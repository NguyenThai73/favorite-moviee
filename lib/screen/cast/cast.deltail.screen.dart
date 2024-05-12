import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cast.deltail.cubit.dart';
import 'cast.deltail.cubit.state.dart';

class CastDetailScreen extends StatelessWidget {
  const CastDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastDetailCubit, CastDetailCubitState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF325A3E),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            leadingWidth: 50,
            title: Text(
              state.castDetailModel.name ?? "",
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            centerTitle: true,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
