// ignore_for_file: use_build_context_synchronously, deprecated_member_use, prefer_const_constructors
import 'package:favorite_movie/constants/error.dart';
import 'package:favorite_movie/constants/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout.register.dart';
import 'register.cubit.dart';
import 'register.cubit.state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isSeenPass = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterCubitState>(
      listener: (context, state) {
        if (state.status == Status.success) {
         Navigator.pop(context, context.read<RegisterCubit>().emailController.text);
        }
        if (state.status == Status.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialogApp(
              message: "The email was registered",
            ),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Positioned.fill(
              child: LayoutRegister(
                namePage: "Register!",
                subPage: "Create your new account!",
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                        padding: EdgeInsets.only(right: 10),
                        height: 56,
                        decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: context.read<RegisterCubit>().nameController,
                          decoration: InputDecoration(
                            hintText: "Full name",
                            helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                            prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.person)),
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
                          controller: context.read<RegisterCubit>().emailController,
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
                          controller: context.read<RegisterCubit>().passwordController,
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
                        margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                        padding: EdgeInsets.only(right: 10),
                        height: 56,
                        decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: context.read<RegisterCubit>().comfirmPasswordController,
                          decoration: InputDecoration(
                            hintText: "Password confirm",
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
                    ],
                  ),
                ),
                buttonName: "Register",
                onTap: () {
                  if (context.read<RegisterCubit>().nameController.text.isEmpty ||
                      context.read<RegisterCubit>().emailController.text.isEmpty ||
                      context.read<RegisterCubit>().passwordController.text.isEmpty ||
                      context.read<RegisterCubit>().comfirmPasswordController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => ErrorDialogApp(
                        message: "Need to enter enough information",
                      ),
                    );
                  } else {
                    if (context.read<RegisterCubit>().passwordController.text.length < 6 ||
                        context.read<RegisterCubit>().comfirmPasswordController.text.length < 6) {
                      showDialog(
                        context: context,
                        builder: (context) => ErrorDialogApp(
                          message: "Password must be greater than 5 characters",
                        ),
                      );
                    } else {
                      if (context.read<RegisterCubit>().passwordController.text != context.read<RegisterCubit>().comfirmPasswordController.text) {
                        showDialog(
                          context: context,
                          builder: (context) => ErrorDialogApp(
                            message: "Confirm passwords do not match",
                          ),
                        );
                      } else {
                        context.read<RegisterCubit>().register();
                      }
                    }
                  }
                },
              ),
            ),
            Positioned.fill(child: state.status == Status.loading ? LoadingApp() : SizedBox.shrink())
          ],
        );
      },
    );
  }
}

// class DataRegister {
//   final String name;
//   final String email;
//   final String password;
//   final FlutterEmailSender flutterEmailSender;
//   DataRegister({required this.name, required this.email, required this.password, required this.flutterEmailSender});
// }
