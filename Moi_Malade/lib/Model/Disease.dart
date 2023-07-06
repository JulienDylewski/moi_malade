class Disease {
  final int? id;
  final LanguageData? name;
  final LanguageData? description;
  final MedicationDescription? medicationDescription;
  final LanguageData? symptomDescription;
  final Whois? whois;
  final List<LanguageData>? testsProceduresList;
  final List<LanguageData>? medicationsList;
  final List<DiseaseSymptom>? diseaseSymptoms;
  final int? relevanceScore;

  Disease({
    this.id,
    this.name,
    this.description,
    this.medicationDescription,
    this.symptomDescription,
    this.whois,
    this.testsProceduresList,
    this.medicationsList,
    this.diseaseSymptoms,
    this.relevanceScore,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['id'] as int?,
      name: json['name'] != null ? LanguageData.fromJson(json['name']) : null,
      description: json['description'] != null ? LanguageData.fromJson(json['description']) : null,
      medicationDescription: json['medicationDescription'] != null ? MedicationDescription.fromJson(json['medicationDescription']) : null,
      symptomDescription: json['symptomDescription'] != null ? LanguageData.fromJson(json['symptomDescription']) : null,
      whois: json['whois'] != null ? Whois.fromJson(json['whois']) : null,
      testsProceduresList: json['testsProceduresList'] != null ? (json['testsProceduresList'] as List<dynamic>).map((item) => LanguageData.fromJson(item)).toList() : null,
      medicationsList: json['medicationsList'] != null ? (json['medicationsList'] as List<dynamic>).map((item) => LanguageData.fromJson(item)).toList() : null,
      diseaseSymptoms: json['diseaseSymptoms'] != null ? (json['diseaseSymptoms'] as List<dynamic>).map((item) => DiseaseSymptom.fromJson(item)).toList() : null,
      relevanceScore: json['relevanceScore'] as int?,
    );
  }
}

class LanguageData {
  final int? id;
  final String? nomFr;
  final String? nomEn;

  LanguageData({
    this.id,
    this.nomFr,
    this.nomEn,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) {
    return LanguageData(
      id: json['id'] as int?,
      nomFr: json['nomFr'] as String?,
      nomEn: json['nomEn'] as String?,
    );
  }
}

class MedicationDescription {
  final int? id;
  final String? descriptionFr;
  final String? descriptionEn;

  MedicationDescription({
    this.id,
    this.descriptionFr,
    this.descriptionEn,
  });

  factory MedicationDescription.fromJson(Map<String, dynamic> json) {
    return MedicationDescription(
      id: json['id'] as int?,
      descriptionFr: json['descriptionFr'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
    );
  }
}

class Whois {
  final int? id;
  final String? descFr;
  final String? descEn;
  final String? sex;
  final String? ethnicity;
  final int? track1Start;
  final int? track1End;
  final int? track2Start;
  final int? track2End;
  final int? track3Start;
  final int? track3End;

  Whois({
    this.id,
    this.descFr,
    this.descEn,
    this.sex,
    this.ethnicity,
    this.track1Start,
    this.track1End,
    this.track2Start,
    this.track2End,
    this.track3Start,
    this.track3End,
  });

  factory Whois.fromJson(Map<String, dynamic> json) {
    return Whois(
      id: json['id'] as int?,
      descFr: json['descFr'] as String?,
      descEn: json['descEn'] as String?,
      sex: json['sex'] as String?,
      ethnicity: json['ethnicity'] as String?,
      track1Start: json['track1Start'] as int?,
      track1End: json['track1End'] as int?,
      track2Start: json['track2Start'] as int?,
      track2End: json['track2End'] as int?,
      track3Start: json['track3Start'] as int?,
      track3End: json['track3End'] as int?,
    );
  }
}

class DiseaseSymptom {
  final int? id;
  final String? disease;
  final LanguageData? symptom;
  final int? painIndex;

  DiseaseSymptom({
    this.id,
    this.disease,
    this.symptom,
    this.painIndex,
  });

  factory DiseaseSymptom.fromJson(Map<String, dynamic> json) {
    return DiseaseSymptom(
      id: json['id'] as int?,
      disease: json['disease'] as String?,
      symptom: json['symptom'] != null ? LanguageData.fromJson(json['symptom']) : null,
      painIndex: json['painIndex'] as int?,
    );
  }
}
