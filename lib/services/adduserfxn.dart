import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UserRegistrationService {
  final uid;
  UserRegistrationService({this.uid});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(String name, String email, String role, String wallet) {
    var id = Uuid();
    String userId = id.v1();

    return _firestore
        .collection('users')
        .doc(uid)
        .set({
          'id': userId,
          'username': name,
          'email': email,
          'role': role,
          'MetaMask Address': wallet,
        })
        .then((value) => print('User added'))
        .catchError((error) => print('Failed to add user'));
  }
}
