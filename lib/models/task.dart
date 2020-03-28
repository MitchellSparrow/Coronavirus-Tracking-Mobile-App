import 'package:flutter/material.dart';

///This class describes the entity for the pie chart
///Each entity of the pie chart has a name, a value
///and a colour

class Task {
  String task;
  int taskValue;
  Color colorValue;
  Task(this.task, this.taskValue, this.colorValue);
}
