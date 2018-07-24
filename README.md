This CMake usage example is based on the following repo:
https://github.com/tamaskenez/stackoverflow-cmake-find-link-example

It goes further and shows how to maintain a project as a collection of repos.
Each repo is built in a separate step. Some of the products are installed (exported)
in a shared directory and become available for future use (import) by the next steps.

The files under "infra" directory emulate the core functionality repo, producing
few libraries.

The files under "myexe" directory emulate a repo with a specialized app, which uses
the libraries from "infra".

Orchestration of the build steps (invoking CMake etc.) is done from 
the script "build.sh"

