import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:products_app/core/ui/theme/theme_bloc/theme_event.dart';
import 'package:products_app/core/ui/theme/theme_bloc/theme_state.dart';
import '../app_themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: appThemeData[AppTheme.LightTheme]));

  @override
  ThemeState get initialState =>
  ThemeState(themeData: appThemeData[AppTheme.LightTheme]);

  @override
  Stream<ThemeState> mapEventToState(
      ThemeEvent event,
      ) async* {
    if (event is ThemeChanged) {
      yield ThemeState(themeData: appThemeData[event.theme]);
    }
  }
}