
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import '../Utils/font_styles.dart';
import '../utils/app_colors.dart';
import 'FormWithMeter.dart';
import 'FormWithoutMeter.dart';

class MainHome extends StatefulWidget {
  static const String routeName = 'BillPage';
  const MainHome({Key? key}) : super(key: key);

  @override
  MainHomeState createState() => MainHomeState();
}

class MainHomeState extends State<MainHome> {

  @override
  void initState() {
    // TODO: implement initState
    //notificationService.initialiseNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteLight,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("WELCOME TO EASY BILL",
              overflow: TextOverflow.ellipsis,
              style:
              FontStyles.montserratRegular19().copyWith(color: Colors.white)),
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

  Widget _bodybuilder(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 200.h),
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  width: 220,
                  height: 70,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.deepOrangeAccent, Colors.orange, Colors.yellow],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0)
                      )
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text('Je n\'es pas de Compteur',
                        style: FontStyles.montserratRegular19().copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  )
              ),
              SizedBox(width: 10.w),
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, color: AppColors.white, size: 40)
              ),
              SizedBox(width: 10.w),
            ],
          ),
          onTap: (){

            Navigator.push(
              context,
              PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                  child: const WithoutMeter()),
            );

          },
        ),

        SizedBox(height: 50.h),
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.w),
              const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person, color: AppColors.white, size: 40)
              ),
              SizedBox(width: 10.w),
              Container(
                  width: 220,
                  height: 70,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.blue, Colors.lightBlueAccent, Colors.white12],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(15.0)
                      )),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text('J\'ai Mon Compteur',
                        style: FontStyles.montserratRegular19().copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  )
              ),
            ],
          ),
          onTap: (){

            Navigator.push(
              context,
              PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                  child: const HomePage()),
            );

          },
        )
      ],
    );
  }
}