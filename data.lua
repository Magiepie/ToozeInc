semitrailer = {
				tanker = {
					[1] = {model = 'tanker'}, 
					[2] = {model = 'tanker2'},
					[3] = {model = 'armytanker'}
				},
				boxtrailer = {
					[1] = {model = 'trailers'},
					[2] = {model = 'trailers2'},
					[3] = {model = 'trailers3'},
					[4] = {model = 'trailers4'},
					[5] = {model = 'tvtrailer'}
				},
				flatbed = {
					[1] = {model = 'trflat'}, 
					[2] = {model = 'trailerlogs'},
					
					[3] = {model = 'armytrailer'},
					[4] = {model = 'armytrailer2'},
					[5] = {model = 'freighttrailer'}
				} --semitrailer.tanker[N].model
				
}

semitruck = {
	
}

trailerpickup ={
	[0] = { x = -380.93814086914, y = -2765.6560058594,z = 6.2215805053711 },
	[0] = { x = -380.93814086914, y = -2765.6560058594,z = 6.2215805053711 }
}

semipickup = { -- old
	
	[1] = { locationName = 'Clucking Bell Farms',  x = 75.21, y = 6349.967, z = 31.6 , h = 30 },	
	[2] = { locationName = 'Test Blip'			,  x = 75.21, y = 6449.967, z = 31.6,  h = 30 },
	[3]= { locationName = 'Test Blip',            x = 78.008171081543, y = 6339.7236328125, z = 33.162822723389, heading = 78.049476623535}
}


semidropoff = {
				boxtrailer  = {
					[1] = { pay = 123, location = 'Paleto Bay Markets',							
							front = { x = -361.83807373047, y = 6074.9702148438, z = 33.490642547607, heading = 44.537750244141},
							back  = { x = -354.82592773438, y = 6067.8422851563, z = 33.337810516357} 
						  },
					[2] = { pay	  = 123, location = 'Paleto Bay Liqour',
							front = { x = -399.94418334961, y = 6085.9165039063, z = 33.492824554443, heading = 44.814521789551},
							back  = { x = -392.89755249023, y = 6078.8227539063, z = 33.345264434814}					 
						  },
					[3] = { pay = 123, location = 'Wilsons Hatchery',
						   front = { x = -22.245634078979, y = 6433.517578125, z = 33.433769226074, heading = 319.42529296875},
						   back  = { x = -28.748331069946, y = 6425.9228515625, z = 33.265518188477}
						},
					[4] = { pay = 123, location = 'MOJITO INN',
					    	front = { x = -97.429237365723, y = 6388.4916992188, z = 33.478744506836, heading = 44.836860656738},
							back  = { x = -90.379219055176, y = 6381.4008789063, z = 33.333793640137}					
						},
					[5] = { pay = 123, location = 'Dinner @postal:1000',--dinner ,postal 1000, AOP Blaine County							
							front = { x = 1594.5440673828, y = 6446.7602539063, z = 27.311363220215, heading = 155.31838989258},
							back  = { x = 1598.7200927734, y = 6455.8452148438, z = 27.163215637207}
						},
					[6] = { pay = 123, location = 'Cuseys Dinner @postal:8188',							
							front = { x = 815.25250244141, y = -748.1357421875, z = 28.41423034668, heading = 2.7927329540253},
							back  = { x = 815.73699951172, y = -758.12280273438, z = 28.568870544434}
						},
					[7] = { pay = 123, location = 'maibatsu motors INC',				
							front = { x = 883.27532958984, y = -886.72509765625, z = 26.42068862915, heading = 87.68505859375},
							back  = { x = 893.23077392578, y = -887.12902832031, z = 27.273097991943}
						},
					[8] = { pay = 123, location = 'maibatsu motors INC2',				
							front = { x = 883.16271972656, y = -922.75128173828, z = 26.411592483521, heading = 89.083374023438},
							back  = { x = 893.16088867188, y = -922.91131591797, z = 26.521734237671}
						},
					[9] = { pay = 123, location = 'Darnell Bros postal @postal:8182',						
							front = { x = 751.1005859375, y = -966.45037841797, z = 26.354417800903, heading = 270.40725708008},
							back  = { x = 741.10278320313, y = -966.52142333984, z = 26.157121658325}
						},
					[10] = { pay = 123, location = 'The secure unit 24hr acess 2377',							
						   	 front = { x = 936.08001708984, y = -1241.3477783203, z = 27.119274139404, heading = 34.517513275146},
							 back  = { x = 941.74346923828, y = -1249.5867919922, z = 27.327117919922}
						},
					[11] = { pay = 123, location = 'Zalinsky Supply & mfr corp @postal:8195',
							 front = { x = 841.36608886719, y = -1156.4105224609, z = 26.791816711426, heading = 272.7861328125},
							 back  = { x = 831.37902832031, y = -1156.8966064453, z = 26.940723419189}
						},
					[12] = { pay = 123, location = 'Big Warehouse  @postal:9289',						
						front = { x = 847.56195068359, y = -2495.6572265625, z = 30.12477684021, heading = 79.307273864746},
						back  = { x = 857.38812255859, y = -2497.5126953125, z = 30.185022354126}
						}						
					
						 
				},
				tanker = { -- old
					[1] = {pay = 123, location = 'Beef Warehouse', --
						['truck'] = {['x'] = -26.05, ['y'] = 6414.8, ['z'] = 31.75},},  
						['trailer'] = {['x'] = -33.84, ['y'] = 6422.95, ['z'] = 35.78},
				},
				hard   = { -- back in to small places, truck size matters take in to account
					[1] = { pay = 123, location = 'Wilson Hatcheries',
						['truck'] = {['x'] = -22.65, ['y'] = 6433.41, ['z'] = 31.7},},  
						['trailer'] = {['x'] = -28.28, ['y'] = 6427.76, ['z'] = 35.8}
				}
}

worktruck = {-- regular trucks

} 
worktrailer = {

}