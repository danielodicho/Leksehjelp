
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/views/chatScreen.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

 AuthMethods authMethods = new AuthMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController brukernavnController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passordController = new TextEditingController();


  signMeUp(){
    if(formKey.currentState!.validate()){
        setState(() {
          isLoading = true;
        });

        authMethods.signUpwithEmailAndPassword(emailController.text,
            passordController.text).then((value){

            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => ChatRoom()));
        });

        
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain,
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ): SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val){
                          return val!.isEmpty || val.length < 2 ? 'Legg inn brukernavn' : null;
                        },
                        controller: brukernavnController,
                          style: simpleStyle(),
                          decoration: textFieldInputDecoration('brukernavn')
                      ),
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?
                          null : "Legg inn riktig email";
                        },
                        controller: emailController,
                          style: simpleStyle(),
                          decoration: textFieldInputDecoration('e-mail')
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val!.length > 6 ? null : 'Passord må være meir enn 6 karakterer';
                        },
                        controller: passordController,
                        style: simpleStyle(),
                        decoration: textFieldInputDecoration('password'
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Text('Glømt passord?',
                      style: simpleStyle(),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: (){
                    signMeUp();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xFFFFB6C1),
                              const Color(0xFF0000FF),
                            ]
                        ),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text('Registrer ny konto', style: mediumStyle(),),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFFB6C1),
                            const Color(0xFFFFFFFF),
                          ]
                      ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text('Registrer ny konto med Google!', style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Allerede registrert? ', style: mediumStyle(),),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Logg inn her!', style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
