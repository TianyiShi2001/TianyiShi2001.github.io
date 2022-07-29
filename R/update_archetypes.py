#!/usr/bin/env python

from datetime import datetime, timedelta
import math, re
from dateutil.parser import parse

class OxDate(object):
    _terms = {
        'Michaelmas': {
            'months': (10, 11, 12),
            'vac': 'Christmas'},
        'Hilary': {
            'months': (1, 2, 3),
            'vac': 'Easter'},
        'Trinity': {
            'months': (4, 5, 6),
            'vac': 'long'}
    }
    _dates = {
        2019: {
            'Michaelmas': ('10-13', '12-7')
        },
        2020: {
            'Hilary': ('1-19', '3-14'),
            'Trinity': ('4-26', '6-20'),
            'Michaelmas': ('10-11', '12-5')
        },
        2021: {
            'Hilary': ('1-17', '3-13'),
            'Trinity': ('4-25', '6-19'),
            'Michaelmas': ('10-10', '12-4')
        }
    }
    def __init__(self, date = datetime.now()):
        if date:
            if isinstance(date, str):
                self.date = parse(date)
            elif isinstance(date, datetime):
                self.date = date
        self.term = self.get_term()
        self.startDate, self.endDate = self.get_term_dates()
        self.wterm = self.get_week_of_term()
    def get_term(self):
        for termName, termInfo in OxDate._terms.items():
            if self.date.month in termInfo['months']:
                return termName
    def get_term_dates(self):
        try:
            start, end = list(map(lambda date: datetime.strptime(date, '%m-%d').replace(year = self.date.year), OxDate._dates[self.date.year][self.term.title()]))
        except:
            import lxml.etree as le
            import requests
            print('cannot find a match in the local database, getting dates online...')
            html = le.HTML(requests.get('https://www.ox.ac.uk/about/facts-and-figures/dates-of-term').text)
            start, end = html.xpath(f'(//*[text()="{self.term.title()} {self.date.year}"])[1]/following-sibling::*/text()')
            def term_date_parse(date):
                return datetime.strptime(date, '%A %d %B').replace(year=self.date.year)
            start, end = term_date_parse(start), term_date_parse(end)
        return start, end
    def get_week_of_term(self):
        week = math.ceil((self.date - self.startDate)/timedelta(weeks=1)) 
        return week

if __name__ == "__main__":
    NOW = OxDate()
    TERM, WEEK = NOW.term, NOW.wterm
    with open('tutorial.md', 'r+') as f:
        content = f.read()
        content = re.sub(r'(?<=term: ).*', TERM, content)
        content = re.sub(r'(?<=week: ).*', str(WEEK + 1), content)
        f.seek(0); f.truncate()
        f.write(content)

    with open('default.md', 'r+') as f:
        content = f.read()
        content = re.sub(r'(?<=term: ).*', TERM, content)
        content = re.sub(r'(?<=week: ).*', str(WEEK), content) 
        f.seek(0); f.truncate()
        f.write(content)