
AddTest(
    NAME MapGeometryToMeshSurface_Ammer
    PATH MeshGeoToolsLib/Ammer
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Ammer
    EXECUTABLE MapGeometryToMeshSurface
    EXECUTABLE_ARGS -m Ammer-Homogen100m-Final-TopSurface.vtu -i Ammer-Rivers.gml -a -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Ammer/Ammer-Rivers-Mapped.gml
    TESTER diff
    DIFF_DATA Ammer-Rivers-Mapped.gml
)

AddTest(
    NAME MapGeometryToMeshSurface_Bode
    PATH MeshGeoToolsLib/Bode
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Bode
    EXECUTABLE MapGeometryToMeshSurface
    EXECUTABLE_ARGS -m BodeComplex.msh -i BodeEZG_Fliessgewaesser.gml -a -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Bode/BodeEZG_Fliessgewaesser-Mapped.gml
    RUNTIME 7
    TESTER gmldiff
    DIFF_DATA BodeEZG_Fliessgewaesser-Mapped.gml 1e-10 1e-10
)

AddTest(
    NAME MapGeometryToMeshSurface_Naegelstedt
    PATH MeshGeoToolsLib/Naegelstedt
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Naegelstedt
    EXECUTABLE MapGeometryToMeshSurface
    EXECUTABLE_ARGS -m SmallTest.vtu -i RiverNetwork.gml -a -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Naegelstedt/RiverNetwork-Mapped.gml
    RUNTIME 7
    TESTER diff
    DIFF_DATA RiverNetwork-Mapped.gml
)

AddTest(
    NAME postLIE
    PATH LIE/PostProcessing
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/LIE/PostProcessing
    EXECUTABLE postLIE
    EXECUTABLE_ARGS -i single_joint.pvd -o ${Data_BINARY_DIR}/LIE/PostProcessing/post_single_joint.pvd
    REQUIREMENTS OGS_BUILD_PROCESS_LIE
    TESTER vtkdiff
    DIFF_DATA
    expected_post_single_joint_ts_1_t_1.000000.vtu post_single_joint_ts_1_t_1.000000.vtu u u 1e-14 1e-14
)

AddTest(
    NAME postLIE3D
    PATH LIE/PostProcessing
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/LIE/PostProcessing
    EXECUTABLE postLIE
    EXECUTABLE_ARGS -i single_joint_3D.pvd -o ${Data_BINARY_DIR}/LIE/PostProcessing/post_single_joint_3D.pvd
    REQUIREMENTS OGS_BUILD_PROCESS_LIE
    TESTER vtkdiff
    DIFF_DATA
    post_single_joint_3D_ts_1_t_1.000000.vtu post_single_joint_3D_ts_1_t_1.000000.vtu u u 1e-14 1e-14
)

AddTest(
    NAME identifySubdomains_2D_Create
    PATH MeshGeoToolsLib/IdentifySubdomains
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/IdentifySubdomains
    EXECUTABLE identifySubdomains
    EXECUTABLE_ARGS -m 2D_mesh.vtu -o ${Data_BINARY_DIR}/MeshGeoToolsLib/IdentifySubdomains/new_ -- 2D_mesh_top_boundary.vtu 2D_mesh_bottom_boundary.vtu
    TESTER vtkdiff
    DIFF_DATA
    2D_mesh_top.vtu new_2D_mesh_top_boundary.vtu bulk_node_ids bulk_node_ids 0 0
    2D_mesh_top.vtu new_2D_mesh_top_boundary.vtu bulk_element_ids bulk_element_ids 0 0
    2D_mesh_bottom.vtu new_2D_mesh_bottom_boundary.vtu bulk_node_ids bulk_node_ids 0 0
    2D_mesh_bottom.vtu new_2D_mesh_bottom_boundary.vtu bulk_element_ids bulk_element_ids 0 0
)

AddTest(
    NAME identifySubdomains_2D_Check
    PATH MeshGeoToolsLib/IdentifySubdomains
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/IdentifySubdomains
    EXECUTABLE identifySubdomains
    EXECUTABLE_ARGS -m 2D_mesh.vtu -o ${Data_BINARY_DIR}/MeshGeoToolsLib/IdentifySubdomains/check_ -- 2D_mesh_top.vtu 2D_mesh_bottom.vtu
    TESTER vtkdiff
    DIFF_DATA
    2D_mesh_top.vtu check_2D_mesh_top.vtu bulk_node_ids bulk_node_ids 0 0
    2D_mesh_top.vtu check_2D_mesh_top.vtu bulk_element_ids bulk_element_ids 0 0
    2D_mesh_bottom.vtu check_2D_mesh_bottom.vtu bulk_node_ids bulk_node_ids 0 0
    2D_mesh_bottom.vtu check_2D_mesh_bottom.vtu bulk_element_ids bulk_element_ids 0 0
)

AddTest(
    NAME identifySubdomains_riverTriangleMesh
    PATH MeshGeoToolsLib/IdentifySubdomains
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/IdentifySubdomains
    EXECUTABLE identifySubdomains
    EXECUTABLE_ARGS -m river_domain_triangle.vtu -o ${Data_BINARY_DIR}/MeshGeoToolsLib/IdentifySubdomains/triangle_ -- river_bc.vtu
    TESTER vtkdiff
    DIFF_DATA
    river_bc_triangle.vtu triangle_river_bc.vtu bulk_node_ids bulk_node_ids 0 0
    #river_bc_triangle.vtu triangle_river_bc.vtu bulk_element_ids bulk_element_ids 0 0   # TODO (naumov) Needs extension of vtkdiff to FieldData
    river_bc_triangle.vtu triangle_river_bc.vtu number_bulk_elements number_bulk_elements 0 0
)

