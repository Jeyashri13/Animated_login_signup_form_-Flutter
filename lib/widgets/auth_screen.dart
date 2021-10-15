// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_with_firebase_auth/widgets/constants.dart';
import 'package:login_with_firebase_auth/widgets/login_form.dart';
import 'package:login_with_firebase_auth/widgets/signup_form.dart';
import 'package:login_with_firebase_auth/widgets/social_buttons.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false;

  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;
  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: <Widget>[
                //login
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: size.width * 0.88,
                  height: size.height,
                  left: _isShowSignUp ? -size.width * 0.76 : 0,
                  child: Container(
                    color: login_bg,
                    child: LoginForm(),
                  ),
                ),
                //signup

                AnimatedPositioned(
                  duration: defaultDuration,
                  height: size.height,
                  width: size.width * 0.88,
                  left: _isShowSignUp ? size.width * 0.12 : size.width * 0.88,
                  child: Container(
                    color: signup_bg,
                    child: SignUpForm(),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  top: size.height * 0.1,
                  left: 0,
                  right: _isShowSignUp ? -size.width * 0.06 : size.width * 0.06,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white60,
                    child: AnimatedSwitcher(
                      duration: defaultDuration,
                      child: _isShowSignUp
                          ? SvgPicture.asset(
                              "assets/animation_logo.svg",
                              color: signup_bg,
                            )
                          : SvgPicture.asset(
                              "assets/animation_logo.svg",
                              color: login_bg,
                            ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: size.width,
                  bottom: size.height * 0.1,
                  right: _isShowSignUp ? -size.width * 0.06 : size.width * 0.06,
                  child: SocialButtons(),
                ),
                //logintext
                AnimatedPositioned(
                  duration: defaultDuration,
                  left: _isShowSignUp ? 0 : size.width * 0.44 - 80,
                  bottom:
                      _isShowSignUp ? size.height / 2 - 80 : size.height * 0.3,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: _isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignUp ? Colors.white : Colors.white70),
                    child: Transform.rotate(
                      angle: -_animationTextRotate.value * pi / 180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          if (_isShowSignUp) {
                            updateView();
                          } else {
                            //login
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75),
                          width: 160,
                          child: Text(
                            'Log In'.toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // signup Text
                AnimatedPositioned(
                  duration: defaultDuration,
                  right: _isShowSignUp ? size.width * 0.44 - 80 : 0,
                  bottom:
                      !_isShowSignUp ? size.height / 2 - 80 : size.height * 0.3,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: !_isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignUp ? Colors.white : Colors.white70),
                    child: Transform.rotate(
                      angle: (90 - _animationTextRotate.value) * pi / 180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          if (_isShowSignUp) {
                            //signup
                          } else {
                            updateView();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75),
                          width: 160,
                          child: Text(
                            'Sign Up'.toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
