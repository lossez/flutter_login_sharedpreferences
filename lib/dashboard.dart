import 'package:flutter/material.dart';
import 'package:ilab_mobile/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dataAssisten.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  var data;
  var firstName;
  String mystring = "the quick brown fox";

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('username');
    dataAssisten.forEach((element) {
      if (element['UserName'] == user) {
        setState(() {
          data = element;
          var getName = element['FullName'];
          var newString = getName.toString().split(" ").toList();
          firstName = newString;
        });
      }
    });
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => loginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hai, " + firstName[0],
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: _profileModal,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(),
    );
  }

  void _profileModal() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.only()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 25,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: Container(
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2.5)),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/profile/profile.png'),
                    ),
                    title: Text(data['FullName']),
                    subtitle: Text(data['UserName']),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(13, 0, 13, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 20,
                        ),
                        Text("My Profile")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(13, 0, 13, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20,
                        ),
                        FlatButton(onPressed: logout, child: Text('Logout'))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
