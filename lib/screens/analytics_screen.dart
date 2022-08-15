import 'package:amazon_clone/services/admin_service.dart';
import 'package:amazon_clone/widgets/category_product_chart.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../models/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final adminService = AdminService();
  int? totalEarnings;
  List<Sales>? totalSales;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminService.getEarnings(context);
    totalEarnings = earningData['totalEarnings'] as int;
    totalSales = earningData['sales'];
    setState(() {});
}
  @override
  Widget build(BuildContext context) {
    return totalSales == null || totalEarnings == null ? const Loader() : Column(
      children: [
          Text('\$$totalEarnings', style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
          ),
          ),
        //Display chart
        SizedBox(
          height: 300,
          child: CategoryProductsChart(seriesList: [
            charts.Series(id: 'Sales', data: totalSales!, domainFn: (Sales sales, _) => sales.label, measureFn: (Sales sales, _) => sales.earning,
            ),
          ],
          ),
        ),
      ],
    );
  }
}
