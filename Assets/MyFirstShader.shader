Shader "Unlit/MyFirstShader"
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
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION; //object space
                float4 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION; //clip space /cameras space
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                v.vertex.xyz += v.normal.xyz * -1;
                o.vertex = UnityObjectToClipPos(v.vertex );
                //o.vertex = mul(unity_ObjectToWorld, v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = float4( i.uv.xyxx);// tex2D(_MainTex, i.uv);

                //UV X Y
                //OUTPUT   X X X

                // X Y Z W
                // R G B A
                // 0 1 2 3
                // U V (but you cant do uv
                
                return col;
            }
            ENDHLSL
            
            //fixed 11bits -2.0 to +2.0 (only if number is between 0 to 1)  have a precision of 1/256
            
            //half 16 bits
            
            //float 32 bits 
            //float   4.5
            //float2  4.5 , 6.8
            //float3  4.5 , 6.8, 4.0
            //float4  4.5 , 6.8, 4.0, 0.1
            
            //float2x2
            //          4.5 , 6.8
            //          4.5 , 6.8
            
            //int
            //int2
            
            //bool   0 or 1
            
            //sampler2D   2D Texture
            //samplerCUBE   3D Texture
            
        }
    }
}
