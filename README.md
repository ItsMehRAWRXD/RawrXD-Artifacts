# RawrXD-Artifacts

Measurement evidence for `ItsMehRAWRXD/RawrXD`. Not a source repository.

```ini
REPOSITORY_ROLE=MEASUREMENT_EVIDENCE
SOURCE_OF_TRUTH=0
BUILD_AUTHORITY=0
CANONICAL_CODE=NO
```

## What belongs here

Binary artefacts that receipts reference but that should not sit in a source
tree: GPU oracle dumps, parity vectors, harness logs.

## What does not belong here

Anything buildable from the source repo. If it compiles from `RawrXD`, it
stays in `RawrXD`. This repository exists so that 163.6 MB of dumps does not
make every ordinary clone expensive — a mistake already made three times over
on sibling repositories, each ~1.9 GB, which now fail local checkout with
`error: unable to create file ... Filename too long`.

## Sets

| Set | Files | Bytes | Content root SHA-256 |
|---|---:|---:|---|
| `QORACLE_001` | 494 | 171,596,134 | `e1125164d63f50ec50f64b372eeeae7dc2915af1cf9769b599a6358090f31236` |

`CONTENT_ROOT_SHA256` is the SHA-256 of the newline-joined, path-sorted list
of `"<sha256>  <relpath>"` lines. The authoritative per-file listing lives in
the source repo at
[`rawrxd/audit/RAWRXD_ARTIFACT_MANIFEST_001/ARTIFACT_MANIFEST.md`](https://github.com/ItsMehRAWRXD/RawrXD/blob/beacon-residency-001/rawrxd/audit/RAWRXD_ARTIFACT_MANIFEST_001/ARTIFACT_MANIFEST.md)
— the manifest is versioned with the code that produced the evidence, and this
repository carries only the bytes.

Verify before trusting a set:

```powershell
Get-ChildItem _qoracle -Recurse -File | Sort-Object FullName | ForEach-Object {
  "{0}  {1}" -f (Get-FileHash $_.FullName -Algorithm SHA256).Hash.ToLower(),
           $_.FullName -replace [regex]::Escape((Get-Location).Path + '\'),''
}
```

## Known omissions

`real_tinyllama_f32.nqb` (4197.5 MB) is **not** here. It is 42x GitHub's
100 MB per-file limit and is fully reproducible:

```
gguf_to_nqb_converter.exe <model.gguf> out.nqb
```

Its provenance is recorded in the manifest, including the converter receipt
(`GGUF_TENSORS=201  CONVERTED=201  SKIPPED=0  SYNTHETIC_WEIGHTS=0  VERDICT=PASS`).

## Provenance

Extracted from `F:\~dev`, branch `beacon-residency-001`, 2026-10-05.
Model under test: `gemma3-1b-Q2_K.gguf` (whose tensor table is
Q8_0 47.0% / Q4_0 37.2% / Q3_K 14.9% — it contains **no** Q2_K despite the
filename).