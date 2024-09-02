### 변수

변수는 var 변수명 = 값 형식으로 선언한다.
타입을 추론하는 타입 추론 기능을 제공하며, 명시적으로 타입을 선언하지 않아도 된다.
중간에 변수 값을 변경할 수 있다.
변수명 종복은 안된다.
```dart
void main(){
    var name = "TEST";
    var name = "World"
}
```


dynamic 키워드 또한 var 키워드와 마찬가지로 변수의 타입을 유추하는 키워드.
타입을 한 번 유추하면 추론된 타입이 고정된다.
따라서 고정된 변수 타입과 다른 변수 타입의 값을 같은 변수에 다시 저장하려 들면, 에러가 난다.
다이나믹 키워드를 사용하면 변수의 타입이 고정되지 않고 , 다른 타입으로 저장할 수 있다.
```dart
void main(){
    dynamic name = "TEST";
    name = 1;
}
```


### final , const

fianl은 런타임, const는 빌드 타임 상수.
final은 런타임시 한번 할당되면 변경 불가능,  const는 컴파일 단계에서 선언된다.

```dart
void main(){
    final String name = 'TEST';
    name = 'World';     // 에러 발생

    const String name2 = "TEST";
    name2 = "World"     // 에러 발생
}

void main(){
    // 동작
    final DateTime now = DateTime.now();


    // 에러
    const DateTime now2 = DateTime.now();
}

```


### List