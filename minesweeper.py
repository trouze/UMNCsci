# <Tyler Rouze rouze012>

# I understand that this is a graded, individual examination that may not be
# discussed with anyone. I also understand that obtaining solution or
# partial solution from outside sources, or discussing any aspect of the exam
# with anyone is academic misconduct and will result in failing the course.
# I further certify that this program represents my own work and that none of
# it was obtained from any source other than material presented as part of the
# course

import turtle as t
import random as rn

class Cell():

    def __init__(self,xmin=0,ymin=0,xmax=10,ymax=10,bomb=False,cleared=False):
        self.__xmin=int(xmin)
        self.__ymin=int(ymin)
        self.__xmax=int(xmax)
        self.__ymax=int(ymax)
        self.__t=t.Turtle()
        self.__t.hideturtle()
        self.__t.penup()
        self.__t.speed(0)
        self.__bomb=bomb
        self.__cleared=cleared

    def turtleaccess(self):
        return self.__t

    def getHeight(self):
        return int(self.__ymax-self.__ymin)

    def getWidth(self):
        return int(self.__xmax-self.__ymin)

    def isIn(self,x,y):
        if x<=self.__xmax or x>=self.__xmin or y<=self.__ymax or y>=self.__ymin:
            return True
        else:
            return False

    def setBomb(self,bomb):
        self.__bomb=bomb

    def isBomb(self):
        return self.__bomb

    def clear(self,cleared,x,y):
        self.__cleared=cleared
        self.draw(x,y)

    def isCleared(self):
        return self.__cleared

    def showCount(self,c,x,y):
        self.__t.goto(x+(self.getWidth()/2),y+(self.getHeight()/2))
        self.__t.write(c,font=('Arial',20,'normal'))

    def draw(self,x,y):
        self.__t.hideturtle()
        self.__t.penup()
        self.__t.speed(0)
        self.__t.goto(x,y)
        if self.isCleared()==True and self.isBomb()==False:
            self.__t.color('grey')
            self.__t.begin_fill()
            self.__t.setheading(0)
            self.__t.forward(self.getWidth())
            self.__t.setheading(90)
            self.__t.forward(self.getWidth())
            self.__t.setheading(180)
            self.__t.forward(self.getWidth())
            self.__t.setheading(270)
            self.__t.forward(self.getWidth())
            self.__t.end_fill()

        elif self.isCleared()==True and self.isBomb()==True:
            self.__t.color('red')
            self.__t.begin_fill()
            self.__t.setheading(0)
            self.__t.forward(self.getWidth())
            self.__t.setheading(90)
            self.__t.forward(self.getWidth())
            self.__t.setheading(180)
            self.__t.forward(self.getWidth())
            self.__t.setheading(270)
            self.__t.forward(self.getWidth())
            self.__t.end_fill()

        elif self.isCleared()==False and self.isBomb()==False:
            self.__t.color('blue')
            self.__t.begin_fill()
            self.__t.setheading(0)
            self.__t.forward(self.getWidth())
            self.__t.setheading(90)
            self.__t.forward(self.getWidth())
            self.__t.setheading(180)
            self.__t.forward(self.getWidth())
            self.__t.setheading(270)
            self.__t.forward(self.getWidth())
            self.__t.end_fill()

        elif self.isCleared()==False and self.isBomb()==True:
            self.__t.color('blue')
            self.__t.begin_fill()
            self.__t.setheading(0)
            self.__t.forward(self.getWidth())
            self.__t.setheading(90)
            self.__t.forward(self.getWidth())
            self.__t.setheading(180)
            self.__t.forward(self.getWidth())
            self.__t.setheading(270)
            self.__t.forward(self.getWidth())
            self.__t.end_fill()


