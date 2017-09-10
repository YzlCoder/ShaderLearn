// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "YZL/S7" {
	Properties {
		_Color("Diffuse Color",Color) = (1,1,1,1)
		_MainTex("MainTexture", 2D) = "White"{}
		_Gloss("Gloss",Range(1,20)) = 10
	}
	SubShader {
		Pass{
			Tags{ "LightMode" = "ForwardBase" }

			CGPROGRAM
			#include "Lighting.cginc"
			#pragma vertex vert
			#pragma fragment frag
			fixed4 _Color;
			sampler2D _MainTex;
			half _Gloss;
			struct a2v{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
				float4 texcoord:TEXCOORD0;
			};

			struct v2f {
				float4 position:SV_POSITION;
				fixed3 normalDir:DIR1;
				fixed3 viewDir:DIR2;
				float4 uv:TEXCOORD0;
			};
			v2f vert(a2v v){
				v2f f;
				f.position = mul(UNITY_MATRIX_MVP, v.vertex);
				f.normalDir = normalize(UnityObjectToWorldNormal(v.normal));
				f.viewDir = normalize(WorldSpaceViewDir(v.vertex));
				f.uv = v.texcoord;
				return f;
			}

			fixed4 frag(v2f f): SV_Target{

				fixed3 lightDir = normalize( _WorldSpaceLightPos0.xyz);
				fixed3 diffuse = _Color.rgb * tex2D(_MainTex, f.uv.xy) * max(dot(f.normalDir, lightDir) * 0.5 + 0.5, 0);

				fixed3 reflectDir = normalize(reflect(-lightDir,f.normalDir));

				fixed3 specula =  _LightColor0.rgb * pow(max(dot(f.viewDir,reflectDir),0), _Gloss);
				
				return fixed4(diffuse + specula, 1);
			}
		
			ENDCG
		}

	}
	FallBack "Diffuse"
}
