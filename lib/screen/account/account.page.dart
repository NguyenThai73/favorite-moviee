// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_movie/constants/dialog.show.image.dart';
import 'package:favorite_movie/constants/error.dart';
import 'package:favorite_movie/constants/loading.dart';
import 'package:favorite_movie/constants/share.preferences.dart';
import 'package:favorite_movie/screen/account/component/dialog.change.pass.dart';
import 'package:favorite_movie/screen/account/component/dialog.delete.account.dart';
import 'package:favorite_movie/screen/block/block.screen.dart';
import 'package:favorite_movie/screen/login_screen/login.cubit.dart';
import 'package:favorite_movie/screen/login_screen/login.screen.dart';
import 'package:favorite_movie/screen/policy/policy.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account.cubit.dart';
import 'account.cubit.state.dart';
import 'component/dialog.change.name.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountCubitState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(width: 6, color: Color(0xFFE2E2E2)))),
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Column(
                            children: [
                              Image.asset("assets/background_infor.png", fit: BoxFit.fitWidth),
                            ],
                          )),
                          Positioned.fill(
                              child: Column(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, bottom: 5),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(width: 1, color: Colors.white),
                                            borderRadius: BorderRadius.circular(100)),
                                        child: ClipOval(
                                            child: (state.userAppModel.image != null)
                                                ? GestureDetector(
                                                  onTap: (){
                                                     context.showDialogImage(state.userAppModel.image??"");
                                                  },
                                                  child: CachedNetworkImage(
                                                      imageUrl: state.userAppModel.image ?? "",
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context, url, error) {
                                                        return Image.asset(
                                                          "assets/noavatar.png",
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                )
                                                : Image.asset(
                                                    "assets/noavatar.png",
                                                    fit: BoxFit.cover,
                                                  )),
                                      ),
                                    ),
                                    Positioned.fill(
                                        child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          width: 30,
                                          height: 30,
                                          child: GestureDetector(
                                              onTap: () async {
                                                var urlFile = await handleUploadImage();
                                                if (urlFile != null) {
                                                  context.read<AccountCubit>().updateImage(urlFile);
                                                }
                                              },
                                              child: Image.asset("assets/icon_camera.png")),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: Container()),
                                  Text(
                                    state.userAppModel.name ?? "",
                                    style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: GestureDetector(
                                            onTap: () async {
                                              var response = await showDialog(
                                                context: context,
                                                builder: (context) => DialogChangeName(
                                                  nameNow: state.userAppModel.name ?? "",
                                                ),
                                              );
                                              if (response != null && response is String && response.isNotEmpty) {
                                                var result = await context.read<AccountCubit>().updateName(response);
                                                if (result) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => ErrorDialogApp(
                                                      message: "Change name successfully",
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            child: Image.asset("assets/icon_edit.png"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                state.userAppModel.email ?? "",
                                style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 14, bottom: 18),
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E2E2)))),
                                child: GestureDetector(
                                  onTap: () async {
                                    var response = await showDialog(
                                      context: context,
                                      builder: (context) => const DialogChangePassword(),
                                    );
                                    if (response != null && response is String && response.isNotEmpty) {
                                      var result = await context.read<AccountCubit>().updatePassword(response);
                                      if (result) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => ErrorDialogApp(
                                            message: "Change password successfully",
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset("assets/lock.png"),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Change password",
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: Color(0xFF999898),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 14, bottom: 18),
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E2E2)))),
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => const BlockScreen(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset("assets/block-user.png"),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "User has been blocked",
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: Color(0xFF999898),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 14, bottom: 18),
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E2E2)))),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => const PolicyScreen(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset("assets/privacy-policy.png"),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Privacy policy",
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: Color(0xFF999898),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 14, bottom: 18),
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E2E2)))),
                                child: GestureDetector(
                                  onTap: () async {
                                    var response = await showDialog(
                                      context: context,
                                      builder: (context) => const DialogDeleteAccount(),
                                    );
                                    if (response != null && response is bool && response == true) {
                                      await FirebaseAuth.instance.currentUser!.delete();
                                      AppSharedPreferences.clear();
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) => BlocProvider(
                                            create: (context) => LoginCubit(),
                                            child: const LoginScreen(),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset("assets/delete-user.png"),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Delete my account",
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: Color(0xFF999898),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await FirebaseAuth.instance.signOut();
                                  AppSharedPreferences.clear();
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => BlocProvider(
                                        create: (context) => LoginCubit(),
                                        child: const LoginScreen(),
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Image.asset("assets/log-out.png"),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "Log out",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              Positioned.fill(child: state.status == AccountStatus.loading ? const LoadingApp() : const SizedBox.shrink())
            ],
          ),
        );
      },
    );
  }
}
