class StoryModel {
  String meses;
  String peso;
  String altura;
  String fecha;
  String estado;

  StoryModel({
    this.meses,
    this.peso,
    this.altura,
    this.fecha,
    this.estado,
  });
}

List<StoryModel> storyData = [
  StoryModel(meses: "24", peso: "45", altura: "90", fecha: "24-ags-20", estado: "Grave"),
  StoryModel(meses: "44", peso: "35", altura: "80", fecha: "23-sep-20", estado: "Normal"),
  StoryModel(meses: "23", peso: "33", altura: "88", fecha: "12-oct-20", estado: "Medio"),
  StoryModel(meses: "60", peso: "55", altura: "66", fecha: "08-oct-20", estado: "Normal"),
  StoryModel(meses: "14", peso: "16", altura: "55", fecha: "01-nov-20", estado: "Grave"),
];
