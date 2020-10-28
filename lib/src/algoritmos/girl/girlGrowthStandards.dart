class StandardGirl {
  //------------------- Longitud para la edad desde nacimiento a 2 años---------------------
  List lengthForAgeGIRLSBirthTo2Years(int month) {
    var longitudParaEdad =  [0.0,0.0,0.0];
    //posicion 0 = Mediana  y posicion 1 =  desviacion estandar 
    switch (month) {      
    case  0: return longitudParaEdad = List.of({49.1477,	1.8627}); break;
    case  1: return longitudParaEdad = List.of({53.6872,	1.9542}); break;
    case  2: return longitudParaEdad = List.of({57.0673,	2.0362}); break;
    case  3: return longitudParaEdad = List.of({59.8029,	2.1051}); break;
    case  4: return longitudParaEdad = List.of({62.0899,	2.1645}); break;
    case  5: return longitudParaEdad = List.of({64.0301,	2.2174}); break;
    case  6: return longitudParaEdad = List.of({65.7311,	2.2664}); break;
    case  7: return longitudParaEdad = List.of({67.2873,	2.3154}); break;
    case  8: return longitudParaEdad = List.of({68.7498,	2.3650}); break;
    case  9: return longitudParaEdad = List.of({70.1435,	2.4157}); break;
    case 10: return longitudParaEdad = List.of({71.4818,	2.4676}); break;
    case 11: return longitudParaEdad = List.of({72.7710,	2.5208}); break;
    case 12: return longitudParaEdad = List.of({74.0150,	2.5750}); break;
    case 13: return longitudParaEdad = List.of({75.2176,	2.6296}); break;
    case 14: return longitudParaEdad = List.of({76.3817,	2.6841}); break;
    case 15: return longitudParaEdad = List.of({77.5099,	2.7392}); break;
    case 16: return longitudParaEdad = List.of({78.6055,	2.7944}); break;
    case 17: return longitudParaEdad = List.of({79.6710,	2.8490}); break;
    case 18: return longitudParaEdad = List.of({80.7079,	2.9039}); break;
    case 19: return longitudParaEdad = List.of({81.7182,	2.9582}); break;
    case 20: return longitudParaEdad = List.of({82.7036,	3.0129}); break;
    case 21: return longitudParaEdad = List.of({83.6654,	3.0672}); break;
    case 22: return longitudParaEdad = List.of({84.6040,	3.1202}); break;
    case 23: return longitudParaEdad = List.of({85.5202,	3.1737}); break;
    case 24: return longitudParaEdad = List.of({86.4153,	3.2267}); break;
      default: return longitudParaEdad;
    }
  }
  //--------------- estatura/Talla para la edad de 2 a 5 años --------------------------------
 List heightForAgeGIRLS2To5Years (int month){
   var estaturaParaEdad =  [0.0,0.0,0.0];
   //posicion 0 = Mediana  y posicion 1 =  desviacion estandar 
   switch (month) {
    case 24: return estaturaParaEdad = List.of({ 85.7153,	3.2267}); break;	
    case 25: return estaturaParaEdad = List.of({ 86.5904,	3.2783}); break;	
    case 26: return estaturaParaEdad = List.of({ 87.4462,	3.3300}); break;	
    case 27: return estaturaParaEdad = List.of({ 88.2830,	3.3812}); break;	
    case 28: return estaturaParaEdad = List.of({ 89.1004,	3.4313}); break;	
    case 29: return estaturaParaEdad = List.of({ 89.8991,	3.4809}); break;	
    case 30: return estaturaParaEdad = List.of({ 90.6797,	3.5302}); break;	
    case 31: return estaturaParaEdad = List.of({ 91.4430,	3.5782}); break;	
    case 32: return estaturaParaEdad = List.of({ 92.1906,	3.6259}); break;	
    case 33: return estaturaParaEdad = List.of({ 92.9239,	3.6724}); break;	
    case 34: return estaturaParaEdad = List.of({ 93.6444,	3.7186}); break;	
    case 35: return estaturaParaEdad = List.of({ 94.3533,	3.7638}); break;	
    case 36: return estaturaParaEdad = List.of({ 95.0515,	3.8078}); break;	
    case 37: return estaturaParaEdad = List.of({ 95.7399,	3.8526}); break;	
    case 38: return estaturaParaEdad = List.of({ 96.4187,	3.8963}); break;	
    case 39: return estaturaParaEdad = List.of({ 97.0885,	3.9389}); break;	
    case 40: return estaturaParaEdad = List.of({ 97.7493,	3.9813}); break;	
    case 41: return estaturaParaEdad = List.of({ 98.4015,	4.0236}); break;	
    case 42: return estaturaParaEdad = List.of({ 99.0448,	4.0658}); break;	
    case 43: return estaturaParaEdad = List.of({ 99.6795,	4.1068}); break;	
    case 44: return estaturaParaEdad = List.of({100.3058,	4.1476}); break;	
    case 45: return estaturaParaEdad = List.of({100.9238,	4.1883}); break;	
    case 46: return estaturaParaEdad = List.of({101.5337,	4.2279}); break;	
    case 47: return estaturaParaEdad = List.of({102.1360,	4.2683}); break;	
    case 48: return estaturaParaEdad = List.of({102.7312,	4.3075}); break;	
    case 49: return estaturaParaEdad = List.of({103.3197,	4.3456}); break;	
    case 50: return estaturaParaEdad = List.of({103.9021,	4.3847}); break;	
    case 51: return estaturaParaEdad = List.of({104.4786,	4.4226}); break;	
    case 52: return estaturaParaEdad = List.of({105.0494,	4.4604}); break;	
    case 53: return estaturaParaEdad = List.of({105.6148,	4.4981}); break;	
    case 54: return estaturaParaEdad = List.of({106.1748,	4.5358}); break;	
    case 55: return estaturaParaEdad = List.of({106.7295,	4.5734}); break;	
    case 56: return estaturaParaEdad = List.of({107.2788,	4.6108}); break;	
    case 57: return estaturaParaEdad = List.of({107.8227,	4.6472}); break;	
    case 58: return estaturaParaEdad = List.of({108.3613,	4.6834}); break;	
    case 59: return estaturaParaEdad = List.of({108.8948,	4.7195}); break;	
    case 60: return estaturaParaEdad = List.of({109.4233,	4.7566}); break;	
     default: return estaturaParaEdad;
   }
 }
//------------------ Peso para la Edad en niñas de 0 a 5 años-------------------
List weightForAgeGIRLSbirthTo5Years(int month){
  var pesoParaEdad =  [0.0,0.0,0.0];
  //posicion 0 = Lambda , posicion 1 = Mediana, posicion 2 = Sigma
  switch (month) {
    case  0: return pesoParaEdad = List.of({ 0.3809,	 3.2322,	0.14171}); break;	
    case  1: return pesoParaEdad = List.of({ 0.1714,	 4.1873,	0.13724}); break;	
    case  2: return pesoParaEdad = List.of({ 0.0962,	 5.1282,	0.13000}); break;	
    case  3: return pesoParaEdad = List.of({ 0.0402,	 5.8458,	0.12619}); break;	
    case  4: return pesoParaEdad = List.of({-0.0050,	 6.4237,	0.12402}); break;	
    case  5: return pesoParaEdad = List.of({-0.0430,	 6.8985,	0.12274}); break;	
    case  6: return pesoParaEdad = List.of({-0.0756,	 7.2970,	0.12204}); break;	
    case  7: return pesoParaEdad = List.of({-0.1039,	 7.6422,	0.12178}); break;	
    case  8: return pesoParaEdad = List.of({-0.1288,	 7.9487,	0.12181}); break;	
    case  9: return pesoParaEdad = List.of({-0.1507,	 8.2254,	0.12199}); break;	
    case 10: return pesoParaEdad = List.of({-0.1700,	 8.4800,	0.12223}); break;	
    case 11: return pesoParaEdad = List.of({-0.1872,	 8.7192,	0.12247}); break;	
    case 12: return pesoParaEdad = List.of({-0.2024,	 8.9481,	0.12268}); break;	
    case 13: return pesoParaEdad = List.of({-0.2158,	 9.1699,	0.12283}); break;	
    case 14: return pesoParaEdad = List.of({-0.2278,	 9.3870,	0.12294}); break;	
    case 15: return pesoParaEdad = List.of({-0.2384,	 9.6008,	0.12299}); break;	
    case 16: return pesoParaEdad = List.of({-0.2478,	 9.8124,	0.12303}); break;	
    case 17: return pesoParaEdad = List.of({-0.2562,	10.0226,	0.12306}); break;	
    case 18: return pesoParaEdad = List.of({-0.2637,	10.2315,	0.12309}); break;	
    case 19: return pesoParaEdad = List.of({-0.2703,	10.4393,	0.12315}); break;	
    case 20: return pesoParaEdad = List.of({-0.2762,	10.6464,	0.12323}); break;	
    case 21: return pesoParaEdad = List.of({-0.2815,	10.8534,	0.12335}); break;	
    case 22: return pesoParaEdad = List.of({-0.2862,	11.0608,	0.12350}); break;	
    case 23: return pesoParaEdad = List.of({-0.2903,	11.2688,	0.12369}); break;	
    case 24: return pesoParaEdad = List.of({-0.2941,	11.4775,	0.12390}); break;	
    case 25: return pesoParaEdad = List.of({-0.2975,	11.6864,	0.12414}); break;	
    case 26: return pesoParaEdad = List.of({-0.3005,	11.8947,	0.12441}); break;	
    case 27: return pesoParaEdad = List.of({-0.3032,	12.1015,	0.12472}); break;	
    case 28: return pesoParaEdad = List.of({-0.3057,	12.3059,	0.12506}); break;	
    case 29: return pesoParaEdad = List.of({-0.3080,	12.5073,	0.12545}); break;	
    case 30: return pesoParaEdad = List.of({-0.3101,	12.7055,	0.12587}); break;	
    case 31: return pesoParaEdad = List.of({-0.3120,	12.9006,	0.12633}); break;	
    case 32: return pesoParaEdad = List.of({-0.3138,	13.0930,	0.12683}); break;	
    case 33: return pesoParaEdad = List.of({-0.3155,	13.2837,	0.12737}); break;	
    case 34: return pesoParaEdad = List.of({-0.3171,	13.4731,	0.12794}); break;	
    case 35: return pesoParaEdad = List.of({-0.3186,	13.6618,	0.12855}); break;	
    case 36: return pesoParaEdad = List.of({-0.3201,	13.8503,	0.12919}); break;	
    case 37: return pesoParaEdad = List.of({-0.3216,	14.0385,	0.12988}); break;	
    case 38: return pesoParaEdad = List.of({-0.3230,	14.2265,	0.13059}); break;	
    case 39: return pesoParaEdad = List.of({-0.3243,	14.4140,	0.13135}); break;	
    case 40: return pesoParaEdad = List.of({-0.3257,	14.6010,	0.13213}); break;	
    case 41: return pesoParaEdad = List.of({-0.3270,	14.7873,	0.13293}); break;	
    case 42: return pesoParaEdad = List.of({-0.3283,	14.9727,	0.13376}); break;	
    case 43: return pesoParaEdad = List.of({-0.3296,	15.1573,	0.13460}); break;	
    case 44: return pesoParaEdad = List.of({-0.3309,	15.3410,	0.13545}); break;	
    case 45: return pesoParaEdad = List.of({-0.3322,	15.5240,	0.13630}); break;	
    case 46: return pesoParaEdad = List.of({-0.3335,	15.7064,	0.13716}); break;	
    case 47: return pesoParaEdad = List.of({-0.3348,	15.8882,	0.13800}); break;	
    case 48: return pesoParaEdad = List.of({-0.3361,	16.0697,	0.13884}); break;	
    case 49: return pesoParaEdad = List.of({-0.3374,	16.2511,	0.13968}); break;	
    case 50: return pesoParaEdad = List.of({-0.3387,	16.4322,	0.14051}); break;	
    case 51: return pesoParaEdad = List.of({-0.3400,	16.6133,	0.14132}); break;	
    case 52: return pesoParaEdad = List.of({-0.3414,	16.7942,	0.14213}); break;	
    case 53: return pesoParaEdad = List.of({-0.3427,	16.9748,	0.14293}); break;	
    case 54: return pesoParaEdad = List.of({-0.3440,	17.1551,	0.14371}); break;	
    case 55: return pesoParaEdad = List.of({-0.3453,	17.3347,	0.14448}); break;	
    case 56: return pesoParaEdad = List.of({-0.3466,	17.5136,	0.14525}); break;	
    case 57: return pesoParaEdad = List.of({-0.3479,	17.6916,	0.14600}); break;	
    case 58: return pesoParaEdad = List.of({-0.3492,	17.8686,	0.14675}); break;	
    case 59: return pesoParaEdad = List.of({-0.3505,	18.0445,	0.14748}); break;	
    case 60: return pesoParaEdad = List.of({-0.3518,	18.2193,	0.14821}); break;	
    default: return pesoParaEdad;
  }
} 
//----------------- Peso para la longitud de 0 a 2 años Puntuacion z -------------------------
List weightForLengthGIRLSbirthTo2Years (int longitud){
	var pesoParaLongitud =  [0.0,0.0,0.0];
  //posicion 0 = Lambda , posicion 1 = Mediana, posicion 2 = Sigma
  switch (longitud) {
  case 45: return pesoParaLongitud = List.of({-0.3833,	 2.4607,	0.09029}); break;
  case 46: return pesoParaLongitud = List.of({-0.3833,	 2.6306,	0.09037}); break;
  case 47: return pesoParaLongitud = List.of({-0.3833,	 2.8007,	0.09044}); break;
  case 48: return pesoParaLongitud = List.of({-0.3833,	 2.9741,	0.09052}); break;
  case 49: return pesoParaLongitud = List.of({-0.3833,	 3.1560,	0.09060}); break;
  case 50: return pesoParaLongitud = List.of({-0.3833,	 3.3518,	0.09068}); break;
  case 51: return pesoParaLongitud = List.of({-0.3833,	 3.5636,	0.09076}); break;
  case 52: return pesoParaLongitud = List.of({-0.3833,	 3.7911,	0.09085}); break;
  case 53: return pesoParaLongitud = List.of({-0.3833,	 4.0332,	0.09093}); break;
  case 54: return pesoParaLongitud = List.of({-0.3833,	 4.2875,	0.09102}); break;
  case 55: return pesoParaLongitud = List.of({-0.3833,	 4.5498,	0.09110}); break;
  case 56: return pesoParaLongitud = List.of({-0.3833,	 4.8162,	0.09118}); break;
  case 57: return pesoParaLongitud = List.of({-0.3833,	 5.0837,	0.09125}); break;
  case 58: return pesoParaLongitud = List.of({-0.3833,	 5.3507,	0.09130}); break;
  case 59: return pesoParaLongitud = List.of({-0.3833,	 5.6151,	0.09134}); break;
  case 60: return pesoParaLongitud = List.of({-0.3833,	 5.8742,	0.09136}); break;
  case 61: return pesoParaLongitud = List.of({-0.3833,	 6.1270,	0.09137}); break;
  case 62: return pesoParaLongitud = List.of({-0.3833,	 6.3738,	0.09135}); break;
  case 63: return pesoParaLongitud = List.of({-0.3833,	 6.6144,	0.09131}); break;
  case 64: return pesoParaLongitud = List.of({-0.3833,	 6.8501,	0.09126}); break;
  case 65: return pesoParaLongitud = List.of({-0.3833,	 7.0812,	0.09119}); break;
  case 66: return pesoParaLongitud = List.of({-0.3833,	 7.3076,	0.09110}); break;
  case 67: return pesoParaLongitud = List.of({-0.3833,	 7.5288,	0.09101}); break;
  case 68: return pesoParaLongitud = List.of({-0.3833,	 7.7448,	0.09090}); break;
  case 69: return pesoParaLongitud = List.of({-0.3833,	 7.9559,	0.09079}); break;
  case 70: return pesoParaLongitud = List.of({-0.3833,	 8.1630,	0.09068}); break;
  case 71: return pesoParaLongitud = List.of({-0.3833,	 8.3666,	0.09056}); break;
  case 72: return pesoParaLongitud = List.of({-0.3833,	 8.5679,	0.09043}); break;
  case 73: return pesoParaLongitud = List.of({-0.3833,	 8.7661,	0.09031}); break;
  case 74: return pesoParaLongitud = List.of({-0.3833,	 8.9601,	0.09018}); break;
  case 75: return pesoParaLongitud = List.of({-0.3833,	 9.1490,	0.09005}); break;
  case 76: return pesoParaLongitud = List.of({-0.3833,	 9.3337,	0.08992}); break;
  case 77: return pesoParaLongitud = List.of({-0.3833,	 9.5166,	0.08979}); break;
  case 78: return pesoParaLongitud = List.of({-0.3833,	 9.7015,	0.08965}); break;
  case 79: return pesoParaLongitud = List.of({-0.3833,	 9.8915,	0.08952}); break;
  case 80: return pesoParaLongitud = List.of({-0.3833,	10.0891,	0.08940}); break;
  case 81: return pesoParaLongitud = List.of({-0.3833,	10.2965,	0.08928}); break;
  case 82: return pesoParaLongitud = List.of({-0.3833,	10.5140,	0.08918}); break;
  case 83: return pesoParaLongitud = List.of({-0.3833,	10.7410,	0.08910}); break;
  case 84: return pesoParaLongitud = List.of({-0.3833,	10.9767,	0.08903}); break;
  case 85: return pesoParaLongitud = List.of({-0.3833,	11.2198,	0.08898}); break;
  case 86: return pesoParaLongitud = List.of({-0.3833,	11.4684,	0.08895}); break;
  case 87: return pesoParaLongitud = List.of({-0.3833,	11.7201,	0.08895}); break;
  case 88: return pesoParaLongitud = List.of({-0.3833,	11.9720,	0.08896}); break;
  case 89: return pesoParaLongitud = List.of({-0.3833,	12.2229,	0.08900}); break;
  case 90: return pesoParaLongitud = List.of({-0.3833,	12.4723,	0.08906}); break;
  case 91: return pesoParaLongitud = List.of({-0.3833,	12.7205,	0.08913}); break;
  case 92: return pesoParaLongitud = List.of({-0.3833,	12.9681,	0.08923}); break;
  case 93: return pesoParaLongitud = List.of({-0.3833,	13.2158,	0.08934}); break;
  case 94: return pesoParaLongitud = List.of({-0.3833,	13.4643,	0.08948}); break;
  case 95: return pesoParaLongitud = List.of({-0.3833,	13.7146,	0.08963}); break;
  case 96: return pesoParaLongitud = List.of({-0.3833,	13.9676,	0.08981}); break;
  case 97: return pesoParaLongitud = List.of({-0.3833,	14.2239,	0.09000}); break;
  case 98: return pesoParaLongitud = List.of({-0.3833,	14.4848,	0.09021}); break;
  case 99: return pesoParaLongitud = List.of({-0.3833,	14.7519,	0.09044}); break;
  case 100: return pesoParaLongitud = List.of({-0.3833,	15.0267,	0.09069}); break;
  case 101: return pesoParaLongitud = List.of({-0.3833,	15.3108,	0.09096}); break;
  case 102: return pesoParaLongitud = List.of({-0.3833,	15.6046,	0.09125}); break;
  case 103: return pesoParaLongitud = List.of({-0.3833,	15.9087,	0.09155}); break;
  case 104: return pesoParaLongitud = List.of({-0.3833,	16.2229,	0.09186}); break;
  case 105: return pesoParaLongitud = List.of({-0.3833,	16.5470,	0.09219}); break;
  case 106: return pesoParaLongitud = List.of({-0.3833,	16.8814,	0.09254}); break;
  case 107: return pesoParaLongitud = List.of({-0.3833,	17.2269,	0.09289}); break;
  case 108: return pesoParaLongitud = List.of({-0.3833,	17.5839,	0.09326}); break;
  case 109: return pesoParaLongitud = List.of({-0.3833,	17.9526,	0.09363}); break;
  case 110: return pesoParaLongitud = List.of({-0.3833,	18.3324,	0.09401}); break;
    default: return pesoParaLongitud;
  }
}
//-------------------- Peso para la altura / Talla  de 2 a5 años ----------------------
List weightForHeightGIRLS2To5Years (int altura){
  var pesoParaAltura =  [0.0,0.0,0.0];
  //posicion 0 = Lambda , posicion 1 = Mediana, posicion 2 = Sigma
  switch (altura) {
    case  65: return pesoParaAltura = List.of({	-0.3833,	 7.2402,	0.09113}); break;	
    case  66: return pesoParaAltura = List.of({	-0.3833,	 7.4630,	0.09104}); break;	
    case  67: return pesoParaAltura = List.of({	-0.3833,	 7.6806,	0.09094}); break;	
    case  68: return pesoParaAltura = List.of({	-0.3833,	 7.8930,	0.09083}); break;	
    case  69: return pesoParaAltura = List.of({	-0.3833,	 8.1012,	0.09071}); break;	
    case  70: return pesoParaAltura = List.of({	-0.3833,	 8.3058,	0.09059}); break;	
    case  71: return pesoParaAltura = List.of({	-0.3833,	 8.5078,	0.09047}); break;	
    case  72: return pesoParaAltura = List.of({	-0.3833,	 8.7070,	0.09035}); break;	
    case  73: return pesoParaAltura = List.of({	-0.3833,	 8.9025,	0.09022}); break;	
    case  74: return pesoParaAltura = List.of({	-0.3833,	 9.0928,	0.09009}); break;	
    case  75: return pesoParaAltura = List.of({	-0.3833,	 9.2786,	0.08996}); break;	
    case  76: return pesoParaAltura = List.of({	-0.3833,	 9.4617,	0.08983}); break;	
    case  77: return pesoParaAltura = List.of({	-0.3833,	 9.6456,	0.08969}); break;	
    case  78: return pesoParaAltura = List.of({	-0.3833,	 9.8338,	0.08956}); break;	
    case  79: return pesoParaAltura = List.of({	-0.3833,	10.0289,	0.08943}); break;	
    case  80: return pesoParaAltura = List.of({	-0.3833,	10.2332,	0.08932}); break;	
    case  81: return pesoParaAltura = List.of({	-0.3833,	10.4477,	0.08921}); break;	
    case  82: return pesoParaAltura = List.of({	-0.3833,	10.6719,	0.08912}); break;	
    case  83: return pesoParaAltura = List.of({	-0.3833,	10.9051,	0.08905}); break;	
    case  84: return pesoParaAltura = List.of({	-0.3833,	11.1462,	0.08899}); break;	
    case  85: return pesoParaAltura = List.of({	-0.3833,	11.3934,	0.08896}); break;	
    case  86: return pesoParaAltura = List.of({	-0.3833,	11.6444,	0.08895}); break;	
    case  87: return pesoParaAltura = List.of({	-0.3833,	11.8965,	0.08896}); break;	
    case  88: return pesoParaAltura = List.of({	-0.3833,	12.1478,	0.08899}); break;	
    case  89: return pesoParaAltura = List.of({	-0.3833,	12.3976,	0.08904}); break;	
    case  90: return pesoParaAltura = List.of({	-0.3833,	12.6461,	0.08911}); break;	
    case  91: return pesoParaAltura = List.of({	-0.3833,	12.8939,	0.08920}); break;	
    case  92: return pesoParaAltura = List.of({	-0.3833,	13.1415,	0.08931}); break;	
    case  93: return pesoParaAltura = List.of({	-0.3833,	13.3896,	0.08944}); break;	
    case  94: return pesoParaAltura = List.of({	-0.3833,	13.6393,	0.08959}); break;	
    case  95: return pesoParaAltura = List.of({	-0.3833,	13.8914,	0.08975}); break;	
    case  96: return pesoParaAltura = List.of({	-0.3833,	14.1466,	0.08994}); break;	
    case  97: return pesoParaAltura = List.of({	-0.3833,	14.4059,	0.09015}); break;	
    case  98: return pesoParaAltura = List.of({	-0.3833,	14.6710,	0.09037}); break;	
    case  99: return pesoParaAltura = List.of({	-0.3833,	14.9434,	0.09062}); break;	
    case 100: return pesoParaAltura = List.of({	-0.3833,	15.2246,	0.09088}); break;	
    case 101: return pesoParaAltura = List.of({	-0.3833,	15.5154,	0.09116}); break;	
    case 102: return pesoParaAltura = List.of({	-0.3833,	15.8164,	0.09146}); break;	
    case 103: return pesoParaAltura = List.of({	-0.3833,	16.1276,	0.09177}); break;	
    case 104: return pesoParaAltura = List.of({	-0.3833,	16.4488,	0.09209}); break;	
    case 105: return pesoParaAltura = List.of({	-0.3833,	16.7800,	0.09243}); break;	
    case 106: return pesoParaAltura = List.of({	-0.3833,	17.1220,	0.09278}); break;	
    case 107: return pesoParaAltura = List.of({	-0.3833,	17.4755,	0.09315}); break;	
    case 108: return pesoParaAltura = List.of({	-0.3833,	17.8407,	0.09352}); break;	
    case 109: return pesoParaAltura = List.of({	-0.3833,	18.2174,	0.09390}); break;	
    case 110: return pesoParaAltura = List.of({	-0.3833,	18.6043,	0.09428}); break;	
    case 111: return pesoParaAltura = List.of({	-0.3833,	19.0009,	0.09467}); break;	
    case 112: return pesoParaAltura = List.of({	-0.3833,	19.4060,	0.09507}); break;	
    case 113: return pesoParaAltura = List.of({	-0.3833,	19.8190,	0.09546}); break;	
    case 114: return pesoParaAltura = List.of({	-0.3833,	20.2385,	0.09586}); break;	
    case 115: return pesoParaAltura = List.of({	-0.3833,	20.6629,	0.09626}); break;	
    case 116: return pesoParaAltura = List.of({	-0.3833,	21.0909,	0.09666}); break;	
    case 117: return pesoParaAltura = List.of({	-0.3833,	21.5213,	0.09707}); break;	
    case 118: return pesoParaAltura = List.of({	-0.3833,	21.9529,	0.09747}); break;	
    case 119: return pesoParaAltura = List.of({	-0.3833,	22.3851,	0.09788}); break;	
    case 120: return pesoParaAltura = List.of({	-0.3833,	22.8173,	0.09828}); break;	
    default: return pesoParaAltura;
  }
}
}
