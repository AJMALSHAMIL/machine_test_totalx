import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine_test_totalx/features/homePage/screen/homePage.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../../core/constants/colorConst.dart';
import '../../../core/constants/faliure.dart';
import '../../../core/constants/imageConst.dart';
import '../../../main.dart';

class OtpPage extends ConsumerStatefulWidget {
  String verificationId;
  OtpPage({super.key, required this.verificationId});

  @override
  ConsumerState createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  TextEditingController otpController = TextEditingController();

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
                  onTap: () async {
                    try {
                      PhoneAuthCredential credential =
                          await PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: otpController.text.toString());
                      FirebaseAuth.instance
                          .signInWithCredential(credential)
                          .then(
                        (value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ));
                        },
                      );
                    } catch (e) {
                      Failure(e.toString());
                    }
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
        padding: EdgeInsets.all(w * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h * 0.1,
            ),
            Center(
              child: SizedBox(
                width: w * 0.5,
                height: h * 0.2,
                child: const Image(image: AssetImage(ImageConst.otppage)),
              ),
            ),
            SizedBox(
              height: h * 0.07,
            ),
            Text(
              'OTP Verification',
              style: TextStyle(
                  fontSize: w * 0.04,
                  color: Pallete.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Text("Enter the verification code we just sent to your",
                style: TextStyle(
                    fontSize: w * 0.04,
                    color: Pallete.black,
                    fontWeight: FontWeight.w400)),
            Text("number +91 *******21",
                style: TextStyle(
                    fontSize: w * 0.04,
                    color: Pallete.black,
                    fontWeight: FontWeight.w400)),
            SizedBox(
              height: h * 0.02,
            ),
            SizedBox(
              width: w * 1,
              height: w * 0.14,
              child: Pinput(
                length: 6,
                controller: otpController,
                focusedPinTheme: PinTheme(
                  decoration: BoxDecoration(
                    color: Pallete.lightGrey,
                    border: Border.all(color: Pallete.black, width: w * 0.007),
                    borderRadius: BorderRadius.circular(w * 0.03),
                  ),
                ),
                defaultPinTheme: PinTheme(
                    decoration: BoxDecoration(
                  color: Pallete.lightGrey,
                  border: Border.all(color: Pallete.darkGrey, width: w * 0.002),
                  borderRadius: BorderRadius.circular(w * 0.03),
                )),
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Countdown(
                  seconds: 59,
                  build: (BuildContext, int) {
                    return Text(
                      int.toString(),
                      style: TextStyle(
                          color: Pallete.red,
                          fontWeight: FontWeight.w400,
                          fontSize: w * 0.04),
                    );
                  },
                ),
                Text(
                  "Sec",
                  style: TextStyle(
                      color: Pallete.red,
                      fontWeight: FontWeight.w400,
                      fontSize: w * 0.04),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Don't Get OTP? ",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      color: Pallete.black,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "Resend",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      color: Pallete.blue,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
