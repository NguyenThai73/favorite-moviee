import 'package:favorite_movie/constants/dialog.show.image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'account.cubit.dart';
import 'account.cubit.state.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountCubitState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: GestureDetector(
                onTap: () {
                  context.showDialogImage(state.userAppModel.image ?? "");
                },
                child: ClipOval(
                    child: (state.userAppModel.image != null)
                        ? CachedNetworkImage(
                            imageUrl: state.userAppModel.image ?? "",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                "assets/noavatar.png",
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            "assets/noavatar.png",
                            fit: BoxFit.cover,
                          )),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              state.userAppModel.name ?? "",
              style: const TextStyle(fontSize: 16, color: Color(0xFF000000)),
            )
          ],
        );
      },
    );
  }
}
