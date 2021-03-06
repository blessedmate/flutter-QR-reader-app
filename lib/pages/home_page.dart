import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:qr_reader_app/pages/map_history_page.dart';
import 'package:qr_reader_app/pages/map_page.dart';
import 'package:qr_reader_app/pages/websites_page.dart';
import 'package:qr_reader_app/providers/db_provider.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/providers/ui_provider.dart';
import 'package:qr_reader_app/widgets/custom_navigation_bar.dart';
import 'package:qr_reader_app/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use scans provider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('History'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              scanListProvider.deleteAllScans();
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get current page index
    final uiProvider = Provider.of<UiProvider>(context);

    // Changes to show current page
    final currentIndex = uiProvider.selectedMenuOpt;

    // Use scans provider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return const MapHistoryPage();

      case 1:
        scanListProvider.loadScansByType('http');
        return const WebsitesPage();

      default:
        return const MapHistoryPage();
    }
  }
}
