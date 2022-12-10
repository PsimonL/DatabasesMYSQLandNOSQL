########################################################################################################
#Biblioteki
########################################################################################################
from tkinter import *
from tkinter import ttk
import sqlite3
########################################################################################################
#root, kursor i połączenie z db
root = Tk()
root.title('Database GUI')
root.geometry("500x500")

#ALL IS BASED ON SQL LITE
#Creating or connecting to Database
connection = sqlite3.connect("GUI.db")
#Creating cursor
cursor = connection.cursor()
#Commit changes
#connection.commit()
#Close connection
#connection.close()
########################################################################################################
#COMMENTED
#COMMENTED
#COMMENTED
########################################################################################################
#create table osoby
'''table_osoby = """CREATE TABLE
osoby(ID_osoby INTEGER,
nazwisko TEXT,
imie TEXT,
adres TEXT)"""
cursor.execute(table_osoby)
connection.commit()

#create table ksiazki
table_ksiazki = """CREATE TABLE ksiazki(
id_ksiazki INTEGER,
tytul TEXT,
autor TEXT)"""
cursor.execute(table_ksiazki)
connection.commit()

#create table wypozyczenia
table_wypozyczenia = """CREATE TABLE wypozyczenia(
id_wypozyczenia INTEGER,
ksiazka_id INTEGER,
osoba_id INTEGER,
data_wypozyczenia TEXT)"""
cursor.execute(table_wypozyczenia)
connection.commit()

"""add to osoby"""
cursor.execute("INSERT INTO osoby VALUES (1, 'S', 'Z', 'Kraków, ul. Ignacego Krasickiego 23/8')")
cursor.execute("INSERT INTO osoby VALUES (2, 'Dębowski', 'Piotr', 'Kraków, ul. Zielona 12/7')")
cursor.execute("INSERT INTO osoby VALUES (3, 'Kulik', 'Eugeniusz', 'Wieliczka, ul. Krakowska 7')")
cursor.execute("INSERT INTO osoby VALUES (4, 'Sikora', 'Jan', 'Kraków, ul. Tatrzańska 7/9')")
connection.commit()

"""add to ksiazki"""
cursor.execute("INSERT INTO ksiazki VALUES (1, 'Analiza mateamtyczna', 'Kowalski Jan')")
cursor.execute("INSERT INTO ksiazki VALUES (2, 'Rachunek prawdopodobieństwa', 'Batko Łukasz')")
cursor.execute("INSERT INTO ksiazki VALUES (3, 'Fizyka dla inżynierów', 'Kalestyński Andrzej')")
cursor.execute("INSERT INTO ksiazki VALUES (4, 'C++: Wprowadzenie', 'Balcerzak Józef')")
cursor.execute("INSERT INTO ksiazki VALUES (5, 'Bazy danych: wprowadzenie', 'Wasiak Jan')")
connection.commit()

"""add to wypozyczenia"""
cursor.execute("INSERT INTO wypozyczenia VALUES (1, 1, 1, '2007-11-07')")
cursor.execute("INSERT INTO wypozyczenia VALUES (2, 2, 2, '2007-12-09')")
cursor.execute("INSERT INTO wypozyczenia VALUES (3, 3, 3, '2007-12-10')")
cursor.execute("INSERT INTO wypozyczenia VALUES (4, 2, 4, '2008-01-04')")
cursor.execute("INSERT INTO wypozyczenia VALUES (5, 3, 2, '2008-01-07')")
connection.commit()'''
########################################################################################################
#Funkcje
def os_print():
    table_os = Tk()
    table_os.title("Tabela osob")
    table_os.geometry("100x100")
    window_table_os = Frame(table_os)
    window_table_os.pack()

    tree = ttk.Treeview(table_os, column=("c1", "c2", "c3", "c4"), show='headings')
    tree.column("#1", anchor=CENTER)
    tree.heading("#1", text="id_osoby")
    tree.column("#2", anchor=CENTER)
    tree.heading("#2", text="nazwisko")
    tree.column("#3", anchor=CENTER)
    tree.heading("#3", text="imie")
    tree.column("#4", anchor=CENTER, width=300)
    tree.heading("#4", text="adres")
    tree.pack()

    cursor.execute("SELECT * FROM osoby")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
        tree.insert("", END, values=row)
    connection.commit()

    cursor.execute("SELECT * FROM osoby")
    print("Wypisanie tabeli osob: ")
    for row in cursor.fetchall():
        print(row)
    connection.commit()

def ks_print():
    table_ks = Tk()
    table_ks.title("Tabela ksiazek")
    table_ks.geometry("600x600")
    window_table_ks = Frame(table_ks)
    window_table_ks.pack()

    tree = ttk.Treeview(table_ks, column=("c1", "c2", "c3"), show='headings')
    tree.column("#1", anchor=CENTER)
    tree.heading("#1", text="id_ksiazki")
    tree.column("#2", anchor=CENTER)
    tree.heading("#2", text="tytul")
    tree.column("#3", anchor=CENTER)
    tree.heading("#3", text="autor")
    tree.pack()

    cursor.execute("SELECT * FROM ksiazki")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
        tree.insert("", END, values=row)
    connection.commit()

    cursor.execute("SELECT * FROM ksiazki")
    print("Wypisanie tabeli ksiazek: ")
    for row in cursor.fetchall():
        print(row)
    connection.commit()

