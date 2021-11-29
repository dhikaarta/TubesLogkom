# Harvest Star
Tugas Besar IF2121 Logika Komputasional: I Got Scammed By My Client And Have to Restart My Life As A Farmer "A Farmer’s Life is Not That Bad, I Think"

## Table of Contents
* [General Information](#general-information)
* [Screenshots](#screenshots)
* [Structures](#structures)
* [Setup](#setup)
* [Usage](#usage)
* [Authors](#authors)

## General Information
Harvest Star merupakan farm simulator role-playing game yang dibuat menggunakan bahasa Prolog yang memiliki paradigma deklaratif. Untuk menyelesaikan permainan ini, pemain harus mencari 20.000 gold guna membayar hutang dalam jangka 1 tahun. Pemain bisa melakukan 3 kegiatan utama untuk mendapatkan gold, yaitu dengan fishing, farming, atau ranching.

## Screenshots
### Tampilan Start Game
![Start Game](./test/1.png)
### Tampilan Map
![Map](./test/2.png)
### Tampilan End Game
![End Game](./test/3.png)

## Structures
```bash
C:.
│   README.md
│   
├───src
│       exploration.pl
│       farming.pl
│       fishing.pl
│       house.pl
│       inventory.pl
│       items.pl
│       main.pl
│       map.pl
│       market.pl
│       player.pl
│       quest.pl
│       ranching.pl
│       randomevent.pl
│       season.pl
│       weather.pl
│
└───test
        1.png
        2.png
        3.png
```

## Setup
* Pastikan anda telah memiliki GNU Prolog Compiler. Jika Anda belum memiliki GNU Prolog Compiler, Anda dapat download compiler tersebut menggunakan link [berikut](http://www.gprolog.org/) dan install pada komputer Anda.

## Usage
* Clone repository ini menggunakan link `https://github.com/dhikaarta/TubesLogkom.git`.
* Buka aplikasi GNU Prolog Compiler dan ubah directory dari compiler tersebut menjadi directory tempat anda melakukan clone repository. Hal tersebut dapat dilakukan dengan membuka option `File > Change Dir...` dan navigate ke folder `src` di dalam directory clone repository.
* Jalankan perintah `['main.pl'].` untuk melakukan kompilasi seluruh file Prolog pada program.
* Jalankan perintah `start.` untuk memulai permainan.

## Authors
* [Rayhan Kinan Muhannad - 13520065](https://github.com/rayhankinan)
* [Andhika Arta Aryanto - 13520081](https://github.com/dhikaarta)
* [Sarah Azka Arief - 13520083](https://github.com/azkazkazka)
* [Aira Thalca Avila Putra - 13520101](https://github.com/airathalca)