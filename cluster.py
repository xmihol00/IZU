
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
import matplotlib.pyplot as plt

print()
print("==================================================================================================")
print("Zadání:\t\tVUT, FIT, IZU, projekt 3")
print("Autor:\t\tDavid Mihola")
print("Login:\t\txmihol00")
print("Kontakt:\txmihol00@stud.fit.vutbr.cz")
print("Datum:\t\t24. 4. 2021")
print("==================================================================================================")

np.set_printoptions(precision=4, floatmode='fixed')

points = np.array([[0, -1, -2], [-3, -1, -3], [ 1, -3,  2], [-2, -2,  2], [1,  2, -4], [0, -4,  3],
                  [1,  0, -3], [-3,  0,  0], [-2,  2, -4], [-2,  4,  3], [3, -2,  4], [2, -5, -4]])

#center_points = np.array([[-3, 4, 1], [5, 0, -3], [-1, -1, 1]])
center_points = np.array([[-3, 4, 1],[ 5, 0,-3],[-1,-1, 1]])

def set_axes_equal(ax):
    '''Make axes of 3D plot have equal scale so that spheres appear as spheres,
    cubes as cubes, etc..  This is one possible solution to Matplotlib's
    ax.set_aspect('equal') and ax.axis('equal') not working for 3D.

    Input
      ax: a matplotlib axis, e.g., as output from plt.gca().
    '''

    x_limits = ax.get_xlim3d()
    y_limits = ax.get_ylim3d()
    z_limits = ax.get_zlim3d()

    x_range = abs(x_limits[1] - x_limits[0])
    x_middle = np.mean(x_limits)
    y_range = abs(y_limits[1] - y_limits[0])
    y_middle = np.mean(y_limits)
    z_range = abs(z_limits[1] - z_limits[0])
    z_middle = np.mean(z_limits)

    # The plot bounding box is a sphere in the sense of the infinity
    # norm, hence I call half the max range the plot radius.
    plot_radius = 0.5*max([x_range, y_range, z_range])

    ax.set_xlim3d([x_middle - plot_radius, x_middle + plot_radius])
    ax.set_ylim3d([y_middle - plot_radius, y_middle + plot_radius])
    ax.set_zlim3d([z_middle - plot_radius, z_middle + plot_radius])

def distance(center_point, x):
    d = np.sqrt(np.sum((center_point - x)**2))
    d_str = "%.4f" % round(d, 4)
    print(f"Euklidovská vzdálenost středového bodu {np.array2string(center_point, separator=', ')} a bodu {np.array2string(x, separator=', ')} je: {d_str}")
    return d

def recalculate_center_ponits(cluster1, cluster2, cluster3):
    return np.array([np.sum(cluster1, 0)/np.size(cluster1, 0), np.sum(cluster2, 0)/np.size(cluster2, 0),
                     np.sum(cluster3, 0)/np.size(cluster3, 0)])

cluster1 = np.array([[0,0,0]])
cluster2 = np.array([[0,0,0]])
cluster3 = np.array([[0,0,0]])

print()
print("Počáteční středové body:\n", np.array2string(center_points, separator=', '))
print()
print("Body:")
print(np.array2string(points, separator=', '))
print()
print("\n============================================ výpočet ============================================\n")

while True:
    for point in points:
        d1 = distance(center_points[0], point)
        d2 = distance(center_points[1], point)
        d3 = distance(center_points[2], point)

        min_d = min(d1, min(d2, d3))
        if min_d == d1:
            print(f"\tMinimální Euklidovská vdálenost = {np.array2string(d1, separator=', ')} bodu {np.array2string(point, separator=', ')} je od středového bodu {center_points[0]}\n")
            cluster1 = np.append(cluster1, [point], axis=0)
        elif min_d == d2:
            print(f"\tMinimální Euklidovská vdálenost = {np.array2string(d2, separator=', ')} bodu {np.array2string(point, separator=', ')} je od středového bodu {center_points[1]}\n")
            cluster2 = np.append(cluster2, [point], axis=0)
        elif min_d == d3:
            print(f"\tMinimální Euklidovská vdálenost = {np.array2string(d3, separator=', ')} bodu {np.array2string(point, separator=', ')} je od středového bodu {center_points[2]}\n")
            cluster3 = np.append(cluster3, [point], axis=0)

    cluster1 = cluster1[1:]
    cluster2 = cluster2[1:]
    cluster3 = cluster3[1:]
    new_center_points = recalculate_center_ponits(cluster1, cluster2, cluster3)
    if np.array_equal(new_center_points, center_points):
        print("Středové body se nezměnily.")
        print("Finální sředový bod 1:", np.array2string(center_points[0], separator=', '))
        print("Finální shluk 1:")
        print(cluster1)
        print("Finální středový bod 2:", np.array2string(center_points[1], separator=', '))
        print("Finální shluk 2:")
        print(cluster2)
        print("Finální středový bod 3:", np.array2string(center_points[2], separator=', '))
        print("Finální shluk 3:")
        print(cluster3)
        break
    else:
        print("Aktuální středové body:\n", np.array2string(center_points, separator=', '))
        print("Nové středové body:\n", np.array2string(new_center_points, separator=', '))
        print()
        print(f"Středový bod {np.array2string(new_center_points[0], separator=', ')} vypočítán jako aritmetický průměr z hluku 1:")
        print(np.array2string(cluster1, separator=', '))
        print(f"Středový bod {np.array2string(new_center_points[1], separator=', ')} vypočítán jako aritmetický průměr z hluku 2:")
        print(np.array2string(cluster2, separator=', '))
        print(f"Středový bod {np.array2string(new_center_points[2], separator=', ')} vypočítán jako aritmetický průměr z hluku 3:")
        print(np.array2string(cluster3, separator=', '))
        center_points = new_center_points
    
    print("\n=================================== výpočet pro nové středové body ===================================\n")

    cluster1 = np.array([[0,0,0]])
    cluster2 = np.array([[0,0,0]])
    cluster3 = np.array([[0,0,0]])


fig = plt.figure(figsize=(8,8))
ax = fig.gca(projection='3d')

for point in cluster1:
    ax.scatter(point[0], point[1], point[2], c="red") 

for point in cluster2:
    ax.scatter(point[0], point[1], point[2], c="green")

for point in cluster3:
    ax.scatter(point[0], point[1], point[2], c="blue")

for point in center_points:
    ax.scatter(point[0], point[1], point[2], c="black")

set_axes_equal(ax)
#plt.show()

