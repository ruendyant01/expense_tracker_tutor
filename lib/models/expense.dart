import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';


const uuid = Uuid();

enum Category {
  food,
  live,
  fashion
}

const iconsFromCategory = {
  Category.food: Icons.lunch_dining,
  Category.fashion: Icons.movie,
  Category.live: Icons.flight_takeoff
};

class Expense {
  Expense({required this.title, required this.amount, required this.category, required this.date}) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  String get formattedDate {
    return DateFormat('dd-MM-yyyy').format(date);
  }
}