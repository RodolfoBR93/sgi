import 'package:flutter/material.dart';
import 'package:sgi/core/app_images.dart';
import 'package:sgi/core/core.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/models/user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'Widgets/app_bar_register_widget.dart';
import 'package:sgi/login/access_code_page.dart';

class SendMail extends StatefulWidget {
  final String user;
  final String email;
  SendMail(this.user, this.email);

  @override
  _SendMailState createState() => _SendMailState(user, email);
}

class _SendMailState extends State<SendMail> {
  final String user;
  final String email;
  final UserDao _dao = UserDao();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _SendMailState(this.user, this.email);

  @override
  void initState() {
    if (!kIsWeb) {
      _dao.delete();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarRegisterWidget(),
      body: Container(
          color: Colors.white,
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  //height: MediaQuery.of(context).size.height / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(AppImages.email_sent),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: RichText(
                  text: TextSpan(
                      text: "Código de verificação enviado para o E-mail:",
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: RichText(
                  text: TextSpan(
                      text: email,
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                  child: SizedBox(
                    //height: 55, //height of button
                    width: double.infinity, //width of button
                    child: ElevatedButton(
                      onPressed: () {
                        _onWillPop(user);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 3,
                          primary: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 16.9),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _onWillPop(String _user) {
    //final User newUser = User(0, _user, '', '','','','','','','','','','');
    //_dao.save(newUser);
    // Navigator.of(context)
    //     .pushNamedAndRemoveUntil('/accescode', (Route<dynamic> route) => false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccessCode(_user)),
    );
  }
}
