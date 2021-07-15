import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUsername(String username ) async {
  return await FirebaseFirestore.instance.collection("users")
      .where("name", isEqualTo: username)
    .get();
    
    
  }

  getUserByUserEmail(String userEmail ) async {
    return await FirebaseFirestore.instance.collection("users")
        .where("email", isEqualTo: userEmail)
        .get();


  }

  uploadUserInfo(userInfoMap){

  FirebaseFirestore.instance.collection("users")
      .add(userInfoMap);


  }
  createChatRoom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).set(chatRoomMap).catchError((e) {
      print(e.toString());
    });
  }
}



