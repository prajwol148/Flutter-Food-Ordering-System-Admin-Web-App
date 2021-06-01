import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'package:ecommerce_admin_tut/widgets/cards/cards_list.dart';
import 'package:ecommerce_admin_tut/widgets/charts/chart.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:ecommerce_admin_tut/widgets/page_header.dart';
import 'package:ecommerce_admin_tut/widgets/charts/sales_chart.dart';
import 'package:ecommerce_admin_tut/widgets/top_buyer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageDesktop extends StatefulWidget {
  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TablesProvider>(context);
    return ListView(
      children: [
        PageHeader(
          text: "DASHBOARD",
        ),
        CardsList(),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 550,
                  width: MediaQuery.of(context).size.width / 1.9,
                  child: SalesChartTwo()),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 600,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(0, 3),
                          blurRadius: 16)
                    ]),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Recent Orders',
                      size: 30,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return TopBuyerWidget(orderModel: tableProvider.orders[index],);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
