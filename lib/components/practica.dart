import 'dart:math';

//
void main() async {
  String result =
      operacion(operacion: "division", numeroBase: 5, numeroOperador: 0);
  print(result);

  int numeroPrimos = 6;
  var resultPrimo = numPrimos(numeroPrimos);
  print("NUmeros primos:");
  for (var element in resultPrimo) {
    print("$element, ");
  }
  
  String cifrado = cifrarCesar(desplazamiento: 3, mensaje: "ABC");
  print(cifrado);

  int numeroAmstrom = 153;
  if (numeroArmStrong(numeroAmstrom)) {
    print("Es numero Armstrong");
  } else {
    print("No es numero Armstrong");
  }
}

//--------------------------------------------------- METODOS ----------------------------------------------------------
int suma({required int numero, required int segundoNumero}) {
  return numero + segundoNumero;
}

int multiplicacion({required int multiplicando, required int multiplicador}) {
  return multiplicando * multiplicador;
}

int resta({required int minuendo, required int sustraendo}) {
  return minuendo - sustraendo;
}

double division({required int dividendo, required int divisor}) {
  return dividendo / divisor;
}

String operacion(
    {required String operacion,
    required int numeroBase,
    required int numeroOperador}) {
  //Requiere las tres bases
  if (operacion == "suma") {
    operacion =
        "La suma es ${suma(numero: numeroBase, segundoNumero: numeroOperador)}";
  } else if (operacion == "resta") {
    operacion =
        "La resta es ${(minuendo: numeroBase, sustraendo: numeroOperador)}";
  } else if (operacion == "multiplicacion") {
    operacion = "La multiplicacion es ${(
      multiplicando: numeroBase,
      multiplicador: numeroOperador
    )}";
  } else if (operacion == "division") {
    if (numeroOperador != 0) {
      //Validacion  que el divisor no sea cero
      operacion =
          "La division es ${division(dividendo: numeroBase, divisor: numeroOperador)}";
    } else {
      operacion = "El divisor (numero operador) no puede ser Cero";
    }
  } else {
    operacion = "operacion desconocida";
  }

  return operacion;
}

//--------------------------------------------------- Numeros Primos ----------------------------------------------------------
List<int> numPrimos(int cantidad) {
  List<int> result = [];
  int primo = 1;
  while (cantidad > 0) {
    if (esPrimo(primo)) {
      //Si el numero es primo se lo añade
      result.add(primo);
      //print(primo);
      cantidad--;
    }
    primo++;
  }
  return result;
}

bool esPrimo(int numero) {
  if (numero < 2) {
    return false;
  }
  for (int i = 2; i <= (numero / 2); i++) {
    if (numero % i == 0) {
      // Modulo del incremento para saber si es par
      return false;
    }
  }
  return true; // si no entra al if es true
}

List<int> listaPrimos({required int cantidad}) {
  List<int> numPrimos = [];
  for (var i = 2; i <= cantidad; i++) {
    for (var d = 2; d < i; i++) {
      if (i % 2 != 0) {
        numPrimos.add(i);
      }
    }
  }
  return numPrimos;
}

//--------------------------------------------------- CESAR ----------------------------------------------------------
String cifrarCesar({required int desplazamiento, required String mensaje}) {
  mensaje = mensaje.toUpperCase(); //convertir mayuscula
  String alfabeto = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"; //Alfabeto para iterar
  String nuevoAlfabeto = ""; // EL alfabeto MOdificado con desplazamiento
  String cifrado = ""; //El mensaje cifrado
  while (desplazamiento >= 27) {
    //por si el dezplazamiento es mayor al alfabeto
    desplazamiento -= 27;
  }
  for (var i = 0; i < alfabeto.length; i++) {
    if (i + desplazamiento >= alfabeto.length) {
      //SI el desplazamiento es mayor se le restara la cantidad del alfabeto
      // 25 26   0  1
      // Y   Z   A  B
      int nuevo = (i + desplazamiento - 27);
      nuevoAlfabeto += alfabeto[nuevo];
    } else {
      nuevoAlfabeto += alfabeto[
          i + desplazamiento]; //añade al alfabetomodificado la letra modificada
    }
  }
  for (var i = 0; i < mensaje.length; i++) {
    for (var j = 0; j < nuevoAlfabeto.length; j++) {
      if (mensaje[i] == alfabeto[j]) {
        // Comprueba cada letra del mensaje con el alfabeto sin modificar
        cifrado +=
            nuevoAlfabeto[j]; // y se añade la letra del alfabeto modificado
        break;
      }
    }
  }
  return cifrado;
}

//--------------------------------------------------- 5 ----------------------------------------------------------
bool numeroArmStrong(int numero) {
  int aux = numero; //para verificar la condicion armstron
  int resultado = 0;
  int n = numero.toString().length; // para saber a que numero elevar

  while (numero != 0) {
    int digit = numero % 10; //iteracion para obtener cada digito
    resultado += pow(digit, n).toInt();
    numero = (numero / 10).toInt();
  }
  if (resultado == aux) {
    return true;
  } else {
    return false;
  }
}
