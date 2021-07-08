import 'package:flutter/src/widgets/framework.dart';

import 'breakpoints.dart';
import 'colunas/colunas.dart';
import 'colunas/colunas_md.dart';

class Grid implements Colunas, ColunasMD {
  final Colunas _coluna;
  final ColunasMD _colunaMD;

  Grid(this._coluna, this._colunaMD);

  @override
  double get mobile => Breakpoints.mobile;
  @override
  double get tablet => Breakpoints.tablet;
  @override
  double get desktopLg => Breakpoints.desktopLg;
  @override
  double get desktopXl => Breakpoints.desktopXl;
  @override
  double get desktopXXl => Breakpoints.desktopXXl;

  @override
  double col_1({BuildContext context}) {
    // TODO: implement col_1
    throw UnimplementedError();
  }

  @override
  double col_10({BuildContext context}) {
    // TODO: implement col_10
    throw UnimplementedError();
  }

  @override
  double col_11({BuildContext context}) {
    // TODO: implement col_11
    throw UnimplementedError();
  }

  @override
  double col_12({BuildContext context}) {
    // TODO: implement col_12
    throw UnimplementedError();
  }

  @override
  double col_2({BuildContext context}) {
    // TODO: implement col_2
    throw UnimplementedError();
  }

  @override
  double col_3({BuildContext context}) {
    // TODO: implement col_3
    throw UnimplementedError();
  }

  @override
  double col_4({BuildContext context}) {
    // TODO: implement col_4
    throw UnimplementedError();
  }

  @override
  double col_5({BuildContext context}) {
    // TODO: implement col_5
    throw UnimplementedError();
  }

  @override
  double col_6({BuildContext context}) {
    // TODO: implement col_6
    throw UnimplementedError();
  }

  @override
  double col_7({BuildContext context}) {
    // TODO: implement col_7
    throw UnimplementedError();
  }

  @override
  double col_8({BuildContext context}) {
    // TODO: implement col_8
    throw UnimplementedError();
  }

  @override
  double col_9({BuildContext context}) {
    // TODO: implement col_9
    throw UnimplementedError();
  }

  @override
  colmd_1({BuildContext context}) {
    // TODO: implement colmd_1
    throw UnimplementedError();
  }

  @override
  colmd_10({BuildContext context}) {
    // TODO: implement colmd_10
    throw UnimplementedError();
  }

  @override
  colmd_11({BuildContext context}) {
    // TODO: implement colmd_11
    throw UnimplementedError();
  }

  @override
  colmd_12({BuildContext context}) {
    // TODO: implement colmd_12
    throw UnimplementedError();
  }

  @override
  colmd_2({BuildContext context}) {
    // TODO: implement colmd_2
    throw UnimplementedError();
  }

  @override
  colmd_3({BuildContext context}) {
    // TODO: implement colmd_3
    throw UnimplementedError();
  }

  @override
  colmd_4({BuildContext context}) {
    // TODO: implement colmd_4
    throw UnimplementedError();
  }

  @override
  colmd_5({BuildContext context}) {
    // TODO: implement colmd_5
    throw UnimplementedError();
  }

  @override
  colmd_6({BuildContext context}) {
    // TODO: implement colmd_6
    throw UnimplementedError();
  }

  @override
  colmd_7({BuildContext context}) {
    // TODO: implement colmd_7
    throw UnimplementedError();
  }

  @override
  colmd_8({BuildContext context}) {
    // TODO: implement colmd_8
    throw UnimplementedError();
  }

  @override
  colmd_9({BuildContext context}) {
    // TODO: implement colmd_9
    throw UnimplementedError();
  }

  @override
  bool isDesktopLg({BuildContext context}) {
    // TODO: implement isDesktopLg
    throw UnimplementedError();
  }

  @override
  bool isDesktopLgDOWN({BuildContext context}) {
    // TODO: implement isDesktopLgDOWN
    throw UnimplementedError();
  }

  @override
  bool isDesktopLgUP({BuildContext context}) {
    // TODO: implement isDesktopLgUP
    throw UnimplementedError();
  }

  @override
  bool isDesktopXXl({BuildContext context}) {
    // TODO: implement isDesktopXXl
    throw UnimplementedError();
  }

  @override
  bool isDesktopXXlDOWN({BuildContext context}) {
    // TODO: implement isDesktopXXlDOWN
    throw UnimplementedError();
  }

  @override
  bool isDesktopXXlUP({BuildContext context}) {
    // TODO: implement isDesktopXXlUP
    throw UnimplementedError();
  }

  @override
  bool isDesktopXl({BuildContext context}) {
    // TODO: implement isDesktopXl
    throw UnimplementedError();
  }

  @override
  bool isDesktopXlDOWN({BuildContext context}) {
    // TODO: implement isDesktopXlDOWN
    throw UnimplementedError();
  }

  @override
  bool isDesktopXlUP({BuildContext context}) {
    // TODO: implement isDesktopXlUP
    throw UnimplementedError();
  }

  @override
  bool isMobile({BuildContext context}) {
    // TODO: implement isMobile
    throw UnimplementedError();
  }

  @override
  bool isMobileDOWN({BuildContext context}) {
    // TODO: implement isMobileDOWN
    throw UnimplementedError();
  }

  @override
  bool isMobileUP({BuildContext context}) {
    // TODO: implement isMobileUP
    throw UnimplementedError();
  }

  @override
  bool isTablet({BuildContext context}) {
    // TODO: implement isTablet
    throw UnimplementedError();
  }

  @override
  bool isTabletDOWN({BuildContext context}) {
    // TODO: implement isTabletDOWN
    throw UnimplementedError();
  }