AddTest(
    NAME identifySubdomains_riverPrismMesh
    PATH MeshGeoToolsLib/IdentifySubdomains
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/IdentifySubdomains
    EXECUTABLE identifySubdomains
    EXECUTABLE_ARGS -s 1e-3 -m river_domain_prism.vtu -o ${Data_BINARY_DIR}/MeshGeoToolsLib/IdentifySubdomains/prism_ -- river_bc.vtu
    TESTER vtkdiff
    DIFF_DATA
    river_bc_prism.vtu prism_river_bc.vtu bulk_node_ids bulk_node_ids 0 0
    #river_bc_prism.vtu prism_river_bc.vtu bulk_element_ids bulk_element_ids 0 0 # TODO (naumov) Needs extension of vtkdiff to FieldData
    river_bc_prism.vtu prism_river_bc.vtu number_bulk_elements number_bulk_elements 0 0
)

AddTest(
    NAME partmesh_2Dmesh_ogs2metis
    PATH NodePartitionedMesh/partmesh_2Dmesh_3partitions/Binary
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/partmesh_2Dmesh_3partitions/Binary
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -i 2Dmesh.vtu --ogs2metis
                    -o ${Data_BINARY_DIR}/NodePartitionedMesh/partmesh_2Dmesh_3partitions/Binary
)

AddTest(
    NAME partmesh_2Dmesh_3partitions_binary
    PATH NodePartitionedMesh/partmesh_2Dmesh_3partitions/Binary
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/partmesh_2Dmesh_3partitions/Binary
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -m -n 3 -i 2Dmesh.vtu
                    -o ${Data_BINARY_DIR}/NodePartitionedMesh/partmesh_2Dmesh_3partitions/Binary --
                    2Dmesh_PLY_EAST.vtu
                    2Dmesh_PLY_WEST.vtu
                    2Dmesh_PLY_NORTH.vtu
                    2Dmesh_PLY_SOUTH.vtu
                    2Dmesh_POINT4.vtu
                    2Dmesh_POINT5.vtu
    # Mac is producing slightly different partitioning, so the results are not
    # comparable.
    REQUIREMENTS NOT APPLE
    DEPENDS partmesh-partmesh_2Dmesh_ogs2metis
    TESTER diff
    DIFF_DATA 2Dmesh_partitioned_node_properties_val3.bin
              2Dmesh_partitioned_node_properties_cfg3.bin
              2Dmesh_partitioned_msh_cfg3.bin
              2Dmesh_partitioned_cell_properties_val3.bin
              2Dmesh_partitioned_cell_properties_cfg3.bin
              2Dmesh_partitioned_msh_ele_g3.bin
              2Dmesh_partitioned_msh_ele3.bin
              2Dmesh_partitioned_msh_nod3.bin
              2Dmesh_PLY_EAST_partitioned_msh_cfg3.bin
              2Dmesh_PLY_EAST_partitioned_msh_ele3.bin
              2Dmesh_PLY_EAST_partitioned_msh_ele_g3.bin
              2Dmesh_PLY_EAST_partitioned_msh_nod3.bin
              2Dmesh_PLY_NORTH_partitioned_msh_cfg3.bin
              2Dmesh_PLY_NORTH_partitioned_msh_ele3.bin
              #2Dmesh_PLY_NORTH_partitioned_msh_ele_g3.bin   empty
              2Dmesh_PLY_NORTH_partitioned_msh_nod3.bin
              2Dmesh_PLY_SOUTH_partitioned_msh_cfg3.bin
              2Dmesh_PLY_SOUTH_partitioned_msh_ele3.bin
              #2Dmesh_PLY_SOUTH_partitioned_msh_ele_g3.bin   empty
              2Dmesh_PLY_SOUTH_partitioned_msh_nod3.bin
              2Dmesh_PLY_WEST_partitioned_msh_cfg3.bin
              2Dmesh_PLY_WEST_partitioned_msh_ele3.bin
              2Dmesh_PLY_WEST_partitioned_msh_ele_g3.bin
              2Dmesh_PLY_WEST_partitioned_msh_nod3.bin
              2Dmesh_POINT4_partitioned_msh_cfg3.bin
              2Dmesh_POINT4_partitioned_msh_ele3.bin
              #2Dmesh_PLY_POINT4_partitioned_msh_ele_g3.bin   empty
              2Dmesh_POINT4_partitioned_msh_nod3.bin
              2Dmesh_POINT5_partitioned_msh_cfg3.bin
              2Dmesh_POINT5_partitioned_msh_ele3.bin
              #2Dmesh_PLY_POINT5_partitioned_msh_ele_g3.bin   empty
              2Dmesh_POINT5_partitioned_msh_nod3.bin

              2Dmesh_PLY_EAST_partitioned_cell_properties_cfg3.bin
              2Dmesh_PLY_EAST_partitioned_cell_properties_val3.bin
              2Dmesh_PLY_NORTH_partitioned_cell_properties_cfg3.bin
              2Dmesh_PLY_NORTH_partitioned_cell_properties_val3.bin
              2Dmesh_PLY_SOUTH_partitioned_cell_properties_cfg3.bin
              2Dmesh_PLY_SOUTH_partitioned_cell_properties_val3.bin
              2Dmesh_PLY_WEST_partitioned_cell_properties_cfg3.bin
              2Dmesh_PLY_WEST_partitioned_cell_properties_val3.bin
              2Dmesh_POINT4_partitioned_cell_properties_cfg3.bin
              2Dmesh_POINT4_partitioned_cell_properties_val3.bin
              2Dmesh_POINT5_partitioned_cell_properties_cfg3.bin
              2Dmesh_POINT5_partitioned_cell_properties_val3.bin

              2Dmesh_PLY_EAST_partitioned_node_properties_cfg3.bin
              2Dmesh_PLY_EAST_partitioned_node_properties_val3.bin
              2Dmesh_PLY_NORTH_partitioned_node_properties_cfg3.bin
              2Dmesh_PLY_NORTH_partitioned_node_properties_val3.bin
              2Dmesh_PLY_SOUTH_partitioned_node_properties_cfg3.bin
              2Dmesh_PLY_SOUTH_partitioned_node_properties_val3.bin
              2Dmesh_PLY_WEST_partitioned_node_properties_cfg3.bin
              2Dmesh_PLY_WEST_partitioned_node_properties_val3.bin
              2Dmesh_POINT4_partitioned_node_properties_cfg3.bin
              2Dmesh_POINT4_partitioned_node_properties_val3.bin
              2Dmesh_POINT5_partitioned_node_properties_cfg3.bin
              2Dmesh_POINT5_partitioned_node_properties_val3.bin
)

