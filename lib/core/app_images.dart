class AppImages {
  static String get logoColorida => "assets/images/logo_colorida.png";
  static String get logoBranca => "assets/images/logo_branca.png";
  static String get verify => "assets/images/verify.png";
  static String get otp => "assets/images/otp.gif";
  static String get asa_circular => "assets/images/LogoCircular_Asa.png";
  static String get mcd_circular =>
      "assets/images/LogoCircular_MaceioDistribuidora.png";
  static String get mslog_circular => "assets/images/LogoCircular_MsLog.png";
  static String get cose_circular => "assets/images/LogoCircular_Cose.png";

  // static String get logoAsa => asa_circular;
  // static String get logoMcd => mcd_circular;
  // static String get logMslog => mslog_circular;
  // static String get logoCose => cose_circular;

  static String getImage(String empresa) {
    String image;
    switch (empresa) {
      case '01':
        {
          image = asa_circular;
        }
        break;
      case '03':
        {
          image = mslog_circular;
        }
        break;
      case '08':
        {
          image = mcd_circular;
        }
        break;
      case '0117':
        {
          image = cose_circular;
        }
        break;
      case '15':
        {
          image = asa_circular;
        }
        break;
      case '16':
        {
          image = asa_circular;
        }
        break;
    }
    return image;
  }
}
