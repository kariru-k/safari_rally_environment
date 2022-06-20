import 'package:flutter/material.dart';
import 'package:safari_rally/reports/noise_test_reports.dart';

import '../reports/carwash_report.dart';
import '../reports/marshall_delivery_reviews.dart';
import '../reports/refuelling_report.dart';
import '../reports/service_park_report.dart';
import '../reports/stage_review_reports.dart';
import '../reports/supplier_delivery_reports.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      //ListView to display the list of reports
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
                title: const Text('Noise Test Reports'),
                subtitle: const Text('Reports of noise test data that was accrued'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NoiseTestReports(),
                  ));
                }
            ),
          ),
          Card(
            child: ListTile(
                title: const Text('Supplier Delivery Reports'),
                subtitle: const Text('Details all the Supplier deliveries and deployments'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SupplierReportStagePage(),
                  ));
                }
            ),
          ),
          Card(
          child: ListTile(
            title: const Text('Marshall Delivery Reviews'),
            subtitle: const Text('Details the reviews of the supplier deliveries as per the Marshall'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MarshallDeliveryReviews(),
              ));
            }
          ),
          ),
          Card(
            child: ListTile(
              title: const Text('Stage Review Reports'),
              subtitle: const Text('Review of the Stage after the rally.'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ReportStagePage(),
                ));
            }
          ),
          ),
          Card(
            child: ListTile(
                title: const Text('Service Park Reports'),
                subtitle: const Text('Review of the Service Park'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ServiceParkReports(),
                  ));
                }
            ),
          ),
          Card(
            child: ListTile(
                title: const Text('Refuelling Reports'),
                subtitle: const Text('Review of the Refuelling Stations'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RefuellingReports(),
                  ));
                }
            ),
          ),
          Card(
            child: ListTile(
                title: const Text('Car Wash Reports'),
                subtitle: const Text('Review of the Service Park'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CarWashReports(),
                  ));
                }
            ),
          ),
        ],
      ),
    );
  }
}


