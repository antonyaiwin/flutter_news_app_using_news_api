import 'package:flutter/material.dart';

import '../../../core/constants/image_constants.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
  });
  final String category;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(
                  color: Colors.white.withOpacity(0.7),
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignInside,
                )
              : null,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              '${ImageConstants.categoryImagesBasePath}$category.jpg',
            ),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.multiply,
            ),
          ),
        ),
        child: Center(
            child: Text(
          category[0].toUpperCase() + category.substring(1),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        )),
      ),
    );
  }
}
