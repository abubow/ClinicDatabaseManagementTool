import mysql.connector
from tkinter import *
from tkinter import ttk

myDb = mysql.connector.connect(host= "localhost", user="root", passwd="")
myCursor = myDb.cursor()
def get_data(table_name, database_name):
    myCursor.execute("USE " + str(database_name))
    myCursor.execute("SELECT * FROM " + str(table_name))
    data = myCursor.fetchall()
    #print(data)
#getting the names of all databases
myCursor.execute("SHOW DATABASES WHERE `Database` NOT IN ('mysql', 'information_schema', 'performance_schema')")
databases = myCursor.fetchall()
tabs = []
for i in databases:
    tabs.append(i)


# set a background color
backGroundColor = '#2A363B'
# set a font color
fontColor = '#FFFFFF'
# set selected color
selectedColor = '#E84A5F'
# create a window
window = Tk()
# set a title
window.title("Front-End") 
 # set a size
window.geometry("1000x1000")
window.configure(background=backGroundColor, highlightcolor=selectedColor)
# disable resizing
#window.resizable(0, 0)
#disable the top bar
window.overrideredirect(True)
# creating top bar
topBar = Frame(window, width=1000, height=30, bg=backGroundColor, relief="raised")
topBar.pack(side=TOP, fill=X, expand=1)
# creating close button
closeButton = Button(topBar, text="X", width=3, height=1, bg=backGroundColor, fg="#FFFFFF", command=window.destroy, borderwidth=0)
closeButton.pack(side=RIGHT, padx=5, pady=5)
# creating a top bar label
topBarLabel = Label(topBar, text="Clinic Appointment Database", font=("Roboto", 12), bg=backGroundColor, fg="#FFFFFF")
topBarLabel.pack(side=LEFT, padx=5, pady=5)
def move_window(event):
    window.geometry("+{0}+{1}".format(event.x_root, event.y_root))
# allow the window to be moved by dragging the top bar
topBar.bind('<B1-Motion>', move_window)



# divide the window into two parts

#top for the Label
top = Frame(window,bg=backGroundColor)
top.pack(side=TOP)
# create a label
label = Label(top, text="Clinic Management System", font=("Roboto", 20, "bold"), bg=backGroundColor, fg=fontColor)
label.pack( side=LEFT, padx=10, pady=10, fill=X)


# bottom for the tabs
bottom = Frame(window, bg=backGroundColor)
bottom.pack(side=BOTTOM)
# creating style for the tabs
style = ttk.Style()
style.configure('my.TNotebook', background=backGroundColor, foreground=selectedColor, font=('Roboto', 10, 'bold'))
style.configure('my.TNotebook.Tab', background=backGroundColor, foreground=selectedColor, font=('Roboto', 10, 'bold'))
#creating a tab for each database
my_notebook = ttk.Notebook(bottom)
tab = []
for i in range(len(tabs)):
    tab.append(ttk.Frame(my_notebook, height=950, width=1000, style='my.TNotebook'))
    tab[i].pack(fill="both", expand=2)
    my_notebook.add(tab[i], text="  " + tabs[i][0] + "  ")
    myCursor.execute("USE " + tabs[i][0])
    myCursor.execute("SHOW TABLES")
    tables = myCursor.fetchall()
    table_names = []
    for j in tables:
        table_names.append(j)
    for k in range(len(table_names)):
        get_data(table_names[k][0], tabs[i][0])
    # creating a label for each table
    table_labels = []
    for j in range(len(table_names)):
        table_labels.append(Label(tab[i], text=table_names[j][0], font=("Roboto", 12, "bold"), bg=backGroundColor, fg=fontColor))
        table_labels[j].pack(side=LEFT, padx=10, pady=10, fill=X)
    # creating a button for each table
my_notebook.pack()
window.mainloop()
myDb.close()
myCursor.close()
window.destroy()
exit()