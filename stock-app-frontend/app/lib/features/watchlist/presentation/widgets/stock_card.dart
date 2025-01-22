import 'package:flutter/material.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:app/core/utils/themes/fonts/app_typography.dart';
import 'package:app/core/utils/widgets/Icons/custom_icon.dart';
import 'package:app/core/constant/icons/app_icons_path.dart';

class StockCard extends StatelessWidget {
  final String symbol;
  final String companyName;
  final double currentPrice;
  final double changeAmount;
  final double changePercentage;
  final VoidCallback? onDelete;

  const StockCard({
    Key? key,
    required this.symbol,
    required this.companyName,
    required this.currentPrice,
    required this.changeAmount,
    required this.changePercentage,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors().primaryColor,
                  child: Text(
                    symbol[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        symbol,
                        style: AppTypography.heading.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        companyName,
                        style: AppTypography.subtitle.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: const CustomIcon(
                      svgPath: AppIcons.deleteIcon,
                      size: 24,
                      color: Colors.red,
                    ),
                    onPressed: onDelete,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current Price', style: AppTypography.label),
                    Text(
                      '\$${currentPrice.toStringAsFixed(2)}',
                      style: AppTypography.heading.copyWith(
                        color: AppColors().primaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Change', style: AppTypography.label),
                    Row(
                      children: [
                        Icon(
                          changeAmount >= 0
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: changeAmount >= 0 ? Colors.green : Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${changeAmount.toStringAsFixed(2)} (${changePercentage.toStringAsFixed(2)}%)',
                          style: TextStyle(
                            color:
                                changeAmount >= 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
