// ignore_for_file: use_build_context_synchronously, deprecated_member_use, prefer_const_constructors
import 'package:favorite_movie/screen/block/block.cubit.dart';
import 'package:favorite_movie/screen/favorite/favorite.cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/error.dart';
import '../../constants/loading.dart';
import '../../main.app.dart';
import '../register_sreen/register.cubit.dart';
import '../register_sreen/register.page.dart';
import 'login.cubit.dart';
import 'login.cubit.state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSeenPass = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginCubitState>(
      listener: (context, state) {
        if (state.status == LoginStatus.loading) {}
        if (state.status == LoginStatus.success) {
          context.read<FavoriteCubit>().getData();
          context.read<BlockCubit>().getData();
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const MainApp(),
            ),
          );
          
        }
        if (state.status == LoginStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialogApp(
              message: "Account password is incorrect",
            ),
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Stack(
            children: [
              Positioned.fill(
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.1,
                                  bottom: MediaQuery.of(context).size.height * 0.07,
                                ),
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20), image: const DecorationImage(image: AssetImage("assets/logo.png"))),
                              ),
                              SizedBox(height: 30),
                              Container(
                                margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                                padding: EdgeInsets.only(right: 10),
                                height: 56,
                                decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  controller: context.read<LoginCubit>().emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                                    prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.email)),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 18),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                                padding: EdgeInsets.only(right: 10),
                                height: 56,
                                decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  controller: context.read<LoginCubit>().passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                                    prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.lock)),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 18),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isSeenPass = !isSeenPass;
                                        });
                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Icon(
                                          isSeenPass ? Icons.visibility_off : Icons.visibility,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  obscureText: isSeenPass,
                                ),
                              ),
                              Container(
                                height: 56,
                                margin: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xFF335a3e),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    context.read<LoginCubit>().login();
                                  },
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: "Do not have an account? ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF999999),
                                  ),
                                ),
                                TextSpan(
                                  text: "Register",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF325A3E),
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      var response = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => BlocProvider(
                                            create: (context) => RegisterCubit(),
                                            child: const RegisterPage(),
                                          ),
                                        ),
                                      );
                                      if (response != null && response is String) {
                                        context.read<LoginCubit>().registerSucces(email: response);
                                      }
                                    },
                                ),
                              ])),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
              Positioned.fill(child: state.status == LoginStatus.loading ? LoadingApp() : SizedBox.shrink())
            ],
          ),
        );
      },
    );
  }
}
