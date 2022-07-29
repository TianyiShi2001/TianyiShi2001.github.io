prot = "ACDGSFPLKMNEQQWERKGFDSACNMMP".repeat(1000000);

protein = {
  A: { count: 0, mw: [89.0932, 89.047678] },
  C: { count: 0, mw: [121.1582, 121.019749] },
  D: { count: 0, mw: [133.1027, 133.037508] },
  E: { count: 0, mw: [147.1293, 147.053158] },
  F: { count: 0, mw: [165.1891, 165.078979] },
  G: { count: 0, mw: [75.0666, 75.032028] },
  H: { count: 0, mw: [155.1546, 155.069477] },
  I: { count: 0, mw: [131.1729, 131.094629] },
  K: { count: 0, mw: [146.1876, 146.105528] },
  L: { count: 0, mw: [131.1729, 131.094629] },
  M: { count: 0, mw: [149.2113, 149.051049] },
  N: { count: 0, mw: [132.1179, 132.053492] },
  O: { count: 0, mw: [255.3134, 255.158292] },
  P: { count: 0, mw: [115.1305, 115.063329] },
  Q: { count: 0, mw: [146.1445, 146.069142] },
  R: { count: 0, mw: [174.201, 174.111676] },
  S: { count: 0, mw: [105.0926, 105.042593] },
  T: { count: 0, mw: [119.1192, 119.058243] },
  U: { count: 0, mw: [168.0532, 168.964203] },
  V: { count: 0, mw: [117.1463, 117.078979] },
  W: { count: 0, mw: [204.2252, 204.089878] },
  Y: { count: 0, mw: [181.1885, 181.07389] }
};

for (a of prot) {
  protein[a]["count"]++;
}

mw = 0;
for (a in protein) {
  mw += protein[a]["count"] * protein[a]["mw"][0];
}
mw_mi = 0;
for (a in protein) {
  mw_mi += protein[a]["count"] * protein[a]["mw"][1];
}
console.log(mw_mi);
