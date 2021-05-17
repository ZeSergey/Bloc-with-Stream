import 'package:bloc_stream_example/color_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc with Stream',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorBloc _bloc = ColorBloc();
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc with Stream'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<Object>(
            stream: _bloc.outputStateStream,
            initialData: Colors.red,
            builder: (context, snapshot) {
              return AnimatedContainer(
                width: 100,
                height: 100,
                duration: Duration(milliseconds: 500),
                color: snapshot.data,
              );
            }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () => _bloc.inputEventSink.add(ColorEvent.event_red)),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () =>
                  _bloc.inputEventSink.add(ColorEvent.event_green)),
        ],
      ),
    );
  }
}
