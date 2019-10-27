#!/usr/bin/env python
# -*- coding: utf-8 -*-

from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np
import math
import pylab
from mpl_toolkits.mplot3d import proj3d
from matplotlib import ticker

genes = []
brain0t = xs = []
brain1t = ys = []
brain2t = zs = []
combq = []

#Extract columns
with open('/home/pclam/cvd/v6/results/combined.brain.p.txt') as f:
    next(f) #pass header
    lines = f.readlines()

    for x in lines:
        genes.append(x.split("\t")[1])
        brain0t.append(float(x.split("\t")[2]))
        brain1t.append(float(x.split("\t")[4]))
        brain2t.append(float(x.split("\t")[6]))
        combq.append(-math.log10(float(x.split("\t")[8])))


#plot
fig = plt.figure()
ax = fig.add_subplot(111,projection='3d')
p = ax.scatter(xs,ys,zs,c=combq, cmap = 'viridis_r')

#grid colors
plt.rcParams['grid.color'] = '#f0f0f0'
plt.rcParams['grid.linewidth'] = 2

#axis labels
ax.set_xlabel('Brain0-t')
ax.set_ylabel('Brain1-t')
ax.set_zlabel('Brain2-t')

#colors of planes
ax.w_xaxis.set_pane_color((1.0, 1.0, 1.0, 1.0))
ax.w_yaxis.set_pane_color((1.0, 1.0, 1.0, 1.0))
ax.w_zaxis.set_pane_color((1.0, 1.0, 1.0, 1.0))

#colorbar
p.set_clim([0,round(max(combq))])
cbar = fig.colorbar(p, ax=ax,shrink = 0.8, ticks = np.arange(0,round(max(combq))+1))
cbar.set_label('-log(q)')
cbar.outline.set_visible(False)

#Add annotations

global labels_and_points
labels_and_points = []

# Write the lables u want to add
labels = []
xa = []
ya = []
za = []
for i in range(2,4):
    labels.append(genes[i])
    xa.append(xs[i])
    ya.append(ys[i])
    za.append(zs[i])


old_x = old_y = 1e9
thresh = .1

for txt, x, y, z in zip(labels, xa, ya, za):
    x2, y2, _ = proj3d.proj_transform(x,y,z, ax.get_proj())

    d = ((x2-old_x)**2+(y2-old_y)**2)**(.5)
    flip = 1
    if d < thresh: flip=-1.7

    label = plt.annotate(
        txt, xy = (x2, y2), xytext = (-20*flip, -20*flip), size = 8,
        textcoords = 'offset points', ha = 'right', va = 'bottom',
        bbox = dict(boxstyle = 'round,pad=0.25', fc = 'orange', alpha = 0.5),
        arrowprops = dict(arrowstyle = '-|>', connectionstyle = 'arc3,rad=0'))
    labels_and_points.append((label, x, y, z))
    old_x = x2
    old_y = y2

# Any else genes you want to add
## xtext, ytext define the dot position
def add_gene(geneID, labels_and_points, xtext, ytext):
    xg = xs[genes.index(geneID)]
    yg = ys[genes.index(geneID)]
    zg = zs[genes.index(geneID)]
    x3, y3, _ = proj3d.proj_transform(xg, yg, zg, ax.get_proj())
    label_g = plt.annotate(
        geneID, xy = (x3, y3), xytext = (xtext, ytext), size = 8,
        textcoords = 'offset points', ha = 'right', va = 'bottom',
        bbox = dict(boxstyle = 'round,pad=0.25', fc = 'orange', alpha = 0.5),
        arrowprops = dict(arrowstyle = '-|>', connectionstyle = 'arc3,rad=0'))
    labels_and_points.append((label_g, xg, yg, zg))

add_gene('ANKRD37', labels_and_points, 45, 20)
add_gene('FCGBP', labels_and_points, 23, -40)
add_gene('STAB1', labels_and_points, 15, 30)

def update_position(e):
    for label, x, y, z in labels_and_points:
        x2, y2, _ = proj3d.proj_transform(x, y, z, ax.get_proj())
        label.xy = x2,y2
        label.update_positions(fig.canvas.renderer)
    fig.canvas.draw()

fig.canvas.mpl_connect('motion_notify_event', update_position)
plt.savefig('/home/pclam/cvd/v6/results/3Dscatterplot.pdf',format = 'pdf')
print('Finsh ploting!')
#plt.show()
