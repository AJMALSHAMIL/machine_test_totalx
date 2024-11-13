import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:machine_test_totalx/core/constants/colorConst.dart';
import 'package:machine_test_totalx/core/constants/imageConst.dart';

import '../../../main.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return
                  AlertDialog(
                      backgroundColor: Pallete.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 0.04),
                      ),
                      content:Container(
                        height: h*0.4,
                        color: Pallete.white,
                        child: Padding(
                          padding:  EdgeInsets.all(w*0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add A New User", style: TextStyle(fontSize: w * 0.04, color: Pallete.black,fontWeight: FontWeight.w500),),
                              SizedBox(height: h*0.02,),
                              Center(
                                child: CircleAvatar(
                                  radius: w*0.1,
                                    child: Image(image: AssetImage(ImageConst.profilePic))),
                              ),
                              SizedBox(height: h*0.02,),
                              Text("Name", style: TextStyle(fontSize: w * 0.04, color: Pallete.lightGrey,fontWeight: FontWeight.w500),),
                              SizedBox(height: h*0.01,),

                            ],
                          ),
                        ),
                      )
                  );
              });
        },
        child: CircleAvatar(
          radius: w*0.1,
          backgroundColor: Pallete.black,
          child: Icon(Icons.add,color: Pallete.white,size: w*0.1,),
        ),
      ),
      backgroundColor: Pallete.lightGrey,
      appBar: AppBar(
        backgroundColor: Pallete.black,
        title: Row(
          children: [
            SvgPicture.asset(ImageConst.location,color: Pallete.white,width: w*0.05,),
            Text(" Nilambur",style: TextStyle(color: Pallete.white,fontWeight: FontWeight.w400),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(w*0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.all(w*0.02),
                child: Row(
                  children: [
                    Container(
                      height: h * 0.07,
                      width: w * 0.75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.1)),
                      child: TextFormField(
                        // controller: phoneController,
                        cursorColor: Pallete.black,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Pallete.black,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding:  EdgeInsets.all(w*0.03),
                            child: Icon(Icons.search,size: w*0.08,),
                          ),
                            hintText: "  search by name",
                            hintStyle: TextStyle(color: Pallete.darkGrey,fontSize: w*0.04),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w*0.1),
                              borderSide: BorderSide(color: Pallete.lightGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w*0.1), // Rounded borders
                              borderSide: BorderSide(color: Pallete.black,width: w*0.004),
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: w*0.03,),
                    SvgPicture.asset(ImageConst.menu)
                  ],
                ),
              ),
              SizedBox(height: h*0.03,),
              Text("Users Lists", style: TextStyle(fontSize: w * 0.04, color: Pallete.darkGrey,fontWeight: FontWeight.w500),),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.all(w*0.02),
                      child: Container(
                        width: w*1,
                        height: h*0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w*0.04),
                          color: Pallete.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: w*0.03,),
                            CircleAvatar(
                              radius: w*0.1,
                            ),
                            SizedBox(width: w*0.03,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Matue nwskdkn",style: TextStyle(fontWeight: FontWeight.w600,fontSize: w*0.04),),
                                SizedBox(height: h*0.01,),
                                Text("Age : ${123}",style: TextStyle(fontWeight: FontWeight.w400),),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
