import 'package:flutter/material.dart';

import 'package:saipaapp/components/login_container.dart';
import 'package:saipaapp/utilities/clippers.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();

  bool _isLoginTapped = false;
  bool _isSignUpTapped = false;

  String _errorText;
  String _enteredNumber;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _enteredNumber = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: (_isLoginTapped || _isSignUpTapped)
            ? () async {
                if (_isLoginTapped)
                  setState(() => _isLoginTapped = !_isLoginTapped);
                else
                  setState(() => _isSignUpTapped = !_isSignUpTapped);
              }
            : null,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (_enteredNumber == null) {
              setState(() {
                _errorText = 'شماره موبایل الزامی است';
              });
            }
          },
          child: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[
                    Colors.black12,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: <double>[0, 0.4],
                ),
              ),
              child: Stack(
                children: <Widget>[
                  _topText(),
                  if (_isLoginTapped || _isSignUpTapped) _backButton(),
                  if (!_isLoginTapped && !_isSignUpTapped) _initialMode(),
                  if (_isLoginTapped) _loginMode(),
                  if (_isSignUpTapped) _signupMode(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topText() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.15,
      left: MediaQuery.of(context).size.width * 0.001,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.cover,
          child: const Text(
            'گروه خودروسازی سایپا',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return Positioned(
      top: 10,
      height: 50,
      width: 50,
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: 15, left: 10),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (_isLoginTapped)
              setState(() => _isLoginTapped = !_isLoginTapped);
            else
              setState(() => _isSignUpTapped = !_isSignUpTapped);
          },
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _initialMode() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.15 +
          MediaQuery.of(context).size.height * 0.25,
      height: MediaQuery.of(context).size.height * 0.4,
      left: (MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 0.85) /
          2,
      // width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: <Widget>[
          LoginContainer(
            'ورود',
            Colors.grey.shade600,
            Colors.white,
            () => setState(() => _isLoginTapped = !_isLoginTapped),
            ClipMethods.loginTopLeftClip,
          ),
          const SizedBox(height: 15),
          LoginContainer(
            'ثبت نام',
            Colors.cyan.shade400,
            Colors.blueGrey,
            () => setState(() => _isSignUpTapped = !_isSignUpTapped),
            ClipMethods.loginTopLeftClip,
          ),
        ],
      ),
    );
  }

  Widget _loginMode() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.18 +
          MediaQuery.of(context).size.height * 0.15,
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: const Text('شماره همراه'),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _controller,
              onChanged: (newNumber) {
                if (newNumber == null) {
                  setState(() => _errorText = 'شماره موبایل الزامی است');
                } else {
                  setState(() => _errorText = null);
                }
              },
              decoration: InputDecoration(
                errorText: _errorText,
                filled: true,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.blue.shade700,
                    width: 0.5,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              cursorColor: Colors.red,
              cursorWidth: 1.2,
            ),
          ),
          const SizedBox(height: 25.0),
          LoginContainer(
            'ارسال کد',
            Colors.grey.shade600,
            Colors.white,
            () {
              if (_enteredNumber == null) {
                if (_errorText == null) {
                  setState(() {
                    _errorText = 'شماره موبایل الزامی است';
                  });
                }
              }
            },
            ClipMethods.loginTopLeftClip,
          ),
        ],
      ),
    );
  }

  Widget _signupMode() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.18 +
          MediaQuery.of(context).size.height * 0.15,
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          const Text(
            'برای استفاده از خدمات سایپا ثبت نام کنید',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          Container(
            child: const Text(
              'لطفا نام و نام خانواگی خود را فارسی وارد کنید',
              style: const TextStyle(fontWeight: FontWeight.w100),
            ),
            padding: const EdgeInsets.only(right: 15),
            alignment: Alignment.centerRight,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            child: const Directionality(
              textDirection: TextDirection.rtl,
              child: const TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'نام و نام خانوادگی',
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            child: const Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'تلفن همراه',
                ),
                keyboardType: TextInputType.number,
                textDirection: TextDirection.ltr,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            child: const Directionality(
              textDirection: TextDirection.rtl,
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'کد ملی',
                ),
                keyboardType: TextInputType.number,
                textDirection: TextDirection.ltr,
              ),
            ),
          ),
          const SizedBox(height: 25),
          LoginContainer(
            'ثبت نام در سایپا',
            Colors.grey,
            Colors.white,
            () {},
            ClipMethods.loginTopLeftClip,
          ),
        ],
      ),
    );
  }
}
