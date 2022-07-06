import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../custom_widget/loader.dart';
import '../services/services.dart';
import '../values/colors.dart';
import '../values/const_urls.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

var _whiteColor = Colors.white.withOpacity(0.5);
bool? _isVisible = true;
bool? _isVisibleCnfrmPassword = true;
TextEditingController? _nameController,
    _emailController,
    _phoneController,
    _passwordController,
    _cnfrmPasswordController;

bool _showLoader = false;

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeController();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showLoader,
      progressIndicator: ColorLoader(),
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  "Create New Account",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 22.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Center(
                child: Text(
                  "Please fill in the form to continue",
                  style: TextStyle(fontSize: 15.sp, color: _whiteColor),
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.sp, 1.h.sp, 22.sp, 0),
                child: Container(
                  height: 7.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(19.sp),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          focusColor: Colors.transparent,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "Please Enter Name",
                          hintStyle: TextStyle(color: _whiteColor)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.sp, 2.h, 22.sp, 0),
                child: Container(
                  height: 7.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(19.sp),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          focusColor: Colors.transparent,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "Please Enter Email ID",
                          hintStyle: TextStyle(color: _whiteColor)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.sp, 2.h.sp, 22.sp, 0),
                child: Container(
                  height: 7.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(19.sp),
                  ),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      maxLength: 10,
                      decoration: InputDecoration(
                          counterText: "",
                          focusColor: Colors.transparent,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "Please Enter Mobile Number",
                          hintStyle: TextStyle(color: _whiteColor)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.sp, 2.h.sp, 22.sp, 0),
                child: Container(
                  height: 7.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(19.sp),
                  ),
                  child: Center(
                    child: TextFormField(
                      obscureText: _isVisible!,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          counterText: "",
                          suffixIcon: _isVisible == false
                              ? IconButton(
                                  icon: Icon(Icons.visibility,
                                      color: _whiteColor),
                                  onPressed: () {
                                    setState(() {
                                      _isVisible = true;
                                    });
                                  })
                              : IconButton(
                                  icon: Icon(Icons.visibility_off,
                                      color: _whiteColor),
                                  onPressed: () {
                                    setState(() {
                                      _isVisible = false;
                                    });
                                  }),
                          focusColor: Colors.transparent,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "Please Enter Password",
                          hintStyle: TextStyle(color: _whiteColor)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.sp, 2.h.sp, 22.sp, 0),
                child: Container(
                  height: 7.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(19.sp),
                  ),
                  child: Center(
                    child: TextFormField(
                      obscureText: _isVisibleCnfrmPassword!,
                      controller: _cnfrmPasswordController,
                      decoration: InputDecoration(
                          counterText: "",
                          suffixIcon: _isVisibleCnfrmPassword == false
                              ? IconButton(
                                  icon: Icon(Icons.visibility,
                                      color: _whiteColor),
                                  onPressed: () {
                                    setState(() {
                                      _isVisibleCnfrmPassword = true;
                                    });
                                  })
                              : IconButton(
                                  icon: Icon(Icons.visibility_off,
                                      color: _whiteColor),
                                  onPressed: () {
                                    setState(() {
                                      _isVisibleCnfrmPassword = false;
                                    });
                                  }),
                          focusColor: Colors.transparent,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "Confirm Your Password",
                          hintStyle: TextStyle(color: _whiteColor)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.all(22.sp),
                child: InkWell(
                  onTap: () {
                    if (_nameController!.text.isEmpty) {
                      Services.snackBarError(context, "Please Enter Name");
                    } else if (_emailController!.text.isEmpty) {
                      Services.snackBarError(context, "Please Enter Email");
                    } else if (_phoneController!.text.isEmpty) {
                      Services.snackBarError(context, "Please Mobile Number");
                    } else if (_phoneController!.text.length > 10) {
                      Services.snackBarError(
                          context, "Mobile Number Must Have 10 Digits");
                    } else if (_passwordController!.text.isEmpty) {
                      Services.snackBarError(context, "Please Enter Password");
                    } else if (_cnfrmPasswordController!.text.isEmpty) {
                      Services.snackBarError(
                          context, "Please Confirm You Password");
                    } else if (_cnfrmPasswordController!.text !=
                        _passwordController!.text) {
                      Services.snackBarError(
                          context, "Password Does Not Match");
                    } else {
                      _signUp(
                        _phoneController!.text,
                        _passwordController!.text,
                        _nameController!.text,
                        _emailController!.text,
                      );
                    }
                  },
                  child: Ink(
                    height: 7.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(19.sp),
                    ),
                    child: Center(
                        child: Text(
                      "Sign UP",
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 22.w,
                  ),
                  Text("Already Have An Account ? "),
                  InkWell(
                    onTap: () {
                      Get.to(() => LoginPage());
                    },
                    child: Text("Sign In",
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp(
      String mobile, String password, String name, String email) async {
    final String apiUrl = ConstUrls.signUp;

    setState(() {
      _showLoader = true;
    });
    Response response;
    var dio = Dio();
    String? _message;

    try {
      var body = {
        "var_mobileno": mobile,
        "var_password": password,
        "var_name": name,
        "var_email": email,
      };
      response = await dio.post(apiUrl,
          options: Options(
            contentType: 'application/x-www-form-urlencoded',
          ),
          data: (body));

      setState(() {
        _showLoader = false;
        _message = response.data['message'];
      });
      log(response.data.toString());
      Get.to(() => LoginPage())!.then((value) => {setState(() {})});
      Services.snackBarSuccess(context, _message!);
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        setState(() {
          _showLoader = false;
        });
        log(e.message.toString());
        Services.snackBarError(context, "Something Went Wrong!!!");
      }
    }
  }

  _initController() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _cnfrmPasswordController = TextEditingController();
  }

  _disposeController() {
    _nameController!.dispose();
    _emailController!.dispose();
    _phoneController!.dispose();
    _passwordController!.dispose();
    _cnfrmPasswordController!.dispose();
    _initController();
  }
}
