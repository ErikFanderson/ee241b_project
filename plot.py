import matplotlib.pyplot as plt
import numpy as np

if __name__=='__main__':
    fig, ax = plt.subplots()

    ind = np.arange(5)
    width = 0.3

    nems = [10952.26272, 4.536, 0.576, 0.1296, 0.0648] 
    cmos = [10821.626, 1834.747, 241.212, 48.989, 25.661]

    ax.bar(ind, nems, width, label="NEMS")
    ax.bar(ind + width, cmos, width, label="CMOS")
    ax.legend()
    ax.set_yscale("log")
    ax.set_title("Area Comparison")
    ax.set_ylabel("Area [um^2]")
    plt.xticks(ind + width/2, ("blkinst", "cbinstw", "cbinste", "cbinsts", "cbinstn"))
    plt.show()