AddTest(
    NAME partmesh_mesh_for_QuadraticElements_quad8_ogs2metis
    PATH NodePartitionedMesh/QuadraticElements/Quad8
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad8
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -i quad_q.vtu --ogs2metis -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad8
)

AddTest(
    NAME partmesh_mesh_for_QuadraticElements_quad8
    PATH NodePartitionedMesh/QuadraticElements/Quad8
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad8
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -m  -n 2 -i quad_q.vtu -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad8
    REQUIREMENTS NOT APPLE
    DEPENDS partmesh-partmesh_mesh_for_QuadraticElements_quad8_ogs2metis
    TESTER diff
    DIFF_DATA quad_q_partitioned_msh_ele2.bin
              quad_q_partitioned_msh_ele_g2.bin
              quad_q_partitioned_msh_nod2.bin
              quad_q_partitioned_msh_cfg2.bin
              quad_q_partitioned_cell_properties_cfg2.bin
              quad_q_partitioned_cell_properties_val2.bin
)

AddTest(
    NAME partmesh_mesh_for_QuadraticElements_quad9_ogs2metis
    PATH NodePartitionedMesh/QuadraticElements/Quad9
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad9
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -i quad_9node.vtu --ogs2metis -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad9
)

AddTest(
    NAME partmesh_mesh_for_QuadraticElements_quad9
    PATH NodePartitionedMesh/QuadraticElements/Quad9
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad9
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -m -n 2 -i quad_9node.vtu -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad9
    REQUIREMENTS NOT APPLE
    DEPENDS partmesh-partmesh_mesh_for_QuadraticElements_quad9_ogs2metis
    TESTER diff
    DIFF_DATA  quad_9node_partitioned_msh_ele2.bin
               quad_9node_partitioned_msh_ele_g2.bin
               quad_9node_partitioned_msh_nod2.bin
               quad_9node_partitioned_msh_cfg2.bin
               quad_9node_partitioned_cell_properties_cfg2.bin
               quad_9node_partitioned_cell_properties_val2.bin
)

##############Quadratic Triangle##############
AddTest(
    NAME partmesh_mesh_for_QuadraticTriangle_ogsmetis
    PATH NodePartitionedMesh/QuadraticElements/Quad_triangle
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad_triangle
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -i basicQuadTri.vtu --ogs2metis -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad_triangle
)

AddTest(
    NAME partmesh_mesh_for_QuadraticTriangle
    PATH NodePartitionedMesh/QuadraticElements/Quad_triangle
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad_triangle
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -m -n 2 -i basicQuadTri.vtu -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad_triangle
    REQUIREMENTS NOT APPLE
    DEPENDS partmesh-partmesh_mesh_for_QuadraticTriangle_ogsmetis
    TESTER diff
    DIFF_DATA  basicQuadTri_partitioned_cell_properties_cfg2.bin
               basicQuadTri_partitioned_msh_cfg2.bin
               basicQuadTri_partitioned_msh_ele_g2.bin
               basicQuadTri_partitioned_cell_properties_val2.bin
               basicQuadTri_partitioned_msh_ele2.bin
               basicQuadTri_partitioned_msh_nod2.bin
)
################################################

##############Quadratic Tet#####################
AddTest(
    NAME partmesh_mesh_for_QuadraticTet_ogsmetis
    PATH NodePartitionedMesh/QuadraticElements/Quad_tet
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad_tet
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -i basicQuadTet.vtu --ogs2metis -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad_tet
)

AddTest(
    NAME partmesh_mesh_for_QuadraticTet
    PATH NodePartitionedMesh/QuadraticElements/Quad_tet
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad_tet
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -m -n 2 -i basicQuadTet.vtu -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad_tet
    REQUIREMENTS NOT APPLE
    DEPENDS partmesh-partmesh_mesh_for_QuadraticTet_ogsmetis
    TESTER diff
    DIFF_DATA   basicQuadTet_partitioned_cell_properties_cfg2.bin
                basicQuadTet_partitioned_cell_properties_val2.bin
                basicQuadTet_partitioned_msh_cfg2.bin
                basicQuadTet_partitioned_msh_ele2.bin
                basicQuadTet_partitioned_msh_ele_g2.bin
                basicQuadTet_partitioned_msh_nod2.bin
)
################################################

##############Quadratic Hex#####################
AddTest(
    NAME partmesh_mesh_for_QuadraticHex_ogsmetis
    PATH NodePartitionedMesh/QuadraticElements/Quad_hex
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad_hex
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -i basicQuadHex.vtu --ogs2metis -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad_hex
)

AddTest(
    NAME partmesh_mesh_for_QuadraticHex
    PATH NodePartitionedMesh/QuadraticElements/Quad_hex
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad_hex
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -m -n 2 -i basicQuadHex.vtu -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad_hex
    REQUIREMENTS NOT APPLE
    DEPENDS partmesh-partmesh_mesh_for_QuadraticHex_ogsmetis
    TESTER diff
    DIFF_DATA   basicQuadHex_partitioned_cell_properties_cfg2.bin
                basicQuadHex_partitioned_cell_properties_val2.bin
                basicQuadHex_partitioned_msh_cfg2.bin
                basicQuadHex_partitioned_msh_ele2.bin
                basicQuadHex_partitioned_msh_ele_g2.bin
                basicQuadHex_partitioned_msh_nod2.bin
)
################################################

##############Quadratic Line#####################
AddTest(
    NAME partmesh_mesh_for_QuadraticLine_ogsmetis
    PATH NodePartitionedMesh/QuadraticElements/Quad_line
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad_line
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -i basicQuadLine.vtu --ogs2metis -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad_line
)

