Shader "Unlit/FirstTransparant"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"
                "Queue"="Transparent" }

        Pass
        {
            // Src value(Source) 
                // Frag Shader
            // Dst value(Destination)
                // Render Target

            // (Src * A)    +/-    (Dst * B)

            
            
            // (Src *1) + (Dst * 1) // Blend One One / Additive
            
            // Blend DstColor Zero // Multiplicitive
            // (Src * DstColor) + (Dst * 0)
            
            // Blend DstColor SrcColor
            // (Src * DstColor) + (Dst * SrcColor)

            // Blend OneMinusDstColor One // Soft Additive
            // (Src * 1-Dst) + (Dst * 1)
            
            // Blend SrcAlpha OneMinusSrcAlpha // Traditional
            // (Src * SrcAlpha) + (Dst * OneMinusSrcAlpha)
            
            ZWrite Off
            //BlendOp RevSub // Dst - Src
            //BlendOp Sub // Src - Dst
            //Blend One One
            //Blend DstColor SrcColor
            //Blend DstColor Zero
            Blend SrcAlpha OneMinusSrcAlpha // Traditonal Transparancy
            //Blend One One // Additive
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = float4(1, 0, 0, 0.5);
                return col;
            }
            ENDCG
        }
    }
}