def wyp_print():
    table_wyp = Tk()
    table_wyp.title("Tabela wypozyczen")
    table_wyp.geometry("600x600")
    window_table_wyp = Frame(table_wyp)
    window_table_wyp.pack()

    tree = ttk.Treeview(table_wyp, column=("c1", "c2", "c3", "c4"), show='headings')
    tree.column("#1", anchor=CENTER)
    tree.heading("#1", text="id_wypozyczenia")
    tree.column("#2", anchor=CENTER)
    tree.heading("#2", text="ksiazka_id")
    tree.column("#3", anchor=CENTER)
    tree.heading("#3", text="osoba_id")
    tree.column("#4", anchor=CENTER)
    tree.heading("#4", text="data_wypozyczenia")
    tree.pack()

    cursor.execute("SELECT * FROM wypozyczenia")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
        tree.insert("", END, values=row)
    connection.commit()

    cursor.execute("SELECT * FROM wypozyczenia")
    print("Wypisanie tabeli wypozyczen: ")
    for row in cursor.fetchall():
        print(row)
    connection.commit()

def kwe1_print():
    query1 = Tk()
    query1.title("Zestawienie danych 1")
    query1.geometry("600x600")
    window_query1 = Frame(query1)
    window_query1.pack()

    tree = ttk.Treeview(query1, column=("c1", "c2", "c3","c4", "c5", "c6"), show='headings')
    tree.column("#1", anchor=CENTER)
    tree.heading("#1", text="id_wypozyczenia")
    tree.column("#2", anchor=CENTER)
    tree.heading("#2", text="tytul")
    tree.column("#3", anchor=CENTER)
    tree.heading("#3", text="autor")
    tree.column("#4", anchor=CENTER)
    tree.heading("#4", text="nazwisko")
    tree.column("#5", anchor=CENTER)
    tree.heading("#5", text="imie")
    tree.column("#6", anchor=CENTER)
    tree.heading("#6", text="data_wypozyczenia")
    tree.pack()

    cursor.execute("""SELECT wypozyczenia.id_wypozyczenia, 
    ksiazki.tytul, ksiazki.autor, 
    osoby.nazwisko, osoby.imie,
    wypozyczenia.data_wypozyczenia FROM osoby, ksiazki, wypozyczenia 
    WHERE wypozyczenia.ksiazka_id = ksiazki.id_ksiazki AND osoby.id_osoby = wypozyczenia.osoba_id
    ORDER BY id_wypozyczenia""")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
        tree.insert("", END, values=row)
    connection.commit()

    cursor.execute("""SELECT wypozyczenia.id_wypozyczenia, 
    ksiazki.tytul, ksiazki.autor, 
    osoby.nazwisko, osoby.imie,
    wypozyczenia.data_wypozyczenia FROM osoby, ksiazki, wypozyczenia 
    WHERE wypozyczenia.ksiazka_id = ksiazki.id_ksiazki AND osoby.id_osoby = wypozyczenia.osoba_id
    ORDER BY id_wypozyczenia""")
    print("Kwerenda 1:")
    for row in cursor.fetchall():
        print(row)
    connection.commit()

def kwe2_print():
    query2 = Tk()
    query2.title("Zestawienie danych 2")
    query2.geometry("600x600")
    window_query2 = Frame(query2)
    window_query2.pack()

    tree = ttk.Treeview(query2, column=("c1", "c2", "c3"), show='headings')
    tree.column("#1", anchor=CENTER)
    tree.heading("#1", text="nazwisko")
    tree.column("#2", anchor=CENTER)
    tree.heading("#2", text="imie")
    tree.column("#3", anchor=CENTER)
    tree.heading("#3", text="liczba wypozyczonych ksiazek")
    tree.pack()

    cursor.execute("""SELECT nazwisko, imie, COUNT(osoba_id) AS "liczba wypozyczoncyh ksiazek" FROM osoby, wypozyczenia
    WHERE wypozyczenia.osoba_id = osoby.id_osoby GROUP BY osoba_id""")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
        tree.insert("", END, values=row)
    connection.commit()

    cursor.execute("""SELECT nazwisko, imie, COUNT(osoba_id) FROM osoby, wypozyczenia
    WHERE wypozyczenia.osoba_id = osoby.id_osoby GROUP BY osoba_id""")
    print("Kwerenda 2:")
    for row in cursor.fetchall():
        print(row)
    connection.commit()
########################################################################################################
#mainloop
########################################################################################################
osoby_print_button = Button(root, text="Wyswietlenie tabeli osob",
                            padx=50, pady=40, command=os_print)
ksiazki_print_button = Button(root, text="Wyswietlenie tabeli ksiazek",
                            padx=50, pady=40, command=ks_print)
wypozyczenia_print_button = Button(root, text="Wyswietlenie tabeli wypozyczen",
                            padx=40, pady=40, command=wyp_print)
kwerenda1_print_button = Button(root, text="Zestawienie danych 1",
                            padx=50, pady=40, command=kwe1_print)
kwerenda2_print_button = Button(root, text="Zestawienie danych 2",
                            padx=50, pady=40, command=kwe2_print)

osoby_print_button.pack()
ksiazki_print_button.pack()
wypozyczenia_print_button.pack()
kwerenda1_print_button.pack()
kwerenda2_print_button.pack()

root.mainloop()

