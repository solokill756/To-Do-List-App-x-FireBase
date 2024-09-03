import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/item.dart';

class CardBody extends StatelessWidget {
  const CardBody({
    super.key,
    required this.deleteCard,
    required this.item,
  });
  final Function deleteCard;
  final Item item;
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final startDate = formatter.parseStrict(item.date_begin);
    final endDate = formatter.parseStrict(item.date_end);
    final difference1 = DateTime.now().difference(startDate).inDays;
    final difference2 = endDate.difference(DateTime.now()).inDays;
    Color? _cardColor;
    if (difference2 <= 1) {
      _cardColor = Colors.red[400];
    } else {
      if (difference1 > 0) {
        _cardColor = Colors.green[400];
      } else {
        _cardColor = Colors.grey[400];
      }
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      width: double.infinity,
      height: 74,
      decoration: BoxDecoration(
          color: _cardColor, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.content,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xff4B4B4B),
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () async {
                if (await confirm(context,
                    content:
                        const Text("Bạn có muốn xóa phần task này không ?"))) {
                  deleteCard(item.id);
                }
                return;
              },
              child: const Icon(
                Icons.delete_outline,
                color: Color(0xff4B4B4B),
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
