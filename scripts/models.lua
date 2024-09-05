local models = {}

models.msg_update_constant = hash('update_constant')
models.msg_update_dafault_values = hash('update_dafault_values')

models.is_updating = false

local model_settings = {

	['/cone#model'] = {
		toon_color = vmath.vector4(0.9433962, 0.67362875, 0.4494482, 1.0),
		toon_ambient_color = vmath.vector4(0.8, 0.8, 0.8, 1.0),
		toon_specular_color = vmath.vector4(0.2264151, 0.2264151, 0.2264151, 1.0),
		toon_glossiness = vmath.vector4(14),
		toon_rim_color = vmath.vector4(0.8027793, 0.8027793, 0.8027793, 1.0),
		toon_rim_amount = vmath.vector4(0.714)

	},
	['/cylinder#model'] = {
		toon_color = vmath.vector4(0.259167, 0.6037736, 0.4052985, 1.0),
		toon_ambient_color = vmath.vector4(0.8, 0.8, 0.8, 1.0),
		toon_specular_color = vmath.vector4(0.8027793, 0.8027793, 0.8027793, 1.0),
		toon_glossiness = vmath.vector4(8),
		toon_rim_color = vmath.vector4(1.216786, 1.216786, 1.216786, 1.0),
		toon_rim_amount = vmath.vector4(0.753)

	},
	['/sphere#model'] = {
		toon_color = vmath.vector4(0.5, 0.5, 0.75, 1.0),
		toon_ambient_color = vmath.vector4(0.5, 0.5, 0.75, 1.0),
		toon_specular_color = vmath.vector4(0.5, 0.5, 0.8, 1.0),
		toon_glossiness = vmath.vector4(32),
		toon_rim_color = vmath.vector4(0.2, 0.2, 0.2, 1.0),
		toon_rim_amount = vmath.vector4(0.7),
		toon_rim_threshold = vmath.vector4(0.01),
		toon_light_smooth_interpolation = vmath.vector4(0.01),
		toon_rim_smooth = vmath.vector4(0.01),
		toon_specular_smooth = vmath.vector4(0.01)
	},
	['/torus#model'] = {
		toon_color = vmath.vector4(0.764151, 0.48840743, 0.378471, 1.0),
		toon_ambient_color = vmath.vector4(0.8, 0.8, 0.8, 1.0),
		toon_specular_color = vmath.vector4(2.2870936, 2.2870936, 2.2870936, 1),
		toon_glossiness = vmath.vector4(20),
		toon_rim_color = vmath.vector4(2, 2, 2, 1),
		toon_rim_amount = vmath.vector4(0.7)
	},
	['/bear#model'] = {
		--	toon_color = vmath.vector4(155 / 255, 90 / 255, 69 / 255, 1.0),
		toon_ambient_color = vmath.vector4(155 / 255, 90 / 255, 69 / 255, 1.0),
		--toon_specular_color = vmath.vector4(2.2870936, 2.2870936, 2.2870936, 1),
		toon_glossiness = vmath.vector4(20),
		--	toon_rim_color = vmath.vector4(2, 2, 2, 1),
		toon_rim_amount = vmath.vector4(0.569)
	}
	,
	['/dog#model'] = {
		toon_color = vmath.vector4(0.764151, 0.48840743, 0.378471, 1.0),
		toon_ambient_color = vmath.vector4(0.8, 0.8, 0.8, 1.0),
		toon_specular_color = vmath.vector4(2.2870936, 2.2870936, 2.2870936, 1),
		toon_glossiness = vmath.vector4(10),
		toon_rim_color = vmath.vector4(2, 2, 2, 1),
		toon_rim_amount = vmath.vector4(0.7)
	}
	,
	['/duck#model'] = {
		--	toon_color = vmath.vector4(218 / 255, 174 / 255, 126 / 255, 1.0),
		toon_ambient_color = vmath.vector4(218 / 255, 174 / 255, 126 / 255, 1.0),

		toon_glossiness = vmath.vector4(60),
		--	toon_rim_color = vmath.vector4(2, 2, 2, 1),
		toon_rim_amount = vmath.vector4(0.7)
	},
	['/ball#model'] = {
		--	toon_color = vmath.vector4(218 / 255, 174 / 255, 126 / 255, 1.0),
		--	toon_ambient_color = vmath.vector4(218 / 255, 174 / 255, 126 / 255, 1.0),
		--	toon_specular_color = vmath.vector4(2.2870936, 2.2870936, 2.2870936, 1),
		--	toon_glossiness = vmath.vector4(20),
		--	toon_rim_color = vmath.vector4(1, 1, 1, 1),
		--	toon_rim_amount = vmath.vector4(0.7),

	},
}


models.list = {}

function models.set_light_position(model_id, light_position)
	go.set(model_id, "light", vmath.vector4(light_position.x, light_position.y, light_position.z, 0))
end

local function update_models(light_position)
	for model_id, material_constants in pairs(models.list) do
		models.set_light_position(model_id, light_position)
		for constant, constant_value in pairs(material_constants) do
			go.set(model_id, constant, constant_value)
		end
	end
end
function models.init(light_position)
	models.list = model_settings
	update_models(light_position)
	models.set_camera_position(go.get_position('/camera'))
end

function models.init_model(model_id, light_position)
	models.list[model_id] = model_settings[model_id]
	update_models(light_position)
end

function models.get_models()
	return models.list
end

function models.get_model(id)
	return models.list[id]
end

function models.update_constant(constant, constant_value)
	for model_id, material_constants in pairs(models.list) do
		for _, _ in pairs(material_constants) do
			go.set(model_id, constant, constant_value)
		end
	end
end

function models.set_constant(constant, constant_value)
	for model_id, material_constants in pairs(models.list) do
		for _, _ in pairs(material_constants) do
			local value = vmath.vector4(constant_value)
			go.set(model_id, constant, value)
		end
	end
end

function models.set_camera_position(camera_position)
	for model_id, _ in pairs(models.list) do
		go.set(model_id, "camera_position", vmath.vector4(camera_position.x, camera_position.y, camera_position.z, 0))
	end
end

return models
