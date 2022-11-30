
import 'dart:async';
//import 'dart:convert';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../BillPage/BillWithMeter.dart';
import '../utils/app_colors.dart';
import '../utils/font_styles.dart';
import 'mainHome.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final storage = const FlutterSecureStorage();
  Timer? timer;
  String date = "";

  @override
  void initState() {
    startbilling();
    super.initState();

  }

  void startbilling() {
    date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = DateFormat("EEEE-dd-MM-yyyy").format(dateParse);
    currentdate.text = formattedDate;

  }

  TextEditingController initialDateVal = TextEditingController();
  TextEditingController currentdate = TextEditingController();
  TextEditingController oldIndex = TextEditingController();
  TextEditingController newIndex = TextEditingController();
  TextEditingController owner = TextEditingController();
  TextEditingController billAmount = TextEditingController();
  TextEditingController billAmountWT = TextEditingController();
  TextEditingController totalVAT = TextEditingController();
  TextEditingController includedController = TextEditingController();
  TextEditingController consomation = TextEditingController();
  TextEditingController nonPayer = TextEditingController();

  int total = 0;
  num totalPay = 0;
  int difference = 0;
  int ancienIndex = 0;
  int nouvelleIndex = 0;
  int conso = 0;
  num vatPerStudio = 0;
  bool arriere = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Formulaire",
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
      resizeToAvoidBottomInset: true,
      //drawer: _buildDrawer(context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xF5E8E8FF),
              AppColors.whiteLight,
            ],
          ),
        ),
        child: Center(
          child: _buildBody(context),
        ),
      ),
      backgroundColor: Colors.white70,
    );
  }

  Future _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    String formattedDate = DateFormat("EEEE-dd-MM-yyyy").format(pickedDate!);
    if(pickedDate != null ){
      setState(() {
        initialDateVal.text = formattedDate; //set output date to TextField value.
      });
    }else{
      print("Date is not selected");
    }
  }

  Widget _buildBody(BuildContext context) {
    nonPayer.text = "0";
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 10.h),
            TextFormField(
              // focusNode: _focusNode,
              keyboardType: TextInputType.phone,
              autocorrect: false,
              textAlign: TextAlign.center,
              controller: initialDateVal,
              onTap: () {
                _selectDate();
                FocusScope.of(context).requestFocus(FocusNode());
              },
              maxLines: 1,
              //initialValue: 'Aseem Wangoo',
              validator: (value) {
                if (value!.isEmpty || value.isEmpty) {
                  return 'field required';
                }
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: 'Dernière Date',
                hintText: 'date',
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                //filled: true,
                icon: const Icon(Icons.calendar_today),
                labelStyle:
                const TextStyle(decorationStyle: TextDecorationStyle.solid),
              ),
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: currentdate,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Date d\'Aujourd\'hui',
                icon: const Icon(Icons.date_range_rounded),
              ),
              readOnly: true,
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: owner,
              autofocus: false,
              autocorrect: false,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                hintText: 'Pour M. / Mme ...',
                labelText: 'Entrez Le Nom',
                icon: const Icon(Icons.person_pin_rounded),
              ),
              validator: (inputValue){
                if(inputValue!.isEmpty ) {
                  return "field Required!";
                }
              },
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: billAmountWT,
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                hintText: 'xxxx XAF',
                labelText: 'Total avec Tax/ TTC',
                icon: const Icon(Icons.payment),
              ),
              validator: (inputValue){
                if(inputValue!.isEmpty ) {
                  return "field Required!";
                }
              },
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: billAmount,
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                hintText: 'xxxx XAF',
                labelText: 'Total sans Tax/WT',
                icon: const Icon(Icons.payment),
              ),
              validator: (inputValue){
                if(inputValue!.isEmpty ) {
                  return "field Required!";
                }
              },
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 130.0.w,
                  child: TextFormField(
                    controller: includedController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      hintText: '1',
                      labelText: '# Constructions',
                      //suffixIcon: const Icon(Icons.shopping_cart),
                    ),
                    validator: (inputValue){
                      if(inputValue!.isEmpty ) {
                        return "field Required!";
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 130.0.w,
                  child: TextFormField(
                    controller: totalVAT,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      hintText: '1',
                      labelText: 'Total TVA',
                      //suffixIcon: const Icon(Icons.shopping_cart),
                    ),
                    validator: (inputValue){
                      if(inputValue!.isEmpty ) {
                        return "field Required!";
                      }
                    },
                  ),
                )
              ],
            ),

            SizedBox(height: 10.h),
            TextFormField(
              controller: consomation,
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                hintText: '20 m3',
                labelText: 'Entrez Consomation',
                icon: const Icon(Icons.numbers_sharp),
              ),
              validator: (inputValue){
                if(inputValue!.isEmpty ) {
                  return "field Required!";
                }
              },
            ),

            SizedBox(height: 10.h),
            TextFormField(
              controller: oldIndex,
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                hintText: '0044',
                labelText: 'Entrez Ancien Index',
                icon: const Icon(Icons.numbers_rounded),
              ),
              validator: (inputValue){
                if(inputValue!.isEmpty ) {
                  return "field Required!";
                }
              },
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: newIndex,
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                hintText: '0044',
                labelText: 'Entrez Nouvel Index',
                icon: const Icon(Icons.numbers_rounded),
              ),
              validator: (inputValue){
                if(inputValue!.isEmpty ) {
                  return "field Required!";
                }
              },
            ),
            SizedBox(height: 10.h),
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.attach_money_rounded),
                    SizedBox(width: 5.0.w),
                    Text("Facture non Payé?",
                        style: FontStyles.montserratRegular14().copyWith(
                            color: const Color(0xFF34283E))),
                    Checkbox(
                      value: arriere,
                      onChanged: (value) {
                        setState(() {
                          arriere = !arriere;
                        });
                      },
                    ),
                  ],
                ),
                if(arriere)...[
                  TextFormField(
                    controller: nonPayer,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Montant Non payer',
                      labelText: 'Entrez le montant',
                      icon: const Icon(Icons.numbers_rounded),
                    ),
                    validator: (inputValue){
                      if(inputValue!.isEmpty ) {
                        return "field Required!";
                      }
                    },
                  ),
                ]
              ],
            ),

            _buildPdfBill(),
          ],
        ),
      )
    );
  }

  Widget _buildPdfBill() {
    return Container(
      margin: EdgeInsets.only(left: 10.0.w, right: 10.w, top: 8.0.h),
      child: Center(
        child: TextButton(
          onPressed: () async{
            difference = (int.parse(newIndex.text) - int.parse(oldIndex.text));
            int totalbillAmount = int.parse(billAmount.text) + 200;
            total = difference * totalbillAmount;
            double totalWT = total / int.parse(consomation.text);
            vatPerStudio = int.parse(totalVAT.text) / int.parse(includedController.text);
            totalPay = totalWT + vatPerStudio + int.parse(nonPayer.text) + 100;
            print("$totalWT + $vatPerStudio = $totalPay XAF");


            await storage.write(key: "initialDate", value: initialDateVal.text);
            await storage.write(key: "currentDate", value: currentdate.text);
            await storage.write(key: "oldIndex", value: oldIndex.text);
            await storage.write(key: "billAmountWT", value: billAmountWT.text);
            await storage.write(key: "newIndex", value: newIndex.text);
            await storage.write(key: "owner", value: owner.text);
            await storage.write(key: "billAmount", value: billAmount.text);
            await storage.write(key: "totalFinal", value: totalPay.toStringAsFixed(0));
            await storage.write(key: "VATPerStudio", value: vatPerStudio.toStringAsFixed(0));
            await storage.write(key: "consomation", value: difference.toString());
            await storage.write(key: "totalWT", value: totalWT.toStringAsFixed(0));
            await storage.write(key: "nonPayer", value: nonPayer.text);

            Navigator.push(
              context,
              PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                  child: const BillPage()),
            );

          },
          child: Container(
              width: 200,
              height: 50,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.deepOrangeAccent, Colors.orange, Colors.yellow],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(15.0)
                  )),
              child: Center(
                child: Text('Facturer',
                    style: FontStyles.montserratRegular19().copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              )
          ),
        ),
      ),
    );
  }
}
