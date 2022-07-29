from Bio import SeqIO
from Bio import AlignIO

# ce = SeqIO.read('ce.fasta', 'fasta')
# hs = SeqIO.read('hs.fasta', 'fasta')
# mm = SeqIO.read('mm.fasta', 'fasta')
# xl = SeqIO.read('xl.fasta', 'fasta')


alignment = AlignIO.read('clustal.aln', 'clustal')
for record in alignment:
    print(record.id + " " + record.seq)

alignment1 = AlignIO.read('muscle.fasta', 'fasta')
for record in alignment1:
    print(record.id + " " + record.seq)

print(alignment, alignment1, sep='\n')

AlignIO.write(alignment1, 'muscle.aln', 'clustal')
