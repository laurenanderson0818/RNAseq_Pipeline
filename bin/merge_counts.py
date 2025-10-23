#!/usr/bin/env python

import argparse
import pandas as pd
import os

parser = argparse.ArgumentParser()

parser.add_argument("-i", "--inputs", nargs="+", help="Input VERSE exon count files to merge", dest="inputs", required=True)
parser.add_argument("-o", "--output", help="The output file name and path for the merged counts matrix", dest="output", required=True)

args = parser.parse_args()

dfs = []

for file in args.inputs:
    sample_name = os.path.basename(file).replace(".exon.txt", "")

    df = pd.read_csv(file, sep="\t")

    df = df.set_index("gene")
    df = df.rename(columns={"count": sample_name})

    dfs.append(df)

merged = pd.concat(dfs, axis=1)

merged.to_csv(args.output)