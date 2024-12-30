import 'package:appstore/Widget/ProductCard/ProductCardLogic.dart';
import 'package:appstore/helper/DeviceDimenssions.dart';
import 'package:flutter/material.dart';
import 'package:appstore/Model/Product_Model.dart';

class CardItemOfProduct extends StatefulWidget {
  final ProductModel productModel;

  CardItemOfProduct({required this.productModel});

  @override
  _CardItemOfProductState createState() => _CardItemOfProductState();
}

class _CardItemOfProductState extends State<CardItemOfProduct> {
  late ProductCardLogic productCardLogic;

  @override
  void initState() {
    super.initState();
    productCardLogic = ProductCardLogic(productModel: widget.productModel);
    _loadFavoriteStatus();
  }

  _loadFavoriteStatus() async {
    await productCardLogic.loadFavoriteStatus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Image.network(
                  widget.productModel.image ?? "https://via.placeholder.com/150",
                  height: DeviceDimensions.deviceHeight * .15,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    productCardLogic.isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: productCardLogic.isFavorited ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      productCardLogic.toggleFavorite(context);
                    });
                  },
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: widget.productModel.discount == 0
                    ? Container()
                    : Text(
                        '-${widget.productModel.discount?.toInt()}%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: DeviceDimensions.deviceHeight * .2),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          r'$' + '${widget.productModel.price?.toInt()}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        widget.productModel.discount == 0
                            ? SizedBox()
                            : Text(
                                r'$' + '${widget.productModel.oldPrice?.toInt()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  decorationThickness: 2.0,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    widget.productModel.name!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Text(
                    widget.productModel.description!, // Add description here
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    productCardLogic.addToCart(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'ADD CART',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
