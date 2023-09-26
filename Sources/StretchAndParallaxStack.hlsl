struct Functions{

	float Map(float X, float InMin, float InMax, float OutMin, float OutMax){
		return (X - InMin) * (OutMax - OutMin) / (InMax - InMin) + OutMin;
	}
	
	float2 BorderStretch(float2 InUV, float2 Scale, float Cutoff){
		float2 Out = {0.0, 0.0};

		if(InUV.x <= Cutoff / Scale.x){
			Out.x = Map(InUV.x, 0.0, Cutoff / Scale.x, 0.0, Cutoff);
		}else if(InUV.x >= 1.0 - (Cutoff / Scale.x)){
			Out.x = Map(InUV.x, 1.0 - (Cutoff / Scale.x), 1.0, 1.0 - Cutoff, 1.0);
		}else{
			Out.x = Map(InUV.x, Cutoff / Scale.x, 1.0 - (Cutoff / Scale.x), Cutoff, 1.0 - Cutoff);
		}

		if(InUV.y <= Cutoff / Scale.y){
			Out.y = Map(InUV.y, 0.0, Cutoff / Scale.y, 0.0, Cutoff);
		}else if(InUV.y >= 1.0 - (Cutoff / Scale.y)){
			Out.y = Map(InUV.y, 1.0 - (Cutoff / Scale.y), 1.0, 1.0 - Cutoff, 1.0);
		}else{
			Out.y = Map(InUV.y, Cutoff / Scale.y, 1.0 - (Cutoff / Scale.y), Cutoff, 1.0 - Cutoff);
		}
		
		return Out;
	}
	
};

Functions F;

float4 Out = float4(0.0, 0.0, 0.0, 0.0);

for(int i = 0; i < MultiCount; i++){
	float Alpha = pow(1.0 - (i / MultiCount), MultiAlphaExponent);
	float2 SampleUV = UV + MultiOffset * i;
	if (SampleUV.x >= 0.0 && SampleUV.x <= 1.0 && SampleUV.y >= 0.0 && SampleUV.y <= 1.0) {
		Out = max(Out, Alpha * Tex.Sample(TexSampler, F.BorderStretch(SampleUV, FaceScale, BorderCutoff)));
	}
}

return Out;