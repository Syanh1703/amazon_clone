import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/models/order_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/services/admin_service.dart';
import 'package:amazon_clone/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String orderScreenRouteName = '/order-detail';
  final OrderModel order;
  OrderDetailScreen({
    required this.order,
});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  int currentStep = 0;
  final adminService = AdminService();

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.searchScreenRouteName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  ///Only for admin!!!!
  void changeOrderStatus(int status) async{
    adminService.changeOrderStatus(context: context, status: status + 1, order: widget.order, onSuccess: (){
      //Make sure the current step increases by 1
      setState(() {
        currentStep += 1;
      });
    });
  }

  Step orderSteps( String title,String content, int currentStep, int orderStep){
    return Step(
        title: Text(title),
        content: Text(content),
        isActive: currentStep > orderStep,
        state: currentStep > orderStep ? StepState.complete : StepState.indexed
    );
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: GlobalVars.homeScreenCommon((query) => navigateToSearchScreen(query)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('View orders detail', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height: 2,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Order date: ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt),
                    )}', style: const TextStyle(
                        fontSize: 18,
                    ),),
                    Text('Order ID: ${widget.order.id}', style: const TextStyle(
                      fontSize: 18
                    ),),
                    Text('Total Price: \$${widget.order.totalPrice}', style: const TextStyle(
                      fontSize: 18,
                    ),),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Text('Purchase Detail', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
              ),
              const SizedBox(height: 2,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                      for(int i = 0; i<widget.order.products.length; i++)
                        Row(
                          children: <Widget>[
                            Image.network(widget.order.products[i].images[0], width: 135, height: 135, fit: BoxFit.contain,),
                            const SizedBox(width: 5,),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Name: ${widget.order.products[i].name}', style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500
                                    ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text('Quantity: ${widget.order.quantity[i]}', style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                    ),
                                  ],
                                ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Text('Tracking orders', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
              ),
              const SizedBox(height: 2,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12)
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if(user.type == 'admin'){
                      //Show a custom button
                      return CustomButton(buttonText: 'Done', onTap: () => changeOrderStatus(details.currentStep));
                    }
                    return const SizedBox();
                  },
                  steps: [
                    orderSteps('Pending', 'Your order is yet to be delivered', currentStep, 0),
                    orderSteps('Completed', 'Your order has been delivered', currentStep, 1),
                    orderSteps('Received', 'Your order has been received', currentStep, 2),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text('Your order has been delivered to your location'),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3 ? StepState.complete : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

