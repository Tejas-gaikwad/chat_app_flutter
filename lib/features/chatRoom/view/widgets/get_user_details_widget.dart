import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserDataWidget extends StatelessWidget {
  final String senderUserId;
  final String currentUserId;
  final Color nameColor;
  const GetUserDataWidget({
    super.key,
    required this.senderUserId,
    required this.nameColor,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("users")
          .doc(senderUserId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Unknown",
            style: Theme.of(context).textTheme.bodyText2,
          );
        }
        if (snapshot.hasData) {
          final data = snapshot.data;
          final userData = data?.data();
          return (senderUserId == currentUserId)
              ? const SizedBox()
              : Row(
                  children: [
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            userData?['imagePath'] ??
                                "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
                            fit: BoxFit.cover,
                          ),
                        )),
                    SizedBox(width: 5),
                    Text(
                      userData?['username'],
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                );
        }
        return const SizedBox();
      },
    );
  }
}
