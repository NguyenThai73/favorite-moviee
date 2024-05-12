// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'vote.cubit.state.dart';

class VoteCubit extends Cubit<VoteCubitState> {
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  VoteCubit() : super(const VoteCubitState(voteStatus: VoteStatus.initial)) {
    _subscription = inAppPurchase.purchaseStream.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchase(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {});
  }

  Future<void> _listenToPurchase(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
      } else {
        if (purchaseDetails.status == PurchaseStatus.canceled) {
        }
        if (purchaseDetails.status == PurchaseStatus.error) {
          emit(state.copyWith(voteStatus: VoteStatus.error));
        } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {}
        if (purchaseDetails.pendingCompletePurchase) {
          emit(state.copyWith(voteStatus: VoteStatus.success));
        }
      }
    }
  }

  voteProduct(String productId) async {
    emit(state.copyWith(voteStatus: VoteStatus.loading));
    try {
      bool available = await inAppPurchase.isAvailable();
      if (!available) {
        emit(state.copyWith(voteStatus: VoteStatus.error));
        return;
      }
      final ProductDetailsResponse productDetailsResponse = await inAppPurchase.queryProductDetails({productId});
      if (productDetailsResponse.notFoundIDs.contains(productId)) {
        emit(state.copyWith(voteStatus: VoteStatus.error));
        return;
      }
      final ProductDetails productDetails = productDetailsResponse.productDetails.first;
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
      await inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
    } catch (e) {
      emit(state.copyWith(voteStatus: VoteStatus.error));
    }
  }
}
