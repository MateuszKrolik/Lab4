#!/bin/bash

# Pobranie argumentów
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        --date|-d)
        date=$(date +"%Y-%m-%d")
        echo "Dzisiejsza data: $date"
        shift
        ;;
        --logs|-l)
        count="$2"
        if [[ ! $count =~ ^[0-9]+$ ]]; then
            echo "Błędna liczba plików. Podaj poprawną liczbę."
            exit 1
        fi
        for ((i=1; i<=$count; i++))
        do
            echo "log$i.txt" > "log$i.txt"
            echo "Nazwa pliku: log$i.txt" >> "log$i.txt"
            echo "Nazwa skryptu: $0" >> "log$i.txt"
            echo "Data utworzenia: $(date +"%Y-%m-%d")" >> "log$i.txt"
        done
        shift
        shift
        ;;
        --help|-h)
        echo "Dostępne opcje:"
        echo "--date, -d: Wyświetla dzisiejszą datę."
        echo "--logs, -l [liczba]: Tworzy automatycznie określoną liczbę plików logx.txt, gdzie x to numer pliku od 1 do liczba."
        echo "--help, -h: Wyświetla dostępne opcje."
        exit 0
        ;;
        *)
        echo "Nieznana opcja: $key"
        exit 1
        ;;
    esac
done

# Tworzenie pliku .gitignore
echo "*log*" > .gitignore

# Utworzenie tagu v1.0
git tag v1.0

# Wykonanie merge'a na głównym branchu
git checkout głównyBranch
git merge taskBranch
