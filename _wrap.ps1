$ErrorActionPreference='Stop'
try {
  & 'F:\~dev\rawrxd\tools\owner_proof_001.ps1' -LinkLog 'F:\~dev\_gold_build30.txt' -ProjectRoot 'F:\~dev\rawrxd' -VerifyExports -Out 'F:\~dev\_owner_proof_verified.txt' | Out-Null
  "EXIT_OK"
} catch {
  "MSG: " + $_.Exception.Message
  "LINE: " + $_.InvocationInfo.ScriptLineNumber
  "SRC : " + $_.InvocationInfo.Line.Trim()
}
