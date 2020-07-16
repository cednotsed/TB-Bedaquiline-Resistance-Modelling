import numpy as np
import pandas as pd
from pathlib import Path

data = Path('~/git_repos/TB-Bedaquiline-Resistance-Modelling')

df = pd.read_csv(data / 'mutations_with_scores.csv')
df = df[['WT', 'position', 'Variant', 'Drug Resistance', 'PROVEAN score', 'effect', 'Predicted probability of resistance']]

mutation = df.WT + df.position.astype('str') + df.Variant
df.insert(loc=0, value=mutation, column='Mutation')

# Sample IDs
meta = pd.read_csv(data / 'rv0678_sample_ids_160720.csv')

meta_expand = pd.DataFrame()

for i in range(meta.shape[0]):
    x = meta.iloc[i, :]
    mut_list = x['Mutations'].split(',')

    for mut in mut_list:
        copy_row = x.copy()
        copy_row['Mutations'] = mut
        meta_expand = meta_expand.append(copy_row, ignore_index=True)

meta_expand.columns = ['Classification', 'Lineage', 'Mutation', 'Sample ID']
meta_expand = meta_expand[['Mutation', 'Classification', 'Lineage', 'Sample ID']]

df = df.merge(meta_expand, on='Mutation', how='left')
df.to_csv(data / 'mutation_list.predictions.sampleIDs.csv', index=False, header=True)


