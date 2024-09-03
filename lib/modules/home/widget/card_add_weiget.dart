import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardAddWeiget extends StatefulWidget {
  const CardAddWeiget({
    super.key,
    required this.addCard,
  });
  final Function addCard;

  @override
  State<CardAddWeiget> createState() => _CardAddWeigetState();
}

class _CardAddWeigetState extends State<CardAddWeiget> {
  final _contentController = TextEditingController();
  final _timeBeginController = TextEditingController();
  final _timeEndController = TextEditingController();
  String? _contentErorr = "Xin mời nhập việc cần làm";
  String? _timeBeginError = "Format 'dd/MM/yyyy'";
  String? _timeEndError = "Format 'dd/MM/yyyy'";
  // kiểm tra thời gian thỏa mãn
  bool _isValidDate(String input, String format) {
    try {
      final dateFormat = DateFormat(format);
      dateFormat.parseStrict(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  void _checkContent() {
    setState(() {
      if (_contentController.text.trim() == "") {
        _contentErorr = "Xin mời nhập việc cần làm";
      } else {
        _contentErorr = null;
      }
    });
  }

  void _checkTime(String time, int type) {
    setState(() {
      if (type == 0) {
        if (_isValidDate(time, "dd/MM/yyyy")) {
          _timeBeginError = null;
        } else {
          _timeBeginError = "Format 'dd/MM/yyyy'";
        }
      } else {
        if (_isValidDate(time, "dd/MM/yyyy")) {
          _timeEndError = null;
        } else {
          _timeEndError = "Format 'dd/MM/yyyy'";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              onChanged: (value) {
                _checkContent();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Your Task",
                errorText: _contentErorr,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _timeBeginController,
                    onChanged: (value) {
                      _checkTime(_timeBeginController.text.trim(), 0);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Start Time",
                      errorText: _timeBeginError,
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: _timeEndController,
                    onChanged: (value) {
                      _checkTime(_timeEndController.text.trim(), 1);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "End Time",
                      errorText: _timeEndError,
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_contentErorr == null &&
                      _timeBeginError == null &&
                      _timeEndError == null) {
                    await widget.addCard(
                        _contentController.text.trim(),
                        _timeBeginController.text.trim(),
                        _timeEndController.text.trim());
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Add task',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
