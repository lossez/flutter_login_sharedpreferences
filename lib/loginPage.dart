import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'dataAssisten.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool _showPassword = false;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _loginCheck(String _username, String _password) {
    dataAssisten.forEach((element) async {
      if (element['UserName'] == _username &&
          element['PassWord'] == _password) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', _username);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => dashboard()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Username",
              style: TextStyle(color: Colors.grey),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter Username'),
              controller: _usernameController,
            ),
            SizedBox(height: 50),
            Text(
              "Password",
              style: TextStyle(color: Colors.grey),
            ),
            TextField(
                obscureText: !this._showPassword,
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: 'Enter Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: this._showPassword ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(
                            () => this._showPassword = !this._showPassword);
                      },
                    ))),
            Container(
              padding: EdgeInsets.only(top: 15),
              alignment: Alignment.centerRight,
              child: Text("Forgot password?"),
            ),
            SizedBox(height: 50),
            Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: () => _loginCheck(
                      _usernameController.text,
                      _passwordController
                          .text) // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => dashboard())),
                  ),
            ),
          ],
        ),
      )),
    );
  }
}
