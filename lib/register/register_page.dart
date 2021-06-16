import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgi/core/core.dart';
import 'package:sgi/core/uteis.dart';
import 'package:email_validator/email_validator.dart';
import 'Widgets/app_bar_register_widget.dart';

class Register extends StatefulWidget {
  static const String routeName = "/register";
  Register();

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Endereco endereco = new Endereco();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBarRegisterWidget(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Cadastro",
                      style: AppTextStyles.body30Black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: AppColors.black,
                  ),
                  hintText: 'E-mail',
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
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
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
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.black,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: displayPassword,
                    child: _obscureTextPassword
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
                obscureText: _obscureTextPassword,
                autocorrect: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: TextField(
                controller: _passwordConfirmController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.black,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: displayConfirmPassword,
                    child: _obscureTextConfirmPassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                  hintText: 'Confirmar Senha',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                cursorColor: Colors.blue,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
                obscureText: _obscureTextConfirmPassword,
                autocorrect: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
              child: SizedBox(
                height: 55, //height of button
                width: double.infinity, //width of button
                child: ElevatedButton(
                  onPressed: () {
                    criaUsuario();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(color: Colors.white, fontSize: 16.9),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void displayPassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void displayConfirmPassword() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  Future criaUsuario() async {
    FocusScope.of(context).unfocus();
    List retorno;
    if (_usuarioController.text.trim().length < 4) {
      WidgetsUteis.exibeSnackBar(context, _scaffoldKey,
          'Usuário deve possuir no mínimo 4 caracteres!');
    } else if (!EmailValidator.validate(_emailController.text.trim())) {
      WidgetsUteis.exibeSnackBar(context, _scaffoldKey, 'E-mail inválido!');
    } else if (_passwordController.text.trim().length < 4) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, 'Senha deve possuir no mínimo 4 caracteres!');
    } else if (_passwordController.text.trim() !=
        _passwordConfirmController.text.trim()) {
      WidgetsUteis.exibeSnackBar(context, _scaffoldKey, 'Senhas não conferem!');
    } else {
      WidgetsUteis.showLoadingDialog(context, _keyLoader, 'Aguarde...');
      await new Future.delayed(const Duration(seconds: 1));
      try {
        Response response;
        Dio dio = new Dio();
        response = await dio.post("${endereco.getEndereco}cria_usuario", data: {
          "usuario": _usuarioController.text.trim(),
          "senha": _passwordController.text.trim(),
          "email": _emailController.text.trim()
        });
        if (response.statusCode == 200 || response.statusCode == 201) {
          Navigator.of(context).pop();
          WidgetsUteis.exibeSnackBar(
              context, _scaffoldKey, response.data['mensagem']);

          if (response.data['id'] == 1) {
            await new Future.delayed(const Duration(seconds: 2));
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          }
          return retorno;
        } else {
          //If that response was not OK, throw an error.
          retorno = ['Falha ao conectar'];
        }
      } catch (e) {
        WidgetsUteis.exibeSnackBar(
            context, _scaffoldKey, "Não foi possível conectar");
        print(e);
      }
    }
    return retorno;
  }
}

//^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$
