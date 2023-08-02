import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateItem extends StatelessWidget {
  const CreateItem({super.key, required this.closePanel});

  final VoidCallback closePanel;

  void text() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: closePanel, icon: const Icon(Icons.close, size: 30))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 200,
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), color: Colors.grey[400]),
                      child: const Icon(Icons.image, size: 30),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "Item Name",
                            hintStyle: TextStyle(),
                            border: InputBorder.none,
                          )),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Item ID",
                          hintStyle: TextStyle(),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              hintText: "Brought Price",
                              hintStyle: TextStyle(),
                              border: InputBorder.none)),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              hintText: "Selling Price",
                              hintStyle: TextStyle(),
                              border: InputBorder.none)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => print("create item"),
                    child: Container(
                      padding:
                          const EdgeInsets.all(12) + const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 20, 16, 26),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "Create",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
