class StandardsBoy {
///--------------- mediana  de longitud para la edad de nacimiento a  2 años -------------------
 List lengthForAgeBirthTo2YearsMedianDS(int month) {
   ///Las Collections son objetos que agrupan múltiples elementos dentro de ellos, un objeto
   /// List por ejemplo pertenece a los Collections.
   var alturaEdad = [0.0,0.0,0.0];
   // posicion 0  = mediana  y posiscion 1 = Desviacion Estandar(DS)
   switch (month) {
    case  0: return alturaEdad = List.of({49.8842, 1.8931}); break;	
    case  1: return alturaEdad = List.of({54.7244, 1.9465}); break;	
    case  2: return alturaEdad = List.of({58.4249, 2.0005}); break;	
    case  3: return alturaEdad = List.of({61.4292, 2.0444}); break;	
    case  4: return alturaEdad = List.of({63.8860, 2.0808}); break;	
    case  5: return alturaEdad = List.of({65.9026, 2.1115}); break;	
    case  6: return alturaEdad = List.of({67.6236, 2.1403}); break;	
    case  7: return alturaEdad = List.of({69.1645, 2.1711}); break;	
    case  8: return alturaEdad = List.of({70.5994, 2.2055}); break;	
    case  9: return alturaEdad = List.of({71.9687, 2.2433}); break;	
    case 10: return alturaEdad = List.of({73.2812, 2.2849}); break;	
    case 11: return alturaEdad = List.of({74.5388, 2.3293}); break;	
    case 12: return alturaEdad = List.of({75.7488, 2.3762}); break;	
    case 13: return alturaEdad = List.of({76.9186, 2.4260}); break;	
    case 14: return alturaEdad = List.of({78.0497, 2.4773}); break;	
    case 15: return alturaEdad = List.of({79.1458, 2.5303}); break;	
    case 16: return alturaEdad = List.of({80.2113, 2.5844}); break;	
    case 17: return alturaEdad = List.of({81.2487, 2.6406}); break;	
    case 18: return alturaEdad = List.of({82.2587, 2.6973}); break;	
    case 19: return alturaEdad = List.of({83.2418, 2.7553}); break;	
    case 20: return alturaEdad = List.of({84.1996, 2.8140}); break;	
    case 21: return alturaEdad = List.of({85.1348, 2.8742}); break;	
    case 22: return alturaEdad = List.of({86.0477, 2.9342}); break;	
    case 23: return alturaEdad = List.of({86.9410, 2.9951}); break;	
    case 24: return alturaEdad = List.of({87.8161, 3.0551}); break;	
    default: return alturaEdad;	
   }
   
  }  
///--------------- mediana de longitud para la edad de 2 años a 5 años -------------------
  List lengthForAge2To5YearsMedianDS(int month) {
    var alturaEdad = [0.0,0.0,0.0];
    // posicion 0  = mediana  y posiscion 1 = Desviacion Estandar(DS)
    switch (month) {
      case 24: return	alturaEdad = List.of({ 87.1161, 3.0551}); break;
      case 25: return	alturaEdad = List.of({ 87.9720, 3.1160}); break;
      case 26: return	alturaEdad = List.of({ 88.8065, 3.1757}); break;
      case 27: return	alturaEdad = List.of({ 89.6197, 3.2353}); break;
      case 28: return	alturaEdad = List.of({ 90.4120, 3.2928}); break;
      case 29: return	alturaEdad = List.of({ 91.1828, 3.3501}); break;
      case 30: return	alturaEdad = List.of({ 91.9327, 3.4052}); break;
      case 31: return	alturaEdad = List.of({ 92.6631, 3.4591}); break;
      case 32: return	alturaEdad = List.of({ 93.3753, 3.5118}); break;
      case 33: return	alturaEdad = List.of({ 94.0711, 3.5625}); break;
      case 34: return	alturaEdad = List.of({ 94.7532, 3.6120}); break;
      case 35: return	alturaEdad = List.of({ 95.4236, 3.6604}); break;
      case 36: return	alturaEdad = List.of({ 96.0835, 3.7069}); break;
      case 37: return	alturaEdad = List.of({ 96.7337, 3.7523}); break;
      case 38: return	alturaEdad = List.of({ 97.3749, 3.7976}); break;
      case 39: return	alturaEdad = List.of({ 98.0073, 3.8409}); break;
      case 40: return	alturaEdad = List.of({ 98.6310, 3.8831}); break;
      case 41: return	alturaEdad = List.of({ 99.2459, 3.9242}); break;
      case 42: return	alturaEdad = List.of({ 99.8515, 3.9651}); break;
      case 43: return	alturaEdad = List.of({100.4485, 4.0039}); break;
      case 44: return	alturaEdad = List.of({101.0374, 4.0435}); break;
      case 45: return	alturaEdad = List.of({101.6186, 4.0810}); break;
      case 46: return	alturaEdad = List.of({102.1933, 4.1194}); break;
      case 47: return	alturaEdad = List.of({102.7625, 4.1567}); break;
      case 48: return	alturaEdad = List.of({103.3273, 4.1941}); break;
      case 49: return	alturaEdad = List.of({103.8886, 4.2314}); break;
      case 50: return	alturaEdad = List.of({104.4473, 4.2677}); break;
      case 51: return	alturaEdad = List.of({105.0041, 4.3052}); break;
      case 52: return	alturaEdad = List.of({105.5596, 4.3417}); break;
      case 53: return	alturaEdad = List.of({106.1138, 4.3783}); break;
      case 54: return	alturaEdad = List.of({106.6668, 4.4149}); break;
      case 55: return	alturaEdad = List.of({107.2188, 4.4517}); break;
      case 56: return	alturaEdad = List.of({107.7697, 4.4886}); break;
      case 57: return	alturaEdad = List.of({108.3198, 4.5245}); break;
      case 58: return alturaEdad = List.of({108.8689, 4.5616}); break;
      case 59: return	alturaEdad = List.of({109.4170, 4.5977}); break;
      case 60: return	alturaEdad = List.of({109.9638, 4.6339}); break;
      default: return alturaEdad ;
     }	
   }

//----------------------------- Peso para la edad ---------------------------------
 List weigthForAgeBoy(int month){
   var weigthForAge = [0.0,0.0,0.0];
   //posicion 0 = Lambda , posicion 1 = Mediana, posicion 2 = Sigma
   switch (month) {
    case  0: return weigthForAge = List.of({0.3487,  3.3464, 0.14602}); break;	   
    case  1: return weigthForAge = List.of({0.2297,  4.4709, 0.13395}); break;	   
    case  2: return weigthForAge = List.of({0.1970,  5.5675, 0.12385}); break;	   
    case  3: return weigthForAge = List.of({0.1738,  6.3762, 0.11727}); break;	   
    case  4: return weigthForAge = List.of({0.1553,  7.0023, 0.11316}); break;	   
    case  5: return weigthForAge = List.of({0.1395,  7.5105, 0.11080}); break;	   
    case  6: return weigthForAge = List.of({0.1257,  7.9340, 0.10958}); break;	   
    case  7: return weigthForAge = List.of({0.1134,  8.2970, 0.10902}); break;	   
    case  8: return weigthForAge = List.of({0.1021,  8.6151, 0.10882}); break;	   
    case  9: return weigthForAge = List.of({0.0917,  8.9014, 0.10881}); break;	   
    case 10: return weigthForAge = List.of({0.0820,  9.1649, 0.10891}); break;	   
    case 11: return weigthForAge = List.of({0.0730,  9.4122, 0.10906}); break;	   
    case 12: return weigthForAge = List.of({0.0644,  9.6479, 0.10925}); break;	   
    case 13: return weigthForAge = List.of({0.0563,  9.8749, 0.10949}); break;	   
    case 14: return weigthForAge = List.of({0.0487, 10.0953, 0.10976}); break;	   
    case 15: return weigthForAge = List.of({0.0413, 10.3108, 0.11007}); break;	   
    case 16: return weigthForAge = List.of({0.0343, 10.5228, 0.11041}); break;	   
    case 17: return weigthForAge = List.of({0.0275, 10.7319, 0.11079}); break;	   
    case 18: return weigthForAge = List.of({0.0211, 10.9385, 0.11119}); break;	   
    case 19: return weigthForAge = List.of({0.0148, 11.1430, 0.11164}); break;	   
    case 20: return weigthForAge = List.of({0.0087, 11.3462, 0.11211}); break;	   
    case 21: return weigthForAge = List.of({0.0029, 11.5486, 0.11261}); break;	   
    case 22: return weigthForAge = List.of({0.0028, 11.7504, 0.11314}); break;	   
    case 23: return weigthForAge = List.of({0.0083, 11.9514, 0.11369}); break;	   
    case 24: return weigthForAge = List.of({0.0137, 12.1515, 0.11426}); break;	   
    case 25: return weigthForAge = List.of({0.0189, 12.3502, 0.11485}); break;	   
    case 26: return weigthForAge = List.of({0.0240, 12.5466, 0.11544}); break;	   
    case 27: return weigthForAge = List.of({0.0289, 12.7401, 0.11604}); break;	   
    case 28: return weigthForAge = List.of({0.0337, 12.9303, 0.11664}); break;	   
    case 29: return weigthForAge = List.of({0.0385, 13.1169, 0.11723}); break;	   
    case 30: return weigthForAge = List.of({0.0431, 13.3000, 0.11781}); break;	   
    case 31: return weigthForAge = List.of({0.0476, 13.4798, 0.11839}); break;	   
    case 32: return weigthForAge = List.of({0.0520, 13.6567, 0.11896}); break;	   
    case 33: return weigthForAge = List.of({0.0564, 13.8309, 0.11953}); break;	   
    case 34: return weigthForAge = List.of({0.0606, 14.0031, 0.12008}); break;	   
    case 35: return weigthForAge = List.of({0.0648, 14.1736, 0.12062}); break;	   
    case 36: return weigthForAge = List.of({0.0689, 14.3429, 0.12116}); break;	   
    case 37: return weigthForAge = List.of({0.0729, 14.5113, 0.12168}); break;	   
    case 38: return weigthForAge = List.of({0.0769, 14.6791, 0.12220}); break;	   
    case 39: return weigthForAge = List.of({0.0808, 14.8466, 0.12271}); break;	   
    case 40: return weigthForAge = List.of({0.0846, 15.0140, 0.12322}); break;	   
    case 41: return weigthForAge = List.of({0.0883, 15.1813, 0.12373}); break;	   
    case 42: return weigthForAge = List.of({0.0920, 15.3486, 0.12425}); break;	   
    case 43: return weigthForAge = List.of({0.0957, 15.5158, 0.12478}); break;	   
    case 44: return weigthForAge = List.of({0.0993, 15.6828, 0.12531}); break;	   
    case 45: return weigthForAge = List.of({0.1028, 15.8497, 0.12586}); break;	   
    case 46: return weigthForAge = List.of({0.1063, 16.0163, 0.12643}); break;	   
    case 47: return weigthForAge = List.of({0.1097, 16.1827, 0.12700}); break;	   
    case 48: return weigthForAge = List.of({0.1131, 16.3489, 0.12759}); break;	   
    case 49: return weigthForAge = List.of({0.1165, 16.5150, 0.12819}); break;	   
    case 50: return weigthForAge = List.of({0.1198, 16.6811, 0.12880}); break;	   
    case 51: return weigthForAge = List.of({0.1230, 16.8471, 0.12943}); break;	   
    case 52: return weigthForAge = List.of({0.1262, 17.0132, 0.13005}); break;	   
    case 53: return weigthForAge = List.of({0.1294, 17.1792, 0.13069}); break;	   
    case 54: return weigthForAge = List.of({0.1325, 17.3452, 0.13133}); break;	   
    case 55: return weigthForAge = List.of({0.1356, 17.5111, 0.13197}); break;	   
    case 56: return weigthForAge = List.of({0.1387, 17.6768, 0.13261}); break;	   
    case 57: return weigthForAge = List.of({0.1417, 17.8422, 0.13325}); break;	   
    case 58: return weigthForAge = List.of({0.1447, 18.0073, 0.13389}); break;	   
    case 59: return weigthForAge = List.of({0.1477, 18.1722, 0.13453}); break;	   
    case 60: return weigthForAge = List.of({0.1506, 18.3366, 0.13517}); break;
    default: return weigthForAge;
   }
 }
//--------------------- Peso para la longitud de nacimiento a dos años (Puntuacion Z) -----------
List weightForLengthBirthTo2YearsBOYSz(int altura){
  var   weightForLength = [0.0,0.0,0.0];
  //posicion 0 = Lambda , posicion 1 = Mediana, posicion 2 = Sigma
  switch (altura) {
    case  45:	return weightForLength = List.of({-0.3521,   2.441, 0.09182}); break;
    case  46:	return weightForLength = List.of({-0.3521,  2.6077, 0.09124}); break;
    case  47:	return weightForLength = List.of({-0.3521,  2.7755, 0.09065}); break;
    case  48:	return weightForLength = List.of({-0.3521,   2.948, 0.09007}); break;
    case  49:	return weightForLength = List.of({-0.3521,  3.1308, 0.08948}); break;
    case  50:	return weightForLength = List.of({-0.3521,  3.3278,  0.0889}); break;
    case  51:	return weightForLength = List.of({-0.3521,  3.5376, 0.08831}); break;
    case  52:	return weightForLength = List.of({-0.3521,   3.762, 0.08771}); break;
    case  53:	return weightForLength = List.of({-0.3521,   4.006, 0.08711}); break;
    case  54:	return weightForLength = List.of({-0.3521,  4.2693, 0.08651}); break;
    case  55:	return weightForLength = List.of({-0.3521,  4.5467, 0.08592}); break;
    case  56:	return weightForLength = List.of({-0.3521,  4.8338, 0.08535}); break;
    case  57:	return weightForLength = List.of({-0.3521,  5.1259, 0.08481}); break;
    case  58:	return weightForLength = List.of({-0.3521,   5.418,  0.0843}); break;
    case  59:	return weightForLength = List.of({-0.3521,  5.7074, 0.08383}); break;
    case  60:	return weightForLength = List.of({-0.3521,  5.9907, 0.08342}); break;
    case  61:	return weightForLength = List.of({-0.3521,  6.2632, 0.08308}); break;
    case  62:	return weightForLength = List.of({-0.3521,  6.5251, 0.08279}); break;
    case  63:	return weightForLength = List.of({-0.3521,  6.7786, 0.08255}); break;
    case  64:	return weightForLength = List.of({-0.3521,  7.0255, 0.08236}); break;
    case  65:	return weightForLength = List.of({-0.3521,  7.2666, 0.08223}); break;
    case  66:	return weightForLength = List.of({-0.3521,  7.5034, 0.08215}); break;
    case  67:	return weightForLength = List.of({-0.3521,   7.737, 0.08212}); break;
    case  68:	return weightForLength = List.of({-0.3521,  7.9674, 0.08214}); break;
    case  69:	return weightForLength = List.of({-0.3521,  8.1955, 0.08219}); break;
    case  70:	return weightForLength = List.of({-0.3521,  8.4227, 0.08229}); break;
    case  71:	return weightForLength = List.of({-0.3521,   8.648, 0.08241}); break;
    case  72:	return weightForLength = List.of({-0.3521,  8.8697, 0.08254}); break;
    case  73:	return weightForLength = List.of({-0.3521,  9.0865, 0.08269}); break;
    case  74:	return weightForLength = List.of({-0.3521,  9.2974, 0.08283}); break;
    case  75:	return weightForLength = List.of({-0.3521,  9.5032, 0.08295}); break;
    case  76:	return weightForLength = List.of({-0.3521,  9.7033, 0.08307}); break;
    case  77:	return weightForLength = List.of({-0.3521,  9.8963, 0.08314}); break;
    case  78:	return weightForLength = List.of({-0.3521, 10.0827,	0.08318}); break;	
    case  79:	return weightForLength = List.of({-0.3521, 10.2649,	0.08316}); break;	
    case  80:	return weightForLength = List.of({-0.3521, 10.4475,	0.08308}); break;	
    case  81:	return weightForLength = List.of({-0.3521, 10.6352,	0.08293}); break;	
    case  82:	return weightForLength = List.of({-0.3521, 10.8321,	0.08273}); break;	
    case  83:	return weightForLength = List.of({-0.3521, 11.0415,	0.08246}); break;	
    case  84:	return weightForLength = List.of({-0.3521, 11.2651,	0.08215}); break;	
    case  85:	return weightForLength = List.of({-0.3521, 11.5007,	0.08181}); break;	
    case  86:	return weightForLength = List.of({-0.3521, 11.7444,	0.08145}); break;	
    case  87:	return weightForLength = List.of({-0.3521, 11.9916,	0.08111}); break;	
    case  88:	return weightForLength = List.of({-0.3521, 12.2382,	0.08082}); break;	
    case  89:	return weightForLength = List.of({-0.3521, 12.4815,	0.08058}); break;	
    case  90:	return weightForLength = List.of({-0.3521, 12.7209,	0.08041}); break;	
    case  91:	return weightForLength = List.of({-0.3521, 12.9569,	 0.0803}); break;	
    case  92:	return weightForLength = List.of({-0.3521,  13.191,	0.08025}); break;	
    case  93:	return weightForLength = List.of({-0.3521, 13.4239,	0.08026}); break;	
    case  94:	return weightForLength = List.of({-0.3521, 13.6572,	0.08034}); break;	
    case  95:	return weightForLength = List.of({-0.3521, 13.8928,	0.08047}); break;	
    case  96:	return weightForLength = List.of({-0.3521, 14.1325,	0.08067}); break;	
    case  97:	return weightForLength = List.of({-0.3521, 14.3782,	0.08092}); break;	
    case  98:	return weightForLength = List.of({-0.3521, 14.6316,	0.08122}); break;	
    case  99:	return weightForLength = List.of({-0.3521, 14.8934,	0.08157}); break;	
    case 100:	return weightForLength = List.of({-0.3521, 15.1637,	0.08198}); break;	
    case 101:	return weightForLength = List.of({-0.3521, 15.4419,	0.08243}); break;	
    case 102:	return weightForLength = List.of({-0.3521, 15.7276,	0.08292}); break;	
    case 103:	return weightForLength = List.of({-0.3521, 16.0206,	0.08343}); break;	
    case 104:	return weightForLength = List.of({-0.3521, 16.3204,	0.08397}); break;	
    case 105:	return weightForLength = List.of({-0.3521, 16.6268,	0.08453}); break;	
    case 106:	return weightForLength = List.of({-0.3521, 16.9401,	 0.0851}); break;	
    case 107:	return weightForLength = List.of({-0.3521, 17.2607,	0.08568}); break;	
    case 108:	return weightForLength = List.of({-0.3521, 17.5885,	0.08629}); break;	
    case 109:	return weightForLength = List.of({-0.3521, 17.9242,	0.08691}); break;	
    case 110:	return weightForLength = List.of({-0.3521, 18.2689,	0.08755}); break;	
    default: return weightForLength;  }
 }

//--------------------- Peso para la estatura altura de dos a cinco años (Puntuacion Z) -----------
List weightForHeight2To5YearsBOYSz(int altura){
   var   weightForLength = [0.0,0.0,0.0];
  //posicion 0 = Lambda , posicion 1 = Mediana, posicion 2 = Sigma
  switch (altura) {
    case  65: return weightForLength = List.of({-0.3521,  7.4327, 0.08217}); break;
    case  66: return weightForLength = List.of({-0.3521,  7.6673, 0.08212}); break;
    case  67: return weightForLength = List.of({-0.3521,  7.8986, 0.08213}); break;
    case  68: return weightForLength = List.of({-0.3521,  8.1272, 0.08217}); break;
    case  69: return weightForLength = List.of({-0.3521,  8.3547, 0.08226}); break;
    case  70: return weightForLength = List.of({-0.3521,  8.5808, 0.08237}); break;
    case  71: return weightForLength = List.of({-0.3521,  8.8036, 0.08250}); break;
    case  72: return weightForLength = List.of({-0.3521,  9.0221, 0.08264}); break;
    case  73: return weightForLength = List.of({-0.3521,  9.2347, 0.08278}); break;
    case  74: return weightForLength = List.of({-0.3521,  9.4420, 0.08292}); break;
    case  75: return weightForLength = List.of({-0.3521,  9.6440, 0.08303}); break;
    case  76: return weightForLength = List.of({-0.3521,  9.8392, 0.08312}); break;
    case  77: return weightForLength = List.of({-0.3521, 10.0274, 0.08317}); break;
    case  78: return weightForLength = List.of({-0.3521, 10.2105, 0.08317}); break;
    case  79: return weightForLength = List.of({-0.3521, 10.3923, 0.08311}); break;
    case  80: return weightForLength = List.of({-0.3521, 10.5781, 0.08298}); break;
    case  81: return weightForLength = List.of({-0.3521, 10.7718, 0.08279}); break;
    case  82: return weightForLength = List.of({-0.3521, 10.9772, 0.08255}); break;
    case  83: return weightForLength = List.of({-0.3521, 11.1966, 0.08225}); break;
    case  84: return weightForLength = List.of({-0.3521, 11.4290, 0.08191}); break;
    case  85: return weightForLength = List.of({-0.3521, 11.6707, 0.08156}); break;
    case  86: return weightForLength = List.of({-0.3521, 11.9173, 0.08121}); break;
    case  87: return weightForLength = List.of({-0.3521, 12.1645, 0.08090}); break;
    case  88: return weightForLength = List.of({-0.3521, 12.4089, 0.08064}); break;
    case  89: return weightForLength = List.of({-0.3521, 12.6495, 0.08045}); break;
    case  90: return weightForLength = List.of({-0.3521, 12.8864, 0.08032}); break;
    case  91: return weightForLength = List.of({-0.3521, 13.1209, 0.08025}); break;
    case  92: return weightForLength = List.of({-0.3521, 13.3541, 0.08025}); break;
    case  93: return weightForLength = List.of({-0.3521, 13.5870, 0.08031}); break;
    case  94: return weightForLength = List.of({-0.3521, 13.8217, 0.08043}); break;
    case  95: return weightForLength = List.of({-0.3521, 14.0600, 0.08060}); break;
    case  96: return weightForLength = List.of({-0.3521, 14.3037, 0.08083}); break;
    case  97: return weightForLength = List.of({-0.3521, 14.5547, 0.08112}); break;
    case  98: return weightForLength = List.of({-0.3521, 14.8140, 0.08146}); break;
    case  99: return weightForLength = List.of({-0.3521, 15.0818, 0.08185}); break;
    case 100: return weightForLength = List.of({-0.3521, 15.3576, 0.08229}); break;
    case 101: return weightForLength = List.of({-0.3521, 15.6412, 0.08277}); break;
    case 102: return weightForLength = List.of({-0.3521, 15.9320, 0.08328}); break;
    case 103: return weightForLength = List.of({-0.3521, 16.2298, 0.08381}); break;
    case 104: return weightForLength = List.of({-0.3521, 16.5342, 0.08436}); break;
    case 105: return weightForLength = List.of({-0.3521, 16.8454, 0.08493}); break;
    case 106: return weightForLength = List.of({-0.3521, 17.1637, 0.08551}); break;
    case 107: return weightForLength = List.of({-0.3521, 17.4894, 0.08611}); break;
    case 108: return weightForLength = List.of({-0.3521, 17.8226, 0.08673}); break;
    case 109: return weightForLength = List.of({-0.3521, 18.1645, 0.08736}); break;
    case 110: return weightForLength = List.of({-0.3521, 18.5158, 0.08800}); break;
    case 111: return weightForLength = List.of({-0.3521, 18.8759, 0.08864}); break;
    case 112: return weightForLength = List.of({-0.3521, 19.2439, 0.08928}); break;
    case 113: return weightForLength = List.of({-0.3521, 19.6185, 0.08991}); break;
    case 114: return weightForLength = List.of({-0.3521, 19.9990, 0.09054}); break;
    case 115: return weightForLength = List.of({-0.3521, 20.3846, 0.09116}); break;
    case 116: return weightForLength = List.of({-0.3521, 20.7741, 0.09177}); break;
    case 117: return weightForLength = List.of({-0.3521, 21.1666, 0.09239}); break;
    case 118: return weightForLength = List.of({-0.3521, 21.5611, 0.09300}); break;
    case 119: return weightForLength = List.of({-0.3521, 21.9568, 0.09362}); break;
    case 120: return weightForLength = List.of({-0.3521, 22.3530, 0.09424}); break;
    default: return weightForLength;
  }
}
}