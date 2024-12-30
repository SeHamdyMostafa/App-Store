import 'package:appstore/Widget/ModelCardItem/QuantityContro.dart';
import 'package:flutter/material.dart';
import 'package:appstore/Model/Product_Model.dart';
import 'package:appstore/services/cart_service.dart';
import 'package:appstore/helper/DeviceDimenssions.dart';

class ModelCardItem extends StatefulWidget {
  final ProductModel productModel;
  final bool isCartPage; // تحديد إذا كانت البطاقة في صفحة الكارت

  ModelCardItem({
    required this.productModel,
    required this.isCartPage,
  });

  @override
  State<ModelCardItem> createState() => _ModelCardItemState();
}

class _ModelCardItemState extends State<ModelCardItem> {
  bool _isUpdating = false;

  void _updateQuantity(int newQuantity) async {
    if (_isUpdating) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      await CartService().updateCartItemQuantity(
        cartItemId: widget.productModel.cartItemId!,
        quantity: newQuantity,
        context: context,
      );

      setState(() {
        widget.productModel.quantity = newQuantity;
      });
    } catch (e) {
      print(e);
      _showErrorSnackBar('❌ Failed to update quantity');
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceDimensions.deviceHeight * .23,
      width: DeviceDimensions.deviceWidth * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 50,
            color: Colors.grey.withOpacity(.1),
            spreadRadius: 20,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Card(
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                widget.productModel.image!,
                height: DeviceDimensions.deviceHeight * .3,
                width: DeviceDimensions.deviceWidth * .3,
                fit: BoxFit.contain,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: DeviceDimensions.deviceWidth * .4,
                    child: Text(
                      widget.productModel.name!,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    r'$' + '${widget.productModel.price?.toInt()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  if (widget.productModel.discount != 0)
                    Text(
                      r'$' + '${widget.productModel.oldPrice?.toInt()}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        decorationThickness: 2.0,
                      ),
                    ),
                ],
              ),
              // إظهار أزرار التحكم فقط في صفحة الكارت
              if (widget.isCartPage) 
                QuantityControlWidget(
                  quantity: widget.productModel.quantity!,
                  onQuantityChanged: _updateQuantity,
                  isUpdating: _isUpdating,
                ), 
            ],
          ),
        ),
      ),
    );
  }
}
