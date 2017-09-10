// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "YZL/S2" {
	Properties {
		_Diffuse("Diffuse Color",Color) = (1,1,1,1)
	}
	SubShader {
		Pass{
			Tags{ "LightMode" = "ForwardBase" }

			CGPROGRAM
			#include "Lighting.cginc"
			#pragma vertex vert
			#pragma fragment frag
			fixed4 _Diffuse;

			struct a2v{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
			};

			struct v2f {
				float4 position:SV_POSITION;
				fixed3 normalDir:COLOR;
			};
			v2f vert(a2v v){
				v2f f;
				f.position = mul(UNITY_MATRIX_MVP, v.vertex);
				f.normalDir = normalize( (float3)mul(fixed4(v.normal,0),  unity_WorldToObject));
				return f;
			}

			fixed4 frag(v2f f): SV_Target{
				fixed3 lightDir = normalize( _WorldSpaceLightPos0.xyz);
				fixed3 diffuse = _LightColor0.rgb * max(dot(f.normalDir, lightDir), 0) * _Diffuse.rgb;
				return fixed4(diffuse, 1);
			}
		
			ENDCG
		}

	}
	FallBack "Diffuse"
}
