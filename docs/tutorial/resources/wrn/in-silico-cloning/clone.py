from Bio import SeqIO
from Bio.Seq import Seq
from Bio.Alphabet.IUPAC import IUPACUnambiguousDNA
from Bio.Restriction import RestrictionBatch
from Bio.Restriction import Analysis

goiFile = '/Users/tianyishi/Documents/GitHub/ox/content/tutorial/resources/wrn/in-silico-cloning/original.dna'  # input('GOI file? ')
mcsStr = 'gagaccacaacggtttccctctagaaataattttgtttaactttaagaaggagatataccatggcacatatgagcggccgcgtcgactcgagcgagctcccggggggggttct'  # input('MCS? ')

rb = RestrictionBatch(suppliers=['C', 'B', 'E', 'I', 'K', 'J', 'M', 'O', 'N', 'Q', 'S', 'R', 'V', 'Y', 'X'])

goi = SeqIO.read(goiFile, 'snapgene').seq
mcs = Seq(mcsStr, IUPACUnambiguousDNA())
result_mcs = rb.search(mcs)
result_goi = rb.search(goi)
REs = set([e for e in result_mcs.keys() if result_mcs[e]]) - set([e for e in result_goi.keys() if result_goi[e]])

ana = Analysis(RestrictionBatch(list(REs)), mcs)

# print(sorted(REs, key=lambda e: result_mcs[e]))

ana.print_as('map')
ana.print_that()
