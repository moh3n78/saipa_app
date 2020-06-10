import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginTapped = false;
  bool isSignUpTapped = false;

  final TextEditingController _controller = TextEditingController();
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
      // body: ClipPath(
      //   child: Center(
      //     child: Container(
      //       height: 300,
      //       width: 300,
      //       decoration: BoxDecoration(
      //         color: Colors.blueAccent.shade700,
      //         borderRadius: BorderRadius.circular(15),
      //       ),
      //     ),
      //   ),
      //   clipper: MyClipper(),
      // ),
      // body: Center(
      //   child: Container(
      //     height: MediaQuery.of(context).size.height * 0.6,
      //     width: MediaQuery.of(context).size.width * 0.8,
      //     color: Colors.blueAccent.shade700,
      //     child: CustomPaint(
      //       foregroundPainter: MyCustomPainter(),
      //     ),
      //   ),
      // ),
      body: WillPopScope(
        onWillPop: (isLoginTapped || isSignUpTapped)
            ? () async {
                if (isLoginTapped)
                  setState(() => isLoginTapped = !isLoginTapped);
                else
                  setState(() => isSignUpTapped = !isSignUpTapped);
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
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
                  if (isLoginTapped || isSignUpTapped)
                    Positioned(
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
                            if (isLoginTapped)
                              setState(() => isLoginTapped = !isLoginTapped);
                            else
                              setState(() => isSignUpTapped = !isSignUpTapped);
                          },
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: Container(
                      alignment: Alignment.center,
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
                  ),
                  if (isLoginTapped) loginMode(),
                  if (isSignUpTapped) signupMode(),
                  if (!isLoginTapped && !isSignUpTapped) notLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginMode() {
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
          ),
        ],
      ),
    );
  }

  Widget signupMode() {
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
          LoginContainer('ثبت نام در سایپا', Colors.grey, Colors.white, () {})
        ],
      ),
    );
  }

  Widget notLogin() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.4,
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
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
        ],
      ),
    );
  }
}

class LoginContainer extends StatelessWidget {
  final String text;
  final Color containerColor;
  final Color textColor;
  final Function onTap;

  const LoginContainer(
    this.text,
    this.containerColor,
    this.textColor,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          alignment: Alignment.center,
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
        onTap: onTap,
      ),
      clipper: MyClipper(),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(25, 0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height / 3);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    Path path = Path();
    path.moveTo(50, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    canvas.drawPath(path, paint);
    // path.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
