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
    put('ethercalc_export', file_type='tabular')

    # get audit trail of worksheet, output one command per line
    # TODO: build galaxy tool that takes this log and applies changes new file
    get_audit_trail()

    put('ethercalc_audit', file_type='txt')
