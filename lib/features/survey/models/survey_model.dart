class SurveyModel {
  SurveyModel({
    required this.values,
    required this.informelatitud,
    required this.informelongitud,
  });

  final Map<String, String> values;
  final String informelatitud;
  final String informelongitud;

  Map<String, String> toMap() => {
        ...values,
        'informelatitud': informelatitud,
        'informelongitud': informelongitud,
      };
}
