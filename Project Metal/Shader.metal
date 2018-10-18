//
//  Shader.metal
//  Project Metal
//
//  Created by Sawan Kumar on 17/10/18.
//  Copyright © 2018 Genisys. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;


//MARK: Vertex function
/*
 function signture: - vertex_shader
 function return type: - vextex float4
 parameters:
    name:vertices,
    type:const device packed_float3,
    taking Array of buffer 0
 
    name:vertexId,
    type:uint,
    taking Array of vertex_id
 */
vertex float4 vertex_shader(const device packed_float3 *vertices[[buffer(0)]], uint vertexId [[vertex_id]]) {
    return float4(vertices[vertexId], 1);
}

//MARK: Fragment function
/*
 return half4 which is half of float4 and return red color you can choose whatever color you want to shade.
 */
fragment half4 fragment_shader(){
    return half4(1,0,0,1);
}
