return {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  formatCommand = "eslint_d --stdin --fix-to-stdout --stdin-filename=${INPUT}",
  formatStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
}
