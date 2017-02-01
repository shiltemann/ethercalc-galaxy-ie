#!/usr/bin/python

import csv
import json

from galaxy_ie_helpers import put


def csv_to_tsv(infile, outfile):
    with open(outfile, 'w+') as fout, open(infile, 'r') as fin:
        csv.writer(fout, delimiter="\t").writerows(csv.reader(fin))


def get_audit_trail():
    with open('dump.json') as d, open('ethercalc_audit', 'w+') as fout:
        j = json.load(d)
        audit = j.get('audit-galaxy')
        for command in audit:
            fout.write(command.encode('UTF8') + '\n')


if __name__ == "__main__":
    # send worksheet to galaxy history
    csv_to_tsv('ethercalc_saved', 'ethercalc_export')

    # get audit trail of worksheet, output one command per line
    get_audit_trail()

    # send outputs to Galaxy
    put('ethercalc_audit', file_type='txt')
    put('ethercalc_export', file_type='tabular')
