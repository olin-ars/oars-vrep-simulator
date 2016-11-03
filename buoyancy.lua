--module("buoyancy")
local buoyancy = {}

function buoyancy.init(voxel_size)
   submerged_volume = simCreateOctree(voxel_size,0,1)
   water_level = 0
   graph_handle = simGetObjectHandle("Graph")
end

function buoyancy.do_buoyancy(boat)
   p=simGetObjectPosition(boat,-1)
   linVel, angVel = simGetObjectVelocity(boat)
   simRemoveVoxelsFromOctree(submerged_volume,0,nil)
   simInsertObjectIntoOctree(submerged_volume,boat,0)
   local voxels = simGetOctreeVoxels(submerged_volume)
   local to_remove = {}
   local dz = simGetSimulationTimeStep()/2*linVel[3]
   for i = 3,table.getn(voxels),3 do
      if voxels[i]+water_level> 0 then
	 to_remove[#to_remove+1] = voxels[i-2]
	 to_remove[#to_remove+1] = voxels[i-1]
	 to_remove[#to_remove+1] = voxels[i]
      end
   end
   if table.getn(to_remove) > 1 then
      simRemoveVoxelsFromOctree(submerged_volume,1,to_remove)
   end
   voxels = simGetOctreeVoxels(submerged_volume)
   local verts, indeces
   if table.getn(voxels) > 9 then
      verts,indeces = simGetQHull(voxels)
   end
   if shape ~= nil then
      simRemoveObject(shape)
      shape = nil
   end
   if verts ~= nil then
      shape = simCreateMeshShape(1,20,verts,indeces)
      local code = simComputeMassAndInertia(shape,1000)
      if code == 1 then
	 
	 local om = simGetObjectMatrix(boat,-1)
	 local mass, inertia, cm = simGetShapeMassAndInertia(shape,om)
	 local im = simInvertMatrix(om)
	 local force = {0,0,mass*9.81};
	 local appliedForce = simMultiplyVector(om,force)
	 simHandleGraph(graph_handle,simGetSimulationTime()+simGetSimulationTimeStep())
	 --simResetGraph(graph_handle)
	 simSetGraphUserData(graph_handle,"cm_x",cm[1])
	 simSetGraphUserData(graph_handle,"cm_y",cm[2])
	 simSetGraphUserData(graph_handle,"cm_z",cm[3])
	 simSetGraphUserData(graph_handle,"f_x",appliedForce[1]/9.81/mass)
	 simSetGraphUserData(graph_handle,"f_y",appliedForce[2]/9.81/mass)
	 simSetGraphUserData(graph_handle,"f_z",appliedForce[3]/9.81/mass)
	 simAddForce(boat,cm,appliedForce)
      end
   end
end
   
return buoyancy
