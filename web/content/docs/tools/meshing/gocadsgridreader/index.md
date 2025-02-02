+++
date = "2019-01-11T11:00:13+01:00"
title = "GocadSGridReader"
author = "Thomas Fischer"

[menu]
  [menu.tools]
    parent = "meshing"
+++

## Introduction

The tool `GocadSGridReader` reads a Gocad stratigraphic grid (file ending sg)
and writes the data in the open vtk unstructured grid file format (file ending
vtu). The tool doesn't change the geometry, i.e., it doesn't change the element
quality. Thus, the mesh may not be usable for finite mesh element simulations
immediately.

The tool is part of the official [OpenGeoSys git repository](https://github.com/ufz/ogs)
and is build when the `OGS_BUILD_UTILS` cmake switch is set `ON`. The build
executable `GocadSGridReader` is placed in the `bin` directory. The tool is a command line tool.

## Usage

Running `GocadSGridReader` tool will print the required arguments and a short usage message; for detailed usage add the `--help` argument.

```bash
bin/GocadSGridReader  -s <file_name.sg> -o <file_name.vtu>
                      [-f <true/false>] [--] [--version] [-h]

Where:

   -s <file_name.sg>,  --sg <file_name.sg>
     (required)  Gocad stratigraphic grid file name

   -o <file_name.vtu>,  --output-mesh <file_name.vtu>
     (required)  vtk unstructured grid file name

   -f <true/false>,  --generate-face-sets <true/false>
     generate face sets; default false, i.e. do not generate face sets
```

## Example

```bash
GocadSGridReader -s flow_simulation_grid_klein_Rinne.sg -o flow_simulation_grid_klein_Rinne.vtu
```

![Gocad SGrid](flow_simulation_klein_Grid_Rinne.png)

## Applications

### Thuringia Syncline (INFLUINS project)

![GO2OGS Workflow](WorkflowGO2OGS.png "The tool was used to convert Gocad stratigraphic grids ('GoCad Model' in
figure below) of the Thuringia syncline to a vtk unstructured grid ('VTU'
in the figure) within the INFLUINS project. Further conversion steps were taken
to prepare the mesh for the simulation (not part of this tool, see Fischer et
al. 2015).")

#### Publication

{{< bib "fischer:2015" >}}

### Other

- Rotenburger Rinne (Geologischer Dienst für Niedersachsen, Referat Hydrogeologie Landesamt für Bergbau, Energie und Geologie, Jörg Elbracht)
- Heat storage model HH (Christian-Albrechts-Universität zu Kiel, Institut für Geowissenschaften, Janine Struß)
- Geothermal project (British Geological Survey, Richard Haslam)
