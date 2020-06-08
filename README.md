# TB-Bedaquiline-Resistance-Modelling
Using XGBoost to model M. tuberculosis resistance to Bedaquiline based on amino acid information. Refer to our manuscript for more details (TBC).

## Description of files
1. R [script](data_parser.R) for filtering only susceptible and resistant mutations.
2. [List](raw_tb_mutation_data.csv) of raw mutations obtained from SNPeff.
3. [Input feature matrix](encoded_mutations.csv).
4. Predicted [scores](mutations_with_scores.csv) for INFERRED and UNKNOWN phenotypes.
5. Python [script](tb_drugs.ipynb) for XGboost Model training and analysis.
