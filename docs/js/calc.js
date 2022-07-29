protein_weights = {
  A: 89.0932,
  C: 121.1582,
  D: 133.1027,
  E: 147.1293,
  F: 165.1891,
  G: 75.0666,
  H: 155.1546,
  I: 131.1729,
  K: 146.1876,
  L: 131.1729,
  M: 149.2113,
  N: 132.1179,
  O: 255.3134,
  P: 115.1305,
  Q: 146.1445,
  R: 174.201,
  S: 105.0926,
  T: 119.1192,
  U: 168.0532,
  V: 117.1463,
  W: 204.2252,
  Y: 181.1885
};

monoisotopic_protein_weights = {
  A: 89.047678,
  C: 121.019749,
  D: 133.037508,
  E: 147.053158,
  F: 165.078979,
  G: 75.032028,
  H: 155.069477,
  I: 131.094629,
  K: 146.105528,
  L: 131.094629,
  M: 149.051049,
  N: 132.053492,
  O: 255.158292,
  P: 115.063329,
  Q: 146.069142,
  R: 174.111676,
  S: 105.042593,
  T: 119.058243,
  U: 168.964203,
  V: 117.078979,
  W: 204.089878,
  Y: 181.073893
};

unambiguous_dna_weights = {
  A: 331.2218,
  C: 307.1971,
  G: 347.2212,
  T: 322.2085
};

monoisotopic_unambiguous_dna_weights = {
  A: 331.06817,
  C: 307.056936,
  G: 347.063084,
  T: 322.056602
};

unambiguous_rna_weights = {
  A: 347.2212,
  C: 323.1965,
  G: 363.2206,
  U: 324.1813
};

monoisotopic_unambiguous_rna_weights = {
  A: 347.063084,
  C: 323.051851,
  G: 363.057999,
  U: 324.035867
};

calcMW = (o1, o2, box, e1, e2) => {
  box.addEventListener("input", () => {
    const seq = box.value.toUpperCase();
    let mw = 0,
      mw_mi = 0;
    for (const a of seq) {
      mw += o1[a];
      mw_mi += o2[a];
    }
    e1.innerHTML = `${mw.toFixed(3)} Da (${(mw / 1000).toFixed(3)} kDa)`;
    e2.innerHTML = `${mw_mi.toFixed(3)} Da (${(mw_mi / 1000).toFixed(3)} kDa)`;
  });
};

calcMW(protein_weights, monoisotopic_protein_weights, document.getElementById("seq"), document.getElementById("mw"), document.getElementById("mw-mi"));

calcMW(unambiguous_dna_weights, monoisotopic_unambiguous_dna_weights, document.getElementById("dna"), document.getElementById("mw-dna"), document.getElementById("mw-mi-dna"));
