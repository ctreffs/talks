---
title: Genetic Algorithms
theme: league # beige, black, blood, league, moon, night, serif, simple, sky, solarized, white
revealOptions:
	controls: true
	progress: true
	slideNumber: true
	keyboard: true
	overview: true
	center: true
	touch: true
	loop: false
	help: true
	showNotes: false
	autoPlayMedia: true
	hideAddressBar: true # mobile only
    #transition:  slide  # none/fade/slide/convex/concave/zoom
---

# Genetic Algorithms

### Christian Treffs

---

### Definition

> In computer science and operations research, a genetic algorithm (GA) is a metaheuristic inspired by the process of natural selection that belongs to the larger class of evolutionary algorithms (EA). Genetic algorithms are commonly used to generate high-quality solutions to optimization and search problems by relying on bio-inspired operators such as mutation, crossover and selection.

---

### Idea

In a genetic algorithm, a *population of candidate solutions* (called individuals, creatures, or phenotypes) to an optimization problem is evolved toward better solutions. 
Each candidate solution has a *set of properties* (its chromosomes or genotype) which can be *mutated and altered*.

A typical genetic algorithm requires:

1. A genetic representation of the solution domain
2. A fitness function to evaluate the solution domain

---

### Building blocks

1. Initialization
2. Selection & Genetic operations
3. Termination

----

### Initialization

Initialize a population of solutions.
Often, the initial population is generated randomly.
Solutions may be "seeded" in areas where optimal solutions are likely to be 

----

### Selection & Genetics

Portion of the existing population is selected to breed a new generation.  
Individual solutions are selected through a fitness-based process, where fitter solutions (as measured by a fitness function) are typically more likely to be selected.   
Improve solutions through repetitive application of mutation, crossover, inversion and selection operators.

----

#### Fitness function

The fitness function is defined over the genetic representation and measures the quality of the represented solution. The fitness function is always problem dependent.

In some problems, it is hard or even impossible to define the fitness expression; in these cases, a simulation may be used to determine the fitness function value of a phenotype.

Notes:
Knapsack problem one wants to maximize the total value of objects that can be put in a knapsack of some fixed capacity. A representation of a solution might be an array of bits, where each bit represents a different object, and the value of the bit (0 or 1) represents whether or not the object is in the knapsack. Not every such representation is valid, as the size of objects may exceed the capacity of the knapsack. The fitness of the solution is the sum of values of all objects in the knapsack if the representation is valid, or 0 otherwise.

----

##### Recombination/Crossover

> ... is used to combine the genetic information of two parents to generate new offspring.


##### Mutation

> ... is used to maintain genetic diversity from one generation of a population of genetic algorithm chromosomes to the next. Mutation alters one or more gene values in a chromosome from its initial state

Notes:
 In mutation, the solution may change entirely from the previous solution.
 
----

### Termination

The algorithm terminates when either a maximum number of generations has been produced, or a satisfactory fitness level has been reached for the population.

Common terminating conditions are:

1. A solution is found that satisfies minimum criteria
2. Fixed number of generations reached
3. Allocated budget (computation time/money) reached
4. Successive iterations no longer produce better results

---

# Demo

#### Knapsack