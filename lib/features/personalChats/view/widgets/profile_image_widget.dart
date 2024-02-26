import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constants/utils/colors.dart';

class ProfileImageWidget extends StatelessWidget {
  final String userId;
  const ProfileImageWidget({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("users").doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          final userData = data?.data();
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: primaryFairColor, width: 3.0),
            ),
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              child: Image.network(
                userData?['imagePath'] ??
                    "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
                fit: BoxFit.cover,
              ),
            ),
          );
        }
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person),
        );
      },
    );
  }
}
