import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silvics/values/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

String? _userName,_userPhone,_userEmail;

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          Padding(
              padding: EdgeInsets.only(left: 3.w, top: 4.h),
              child: Row(
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 42.w,
                  ),
                ],
              )),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.all(18.sp),
            child: Container(
              height: 8.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person),
                  ),
                  title: Text(
                    _userName!,
                    style:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18.sp),
            child: Container(
              height: 8.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.local_phone_rounded),
                  ),
                  title: Text(
                    _userPhone!,
                    style:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18.sp),
            child: Container(
              height: 8.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.email),
                  ),
                  title: Text(
                    _userEmail!,
                    style:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _getData()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState((){
      _userName = _prefs.getString("userName");
      _userPhone = _prefs.getString("userPhone");
      _userEmail = _prefs.getString("userEmail");
    });
  }
}
