import 'package:equatable/equatable.dart';


import '../app_themes.dart';


abstract class ThemeEvent extends Equatable {

  @override
  List props = const [];
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged({this.theme}) ;
}