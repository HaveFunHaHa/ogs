+++
date = "2019-12-03T00:00:00+01:00"
title = "TecPlotTools"
author = "Karsten Rink"

[menu]
  [menu.tools]
    parent = "Data Import/Export"
+++

## Introduction

This is a utility for handling TecPlot data. At the moment, it is possible to split a file containing ```n``` time steps into ```n``` files contain one time step each, or to convert TecPlot raster data into OGS meshes. All data available for the raster will be converted into cell arrays for the OGS mesh.

This tool may be extended in the future to handle more TecPlot-related functionality.

## Usage

```bash
   TecPlotTools -i <string> [-o <string>] [-c] [-s]


Where:

   -i <string>,  --input-file <string>
     (required)  TecPlot input file

   -o <string>,  --output-file <string>
     output mesh file

   -c,  --convert
     convert TecPlot data into OGS meshes

   -s,  --split
     split time steps into separate files
```

## Simple example

**Command:**

```bash
TecPlotTools -i Lake.plt -o Lake.vtu -c
```

**Input:**

![TecPlot-Header](./PoyangLake-TecPlot.png "TecPlot-Header of file containing raster data")

**Output:**

![Converted file](./PoyangLake-ParaView.png "Converted file visualised in ParaView with all scalar data available.")