AddTest(
    NAME partmesh_mesh_for_QuadraticLine
    PATH NodePartitionedMesh/QuadraticElements/Quad_line
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/QuadraticElements/Quad_line
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -m -n 2 -i basicQuadLine.vtu -o ${Data_BINARY_DIR}/NodePartitionedMesh/QuadraticElements/Quad_line
    REQUIREMENTS NOT APPLE
    DEPENDS partmesh-partmesh_mesh_for_QuadraticLine_ogsmetis
    TESTER diff
    DIFF_DATA   basicQuadLine_partitioned_cell_properties_cfg2.bin
                basicQuadLine_partitioned_cell_properties_val2.bin
                basicQuadLine_partitioned_msh_cfg2.bin
                basicQuadLine_partitioned_msh_ele2.bin
                basicQuadLine_partitioned_msh_ele_g2.bin
                basicQuadLine_partitioned_msh_nod2.bin
)
################################################

# Regression test for https://github.com/ufz/ogs/issues/1845 fixed in
# https://github.com/ufz/ogs/pull/2237
# checkMesh crashed when encountered Line3 element.
AddTest(
    NAME checkMesh_LIE_HM_TaskB
    PATH LIE/HydroMechanics
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/LIE/HydroMechanics
    EXECUTABLE checkMesh
    EXECUTABLE_ARGS -p -v TaskB_mesh.vtu
)

AddTest(
    NAME mesh2raster_test
    PATH MeshGeoToolsLib/Hamburg
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Hamburg
    EXECUTABLE Mesh2Raster
    EXECUTABLE_ARGS -i 00-surface.vtu -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Hamburg/00-raster.asc -c 25
    TESTER diff
    DIFF_DATA 00-raster.asc
)

MeshTest(
    NAME ExtractSurfaceLeft
    PATH MeshLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
    EXECUTABLE ExtractSurface
    EXECUTABLE_ARGS -i cube_1x1x1_hex_1e3_layers_10.vtu -o ${Data_BINARY_DIR}/MeshLib/Left.vtu -x 1 -y 0 -z 0 -a 25
    DIFF_DATA Left.vtu Left.vtu 1e-16
)

MeshTest(
    NAME ExtractSurfaceRight
    PATH MeshLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
    EXECUTABLE ExtractSurface
    EXECUTABLE_ARGS -i cube_1x1x1_hex_1e3_layers_10.vtu -o ${Data_BINARY_DIR}/MeshLib/Right.vtu -x -1 -y 0 -z 0 -a 25
    DIFF_DATA Right.vtu Right.vtu 1e-16
)

MeshTest(
    NAME ExtractSurfaceFront
    PATH MeshLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
    EXECUTABLE ExtractSurface
    EXECUTABLE_ARGS -i cube_1x1x1_hex_1e3_layers_10.vtu -o ${Data_BINARY_DIR}/MeshLib/Front.vtu -x 0 -y 1 -z 0 -a 25
    DIFF_DATA Front.vtu Front.vtu 1e-16
)

MeshTest(
    NAME ExtractSurfaceBack
    PATH MeshLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
    EXECUTABLE ExtractSurface
    EXECUTABLE_ARGS -i cube_1x1x1_hex_1e3_layers_10.vtu -o ${Data_BINARY_DIR}/MeshLib/Back.vtu -x 0 -y -1 -z 0 -a 25
    DIFF_DATA Back.vtu Back.vtu 1e-16
)

MeshTest(
    NAME GocadTSurface_Mesh_Test
    PATH MeshLib
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
    EXECUTABLE GocadTSurfaceReader
    EXECUTABLE_ARGS -i Top-Lower-Shaly.ts -o ${Data_BINARY_DIR}/MeshLib -b
    DIFF_DATA Top-Lower-Shaly.vtu Top-Lower-Shaly.vtu 1e-16
)

AddTest(
    NAME GocadTSurface_Array_Test
    PATH MeshLib
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
    EXECUTABLE GocadTSurfaceReader
    EXECUTABLE_ARGS -i Top-Lower-Shaly.ts -o ${Data_BINARY_DIR}/MeshLib -b
    DEPENDS GocadTSurfaceReader-GocadTSurface_Mesh_Test-vtkdiff
    TESTER vtkdiff
    DIFF_DATA
    Top-Lower-Shaly.vtu Top-Lower-Shaly.vtu Reshape_Thickness Reshape_Thickness 1e-16 0
    Top-Lower-Shaly.vtu Top-Lower-Shaly.vtu Measured_Depth Measured_Depth 1e-16 0
)

AddTest(
    NAME createIntermediateRasters_test
    PATH MeshGeoToolsLib/Hamburg
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Hamburg
    EXECUTABLE createIntermediateRasters
    EXECUTABLE_ARGS --file1 layer04.asc --file2 layer17.asc -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Hamburg/output.asc
    TESTER diff
    DIFF_DATA output0.asc
)

AddTest(
    NAME Vtu2Grid_Test
    PATH FileIO/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/FileIO
    EXECUTABLE Vtu2Grid
    EXECUTABLE_ARGS -i AmmerSubsurfaceCoarse.vtu -o ${Data_BINARY_DIR}/FileIO/AmmerGridOutput.vtu -x 200 -y 200 -z 20
    TESTER vtkdiff
    DIFF_DATA
    AmmerSubsurfaceGrid.vtu AmmerGridOutput.vtu MaterialIDs MaterialIDs 0 0
)

if(SNAKEMAKE AND TEE_TOOL_PATH)
    add_test(NAME snakemake_ExtractBoundary
        COMMAND ${SNAKEMAKE} -j 1
            --configfile ${PROJECT_BINARY_DIR}/buildinfo.yaml
            -s ${CMAKE_CURRENT_SOURCE_DIR}/ExtractBoundary.smk
    )

    add_test(NAME snakemake_VoxelGridFromLayers
        COMMAND ${SNAKEMAKE} -j 1
            --configfile ${PROJECT_BINARY_DIR}/buildinfo.yaml
            -s ${CMAKE_CURRENT_SOURCE_DIR}/VoxelGridFromLayers.smk
    )
    set_tests_properties(snakemake_ExtractBoundary snakemake_VoxelGridFromLayers
        PROPERTIES LABELS "default"
    )
    add_dependencies(ctest ExtractBoundary Layers2Grid AddFaultToVoxelGrid generateStructuredMesh)
