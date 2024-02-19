
import 'package:cloud_firestore/cloud_firestore.dart';

Future addUserTable(username, email, uid) async {

  await FirebaseFirestore.instance.collection('customers').doc(uid).set(
    {
      'username': username,
      'email': email,
      'uid': uid,
      'points': 0
    },
  );
}

updateUserDetails(key, value, uid) async {
  await FirebaseFirestore.instance.collection('customers').doc(uid).update(
    {
      key: value,
    },
  );
}