  @override
  bool isTabletUP({BuildContext context}) {
    // TODO: implement isTabletUP
    throw UnimplementedError();
  }

  @override
  double totalHeight({BuildContext context}) {
    // TODO: implement totalHeight
    throw UnimplementedError();
  }

  @override
  double totalWidth({BuildContext context}) {
    // TODO: implement totalWidth
    throw UnimplementedError();
  }

  // @override
  // double totalWidth({@required @required BuildContext context}) {
  //   return _coluna.totalWidth(context: context);
  // }

  // @override
  // double totalHeight({@required BuildContext context}) {
  //   return _coluna.totalHeight(context: context);
  // }

  // @override
  // bool isMobile({@required BuildContext context}) {
  //   return _coluna.isMobile(context: context);
  // }

  // @override
  // bool isMobileUP({@required BuildContext context}) {
  //   return _coluna.isMobileUP(context: context);
  // }

  // @override
  // bool isMobileDOWN({@required BuildContext context}) {
  //   return _coluna.isMobileDOWN(context: context);
  // }

  // @override
  // bool isTablet({@required BuildContext context}) {
  //   return _coluna.isTablet(context: context);
  // }

  // @override
  // bool isTabletUP({@required BuildContext context}) {
  //   return _coluna.isTabletUP(context: context);
  // }

  // @override
  // bool isTabletDOWN({@required BuildContext context}) {
  //   return _coluna.isTabletDOWN(context: context);
  // }

  // @override
  // bool isDesktopLg({@required BuildContext context}) {
  //   return _coluna.isDesktopLg(context: context);
  // }

  // @override
  // bool isDesktopLgUP({@required BuildContext context}) {
  //   return _coluna.isDesktopLgUP(context: context);
  // }

  // @override
  // bool isDesktopLgDOWN({@required BuildContext context}) {
  //   return _coluna.isDesktopLgDOWN(context: context);
  // }

  // @override
  // bool isDesktopXl({@required BuildContext context}) {
  //   return _coluna.isDesktopXl(context: context);
  // }

  // @override
  // bool isDesktopXlUP({@required BuildContext context}) {
  //   return _coluna.isDesktopXlUP(context: context);
  // }

  // @override
  // bool isDesktopXlDOWN({@required BuildContext context}) {
  //   return _coluna.isDesktopXlDOWN(context: context);
  // }

  // @override
  // bool isDesktopXXl({@required BuildContext context}) {
  //   return _coluna.isDesktopXXl(context: context);
  // }

  // @override
  // bool isDesktopXXlUP({@required BuildContext context}) {
  //   return _coluna.isDesktopXXlUP(context: context);
  // }

  // @override
  // bool isDesktopXXlDOWN({@required BuildContext context}) {
  //   return _coluna.isDesktopXXlDOWN(context: context);
  // }

  // @override
  // double col_1({@required BuildContext context}) {
  //   return _coluna.col_1(context: context);
  // }

  // @override
  // double col_2({@required BuildContext context}) {
  //   return _coluna.col_2(context: context);
  // }

  // @override
  // double col_3({@required BuildContext context}) {
  //   return _coluna.col_3(context: context);
  // }

  // @override
  // double col_4({@required BuildContext context}) {
  //   return _coluna.col_4(context: context);
  // }

  // @override
  // double col_5({@required BuildContext context}) {
  //   return _coluna.col_5(context: context);
  // }

  // @override
  // double col_6({@required BuildContext context}) {
  //   return _coluna.col_6(context: context);
  // }

  // @override
  // double col_7({@required BuildContext context}) {
  //   return _coluna.col_7(context: context);
  // }

  // @override
  // double col_8({@required BuildContext context}) {
  //   return _coluna.col_8(context: context);
  // }

  // @override
  // double col_9({@required BuildContext context}) {
  //   return _coluna.col_9(context: context);
  // }

  // @override
  // double col_10({@required BuildContext context}) {
  //   return _coluna.col_10(context: context);
  // }

  // @override
  // double col_11({@required BuildContext context}) {
  //   return _coluna.col_11(context: context);
  // }

  // @override
  // double col_12({@required BuildContext context}) {
  //   return _coluna.col_12(context: context);
  // }

  // @override
  // colmd_1({@required BuildContext context}) {
  //   return _colunaMD.colmd_1(context: context);
  // }

  // @override
  // colmd_2({@required BuildContext context}) {
  //   return _colunaMD.colmd_2(context: context);
  // }

  // @override
  // colmd_3({@required BuildContext context}) {
  //   return _colunaMD.colmd_3(context: context);
  // }

  // @override
  // colmd_4({@required BuildContext context}) {
  //   return _colunaMD.colmd_4(context: context);
  // }

  // @override
  // colmd_5({@required BuildContext context}) {
  //   return _colunaMD.colmd_5(context: context);
  // }

  // @override
  // colmd_6({@required BuildContext context}) {
  //   return _colunaMD.colmd_6(context: context);
  // }

  // @override
  // colmd_7({@required BuildContext context}) {
  //   return _colunaMD.colmd_7(context: context);
  // }

  // @override
  // colmd_8({@required BuildContext context}) {
  //   return _colunaMD.colmd_8(context: context);
  // }

  // @override
  // colmd_9({@required BuildContext context}) {
  //   return _colunaMD.colmd_9(context: context);
  // }

  // @override
  // colmd_10({@required BuildContext context}) {
  //   return _colunaMD.colmd_10(context: context);
  // }

  // @override
  // colmd_11({@required BuildContext context}) {
  //   return _colunaMD.colmd_11(context: context);
  // }

  // @override
  // colmd_12({@required BuildContext context}) {
  //   return _colunaMD.colmd_12(context: context);
  // }
}
