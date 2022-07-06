import mysql.connector
from tkinter import *
from tkinter import ttk

myDb = mysql.connector.connect(host= "localhost", user="root", passwd="")
myCursor = myDb.cursor()
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
closeIcon = PhotoImage(file="D:\Git_Repos\ClinicAppointmentDatabase\close.gif", width=20, height=20)
closeButton = Button ( topBar, text="X", width=3, height=1, bg=backGroundColor, fg="#FFFFFF",
                        command=window.destroy, borderwidth=2, relief="flat", 
                        image=closeIcon, compound="left", font=("Arial", 10))
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

def get_data(table_name, database_name):
    myCursor.execute("USE " + str(database_name))
    myCursor.execute("SELECT * FROM " + str(table_name))
    data = myCursor.fetchall()
    return data

def get_column_names(table_name, database_name):
    myCursor.execute("USE " + str(database_name))
    myCursor.execute("DESCRIBE " + str(table_name))
    column_names = myCursor.fetchall()
    return column_names
tab = []
tables = []
for i in range(len(tabs)):
    tab.append(ttk.Frame(my_notebook, height=950, width=1000, style='my.TNotebook'))
    tab[i].pack(fill="both", expand=2)
    my_notebook.add(tab[i], text="  " + tabs[i][0] + "  ")

    tables.append(ttk.Frame(tab[i], height=950, width=1000))

my_notebook.pack(fill="both", expand=2)
window.mainloop()
myDb.close()
myCursor.close()
window.destroy()
exit()