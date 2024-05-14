import 'package:flutter/material.dart';
import 'package:app3/models/recipe.dart';

import 'input_recipes.dart';

class RecipesCard extends StatelessWidget {
  final Recipe recipe;

  const RecipesCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: GestureDetector(
        onTap: () {
          String id = recipe.id;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InputRecipes(
                recipeId: id,
              ),
            ),
          );
        },
        child: Container(
          width: 160,
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
                        recipe.imagePath ?? 'placeholder_image_path.png',
                        fit: BoxFit.fill,
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
                          recipe.description ?? 'No description available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 1, // Giới hạn số dòng
                          overflow: TextOverflow
                              .ellipsis, // Hiển thị dấu "..." nếu vượt quá
                        ),
                        const SizedBox(height: 5),
                        _buildDetailText(recipe.detail),
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
      maxLines: 3, // Giới hạn số dòng
      overflow:
          TextOverflow.ellipsis, // Hiển thị dấu "..." khi vượt quá số dòng
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
          maxLines: 3, // Giới hạn số dòng
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
  //           // Xử lý khi nhấn vào IconButton

  //           String id = recipe.id;
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => InputRecipes(
  //                 recipeId: id,
  //               ),
  //             ),
  //           );
  //         },
  //         icon: const Icon(
  //           Icons.more_horiz, // Icon thích hợp có thể thay đổi
  //           color: Color(0xFF4D8BAA),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
