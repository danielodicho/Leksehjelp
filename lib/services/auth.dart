import 'package:chat_app/module/user1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods{

    final FirebaseAuth _auth = FirebaseAuth.instance;

    User1? _userFromUser(User bruker){
      return bruker != null ? User1(userId: bruker.uid) : null;
    }

    Future signInWithEmailAndPassword(String email, String password) async {
      try{
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: email, password: password );

        User? firebaseUser = result.user;
        return _userFromUser(firebaseUser!);

      }catch(e){
        print(e);
      }

    }

    Future signUpwithEmailAndPassword(String email, String password) async{
      try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User? firebaseUser = result.user;
        return _userFromUser(firebaseUser!);
      }catch(e){
        print(e.toString());
      }
    }
    Future resetPass(String email) async{
      try{
        return await _auth.sendPasswordResetEmail(email: email);
      }catch(e){
        print(e.toString());
      }
    }

    Future signOut() async{
      try{
        return await _auth.signOut();
      }catch(e){

      }
    }

}