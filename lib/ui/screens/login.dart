import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginTapped = false;
  bool isSignUpTapped = false;

  List<Widget> loginMode = [
    Container(
      child: const Text('شماره همراه'),
      padding: const EdgeInsets.symmetric(horizontal: 20),
    ),
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextField(
        decoration: InputDecoration(border: InputBorder.none),
        keyboardType: TextInputType.number,
      ),
    ),
    const SizedBox(height: 25.0),
    LoginContainer(
      'ارسال کد',
      Colors.grey.shade600,
      Colors.white,
      () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              if (isLoginTapped || isSignUpTapped)
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15, left: 10),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      if (isLoginTapped)
                        setState(() => isLoginTapped = !isLoginTapped);
                      else
                        setState(() => isSignUpTapped = !isSignUpTapped);
                    },
                    color: Colors.white,
                  ),
                ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.45,
                child: const Text(
                  'گروه خودروسازی سایپا',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isLoginTapped) ...loginMode,
              if (!isLoginTapped && !isSignUpTapped) ...notLogin(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> notLogin() {
    return [
      LoginContainer(
        'ورود',
        Colors.grey.shade600,
        Colors.white,
        () => setState(() => isLoginTapped = !isLoginTapped),
      ),
      const SizedBox(height: 15),
      LoginContainer(
        'ثبت نام',
        Colors.cyan.shade400,
        Colors.blueGrey,
        () => setState(() => isSignUpTapped = !isSignUpTapped),
      ),
    ];
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    print('******************$size****************');
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LoginContainer extends StatelessWidget {
  final String text;
  final Color containerColor;
  final Color textColor;
  final Function onTap;

  LoginContainer(this.text, this.containerColor, this.textColor, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipPath(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 25.0),
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: const BorderRadius.only(
              topRight: const Radius.circular(15.0),
              bottomRight: const Radius.circular(15.0),
              bottomLeft: const Radius.circular(20.0),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
        clipper: MyClipper(),
      ),
      onTap: onTap,
    );
  }
}
