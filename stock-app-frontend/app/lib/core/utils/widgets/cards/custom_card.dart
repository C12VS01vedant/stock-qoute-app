import 'package:app/core/constant/enums/custom_typography_styles.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:app/core/utils/widgets/Texts/custom_text.dart';

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String symbol;
  final String companyName;
  final double currentPrice; 
  final double changeAmount; 
  final double changePercentage; // Make nullable
  
  final bool hasInternetConnection;

  const CustomCard({
    super.key,
    required this.symbol,
    required this.currentPrice,
    required this.changeAmount,
    required this.changePercentage,
    this.companyName = '',
   
    required this.hasInternetConnection,
  });

  String formatPrice(dynamic price) {
    if (price == null || price == "N/A") return "N/A";
    if (price is num) return price.toStringAsFixed(2);
    return price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your on-tap logic here
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(12),
        elevation: 8,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Symbol and Company Name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(symbol),
                      const SizedBox(width: 10),
                    ],
                  ),
                  if (companyName.isNotEmpty)
                    Expanded(
                      child: CustomText(
                        text: companyName,
                        typographyStyle: CustomTypographyStyle.body,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              // Current Price
              CustomText(
                text:
                    'Change: \$${changeAmount.toStringAsFixed(2)} (${changePercentage.toStringAsFixed(2)}%)',
                typographyStyle: CustomTypographyStyle.body,
                textColor: changeAmount>= 0
                    ? AppColors().gainColor
                    : AppColors().errorColor,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Change Amount and Percentage
              CustomText(
                text:
                    'Change: Rs${changeAmount.toStringAsFixed(2)} (${changePercentage.toStringAsFixed(2)}%)',
                typographyStyle: CustomTypographyStyle.body,
                textColor: changeAmount >= 0
                    ? AppColors().gainColor
                    : AppColors().errorColor,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 15),

              // // Additional Details
              // if (additionalDetails.isNotEmpty)
              //   ...additionalDetails.entries.map((entry) => Padding(
              //         padding: const EdgeInsets.only(bottom: 5),
              //         child: CustomText(
              //           text: '${entry.key}: ${entry.value}',
              //           typographyStyle: CustomTypographyStyle.caption,
              //           textColor: AppColors().secondaryColor,
              //         ),
              //       )),

              // Connectivity Status Indicator
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  hasInternetConnection
                      ? Icons.signal_cellular_4_bar
                      : Icons.signal_cellular_off,
                  color: hasInternetConnection
                      ? AppColors().gainColor
                      : AppColors().errorColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