class Minesweeper():

    def __init__(self,rows=5,cols=5,nummines=5,bombvis=False):
        self.__grid=[[Cell() for i in range(rows)]for i in range(cols)]

        self.__nummines=nummines
        self.__bombvis=bombvis
        self.__rows=rows
        self.__cols=cols
        self.__loss=False
        self.__tM=Cell().turtleaccess()
        self.__screen=self.__tM.getscreen()
        self.__screen.setworldcoordinates(0,0,self.__rows*(Cell().getWidth()+1),self.__cols*(Cell().getHeight()+1))

        y=0
        for row in self.__grid:
            x=0
            for cell in row:
                cell.draw(x,y)
                x+=cell.getWidth()+1
            y+=cell.getHeight()+1
        i=0

        while i < self.__nummines:
            bombrow=rn.randint(0,self.__rows-1)
            bombcol=rn.randint(0,self.__cols-1)
            cell2=self.__grid[bombrow][bombcol]

            if cell2.isBomb()==False:
                cell2.setBomb(True)
                i+=1

                if self.__bombvis==True:
                    cell2.clear(True,bombrow*(Cell().getWidth()+1),bombcol*(Cell().getHeight()+1))
                    Cell().showCount('*',bombrow*(Cell().getWidth()+1),bombcol*(Cell().getHeight()+1))

        cellsremain=self.cellsRemaining()
        while cellsremain>0 and self.__loss==False:
            self.__screen.delay(0)
            self.__screen.onclick(self.mouseClick)
            self.__screen.listen()
            cellsremain=self.cellsRemaining()
        if self.__loss==False:
            self.__tM.goto((self.__rows*(Cell().getWidth()+1))/2,(self.__cols*(Cell().getHeight()+1))/2)
            self.__tM.penup()
            self.__tM.hideturtle()
            self.__tM.write('You Won!',font=('Arial',20,'normal'))
        return


    def countBombs(self,x,y):
        count=0
        for (delx,dely) in [(0,1),(0,-1),(1,0),(-1,0),(1,1),(-1,1),(1,-1),(-1,-1)]:
            if x+delx<=self.__rows-1 and y+dely<=self.__cols-1 and x+delx>=0 and y+dely>=0 and self.__grid[delx+x][dely+y].isBomb()==True:
                count+=1
        return count

    def cellsRemaining(self):
        remain=0
        for row in self.__grid:
            for cell5 in row:
                if cell5.isCleared()==False and Cell().isBomb()==False:
                    remain+=1
        return remain

    def getRowCol(self,x,y):
        if x>self.__rows*(Cell().getWidth()+1) or x<0 or y>self.__cols*(Cell().getHeight()+1) or y<0:
            return -1,-1
        else:
            gridrow=int((x-1)//(Cell().getWidth()+1))
            gridcol=int((y-1)//(Cell().getHeight()+1))
            return gridrow,gridcol

    def mouseClick(self,x,y):
        getx,gety=self.getRowCol(x,y)
        cell3=self.__grid[getx][gety]
        if (getx,gety)!=(-1,-1):
            if cell3.isBomb()==True:
                cell3.clear(True,getx*(Cell().getWidth()+1),gety*(Cell().getHeight()+1))
                Cell().showCount('*',getx*(Cell().getWidth()+1),gety*(Cell().getHeight()+1))
                self.__tM.goto((self.__rows*(Cell().getWidth()+1))/2,(self.__cols*(Cell().getHeight()+1))/2)
                self.__tM.penup()
                self.__tM.hideturtle()
                self.__tM.write('You Lose!',font=('Arial',20,'normal'))
                self.__loss=True
                return
            else:
                self.clearCell(getx,gety)
                if Minesweeper().cellsremaining()==0:
                    self.__tM.goto((self.__rows*(Cell().getWidth()+1))/2,(self.__cols*(Cell().getHeight()+1))/2)
                    self.__tM.penup()
                    self.__tM.hideturtle()
                    self.__tM.write('You Win!',font=('Arial',20,'normal'))
        elif (getx,gety)==(-1,-1):
            return

    def clearCell(self,x,y):
        #base cases
        if Cell().isIn(x,y)==False:
            return
        cell1=self.__grid[x][y]
        if cell1.isCleared()==True:
            return
        if cell1.isBomb()==True:
            return
        #if pass base cases
        cell1.clear(True,x*(Cell().getWidth()+1),y*(Cell().getHeight()+1))
        num=self.countBombs(x,y)
        if num > 0:
            Cell().showCount(num,x*(Cell().getWidth()+1),y*(Cell().getHeight()+1))
            return
        for (delx,dely) in [(0,1),(0,-1),(1,0),(-1,0),(1,1),(-1,1),(1,-1),(-1,-1)]:
            if x+delx<=self.__rows-1 and y+dely<=self.__cols-1 and x+delx>=0 and y+dely>=0:
                self.clearCell(x+delx,y+dely)

def main():
    askrows=int(input('Enter the number of rows: '))
    askcols=int(input('Enter the number of columns: '))
    askmines=int(input('Enter the number of mines: '))
    askbombvis=input('Enter (True/False) for bombs being visible: ')
    if askbombvis=='True' or askbombvis=='true':
        askbombvis=True
    else:
        askbombvis=False
    Cell()
    Minesweeper(askrows,askcols,askmines,askbombvis)

if __name__ == '__main__':
    main()
