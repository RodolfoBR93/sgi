class User {
  final int id;
  final String user;
  final String userProtheus;
  final String userGdi;
  final String acessoGerente;
  final String acessoSuper;
  final String acessoDiretor;
  final String cargoFin;
  final String gerenteFin;
  final String diretorFin;
  final String diretorAdm;
  final String gerenteTI;
  final String comprador;

  User(
      this.id,
      this.user,
      this.userProtheus,
      this.userGdi,
      this.acessoGerente,
      this.acessoSuper,
      this.acessoDiretor,
      this.cargoFin,
      this.gerenteFin,
      this.diretorFin,
      this.diretorAdm,
      this.gerenteTI,
      this.comprador);

  @override
  String toString() {
    return 'User{id: $id,user: $user, userProtheus: $userProtheus, userGdi: $userGdi, acessoGerente: $acessoGerente, acessoSuper: $acessoSuper, acessoDiretor: $acessoDiretor,cargoFin: $cargoFin, gerenteFin: $gerenteFin, diretorFin: $diretorFin, diretorAdm: $diretorAdm, gerenteTI: $gerenteTI, comprador: $comprador}';
  }

  String get getUser {
    return user;
  }

  String get getuserProtheus {
    return userProtheus;
  }

  String get getuserGdi {
    return userGdi;
  }

  String get getacessoGerente {
    return acessoGerente;
  }

  String get getacessoSuper {
    return acessoSuper;
  }

  String get getacessoDiretor {
    return acessoDiretor;
  }

  String get getCargoFin {
    return cargoFin;
  }

  String get getGerenteFin {
    return gerenteFin;
  }

  String get getDiretorFin {
    return diretorFin;
  }

  String get getDiretorAdm {
    return diretorAdm;
  }

  String get getGerenteTi {
    return gerenteTI;
  }

  String get getComprador {
    return comprador;
  }
}

// class User {

//   int _recno;
//   String _usuario;
//   String _senha;
//   String _usuProtheus;
//   String _senhaProtheus;
//   String _statusProtheus;
//   String _usuGnc;
//   String _senhaGnc;
//   String _statusGnc;
//   String _nome;
//   String _nreduz;
//   String _cargo;
//   String _telefone;
//   String _ramal;
//   String _matricula;

//   // criando um construtor
//   User(this._recno , this._usuario , this._senha , this._usuProtheus , this._senhaProtheus , this._statusProtheus , this._usuGnc , this._senhaGnc , this._statusGnc , this._nome , this._nreduz , this._cargo , this._telefone , this._ramal , this._matricula );

//   //mapeando o usuario para podermos acessar os valores do usuário
//   // utilizaremos dynamic, pois não sabemos o que é cada um
//   // criaremos outro construtor
//   User.map(dynamic obj) {
//     // quando passamos um nome ele já recebe como objeto
//     this._recno           = obj['recno'];
//     this._usuario         = obj['usuario'];
//     this._senha           = obj['senha'];
//     this._usuProtheus     = obj['usuProtheus'];
//     this._senhaProtheus   = obj['senhaProtheus'];
//     this._statusProtheus  = obj['statusProtheus'];
//     this._usuGnc          = obj['usuGnc'];
//     this._senhaGnc        = obj['senhaGnc'];
//     this._statusGnc       = obj['statusGnc'];
//     this._nome            = obj['nome'];
//     this._nreduz          = obj['nreduz'];
//     this._cargo           = obj['cargo'];
//     this._telefone        = obj['telefone'];
//     this._ramal           = obj['ramal'];
//     this._matricula       = obj['matricula'];
//   }

//   int get recno             => _recno == null? 0 : _recno;
//   String get usuario        => _usuario == null? '' : _usuario;
//   String get senha          => _senha == null? '' : _senha;
//   String get usuProtheus    => _usuProtheus == null? '' : _usuProtheus;
//   String get senhaProtheus  => _senhaProtheus == null? '' : _senhaProtheus;
//   String get statusProtheus => _statusProtheus == null? '' : _statusProtheus;
//   String get usuGnc         => _usuGnc == null? '' : _usuGnc;
//   String get senhaGnc       => _senhaGnc == null? '' : _senhaGnc;
//   String get statusGnc      => _statusGnc == null? '' : _statusGnc;
//   String get nome           => _nome == null? '' : _nome;
//   String get nreduz         => _nreduz == null? '' : _nreduz;
//   String get cargo          => _cargo == null? '' : _cargo;
//   String get telefone       => _telefone == null? '' : _telefone;
//   String get ramal          => _ramal == null? '' : _ramal;
//   String get matricula      => _matricula == null? '' : _matricula;

//   // o map irá acessar uma key, como string, e depois uma chave que eu deseje
//   Map<String, dynamic> toMap() {
//     //instanciando o mapa
//     var mapa = new Map<String, dynamic>();
//     // agora iremos fazer o inverso do anterior, iremos colocar o conteúdo
//     // dos atributos no mapa, ficará como se fosse um json
//     mapa["recno"] = _recno;
//     mapa["usuario"] = _usuario;
//     mapa["senha"] = _senha;
//     mapa["usuProtheus"] = _usuProtheus;
//     mapa["senhaProtheus"] = _senhaProtheus;
//     mapa["statusProtheus"] = _statusProtheus;
//     mapa["usuGnc"] = _usuGnc;
//     mapa["senhaGnc"] = _senhaGnc;
//     mapa["statusGnc"] = _statusGnc;
//     mapa["nome"] = _nome;
//     mapa["nreduz"] = _nreduz;
//     mapa["cargo"] = _cargo;
//     mapa["telefone"] = _telefone;
//     mapa["ramal"] = _ramal;
//     mapa["matricula"] = _matricula;

//     return mapa;
//   }

//   User.fromMap(Map<String, dynamic> mapa) {
//     this._recno           = mapa['recno'];
//     this._usuario         = mapa['usuario'];
//     this._senha           = mapa['senha'];
//     this._usuProtheus     = mapa['usuProtheus'];
//     this._senhaProtheus   = mapa['senhaProtheus'];
//     this._statusProtheus  = mapa['statusProtheus'];
//     this._usuGnc          = mapa['usuGnc'];
//     this._senhaGnc        = mapa['senhaGnc'];
//     this._statusGnc       = mapa['statusGnc'];
//     this._nome            = mapa['nome'];
//     this._nreduz          = mapa['nreduz'];
//     this._cargo           = mapa['cargo'];
//     this._telefone        = mapa['telefone'];
//     this._ramal           = mapa['ramal'];
//     this._matricula       = mapa['matricula'];
//   }

// }
