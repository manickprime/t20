import 'dart:async';

class ThemeBloc {
  // ignore: close_sinks
  final _themeStreamController = StreamController<bool>();
  get changeTheTheme => _themeStreamController.sink.add;
  get darkThemeIsEnabled => _themeStreamController.stream;
}
