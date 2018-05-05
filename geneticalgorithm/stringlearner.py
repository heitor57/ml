#!/usr/bin/python3.5
import time
from copy import copy
import random
timetodo=input("Give the reserved time: ")
indiamount = 75
targetstr = "Hello guys"
alphabet = " abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWYXZ,.;:"
# at the beginning of the script
startTime = time.time()
def getUptime():
    return time.time() - startTime
class Individual:
    fitness = 0
    def __init__(self,chromosomes="0"*len(targetstr)):
        self.chromosomes = chromosomes
    def id(self):
        return id(self)
    def getchromo(self):
        return self.chromosomes
    def randomchromo(self):
        self.chromosomes=""
        for x in range(len(targetstr)):
            self.chromosomes+=random.choice(alphabet)
        return self
    def setgene(self,column,value):
        self.chromosomes=self.chromosomes[:column]+value+self.chromosomes[column+1:]
    def __str__(self):
        return self.chromosomes
class Population:
    individuals = []
    def __init__(self):
        pass
    def randompopulation(self,num):
        for x in range(num):
            self.add(Individual().randomchromo())
    def add(self,ind):
        self.individuals.append(ind)
    def getall(self):    
        return self.individuals
    def crossover(self,ind1,ind2):
        ind1c=ind1.getchromo()
        ind2c=ind2.getchromo()
        print("Crossover de :"+ind1c+"   "+ind2c)
        iss1=int(len(ind1c)/2)
        iss2=int(len(ind2c)/2)
        newind1=Individual(ind1c)
        newind2=Individual(ind2c)
        # First form of crossover
        newind1l=list(newind1.chromosomes)
        newind2l=list(newind2.chromosomes)
        i=0
        for x,y in zip(ind1c,ind2c):
            if i%2 == 0:
                newind1l[i]=ind2c[i]
                newind2l[i]=ind1c[i]
                i=1+i
        newind1.chromosomes = "".join(newind1l)
        newind2.chromosomes = "".join(newind2l)
        #second form of crossover
        #newind1=Individual(ind1c[:iss1]+ind2c[iss2:])
        #newind2=Individual(ind2c[:iss2]+ind1c[iss1:])
        return newind1,newind2
    def remove(self,ind):
        self.individuals.remove(ind)
    def fitness(self,ind):
        ind.fitness=0
        for char,chromo in zip(targetstr,ind.getchromo()):
            if char == chromo:
                ind.fitness+=1
    def fitnessall(self):
        for x in self.getall():
            self.fitness(x)
    def mutation(self,ind):
        if random.randrange(0,100,1)>=90:
            print("Mutation in before:  "+ind.getchromo())
            ind.setgene(random.randrange(0,len(ind.getchromo()),1),random.choice(alphabet))
            print("Mutation in after:   "+ind.getchromo())
    def massmutation(self):
        for x in self.getall():
            self.mutation(x)
    def nextgeneration(self):
        roulette=[]
        temppop=[]
        for x in self.getall():
            for y in range(x.fitness):
                roulette.append(self.individuals.index(x))
        print("Roleta: "+str(roulette))
        if len(roulette) > 0:
            for x in range(int(indiamount/2)):
                index1=random.choice(roulette)
                index2=random.choice(roulette)
                crossr=self.crossover(self.individuals[index1],self.individuals[index2])
                temppop.append(crossr[0])
                temppop.append(crossr[1])
        self.individuals  = temppop
    def delall(self):
        self.individuals=[]
    def __str__(self):
        return self.individuals
population = Population()
# ADD individuals
population.randompopulation(indiamount)
count=1
while getUptime() < float(timetodo):
    #get all individuals
    population.fitnessall()
    for x in population.individuals:
        print(x)
    population.nextgeneration()
    population.massmutation()
    count+=1
print("Last population of "+str(count)+":")
population.fitnessall()
for x in population.individuals:
    print(str(x)+"         Fitness:"+str(x.fitness))
print("Tempo gasto: "+str(getUptime()));
