Shader "Unlit/MultiLight"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Gloss ("Gloss", float) = 1
        _Colour("Colour", color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        
        // Base Pass
        Pass
        {
            Tags { "LightMode" = "ForwardBase" }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "IncLighting.cginc"
            ENDCG
        }
        
        // Additional Pass
        Pass
        {
            Blend One One
            
            Tags { "LightMode" = "ForwardAdd" }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd //fwdadd // ForwardAdd
            #include "IncLighting.cginc"
            ENDCG
        }
    }
}
