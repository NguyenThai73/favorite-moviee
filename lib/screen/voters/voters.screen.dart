import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_movie/constants/loading.dart';
import 'package:favorite_movie/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'voters.cubit.dart';
import 'voters.cubit.state.dart';

class VotersScreen extends StatelessWidget {
  const VotersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocBuilder<VotersCubit, VotersCubitState>(
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color(0xFF325A3E),
                    leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    title: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, right: 10),
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: "$urlImageBase${context.read<VotersCubit>().rankingModel.poster_path}",
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            context.read<VotersCubit>().rankingModel.title ?? "",
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.listVoter.length,
                        itemBuilder: (context, index) {
                          final voter = state.listVoter[index];
                          return Container(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                            child: Row(
                              children: [
                                Text("#${index+1}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                                const SizedBox(width: 15),
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: ClipOval(
                                      child: (voter.image != null)
                                          ? CachedNetworkImage(
                                              imageUrl: voter.image ?? "",
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
                                const SizedBox(width: 15),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      voter.name ?? "",
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      voter.email ?? "",
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "Point vote: ${voter.point}",
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )),
                                const SizedBox(width: 15),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
              Positioned.fill(child: state.status == VotersStatus.loading ? const LoadingApp() : const SizedBox.shrink())
            ],
          );
        },
      ),
    );
  }
}
