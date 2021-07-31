import math as m

E = -3/12 * m.log2(3/12) - 3/12 * m.log2(3/12) - 6/12 * m.log2(6/12)
print("Entropy =", E)

MyArmy = 5/12 * (-2/5 * m.log2(2/5) - 3/5 * m.log2(3/5)) + 4/12 * (-1/4 * m.log2(1/4) -1/4 * m.log2(1/4) - 2/4 * m.log2(2/4)) \
    + 3/12 * (-1/3 * m.log2(1/3) -2/3 * m.log2(2/3))
print("MyArmy = ", MyArmy, "Entropy gain =", round(E - MyArmy, 4))

EnemyArmy = 6/12 * (-3/6 * m.log2(3/6) - 2/6 * m.log2(2/6) - 1/6 * m.log2(1/6)) + 3/12 * (-2/3 * m.log2(2/3) - 1/3 * m.log2(1/3)) \
    + 3/12 * (-3/3 * m.log2(3/3))
print("EnemyArmy =", EnemyArmy, "Entropy gain =", round(E - EnemyArmy, 4))

MyBetrayal = 5/12 * (-2/5 * m.log2(2/5) - 1/5 * m.log2(1/5) - 2/5 * m.log2(2/5)) \
    + 7/12 * (-1/7 * m.log2(1/7) - 4/7 * m.log2(4/7) - 2/7 * m.log2(2/7))
print("MyBetrayal =", MyBetrayal, "Entropy gain =", round(E - MyBetrayal, 4))

EnemyBetrayal = 5/12 * (-1/5 * m.log2(1/5) - 1/5 * m.log2(1/5) - 3/5 * m.log2(3/5)) \
    + 7/12 * (-2/7 * m.log2(2/7) - 3/7 * m.log2(3/7) - 2/7 * m.log2(2/7))
print("EnemyBetrayal =", EnemyBetrayal, "Entropy gain =", round(E - EnemyBetrayal, 4))

Expected = 6/12 * (-1/6 * m.log2(1/6) - 2/6 * m.log2(2/6) - 3/6 * m.log2(3/6)) \
    + 6/12 * (-2/6 * m.log2(2/6) - 4/6 * m.log2(4/6))
print("Expected =", Expected, "Entropy gain =", round(E - Expected, 4))

print()
samll_E = -3/6 * m.log2(3/6) - 2/6 * m.log2(2/6) - 1/6 * m.log2(1/6)
print("small branch Entropy =", samll_E)

small_MyArmy = 3/6 * (-2/3 * m.log2(2/3) - 1/3 * m.log2(1/3)) + 2/6 * (-1/2 * m.log2(1/2) -1/2 * m.log2(1/2)) \
    + 1 * (-1 * m.log2(1))
print("small branch MyArmy =", small_MyArmy, "Etropy gain =", round(samll_E - small_MyArmy, 4))

small_MyBetrayal = 2/6 * (-2/2 * m.log2(2/2)) + 4/6 * (-1/4 * m.log2(1/4) -2/4 * m.log2(2/4) -1/4 * m.log2(1/4))
print("small branch MyBetrayal =", small_MyBetrayal, "Etropy gain =", round(samll_E - small_MyBetrayal, 4))

small_EnemyBetrayal = 1/6 * (-1 * m.log2(1)) + 5/6 * (-1/5 * m.log2(1/5) -2/5 * m.log2(2/5) -2/5 * m.log2(2/5))
print("small branch EnemyBetrayal =", small_EnemyBetrayal, "Etropy gain =", round(samll_E - small_EnemyBetrayal, 4))

small_Expected = 2/6 * (-2/2 * m.log2(2/2)) + 4/6 * (-1/4 * m.log2(1/4) -2/4 * m.log2(2/4) -1/4 * m.log2(1/4))
print("small branch Expected =", small_Expected, "Etropy gain =", round(samll_E - small_Expected, 4))

print()
medium_E = -2/3 * m.log2(2/3) -1/3 * m.log2(1/3)
print("medium branch Entropy =", medium_E)

medium_MyArmy = 1/3 * (-1 * m.log2(1)) + 1/3 * (-1 * m.log2(1)) + 1/3 * (-1 * m.log2(1))
print("medium branch MyArmy =", medium_MyArmy, "Etropy gain =", round(medium_E - medium_MyArmy, 4))

