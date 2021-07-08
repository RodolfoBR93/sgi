import 'package:flutter/material.dart';
import 'package:sgi/shared/grid/breakpoints.dart';

class ScreenSize {
  bool isMobile({@required BuildContext context}) {
    return MediaQuery.of(context).size.width <= Breakpoints.mobile;
  }

  bool isMobileUP({@required BuildContext context}) {
    return MediaQuery.of(context).size.width >= Breakpoints.mobile;
  }

  bool isMobileDOWN({@required BuildContext context}) {
    return MediaQuery.of(context).size.width <= Breakpoints.mobile;
  }

  bool isTablet({@required BuildContext context}) {
    return MediaQuery.of(context).size.width > Breakpoints.mobile &&
        MediaQuery.of(context).size.width <= Breakpoints.tablet;
  }

  bool isTabletUP({@required BuildContext context}) {
    return MediaQuery.of(context).size.width >= Breakpoints.tablet;
  }

  bool isTabletDOWN({@required BuildContext context}) {
    return MediaQuery.of(context).size.width <= Breakpoints.tablet;
  }

  bool isDesktopLg({@required BuildContext context}) {
    return MediaQuery.of(context).size.width > Breakpoints.tablet &&
        MediaQuery.of(context).size.width <= Breakpoints.desktopLg;
  }

  bool isDesktopLgUP({@required BuildContext context}) {
    return MediaQuery.of(context).size.width >= Breakpoints.desktopLg;
  }

  bool isDesktopLgDOWN({@required BuildContext context}) {
    return MediaQuery.of(context).size.width <= Breakpoints.desktopLg;
  }

  bool isDesktopXl({@required BuildContext context}) {
    return MediaQuery.of(context).size.width > Breakpoints.desktopLg &&
        MediaQuery.of(context).size.width <= Breakpoints.desktopXl;
  }

  bool isDesktopXlUP({@required BuildContext context}) {
    return MediaQuery.of(context).size.width >= Breakpoints.desktopXl;
  }

  bool isDesktopXlDOWN({@required BuildContext context}) {
    return MediaQuery.of(context).size.width <= Breakpoints.desktopXl;
  }

  bool isDesktopXXl({@required BuildContext context}) {
    return MediaQuery.of(context).size.width > Breakpoints.desktopXl &&
        MediaQuery.of(context).size.width <= Breakpoints.desktopXXl;
  }

  bool isDesktopXXlUP({@required BuildContext context}) {
    return MediaQuery.of(context).size.width >= Breakpoints.desktopXXl;
  }

  bool isDesktopXXlDOWN({@required BuildContext context}) {
    return MediaQuery.of(context).size.width <= Breakpoints.desktopXXl;
  }

  double totalWidth({@required BuildContext context}) {
    return MediaQuery.of(context).size.width;
  }

  double totalHeight({@required BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }
}
