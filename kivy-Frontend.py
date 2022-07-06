import mysql.connector
from kivy.app import App
from kivy.uix.widget import Widget


myDb = mysql.connector.connect(host= "localhost", user="root", passwd="")
myCursor = myDb.cursor()


class PongGame(Widget):
    pass


class PongApp(App):
    def build(self):
        return PongGame()


if __name__ == '__main__':
    PongApp().run()