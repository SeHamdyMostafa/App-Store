import 'package:appstore/helper/DeviceDimenssions.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap; 

  CategoryCard({
    required this.name,
    required this.imageUrl,
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: DeviceDimensions.deviceWidth * 0.45,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  blurRadius: 50,
                  color: Colors.grey.withOpacity(.1),
                  spreadRadius: 20,
                  offset: Offset(1, 1))
            ]),
            child: Card(
              color: Colors.white,
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                                height: DeviceDimensions.deviceHeight * 0.18,
      
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black, 
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis, 
            maxLines: 1, 
          ),
        ],
      ),
    );
  }
}
