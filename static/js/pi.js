const positive_pKs = { Nterm: 7.5, K: 10.0, R: 12.0, H: 5.98 };
const negative_pKs = { Cterm: 3.55, D: 4.05, E: 4.45, C: 9.0, Y: 10.0 };
const pKcterminal = { D: 4.55, E: 4.75 };
const pKnterminal = { A: 7.59, M: 7.0, S: 6.93, P: 8.36, T: 6.82, V: 7.44, E: 7.7 };
const charged_aas = ["K", "R", "H", "D", "E", "C", "Y"];

function _select_charged(AminoAcidsContent) {
  let charged = {};
  for (aa of charged_aas) {
    charged[aa] = AminoAcidsContent[aa];
  }
  charged["Nterm"] = 1.0;
  charged["Cterm"] = 1.0;
  console.log(charged);
  return charged;
}

// const charged_aas_content = _select_charged(AminoAcidsContent);

function _chargeR(charged_aas_content, pH, pos_pKs, neg_pKs) {
  let PositiveCharge = 0.0;
  for (aa in pos_pKs) {
    const pK = pos_pKs[aa];
    const partial_charge = 1.0 / (10 ** (pH - pK) + 1.0);
    PositiveCharge += charged_aas_content[aa] * partial_charge;
  }
  let NegativeCharge = 0.0;
  for (aa in neg_pKs) {
    const pK = neg_pKs[aa];
    const partial_charge = 1.0 / (10 ** (pK - pH) + 1.0);
    NegativeCharge += charged_aas_content[aa] * partial_charge;
  }
  return PositiveCharge - NegativeCharge;
}

console.log(_chargeR(_select_charged({ K: 0.2, L: 0.05, D: 0.03, E: 0.4, R: 0.01, H: 0.01, C: 0.01, Y: 0.01 }), 7, positive_pKs, negative_pKs));
