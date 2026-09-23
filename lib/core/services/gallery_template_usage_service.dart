// Locked Leaf: StoryPad recorded template usage per device in Firestore.
// Removed — nothing about how templates are used leaves this Mac.
// Kept as a no-op so existing callers don't need to change.
class GalleryTemplateUsageService {
  GalleryTemplateUsageService._();
  static GalleryTemplateUsageService get instance => GalleryTemplateUsageService._();

  Future<void> recordTemplateUsage({
    required String templateId,
  }) async {}
}
