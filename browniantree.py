# <Tyler Rouze rouze012>
# I understand that this is a graded, individual examination that may not be
# discussed with anyone. I also understand that obtaining solution or
# partial solution from outside sources, or discussing any aspect of the exam
# with anyone is academic misconduct and will result in failing the course.
# I further certify that this program represents my own work and that none of
# it was obtained from any source other than material presented as part of the
# course

import random as rn
import turtle as tr
import math

def turtlesetup(tr):
    tr.speed(0)
    tr.setworldcoordinates(0,0,199,199)
    tr.hideturtle()
    tr.penup()
    tr.goto(99,99)
    tr.dot(5,"Blue")
    return tr

def treeinput(tr):
    treesize = tr.textinput('Python Turtle Graphics','Enter tree size: ')
    if treesize=='':
        return
    else:
        treesize=int(treesize)
    return treesize

def randwalk(gridlist,treesizeindex,xcor,ycor,radius):
    if hasNeighbor(gridlist,xcor,ycor)==True:
        tr.goto(xcor,ycor)
        tr.dot(5,"Blue")
        gridlist[xcor][ycor]=True
        if xcor>=int(99+radius) or xcor<=int(99-radius) or ycor>=int(99+radius) or ycor<=int(99-radius):
            radius+=1
    else:
        steptotal=0
        isadjacent=False
        while steptotal<=200 and isadjacent==False:
            z=rn.randint(1,4)
            if z==1:
                if inGrid(xcor,ycor)==True:
                    xcor+=1
                else:
                    xcor=xcor
                if hasNeighbor(gridlist,xcor,ycor)==True:
                    tr.goto(xcor,ycor)
                    tr.dot(5,"Blue")
                    gridlist[xcor][ycor]=True
                    if xcor>=int(99+radius) or xcor<=int(99-radius) or ycor>=int(99+radius) or ycor<=int(99-radius):
                        radius+=1
                    treesizeindex+=1
                    isadjacent=True
                else:
                    steptotal+=1
            elif z==2:
                if inGrid(xcor,ycor)==True:
                    ycor+=1
                else:
                    ycor=ycor
                if hasNeighbor(gridlist,xcor,ycor)==True:
                    tr.goto(xcor,ycor)
                    tr.dot(5,"Blue")
                    gridlist[xcor][ycor]=True
                    if xcor>=int(99+radius) or xcor<=int(99-radius) or ycor>=int(99+radius) or ycor<=int(99-radius):
                        radius+=1
                    treesizeindex+=1
                    isadjacent=True
                else:
                    steptotal+=1
            elif z==3:
                if inGrid(xcor,ycor)==True:
                    xcor-=1
                else:
                    xcor=xcor
                if hasNeighbor(gridlist,xcor,ycor)==True:
                    tr.goto(xcor,ycor)
                    tr.dot(5,"Blue")
                    gridlist[xcor][ycor]=True
                    if xcor>=int(99+radius) or xcor<=int(99-radius) or ycor>=int(99+radius) or ycor<=int(99-radius):
                        radius+=1
                    treesizeindex+=1
                    isadjacent=True
                else:
                    steptotal+=1
            elif z==4:
                if inGrid(xcor,ycor)==True:
                    ycor-=1
                else:
                    ycor=ycor
                if hasNeighbor(gridlist,xcor,ycor)==True:
                    tr.goto(xcor,ycor)
                    tr.dot(5,"Blue")
                    gridlist[xcor][ycor]=True
                    if xcor>=int(99+radius) or xcor<=int(99-radius) or ycor>=int(99+radius) or ycor<=int(99-radius):
                        radius+=1
                    treesizeindex+=1
                    isadjacent=True
                else:
                    steptotal+=1
    return list(gridlist),int(treesizeindex),int(radius)


def hasNeighbor(gridlist,xcor,ycor):
    if gridlist[xcor+1][ycor+1]==True:
        return True
    elif gridlist[xcor-1][ycor-1]==True:
        return True
    elif gridlist[xcor-1][ycor+1]==True:
        return True
    elif gridlist[xcor+1][ycor-1]==True:
        return True
    elif gridlist[xcor+1][ycor]==True:
        return True
    elif gridlist[xcor-1][ycor]==True:
        return True
    elif gridlist[xcor][ycor-1]==True:
        return True
    elif gridlist[xcor][ycor+1]==True:
        return True
    elif gridlist[xcor][ycor]==True:
        return False
    else:
        return False

def trgoto(radius):
    theta=rn.randint(0,360)
    radians=math.radians(theta)
    xcor=math.cos(radians)
    ycor=math.sin(radians)
    xcor*=radius
    ycor*=radius
    if xcor<0:
        xcor-=0.5
        xcor=int(xcor)
        xcor+=99
    elif xcor==0:
        xcor=0
        xcor+=99
    elif xcor>0:
        xcor+=0.5
        xcor=int(xcor)
        xcor+=99
    if ycor<0:
        ycor-=0.5
        ycor=int(ycor)
        ycor+=99
    elif ycor==0:
        ycor=0
        ycor+=99
    elif ycor>0:
        ycor+=0.5
        ycor=int(ycor)
        ycor+=99
    return xcor,ycor

def inGrid(xcor,ycor):
    if xcor>=197 or xcor<=2 or ycor>=197 or ycor<=2:
        return False
    else:
        return True

def main():
    treesize=treeinput(tr)
    gridlist=[[False]*199 for values in range(199)]
    turtlesetup(tr)
    gridlist[99][99]=True
    radius=1
    treesizeindex=1
    while treesizeindex<treesize:
        xcor,ycor=trgoto(radius)
        gridlist,treesizeindex,radius=randwalk(gridlist,treesizeindex,xcor,ycor,radius)
    return

if __name__ == '__main__':
    main()
