
import turtle
import random
import time
def bowling():
    frames=1
    frame10rolls=0
    scoreindex=-1
    scores=[]
    while frames<=10 and frame10rolls<3:
        turtle.clearscreen()
        turtle.setworldcoordinates(-200,-200,200,200)
        pin1 = turtle.Turtle()
        pin2 = turtle.Turtle()
        pin3 = turtle.Turtle()
        pin4 = turtle.Turtle()
        pin5 = turtle.Turtle()
        pin6 = turtle.Turtle()
        pin7 = turtle.Turtle()
        pin8 = turtle.Turtle()
        pin9 = turtle.Turtle()
        pin10 = turtle.Turtle()
        writingturtle= turtle.Turtle()
        pin1.hideturtle()
        pin2.hideturtle()
        pin3.hideturtle()
        pin4.hideturtle()
        pin5.hideturtle()
        pin6.hideturtle()
        pin7.hideturtle()
        pin8.hideturtle()
        pin9.hideturtle()
        pin10.hideturtle()
        writingturtle.hideturtle()
        writingturtle.penup()
        pin1.penup()
        pin1.speed(0)
        pin1.shape("circle")
        pin1.color('blue')
        pin1.shapesize(3,3,0)
        pin2.penup()
        pin2.speed(0)
        pin2.shape("circle")
        pin2.color('blue')
        pin2.shapesize(3,3,0)
        pin3.penup()
        pin3.speed(0)
        pin3.shape("circle")
        pin3.color('blue')
        pin3.shapesize(3,3,0)
        pin4.penup()
        pin4.speed(0)
        pin4.shape("circle")
        pin4.color('blue')
        pin4.shapesize(3,3,0)
        pin5.penup()
        pin5.speed(0)
        pin5.shape("circle")
        pin5.color('blue')
        pin5.shapesize(3,3,0)
        pin6.penup()
        pin6.speed(0)
        pin6.shape("circle")
        pin6.color('blue')
        pin6.shapesize(3,3,0)
        pin7.penup()
        pin7.speed(0)
        pin7.shape("circle")
        pin7.color('blue')
        pin7.shapesize(3,3,0)
        pin8.penup()
        pin8.speed(0)
        pin8.shape("circle")
        pin8.color('blue')
        pin8.shapesize(3,3,0)
        pin9.penup()
        pin9.speed(0)
        pin9.shape("circle")
        pin9.color('blue')
        pin9.shapesize(3,3,0)
        pin10.penup()
        pin10.speed(0)
        pin10.shape("circle")
        pin10.color('blue')
        pin10.shapesize(3,3,0)
        pin1.goto(-150,150)
        pin1stamp=pin1.stamp()
        pin2.goto(-50,150)
        pin2stamp=pin2.stamp()
        pin3.goto(50,150)
        pin3stamp=pin3.stamp()
        pin4.goto(150,150)
        pin4stamp=pin4.stamp()
        pin5.goto(-100,50)
        pin5stamp=pin5.stamp()
        pin6.goto(0,50)
        pin6stamp=pin6.stamp()
        pin7.goto(100,50)
        pin7stamp=pin7.stamp()
        pin8.goto(-50,-50)
        pin8stamp=pin8.stamp()
        pin9.goto(50,-50)
        pin9stamp=pin9.stamp()
        pin10.goto(0,-150)
        pin10stamp=pin10.stamp()
