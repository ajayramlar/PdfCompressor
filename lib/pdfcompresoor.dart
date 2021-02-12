

import 'package:flutter/material.dart';

import 'package:starflut/starflut.dart';
void main() => runApp(PdfCompressor());


class PdfCompressor extends StatefulWidget {
  Object srvGroup;

  void _initStarCore() async {
    StarCoreFactory starcore = await Starflut.getFactory();
    StarServiceClass service = await starcore.initSimple();
    srvGroup = await service["_ServiceGroup"];
    bool isAndroid = await Starflut.isAndroid();
    if (isAndroid == true) {
      String libraryDir = await Starflut.getNativeLibraryDir();
      String docPath = await Starflut.getDocumentPath();
      if (libraryDir.indexOf("arm64") > 0) {
        Starflut.unzipFromAssets("lib-dynload-arm64.zip", docPath, true);
      } else if (libraryDir.indexOf("x86_64") > 0) {
        Starflut.unzipFromAssets("lib-dynload-x86_64.zip", docPath, true);
      } else if (libraryDir.indexOf("arm") > 0) {
        Starflut.unzipFromAssets("lib-dynload-armeabi.zip", docPath, true);
      } else {
        Starflut.unzipFromAssets("lib-dynload-x86.zip", docPath, true);
      }
      await Starflut.copyFileFromAssets("python3.6.zip",
          "flutter_assets/starfiles", null);
    }
    await srvGroup.initRaw("python36", service);

    String resPath = await Starflut.getResourcePath();
    srvGroup.loadRawModule("python", "",
        resPath + "/flutter_assets/starfiles/pdf_compressor/pdf_compressor" + "pdf_compressor.py", false);

    dynamic python = await service.importRawContext();

    StarObjectClass retobj = await python.call();
    print(await retobj[0]);
    print(await retobj[1]);

    print(await python["g1"]);

    StarObjectClass yy = await python.call();
    print(await yy.call("__len__",[]));

    StarObjectClass multiply = await service.importRawContext();
    StarObjectClass multiply_inst = await multiply.newObject();
    print(await multiply_inst.getString());

    print(await multiply_inst.call());

    await srvGroup.clearService();
    await starcore.moduleExit();
  }
  @override
  _PdfCompressorState createState() => _PdfCompressorState();
}

class _PdfCompressorState extends State<PdfCompressor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [


        ],
      ),

    );
  }
}
