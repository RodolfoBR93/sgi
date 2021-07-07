import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sgi/core/uteis.dart';
import 'package:money2/money2.dart';
import 'package:intl/intl.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/models/user.dart';

Future<List> getPayments(String usuario, String cargo, String autocomo,
    String bPendente, List empresa) async {
  final UserDao _dao = UserDao();
  Response response;
  Dio dio = new Dio();
  List acessos = [];
  int nQtdTit = 0;
  String nomefor = "",
      vencimento = "",
      tipo = "",
      prefixo = "",
      numero = "",
      parcela = "",
      recno = "",
      titpai = "",
      fornece = "",
      loja = "",
      codfil = "",
      nomefil = "",
      cgc = "",
      ie = "",
      cc = "",
      natureza = "",
      historico = "",
      qtdparc = "",
      vale = "",
      emissao = "",
      usulanc = "",
      dtlanc = "",
      ger = "",
      sup = "",
      dir = "",
      supfin = "",
      gerfin = "",
      datager = "",
      datasup = "",
      datadir = "",
      datasupfin = "",
      datagerfin = "",
      quantger = "",
      quantsup = "",
      quantdir = "",
      quantgerfin = "",
      quantsupfin = "",
      endfor = "";

  List titulos = [];
  List impostos = [];
  List dadosAdicionais = [];
  List retorno = [];
  List rateio;
  Endereco endereco = new Endereco();
  try {
    // response =
    //     await dio.post("${endereco.getEndereco}cc", data: {"usuario": usuario});
    //if (response.statusCode == 200 || response.statusCode == 201) {
      List<User> user = await _dao.findAll();
      if(autocomo=='G'){
        acessos.add(user[0].getacessoGerente.toString());
        acessos.add(user[0].getCargoFin.toString());
      }else if(autocomo=='S'){
        acessos.add(user[0].getacessoSuper.toString());
        acessos.add(user[0].getCargoFin.toString());
      }else if(autocomo=='D'){
        acessos.add(user[0].getacessoDiretor.toString());
        acessos.add(user[0].getCargoFin.toString());
      }
      
      for (int i = 0; i < empresa.length; i++) {
        response = await dio.post("${endereco.getEndereco}titulos", data: {
          "usuario": usuario,
          "cargofin": acessos[1],
          "autocomo": autocomo,
          "astatcc": acessos[0],
          "bpendente": bPendente,
          "empresa": empresa[i][0],
          "diradm": '1' //deve trazer no array acessos
        });
        if (response.statusCode == 200 || response.statusCode == 201) {
          nQtdTit = response.data["qtdtit"];
          //debugPrint(response.data.toString());
          for (int i = 0; i < nQtdTit; i++) {
            vencimento = response.data["titulos"][i]["vencimento"];
            vencimento = vencimento.substring(6, 8) +
                "/" +
                vencimento.substring(4, 6) +
                "/" +
                vencimento.substring(0, 4);
            nomefor =
                response.data["titulos"][i]["nomefor"] + "                    ";
            tipo = response.data["titulos"][i]["tipo"] + " ";
            tipo = tipo.substring(0, 3);
            prefixo = response.data["titulos"][i]["prefixo"] + " ";
            prefixo = prefixo.substring(0, 3);
            parcela = response.data["titulos"][i]["parcela"] + "  ";
            parcela = parcela.substring(0, 3);
            numero = response.data["titulos"][i]["numero"] + "  ".trim();
            recno = response.data["titulos"][i]["recno"];
            titpai = response.data["titulos"][i]["titpai"];
            fornece = response.data["titulos"][i]["fornecedor"];
            loja = response.data["titulos"][i]["loja"];
            codfil = response.data["titulos"][i]["codfil"];
            nomefil = response.data["titulos"][i]["nomefil"];
            cgc = response.data["titulos"][i]["cgc"];
            ie = response.data["titulos"][i]["ie"];
            endfor = response.data["titulos"][i]["endereco"];
            cc = response.data["titulos"][i]["cc"];
            natureza = response.data["titulos"][i]["natureza"] +
                " " +
                response.data["titulos"][i]["natdesc"];
            historico = response.data["titulos"][i]["historico"];
            qtdparc = response.data["titulos"][i]["qtdparc"];
            vale = response.data["titulos"][i]["vale"];
            emissao = response.data["titulos"][i]["emissao"];
            usulanc = response.data["titulos"][i]["matfil"];
            dtlanc = response.data["titulos"][i]["dtlanc"];
            ger = response.data["titulos"][i][
                "aprovger"]; // == ''? 'gerente.teste' : response.data["titulos"][i]["aprovger"];
            sup = response.data["titulos"][i]["aprovsup"];
            dir = response.data["titulos"][i]["aprovdir"];
            supfin = response.data["titulos"][i]["aprovsfin"];
            gerfin = response.data["titulos"][i]["aprovgfin"];
            emissao = emissao.substring(6, 8) +
                '/' +
                emissao.substring(4, 6) +
                '/' +
                emissao.substring(0, 4);
            dtlanc = dtlanc.substring(6, 8) +
                '/' +
                dtlanc.substring(4, 6) +
                '/' +
                dtlanc.substring(0, 4);
            //usulanc = usulanc ==''?'usuario.teste' : usulanc;
            datager = response.data["titulos"][i][
                "aprovhg"]; // == '' ? '01/01/2019' : response.data["titulos"][i]["aprovhg"];
            datasup = response.data["titulos"][i][
                "aprovhs"]; //== '' ? '01/01/2019' : response.data["titulos"][i]["aprovhs"];
            datadir = response.data["titulos"][i][
                "aprovhd"]; // == '' ? '01/01/2019' : response.data["titulos"][i]["aprovhd"];
            datasupfin = response.data["titulos"][i][
                "aprovhsf"]; // == '' ? '01/01/2019' : response.data["titulos"][i]["aprovgfin"];
            datagerfin = response.data["titulos"][i][
                "aprovhgf"]; //== '' ? '01/01/2019' :response.data["titulos"][i]["aprovgfin"] ;
            quantger = response.data["titulos"][i]["quantger"];
            quantsup = response.data["titulos"][i]["quantsup"];
            quantdir = response.data["titulos"][i]["quantdir"];
            quantgerfin = response.data["titulos"][i]["quantgerfin"];
            quantsupfin = response.data["titulos"][i]["quantsupfin"];
            rateio=[];
            for(int rat = 0; rat < response.data["titulos"][i]["rateio"].length; rat++){
              if(response.data["titulos"][i]["rateio"][rat].length>0){
                rateio.add([response.data["titulos"][i]["rateio"][rat]["cc"],response.data["titulos"][i]["rateio"][rat]["percentual"],"R\$ " + formatMoney("${response.data["titulos"][i]["rateio"][rat]["valor"]}")]);
              }
            }
            if (cgc.length == 0) {
              // cgc = 'CNPJ: 19.219.981/0001-90';
              // ie = 'IE: 248565257';
            } else {
              cgc = cgc.length == 14
                  ? 'CNPJ: ' +
                      cgc.substring(0, 2) +
                      '.' +
                      cgc.substring(2, 5) +
                      '.' +
                      cgc.substring(5, 8) +
                      '/' +
                      cgc.substring(8, 12) +
                      '-' +
                      cgc.substring(12, 14)
                  : 'CPF: ' +
                      cgc.substring(0, 3) +
                      '.' +
                      cgc.substring(3, 6) +
                      '.' +
                      cgc.substring(6, 9) +
                      '-' +
                      cgc.substring(9, 11);
            }
            // if(endfor == 'End.: -      /'){
            //   endfor = 'End.: Avenida Pedro Cícero, 605 - Centro     Taquarana/AL';
            // }
            if (titpai == '') {
              titulos.add([
                recno,
                "Fornecedor: " + fornece + " " + loja + " - " + nomefor,
                false,
                titpai,
                prefixo + numero + parcela + tipo + fornece + loja,
                response.data["empresa"]
              ]);
              // DateTime dueDate =
              //     new DateFormat("dd/MM/yyyy").parse(vencimento);
              //     //DateTime dueDate =
              //     new DateFormat("dd/MM/yyyy").parse(vencimento);
              //     Duration days = new Duration(days: 3);
                  
              //     dueDate.add(days);
              //     //dueDate.difference(other)
              dadosAdicionais.add([ 
                tipo,
                prefixo,
                numero,
                parcela,
                " R\$ " +
                    formatMoney("${response.data["titulos"][i]["saldo"]}"),
                vencimento,
                codfil,
                nomefil,
                cgc + "          " + ie,
                endfor,
                cc,
                natureza,
                historico,
                qtdparc,
                vale,
                emissao,
                usulanc,
                dtlanc,
                ger,
                sup,
                dir,
                gerfin,
                supfin,
                datager,
                datasup,
                datadir,
                datagerfin,
                datasupfin,
                quantger,
                quantsup,
                quantdir,
                quantgerfin,
                quantsupfin,
                response.data["titulos"][i]["statusVenc"],
                response.data["titulos"][i]["statusMensagem"],
                response.data["titulos"][i]["diasVenc"],
                prefixo+numero+parcela+tipo+fornece + loja,
                rateio
              ]);
            } else {
              impostos.add([titpai,prefixo+numero+parcela+tipo," R\$ " +formatMoney("${response.data["titulos"][i]["saldo"]}")]);
            }
          }
          for (int i = 0; i < impostos.length; i++) {
            for (int j = 0; j < titulos.length; j++) {
              if (impostos[i][0] == titulos[j][4]) {
                titulos[j][4] = "impostos";
              } else {
                //debugPrint(impostos[i]);
                //debugPrint(titulos[j][4]);
              }
            }
          }
        } else {
          //debugPrint('Failed to load post');
        }
      }
      retorno.add(titulos);
      retorno.add(dadosAdicionais);
      retorno.add(impostos);
      return retorno;
    //} else {
      //If that response was not OK, throw an error.
    //  debugPrint('Failed to load post');
   // }
  } catch (e) {
    print("Falha ao conectar");
    //titulos.add("nok");
    retorno.add(titulos);
    retorno.add(dadosAdicionais);
    return retorno;
  }
}

