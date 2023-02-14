# Домашнее задание к занятию "5. Основы golang"

С `golang` в рамках курса, мы будем работать не много, поэтому можно использовать любой IDE. 
Но рекомендуем ознакомиться с [GoLand](https://www.jetbrains.com/ru-ru/go/).  

## Задача 1. Установите golang.
1. Воспользуйтесь инструкций с официального сайта: [https://golang.org/](https://golang.org/).
2. Так же для тестирования кода можно использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

##Ответ
```
ret@ret-vm:~/Desktop$ sudo apt install golang
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages were automatically installed and are no longer required:
  libflashrom1 libftdi1-2 libllvm13 linux-headers-5.15.0-25
  linux-headers-5.15.0-25-generic linux-image-5.15.0-25-generic
  linux-modules-5.15.0-25-generic linux-modules-extra-5.15.0-25-generic
Use 'sudo apt autoremove' to remove them.
The following additional packages will be installed:
  binutils binutils-common binutils-x86-64-linux-gnu g++ g++-11 gcc gcc-11
  golang-1.18 golang-1.18-doc golang-1.18-go golang-1.18-src golang-doc
  golang-go golang-src libasan6 libbinutils libc-dev-bin libc-devtools
  libc6-dev libcc1-0 libcrypt-dev libctf-nobfd0 libctf0 libdpkg-perl
  libfile-fcntllock-perl libgcc-11-dev libitm1 liblsan0 libnsl-dev
  libquadmath0 libstdc++-11-dev libtirpc-dev libtsan0 libubsan1 linux-libc-dev
  manpages-dev pkg-config rpcsvc-proto
Suggested packages:
  binutils-doc g++-multilib g++-11-multilib gcc-11-doc gcc-multilib make
  autoconf automake libtool flex bison gcc-doc gcc-11-multilib gcc-11-locales
  bzr | brz mercurial subversion glibc-doc debian-keyring bzr libstdc++-11-doc
  dpkg-dev
The following NEW packages will be installed:
  binutils binutils-common binutils-x86-64-linux-gnu g++ g++-11 gcc gcc-11
  golang golang-1.18 golang-1.18-doc golang-1.18-go golang-1.18-src golang-doc
  golang-go golang-src libasan6 libbinutils libc-dev-bin libc-devtools
  libc6-dev libcc1-0 libcrypt-dev libctf-nobfd0 libctf0 libdpkg-perl
  libfile-fcntllock-perl libgcc-11-dev libitm1 liblsan0 libnsl-dev
  libquadmath0 libstdc++-11-dev libtirpc-dev libtsan0 libubsan1 linux-libc-dev
  manpages-dev pkg-config rpcsvc-proto
0 upgraded, 39 newly installed, 0 to remove and 11 not upgraded.
Need to get 135 MB of archives.
After this operation, 619 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
```
```
ret@ret-vm:~/Desktop$ go version
go version go1.18.1 linux/amd64
```


## Задача 2. Знакомство с gotour.
У Golang есть обучающая интерактивная консоль [https://tour.golang.org/](https://tour.golang.org/). 
Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, 
осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана. 

##Ответ

Пощелкал 

## Задача 3. Написание кода. 
Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода 
на своем компьютере, либо использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные 
у пользователя, а можно статически задать в коде.
    Для взаимодействия с пользователем можно использовать функцию `Scanf`:
    ```
    package main
    
    import "fmt"
    
    func main() {
        fmt.Print("Enter a number: ")
        var input float64
        fmt.Scanf("%f", &input)
    
        output := input * 2
    
        fmt.Println(output)    
    }
    ```
##Ответ
```
ret@ret-vm:~/Desktop/golang$ cat script1/script1.go 
package main

import "fmt"

func main() {
    fmt.Print("Enter meters: ")
    var input float64
    fmt.Scanf("%f", &input)

    output := input / 0.3048 

    fmt.Println(output, "ft")
}
ret@ret-vm:~/Desktop/golang$ go run script1/script1.go 
Enter meters: 5
16.404199475065617 ft
ret@ret-vm:~/Desktop/golang$ go run script1/script1.go 
Enter meters: 7
22.96587926509186 ft
ret@ret-vm:~/Desktop/golang$ 
```
 
2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
    ```
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    ```
##Ответ
```
ret@ret-vm:~/Desktop/golang$ cat script2/script2.go 
package main
import "fmt"

func main() {

	x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}

	min := x[0]
	for _, n := range x {
		if n < min {
			min = n
		}
	}

	fmt.Println(min)
}
ret@ret-vm:~/Desktop/golang$ go run script2/script2.go 
9
ret@ret-vm:~/Desktop/golang$ 
```
3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

##Ответ
```
ret@ret-vm:~/Desktop/golang$ cat script3/script3.go 
package main
import "fmt"

func main() {
	for i := 1; i <= 100; i++ {
		if i % 3 == 0 {
			fmt.Printf( "%v\n", i )
		}
	}
}
ret@ret-vm:~/Desktop/golang$ go run script3/script3.go 
3
6
9
12
15
18
21
24
27
30
33
36
39
42
45
48
51
54
57
60
63
66
69
72
75
78
81
84
87
90
93
96
99
ret@ret-vm:~/Desktop/golang$ 
```

В виде решения ссылку на код или сам код. 

## Задача 4. Протестировать код (не обязательно).

Создайте тесты для функций из предыдущего задания. 

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

