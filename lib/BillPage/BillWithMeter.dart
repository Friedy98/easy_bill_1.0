
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:page_transition/page_transition.dart';

import '../Home/mainHome.dart';
import '../PdfAPI.dart';
import '../Utils/font_styles.dart';
import '../utils/app_colors.dart';

class BillPage extends StatefulWidget {
  static const String routeName = 'BillPage';
  const BillPage({Key? key}) : super(key: key);

  @override
  BillPageState createState() => BillPageState();
}

class BillPageState extends State<BillPage> {

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String initialDate = "";
  String currentDate = "";
  String oldIndex = "";
  String newIndex = "";
  String totalPay = "";
  String nonPayer = "";
  String billAmountWT = "";
  String consomation = "";
  String ownerName = "";
  String vatPerStudio = "";
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    //notificationService.initialiseNotification();
    super.initState();
    getBillDetails();
  }

  getBillDetails()async{
    final initial = (await storage.read(key: 'initialDate'))!;
    final today = (await storage.read(key: 'currentDate'))!;
    final old = (await storage.read(key: 'oldIndex'))!;
    final nouveau = (await storage.read(key: 'newIndex'))!;
    final nom = (await storage.read(key: 'owner'))!;
    final payer = (await storage.read(key: 'totalFinal'))!;
    final conso = (await storage.read(key: 'consomation'))!;
    final appart = (await storage.read(key: 'VATPerStudio'))!;
    final totalpayer = (await storage.read(key: 'billAmountWT'))!;
    final imPayer = (await storage.read(key: 'nonPayer'))!;
    setState(() {
      initialDate = initial;
      currentDate = today;
      oldIndex = old;
      newIndex = nouveau;
      ownerName = nom;
      totalPay = payer;
      consomation = conso;
      vatPerStudio = appart;
      billAmountWT = totalpayer;
      nonPayer = imPayer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      key: _key,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Facture",
            overflow: TextOverflow.ellipsis,
            style:
            FontStyles.montserratRegular19().copyWith(color: Colors.white)),
        leading: IconButton(
          onPressed: (){

            Navigator.push(
              context,
              PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                  child: const MainHome()),
            );

          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),

      ),
      body:  _bodybuilder(context),
      bottomSheet: _buildBottomSheet()
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      width: double.infinity,
      height: 50.0.h,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r),
          topRight: Radius.circular(20.0.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Powered By: EasyBill",
              style: FontStyles.montserratRegular14().copyWith(color: Colors.white)),
          Text("Ngouanet Michel Friedrich +237 697658351",
              style: FontStyles.montserratRegular14().copyWith(color: Colors.white)),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.h,
      decoration: const BoxDecoration(
        color: Colors.blue
      ),
    );
  }

  Widget _bodybuilder(BuildContext context){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.topRight,
            child: Text('Yaounde, $currentDate', style: FontStyles.montserratRegular14()),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.topCenter,
            child: Text("FACTURE D'EAU / WATER BILL",
                style: FontStyles.montserratRegular19().copyWith(color: Colors.blue,fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Montant Facture',
                      style: FontStyles.montserratRegular18(),
                    ),
                    const SizedBox(width: 30),
                    Text("$billAmountWT XAF", style: FontStyles.montserratRegular17().copyWith(color: Colors.red,fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'M./Mme',
                      style: FontStyles.montserratRegular18(),
                    ),
                    const SizedBox(width: 30),
                    Text(ownerName, style: FontStyles.montserratRegular19().copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Total VAT',
                      style: FontStyles.montserratRegular18(),
                    ),
                    const SizedBox(width: 30),
                    Text("$vatPerStudio XAF", style: FontStyles.montserratRegular17().copyWith(color: Colors.red,fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),

          ListTile(
            title: Text(
              'Le $initialDate',
              style: FontStyles.montserratRegular17(),
            ),
            subtitle: Text('Index: $oldIndex m3', style: FontStyles.montserratRegular17().copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text(
              'Le $currentDate',
              style: FontStyles.montserratRegular17(),
            ),
            subtitle: Text('Index: $newIndex m3', style: FontStyles.montserratRegular17().copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text(
              'Consummation',
              style: FontStyles.montserratRegular17(),
            ),
            subtitle: Text('$consomation m3', style: FontStyles.montserratRegular17().copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text(
              'Non Payer',
              style: FontStyles.montserratRegular17(),
            ),
            subtitle: Text('$nonPayer XAF', style: FontStyles.montserratRegular17().copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Total à Payer:',
                style: FontStyles.montserratRegular18(),
              ),
              const SizedBox(width: 30),
              Text("$totalPay XAF",
                  style: FontStyles.montserratRegular19().copyWith(color: Colors.red,fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: ()async{
                    storage.deleteAll();
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      Text(' Back ',
                          style: FontStyles.montserratRegular19().copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  )
              ),
              ElevatedButton(
                onPressed: ()async{
                  final pdfFile =
                  await PdfApi.generateBillWithMeter('Yaounde, $currentDate', "$billAmountWT ", ownerName, "$vatPerStudio ",initialDate, oldIndex, currentDate, newIndex, "$consomation ","$nonPayer ", totalPay);

                  PdfApi.openFile(pdfFile);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(' pdf ',
                        style: FontStyles.montserratRegular19().copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    const Icon(Icons.download_rounded, color: Colors.white)
                  ],
                )
              ),
            ],
          )
        ],
      );
  }
}