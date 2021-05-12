import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Snake());
  }
}

class Snake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: GameField()),
    );
  }
}

enum PixelTypes { Emty, Snake, Eat }

class PixelPosition {
  int x;
  int y;
  PixelPosition(this.x,this.y);
}

class GameField extends StatefulWidget {
  @override
  _GameFieldState createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  int columnLen = 16;

  int rowLen = 24;

  List<List<PixelTypes>> fields = [];

  PixelPosition snakeHead = PixelPosition(0,2);

  PixelPosition snakeButt = PixelPosition(0,0);

  List<PixelPosition> snake = [];

  initFields() {
    if (fields.length == 0) {
      for (int i = 0; i < rowLen; i++) {
        List<PixelTypes> pixels = [];
        for (int j = 0; j < columnLen; j++) {
          pixels.add(PixelTypes.Emty);
        }
        fields.add(pixels);
      }
    createObj();
    }
    print(fields);
  }

  createObj() {
    fields[snakeHead.y][snakeHead.x] = PixelTypes.Snake;
    fields[13][10] = PixelTypes.Eat;
    snake.add(PixelPosition(snakeHead.x, snakeHead.y));
  }

  paintHead(){
    fields[snakeHead.y][snakeHead.x] = PixelTypes.Snake;
    snake.add(PixelPosition(snakeHead.x, snakeHead.y));
  }

  emptyButt(){
    if(snake.length>3){
      fields[snake.first.y][snake.first.x] = PixelTypes.Emty;
      snake.removeAt(0);
    }
  }

  getColor(PixelTypes type) {
    switch (type) {
      case PixelTypes.Snake:
        return Colors.grey[800];
      case PixelTypes.Emty:
        return Colors.grey[300];
      case PixelTypes.Eat:
        return Colors.red[800];
      default:
        return Colors.grey[300];
    }
  }

  

  List<Widget> buildField() {
    initFields();
    paintHead();
    List<Widget> _fields = [];
    for (int i = 0; i < fields.length; i++) {
      List<Widget> widgets = [];
      fields[i].forEach((element) {
        widgets.add(Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: 21,
            height: 21,
            color: getColor(element),
          ),
        ));
      });
      _fields.add(Row(
        children: widgets,
      ));
    }

    return _fields;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Container(
          width: 400,
          height: 600,
          color: Colors.grey[200],
          child: Column(
            children: buildField(),
          ),
        ),
        Spacer(),
        Container(
          color: Colors.red,
          width: 300,
          height: 300,
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                child: IconButton(
                  onPressed: () {
                    emptyButt();
                    snakeHead.y -= 1;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.arrow_upward,
                    size: 100,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: IconButton(
                      onPressed: () {
                        emptyButt();
                        snakeHead.x -= 1;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.arrow_left,
                        size: 100,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 100,
                    width: 100,
                    child: IconButton(
                      onPressed: () {
                        emptyButt();
                        snakeHead.x += 1;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.arrow_right,
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 100,
                width: 100,
                child: IconButton(
                  onPressed: () {
                    emptyButt();
                    snakeHead.y += 1;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.arrow_downward,
                    size: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
        Spacer()
      ],
    );
  }
}
