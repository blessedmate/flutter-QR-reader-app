import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scanList = scanListProvider.scans;

    return ListView.builder(
      itemCount: scanList.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          scanListProvider.deleteScanById(scanList[i].id!);
        },
        child: ListTile(
          leading: Icon(
            type == 'http' ? Icons.web : Icons.map_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scanList[i].value),
          subtitle: Text(scanList[i].id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => print(scanList[i].id),
        ),
      ),
    );
  }
}
