# Genetic-Algorithm
Project for subject "AE": Warsaw University of Technology

Celem projektu jest znalezienie rozwiązania problemu plecakowego (wygenerowanego przez skrypt1.m) za pomocą algorytmu genetycznego

## Uruchomienie programu
Żeby uruchomić program i znaleźć rozwiązanie należy w MATLABIE uruchomić funkcję AE z następującymi parametrami:
- items: macierz przechowująca dostępne przedmioty z dwoma cechami: waga i wartość
- N: liczba przedmiotów w plecaku
- nPop: rozmiar populacji algorytmu genetycznego
- pCross: prawdopodobieństwo krzyżowania
- pMut: prawdopodobieństwo mutacji
- it: liczba iteracji algorytmu

Funkcja zwróci następujące wartości:
- X: wektor binarny o rozmiarze N, będący rozwiązaniem zadania
- value: wartość plecaka na podstawie wektora X
- totalCrossed: liczba skrzyżowanych osobników w trakcie trwania algorytmu
- totalMutated: liczba zmutowanych osobników w trakcie trwania algorytmu