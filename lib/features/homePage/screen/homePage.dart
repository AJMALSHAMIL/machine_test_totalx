import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:machine_test_totalx/core/commonfunction/setSearchParams.dart';
import 'package:machine_test_totalx/core/constants/colorConst.dart';
import 'package:machine_test_totalx/core/constants/imageConst.dart';
import 'package:machine_test_totalx/model/adduserModel.dart';
import '../../../core/constants/faliure.dart';
import '../../../main.dart';
import '../controller/homeController.dart';
import 'customlisttile.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final selectAgeTypeProvider = StateProvider<String>(
    (ref) => "All",
  );

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final searchProvider = StateProvider(
    (ref) => '',
  );
  TextEditingController searchController = TextEditingController();

  String? ImgUrl = ImageConst.profilePic;
  var file;

  PickFile(ImageSource) async {
    final imageFile = await ImagePicker.platform.pickImage(source: ImageSource);
    file = File(imageFile!.path);
    if (mounted) {
      setState(() {
        file = File(imageFile.path);
      });
    }
  }

  bool isLoadingVertical = false;
  final loadingProvider = StateProvider(
    (ref) => false,
  );
  Stream<List<UserModel>>? userStream;
  var lastDoc;
  var firstDoc;
  int limits = 1;

  Map<int, DocumentSnapshot> lastDocuments = {};
  int pageIndex = 0;
  int userCount = 0;
  int docIndex = 0;
  Future<void> getUser() async {
    try {
      userStream = FirebaseFirestore.instance
          .collection('users')
          .where('age',
              isGreaterThanOrEqualTo:
                  ref.watch(selectAgeTypeProvider) == 'Elder' ? 60 : null)
          .where('age',
              isLessThanOrEqualTo:
                  ref.watch(selectAgeTypeProvider) == 'Younger' ? 59 : null)
          .where(
            'search',
            arrayContains:
                ref.watch(searchProvider).toString().toUpperCase().isEmpty
                    ? null
                    : ref.watch(searchProvider).toString().toUpperCase(),
          )
          .limit(limits)
          .snapshots()
          .map((event) => event.docs
              .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
              .toList());
      AggregateQuerySnapshot userCountt = await FirebaseFirestore.instance
          .collection('users')
          .where(
            'age',
          )
          .where('age',
              isGreaterThanOrEqualTo:
                  ref.watch(selectAgeTypeProvider) == 'Elder' ? 60 : null)
          .where('age',
              isLessThanOrEqualTo:
                  ref.watch(selectAgeTypeProvider) == 'Younger' ? 59 : null)
          .where(
            'search',
            arrayContains:
                ref.watch(searchProvider).toString().toUpperCase().isEmpty
                    ? null
                    : ref.watch(searchProvider).toString().toUpperCase(),
          )
          .count()
          .get();

      userCount = userCountt.count!;
    } catch (e) {
      Failure(e.toString());
    }
    setState(() {});
  }

  next() {
    if (isLoadingVertical) return;
    isLoadingVertical = true;
    pageIndex++;

    if (lastDoc == null || pageIndex == 0) {
      getUser();
    } else {
      userStream = FirebaseFirestore.instance
          .collection('users')
          .where('age',
              isGreaterThanOrEqualTo:
                  ref.watch(selectAgeTypeProvider) == 'Elder' ? 60 : null)
          .where('age',
              isLessThanOrEqualTo:
                  ref.watch(selectAgeTypeProvider) == 'Younger' ? 59 : null)
          .where(
            'search',
            arrayContains:
                ref.watch(searchProvider).toString().toUpperCase().isEmpty
                    ? null
                    : ref.watch(searchProvider).toString().toUpperCase(),
          )
          .limit(((pageIndex + 1) * limits))
          .snapshots()
          .map((event) => event.docs
              .map(
                (e) => UserModel.fromJson(e.data()),
              )
              .toList());
    }

    isLoadingVertical = false;
    if (mounted) {
      setState(() {});
    }
  }

  List data = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2)).whenComplete(() {
        if (mounted) {
          ref.read(loadingProvider.notifier).update((state) => false);
        }
      });
      getUser();
    });
  }

  addWorker() {
    ref.watch(homeControllerProvider).addUser(
          usermodel: UserModel(
            createTime: DateTime.now(),
            name: nameController.text,
            age: int.tryParse(ageController.text)!,
            photoUrl: "",
            search: setSearchParam2('${nameController.text.trim()}'),
          ),
          context: context,
          // file:file,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                          backgroundColor: Pallete.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.04),
                          ),
                          content: SingleChildScrollView(
                            child: Container(
                              height: h * 0.48,
                              color: Pallete.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add A New User",
                                    style: TextStyle(
                                        fontSize: w * 0.04,
                                        color: Pallete.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoActionSheet(
                                              actions: [
                                                CupertinoActionSheetAction(
                                                  onPressed: () {
                                                    PickFile(
                                                        ImageSource.gallery);
                                                    setState(
                                                      () {},
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  isDefaultAction: true,
                                                  child: const Text(
                                                    "Gallery",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Pallete.black),
                                                  ),
                                                ),
                                                CupertinoActionSheetAction(
                                                    onPressed: () {
                                                      PickFile(
                                                          ImageSource.camera);
                                                      setState(
                                                        () {},
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Camera",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Pallete
                                                                .black))),
                                              ],
                                              cancelButton:
                                                  CupertinoActionSheetAction(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Pallete.black)),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: file != null
                                          ? CircleAvatar(
                                              radius: w * 0.1,
                                              backgroundImage: FileImage(file!),
                                            )
                                          : CircleAvatar(
                                              radius: w * 0.1,
                                              backgroundImage: const AssetImage(
                                                  ImageConst.profilePic),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: w * 0.04,
                                        color: Pallete.lightGrey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: h * 0.01,
                                  ),
                                  Container(
                                    height: h * 0.07,
                                    width: w * 1,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(w * 0.02)),
                                    child: TextFormField(
                                      controller: nameController,
                                      cursorColor: Pallete.black,
                                      keyboardType: TextInputType.name,
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w400,
                                        color: Pallete.black,
                                      ),
                                      decoration: InputDecoration(
                                          hintText: " Name",
                                          hintStyle: const TextStyle(
                                              color: Pallete.lightGrey),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03),
                                            borderSide: const BorderSide(
                                                color: Pallete.lightGrey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03),
                                            borderSide: BorderSide(
                                                color: Pallete.black,
                                                width: w * 0.004),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.01,
                                  ),
                                  Text(
                                    "Age",
                                    style: TextStyle(
                                        fontSize: w * 0.04,
                                        color: Pallete.lightGrey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: h * 0.01,
                                  ),
                                  Container(
                                    height: h * 0.07,
                                    width: w * 1,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(w * 0.02)),
                                    child: TextFormField(
                                      controller: ageController,
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
                                          hintStyle: const TextStyle(
                                              color: Pallete.lightGrey),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03),
                                            borderSide: const BorderSide(
                                                color: Pallete.lightGrey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03),
                                            borderSide: BorderSide(
                                                color: Pallete.black,
                                                width: w * 0.004),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: h * 0.05,
                                              width: w * 0.26,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.03),
                                                color: Pallete.lightGrey,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      fontSize: w * 0.04,
                                                      color: Pallete.darkGrey,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: w * 0.03,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              addWorker();
                                              Navigator.pop(context);
                                              nameController.clear();
                                              ageController.clear();
                                            },
                                            child: Container(
                                              height: h * 0.05,
                                              width: w * 0.26,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.03),
                                                color: Pallete.blue,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Save",
                                                  style: TextStyle(
                                                      fontSize: w * 0.04,
                                                      color: Pallete.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                    },
                  ));
        },
        child: CircleAvatar(
          radius: w * 0.1,
          backgroundColor: Pallete.black,
          child: Icon(
            Icons.add,
            color: Pallete.white,
            size: w * 0.1,
          ),
        ),
      ),
      backgroundColor: Pallete.lightGrey,
      appBar: AppBar(
        leadingWidth: w * 1,
        backgroundColor: Pallete.black,
        leading: Row(
          children: [
            SizedBox(
                child: SvgPicture.asset(
              ImageConst.location,
              color: Pallete.white,
              width: w * 0.05,
            )),
            Text(
              " Nilambur",
              style: TextStyle(
                  color: Pallete.white,
                  fontWeight: FontWeight.w400,
                  fontSize: w * 0.06),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(w * 0.02),
                child: Row(
                  children: [
                    Container(
                      height: h * 0.07,
                      width: w * 0.75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.1)),
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          ref.read(searchProvider.notifier).update(
                                (state) => value,
                              );
                        },
                        cursorColor: Pallete.black,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Pallete.black,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(w * 0.03),
                              child: Icon(
                                Icons.search,
                                size: w * 0.08,
                              ),
                            ),
                            hintText: "  search by name",
                            hintStyle: TextStyle(
                                color: Pallete.darkGrey, fontSize: w * 0.04),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w * 0.1),
                              borderSide:
                                  const BorderSide(color: Pallete.lightGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w * 0.1),
                              borderSide: BorderSide(
                                  color: Pallete.black, width: w * 0.004),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.03,
                    ),
                    Consumer(builder: (context, ref, child) {
                      return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Pallete.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(w * 0.05),
                                    topLeft: Radius.circular(w * 0.05)),
                              ),
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return SizedBox(
                                      height: h * 0.35,
                                      width: w * 1,
                                      child: Padding(
                                        padding: EdgeInsets.all(w * 0.08),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Sort",
                                              style: TextStyle(
                                                  fontSize: w * 0.05,
                                                  color: Pallete.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: h * 0.01,
                                            ),
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: "All",
                                                  activeColor: Pallete.blue,
                                                  groupValue: ref.watch(
                                                      selectAgeTypeProvider),
                                                  onChanged: (value) {
                                                    ref
                                                        .read(
                                                            selectAgeTypeProvider
                                                                .notifier)
                                                        .update(
                                                          (state) =>
                                                              value.toString(),
                                                        );
                                                    setState(() {});
                                                  },
                                                ),
                                                Text(
                                                  "All",
                                                  style: TextStyle(
                                                      fontSize: w * 0.04,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: "Elder",
                                                  activeColor: Pallete.blue,
                                                  groupValue: ref.watch(
                                                      selectAgeTypeProvider),
                                                  onChanged: (value) {
                                                    ref
                                                        .read(
                                                            selectAgeTypeProvider
                                                                .notifier)
                                                        .update(
                                                          (state) =>
                                                              value.toString(),
                                                        );
                                                    setState(() {});
                                                  },
                                                ),
                                                Text(
                                                  "Age : Elder",
                                                  style: TextStyle(
                                                      fontSize: w * 0.04,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: "Younger",
                                                  activeColor: Pallete.blue,
                                                  groupValue: ref.watch(
                                                      selectAgeTypeProvider),
                                                  onChanged: (value) {
                                                    ref
                                                        .read(
                                                            selectAgeTypeProvider
                                                                .notifier)
                                                        .update(
                                                          (state) =>
                                                              value.toString(),
                                                        );
                                                    setState(() {});
                                                  },
                                                ),
                                                Text(
                                                  "Age : Younger",
                                                  style: TextStyle(
                                                      fontSize: w * 0.04,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: SizedBox(
                              child: SvgPicture.asset(ImageConst.menu)));
                    })
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Text(
                "Users Lists",
                style: TextStyle(
                    fontSize: w * 0.04,
                    color: Pallete.darkGrey,
                    fontWeight: FontWeight.w500),
              ),
              StreamBuilder<List<UserModel>>(
                stream: userStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("An error occurred."));
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Center(child: Text("No Data")));
                  }
                  var data = snapshot.data ?? [];
                  if (data.isNotEmpty) {
                    lastDoc = data.last;
                    firstDoc = data.first;
                  }
                  return ref.watch(loadingProvider)
                      ? SizedBox(
                          width: w,
                          height: h * 0.84,
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : SizedBox(
                          width: w,
                          height: h * 0.84,
                          child: data.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : LazyLoadScrollView(
                                  isLoading: isLoadingVertical,
                                  scrollDirection: Axis.vertical,
                                  onEndOfPage: () async {
                                    if (userCount >
                                        ((pageIndex + 1) * limits)) {
                                      await next();
                                    }
                                  },
                                  child: CustomListLayout(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: CustomListTile(
                                          bgColor: Pallete.white,
                                          leading: data[index]
                                                  .photoUrl
                                                  .isNotEmpty
                                              ? CircleAvatar(
                                                  radius: w * 0.08,
                                                  backgroundImage: NetworkImage(
                                                      data[index].photoUrl),
                                                )
                                              : CircleAvatar(
                                                  radius: w * 0.1,
                                                  backgroundImage:
                                                      const AssetImage(
                                                          ImageConst
                                                              .profilePic),
                                                ),
                                          title: Text(
                                            data[index].name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: w * 0.043,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Age : ${data[index].age}"),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
