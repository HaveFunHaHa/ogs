# cmake-lint: disable=C0103

# prefer unix location over frameworks (Apple-only)
set(Python3_FIND_FRAMEWORK LAST)
if(OGS_USE_PIP)
    set(OGS_PYTHON_PACKAGES ""
        CACHE INTERNAL "List of Python packages to be installed via pip."
    )
    set(Python3_FIND_STRATEGY VERSION)
    find_package(
        Python3 ${ogs.minimum_version.python} COMPONENTS Interpreter REQUIRED
    )

    if(NOT EXISTS ${PROJECT_BINARY_DIR}/.venv)
        execute_process(
            COMMAND ${Python3_EXECUTABLE} -m venv .venv
            WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
        )
        unset(_OGS_PYTHON_PACKAGES_SHA1 CACHE)
    endif()
    set(Python3_ROOT_DIR ${PROJECT_BINARY_DIR}/.venv)
    if(MSVC)
        set(Python3_EXECUTABLE ${Python3_ROOT_DIR}/Scripts/python.exe)
        set(LOCAL_VIRTUALENV_BIN_DIR ${PROJECT_BINARY_DIR}/.venv/Scripts
            CACHE INTERNAL ""
        )
    else()
        set(Python3_EXECUTABLE ${Python3_ROOT_DIR}/bin/python)
        set(LOCAL_VIRTUALENV_BIN_DIR ${PROJECT_BINARY_DIR}/.venv/bin
            CACHE INTERNAL ""
        )
    endif()
    if(OGS_BUILD_TESTING)
        # Notebook requirements from versions.json
        foreach(var ${ogs.python.notebook_requirements})
            list(APPEND OGS_PYTHON_PACKAGES
                 "${ogs.python.notebook_requirements_${var}}"
            )
        endforeach()
        list(APPEND OGS_PYTHON_PACKAGES
             "snakemake==${ogs.minimum_version.snakemake}"
        )
        set(SNAKEMAKE ${LOCAL_VIRTUALENV_BIN_DIR}/snakemake CACHE FILEPATH ""
                                                                  FORCE
        )
    endif()
endif()

if(OGS_USE_PYTHON)
    find_package(
        Python3 ${ogs.minimum_version.python} COMPONENTS Interpreter Development
        REQUIRED
    )
else()
    find_package(Python3 ${ogs.minimum_version.python} COMPONENTS Interpreter)
endif()
if(OGS_USE_PIP)
    if(MSVC)
        file(TO_NATIVE_PATH "${Python3_ROOT_DIR}/Lib/site-packages"
             Python3_VIRTUALENV_SITEPACKAGES
        )
        string(REPLACE "\\" "\\\\" Python3_VIRTUALENV_SITEPACKAGES
                       ${Python3_VIRTUALENV_SITEPACKAGES}
        )
    else()
        set(Python3_VIRTUALENV_SITEPACKAGES
            ${Python3_ROOT_DIR}/lib/python${Python3_VERSION_MAJOR}.${Python3_VERSION_MINOR}/site-packages
        )
    endif()
endif()