endif()

AddTest(
    NAME partmesh_with_field_data
    PATH NodePartitionedMesh/partmesh
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/NodePartitionedMesh/partmesh
    EXECUTABLE partmesh
    EXECUTABLE_ARGS -n 2 -i cube_1x1x1_hex_8.vtu -x cube_1x1x1_hex_8 -o ${Data_BINARY_DIR}/NodePartitionedMesh/partmesh
    TESTER diff
    DIFF_DATA
        cube_1x1x1_hex_8_partitioned_cell_properties_cfg2.bin
        cube_1x1x1_hex_8_partitioned_cell_properties_val2.bin
        cube_1x1x1_hex_8_partitioned_msh_cfg2.bin
        cube_1x1x1_hex_8_partitioned_msh_ele2.bin
        cube_1x1x1_hex_8_partitioned_msh_ele_g2.bin
        cube_1x1x1_hex_8_partitioned_msh_nod2.bin
        cube_1x1x1_hex_8_partitioned_node_properties_cfg2.bin
        cube_1x1x1_hex_8_partitioned_node_properties_val2.bin
)

if(OGS_USE_NETCDF)
    AddTest(
        NAME NetCDF_2D_Test
        PATH FileConverter/
        WORKING_DIRECTORY ${Data_SOURCE_DIR}/FileConverter
        EXECUTABLE NetCdfConverter
        EXECUTABLE_ARGS -i sresa1b_ncar_ccsm3-example.nc -o ${Data_BINARY_DIR}/FileConverter/sresa1b_ncar_ccsm3-example.vtu -v pr -t 0 --dim1 2 --dim2 1 --timestep-first 0 --timestep-last 0 -e tri
        TESTER vtkdiff
        DIFF_DATA
        sresa1b_ncar_ccsm3-example.vtu sresa1b_ncar_ccsm3-example.vtu pr pr 1e-16 0
    )

    AddTest(
        NAME NetCDF_3D_Test
        PATH FileConverter/
        WORKING_DIRECTORY ${Data_SOURCE_DIR}/FileConverter
        EXECUTABLE NetCdfConverter
        EXECUTABLE_ARGS -i slim_100897_198.nc -o ${Data_BINARY_DIR}/FileConverter/slim_100897_198.vtu -v NO -t 0 --dim1 3 --dim2 2 --dim3 1 --timestep-first 0 --timestep-last 0 -e hex
        TESTER vtkdiff
        DIFF_DATA
        slim_100897_198.vtu slim_100897_198.vtu NO NO 1e-16 0
    )

    AddTest(
        NAME NetCDF_Image_Test
        PATH FileConverter
        WORKING_DIRECTORY ${Data_SOURCE_DIR}/FileConverter
        EXECUTABLE NetCdfConverter
        EXECUTABLE_ARGS -i sresa1b_ncar_ccsm3-example.nc -o ${Data_BINARY_DIR}/FileConverter/sresa1b_ncar_ccsm3-example.asc -v pr -t 0 --dim1 2 --dim2 1 --timestep-first 0 --timestep-last 0 --images
        TESTER diff
        DIFF_DATA sresa1b_ncar_ccsm3-example0.asc
    )
endif()

if(OGS_BUILD_GUI)
    AddTest(
        NAME RemoveGhostData_Test
        PATH MeshLib
        WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
        EXECUTABLE RemoveGhostData
        EXECUTABLE_ARGS -i Mesh3D.pvtu -o ${Data_BINARY_DIR}/MeshLib/RemoveGhostDataOutput.vtu
        TESTER vtkdiff
        DIFF_DATA
        RemoveGhostDataOutput.vtu RemoveGhostDataOutput.vtu slice slice 0 0
    )

    AddTest(
        NAME RemoveGhostData_EllipticSquareTest
        PATH EllipticPETSc
        WORKING_DIRECTORY ${Data_SOURCE_DIR}/EllipticPETSc
        EXECUTABLE RemoveGhostData
        EXECUTABLE_ARGS -i square_1e1_neumann_ts_1_t_1_000000.pvtu -o ${Data_BINARY_DIR}/EllipticPETSc/square_1e1_neumann_ts_1_t_1_000000.vtu
        TESTER diff
        DIFF_DATA
        square_1e1_neumann_ts_1_t_1_000000.vtu
    )
endif()

AddTest(
    NAME Raster2Mesh_Elevation_Test
    PATH FileConverter
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/FileConverter
    EXECUTABLE Raster2Mesh
    EXECUTABLE_ARGS -i RainEvent30.asc -o ${Data_BINARY_DIR}/FileConverter/RainEvent30-elevation.vtu -e tri -p elevation
    TESTER diff
    DIFF_DATA RainEvent30-elevation.vtu
)

AddTest(
    NAME Raster2Mesh_Materials_Test
    PATH FileConverter
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/FileConverter
    EXECUTABLE Raster2Mesh
    EXECUTABLE_ARGS -i RainEvent30.asc -o ${Data_BINARY_DIR}/FileConverter/RainEvent30-materials.vtu -e quad -p materials
    TESTER vtkdiff
    DIFF_DATA
    RainEvent30-materials.vtu RainEvent30-materials.vtu MaterialIDs MaterialIDs 0 0
)

AddTest(
    NAME Raster2Mesh_Scalars_Test
    PATH FileConverter
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/FileConverter
    EXECUTABLE Raster2Mesh
    EXECUTABLE_ARGS -i RainEvent30.asc -o ${Data_BINARY_DIR}/FileConverter/RainEvent30-scalars.vtu -e tri -p scalar -n ScalarValues
    TESTER vtkdiff
    DIFF_DATA
    RainEvent30-scalars.vtu RainEvent30-scalars.vtu ScalarValues ScalarValues 0 0
)