#end display setup
        pinlist = [pin1stamp, pin2stamp, pin3stamp, pin4stamp, pin5stamp, pin6stamp, pin7stamp, pin8stamp, pin9stamp, pin10stamp] #list of stampid's
        pinsuplist=[pin1stamp, pin2stamp, pin3stamp, pin4stamp, pin5stamp, pin6stamp, pin7stamp, pin8stamp, pin9stamp, pin10stamp]
        distrt=[pin1, pin2, pin3, pin4, pin5, pin6, pin7, pin8, pin9, pin10]
        roll=1
        while roll<=2 and frame10rolls<3:
            toppleinputamount = turtle.textinput('Frame '+str(frames),'Enter # of pins (null for random)')
            if toppleinputamount!='':
                toppleinputamount=int(toppleinputamount)

            if roll==1 and toppleinputamount!='' and toppleinputamount>=10:   #inputted strike 10 or greater
                index=0
                while index<10:
                    distrt[index].clearstamp(pinlist[index]) #pin10.clearstamp(pin10stamp)
                    distrt[index].write("X",font=("Arial",30,"normal"))
                    index+=1
                writingturtle.goto(50,-175)
                writingturtle.write("Strike!",font=("Arial", 24, "normal"))
                if frames!=10:
                    scores+=[10]
                    scoreindex+=1
                    roll=3
                    time.sleep(3)
                    writingturtle.clear()
                else:
                    frame10rolls+=1
                    scores+=[10]
                    scoreindex+=1
                    roll=3
                    time.sleep(3)
                    writingturtle.clear()

            elif roll==1 and toppleinputamount!='' and toppleinputamount<10:      #inputted less than 10 first roll
                index2=0
                pinsupanddisplay=list(zip(pinsuplist, distrt))
                random.shuffle(pinsupanddisplay)        #shuffle both lists in same order so correct pins aare erased
                pinsuplist, distrt = zip(*pinsupanddisplay)
                pinsuplist=list(pinsuplist)
                distrt=list(distrt)
                while index2<toppleinputamount:
                    distrt[index2].clearstamp(pinsuplist[index2])
                    distrt[index2].write("X",font=("Arial",30,"normal"))
                    index2+=1
                index3=0
                while index3<toppleinputamount:
                    del distrt[0]
                    del pinsuplist[0]
                    index3+=1
                scores+=[toppleinputamount]
                scoreindex+=1
                time.sleep(1)
                roll+=1
                if frames!=10:
                    frame10rolls=0
                else:
                    frame10rolls+=1


            elif roll==2 and toppleinputamount!='':      #inputted spare or open frame
                pinsupanddisplay=list(zip(pinsuplist, distrt))
                random.shuffle(pinsupanddisplay)        #shuffle both lists in same order so correct pins aare erased
                pinsuplist, distrt = zip(*pinsupanddisplay)
                pinsuplist=list(pinsuplist)
                distrt=list(distrt)
                index4=0
                while index4<len(pinsuplist) and index4<toppleinputamount:
                    distrt[index4].clearstamp(pinsuplist[index4])
                    distrt[index4].write("X",font=("Arial",30,"normal"))
                    index4+=1
                if toppleinputamount<len(pinsuplist):
                    index5=0
                    while index5<toppleinputamount:
                        del pinsuplist[0]
                        index5+=1
                    scores+=[toppleinputamount]
                    scoreindex+=1
                    writingturtle.goto(50,-175)
                    writingturtle.write("Open Frame: "+str(10-len(pinsuplist)),font=("Arial", 24, "normal"))
                    time.sleep(3)
                    writingturtle.clear()
                    roll=3
                    if frames!=10:
                        frame10rolls=0
                    else:
                        frame10rolls=4
                else:                   #i.e. if the input amount is greater or equal
                    scores+=[10-scores[scoreindex]]
                    scoreindex+=1
                    writingturtle.goto(50,-175)
                    writingturtle.write("Spare",font=("Arial", 24, "normal"))
                    time.sleep(3)
                    writingturtle.clear()
                    roll=3
                    if frames!=10:
                        frame10rolls=0
                    else:
                        frame10rolls+=1

            elif roll==1 and toppleinputamount=='':     #random pins to fall on roll 1
                toppleinputamount=random.randint(0,10)
                if toppleinputamount==10:
                    index6=0
                    while index6<10:
                        distrt[index6].clearstamp(pinlist[index6])
                        distrt[index6].write("X",font=("Arial",30,"normal"))
                        index6+=1
                    writingturtle.goto(50,-175)
                    writingturtle.write("Strike!",font=("Arial", 24, "normal"))
                    if frames!=10:
                        scores+=[10]
                        scoreindex+=1
                        time.sleep(3)
                        writingturtle.clear()
                        roll=3
                    else:
                        frame10rolls+=1
                        scores+=[10]
                        scoreindex+=1
                        time.sleep(3)
                        writingturtle.clear()
                        roll=3

                else:   #i.e. random integer is less than 10
                    index7=0
                    pinsupanddisplay=list(zip(pinsuplist, distrt))
                    random.shuffle(pinsupanddisplay)        #shuffle both lists in same order so correct pins aare erased
                    pinsuplist, distrt = zip(*pinsupanddisplay)
                    pinsuplist=list(pinsuplist)
                    distrt=list(distrt)
                    while index7<toppleinputamount:
                        distrt[index7].clearstamp(pinsuplist[index7])
                        distrt[index7].write("X",font=("Arial",30,"normal"))
                        index7+=1
                    index8=0
                    while index8<toppleinputamount:
                        del distrt[0]
                        del pinsuplist[0]
                        index8+=1
                    scores+=[toppleinputamount]
                    scoreindex+=1
                    time.sleep(1)
                    roll+=1
                    if frames!=10:
                        frame10rolls=0
                    else:
                        frame10rolls+=1

            elif roll==2 and toppleinputamount=='':     #random pins to fall on roll 2
                toppleinputamount=random.randint(0,len(pinsuplist))
                pinsupanddisplay=list(zip(pinsuplist, distrt))
                random.shuffle(pinsupanddisplay)        #shuffle both lists in same order so correct pins aare erased
                pinsuplist, distrt = zip(*pinsupanddisplay)
                pinsuplist=list(pinsuplist)
                distrt=list(distrt)
                index9=0
                while index9<len(pinsuplist) and index9<toppleinputamount:
                    distrt[index9].clearstamp(pinsuplist[index9])
                    distrt[index9].write("X",font=("Arial",30,"normal"))
                    index9+=1
                if toppleinputamount<len(pinsuplist):
                    index10=0
                    while index10<toppleinputamount:
                        del pinsuplist[0]
                        index10+=1
                    scores+=[toppleinputamount]
                    scoreindex+=1
                    writingturtle.goto(50,-175)
                    writingturtle.write("Open Frame: "+str(10-len(pinsuplist)),font=("Arial", 24, "normal"))
                    time.sleep(3)
                    writingturtle.clear()
                    roll=3
                    if frames!=10:
                        frame10rolls=0
                    else:
                        frame10rolls=4
                else:                   #i.e. if the input amount is greater or equal
                    scores+=[10-scores[scoreindex]]
                    scoreindex+=1
                    writingturtle.goto(50,-175)
                    writingturtle.write("Spare",font=("Arial", 24, "normal"))
                    time.sleep(3)
                    writingturtle.clear()
                    roll=3
                    if frames!=10:
                        frame10rolls=0
                    else:
                        frame10rolls+=1

        if frames!=10:
            frames+=1
        else:
            frames=10
    return scores

def finalscore(scores):
    turtle.clearscreen()
    writingturtle= turtle.Turtle()
    writingturtle.hideturtle()
    writingturtle.penup()
    total=[]
    lengthofscores=len(scores)
    iterator=0
    while iterator<=lengthofscores-3:
        if scores[iterator]==10:
            total+=[scores[iterator]+scores[iterator+1]+scores[iterator+2]]
            iterator+=1
        elif scores[iterator]+scores[iterator+1]==10:
            total+=[scores[iterator]+scores[iterator+1]+scores[iterator+2]]
            iterator+=2
        elif scores[iterator]+scores[iterator+1]<10:
            total+=[scores[iterator]+scores[iterator+1]]
            iterator+=2
    writingturtle.goto(0,0)
    writingturtle.write("Final Score: "+str(sum(total)),font=("Arial", 32, "normal"))


def main():
    scores=bowling()
    finalscore(scores)
if __name__ == '__main__':
    main()
