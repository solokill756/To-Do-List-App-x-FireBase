import 'package:flutter/material.dart';

class CardAddWeiget extends StatelessWidget {
  const CardAddWeiget({
    super.key,
    required this.addCard,
  });
  final Function addCard;
  @override
  Widget build(BuildContext context) {
    String content = '';
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                content = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Your Task",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await addCard(content);
                  Navigator.pop(context);
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