AddTest(
    NAME AssignRasterDataToMesh2D_Test
    PATH MeshGeoToolsLib/Ammer
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Ammer
    EXECUTABLE AssignRasterDataToMesh
    EXECUTABLE_ARGS -i Ammer-Homogen100m-Final-TopSurface.vtu -r AmmerGWN.asc -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Ammer/AmmerGWN.vtu -s GWN -c -n
    TESTER vtkdiff
    DIFF_DATA
    AmmerGWN.vtu AmmerGWN.vtu GWN GWN 0 0
    AmmerGWN.vtu AmmerGWN.vtu GWN-2 GWN-2 0 0
)

AddTest(
    NAME AssignRasterDataToMesh1D_Test
    PATH MeshGeoToolsLib/Ammer
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Ammer
    EXECUTABLE AssignRasterDataToMesh
    EXECUTABLE_ARGS -i AmmerRivers.vtu -r AmmerGWN.asc -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Ammer/AmmerRiversGWN.vtu -s GWN -c -n
    TESTER vtkdiff
    DIFF_DATA
    AmmerRiversGWN.vtu AmmerRiversGWN.vtu GWN GWN 0 0
    AmmerRiversGWN.vtu AmmerRiversGWN.vtu GWN-2 GWN-2 0 0
)

AddTest(
    NAME ExtractMaterials_Test
    PATH MeshGeoToolsLib/Naegelstedt
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Naegelstedt
    EXECUTABLE ExtractMaterials
    EXECUTABLE_ARGS -i SmallTest.vtu -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Naegelstedt/SmallTest.vtu
    TESTER diff
    DIFF_DATA SmallTest_Layer1.vtu
              SmallTest_Layer2.vtu
              SmallTest_Layer3.vtu
)

# Tests requires gmsh
if(TARGET VerticalSliceFromLayers AND GMSH)
    AddTest(
        NAME VerticalSliceFromLayers_Test
        PATH MeshGeoToolsLib/Ammer
        WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Ammer
        EXECUTABLE VerticalSliceFromLayers
        EXECUTABLE_ARGS -i AmmerLayers.txt -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Ammer/AmmerSlice --start-x 3491000 --start-y 5380000 --end-x 3495000 --end-y 5385000 -r 200
        DIFF_DATA AmmerSlice.vtu AmmerSlice.vtu 1e-16
    )

endif()

if(TARGET GMSH2OGS AND SNAKEMAKE AND TEE_TOOL_PATH)
    add_test(NAME snakemake_GMSH2OGS_ExtractBoundary
        COMMAND ${SNAKEMAKE} --cores all
        --configfile ${PROJECT_BINARY_DIR}/buildinfo.yaml
        -s ${CMAKE_CURRENT_SOURCE_DIR}/GMSH2OGS_ExtractBoundary.smk
    )
    set_tests_properties(snakemake_GMSH2OGS_ExtractBoundary PROPERTIES LABELS "default")
    add_dependencies(ctest GMSH2OGS)
endif()

foreach(criterion ElementSize EdgeRatio EquiAngleSkew RadiusEdgeRatio SizeDifference)
    AddTest(
        NAME TrianglesGoodElementQuality_${criterion}_Test
        PATH MeshGeoToolsLib/Ammer
        WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Ammer
        EXECUTABLE AddElementQuality
        EXECUTABLE_ARGS -i AmmerGWN.vtu -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Ammer/AmmerGWNWithElementQuality_${criterion}.vtu -c ${criterion}
        TESTER vtkdiff
        DIFF_DATA
        AmmerGWNWithElementQuality.vtu AmmerGWNWithElementQuality_${criterion}.vtu ${criterion} ${criterion} 1e-8 1e-11
    )
endforeach()

foreach(criterion ElementSize EdgeRatio EquiAngleSkew RadiusEdgeRatio SizeDifference)
    AddTest(
        NAME TrianglesPoorElementQuality_${criterion}_Test
        PATH MeshGeoToolsLib/Hamburg
        WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/Hamburg
        EXECUTABLE AddElementQuality
        EXECUTABLE_ARGS -i 00-surface.vtu -o ${Data_BINARY_DIR}/MeshGeoToolsLib/Hamburg/00-surface-WithElementQuality_${criterion}.vtu -c ${criterion}
        TESTER vtkdiff
        DIFF_DATA
        00-surface-WithElementQuality.vtu 00-surface-WithElementQuality_${criterion}.vtu ${criterion} ${criterion} 1e-8 1e-11
    )
endforeach()

foreach(criterion ElementSize EdgeRatio EquiAngleSkew RadiusEdgeRatio SizeDifference)
    AddTest(
        NAME Mixed3DElementQuality_${criterion}_Test
        PATH FileIO
        WORKING_DIRECTORY ${Data_SOURCE_DIR}/FileIO
        EXECUTABLE AddElementQuality
        EXECUTABLE_ARGS -i AmmerSubsurfaceCoarse.vtu -o ${Data_BINARY_DIR}/FileIO/AmmerSubsurfaceCoarse-WithElementQuality_${criterion}.vtu -c ${criterion}
        TESTER vtkdiff
        DIFF_DATA
        AmmerSubsurfaceCoarse-WithElementQuality.vtu AmmerSubsurfaceCoarse-WithElementQuality_${criterion}.vtu ${criterion} ${criterion} 1e-8 1e-11
    )
endforeach()

AddTest(
    NAME IntegrateBoreholesIntoMesh_MatOnly_Test
    PATH MeshGeoToolsLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib
    EXECUTABLE IntegrateBoreholesIntoMesh
    EXECUTABLE_ARGS -i PrismCube10x10x10.vtu -o ${Data_BINARY_DIR}/MeshGeoToolsLib/PrismBHE_mat.vtu -g testpoints.gml --min-id 4 --max-id 8
    TESTER diff
    DIFF_DATA
    PrismBHE_mat.vtu
)

