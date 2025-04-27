import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InAppPurchasesController with ChangeNotifier {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  List<ProductDetails> _products = [];
  bool _isPremium = false;

  List<ProductDetails> get products => _products;
  bool get isPremium => _isPremium;

  

  Future<void> initializeInAppPurchases() async {
  final prefs = await SharedPreferences.getInstance();
  _isPremium = prefs.getBool('isPremium') ?? false;
  notifyListeners();

  final bool isAvailable = await _inAppPurchase.isAvailable();
  if (!isAvailable) return;

  _subscription = _inAppPurchase.purchaseStream.listen((purchases) {
    _handlePurchaseUpdates(purchases);
  });

  await _loadProducts();
  await restorePurchases();
}



  Future<void> _loadProducts() async {
    const Set<String> productIds = {'prem_month_1', 'prem_year_1'};
    final response = await _inAppPurchase.queryProductDetails(productIds);
    _products = response.productDetails;
    notifyListeners();
  }

  Future<void> buySubscription(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
  final prefs = await SharedPreferences.getInstance();
  
  for (var purchase in purchases) {
    if (purchase.status == PurchaseStatus.purchased || purchase.status == PurchaseStatus.restored) {
      
      final matchingProduct = _products.firstWhere(
        (product) => product.id == purchase.productID,
        orElse: () => throw Exception('Product not found'),
      );

      _postPaymentToServer(matchingProduct.price, matchingProduct.title);
      
      _isPremium = true;
      await prefs.setBool('isPremium', true);
      notifyListeners();
    }
    if (purchase.pendingCompletePurchase) {
      _inAppPurchase.completePurchase(purchase);
    }
  }
}



  Future<void> restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> _postPaymentToServer(String amount, String planName) async {
    final prefs = await SharedPreferences.getInstance();
    final uuid = prefs.getString('app_uuid');
    try {
      final response = await http.post(Uri.parse('https://talk-to-quran.com/api/user/addPayment'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Device-UUID': uuid!,
      },
      body: jsonEncode({
        'amount': amount,
        'plan_name': planName
      })
      );
      if (response.statusCode == 200) {
        log('Payment posted to server successfully');
      } else {
        log('Error posting payment to server: ${response.statusCode}');
        log('Error posting payment to server: ${response.body}');
      }
    } catch (e) {
      log('Error posting payment to server: $e');
    }
  }
}