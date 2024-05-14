import 'package:flutter/material.dart';
import 'package:app3/models/plan.dart';
import 'input_plan.dart';
import 'input_recipes.dart';

class PlanCard extends StatelessWidget {
  final Plan plan;

  const PlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: GestureDetector(
        onTap: () {
          String id = plan.id;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Inputplans(
                planId: id,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4D8BAA),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        plan.imagePath ?? 'placeholder_image_path.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.description ?? 'No description available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        _buildDetailText(plan.timeFund),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailText(String? detail) {
    final textWidget = Text(
      detail ?? 'No detail available',
      style: const TextStyle(
        color: Colors.black,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: detail ?? 'No detail available',
          style: const TextStyle(
            color: Colors.black,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: 3,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          return textWidget;
        } else {
          return Text(
            detail ?? 'No detail available',
            style: const TextStyle(
              color: Colors.black,
            ),
          );
        }
      },
    );
  }

  // Widget _buildIconButton(BuildContext context) {
  //   return Positioned(
  //     top: 0,
  //     right: 0,
  //     child: Container(
  //       alignment: Alignment.topRight,
  //       child: IconButton(
  //         onPressed: () {
  //           String id = plan.id;
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => Inputplans(
  //                 planId: id,
  //               ),
  //             ),
  //           );
  //         },
  //         icon: const Icon(
  //           Icons.more_horiz,
  //           color: Color(0xFF4D8BAA),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
