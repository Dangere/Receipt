import 'package:flutter/material.dart';

import '../models.dart';

class ReceiptCard extends StatelessWidget {
  const ReceiptCard({super.key, required this.receipt});
  final Receipt receipt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 10.0) +
          const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Stack(alignment: Alignment.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 40,
                        width: 1,
                        child: Container(
                          color: Colors.grey[400],
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receipt.customerName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Purchased Items: ${receipt.broughtItems.length}",
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: "Paid ",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 15),
                                    children: const [
                                  TextSpan(
                                      text: '400\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(text: "Of "),
                                  TextSpan(
                                      text: "1000",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600))
                                ])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
              const SizedBox(
                height: 8,
              ),
              // const Text("Tab To View",
              //     style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w300),
              //     textAlign: TextAlign.center),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
