class ChildModel {
  final String cui;
  final String name;
  String gender;
  String birth;
  String year;
  String nameMother;
  String nameFather;
  String numberHouse;
  String numberSector;
  String address;
  String community;
  String municipality;
  String proximaCita;
  final String state;

  ChildModel(
      {this.cui,
      this.name,
      this.gender,
      this.birth,
      this.year,
      this.nameMother,
      this.nameFather,
      this.numberHouse,
      this.numberSector,
      this.address,
      this.community,
      this.municipality,
      this.state,
      this.proximaCita
      });
}

List<ChildModel> recordsData = [
  ChildModel(
    cui: "2590-16-107-12",
    name: "Gael Chanax",
    gender: "Masculino",
    birth: "25-abr-94",
    year: "26",
    nameMother: "Leonor",
    nameFather: "Oscar",
    numberHouse: "7-49",
    numberSector: "12",
    address: "Zona 1, canton centro",
    community: "Sn. Fco. La Unión",
    municipality: "Xela",
    state: "Grave",
    proximaCita: "10-09-20"
  ),
  ChildModel(
    cui: "2590-16-107-12",
    name: "Franklin Chavez",
    gender: "Masculino",
    birth: "25-abr-94",
    year: "4",
    nameMother: "Leonor",
    nameFather: "Oscar",
    numberHouse: "7-49",
    numberSector: "12",
    address: "Zona 1, canton centro",
    community: "Sn. Fco. La Unión",
    municipality: "Xela",
    state: "Medio",
    proximaCita: "02-10-20"
  ),
  ChildModel(
    cui: "2590-16-107-12",
    name: "Nohelia Oxlaj",
    gender: "Femenino",
    birth: "25-abr-94",
    year: "3",
    nameMother: "Leonor",
    nameFather: "Oscar",
    numberHouse: "7-49",
    numberSector: "12",
    address: "Zona 1, canton centro",
    community: "Sn. Fco. La Unión",
    municipality: "Xela",
    state: "Normal",
    proximaCita: "12-11-20"
  )
];
