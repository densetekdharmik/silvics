import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silvics/auth/sign_up.dart';
import 'package:silvics/contain_page.dart';

import '../custom_widget/loader.dart';
import '../services/services.dart';
import '../values/colors.dart';
import '../values/const_urls.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool _showLoader = false;
String? _firebaseToken;

var _whiteColor = Colors.white.withOpacity(0.5);

TextEditingController? _phoneController, _passwordController;
bool? _isVisible = true;

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _getToken();
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
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.mainColor,
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                "Welcome Back",
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
                "Please sign in to your account",
                style: TextStyle(fontSize: 15.sp, color: _whiteColor),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.all(22.sp),
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
                            borderSide: BorderSide(color: Colors.transparent)),
                        hintText: "Please Enter Mobile Number",
                        hintStyle: TextStyle(color: _whiteColor)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22.sp, 1.h, 22.sp, 0),
              child: Container(
                height: 7.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(19.sp),
                ),
                child: Center(
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _isVisible!,
                    decoration: InputDecoration(
                        suffixIcon: _isVisible == false
                            ? IconButton(
                                icon:
                                    Icon(Icons.visibility, color: _whiteColor),
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
                            borderSide: BorderSide(color: Colors.transparent)),
                        hintText: "Please Enter Password",
                        hintStyle: TextStyle(color: _whiteColor)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 47.w, top: 0.9.h),
              child: Text("Forgot Password ?"),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.all(22.sp),
              child: InkWell(
                onTap: () {
                  if (_phoneController!.text.isEmpty) {
                    Services.snackBarError(
                        context, "Please Enter Mobile Number");
                  } else if (_passwordController!.text.isEmpty) {
                    Services.snackBarError(context, "Please Enter Password");
                  } else {
                    _login(_phoneController!.text, _passwordController!.text);
                  }
                },
                child: Container(
                  height: 7.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(19.sp),
                  ),
                  child: Center(
                      child: Text(
                    "Sign IN",
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
                Text("Dont Have An Account ? "),
                InkWell(
                  onTap: () {
                    Get.to(() => SignUpPage());
                  },
                  child: Text("Sign UP",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _initController() {
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  _disposeController() {
    _phoneController!.dispose();
    _passwordController!.dispose();
    _initController();
  }

  Future<void> _login(String mobile, String password) async {
    final String apiUrl = ConstUrls.login;
    SharedPreferences _prefs = await SharedPreferences.getInstance();

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
        "var_token": _firebaseToken,
      };
      response = await dio.post(apiUrl,
          options: Options(
            contentType: 'application/x-www-form-urlencoded',
          ),
          data: (body));

      setState(() {
        _showLoader = false;
        _prefs.setBool('isLoggedIn', true);
        _message = response.data['message'];
        _prefs.setString('userName', response.data['data']['var_name']);
        _prefs.setString('userEmail', response.data['data']['var_email']);
        _prefs.setString('userPhone', response.data['data']['var_mobileno']);
      });
      Services.snackBarSuccess(context, _message!);
      Get.offAll(() => ContainPage());
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        setState(() {
          _showLoader = false;
        });
        Services.snackBarError(context, "Something Went Wrong!!!");
      }
    }
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firebaseToken = prefs.getString('firebaseToken');
    });
  }
}
