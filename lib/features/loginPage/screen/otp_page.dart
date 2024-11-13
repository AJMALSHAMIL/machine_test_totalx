import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/colorConst.dart';
import '../../../core/constants/imageConst.dart';
import '../../../main.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: h * 0.1,
        width: w * 1,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer(builder: (context, ref, child) {
                return InkWell(
                  onTap: () {
                    // if (phoneController.text.length <= 10) {
                    //   generateAndPrintRandomNumber();
                    //   print('111111111111');
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(phoneController.text),));
                    // } else {
                    //   phoneController.text;
                    //   showSnackBarWhite(
                    //       context: context, content: selectedLanguage!.words['Enter Mobile Number']);
                    // }
                  },
                  child: Container(
                    height: h * 0.06,
                    width: w * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 0.10),
                      color: Pallete.black,
                    ),
                    child: Center(
                      child: Text(
                        "Verify",
                        style: TextStyle(
                          color: Pallete.white,
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
      backgroundColor: Pallete.white,
      body: Padding(
        padding:  EdgeInsets.all(w*0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h*0.15,),
            Center(
              child: SizedBox(
                width: w*0.5,
                height: h*0.2,
                child: Image(image: AssetImage(ImageConst.otppage)),
              ),
            ),
            SizedBox(height: h*0.07,),
            Text(
              'OTP Verification',
              style:
              TextStyle(fontSize: w * 0.04, color: Pallete.black,fontWeight: FontWeight.w500),
            ),
            SizedBox(height: h*0.02,),
            Text("Enter the verification code we just sent to your",style:TextStyle(fontSize: w * 0.04, color: Pallete.black,fontWeight: FontWeight.w400)),
            Text("number +91 ${9539786243}",style:TextStyle(fontSize: w * 0.04, color: Pallete.black,fontWeight: FontWeight.w400)),
            SizedBox(height: h*0.02,),
            // Container(
            //     height: h * 0.07,
            //     width: w * 0.9,
            //     decoration: BoxDecoration(
            //         color: Pallete.white,
            //         borderRadius: BorderRadius.circular(w * 0.02)),
            //     child: Padding(
            //       padding: EdgeInsets.only(
            //           left: w * 0.2, right: w * 0.2, top: w * 0.02),
            //       child: PinCodeTextField(
            //         appContext: context,
            //         cursorColor: Colors.transparent,
            //         textStyle: TextStyle(fontSize: w * 0.04),
            //         length: 4,
            //         controller: otpController,
            //         keyboardType: TextInputType.number,
            //         onChanged: (value) {},
            //         pinTheme: PinTheme(
            //           shape: PinCodeFieldShape.box,
            //           borderRadius: BorderRadius.circular(w * 0.03),
            //           fieldHeight: h * 0.05,
            //           fieldWidth: w * 0.1,
            //           activeFillColor: Colors.grey.shade200,
            //           selectedFillColor: Colors.grey.shade200,
            //           inactiveFillColor: Colors.grey.shade200,
            //           activeColor: Colors.grey[100],
            //           selectedColor: Colors.grey[100],
            //           inactiveColor: Colors.grey[100],
            //         ),
            //         boxShadows: [
            //           BoxShadow(
            //             color: Colors.black.withOpacity(0.1),
            //             blurRadius: 5,
            //             offset: const Offset(0, 3),
            //           ),
            //         ],
            //         enableActiveFill: true,
            //         onCompleted: (value) {},
            //       ),
            //     )),
          ],
        ),
      ),
    );
  }
}
