Shader "Water/Gerstner"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0, 1)) = 0.5
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Metallic ("Metallic", Range(0, 1)) = 0
        
        _Amplitude ("Amplitude", Float) = 1
        _Wavelength ("Wavelength", Float) = 10
        _Speed ("Speed", Float) = 1
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows vertex:vert
        #pragma target 3.0

        #define TAU 6.28318530718
        #define HALF_TAU TAU / 2
        
        sampler2D _MainTex;
        // float4 _MainTex_ST;

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        float _Amplitude, _Wavelength, _Speed;

        struct Input
        {
            float2 uv_MainTex;
        };

        void vert(inout appdata_full vertexData)
        {
            float3 vert = vertexData.vertex.xyz;
            
            float wave = TAU / _Wavelength;
            vert.y = sin((vert.x - _Speed * _Time.y) * wave) * _Amplitude;
            vertexData.vertex.xyz = vert;
        }
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }

    FallBack "Diffuse"
}