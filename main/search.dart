

import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain,
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(4284121292) ,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),

              child: Row(
                children: [
                  Expanded(child: TextField(
                    style: TextStyle(   // the color of the search input field
                      color: Colors.black87
                    ),
                    decoration: InputDecoration(
                      hintText: 'Søk etter brukernavn',
                      hintStyle: TextStyle(
                        color: Colors.white54
                      ),
                      border: InputBorder.none // Considering turning this on with another color

                    ),

                  )
                  ),
                  Icon(Icons.search)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
