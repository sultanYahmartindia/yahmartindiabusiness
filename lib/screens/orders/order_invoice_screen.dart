import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../utils/common_colors.dart';
import '../../utils/screen_constants.dart';


class OrderInvoiceScreen extends StatefulWidget {
  final String? pdfPath;
  final String? certificate;
  const OrderInvoiceScreen(
      {Key? key, required this.pdfPath, required this.certificate})
      : super(key: key);

  @override
  State<OrderInvoiceScreen> createState() => _OrderInvoiceScreenState();
}

class _OrderInvoiceScreenState extends State<OrderInvoiceScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  List<int>? _documentBytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: CommonColors.appBgColor,
        titleSpacing: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonColors.appColor,
            ),
            onPressed: () => Get.back()),
        title: Text(
          "Order Invoice",
          style: TextStyle(
              color: CommonColors.appColor,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s16),
        ),
        actions: [
          InkWell(
              onTap: () {
                saveFile(widget.certificate!, widget.pdfPath!, context);
              },
              child: const Icon(Icons.download,color: Colors.black,)),
          const SizedBox(width: 16)
        ],
      ),
      body: SfPdfViewer.network(
        widget.certificate!,
        key: _pdfViewerKey,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          _documentBytes = details.document.saveSync();
        },
      ),
    );
  }
}

Future<bool> saveFile(String url, String fileName, context) async {
  try {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt; //
      Directory? directory;
      if (sdkInt >= 33) {
        directory = await getExternalStorageDirectory();
        directory = Directory("/storage/emulated/0/Download/");
        File saveFile = File("${directory.path}$fileName");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          var dio = Dio();
          await dio.download(
            url,
            '${directory.path}/$fileName',
          );
          deleteTransportDialog(context, saveFile.path);
        }
      } else if (sdkInt <= 32) {
        askPermissionBelow33(url, fileName, context);
      }
    } else {
      saveFileForIos(url, fileName, context);
    }
  } catch (e) {
    log(e.toString());
  }
  return true;
}

Future<bool> askPermissionBelow33(String url, String fileName, context) async {
  try {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var sdkInt = androidInfo.version.sdkInt; //
    const permission = Permission.storage;

    PermissionStatus? result;
    if (sdkInt >= 30) {
      await Permission.manageExternalStorage.request();
    } else {
      await Permission.storage.request();
    }

    if (Platform.isAndroid) {
      log("android ${Platform.isAndroid}");
      result = await permission.request();
    }

    if (result!.isGranted) {
      Directory? directory;
      if (sdkInt >= 30) {
        directory = await getExternalStorageDirectory();
        directory = Directory("/storage/emulated/0/Download/");
        File saveFile = File("${directory.path}$fileName");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          var dio = Dio();
          await dio.download(
            url,
            '${directory.path}/$fileName',
          );
          deleteTransportDialog(context, saveFile.path);
        }
      } else {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        File saveFile = File("${directory!.path}/$fileName");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          var dio = Dio();
          await dio.download(
            url,
            '${directory.path}/$fileName',
          );
          deleteTransportDialog(context, saveFile.path);
        }
      }
    } else {
      await permission.request();
    }
    return true;
  } catch (e) {
    return false;
  }
}

saveFileForIos(String url, String fileName, context) async {
  log("ios..");
  Directory? directory;
  directory = await getApplicationDocumentsDirectory();
  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }
  if (await directory.exists()) {
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    if (await directory.exists()) {
      var dio = Dio();
      await dio.download(
        url,
        '${directory.path}/$fileName',
      );
      deleteTransportDialog(context, "Files/On My iPhone/Yahmart/$fileName");
    }
  }
}

deleteTransportDialog(BuildContext context, String dialog) {
  Widget cancelButton = TextButton(
    child: const Text(
      "Ok",
      style: TextStyle(
        color: Colors.green,
      ),
    ),
    onPressed: () {
      Get.back();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Invoice pdf has been saved"),
    content: Text(
      " $dialog ",
    ),
    actions: [
      cancelButton,
      // continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

