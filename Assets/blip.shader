Shader "Unlit/blip"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Gloss("Gloss", range(0,1)) = 1
        _Color("Colour", color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue" = "Geometry"}
        LOD 100

        //Base pass
        Pass
        {
            Tags { "LightMode" = "ForwardBase" }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "blip.cginc"
            ENDCG
        }
        
        //Additional pass
        Pass
        {
            Blend One One
            
            Tags { "LightMode" = "ForwardAdd" }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd
            
            #include "blip.cginc"
            ENDCG
        }
    }
}
