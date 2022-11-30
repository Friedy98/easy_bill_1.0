import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateBillWithoutMeter(String text1, String text2, String text3, String text4, String text5, String text6, String text7, String text8) async {
    final pdf = Document();

    pdf.addPage(Page(
      build: (context) => Column(
        children: [

          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.topRight,
            child: Text('$text1',style: TextStyle( fontSize: 20)),
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.topCenter,
            child: Text("FACTURE D'EAU / WATER BILL",style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.blue, fontSize: 30)),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Montant Facture',style: TextStyle( fontSize: 20)
                    ),
                    SizedBox(width: 30),
                    Text("$text2 XAF",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'M/Mme',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)
                    ),
                    SizedBox(width: 30),
                    Text(text3,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Total VAT',style: TextStyle( fontSize: 20)
                    ),
                    SizedBox(width: 30),
                    Text("$text4 XAF",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Studio A',style: TextStyle( fontSize: 20)
                    ),
                    SizedBox(width: 30),
                    Text("$text5 XAF",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Studio B',style: TextStyle( fontSize: 20)
                    ),
                    SizedBox(width: 30),
                    Text("$text6 XAF",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        'Facture non Payer',style: TextStyle( fontSize: 20)
                    ),
                    SizedBox(width: 30),
                    Text("$text7 XAF",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Total à Payer:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)
                    ),
                    SizedBox(width: 30),
                    Text("$text8 XAF",style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.red, fontSize: 30)),
                  ],
                ),
                SizedBox(height: 30.h),
                Container(
                    width: double.infinity,
                    height: 50.h,
                    color: PdfColors.blue,
                  child: Center(
                    child: Text("By Fikish.el        Ngoaunet Michel Friedrich \nTel: +237 697658351 / +237 652018822",style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.white, fontSize: 15))
                  )
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text('EASYBILL',style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.lightBlue50, fontSize: 50)),
                ),
              ],
            ),
          ),
        ]
      )
    ));

    return saveDocument(name: 'easyBill.pdf', pdf: pdf);
  }

  static Future<File> generateBillWithMeter(String text1, String text2, String text3, String text4, String text5, String text6, String text7, String text8, String text9, String text10, String text11) async {
    final pdf = Document();

    pdf.addPage(Page(
        build: (context) => Column(
            children: [

              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.topRight,
                child: Text(text1,style: TextStyle( fontSize: 20)),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topCenter,
                child: Text("FACTURE D'EAU / WATER BILL",style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.blue, fontSize: 30)),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'Montant Facture',style: TextStyle( fontSize: 20)
                        ),
                        SizedBox(width: 30),
                        Text("$text2 XAF",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'M/Mme',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)
                        ),
                        SizedBox(width: 30),
                        Text(text3,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'Total VAT',style: TextStyle( fontSize: 20)
                        ),
                        SizedBox(width: 30),
                        Text("$text4 XAF",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'Le $text5',style: TextStyle( fontSize: 20)
                        ),
                        SizedBox(width: 30),
                        Text("$text6 m3",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'Le $text7',style: TextStyle( fontSize: 20)
                        ),
                        SizedBox(width: 30),
                        Text("$text8 m3",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'Consummation',style: TextStyle( fontSize: 20)
                        ),
                        SizedBox(width: 30),
                        Text("$text9 m3",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'Facture non Payer',style: TextStyle( fontSize: 20)
                        ),
                        SizedBox(width: 30),
                        Text("$text10 XAF",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            'Total à Payer:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)
                        ),
                        SizedBox(width: 30),
                        Text("$text11 XAF",style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.red, fontSize: 30)),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Container(
                        width: double.infinity,
                        height: 50.h,
                        color: PdfColors.blue,
                        child: Center(
                            child: Text("By Fikish.el        Ngouanet Michel Friedrich \nTel: +237 697658351 / +237 652018822",style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.white, fontSize: 15))
                        )
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text('EASYBILL',style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.lightBlue50, fontSize: 50)),
                    ),
                  ],
                ),
              ),
            ]
        )
    ));

    return saveDocument(name: 'easyBill.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}