AddTest(
    NAME IntegrateBoreholesIntoMesh_ElevationAndMat_Test
    PATH MeshGeoToolsLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib
    EXECUTABLE IntegrateBoreholesIntoMesh
    EXECUTABLE_ARGS -i PrismCube10x10x10.vtu -o ${Data_BINARY_DIR}/MeshGeoToolsLib/PrismBHE_elev.vtu -g testpoints.gml --min-id 4 --max-id 8 --min-elevation 4.5 --max-elevation 10
    TESTER diff
    DIFF_DATA
    PrismBHE_elev.vtu
)

MeshTest(
    NAME ReviseMesh_Test
    PATH MeshLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
    EXECUTABLE reviseMesh
    EXECUTABLE_ARGS -i basin_mesh.vtu -o ${Data_BINARY_DIR}/MeshLib/basin_mesh_fixed.vtu
    DIFF_DATA basin_mesh_fixed.vtu basin_mesh_fixed.vtu 1e-16
)

AddTest(
    NAME ReviseMesh_Test_Arrays
    PATH MeshLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
    EXECUTABLE reviseMesh
    EXECUTABLE_ARGS -i basin_mesh.vtu -o ${Data_BINARY_DIR}/MeshLib/basin_mesh_fixed.vtu
    TESTER vtkdiff
    DIFF_DATA
    basin_mesh_fixed.vtu basin_mesh_fixed.vtu head head 0 0
    basin_mesh_fixed.vtu basin_mesh_fixed.vtu MaterialIDs MaterialIDs 0 0
)
# Execute tests in order to prevent race condition
if(TEST reviseMesh-ReviseMesh_Test_Arrays-vtkdiff)
    set_tests_properties(reviseMesh-ReviseMesh_Test_Arrays
        PROPERTIES DEPENDS reviseMesh-ReviseMesh_Test-vtkdiff)
endif()

AddTest(
    NAME BinaryToPVTU
    PATH MeshLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/EllipticPETSc
    EXECUTABLE binaryToPVTU
    EXECUTABLE_ARGS -i cube_1x1x1_hex_1e3 -o ${Data_BINARY_DIR}/EllipticPETSc/cube_1x1x1_hex_1e3
    WRAPPER mpirun
    WRAPPER_ARGS -np 3
    REQUIREMENTS OGS_USE_MPI
    DIFF_DATA
    cube_1x1x1_hex_1e3_0 cube_1x1x1_hex_1e3_0.vtu 1e-16
    cube_1x1x1_hex_1e3_1.vtu cube_1x1x1_hex_1e3_1.vtu 1e-16
    cube_1x1x1_hex_1e3_2.vtu cube_1x1x1_hex_1e3_2.vtu 1e-16
)

AddTest(
    NAME geometryToGmshAdaptiveGeo
    PATH MeshGeoToolsLib/geometryToGmshGeo/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/geometryToGmshGeo
    EXECUTABLE geometryToGmshGeo
    EXECUTABLE_ARGS -i square_1x1.gml -o ${Data_BINARY_DIR}/MeshGeoToolsLib/geometryToGmshGeo/square_1x1_adaptive.geo
    TESTER diff
    TESTER_ARGS --ignore-matching-lines=OpenGeoSys
    DIFF_DATA
    square_1x1_adaptive.geo
)

AddTest(
    NAME geometryToGmshHomogeneousGeo
    PATH MeshGeoToolsLib/geometryToGmshGeo/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/geometryToGmshGeo
    EXECUTABLE geometryToGmshGeo
    EXECUTABLE_ARGS -i square_1x1.gml -o ${Data_BINARY_DIR}/MeshGeoToolsLib/geometryToGmshGeo/square_1x1_homogeneous.geo --homogeneous -a 0.01
    TESTER diff
    TESTER_ARGS --ignore-matching-lines=OpenGeoSys
    DIFF_DATA
    square_1x1_homogeneous.geo
)

AddTest(
    NAME LineIntersectingDomainBoundary
    PATH MeshGeoToolsLib/geometryToGmshGeo/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/geometryToGmshGeo
    EXECUTABLE geometryToGmshGeo
    EXECUTABLE_ARGS -i square_1x1.gml -i line_intersecting_square.gml -o ${Data_BINARY_DIR}/MeshGeoToolsLib/geometryToGmshGeo/square_1x1_with_intersecting_line.geo
)
set_tests_properties(
    geometryToGmshGeo-LineIntersectingDomainBoundary
    PROPERTIES
        PASS_REGULAR_EXPRESSION
        "ogs.*;ogs.*error.*\n\tpoint with id 5 and coordinates (1.001000000001, 0.6, 0) is outside of the polygon."
)

AddTest(
    NAME ResetPropertiesInPolygonalRegion_AllElementNodesInPolygon
    PATH MeshGeoToolsLib/ResetPropertiesInPolygonalRegion/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/ResetPropertiesInPolygonalRegion
    EXECUTABLE ResetPropertiesInPolygonalRegion
    EXECUTABLE_ARGS -m Cube.vtu -n ValidCells -i 1 -g Polylines.gml -p Back -o ${Data_BINARY_DIR}/MeshGeoToolsLib/ResetPropertiesInPolygonalRegion/Cube-BackPolylinePropertyChange_all_element_nodes_inside.vtu
    TESTER vtkdiff
    DIFF_DATA
    Cube-BackPolylinePropertyChange_all_element_nodes_inside.vtu Cube-BackPolylinePropertyChange_all_element_nodes_inside.vtu ValidCells ValidCells 0 0
)

AddTest(
    NAME ResetPropertiesInPolygonalRegion_AtLeastOneElementNodeInPolygon
    PATH MeshGeoToolsLib/ResetPropertiesInPolygonalRegion/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshGeoToolsLib/ResetPropertiesInPolygonalRegion
    EXECUTABLE ResetPropertiesInPolygonalRegion
    EXECUTABLE_ARGS -m Cube.vtu -n ValidCells -i 1 -g Polylines.gml -p Back --any_of -o ${Data_BINARY_DIR}/MeshGeoToolsLib/ResetPropertiesInPolygonalRegion/Cube-BackPolylinePropertyChange_at_least_one_element_node_inside.vtu
    TESTER vtkdiff
    DIFF_DATA
    Cube-BackPolylinePropertyChange_at_least_one_element_node_inside.vtu Cube-BackPolylinePropertyChange_at_least_one_element_node_inside.vtu ValidCells ValidCells 0 0
)

