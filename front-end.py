import mysql.connector
from tkinter import *
from tkinter import ttk

myDb = mysql.connector.connect(host= "localhost", user="root", passwd="")
myCursor = myDb.cursor()

window = Tk()
window.title("Front-End")
window.geometry("1000x1000")
def get_data(table_name, database_name):
    myCursor.execute("USE " + str(database_name))
    myCursor.execute("SELECT * FROM " + str(table_name))
    data = myCursor.fetchall()
    print(data)
#getting the names of all databases
myCursor.execute("SHOW DATABASES WHERE `Database` NOT IN ('mysql', 'information_schema', 'performance_schema')")
databases = myCursor.fetchall()
tabs = []
for i in databases:
    tabs.append(i)
#creating a tab for each database
my_notebook = ttk.Notebook(window)
tab = []
for i in range(len(tabs)):
    tab.append(ttk.Frame(my_notebook, width=1000, height=1000, relief="raised", border=50))
    my_notebook.add(tab[i], text=tabs[i][0])
    myCursor.execute("USE " + tabs[i][0])
    myCursor.execute("SHOW TABLES")
    tables = myCursor.fetchall()
    table_names = []
    for j in tables:
        table_names.append(j)
    for k in range(len(table_names)):
        get_data(table_names[k][0], tabs[i][0])
    #tab[i].pack(fill="both", expand=1)

    
my_notebook.pack()
window.mainloop()

#Creating a function to get the data from the table

my_notebook.pack()

window.configure(background='#f2f2f2')
window.mainloop()