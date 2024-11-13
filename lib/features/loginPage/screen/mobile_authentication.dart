import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/colorConst.dart';
import '../../../core/constants/imageConst.dart';
import '../../../core/snackbar/snakbar.dart';
import '../../../main.dart';
import 'otp_page.dart';

class MobileAuthentication extends ConsumerStatefulWidget {
  const MobileAuthentication({super.key});

  @override
  ConsumerState createState() => _MobileAuthenticationState();
}

class _MobileAuthenticationState extends ConsumerState<MobileAuthentication> {

  TextEditingController phoneController = TextEditingController();

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
                    if (phoneController.text.length <= 10) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(),));
                    } else {
                      phoneController.text;
                      showSnackBar(
                          context: context, content: 'Enter Mobile Number');
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
                        "Get OTP",
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
          children: [
            SizedBox(height: h*0.1,),
            SizedBox(
              width: w*0.5,
              height: h*0.2,
              child: const Image(image: AssetImage(ImageConst.mobilepage))
            ),
            SizedBox(height: h*0.07,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: w*0.03,),
                Text(
                  'Enter Mobile Number',
                  style:
                  TextStyle(fontSize: w * 0.04, color: Pallete.black,fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: h*0.02,),
            Container(
              height: h * 0.07,
              width: w * 1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w * 0.02)),
              child: TextFormField(
                controller: phoneController,
                cursorColor: Pallete.black,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly
                ],
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w400,
                  color: Pallete.black,
                ),
                decoration: InputDecoration(
                  hintText: "  Enter Phone Number*",
                  hintStyle: const TextStyle(color: Pallete.lightGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.03),
                    borderSide: const BorderSide(color: Pallete.lightGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.03), // Rounded borders
                    borderSide: BorderSide(color: Pallete.black,width: w*0.004),
                  )
                ),
              ),
            ),
            SizedBox(height: h*0.02,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("By Continuing, I agree to TotalX’s",style: TextStyle(fontSize: w * 0.035, color: Pallete.darkGrey,fontWeight: FontWeight.w500),),
                    Text(" Terms and condition",style: TextStyle(fontSize: w * 0.035, color: Pallete.blue,fontWeight: FontWeight.w500),),
                    Text(" &",style: TextStyle(fontSize: w * 0.035, color: Pallete.darkGrey,fontWeight: FontWeight.w500),),
                  ],
                ),
                Text(" privacy policy",style: TextStyle(fontSize: w * 0.035, color: Pallete.blue,fontWeight: FontWeight.w500),),

              ],
            )
          ],
        ),
      ),
    );
  }
}
