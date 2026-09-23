import 'dart:async';
import 'package:flutter/material.dart';
import 'package:storypad/core/mixins/dispose_aware_mixin.dart';
import 'package:storypad/core/services/backups/backup_service_type.dart';
import 'package:storypad/core/types/app_product.dart';

// Locked Leaf: StoryPad sold Pro features through RevenueCat, which tied a
// purchase identity to your cloud account and talked to RevenueCat's servers.
// Locked Leaf is a personal, not-for-sale fork, so RevenueCat is removed and
// every feature is unlocked locally. No purchase checks, no network calls.
//
// The public API is kept so the ~100 existing call sites don't need to change.
class InAppPurchaseProvider extends ChangeNotifier with DisposeAwareMixin {
  bool isActive(String productIdentifier) => true;

  bool get isProUser => true;

  // Legacy one-off purchases. Kept false so nothing is auto-enabled by default
  // (e.g. the period calendar add-on); every feature is still unlocked via isProUser.
  bool get hasAnyLegacyPurchases => false;
  bool get periodCalendar => false;

  bool get initialized => true;
  Future<void> ensureInitialized() async {}

  // Purchase-identity sync across cloud accounts — not used without RevenueCat.
  BackupServiceType? get selectedSyncProvider => null;
  Future<void> setSelectedPurchaseSyncProvider(BackupServiceType? serviceType) async {}

  ({String? displayPrice, String? displayComparePrice, String? badgeLabel}) getActiveDeal(AppProduct product) {
    return (displayPrice: null, displayComparePrice: null, badgeLabel: null);
  }

  Future<void> fetchAndCacheProducts({required String debugSource}) async {}

  Future<bool> purchase(BuildContext context) async => false;

  Future<void> restorePurchase(BuildContext context) async {}

  Future<void> presentCodeRedemptionSheet(BuildContext context) async {}
}
