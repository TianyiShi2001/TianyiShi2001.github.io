from scipy.io import loadmat
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

sns.set()

MNase = np.array(loadmat("MNase_seq_glucose_gene_levels.mat")["MNase_seq_glucose_gene_levels"])
H3K4me3 = np.array(loadmat("H3K4me3_ChIP_seq_glucose_gene_levels.mat")["H3K4me3_ChIP_seq_glucose_gene_levels"])
NET = readMat('NET_seq_glucose_gene_levels_sense_strand.mat')['NET_seq_glucose_gene_levels_sense_strand.mat']

def plot_heatmap(mat, title):
    p = sns.heatmap(mat)
    p.set(
        title=title,
        xlabel='Position relative to TSS (bp)', ylabel='Gene number',
        xticks=[0, 500, 1000, 1500],
        xticklabels=["-500", "TSS", "+500", "+1000"],
        yticks=[0, 999, 1999, 2999, 3999, 4999],
        yticklabels=[1, 1000, 2000, 3000, 4000, 5000],
    )
    return p

plot_heatmap(MNase, "MNase seq Glucose")
plt.show()
plot_heatmap(H3K4me3, 'H3K4me3 ChIP-seq Glucose')
plt.show()
plot_heatmap(NET, 'NET-seq Glucose sense strand')
plt.show()