# September 28 2020 
# Benjamin G. Janesko
# This .tcl script generates a 36-frame animation of a molecule's 
# computed electrostatic potential. 

# The three files below give the density and ESP inputs and the location 
# of the bmp output. Users should modify these as needed 
set densitycubefile M:/projects/Pi-semilocal/AChemistsEye/rhodanine-rho.cube
set espcubefile M:/projects/Pi-semilocal/AChemistsEye/rhodanine-V.cube
set bmplocation M:/projects/Pi-semilocal/AChemistsEye/temp/

# The three values below give the density isosurface cutoff and the 
# ESP max and min values 
set densityisosurface 0.001 
set espmax 0.07
set espmin -0.05


axes location off
color Display {Background} white
display projection orthographic 
mol delete all
mol new $densitycubefile type cube first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
mol addfile $espcubefile type cube first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
mol delrep 0 top
mol representation CPK 1.000000 0.300000 12.000000 12.000000
mol color Name
mol selection {all}
mol material Opaque
mol addrep top
mol representation Isosurface $densityisosurface 0 0 0 1 1 
mol material Edgy    
mol color Volume 1
mol addrep top
mol selupdate 1 top 0
mol colupdate 1 top 0

# red-white-blue color scale 
color scale method RWB
mol scaleminmax top 1 $espmin $espmax 
mol smoothrep top 1 0
scale by 1.2
mol drawframes top 1 {now}
for {set out 1} {$out <37} {incr out} {
rotate x by 10   
render TachyonInternal  $bmplocation/$out.bmp
#}
