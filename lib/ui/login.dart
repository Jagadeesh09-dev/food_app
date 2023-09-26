import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodie/models/user.dart';
import 'package:foodie/utils/app_colors.dart';

import '../services/foodie_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _isLoading = false;
  final Map _signupData = {
    "user_firstname": "",
    "user_email": "",
    "user_phone": "",
    "user_password": "",
    "user_lastname": "ji",
    "user_city": "Hyderabad",
    "user_zipcode": "500072",
  };

  final Map _signinData = {
    "user_email": "",
    "user_password": "",
  };

  String _errorMsg = "";

  validateSignupForm() async {
    Map result = {};
    if (!_signupFormKey.currentState!.validate()) {
      return;
    }
    _signupFormKey.currentState!.save();
    Navigator.pop(context);
    setState(() {
      _isLoading = true;
    });
    await FoodieService().userRegister(json.encode(_signupData)).then((response) {
      result = json.decode(response.body);
    });
    await Future.delayed(const Duration(seconds: 3), () {});
    if (!result['status']) {
      setState(() {
        _isLoading = false;
        _errorMsg = result['msg'];
      });
      signupBottomSheet();
    } else {
      user = User.fromJson(_signupData);
      user.id = result['registeredID'].toString();
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
    }
  }

  validateSigninForm() async {
    Map result = {};
    if (!_signinFormKey.currentState!.validate()) {
      return;
    }
    _signinFormKey.currentState!.save();
    Navigator.pop(context);
    setState(() {
      _isLoading = true;
    });
    await FoodieService().userLogin(json.encode(_signinData)).then((response) {
      result = json.decode(response.body);
    });
    await Future.delayed(const Duration(seconds: 3), () {});
    if (!result['status']) {
      setState(() {
        _isLoading = false;
        _errorMsg = result['msg'];
      });
      signinBottomSheet();
    } else {
      user = User.fromJson(result['user_data'][0]);
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
    }
  }

  clearData() {
    setState(() {
      _signupData['user_firstname'] = "";
      _signupData['user_email'] = "";
      _signupData['user_phone'] = "";
      _signupData['user_password'] = "";
      _signinData['user_email'] = "";
      _signinData['user_password'] = "";
      _errorMsg = '';
    });
  }

  Future signupBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.grey[100],
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
            return Wrap(
              children: [
                Container(
                    width: screenWidth,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Create Account", style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold, color: Colors.black)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: screenWidth * 0.8,
                          child: Form(
                              key: _signupFormKey,
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            "Name",
                                            style: TextStyle(fontSize: screenHeight * 0.013, fontWeight: FontWeight.w500, color: Colors.black45),
                                          )),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.name,
                                        initialValue: _signupData['user_firstname'],
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              )),
                                        ),
                                        validator: (val) {
                                          if (val!.isEmpty) return 'Enter valid name';
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            _signupData['user_firstname'] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            "Mobile",
                                            style: TextStyle(fontSize: screenHeight * 0.013, fontWeight: FontWeight.w500, color: Colors.black45),
                                          )),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.phone,
                                        initialValue: _signupData['user_phone'],
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              )),
                                        ),
                                        validator: (val) {
                                          if (val!.isEmpty || val.length != 10) return 'Enter valid mobile';
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            _signupData['user_phone'] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            "Email",
                                            style: TextStyle(fontSize: screenHeight * 0.013, fontWeight: FontWeight.w500, color: Colors.black45),
                                          )),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.emailAddress,
                                        initialValue: _signupData['user_email'],
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              )),
                                        ),
                                        validator: (val) {
                                          if (val!.isEmpty || !val.isValidEmail()) return 'Enter valid email';
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            _signupData['user_email'] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            "Password",
                                            style: TextStyle(fontSize: screenHeight * 0.013, fontWeight: FontWeight.w500, color: Colors.black45),
                                          )),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      TextFormField(
                                        // keyboardType: TextInputType.visiblePassword,
                                        initialValue: _signupData['user_password'],
                                        obscureText: !_passwordVisible,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordVisible ? Icons.visibility_off : Icons.visibility,
                                              color: appThemeColor,
                                            ),
                                            onPressed: () {
                                              setModalState(() {
                                                _passwordVisible = !_passwordVisible;
                                              });
                                            },
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              )),
                                        ),
                                        validator: (val) {
                                          if (val!.isEmpty) return 'Enter valid password';
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            _signupData['user_password'] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  if (_errorMsg != "")
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                  if (_errorMsg != "")
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [Text(_errorMsg, style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.015, fontWeight: FontWeight.w500))],
                                    ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _errorMsg = "";
                                        });
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        validateSignupForm();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: appThemeColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("I'm already a member. ", style: TextStyle(color: Colors.black, fontSize: screenHeight * 0.015, fontWeight: FontWeight.w500)),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          clearData();
                                          signinBottomSheet();
                                        },
                                        child: Text("Sign In", style: TextStyle(color: appThemeColor, fontSize: screenHeight * 0.015, fontWeight: FontWeight.w500)),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        )
                      ],
                    )),
              ],
            );
          });
        });
  }

  Future signinBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.grey[100],
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              // padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Sign In", style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: screenWidth * 0.8,
                        child: Form(
                            key: _signinFormKey,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          "Email",
                                          style: TextStyle(fontSize: screenHeight * 0.013, fontWeight: FontWeight.w500, color: Colors.black45),
                                        )),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    TextFormField(
                                      initialValue: _signinData['user_email'],
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            )),
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty || !val.isValidEmail()) return 'Enter valid email';
                                        return null;
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          _signinData['user_email'] = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          "Password",
                                          style: TextStyle(fontSize: screenHeight * 0.013, fontWeight: FontWeight.w500, color: Colors.black45),
                                        )),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    TextFormField(
                                      // keyboardType: TextInputType.visiblePassword,
                                      initialValue: _signinData['user_password'],
                                      obscureText: !_passwordVisible,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible ? Icons.visibility_off : Icons.visibility,
                                            color: appThemeColor,
                                          ),
                                          onPressed: () {
                                            setModalState(() {
                                              _passwordVisible = !_passwordVisible;
                                            });
                                          },
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            )),
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) return 'Enter valid password';
                                        return null;
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          _signinData['user_password'] = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Forgot password?", style: TextStyle(fontSize: screenHeight * 0.015, fontWeight: FontWeight.w500, color: Colors.black)),
                                  ],
                                ),
                                if (_errorMsg != "")
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                if (_errorMsg != "")
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text(_errorMsg, style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.015, fontWeight: FontWeight.w500))],
                                  ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.8,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _errorMsg = "";
                                      });
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      validateSigninForm();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: appThemeColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("I'm a new user. ", style: TextStyle(color: Colors.black, fontSize: screenHeight * 0.015, fontWeight: FontWeight.w500)),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        clearData();
                                        signupBottomSheet();
                                      },
                                      child: Text("Sign Up", style: TextStyle(color: appThemeColor, fontSize: screenHeight * 0.015, fontWeight: FontWeight.w500)),
                                    )
                                  ],
                                )
                              ],
                            )),
                      )
                    ],
                  )),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _isLoading
        ? Container(
            color: Colors.transparent,
            width: 300.0,
            height: 300.0,
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/images/loader.gif',
                )),
          )
        : Container();
    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50.0),
                    Text("foodie", style: TextStyle(color: appThemeColor, fontWeight: FontWeight.bold, fontSize: screenHeight * 0.04)),
                    const SizedBox(height: 20.0),
                    Image.asset(
                      'assets/images/food.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 30.0),
                    Text("Delivery that satisfies your hunger", style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: screenHeight * 0.02)),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _errorMsg = "";
                          });
                          signupBottomSheet();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appThemeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _errorMsg = "";
                          });
                          signinBottomSheet();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: appThemeColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (_isLoading)
              Center(
                child: loadingIndicator,
              ),
          ],
        ),
      ),
    );
  }
}
