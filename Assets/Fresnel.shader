Shader "Unlit/Fresnel"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Colour", color) = (1,1,1,1)
        _Strength("Strength", range(0,10)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"  "Queue" = "Transparent"}
        Pass
        {
           // ZTest //Less Equal // LEqual // Greater // NotEqual // GEqual
            //Cull Back // Front // Off
            
            Zwrite Off
            
            //BlendOp RevSub // DST - SRC 
            //BlendOp Sub    // SRC - DST
            //BlendOp ADD    // SRC + DST
            
            //Blend One One // Additive
            Blend SrcAlpha OneMinusSrcAlpha // Traditional transparency
            //Blend One OneMinusSrcAlpha // Premultipled transparency
            //Blend DstColor Zero // Multiplicative
            //Blend DstColor SrcColor // 2x Multiplicative
            //Blend OneMinusDstColor One // Soft Additive
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD1;
                float3 worldPosition : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;
            float _Strength;
            

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPosition = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float3 N = normalize(i.normal);
                float3 V = normalize(_WorldSpaceCameraPos - i.worldPosition);
                float fresnel = 1 - dot(V,N);
                fresnel *= (cos(_Time.y * 4 ) * 0.4 + 0.6);
                fresnel = pow(saturate(fresnel), _Strength);
                return float4(fresnel.xxx * _Color, fresnel.x);
            }
            ENDCG
        }
    }
}