medium_MyBetrayal = 1/3 * (-1 * m.log2(1)) + 2/3 * (-1/2 * m.log2(1/2) -1/2 * m.log2(1/2))
print("medium branch MyBetrayal =", medium_MyBetrayal, "Etropy gain =", round(medium_E - medium_MyBetrayal, 4))

medium_EnemyBetrayal = 1/3 * (-1 * m.log2(1)) + 2/3 * (-1/2 * m.log2(1/2) -1/2 * m.log2(1/2))
print("medium branch EnemyBetrayal =", medium_EnemyBetrayal, "Etropy gain =", round(medium_E - medium_EnemyBetrayal, 4))

medium_Expected = 2/3 * (-2/2 * m.log2(2/2)) + 1/3 * (-1 * m.log2(1))
print("medium branch Expected =", medium_Expected, "Etropy gain =", round(medium_E - medium_Expected, 4))

print()
print("large branch ends with M")

print()
small_small_E = -1/3 * m.log2(1/3) -2/3 * m.log2(2/3)
print("small small branch Entropy =", small_small_E)

small_small_MyBetrayal = 1/3 * (-1 * m.log2(1)) + 2/3 * (-1/2 * m.log2(1/2) -1/2 * m.log2(1/2))
print("small small MyBetrayal =", small_small_MyBetrayal, "Etropy gain =", round(small_small_E - small_small_MyBetrayal, 4))

small_small_EnemyBetrayal = (-1/3 * m.log2(1/3) -2/3 * m.log2(2/3))
print("small small EnemyBetrayal =", small_small_EnemyBetrayal, "Etropy gain =", round(small_small_E - small_small_EnemyBetrayal, 4))

small_small_Expected = 1/3 * (-1 * m.log2(1)) + 2/3 * (-1/2 * m.log2(1/2) -1/2 * m.log2(1/2)) 
print("small small Expected =", small_small_Expected, "Etropy gain =", round(small_small_E - small_small_Expected, 4))

print()
small_medium_E = -1/2 * m.log2(1/2) -1/2 * m.log2(1/2)
print("small medium branch Entropy =", small_medium_E)

small_medium_MyBetrayal = 1/2 * (-1 * m.log2(1)) + 1/2 * (-1 * m.log2(1))
print("small medium MyBetrayal =", small_medium_MyBetrayal, "Etropy gain =", round(small_medium_E - small_medium_MyBetrayal, 4))

small_medium_EnemyBetrayal = 1/2 * (-1 * m.log2(1)) + 1/2 * (-1 * m.log2(1))
print("small medium EnemyBetrayal =", small_medium_EnemyBetrayal, "Etropy gain =", round(small_medium_E - small_medium_EnemyBetrayal, 4))

small_medium_Expected = 1/2 * (-1 * m.log2(1)) + 1/2 * (-1 * m.log2(1))
print("small medium Expected =", small_medium_Expected, "Etropy gain =", round(small_medium_E - small_medium_Expected, 4))

print()
print("small large ends with M")

print()
print("medium small ends with M")

print()
print("medium medium ends with N")

print()
print("medium large ends with N")

print()
print("small small possible ends with Y")

print()
small_small_impossible_E = -1/2 * m.log2(1/2) -1/2 * m.log2(1/2)
print("small small impossible branch Entropy =", small_small_impossible_E)

small_small_impossible_EnemyBetrayal = 2/2 * (-1/2 * m.log2(1/2) -1/2 * m.log2(1/2))
print("small small impossible EnemyBetrayal =", small_small_impossible_EnemyBetrayal, "Etropy gain =", round(small_small_impossible_E - small_small_impossible_EnemyBetrayal, 4))

small_small_impossible_Expected = 1/2 * (-1 * m.log2(1)) + 1/2 * (-1 * m.log2(1))
print("small small impossible Expected =", small_small_impossible_Expected, "Etropy gain =", round(small_small_impossible_E - small_small_impossible_Expected, 4))

print()
print("small medium possible ends with Y")

print()
print("small medium impossible ends with N")

print()
print("small small impossible impossible true ends with M")

print()
print("small small impossible impossible false ends with Y")

