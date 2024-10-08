![Toon](/.github/defold-toons.png?raw=true)

![Toon](/.github/defold-toons-smooth.png?raw=true)

# Defold Toon Shader

Use `toon_local_legacy.material` or `toon_world_legacy.material` for [legacy pipeline](https://defold.com/manuals/shader/#writing-modern-glsl-shaders).  

Use `toon_world.material` or `toon_local.material` for new pipeline Defold >= 1.9.2 

### Shader Constants

All constants must be `vmath.vector4()` but only some components are used:  


`light`(x, y, z) -  Light position  
`camera_position`(x, y, z) -  Camera position  
`toon_color`(x, y, z)  -  Diffuse color  
`toon_ambient_color`(x, y, z)  -  Shadow color   
`toon_specular_color`(x, y, z) -   Specular_color   
`toon_glossiness`(x)  - Glossiness amount    
`toon_rim_color`(x, y, z)  -  Light rim color   
`toon_rim_amount`(x)  -  Light rim amount   
`toon_rim_threshold`(x)  -  Light rim threshold  
`toon_light_smooth_interpolation`(x)  -  Light shadow  smooth  
`toon_rim_smooth`(x) -  Light rim smooth   
`toon_specular_smooth`(x) -  Specular smooth   

---

### Credits
Roystan: https://roystan.net/articles/toon-shader/  