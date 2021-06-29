import 'package:flutter/material.dart';
import 'package:chat_app/widgets/widget.dart';


class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);




  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: simpleStyle(),
                    decoration: textFieldInputDecoration('e-mail eller brukernavn')
                ),
                TextField(
                  style: simpleStyle(),
                  decoration: textFieldInputDecoration('password'
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
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFF0000),
                        const Color(0xFF6A0DAD),
                      ]
                    ),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text('Logg inn', style: mediumStyle(),),
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
                  child: Text('Logg inn med Google!', style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ny bruker? ', style: mediumStyle(),),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Registrer nå!', style: TextStyle(
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