AddTest(
    NAME createRaster_10x10
    PATH GeoTools/createRaster/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/GeoTools/createRaster
    EXECUTABLE createRaster
    EXECUTABLE_ARGS -s 10 -r 10 -c 10 --ll_x 1000 --ll_y 100 -o ${Data_BINARY_DIR}/GeoTools/createRaster/10x10.asc
    TESTER diff
    DIFF_DATA
    10x10.asc 10x10.asc
)

AddTest(
    NAME addDataToRaster_10x10
    PATH GeoTools/addDataToRaster/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/GeoTools/addDataToRaster
    EXECUTABLE addDataToRaster
    EXECUTABLE_ARGS --ll_x 1000 --ll_y 100 --ur_x 1100 --ur_y 200 --function sinxsiny --scaling_value 1 --offset_value 0 -i ${Data_SOURCE_DIR}/GeoTools/createRaster/10x10.asc -o ${Data_BINARY_DIR}/GeoTools/addDataToRaster/10x10_sinxsiny.asc
    TESTER diff
    DIFF_DATA
    10x10_sinxsiny.asc 10x10_sinxsiny.asc
)

MeshTest(
    NAME GMSH2OGS_linearElements
    PATH Utils/GMSH2OGS
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/Utils/GMSH2OGS
    EXECUTABLE GMSH2OGS
    EXECUTABLE_ARGS -i linear_mesh.msh
                    -o ${Data_BINARY_DIR}/Utils/GMSH2OGS/linear_mesh.vtu
    DIFF_DATA linear_mesh.vtu linear_mesh.vtu 1.e-16
)

MeshTest(
    NAME GMSH2OGS_quadratic_quadrilateral
    PATH Utils/GMSH2OGS
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/Utils/GMSH2OGS
    EXECUTABLE GMSH2OGS
    EXECUTABLE_ARGS -i quadratic_quadrilateral.msh
                    -o ${Data_BINARY_DIR}/Utils/GMSH2OGS/quadratic_quadrilateral.vtu
    DIFF_DATA quadratic_quadrilateral.vtu quadratic_quadrilateral.vtu 1.e-16
)

MeshTest(
    NAME GMSH2OGS_quadratic_elements
    PATH Utils/GMSH2OGS
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/Utils/GMSH2OGS
    EXECUTABLE GMSH2OGS
    EXECUTABLE_ARGS -i quadratic_mesh.msh
                    -o ${Data_BINARY_DIR}/Utils/GMSH2OGS/quadratic_mesh.vtu
    REQUIREMENTS NOT (OGS_USE_MPI)
    DIFF_DATA quadratic_mesh.vtu quadratic_mesh.vtu 1.e-16
)

AddTest(
    NAME generateGeometry_10x10_quad
    PATH GeoTools/generateGeometry/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/GeoTools/generateGeometry
    EXECUTABLE generateGeometry
    EXECUTABLE_ARGS --x0 0 --y0 0 --z0 0 --x1 10 --y1 10 --z1 0 --nx 1 --ny 1 --geometry_name TestGeometry --polyline_name TestQuad -o ${Data_BINARY_DIR}/GeoTools/generateGeometry/TestGeometry_10x10_quad.gml
    TESTER diff
    DIFF_DATA
    TestGeometry_10x10_quad.gml TestGeometry_10x10_quad.gml
)

AddTest(
    NAME generateGeometry_10_line_nx9
    PATH GeoTools/generateGeometry/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/GeoTools/generateGeometry
    EXECUTABLE generateGeometry
    EXECUTABLE_ARGS --x0 0 --y0 0 --z0 0 --x1 10 --y1 0 --z1 0 --nx 9 --geometry_name TestGeometry --polyline_name TestLine -o ${Data_BINARY_DIR}/GeoTools/generateGeometry/TestGeometry_10_line_nx9.gml
    TESTER diff
    DIFF_DATA
    TestGeometry_10_line_nx9.gml TestGeometry_10_line_nx9.gml
)

AddTest(
    NAME generateGeometry_point
    PATH GeoTools/generateGeometry/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/GeoTools/generateGeometry
    EXECUTABLE generateGeometry
    EXECUTABLE_ARGS --x0 1 --y0 1 --z0 0 --x1 1 --y1 1 --z1 0 --geometry_name TestGeometry --polyline_name TestPoint  -o ${Data_BINARY_DIR}/GeoTools/generateGeometry/TestGeometry_point.gml
    TESTER diff
    DIFF_DATA
    TestGeometry_point.gml TestGeometry_point.gml
)

MeshTest(
    NAME NodeOrdering_M0
    PATH MeshLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
    EXECUTABLE NodeReordering
    EXECUTABLE_ARGS -i ReorderTestMesh.vtu -o ${Data_BINARY_DIR}/MeshLib/ReorderTestMeshM0.vtu -m 0
    REQUIREMENTS NOT (OGS_USE_MPI)
    DIFF_DATA ReorderTestMeshM0.vtu ReorderTestMeshM0.vtu 1.e-16
)

MeshTest(
    NAME NodeOrdering_M1
    PATH MeshLib/
    WORKING_DIRECTORY ${Data_SOURCE_DIR}/MeshLib
    EXECUTABLE NodeReordering
    EXECUTABLE_ARGS -i ReorderTestMesh.vtu -o ${Data_BINARY_DIR}/MeshLib/ReorderTestMeshM1.vtu -m 1
    REQUIREMENTS NOT (OGS_USE_MPI)
    DIFF_DATA ReorderTestMeshM1.vtu ReorderTestMeshM1.vtu 1.e-16
)
