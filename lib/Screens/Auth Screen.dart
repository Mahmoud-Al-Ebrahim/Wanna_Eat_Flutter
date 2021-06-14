import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../back ground.dart';

class Auth_Screen extends StatefulWidget {
  static String route_name = '/Auth_Screen';

  @override
  _Auth_ScreenState createState() => _Auth_ScreenState();
}

enum AuthMode { Login, SignUp }

class _Auth_ScreenState extends State<Auth_Screen>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': '', 'password': ''};
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  TextEditingController _emailController;
  AnimationController _controller;
  Animation<double> _opacityAnimation;
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  Icon _passwordVisibleIcon = Icon(Icons.remove_red_eye);
  Icon _confirmPasswordVisibleIcon = Icon(Icons.remove_red_eye);

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 300,
        ));
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeIn,
        ));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Stack(
        children: [BackGroundGradient(), _makeLogo()],
      ),
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  _makeLogo() {
    var deviceSize = MediaQuery
        .of(context)
        .size;
    return Container(
      height: deviceSize.height,
      width: deviceSize.width,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  width: deviceSize.width * 0.9,
                  transform: Matrix4.rotationZ(-10 * pi / 180)
                    ..translate(-10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme
                          .of(context)
                          .accentColor,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 15,
                            color: Colors.white,
                            offset: Offset(0, 0))
                      ]),
                  child: Text(
                    'WANNA EAT',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: deviceSize.width * 0.14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            Flexible(child: _makeCardSignAndLogin(), flex: 2),
          ]),
    );
  }

  _makeCardSignAndLogin() {
    var deviceSize = MediaQuery
        .of(context)
        .size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        height: _authMode == AuthMode.SignUp ? deviceSize.height/2 : deviceSize.height/2.35,
        curve: Curves.easeIn,
        duration: Duration(
          milliseconds: 300,
        ),
        width: deviceSize.width * 0.9,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  height: deviceSize.height*0.1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email_outlined,
                      ),
                      labelText: 'E-Mail',
                      hintText: 'test@gmail.com',
                      errorStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (val) {
                      _authData['email'] = val;
                    },
                  ),
                ),
                AnimatedContainer(
                  height: deviceSize.height*0.1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: TextFormField(
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: _passwordVisibleIcon,
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                            _passwordVisibleIcon = _passwordVisible == false
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.remove_red_eye);
                          });
                        },
                      ),
                      icon: Icon(
                        Icons.vpn_key,
                      ),
                      hintText: 'Abc@#123',
                      errorStyle: TextStyle(fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    controller: _passwordController,
                    onSaved: (val) {
                      _authData['password'] = val;
                    },
                  ),
                ),
                AnimatedContainer(
                  height: _authMode == AuthMode.SignUp ?deviceSize.height*0.1 : 0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: TextFormField(

                      controller: _confirmPasswordController,
                      obscureText: _confirmPasswordVisible,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: _confirmPasswordVisibleIcon,
                            onPressed: () {
                              setState(() {
                                _confirmPasswordVisible =
                                !_confirmPasswordVisible;
                                _confirmPasswordVisibleIcon =
                                _confirmPasswordVisible == false
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.remove_red_eye);
                              });
                            },
                          ),
                          labelText: 'Confirm Password',
                          icon: Icon(
                            Icons.repeat,
                          ),
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          enabled: _authMode == AuthMode.SignUp),
                    ),
                  ),
                ),
                SizedBox(height: deviceSize.height*0.03),
                RaisedButton(
                  onPressed: _submit,
                  child: Text(
                    _authMode == AuthMode.SignUp ? 'SIGN UP' : 'LOGIN',
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  textColor: Colors.white,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: FlatButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      _authMode == AuthMode.SignUp
                          ? 'LOGIN' + ' INSTEAD'
                          : 'SIGN UP' + ' INSTEAD',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 30),
                    textColor: Theme
                        .of(context)
                        .primaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _submit() {
    Map<String, String> validationResult = validation();
    if (validationResult['validate'] == 'false') {
      Fluttertoast.showToast(
          msg: validationResult['message'],
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG
      );
    }

  }

  Map<String, String> validation() {
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text) ||
        _passwordController.text.length < 8)
      return {'message': 'E-Mail or Password is invalid', 'validate': 'false'};
    else if (_confirmPasswordController.text != _passwordController.text && _authMode==AuthMode.SignUp) {
      return {'message': 'Password is not Matched', 'validate': 'false'};
    }
    return {};
  }
}