// Future<List> getRights(String usuario) async {
//   Endereco endereco = new Endereco();
//   List dados = [];
//   try {
//     Response response;
//     Dio dio = new Dio();

//     response =
//         await dio.post("${endereco.getEndereco}cc", data: {"usuario": usuario});
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       dados.add(response.data["gerente"]);
//       dados.add(response.data["super"]);
//       dados.add(response.data["diretor"]);
//       dados.add(response.data["cargofin"]);
//       return dados;
//     } else {
//       //If that response was not OK, throw an error.
//       return dados;
//     }
//   } catch (e) {
//     print(e);
//   }
//   return dados;
// }

String formatMoney(String val) {
  double saldo = double.parse(val);
  String ret = formatValue(saldo);
  String aux;
  int len;
  String accumulator = '';
  int start;
  if (ret.contains('.')) {
    ret = ret.replaceAll(".", ",");
  } else {
    ret = ret + ',00';
  }
  aux = ret.substring(0, ret.length - 3);
  len = aux.length;
  start = aux.length;
  while (start > 3) {
    accumulator = '.' + aux.substring(start - 3, start) + accumulator;
    start -= 3;
  }
  accumulator = aux.substring(0, start) + accumulator;
  debugPrint(accumulator + ret.substring(ret.length - 3, ret.length));
  return accumulator + ret.substring(ret.length - 3, ret.length);
}

String formatValue(double n) {
  String ret;
  ret = n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);

  return ret;
}
