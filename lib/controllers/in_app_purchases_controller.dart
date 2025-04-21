import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:async';

class InAppPurchasesController with ChangeNotifier {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  List<ProductDetails> _products = [];
  bool _isPremium = false;

  List<ProductDetails> get products => _products;
  bool get isPremium => _isPremium;

  

  Future<void> initialize() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) return;

    _subscription = _inAppPurchase.purchaseStream.listen((purchases) {
      _handlePurchaseUpdates(purchases);
    });

    await _loadProducts();
    await _restorePurchases();
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

  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) {
    for (var purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased || purchase.status == PurchaseStatus.restored) {
        _isPremium = true;
        notifyListeners();
      }
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
    }
  }

  Future<void> _restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
