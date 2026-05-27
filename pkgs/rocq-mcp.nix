{ lib, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonPackage {
  pname = "rocq-mcp";
  version = "0.2.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "LLM4Rocq";
    repo = "rocq-mcp";
    rev = "612dec76009237e89c52a85bd29c10a75e712831";
    hash = "sha256-UdlwMv+bceC0xLTL+5q2l+1gKYrs6ChKAb01fIC+7dU=";
  };

  build-system = [ python3Packages.setuptools ];

  dependencies = with python3Packages; [
    fastmcp
    psutil
    pytanque
  ];

  meta = {
    description = "MCP server for Rocq/Coq proof development";
    license = lib.licenses.asl20;
    homepage = "https://github.com/LLM4Rocq/rocq-mcp";
    mainProgram = "rocq-mcp";
  };
}
