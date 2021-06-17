import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgi/core/core.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/home/home_page.dart';
import 'package:sgi/register/Widgets/app_bar_register_widget.dart';

class ManageAccess extends StatefulWidget {
  ManageAccess();

  @override
  _ManageAccessState createState() => _ManageAccessState();
}

class _ManageAccessState extends State<ManageAccess> {
  final TextEditingController _userProtheusController = TextEditingController();
  final TextEditingController _passwordProtheusController =
      TextEditingController();
  final TextEditingController _userGdiController = TextEditingController();
  final TextEditingController _passwordGdiController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Endereco endereco = new Endereco();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  bool _obscureTextPasswordProtheus = true;
  bool _obscureTextConfirmPasswordGDI = true;
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
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Gerenciar Acessos",
                      style: AppTextStyles.body30Black,
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Text(
                //     "Login",
                //     style: AppTextStyles.body16Blue,
                //   ),
                // )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 20, 0),
              child: Container(
                width: double.infinity,
                child: Text(
                  "Protheus",
                  style: AppTextStyles.body24Blue,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: TextField(
                controller: _userProtheusController,
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
                controller: _passwordProtheusController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.black,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: displayPasswordProtheus,
                    child: _obscureTextPasswordProtheus
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
                obscureText: _obscureTextPasswordProtheus,
                autocorrect: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 20, 0),
              child: Container(
                width: double.infinity,
                child: Text(
                  "GDI",
                  style: AppTextStyles.body24Blue,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: TextField(
                controller: _userGdiController,
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
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: TextField(
                controller: _passwordGdiController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.black,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: displayConfirmPasswordGDI,
                    child: _obscureTextConfirmPasswordGDI
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
                obscureText: _obscureTextConfirmPasswordGDI,
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
                    sincronizarAcessos();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    "Salvar",
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

  void displayPasswordProtheus() {
    setState(() {
      _obscureTextPasswordProtheus = !_obscureTextPasswordProtheus;
    });
  }

  void displayConfirmPasswordGDI() {
    setState(() {
      _obscureTextConfirmPasswordGDI = !_obscureTextConfirmPasswordGDI;
    });
  }

  Future sincronizarAcessos() async {
    FocusScope.of(context).unfocus();
    List retorno;
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post("${endereco.getEndereco}sinc_contas", data: {
        "usuario": _userProtheusController.text,
        "senha": _passwordProtheusController.text,
        "usuario2": _userGdiController.text,
        "senha2": _passwordGdiController.text
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        retorno = [
          "${response.data['idP']}",
          response.data['usuarioP'],
          response.data['senhaP'],
          response.data['mensagemP'],
          "${response.data['idG']}",
          response.data['usuarioG'],
          response.data['senhaG'],
          response.data['mensagemG']
        ];
        var mensagens = [
          [retorno[0], retorno[3]],
          [retorno[4], retorno[7]]
        ];
        if (retorno[0] != '1' && retorno[4] != '1') {
          statusSincronizacao(context, mensagens, 2, false);
        } else {
          statusSincronizacao(
            context,
            mensagens,
            2,
            true,
            userProtheus: retorno[0] == '1' ? _userProtheusController.text : '',
            userGdi: retorno[4] == '1' ? _userGdiController.text : '',
          );
        }
      } else {
        WidgetsUteis.exibeSnackBar(
            context, _scaffoldKey, "Não foi possível conectar");
      }
    } catch (e) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Não foi possível conectar");
      print(e);
    }
  }

  Future statusSincronizacao(
      BuildContext context, mensagens, quantLogs, continua,
      {userProtheus: '', userGdi: ''}) async {
    WidgetsUteis.showLoadingDialog(
        context, _keyLoader, 'Sincronizando contas...');
    await new Future.delayed(const Duration(seconds: 2));
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text('Status sincronização',
                  style: TextStyle(fontSize: 16.9)),
              content: Container(
                  width: double.maxFinite,
                  height: 300.0,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: quantLogs,
                    itemBuilder: (context, index) {
                      return Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: mensagens[index][0] == '1'
                                ? Icon(Icons.done, color: Colors.green)
                                : Icon(Icons.highlight_off, color: Colors.red),
                            title: Text(mensagens[index][1]),
                          ));
                    },
                  )),
              actions: <Widget>[
                TextButton(
                  child: Text("Voltar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Continuar"),
                  onPressed: () {
                    if (continua) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new TelaPrincipal(userProtheus, userGdi)));
                    } else {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      WidgetsUteis.exibeSnackBar(context, _scaffoldKey,
                          'Ao menos um sistema deve ser sincronizado para continuar!',
                          duracao: 3);
                    }
                  },
                )
              ],
            ));
      },
    );
  }
}
