This CMake usage example is initially based on the following repo:
https://github.com/tamaskenez/stackoverflow-cmake-find-link-example

It goes further and shows how to maintain a project as a collection of repos.
Three modes are presented: package mode, single tree mode, hybrid mode.

There are 2 directories simulating separate repos: "infra" and "app".

The files under "infra" directory emulate the core functionality repo, producing
few libraries.

The files under "app" directory emulate a repo with a specialized app, which uses
the libraries from "infra".


## Package mode
Each repo is built in a separate step. Some of the products are installed (exported)
in a shared directory and become available for future use (import) by the next steps.

Orchestration of the build steps (invoking CMake etc.) is done from 
the script "build.sh"

## Single tree mode
There is a common root CMakeLists.txt which orchestrates the build of the entire tree. 

It is invoked from cmake.sh script but it is done only for convenience to combine few steps.

## Hybrid (either package or single tree) mode
There is a common root CMakeLists.txt but each "repo" is ready to be built separately, 
using its own CMakeLists.txt. 

In the "package" case libraries are installed as "infra" package and "app" uses it as a collection
of pre-built binaries and headers. The user invokes "build.sh" script.

In the "single tree" case no packages are produced and all dependencies are generated together,
enabling parallel build subject only to the limitations of the single dependency tree.
The user invokes "cmake.sh" script. 

