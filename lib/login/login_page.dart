import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/database/dao/user_web._dao.dart';
import 'package:sgi/home/home_page.dart';
import 'package:sgi/login/widgets/app_bar_login_widget.dart';
import 'package:sgi/core/core.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/register/register_page.dart';
import 'access_code_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Login extends StatefulWidget {
  static const String routeName = "/login";
  Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Endereco endereco = new Endereco();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  bool _obscureText = true;
  double screenHeight;
  double screenWidth;
  final UserDao _dao = UserDao();
  UserWebDao userWebDao = UserWebDao();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBarLoginWidget(screenHeight, screenWidth),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                    child: TextField(
                      controller: _usuarioController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: AppColors.black,
                        ),
                        hintText: 'Usuário',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      cursorColor: Colors.blue,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      autocorrect: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColors.black,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: displayPassword,
                          child: _obscureText
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                        hintText: 'Senha',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      cursorColor: Colors.blue,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      obscureText: _obscureText,
                      autocorrect: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 50, //height of button
                      width: double.infinity, //width of button
                      child: ElevatedButton(
                        onPressed: () {
                          logar();
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
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Cadastro()),
                      // );
                    },
                    child: Text(
                      "Esqueci minha senha",
                      style: AppTextStyles.body15,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(gradient: AppGradients.rodape),
                  child: Column(children: [
                    Text(
                      "Ainda não possui cadastro?",
                      style: AppTextStyles.body16White,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 55, //height of button
                      width: 200, //width of button
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                        child: Text(
                          "Cadastre-se",
                          style: TextStyle(color: AppColors.blue, fontSize: 20),
                        ),
                      ),
                    )
                  ]),
                ))
          ],
        ),
      ),
    );
  }

  void displayPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void logar() async {
    FocusScope.of(context).unfocus();
    if (_usuarioController.text.length <= 3) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Insira um usuário válido!", screenWidth);
      await new Future.delayed(const Duration(seconds: 2));
    } else if (_passwordController.text.length <= 3) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Insira uma senha válida!", screenWidth);
      await new Future.delayed(const Duration(seconds: 2));
    } else {
      await getLogin(_usuarioController.text, _passwordController.text);
    }
  }

  Future<int> getLogin(String usuario, String senha) async {
    WidgetsUteis.showLoadingDialog(context, _keyLoader, "Aguarde...");
    await new Future.delayed(const Duration(seconds: 1));
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post("${endereco.getEndereco}login",
          data: {"usuario": usuario, "senha": senha});
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pop();
        if (response.data["status"] == 'FFF') {
          WidgetsUteis.exibeSnackBar(
              context,
              _scaffoldKey,
              "Primeiro acesso, será necessário conectar suas contas!",
              screenWidth);
          await new Future.delayed(const Duration(seconds: 3));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccessCode()),
          );
        } else if (response.data["status"] == 'F') {
          WidgetsUteis.exibeSnackBar(
              context, _scaffoldKey, "Usuário não encontrado!", screenWidth);
        } else if (response.data["status"] == 'FF') {
          WidgetsUteis.exibeSnackBar(context, _scaffoldKey,
              "Senha incorreta para este usuário!", screenWidth);
        } else {
          if (!kIsWeb) {
            _dao.delete();
          }

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => new HomePage(
                  usuario,
                  response.data["usuProt"],
                  response.data["usuGnc"],
                  response.data["acessoGerente"],
                  response.data["acessoSuper"],
                  response.data["acessoDiretor"],
                  response.data["cargoFin"],
                  response.data["gerenteFin"],
                  response.data["diretorFin"],
                  response.data["diretorAdm"],
                  response.data["gerenteTI"],
                  response.data["comprador"])));
        }
      } else {
        Navigator.of(context).pop();
        WidgetsUteis.exibeSnackBar(
            context, _scaffoldKey, 'Falha ao conectar!', screenWidth);
      }

      return response.statusCode;
    } catch (e) {
      Navigator.of(context).pop();
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, 'Falha ao conectar!', screenWidth);
      print(e);
    }
    return 0;
  }

  // salvaUsuario(String valor, String valor2) async {
  //   int rec = int.parse(valor2.trim());
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('usuario', valor);
  //   prefs.setInt('usuApp', rec);
  // }

}
