import 'package:flutter/material.dart';
import 'package:qr_reader_app/widgets/scan_tiles.dart';

class WebsitesPage extends StatelessWidget {
  const WebsitesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(type: 'http');
  }
}
