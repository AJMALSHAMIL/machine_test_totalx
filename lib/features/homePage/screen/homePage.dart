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

  final selectAgeTypeProvider = StateProvider<String>((ref) => "All",);

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
                      content:SingleChildScrollView(
                        child: Container(
                          height: h*0.48,
                          color: Pallete.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add A New User", style: TextStyle(fontSize: w * 0.04, color: Pallete.black,fontWeight: FontWeight.w500),),
                              SizedBox(height: h*0.02,),
                              Center(
                                child: CircleAvatar(
                                  radius: w*0.1,
                                    child: const Image(image: AssetImage(ImageConst.profilePic))),
                              ),
                              SizedBox(height: h*0.02,),
                              Text("Name", style: TextStyle(fontSize: w * 0.04, color: Pallete.lightGrey,fontWeight: FontWeight.w500),),
                              SizedBox(height: h*0.01,),
                              Container(
                                height: h * 0.07,
                                width: w * 1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(w * 0.02)),
                                child: TextFormField(
                                  cursorColor: Pallete.black,
                                  keyboardType: TextInputType.name,
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
                                      hintText: " Name",
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
                              SizedBox(height: h*0.01,),
                              Text("Age", style: TextStyle(fontSize: w * 0.04, color: Pallete.lightGrey,fontWeight: FontWeight.w500),),
                              SizedBox(height: h*0.01,),
                              Container(
                                height: h * 0.07,
                                width: w * 1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(w * 0.02)),
                                child: TextFormField(
                                  cursorColor: Pallete.black,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w400,
                                    color: Pallete.black,
                                  ),
                                  decoration: InputDecoration(
                                      hintText: "  Age",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: h*0.05,
                                          width: w*0.26,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(w * 0.03),
                                            color: Pallete.lightGrey,
                                          ),
                                          child:Center(child:
                                          Text("Cancel", style: TextStyle(fontSize: w * 0.04, color: Pallete.darkGrey,fontWeight: FontWeight.w500),),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: w*0.03,),
                                      Container(
                                        height: h*0.05,
                                        width: w*0.26,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(w * 0.03),
                                          color: Pallete.blue,
                                        ),
                                        child:Center(child:
                                        Text("Save", style: TextStyle(fontSize: w * 0.04, color: Pallete.white,fontWeight: FontWeight.w500),),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
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
            const Text(" Nilambur",style: TextStyle(color: Pallete.white,fontWeight: FontWeight.w400),)
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
                              borderSide: const BorderSide(color: Pallete.lightGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w*0.1), // Rounded borders
                              borderSide: BorderSide(color: Pallete.black,width: w*0.004),
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: w*0.03,),
                    Consumer(
                      builder: (context,ref,child) {
                        return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Pallete.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight:Radius.circular(w*0.05),
                                      topLeft: Radius.circular(w*0.05)),
                                ),
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(builder: (context, setState) {
                                 return   SizedBox(
                                      height:h*0.35,
                                      width: w*1,
                                      child:Padding(
                                        padding:  EdgeInsets.all(w*0.08),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Sort", style: TextStyle(fontSize: w * 0.05, color: Pallete.black,fontWeight: FontWeight.w500),),
                                            SizedBox(height: h*0.03,),
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: "All",
                                                  activeColor: Pallete.blue,
                                                  groupValue:ref.watch(selectAgeTypeProvider),
                                                  onChanged: (value) {
                                                    ref
                                                        .read(selectAgeTypeProvider.notifier)
                                                        .update(
                                                          (state) => value.toString(),
                                                    );
                                                    setState(() {

                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "All",
                                                  style: TextStyle(
                                                      fontSize: w * 0.04,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: "Elder",
                                                  activeColor: Pallete.blue,
                                                  groupValue:ref.watch(selectAgeTypeProvider),
                                                  onChanged: (value) {
                                                    ref
                                                        .read(selectAgeTypeProvider.notifier)
                                                        .update(
                                                          (state) => value.toString(),
                                                    );setState(() {

                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "Age : Elder",
                                                  style: TextStyle(
                                                      fontSize: w * 0.04,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: "Younger",
                                                  activeColor: Pallete.blue,
                                                  groupValue:ref.watch(selectAgeTypeProvider),
                                                  onChanged: (value) {
                                                    ref
                                                        .read(selectAgeTypeProvider.notifier)
                                                        .update(
                                                          (state) => value.toString(),
                                                    );
                                                    setState(() {

                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "Age : Younger",
                                                  style: TextStyle(
                                                      fontSize: w * 0.04,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                                  },);
                                },
                              );
                            },
                            child: SvgPicture.asset(ImageConst.menu));
                      }
                    )
                  ],
                ),
              ),
              SizedBox(height: h*0.03,),
              Text("Users Lists", style: TextStyle(fontSize: w * 0.04, color: Pallete.darkGrey,fontWeight: FontWeight.w500),),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
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
                                const Text("Age : ${123}",style: TextStyle(fontWeight: FontWeight.w400),),
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
