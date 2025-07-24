Shader "MyShaders/FirstShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float3 normal : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex + v.normal * 0.2);
                o.normal = mul(unity_ObjectToWorld,v.normal);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = fixed4(i.normal ,1);
                return col;
            }
            ENDCG
        }
    }
}

// fixed 11bits, -2.0 to 2.0 used mostly between 0 and 1 (has precision of 1/256)
// fixed2, fixed3, fixed4

// half 16 bits
// half2, half3, half4

// Float 32 bits
// float 4.5
// float2 4.5, 6.8
// float3 4.5, 6.8, 4.0
// float4 4.5, 6.8, 4.0, 0.01

// int
// int1, int2, int3

//bool, 0 or 1

// sampler2d 2D texture
// samplerCUBE 3D texture

// fixed4(i.uv,0,1); - RedGreen,Blue0,Alpha
// fixed4(i.uv.x,0,i.uv.y,1); - REDx_, 0 green, BLUEy |
// fixed4(red, green, blue, alpha)