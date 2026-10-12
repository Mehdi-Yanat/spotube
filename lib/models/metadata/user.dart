part of 'metadata.dart';

@freezed
class SpotubeUserObject with _$SpotubeUserObject {
  factory SpotubeUserObject({
    required String id,
    required String name,
    @Default([]) List<SpotubeImageObject> images,
    required String externalUri,
  }) = _SpotubeUserObject;

  factory SpotubeUserObject.fromJson(Map<String, dynamic> json) =>
      _$SpotubeUserObjectFromJson(json);
}
