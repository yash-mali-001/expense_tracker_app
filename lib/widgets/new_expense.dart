import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onAddExpense, super.key});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController =
      TextEditingController(); //TextEditingController must be deleted as soon as build method finishes ,,,  hence we add dispose methode
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    //showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now).then((value) => null);    //then method will execute once a date is being picked ...i.e in future

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount =
        double.tryParse(_amountController.text); // String to double
    final amountIsInvalid = enteredAmount == null || enteredAmount < 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //Show error msg
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text("Invalid Input"),
                content: const Text(
                    "Please enter a valid Title , Amount , Date and Category"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("OK"),
                  )
                ],
              ));
    } else {
      widget.onAddExpense(
        Expense(
            amount: enteredAmount,
            title: _titleController.text,
            category: _selectedCategory,
            date: _selectedDate!),
      );
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              children: [
                //Amount
                Expanded(
                  // TextField Widget also causes problem when it is present inside a row regarding width
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixText: '\u{20B9} ',
                        label: Text(
                          'Amount',
                        )),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),

                // Date
                Expanded(
                  //Row inside another row causes a problem hence it must be wrapped with Expanded widget
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'Select a Date'
                          : formatter.format(
                              _selectedDate!)), // ! we force dart to assume it that the value wont be null
                      IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month_outlined))
                    ],
                  ),
                ),
                // date picker
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    //It id a button that displays the list of items when clicked
                    //values is the list of enum values
                    items: Category.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase().toString()),
                      );
                    }).toList(),

                    //Function that should be executed when button is pressed is passed to onChanged
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    }),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                        context); //Pop removes overlay from the screen
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('ADD'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
