#!/usr/bin/env python 3.8

import PIL
import json
from wordcloud import WordCloud

data_file = "freq.json"
wc_file = "wc.jpg"

with open(data_file) as f:
    raw = json.load(f)
    freq_dict = {t["tags"]: t["n"] for t in raw}


cloud = WordCloud(
    font_path="/Users/tianyishi/Documents/www-src/ox-src/static/fonts/source-serif/SourceHanSerifCN-Light.otf",
    background_color="white",
    margin=5,
    width=1920,
    height=1080,
)

cloud.generate_from_frequencies(freq_dict).to_file(wc_file)
