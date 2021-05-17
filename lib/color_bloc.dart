import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent { event_red, event_green }

class ColorBloc {
  Color _color = Colors.red;

  final _inputEventController = StreamController<ColorEvent>();
  StreamSink<ColorEvent> get inputEventSink => _inputEventController.sink;

  final _outputEventController = StreamController<Color>();
  Stream<Color> get outputStateStream => _outputEventController.stream;

  void _mapStateEvent(ColorEvent event) {
    if (event == ColorEvent.event_red)
      _color = Colors.red;
    else if (event == ColorEvent.event_green)
      _color = Colors.green;
    else
      throw Exception("Wrong Event Type");
    _outputEventController.sink.add(_color);
  }

  ColorBloc() {
    _inputEventController.stream.listen(_mapStateEvent);
  }

  void dispose() {
    _inputEventController.close();
    _outputEventController.close();
  }
}
