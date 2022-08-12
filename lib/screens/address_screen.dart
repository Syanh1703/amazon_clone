import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/services/address_service.dart';
import 'package:amazon_clone/widgets/common/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const addressRouteName = '/address-screen';
  final String totalAmount;
  AddressScreen({required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController houseController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final String mustNotEmpTy = 'This field must not left empty';
  final _addressKey = GlobalKey<FormState>();
  String addressToBeUsed = '';
  final addressService = AddressService();

  List<PaymentItem> paymentItems = [];//The total amount of the products

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price),
    );
  }

  @override
  void dispose() {
    super.dispose();
    houseController.dispose();
    streetController.dispose();
    provinceController.dispose();
    cityController.dispose();
    pincodeController.dispose();
  }

  void payPressed(String addressFromProvider){
    addressToBeUsed = '';
    bool isForm = houseController.text.isNotEmpty ||
        streetController.text.isNotEmpty ||
        provinceController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty;
    if(isForm){
      if(_addressKey.currentState!.validate()){
        addressToBeUsed = '${houseController.text},'
            ' ${streetController.text},'
            ' ${provinceController.text},'
            ' ${cityController.text} -'
            ' ${pincodeController.text}';
      }
      else{
        throw Exception('Please enter all the values!');
      }
    }
    else if(addressFromProvider.isNotEmpty){
      addressToBeUsed = addressFromProvider;
    }
    else{
      showSnackbar(context, 'ERROR in address');
    }
    print('The confirm address is: $addressToBeUsed');
  }

  void onGooglePayResult(res){
    if(Provider.of<UserProvider>(context, listen: false).user.address.isNotEmpty){
      addressService.saveUserAddress(context: context, address: addressToBeUsed);
      print('Save address success');
    }
    addressService.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
  }


  @override
  Widget build(BuildContext context) {
    var userAddress = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVars.appBarGradient
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //Check the address
              if(userAddress.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(userAddress, style: const TextStyle(
                          fontSize: 18,
                        ),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text('OR', style: TextStyle(
                      fontSize: 20,
                    ),),
                    const SizedBox(height: 20,),
                  ],
                ),
              Form(
                key: _addressKey,
                child: Column(
                  children: <Widget>[
                    CustomFormField(houseController, 'Flat or Building', 1, mustNotEmpTy),
                    const SizedBox(height: 10,),
                    CustomFormField(streetController, 'Area, Street', 1, mustNotEmpTy),
                    const SizedBox(height: 10,),
                    CustomFormField(provinceController, 'Province', 1, mustNotEmpTy),
                    const SizedBox(height: 10,),
                    CustomFormField(cityController, 'Town or City', 1, mustNotEmpTy),
                    const SizedBox(height: 10,),
                    CustomFormField(pincodeController, 'Pincode', 1, mustNotEmpTy),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
              GooglePayButton(
                  onPressed: () => payPressed(userAddress),
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(top: 15, ),
                  style: GooglePayButtonStyle.black,
                  type: GooglePayButtonType.buy,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  paymentConfigurationAsset: 'gpay.json',
                  onPaymentResult: onGooglePayResult,
                  paymentItems: paymentItems),
            ],
          ),
        ),
      ),
    );
  }
}
