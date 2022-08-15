import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  CategoryProductsChart({required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(seriesList, animate: true,);
  }
}
