; ModuleID = 'etabackend/cpp/PARSE_TimeTagFileHeader.cpp'
source_filename = "etabackend/cpp/PARSE_TimeTagFileHeader.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.header_info = type { i64, i64, i64, i64, i64, i64, i64 }
%struct.TgHd = type { [32 x i8], i32, i32, i64 }

@order_gurantee3 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [41 x i8] c"\0A [ERROR]\0Aerror reading header, aborted.\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"%s(%d)\00", align 1
@.str.2 = private unnamed_addr constant [27 x i8] c"TTResultFormat_TTTRRecType\00", align 1
@.str.3 = private unnamed_addr constant [20 x i8] c"MeasDesc_Resolution\00", align 1
@.str.4 = private unnamed_addr constant [26 x i8] c"MeasDesc_GlobalResolution\00", align 1
@.str.5 = private unnamed_addr constant [3 x i32] [i32 37, i32 115, i32 0], align 4
@.str.6 = private unnamed_addr constant [11 x i8] c"Header_End\00", align 1
@.str.7 = private unnamed_addr constant [45 x i8] c"\0A [ERROR]Error when reading header, aborted.\00", align 1
@.str.8 = private unnamed_addr constant [41 x i8] c"\0A [ERROR]Failed to read header, aborted.\00", align 1
@.str.9 = private unnamed_addr constant [7 x i8] c"PQTTTR\00", align 1
@.str.10 = private unnamed_addr constant [5 x i8] c"\87\B3\91\FA\00", align 1
@.str.11 = private unnamed_addr constant [93 x i8] c"\0A [ERROR]Unidentified time-tag format. Specify one the with eta.run(...format=x). Aborted. \0A\00", align 1

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i64 @_Z5breadP11header_infoPvmmPc(%struct.header_info* %0, i8* %1, i64 %2, i64 %3, i8* %4) #0 {
  %6 = alloca %struct.header_info*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i8*, align 8
  store %struct.header_info* %0, %struct.header_info** %6, align 8
  store i8* %1, i8** %7, align 8
  store i64 %2, i64* %8, align 8
  store i64 %3, i64* %9, align 8
  store i8* %4, i8** %10, align 8
  %11 = load i8*, i8** %7, align 8
  %12 = load i8*, i8** %10, align 8
  %13 = load %struct.header_info*, %struct.header_info** %6, align 8
  %14 = getelementptr inbounds %struct.header_info, %struct.header_info* %13, i32 0, i32 1
  %15 = load i64, i64* %14, align 8
  %16 = getelementptr inbounds i8, i8* %12, i64 %15
  %17 = load i64, i64* %8, align 8
  %18 = load i64, i64* %9, align 8
  %19 = mul i64 %17, %18
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %16, i64 %19, i1 false)
  %20 = load i64, i64* %8, align 8
  %21 = load i64, i64* %9, align 8
  %22 = mul i64 %20, %21
  %23 = load %struct.header_info*, %struct.header_info** %6, align 8
  %24 = getelementptr inbounds %struct.header_info, %struct.header_info* %23, i32 0, i32 1
  %25 = load i64, i64* %24, align 8
  %26 = add i64 %25, %22
  store i64 %26, i64* %24, align 8
  %27 = load i64, i64* %8, align 8
  %28 = load i64, i64* %9, align 8
  %29 = mul i64 %27, %28
  ret i64 %29
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @_Z15TDateTime_TimeTd(double %0) #2 {
  %2 = alloca double, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  store double %0, double* %2, align 8
  store i32 25569, i32* %3, align 4
  store i32 86400, i32* %4, align 4
  %6 = load double, double* %2, align 8
  %7 = fsub double %6, 2.556900e+04
  %8 = fmul double %7, 8.640000e+04
  %9 = fptosi double %8 to i64
  store i64 %9, i64* %5, align 8
  %10 = load i64, i64* %5, align 8
  ret i64 %10
}

; Function Attrs: alwaysinline uwtable
define dso_local i32 @_Z23PicoQuant_header_parserP11header_infoPc(%struct.header_info* %0, i8* %1) #3 {
  %3 = alloca %struct.header_info*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct.header_info*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i8*, align 8
  %13 = alloca %struct.header_info*, align 8
  %14 = alloca i8*, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca i8*, align 8
  %18 = alloca %struct.header_info*, align 8
  %19 = alloca i8*, align 8
  %20 = alloca i64, align 8
  %21 = alloca i64, align 8
  %22 = alloca i8*, align 8
  %23 = alloca i32, align 4
  %24 = alloca %struct.header_info*, align 8
  %25 = alloca i8*, align 8
  %26 = alloca %struct.TgHd, align 8
  %27 = alloca i32, align 4
  %28 = alloca i8*, align 8
  %29 = alloca i32*, align 8
  %30 = alloca [8 x i8], align 1
  %31 = alloca [40 x i8], align 16
  %32 = alloca double, align 8
  %33 = alloca double, align 8
  %34 = alloca i64, align 8
  %35 = alloca i8, align 1
  store %struct.header_info* %0, %struct.header_info** %24, align 8
  store i8* %1, i8** %25, align 8
  %36 = load %struct.header_info*, %struct.header_info** %24, align 8
  %37 = bitcast [8 x i8]* %30 to i8*
  %38 = load i8*, i8** %25, align 8
  store %struct.header_info* %36, %struct.header_info** %18, align 8
  store i8* %37, i8** %19, align 8
  store i64 1, i64* %20, align 8
  store i64 8, i64* %21, align 8
  store i8* %38, i8** %22, align 8
  %39 = load i8*, i8** %19, align 8
  %40 = load i8*, i8** %22, align 8
  %41 = load %struct.header_info*, %struct.header_info** %18, align 8
  %42 = getelementptr inbounds %struct.header_info, %struct.header_info* %41, i32 0, i32 1
  %43 = load i64, i64* %42, align 8
  %44 = getelementptr inbounds i8, i8* %40, i64 %43
  %45 = load i64, i64* %20, align 8
  %46 = load i64, i64* %21, align 8
  %47 = mul i64 %45, %46
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %39, i8* align 1 %44, i64 %47, i1 false) #7
  %48 = load i64, i64* %20, align 8
  %49 = load i64, i64* %21, align 8
  %50 = mul i64 %48, %49
  %51 = load %struct.header_info*, %struct.header_info** %18, align 8
  %52 = getelementptr inbounds %struct.header_info, %struct.header_info* %51, i32 0, i32 1
  %53 = load i64, i64* %52, align 8
  %54 = add i64 %53, %50
  store i64 %54, i64* %52, align 8
  %55 = load i64, i64* %20, align 8
  %56 = load i64, i64* %21, align 8
  %57 = mul i64 %55, %56
  %58 = trunc i64 %57 to i32
  store i32 %58, i32* %27, align 4
  %59 = load i32, i32* %27, align 4
  %60 = sext i32 %59 to i64
  %61 = icmp ne i64 %60, 8
  br i1 %61, label %62, label %65

62:                                               ; preds = %2
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str, i64 0, i64 0))
  %64 = sext i32 %63 to i64
  store i64 %64, i64* @order_gurantee3, align 8
  br label %289

65:                                               ; preds = %2
  br label %66

66:                                               ; preds = %254, %65
  %67 = load %struct.header_info*, %struct.header_info** %24, align 8
  %68 = bitcast %struct.TgHd* %26 to i8*
  %69 = load i8*, i8** %25, align 8
  store %struct.header_info* %67, %struct.header_info** %3, align 8
  store i8* %68, i8** %4, align 8
  store i64 1, i64* %5, align 8
  store i64 48, i64* %6, align 8
  store i8* %69, i8** %7, align 8
  %70 = load i8*, i8** %4, align 8
  %71 = load i8*, i8** %7, align 8
  %72 = load %struct.header_info*, %struct.header_info** %3, align 8
  %73 = getelementptr inbounds %struct.header_info, %struct.header_info* %72, i32 0, i32 1
  %74 = load i64, i64* %73, align 8
  %75 = getelementptr inbounds i8, i8* %71, i64 %74
  %76 = load i64, i64* %5, align 8
  %77 = load i64, i64* %6, align 8
  %78 = mul i64 %76, %77
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %70, i8* align 1 %75, i64 %78, i1 false) #7
  %79 = load i64, i64* %5, align 8
  %80 = load i64, i64* %6, align 8
  %81 = mul i64 %79, %80
  %82 = load %struct.header_info*, %struct.header_info** %3, align 8
  %83 = getelementptr inbounds %struct.header_info, %struct.header_info* %82, i32 0, i32 1
  %84 = load i64, i64* %83, align 8
  %85 = add i64 %84, %81
  store i64 %85, i64* %83, align 8
  %86 = load i64, i64* %5, align 8
  %87 = load i64, i64* %6, align 8
  %88 = mul i64 %86, %87
  %89 = trunc i64 %88 to i32
  store i32 %89, i32* %27, align 4
  %90 = load i32, i32* %27, align 4
  %91 = sext i32 %90 to i64
  %92 = icmp ne i64 %91, 48
  br i1 %92, label %93, label %94

93:                                               ; preds = %66
  br label %289

94:                                               ; preds = %66
  %95 = getelementptr inbounds [40 x i8], [40 x i8]* %31, i64 0, i64 0
  %96 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 0
  %97 = getelementptr inbounds [32 x i8], [32 x i8]* %96, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %95, i8* align 8 %97, i64 40, i1 false)
  %98 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 1
  %99 = load i32, i32* %98, align 8
  %100 = icmp sgt i32 %99, -1
  br i1 %100, label %101, label %108

101:                                              ; preds = %94
  %102 = getelementptr inbounds [40 x i8], [40 x i8]* %31, i64 0, i64 0
  %103 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 0
  %104 = getelementptr inbounds [32 x i8], [32 x i8]* %103, i64 0, i64 0
  %105 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 1
  %106 = load i32, i32* %105, align 8
  %107 = call i32 (i8*, i8*, ...) @sprintf(i8* %102, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0), i8* %104, i32 %106) #7
  br label %108

108:                                              ; preds = %101, %94
  %109 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 2
  %110 = load i32, i32* %109, align 4
  switch i32 %110, label %252 [
    i32 -65528, label %111
    i32 8, label %112
    i32 268435464, label %113
    i32 285212680, label %124
    i32 301989896, label %125
    i32 536870920, label %126
    i32 537001983, label %155
    i32 553648136, label %160
    i32 1073872895, label %165
    i32 1073938431, label %203
    i32 -1, label %247
  ]

111:                                              ; preds = %108
  br label %253

112:                                              ; preds = %108
  br label %253

113:                                              ; preds = %108
  %114 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 0
  %115 = getelementptr inbounds [32 x i8], [32 x i8]* %114, i64 0, i64 0
  %116 = call i32 @strcmp(i8* %115, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.2, i64 0, i64 0)) #8
  %117 = icmp eq i32 %116, 0
  br i1 %117, label %118, label %123

118:                                              ; preds = %113
  %119 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %120 = load i64, i64* %119, align 8
  %121 = load %struct.header_info*, %struct.header_info** %24, align 8
  %122 = getelementptr inbounds %struct.header_info, %struct.header_info* %121, i32 0, i32 6
  store i64 %120, i64* %122, align 8
  br label %123

123:                                              ; preds = %118, %113
  br label %253

124:                                              ; preds = %108
  br label %253

125:                                              ; preds = %108
  br label %253

126:                                              ; preds = %108
  %127 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 0
  %128 = getelementptr inbounds [32 x i8], [32 x i8]* %127, i64 0, i64 0
  %129 = call i32 @strcmp(i8* %128, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.3, i64 0, i64 0)) #8
  %130 = icmp eq i32 %129, 0
  br i1 %130, label %131, label %140

131:                                              ; preds = %126
  %132 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %133 = bitcast i64* %132 to double*
  %134 = load double, double* %133, align 8
  store double %134, double* %32, align 8
  %135 = load double, double* %32, align 8
  %136 = fmul double %135, 1.000000e+12
  %137 = fptosi double %136 to i64
  %138 = load %struct.header_info*, %struct.header_info** %24, align 8
  %139 = getelementptr inbounds %struct.header_info, %struct.header_info* %138, i32 0, i32 3
  store i64 %137, i64* %139, align 8
  br label %140

140:                                              ; preds = %131, %126
  %141 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 0
  %142 = getelementptr inbounds [32 x i8], [32 x i8]* %141, i64 0, i64 0
  %143 = call i32 @strcmp(i8* %142, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.4, i64 0, i64 0)) #8
  %144 = icmp eq i32 %143, 0
  br i1 %144, label %145, label %154

145:                                              ; preds = %140
  %146 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %147 = bitcast i64* %146 to double*
  %148 = load double, double* %147, align 8
  store double %148, double* %33, align 8
  %149 = load double, double* %33, align 8
  %150 = fmul double %149, 1.000000e+12
  %151 = fptosi double %150 to i64
  %152 = load %struct.header_info*, %struct.header_info** %24, align 8
  %153 = getelementptr inbounds %struct.header_info, %struct.header_info* %152, i32 0, i32 2
  store i64 %151, i64* %153, align 8
  br label %154

154:                                              ; preds = %145, %140
  br label %253

155:                                              ; preds = %108
  %156 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %157 = load i64, i64* %156, align 8
  %158 = load %struct.header_info*, %struct.header_info** %24, align 8
  %159 = getelementptr inbounds %struct.header_info, %struct.header_info* %158, i32 0, i32 1
  store i64 %157, i64* %159, align 8
  br label %253

160:                                              ; preds = %108
  %161 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %162 = bitcast i64* %161 to double*
  %163 = load double, double* %162, align 8
  %164 = call i64 @_Z15TDateTime_TimeTd(double %163)
  store i64 %164, i64* %34, align 8
  br label %253

165:                                              ; preds = %108
  %166 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %167 = load i64, i64* %166, align 8
  %168 = call noalias i8* @calloc(i64 %167, i64 1) #7
  store i8* %168, i8** %28, align 8
  %169 = load %struct.header_info*, %struct.header_info** %24, align 8
  %170 = load i8*, i8** %28, align 8
  %171 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %172 = load i64, i64* %171, align 8
  %173 = load i8*, i8** %25, align 8
  store %struct.header_info* %169, %struct.header_info** %8, align 8
  store i8* %170, i8** %9, align 8
  store i64 1, i64* %10, align 8
  store i64 %172, i64* %11, align 8
  store i8* %173, i8** %12, align 8
  %174 = load i8*, i8** %9, align 8
  %175 = load i8*, i8** %12, align 8
  %176 = load %struct.header_info*, %struct.header_info** %8, align 8
  %177 = getelementptr inbounds %struct.header_info, %struct.header_info* %176, i32 0, i32 1
  %178 = load i64, i64* %177, align 8
  %179 = getelementptr inbounds i8, i8* %175, i64 %178
  %180 = load i64, i64* %10, align 8
  %181 = load i64, i64* %11, align 8
  %182 = mul i64 %180, %181
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %174, i8* align 1 %179, i64 %182, i1 false) #7
  %183 = load i64, i64* %10, align 8
  %184 = load i64, i64* %11, align 8
  %185 = mul i64 %183, %184
  %186 = load %struct.header_info*, %struct.header_info** %8, align 8
  %187 = getelementptr inbounds %struct.header_info, %struct.header_info* %186, i32 0, i32 1
  %188 = load i64, i64* %187, align 8
  %189 = add i64 %188, %185
  store i64 %189, i64* %187, align 8
  %190 = load i64, i64* %10, align 8
  %191 = load i64, i64* %11, align 8
  %192 = mul i64 %190, %191
  %193 = trunc i64 %192 to i32
  store i32 %193, i32* %27, align 4
  %194 = load i32, i32* %27, align 4
  %195 = sext i32 %194 to i64
  %196 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %197 = load i64, i64* %196, align 8
  %198 = icmp ne i64 %195, %197
  br i1 %198, label %199, label %201

199:                                              ; preds = %165
  %200 = load i8*, i8** %28, align 8
  call void @free(i8* %200) #7
  br label %289

201:                                              ; preds = %165
  %202 = load i8*, i8** %28, align 8
  call void @free(i8* %202) #7
  br label %253

203:                                              ; preds = %108
  %204 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %205 = load i64, i64* %204, align 8
  %206 = call noalias i8* @calloc(i64 %205, i64 1) #7
  %207 = bitcast i8* %206 to i32*
  store i32* %207, i32** %29, align 8
  %208 = load %struct.header_info*, %struct.header_info** %24, align 8
  %209 = load i32*, i32** %29, align 8
  %210 = bitcast i32* %209 to i8*
  %211 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %212 = load i64, i64* %211, align 8
  %213 = load i8*, i8** %25, align 8
  store %struct.header_info* %208, %struct.header_info** %13, align 8
  store i8* %210, i8** %14, align 8
  store i64 1, i64* %15, align 8
  store i64 %212, i64* %16, align 8
  store i8* %213, i8** %17, align 8
  %214 = load i8*, i8** %14, align 8
  %215 = load i8*, i8** %17, align 8
  %216 = load %struct.header_info*, %struct.header_info** %13, align 8
  %217 = getelementptr inbounds %struct.header_info, %struct.header_info* %216, i32 0, i32 1
  %218 = load i64, i64* %217, align 8
  %219 = getelementptr inbounds i8, i8* %215, i64 %218
  %220 = load i64, i64* %15, align 8
  %221 = load i64, i64* %16, align 8
  %222 = mul i64 %220, %221
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %214, i8* align 1 %219, i64 %222, i1 false) #7
  %223 = load i64, i64* %15, align 8
  %224 = load i64, i64* %16, align 8
  %225 = mul i64 %223, %224
  %226 = load %struct.header_info*, %struct.header_info** %13, align 8
  %227 = getelementptr inbounds %struct.header_info, %struct.header_info* %226, i32 0, i32 1
  %228 = load i64, i64* %227, align 8
  %229 = add i64 %228, %225
  store i64 %229, i64* %227, align 8
  %230 = load i64, i64* %15, align 8
  %231 = load i64, i64* %16, align 8
  %232 = mul i64 %230, %231
  %233 = trunc i64 %232 to i32
  store i32 %233, i32* %27, align 4
  %234 = load i32, i32* %27, align 4
  %235 = sext i32 %234 to i64
  %236 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %237 = load i64, i64* %236, align 8
  %238 = icmp ne i64 %235, %237
  br i1 %238, label %239, label %242

239:                                              ; preds = %203
  %240 = load i32*, i32** %29, align 8
  %241 = bitcast i32* %240 to i8*
  call void @free(i8* %241) #7
  br label %289

242:                                              ; preds = %203
  %243 = load i32*, i32** %29, align 8
  %244 = call i32 (i32*, ...) @wprintf(i32* getelementptr inbounds ([3 x i32], [3 x i32]* @.str.5, i64 0, i64 0), i32* %243)
  %245 = load i32*, i32** %29, align 8
  %246 = bitcast i32* %245 to i8*
  call void @free(i8* %246) #7
  br label %253

247:                                              ; preds = %108
  %248 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 3
  %249 = load i64, i64* %248, align 8
  %250 = load %struct.header_info*, %struct.header_info** %24, align 8
  %251 = getelementptr inbounds %struct.header_info, %struct.header_info* %250, i32 0, i32 1
  store i64 %249, i64* %251, align 8
  br label %253

252:                                              ; preds = %108
  br label %289

253:                                              ; preds = %247, %242, %201, %160, %155, %154, %125, %124, %123, %112, %111
  br label %254

254:                                              ; preds = %253
  %255 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %26, i32 0, i32 0
  %256 = getelementptr inbounds [32 x i8], [32 x i8]* %255, i64 0, i64 0
  %257 = call i32 @strncmp(i8* %256, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.6, i64 0, i64 0), i64 11) #8
  %258 = icmp ne i32 %257, 0
  br i1 %258, label %66, label %259

259:                                              ; preds = %254
  %260 = load %struct.header_info*, %struct.header_info** %24, align 8
  %261 = getelementptr inbounds %struct.header_info, %struct.header_info* %260, i32 0, i32 6
  %262 = load i64, i64* %261, align 8
  switch i64 %262, label %273 [
    i64 66051, label %263
    i64 66052, label %264
    i64 16843268, label %265
    i64 66053, label %266
    i64 66054, label %267
    i64 66307, label %268
    i64 66308, label %269
    i64 16843524, label %270
    i64 66309, label %271
    i64 66310, label %272
  ]

263:                                              ; preds = %259
  store i8 1, i8* %35, align 1
  br label %274

264:                                              ; preds = %259
  store i8 1, i8* %35, align 1
  br label %274

265:                                              ; preds = %259
  store i8 1, i8* %35, align 1
  br label %274

266:                                              ; preds = %259
  store i8 1, i8* %35, align 1
  br label %274

267:                                              ; preds = %259
  store i8 1, i8* %35, align 1
  br label %274

268:                                              ; preds = %259
  store i8 0, i8* %35, align 1
  br label %274

269:                                              ; preds = %259
  store i8 0, i8* %35, align 1
  br label %274

270:                                              ; preds = %259
  store i8 0, i8* %35, align 1
  br label %274

271:                                              ; preds = %259
  store i8 0, i8* %35, align 1
  br label %274

272:                                              ; preds = %259
  store i8 0, i8* %35, align 1
  br label %274

273:                                              ; preds = %259
  br label %289

274:                                              ; preds = %272, %271, %270, %269, %268, %267, %266, %265, %264, %263
  %275 = load i8, i8* %35, align 1
  %276 = trunc i8 %275 to i1
  br i1 %276, label %277, label %280

277:                                              ; preds = %274
  %278 = load %struct.header_info*, %struct.header_info** %24, align 8
  %279 = getelementptr inbounds %struct.header_info, %struct.header_info* %278, i32 0, i32 4
  store i64 1, i64* %279, align 8
  br label %286

280:                                              ; preds = %274
  %281 = load %struct.header_info*, %struct.header_info** %24, align 8
  %282 = getelementptr inbounds %struct.header_info, %struct.header_info* %281, i32 0, i32 2
  %283 = load i64, i64* %282, align 8
  %284 = load %struct.header_info*, %struct.header_info** %24, align 8
  %285 = getelementptr inbounds %struct.header_info, %struct.header_info* %284, i32 0, i32 4
  store i64 %283, i64* %285, align 8
  br label %286

286:                                              ; preds = %280, %277
  %287 = load %struct.header_info*, %struct.header_info** %24, align 8
  %288 = getelementptr inbounds %struct.header_info, %struct.header_info* %287, i32 0, i32 5
  store i64 4, i64* %288, align 8
  store i32 0, i32* %23, align 4
  br label %291

289:                                              ; preds = %273, %252, %239, %199, %93, %62
  store i32 -1, i32* %23, align 4
  br label %291

290:                                              ; No predecessors!
  store i32 -2, i32* %23, align 4
  br label %291

291:                                              ; preds = %290, %289, %286
  %292 = load i32, i32* %23, align 4
  ret i32 %292
}

declare dso_local i32 @printf(i8*, ...) #4

; Function Attrs: nounwind
declare dso_local i32 @sprintf(i8*, i8*, ...) #5

; Function Attrs: nounwind readonly
declare dso_local i32 @strcmp(i8*, i8*) #6

; Function Attrs: nounwind
declare dso_local noalias i8* @calloc(i64, i64) #5

; Function Attrs: nounwind
declare dso_local void @free(i8*) #5

declare dso_local i32 @wprintf(i32*, ...) #4

; Function Attrs: nounwind readonly
declare dso_local i32 @strncmp(i8*, i8*, i64) #6

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @_Z27FORMAT_QT_RAW_header_parserP11header_info(%struct.header_info* %0) #0 {
  %2 = alloca %struct.header_info*, align 8
  store %struct.header_info* %0, %struct.header_info** %2, align 8
  %3 = load %struct.header_info*, %struct.header_info** %2, align 8
  %4 = getelementptr inbounds %struct.header_info, %struct.header_info* %3, i32 0, i32 6
  store i64 4, i64* %4, align 8
  %5 = load %struct.header_info*, %struct.header_info** %2, align 8
  %6 = getelementptr inbounds %struct.header_info, %struct.header_info* %5, i32 0, i32 5
  store i64 10, i64* %6, align 8
  %7 = load %struct.header_info*, %struct.header_info** %2, align 8
  %8 = getelementptr inbounds %struct.header_info, %struct.header_info* %7, i32 0, i32 2
  store i64 1, i64* %8, align 8
  %9 = load %struct.header_info*, %struct.header_info** %2, align 8
  %10 = getelementptr inbounds %struct.header_info, %struct.header_info* %9, i32 0, i32 3
  store i64 1, i64* %10, align 8
  %11 = load %struct.header_info*, %struct.header_info** %2, align 8
  %12 = getelementptr inbounds %struct.header_info, %struct.header_info* %11, i32 0, i32 4
  store i64 0, i64* %12, align 8
  ret i32 0
}

; Function Attrs: alwaysinline uwtable
define dso_local i32 @_Z30FORMAT_QT_BINARY_header_parserP11header_infoPc(%struct.header_info* %0, i8* %1) #3 {
  %3 = alloca %struct.header_info*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.header_info*, align 8
  %10 = alloca i8*, align 8
  %11 = alloca [32 x i8], align 16
  store %struct.header_info* %0, %struct.header_info** %9, align 8
  store i8* %1, i8** %10, align 8
  %12 = load %struct.header_info*, %struct.header_info** %9, align 8
  %13 = bitcast [32 x i8]* %11 to i8*
  %14 = load i8*, i8** %10, align 8
  store %struct.header_info* %12, %struct.header_info** %3, align 8
  store i8* %13, i8** %4, align 8
  store i64 1, i64* %5, align 8
  store i64 32, i64* %6, align 8
  store i8* %14, i8** %7, align 8
  %15 = load i8*, i8** %4, align 8
  %16 = load i8*, i8** %7, align 8
  %17 = load %struct.header_info*, %struct.header_info** %3, align 8
  %18 = getelementptr inbounds %struct.header_info, %struct.header_info* %17, i32 0, i32 1
  %19 = load i64, i64* %18, align 8
  %20 = getelementptr inbounds i8, i8* %16, i64 %19
  %21 = load i64, i64* %5, align 8
  %22 = load i64, i64* %6, align 8
  %23 = mul i64 %21, %22
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %15, i8* align 1 %20, i64 %23, i1 false) #7
  %24 = load i64, i64* %5, align 8
  %25 = load i64, i64* %6, align 8
  %26 = mul i64 %24, %25
  %27 = load %struct.header_info*, %struct.header_info** %3, align 8
  %28 = getelementptr inbounds %struct.header_info, %struct.header_info* %27, i32 0, i32 1
  %29 = load i64, i64* %28, align 8
  %30 = add i64 %29, %26
  store i64 %30, i64* %28, align 8
  %31 = load i64, i64* %5, align 8
  %32 = load i64, i64* %6, align 8
  %33 = mul i64 %31, %32
  %34 = icmp ne i64 %33, 32
  br i1 %34, label %35, label %38

35:                                               ; preds = %2
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.7, i64 0, i64 0))
  %37 = sext i32 %36 to i64
  store i64 %37, i64* @order_gurantee3, align 8
  store i32 -1, i32* %8, align 4
  br label %49

38:                                               ; preds = %2
  %39 = load %struct.header_info*, %struct.header_info** %9, align 8
  %40 = getelementptr inbounds %struct.header_info, %struct.header_info* %39, i32 0, i32 6
  store i64 4, i64* %40, align 8
  %41 = load %struct.header_info*, %struct.header_info** %9, align 8
  %42 = getelementptr inbounds %struct.header_info, %struct.header_info* %41, i32 0, i32 5
  store i64 10, i64* %42, align 8
  %43 = load %struct.header_info*, %struct.header_info** %9, align 8
  %44 = getelementptr inbounds %struct.header_info, %struct.header_info* %43, i32 0, i32 2
  store i64 1, i64* %44, align 8
  %45 = load %struct.header_info*, %struct.header_info** %9, align 8
  %46 = getelementptr inbounds %struct.header_info, %struct.header_info* %45, i32 0, i32 3
  store i64 1, i64* %46, align 8
  %47 = load %struct.header_info*, %struct.header_info** %9, align 8
  %48 = getelementptr inbounds %struct.header_info, %struct.header_info* %47, i32 0, i32 4
  store i64 0, i64* %48, align 8
  store i32 0, i32* %8, align 4
  br label %49

49:                                               ; preds = %38, %35
  %50 = load i32, i32* %8, align 4
  ret i32 %50
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @_Z31FORMAT_SI_16bytes_header_parserP11header_info(%struct.header_info* %0) #0 {
  %2 = alloca %struct.header_info*, align 8
  store %struct.header_info* %0, %struct.header_info** %2, align 8
  %3 = load %struct.header_info*, %struct.header_info** %2, align 8
  %4 = getelementptr inbounds %struct.header_info, %struct.header_info* %3, i32 0, i32 4
  store i64 0, i64* %4, align 8
  %5 = load %struct.header_info*, %struct.header_info** %2, align 8
  %6 = getelementptr inbounds %struct.header_info, %struct.header_info* %5, i32 0, i32 2
  store i64 1, i64* %6, align 8
  %7 = load %struct.header_info*, %struct.header_info** %2, align 8
  %8 = getelementptr inbounds %struct.header_info, %struct.header_info* %7, i32 0, i32 3
  store i64 1, i64* %8, align 8
  %9 = load %struct.header_info*, %struct.header_info** %2, align 8
  %10 = getelementptr inbounds %struct.header_info, %struct.header_info* %9, i32 0, i32 6
  store i64 1, i64* %10, align 8
  %11 = load %struct.header_info*, %struct.header_info** %2, align 8
  %12 = getelementptr inbounds %struct.header_info, %struct.header_info* %11, i32 0, i32 5
  store i64 16, i64* %12, align 8
  %13 = load %struct.header_info*, %struct.header_info** %2, align 8
  %14 = getelementptr inbounds %struct.header_info, %struct.header_info* %13, i32 0, i32 1
  store i64 0, i64* %14, align 8
  ret i32 0
}

; Function Attrs: alwaysinline uwtable
define dso_local i32 @_Z34FORMAT_QT_COMPRESSED_header_parserP11header_infoPc(%struct.header_info* %0, i8* %1) #3 {
  %3 = alloca %struct.header_info*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.header_info*, align 8
  %10 = alloca i8*, align 8
  %11 = alloca [32 x i8], align 16
  store %struct.header_info* %0, %struct.header_info** %9, align 8
  store i8* %1, i8** %10, align 8
  %12 = load %struct.header_info*, %struct.header_info** %9, align 8
  %13 = bitcast [32 x i8]* %11 to i8*
  %14 = load i8*, i8** %10, align 8
  store %struct.header_info* %12, %struct.header_info** %3, align 8
  store i8* %13, i8** %4, align 8
  store i64 1, i64* %5, align 8
  store i64 32, i64* %6, align 8
  store i8* %14, i8** %7, align 8
  %15 = load i8*, i8** %4, align 8
  %16 = load i8*, i8** %7, align 8
  %17 = load %struct.header_info*, %struct.header_info** %3, align 8
  %18 = getelementptr inbounds %struct.header_info, %struct.header_info* %17, i32 0, i32 1
  %19 = load i64, i64* %18, align 8
  %20 = getelementptr inbounds i8, i8* %16, i64 %19
  %21 = load i64, i64* %5, align 8
  %22 = load i64, i64* %6, align 8
  %23 = mul i64 %21, %22
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %15, i8* align 1 %20, i64 %23, i1 false) #7
  %24 = load i64, i64* %5, align 8
  %25 = load i64, i64* %6, align 8
  %26 = mul i64 %24, %25
  %27 = load %struct.header_info*, %struct.header_info** %3, align 8
  %28 = getelementptr inbounds %struct.header_info, %struct.header_info* %27, i32 0, i32 1
  %29 = load i64, i64* %28, align 8
  %30 = add i64 %29, %26
  store i64 %30, i64* %28, align 8
  %31 = load i64, i64* %5, align 8
  %32 = load i64, i64* %6, align 8
  %33 = mul i64 %31, %32
  %34 = icmp ne i64 %33, 32
  br i1 %34, label %35, label %38

35:                                               ; preds = %2
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.7, i64 0, i64 0))
  %37 = sext i32 %36 to i64
  store i64 %37, i64* @order_gurantee3, align 8
  store i32 -1, i32* %8, align 4
  br label %49

38:                                               ; preds = %2
  %39 = load %struct.header_info*, %struct.header_info** %9, align 8
  %40 = getelementptr inbounds %struct.header_info, %struct.header_info* %39, i32 0, i32 6
  store i64 2, i64* %40, align 8
  %41 = load %struct.header_info*, %struct.header_info** %9, align 8
  %42 = getelementptr inbounds %struct.header_info, %struct.header_info* %41, i32 0, i32 5
  store i64 5, i64* %42, align 8
  %43 = load %struct.header_info*, %struct.header_info** %9, align 8
  %44 = getelementptr inbounds %struct.header_info, %struct.header_info* %43, i32 0, i32 2
  store i64 1, i64* %44, align 8
  %45 = load %struct.header_info*, %struct.header_info** %9, align 8
  %46 = getelementptr inbounds %struct.header_info, %struct.header_info* %45, i32 0, i32 3
  store i64 1, i64* %46, align 8
  %47 = load %struct.header_info*, %struct.header_info** %9, align 8
  %48 = getelementptr inbounds %struct.header_info, %struct.header_info* %47, i32 0, i32 4
  store i64 0, i64* %48, align 8
  store i32 0, i32* %8, align 4
  br label %49

49:                                               ; preds = %38, %35
  %50 = load i32, i32* %8, align 4
  ret i32 %50
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @_Z34FORMAT_BH_spc_4bytes_header_parserP11header_infoPc(%struct.header_info* %0, i8* %1) #0 {
  %3 = alloca %struct.header_info*, align 8
  %4 = alloca i8*, align 8
  store %struct.header_info* %0, %struct.header_info** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load i8*, i8** %4, align 8
  %6 = bitcast i8* %5 to i16*
  %7 = getelementptr inbounds i16, i16* %6, i64 0
  %8 = load i16, i16* %7, align 2
  %9 = zext i16 %8 to i64
  %10 = load %struct.header_info*, %struct.header_info** %3, align 8
  %11 = getelementptr inbounds %struct.header_info, %struct.header_info* %10, i32 0, i32 4
  store i64 %9, i64* %11, align 8
  %12 = load %struct.header_info*, %struct.header_info** %3, align 8
  %13 = getelementptr inbounds %struct.header_info, %struct.header_info* %12, i32 0, i32 3
  store i64 1, i64* %13, align 8
  %14 = load %struct.header_info*, %struct.header_info** %3, align 8
  %15 = getelementptr inbounds %struct.header_info, %struct.header_info* %14, i32 0, i32 2
  store i64 0, i64* %15, align 8
  %16 = load %struct.header_info*, %struct.header_info** %3, align 8
  %17 = getelementptr inbounds %struct.header_info, %struct.header_info* %16, i32 0, i32 6
  store i64 5, i64* %17, align 8
  %18 = load %struct.header_info*, %struct.header_info** %3, align 8
  %19 = getelementptr inbounds %struct.header_info, %struct.header_info* %18, i32 0, i32 5
  store i64 4, i64* %19, align 8
  %20 = load %struct.header_info*, %struct.header_info** %3, align 8
  %21 = getelementptr inbounds %struct.header_info, %struct.header_info* %20, i32 0, i32 1
  store i64 4, i64* %21, align 8
  ret i32 0
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @_Z28FORMAT_ET_A033_header_parserP11header_info(%struct.header_info* %0) #0 {
  %2 = alloca %struct.header_info*, align 8
  store %struct.header_info* %0, %struct.header_info** %2, align 8
  %3 = load %struct.header_info*, %struct.header_info** %2, align 8
  %4 = getelementptr inbounds %struct.header_info, %struct.header_info* %3, i32 0, i32 4
  store i64 0, i64* %4, align 8
  %5 = load %struct.header_info*, %struct.header_info** %2, align 8
  %6 = getelementptr inbounds %struct.header_info, %struct.header_info* %5, i32 0, i32 2
  store i64 1, i64* %6, align 8
  %7 = load %struct.header_info*, %struct.header_info** %2, align 8
  %8 = getelementptr inbounds %struct.header_info, %struct.header_info* %7, i32 0, i32 3
  store i64 1, i64* %8, align 8
  %9 = load %struct.header_info*, %struct.header_info** %2, align 8
  %10 = getelementptr inbounds %struct.header_info, %struct.header_info* %9, i32 0, i32 6
  store i64 6, i64* %10, align 8
  %11 = load %struct.header_info*, %struct.header_info** %2, align 8
  %12 = getelementptr inbounds %struct.header_info, %struct.header_info* %11, i32 0, i32 5
  store i64 8, i64* %12, align 8
  %13 = load %struct.header_info*, %struct.header_info** %2, align 8
  %14 = getelementptr inbounds %struct.header_info, %struct.header_info* %13, i32 0, i32 1
  store i64 0, i64* %14, align 8
  ret i32 0
}

; Function Attrs: alwaysinline uwtable
define dso_local i32 @PARSE_TimeTagFileHeader(%struct.header_info* %0, i8* %1) #3 {
  %3 = alloca %struct.header_info*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca %struct.header_info*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.header_info*, align 8
  %12 = alloca i8*, align 8
  %13 = alloca %struct.header_info*, align 8
  %14 = alloca %struct.header_info*, align 8
  %15 = alloca i8*, align 8
  %16 = alloca i64, align 8
  %17 = alloca i64, align 8
  %18 = alloca i8*, align 8
  %19 = alloca %struct.header_info*, align 8
  %20 = alloca i8*, align 8
  %21 = alloca i64, align 8
  %22 = alloca i64, align 8
  %23 = alloca i8*, align 8
  %24 = alloca %struct.header_info*, align 8
  %25 = alloca i8*, align 8
  %26 = alloca i64, align 8
  %27 = alloca i64, align 8
  %28 = alloca i8*, align 8
  %29 = alloca %struct.header_info*, align 8
  %30 = alloca i8*, align 8
  %31 = alloca i64, align 8
  %32 = alloca i64, align 8
  %33 = alloca i8*, align 8
  %34 = alloca i32, align 4
  %35 = alloca %struct.header_info*, align 8
  %36 = alloca i8*, align 8
  %37 = alloca %struct.TgHd, align 8
  %38 = alloca i32, align 4
  %39 = alloca i8*, align 8
  %40 = alloca i32*, align 8
  %41 = alloca [8 x i8], align 1
  %42 = alloca [40 x i8], align 16
  %43 = alloca double, align 8
  %44 = alloca double, align 8
  %45 = alloca i64, align 8
  %46 = alloca i8, align 1
  %47 = alloca %struct.header_info*, align 8
  %48 = alloca i8*, align 8
  %49 = alloca i64, align 8
  %50 = alloca i64, align 8
  %51 = alloca i8*, align 8
  %52 = alloca i32, align 4
  %53 = alloca %struct.header_info*, align 8
  %54 = alloca i8*, align 8
  %55 = alloca [32 x i8], align 16
  %56 = alloca %struct.header_info*, align 8
  %57 = alloca %struct.header_info*, align 8
  %58 = alloca %struct.header_info*, align 8
  %59 = alloca i8*, align 8
  %60 = alloca i64, align 8
  %61 = alloca i64, align 8
  %62 = alloca i8*, align 8
  %63 = alloca i32, align 4
  %64 = alloca %struct.header_info*, align 8
  %65 = alloca i8*, align 8
  %66 = alloca i32, align 4
  %67 = alloca [8 x i8], align 1
  store %struct.header_info* %0, %struct.header_info** %64, align 8
  store i8* %1, i8** %65, align 8
  store i32 -1, i32* %66, align 4
  %68 = load %struct.header_info*, %struct.header_info** %64, align 8
  %69 = getelementptr inbounds %struct.header_info, %struct.header_info* %68, i32 0, i32 1
  store i64 0, i64* %69, align 8
  %70 = load %struct.header_info*, %struct.header_info** %64, align 8
  %71 = bitcast [8 x i8]* %67 to i8*
  %72 = load i8*, i8** %65, align 8
  store %struct.header_info* %70, %struct.header_info** %58, align 8
  store i8* %71, i8** %59, align 8
  store i64 1, i64* %60, align 8
  store i64 8, i64* %61, align 8
  store i8* %72, i8** %62, align 8
  %73 = load i8*, i8** %59, align 8
  %74 = load i8*, i8** %62, align 8
  %75 = load %struct.header_info*, %struct.header_info** %58, align 8
  %76 = getelementptr inbounds %struct.header_info, %struct.header_info* %75, i32 0, i32 1
  %77 = load i64, i64* %76, align 8
  %78 = getelementptr inbounds i8, i8* %74, i64 %77
  %79 = load i64, i64* %60, align 8
  %80 = load i64, i64* %61, align 8
  %81 = mul i64 %79, %80
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %73, i8* align 1 %78, i64 %81, i1 false) #7
  %82 = load i64, i64* %60, align 8
  %83 = load i64, i64* %61, align 8
  %84 = mul i64 %82, %83
  %85 = load %struct.header_info*, %struct.header_info** %58, align 8
  %86 = getelementptr inbounds %struct.header_info, %struct.header_info* %85, i32 0, i32 1
  %87 = load i64, i64* %86, align 8
  %88 = add i64 %87, %84
  store i64 %88, i64* %86, align 8
  %89 = load i64, i64* %60, align 8
  %90 = load i64, i64* %61, align 8
  %91 = mul i64 %89, %90
  %92 = icmp ne i64 %91, 8
  br i1 %92, label %93, label %96

93:                                               ; preds = %2
  %94 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.8, i64 0, i64 0))
  %95 = sext i32 %94 to i64
  store i64 %95, i64* @order_gurantee3, align 8
  store i32 -2, i32* %63, align 4
  br label %533

96:                                               ; preds = %2
  %97 = load %struct.header_info*, %struct.header_info** %64, align 8
  %98 = getelementptr inbounds %struct.header_info, %struct.header_info* %97, i32 0, i32 6
  %99 = load i64, i64* %98, align 8
  %100 = icmp eq i64 %99, -1
  br i1 %100, label %101, label %116

101:                                              ; preds = %96
  %102 = getelementptr inbounds [8 x i8], [8 x i8]* %67, i64 0, i64 0
  %103 = call i32 @strncmp(i8* %102, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.9, i64 0, i64 0), i64 6) #8
  %104 = icmp eq i32 %103, 0
  br i1 %104, label %105, label %108

105:                                              ; preds = %101
  %106 = load %struct.header_info*, %struct.header_info** %64, align 8
  %107 = getelementptr inbounds %struct.header_info, %struct.header_info* %106, i32 0, i32 6
  store i64 0, i64* %107, align 8
  br label %108

108:                                              ; preds = %105, %101
  %109 = getelementptr inbounds [8 x i8], [8 x i8]* %67, i64 0, i64 0
  %110 = call i32 @strncmp(i8* %109, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.10, i64 0, i64 0), i64 4) #8
  %111 = icmp eq i32 %110, 0
  br i1 %111, label %112, label %115

112:                                              ; preds = %108
  %113 = load %struct.header_info*, %struct.header_info** %64, align 8
  %114 = getelementptr inbounds %struct.header_info, %struct.header_info* %113, i32 0, i32 6
  store i64 4, i64* %114, align 8
  br label %115

115:                                              ; preds = %112, %108
  br label %116

116:                                              ; preds = %115, %96
  %117 = load %struct.header_info*, %struct.header_info** %64, align 8
  %118 = getelementptr inbounds %struct.header_info, %struct.header_info* %117, i32 0, i32 6
  %119 = load i64, i64* %118, align 8
  switch i64 %119, label %526 [
    i64 0, label %120
    i64 1, label %378
    i64 2, label %392
    i64 5, label %434
    i64 4, label %453
    i64 3, label %495
    i64 6, label %507
    i64 -1, label %521
  ]

120:                                              ; preds = %116
  %121 = load %struct.header_info*, %struct.header_info** %64, align 8
  %122 = load i8*, i8** %65, align 8
  store %struct.header_info* %121, %struct.header_info** %35, align 8
  store i8* %122, i8** %36, align 8
  %123 = load %struct.header_info*, %struct.header_info** %35, align 8
  %124 = bitcast [8 x i8]* %41 to i8*
  %125 = load i8*, i8** %36, align 8
  store %struct.header_info* %123, %struct.header_info** %29, align 8
  store i8* %124, i8** %30, align 8
  store i64 1, i64* %31, align 8
  store i64 8, i64* %32, align 8
  store i8* %125, i8** %33, align 8
  %126 = load i8*, i8** %30, align 8
  %127 = load i8*, i8** %33, align 8
  %128 = load %struct.header_info*, %struct.header_info** %29, align 8
  %129 = getelementptr inbounds %struct.header_info, %struct.header_info* %128, i32 0, i32 1
  %130 = load i64, i64* %129, align 8
  %131 = getelementptr inbounds i8, i8* %127, i64 %130
  %132 = load i64, i64* %31, align 8
  %133 = load i64, i64* %32, align 8
  %134 = mul i64 %132, %133
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %126, i8* align 1 %131, i64 %134, i1 false) #7
  %135 = load i64, i64* %31, align 8
  %136 = load i64, i64* %32, align 8
  %137 = mul i64 %135, %136
  %138 = load %struct.header_info*, %struct.header_info** %29, align 8
  %139 = getelementptr inbounds %struct.header_info, %struct.header_info* %138, i32 0, i32 1
  %140 = load i64, i64* %139, align 8
  %141 = add i64 %140, %137
  store i64 %141, i64* %139, align 8
  %142 = load i64, i64* %31, align 8
  %143 = load i64, i64* %32, align 8
  %144 = mul i64 %142, %143
  %145 = trunc i64 %144 to i32
  store i32 %145, i32* %38, align 4
  %146 = load i32, i32* %38, align 4
  %147 = sext i32 %146 to i64
  %148 = icmp ne i64 %147, 8
  br i1 %148, label %149, label %152

149:                                              ; preds = %120
  %150 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str, i64 0, i64 0))
  %151 = sext i32 %150 to i64
  store i64 %151, i64* @order_gurantee3, align 8
  br label %375

152:                                              ; preds = %120
  br label %153

153:                                              ; preds = %340, %152
  %154 = load %struct.header_info*, %struct.header_info** %35, align 8
  %155 = bitcast %struct.TgHd* %37 to i8*
  %156 = load i8*, i8** %36, align 8
  store %struct.header_info* %154, %struct.header_info** %14, align 8
  store i8* %155, i8** %15, align 8
  store i64 1, i64* %16, align 8
  store i64 48, i64* %17, align 8
  store i8* %156, i8** %18, align 8
  %157 = load i8*, i8** %15, align 8
  %158 = load i8*, i8** %18, align 8
  %159 = load %struct.header_info*, %struct.header_info** %14, align 8
  %160 = getelementptr inbounds %struct.header_info, %struct.header_info* %159, i32 0, i32 1
  %161 = load i64, i64* %160, align 8
  %162 = getelementptr inbounds i8, i8* %158, i64 %161
  %163 = load i64, i64* %16, align 8
  %164 = load i64, i64* %17, align 8
  %165 = mul i64 %163, %164
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %157, i8* align 1 %162, i64 %165, i1 false) #7
  %166 = load i64, i64* %16, align 8
  %167 = load i64, i64* %17, align 8
  %168 = mul i64 %166, %167
  %169 = load %struct.header_info*, %struct.header_info** %14, align 8
  %170 = getelementptr inbounds %struct.header_info, %struct.header_info* %169, i32 0, i32 1
  %171 = load i64, i64* %170, align 8
  %172 = add i64 %171, %168
  store i64 %172, i64* %170, align 8
  %173 = load i64, i64* %16, align 8
  %174 = load i64, i64* %17, align 8
  %175 = mul i64 %173, %174
  %176 = trunc i64 %175 to i32
  store i32 %176, i32* %38, align 4
  %177 = load i32, i32* %38, align 4
  %178 = sext i32 %177 to i64
  %179 = icmp ne i64 %178, 48
  br i1 %179, label %180, label %181

180:                                              ; preds = %153
  br label %375

181:                                              ; preds = %153
  %182 = getelementptr inbounds [40 x i8], [40 x i8]* %42, i64 0, i64 0
  %183 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 0
  %184 = getelementptr inbounds [32 x i8], [32 x i8]* %183, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %182, i8* align 8 %184, i64 40, i1 false)
  %185 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 1
  %186 = load i32, i32* %185, align 8
  %187 = icmp sgt i32 %186, -1
  br i1 %187, label %188, label %195

188:                                              ; preds = %181
  %189 = getelementptr inbounds [40 x i8], [40 x i8]* %42, i64 0, i64 0
  %190 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 0
  %191 = getelementptr inbounds [32 x i8], [32 x i8]* %190, i64 0, i64 0
  %192 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 1
  %193 = load i32, i32* %192, align 8
  %194 = call i32 (i8*, i8*, ...) @sprintf(i8* %189, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0), i8* %191, i32 %193) #7
  br label %195

195:                                              ; preds = %188, %181
  %196 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 2
  %197 = load i32, i32* %196, align 4
  switch i32 %197, label %339 [
    i32 -65528, label %198
    i32 8, label %199
    i32 268435464, label %200
    i32 285212680, label %211
    i32 301989896, label %212
    i32 536870920, label %213
    i32 537001983, label %242
    i32 553648136, label %247
    i32 1073872895, label %252
    i32 1073938431, label %290
    i32 -1, label %334
  ]

198:                                              ; preds = %195
  br label %340

199:                                              ; preds = %195
  br label %340

200:                                              ; preds = %195
  %201 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 0
  %202 = getelementptr inbounds [32 x i8], [32 x i8]* %201, i64 0, i64 0
  %203 = call i32 @strcmp(i8* %202, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.2, i64 0, i64 0)) #8
  %204 = icmp eq i32 %203, 0
  br i1 %204, label %205, label %210

205:                                              ; preds = %200
  %206 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %207 = load i64, i64* %206, align 8
  %208 = load %struct.header_info*, %struct.header_info** %35, align 8
  %209 = getelementptr inbounds %struct.header_info, %struct.header_info* %208, i32 0, i32 6
  store i64 %207, i64* %209, align 8
  br label %210

210:                                              ; preds = %205, %200
  br label %340

211:                                              ; preds = %195
  br label %340

212:                                              ; preds = %195
  br label %340

213:                                              ; preds = %195
  %214 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 0
  %215 = getelementptr inbounds [32 x i8], [32 x i8]* %214, i64 0, i64 0
  %216 = call i32 @strcmp(i8* %215, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.3, i64 0, i64 0)) #8
  %217 = icmp eq i32 %216, 0
  br i1 %217, label %218, label %227

218:                                              ; preds = %213
  %219 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %220 = bitcast i64* %219 to double*
  %221 = load double, double* %220, align 8
  store double %221, double* %43, align 8
  %222 = load double, double* %43, align 8
  %223 = fmul double %222, 1.000000e+12
  %224 = fptosi double %223 to i64
  %225 = load %struct.header_info*, %struct.header_info** %35, align 8
  %226 = getelementptr inbounds %struct.header_info, %struct.header_info* %225, i32 0, i32 3
  store i64 %224, i64* %226, align 8
  br label %227

227:                                              ; preds = %218, %213
  %228 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 0
  %229 = getelementptr inbounds [32 x i8], [32 x i8]* %228, i64 0, i64 0
  %230 = call i32 @strcmp(i8* %229, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.4, i64 0, i64 0)) #8
  %231 = icmp eq i32 %230, 0
  br i1 %231, label %232, label %241

232:                                              ; preds = %227
  %233 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %234 = bitcast i64* %233 to double*
  %235 = load double, double* %234, align 8
  store double %235, double* %44, align 8
  %236 = load double, double* %44, align 8
  %237 = fmul double %236, 1.000000e+12
  %238 = fptosi double %237 to i64
  %239 = load %struct.header_info*, %struct.header_info** %35, align 8
  %240 = getelementptr inbounds %struct.header_info, %struct.header_info* %239, i32 0, i32 2
  store i64 %238, i64* %240, align 8
  br label %241

241:                                              ; preds = %232, %227
  br label %340

242:                                              ; preds = %195
  %243 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %244 = load i64, i64* %243, align 8
  %245 = load %struct.header_info*, %struct.header_info** %35, align 8
  %246 = getelementptr inbounds %struct.header_info, %struct.header_info* %245, i32 0, i32 1
  store i64 %244, i64* %246, align 8
  br label %340

247:                                              ; preds = %195
  %248 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %249 = bitcast i64* %248 to double*
  %250 = load double, double* %249, align 8
  %251 = call i64 @_Z15TDateTime_TimeTd(double %250)
  store i64 %251, i64* %45, align 8
  br label %340

252:                                              ; preds = %195
  %253 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %254 = load i64, i64* %253, align 8
  %255 = call noalias i8* @calloc(i64 %254, i64 1) #7
  store i8* %255, i8** %39, align 8
  %256 = load %struct.header_info*, %struct.header_info** %35, align 8
  %257 = load i8*, i8** %39, align 8
  %258 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %259 = load i64, i64* %258, align 8
  %260 = load i8*, i8** %36, align 8
  store %struct.header_info* %256, %struct.header_info** %19, align 8
  store i8* %257, i8** %20, align 8
  store i64 1, i64* %21, align 8
  store i64 %259, i64* %22, align 8
  store i8* %260, i8** %23, align 8
  %261 = load i8*, i8** %20, align 8
  %262 = load i8*, i8** %23, align 8
  %263 = load %struct.header_info*, %struct.header_info** %19, align 8
  %264 = getelementptr inbounds %struct.header_info, %struct.header_info* %263, i32 0, i32 1
  %265 = load i64, i64* %264, align 8
  %266 = getelementptr inbounds i8, i8* %262, i64 %265
  %267 = load i64, i64* %21, align 8
  %268 = load i64, i64* %22, align 8
  %269 = mul i64 %267, %268
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %261, i8* align 1 %266, i64 %269, i1 false) #7
  %270 = load i64, i64* %21, align 8
  %271 = load i64, i64* %22, align 8
  %272 = mul i64 %270, %271
  %273 = load %struct.header_info*, %struct.header_info** %19, align 8
  %274 = getelementptr inbounds %struct.header_info, %struct.header_info* %273, i32 0, i32 1
  %275 = load i64, i64* %274, align 8
  %276 = add i64 %275, %272
  store i64 %276, i64* %274, align 8
  %277 = load i64, i64* %21, align 8
  %278 = load i64, i64* %22, align 8
  %279 = mul i64 %277, %278
  %280 = trunc i64 %279 to i32
  store i32 %280, i32* %38, align 4
  %281 = load i32, i32* %38, align 4
  %282 = sext i32 %281 to i64
  %283 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %284 = load i64, i64* %283, align 8
  %285 = icmp ne i64 %282, %284
  br i1 %285, label %286, label %288

286:                                              ; preds = %252
  %287 = load i8*, i8** %39, align 8
  call void @free(i8* %287) #7
  br label %375

288:                                              ; preds = %252
  %289 = load i8*, i8** %39, align 8
  call void @free(i8* %289) #7
  br label %340

290:                                              ; preds = %195
  %291 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %292 = load i64, i64* %291, align 8
  %293 = call noalias i8* @calloc(i64 %292, i64 1) #7
  %294 = bitcast i8* %293 to i32*
  store i32* %294, i32** %40, align 8
  %295 = load %struct.header_info*, %struct.header_info** %35, align 8
  %296 = load i32*, i32** %40, align 8
  %297 = bitcast i32* %296 to i8*
  %298 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %299 = load i64, i64* %298, align 8
  %300 = load i8*, i8** %36, align 8
  store %struct.header_info* %295, %struct.header_info** %24, align 8
  store i8* %297, i8** %25, align 8
  store i64 1, i64* %26, align 8
  store i64 %299, i64* %27, align 8
  store i8* %300, i8** %28, align 8
  %301 = load i8*, i8** %25, align 8
  %302 = load i8*, i8** %28, align 8
  %303 = load %struct.header_info*, %struct.header_info** %24, align 8
  %304 = getelementptr inbounds %struct.header_info, %struct.header_info* %303, i32 0, i32 1
  %305 = load i64, i64* %304, align 8
  %306 = getelementptr inbounds i8, i8* %302, i64 %305
  %307 = load i64, i64* %26, align 8
  %308 = load i64, i64* %27, align 8
  %309 = mul i64 %307, %308
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %301, i8* align 1 %306, i64 %309, i1 false) #7
  %310 = load i64, i64* %26, align 8
  %311 = load i64, i64* %27, align 8
  %312 = mul i64 %310, %311
  %313 = load %struct.header_info*, %struct.header_info** %24, align 8
  %314 = getelementptr inbounds %struct.header_info, %struct.header_info* %313, i32 0, i32 1
  %315 = load i64, i64* %314, align 8
  %316 = add i64 %315, %312
  store i64 %316, i64* %314, align 8
  %317 = load i64, i64* %26, align 8
  %318 = load i64, i64* %27, align 8
  %319 = mul i64 %317, %318
  %320 = trunc i64 %319 to i32
  store i32 %320, i32* %38, align 4
  %321 = load i32, i32* %38, align 4
  %322 = sext i32 %321 to i64
  %323 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %324 = load i64, i64* %323, align 8
  %325 = icmp ne i64 %322, %324
  br i1 %325, label %326, label %329

326:                                              ; preds = %290
  %327 = load i32*, i32** %40, align 8
  %328 = bitcast i32* %327 to i8*
  call void @free(i8* %328) #7
  br label %375

329:                                              ; preds = %290
  %330 = load i32*, i32** %40, align 8
  %331 = call i32 (i32*, ...) @wprintf(i32* getelementptr inbounds ([3 x i32], [3 x i32]* @.str.5, i64 0, i64 0), i32* %330)
  %332 = load i32*, i32** %40, align 8
  %333 = bitcast i32* %332 to i8*
  call void @free(i8* %333) #7
  br label %340

334:                                              ; preds = %195
  %335 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 3
  %336 = load i64, i64* %335, align 8
  %337 = load %struct.header_info*, %struct.header_info** %35, align 8
  %338 = getelementptr inbounds %struct.header_info, %struct.header_info* %337, i32 0, i32 1
  store i64 %336, i64* %338, align 8
  br label %340

339:                                              ; preds = %195
  br label %375

340:                                              ; preds = %334, %329, %288, %247, %242, %241, %212, %211, %210, %199, %198
  %341 = getelementptr inbounds %struct.TgHd, %struct.TgHd* %37, i32 0, i32 0
  %342 = getelementptr inbounds [32 x i8], [32 x i8]* %341, i64 0, i64 0
  %343 = call i32 @strncmp(i8* %342, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.6, i64 0, i64 0), i64 11) #8
  %344 = icmp ne i32 %343, 0
  br i1 %344, label %153, label %345

345:                                              ; preds = %340
  %346 = load %struct.header_info*, %struct.header_info** %35, align 8
  %347 = getelementptr inbounds %struct.header_info, %struct.header_info* %346, i32 0, i32 6
  %348 = load i64, i64* %347, align 8
  switch i64 %348, label %359 [
    i64 66051, label %349
    i64 66052, label %350
    i64 16843268, label %351
    i64 66053, label %352
    i64 66054, label %353
    i64 66307, label %354
    i64 66308, label %355
    i64 16843524, label %356
    i64 66309, label %357
    i64 66310, label %358
  ]

349:                                              ; preds = %345
  store i8 1, i8* %46, align 1
  br label %360

350:                                              ; preds = %345
  store i8 1, i8* %46, align 1
  br label %360

351:                                              ; preds = %345
  store i8 1, i8* %46, align 1
  br label %360

352:                                              ; preds = %345
  store i8 1, i8* %46, align 1
  br label %360

353:                                              ; preds = %345
  store i8 1, i8* %46, align 1
  br label %360

354:                                              ; preds = %345
  store i8 0, i8* %46, align 1
  br label %360

355:                                              ; preds = %345
  store i8 0, i8* %46, align 1
  br label %360

356:                                              ; preds = %345
  store i8 0, i8* %46, align 1
  br label %360

357:                                              ; preds = %345
  store i8 0, i8* %46, align 1
  br label %360

358:                                              ; preds = %345
  store i8 0, i8* %46, align 1
  br label %360

359:                                              ; preds = %345
  br label %375

360:                                              ; preds = %358, %357, %356, %355, %354, %353, %352, %351, %350, %349
  %361 = load i8, i8* %46, align 1
  %362 = trunc i8 %361 to i1
  br i1 %362, label %363, label %366

363:                                              ; preds = %360
  %364 = load %struct.header_info*, %struct.header_info** %35, align 8
  %365 = getelementptr inbounds %struct.header_info, %struct.header_info* %364, i32 0, i32 4
  store i64 1, i64* %365, align 8
  br label %372

366:                                              ; preds = %360
  %367 = load %struct.header_info*, %struct.header_info** %35, align 8
  %368 = getelementptr inbounds %struct.header_info, %struct.header_info* %367, i32 0, i32 2
  %369 = load i64, i64* %368, align 8
  %370 = load %struct.header_info*, %struct.header_info** %35, align 8
  %371 = getelementptr inbounds %struct.header_info, %struct.header_info* %370, i32 0, i32 4
  store i64 %369, i64* %371, align 8
  br label %372

372:                                              ; preds = %366, %363
  %373 = load %struct.header_info*, %struct.header_info** %35, align 8
  %374 = getelementptr inbounds %struct.header_info, %struct.header_info* %373, i32 0, i32 5
  store i64 4, i64* %374, align 8
  store i32 0, i32* %34, align 4
  br label %376

375:                                              ; preds = %359, %339, %326, %286, %180, %149
  store i32 -1, i32* %34, align 4
  br label %376

376:                                              ; preds = %372, %375
  %377 = load i32, i32* %34, align 4
  store i32 %377, i32* %66, align 4
  br label %526

378:                                              ; preds = %116
  %379 = load %struct.header_info*, %struct.header_info** %64, align 8
  store %struct.header_info* %379, %struct.header_info** %13, align 8
  %380 = load %struct.header_info*, %struct.header_info** %13, align 8
  %381 = getelementptr inbounds %struct.header_info, %struct.header_info* %380, i32 0, i32 4
  store i64 0, i64* %381, align 8
  %382 = load %struct.header_info*, %struct.header_info** %13, align 8
  %383 = getelementptr inbounds %struct.header_info, %struct.header_info* %382, i32 0, i32 2
  store i64 1, i64* %383, align 8
  %384 = load %struct.header_info*, %struct.header_info** %13, align 8
  %385 = getelementptr inbounds %struct.header_info, %struct.header_info* %384, i32 0, i32 3
  store i64 1, i64* %385, align 8
  %386 = load %struct.header_info*, %struct.header_info** %13, align 8
  %387 = getelementptr inbounds %struct.header_info, %struct.header_info* %386, i32 0, i32 6
  store i64 1, i64* %387, align 8
  %388 = load %struct.header_info*, %struct.header_info** %13, align 8
  %389 = getelementptr inbounds %struct.header_info, %struct.header_info* %388, i32 0, i32 5
  store i64 16, i64* %389, align 8
  %390 = load %struct.header_info*, %struct.header_info** %13, align 8
  %391 = getelementptr inbounds %struct.header_info, %struct.header_info* %390, i32 0, i32 1
  store i64 0, i64* %391, align 8
  store i32 0, i32* %66, align 4
  br label %526

392:                                              ; preds = %116
  %393 = load %struct.header_info*, %struct.header_info** %64, align 8
  %394 = load i8*, i8** %65, align 8
  store %struct.header_info* %393, %struct.header_info** %11, align 8
  store i8* %394, i8** %12, align 8
  %395 = load %struct.header_info*, %struct.header_info** %11, align 8
  %396 = bitcast [32 x i8]* %55 to i8*
  %397 = load i8*, i8** %12, align 8
  store %struct.header_info* %395, %struct.header_info** %5, align 8
  store i8* %396, i8** %6, align 8
  store i64 1, i64* %7, align 8
  store i64 32, i64* %8, align 8
  store i8* %397, i8** %9, align 8
  %398 = load i8*, i8** %6, align 8
  %399 = load i8*, i8** %9, align 8
  %400 = load %struct.header_info*, %struct.header_info** %5, align 8
  %401 = getelementptr inbounds %struct.header_info, %struct.header_info* %400, i32 0, i32 1
  %402 = load i64, i64* %401, align 8
  %403 = getelementptr inbounds i8, i8* %399, i64 %402
  %404 = load i64, i64* %7, align 8
  %405 = load i64, i64* %8, align 8
  %406 = mul i64 %404, %405
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %398, i8* align 1 %403, i64 %406, i1 false) #7
  %407 = load i64, i64* %7, align 8
  %408 = load i64, i64* %8, align 8
  %409 = mul i64 %407, %408
  %410 = load %struct.header_info*, %struct.header_info** %5, align 8
  %411 = getelementptr inbounds %struct.header_info, %struct.header_info* %410, i32 0, i32 1
  %412 = load i64, i64* %411, align 8
  %413 = add i64 %412, %409
  store i64 %413, i64* %411, align 8
  %414 = load i64, i64* %7, align 8
  %415 = load i64, i64* %8, align 8
  %416 = mul i64 %414, %415
  %417 = icmp ne i64 %416, 32
  br i1 %417, label %418, label %421

418:                                              ; preds = %392
  %419 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.7, i64 0, i64 0))
  %420 = sext i32 %419 to i64
  store i64 %420, i64* @order_gurantee3, align 8
  store i32 -1, i32* %10, align 4
  br label %432

421:                                              ; preds = %392
  %422 = load %struct.header_info*, %struct.header_info** %11, align 8
  %423 = getelementptr inbounds %struct.header_info, %struct.header_info* %422, i32 0, i32 6
  store i64 2, i64* %423, align 8
  %424 = load %struct.header_info*, %struct.header_info** %11, align 8
  %425 = getelementptr inbounds %struct.header_info, %struct.header_info* %424, i32 0, i32 5
  store i64 5, i64* %425, align 8
  %426 = load %struct.header_info*, %struct.header_info** %11, align 8
  %427 = getelementptr inbounds %struct.header_info, %struct.header_info* %426, i32 0, i32 2
  store i64 1, i64* %427, align 8
  %428 = load %struct.header_info*, %struct.header_info** %11, align 8
  %429 = getelementptr inbounds %struct.header_info, %struct.header_info* %428, i32 0, i32 3
  store i64 1, i64* %429, align 8
  %430 = load %struct.header_info*, %struct.header_info** %11, align 8
  %431 = getelementptr inbounds %struct.header_info, %struct.header_info* %430, i32 0, i32 4
  store i64 0, i64* %431, align 8
  store i32 0, i32* %10, align 4
  br label %432

432:                                              ; preds = %418, %421
  %433 = load i32, i32* %10, align 4
  store i32 %433, i32* %66, align 4
  br label %526

434:                                              ; preds = %116
  %435 = load %struct.header_info*, %struct.header_info** %64, align 8
  %436 = getelementptr inbounds [8 x i8], [8 x i8]* %67, i64 0, i64 0
  store %struct.header_info* %435, %struct.header_info** %3, align 8
  store i8* %436, i8** %4, align 8
  %437 = load i8*, i8** %4, align 8
  %438 = bitcast i8* %437 to i16*
  %439 = load i16, i16* %438, align 2
  %440 = zext i16 %439 to i64
  %441 = load %struct.header_info*, %struct.header_info** %3, align 8
  %442 = getelementptr inbounds %struct.header_info, %struct.header_info* %441, i32 0, i32 4
  store i64 %440, i64* %442, align 8
  %443 = load %struct.header_info*, %struct.header_info** %3, align 8
  %444 = getelementptr inbounds %struct.header_info, %struct.header_info* %443, i32 0, i32 3
  store i64 1, i64* %444, align 8
  %445 = load %struct.header_info*, %struct.header_info** %3, align 8
  %446 = getelementptr inbounds %struct.header_info, %struct.header_info* %445, i32 0, i32 2
  store i64 0, i64* %446, align 8
  %447 = load %struct.header_info*, %struct.header_info** %3, align 8
  %448 = getelementptr inbounds %struct.header_info, %struct.header_info* %447, i32 0, i32 6
  store i64 5, i64* %448, align 8
  %449 = load %struct.header_info*, %struct.header_info** %3, align 8
  %450 = getelementptr inbounds %struct.header_info, %struct.header_info* %449, i32 0, i32 5
  store i64 4, i64* %450, align 8
  %451 = load %struct.header_info*, %struct.header_info** %3, align 8
  %452 = getelementptr inbounds %struct.header_info, %struct.header_info* %451, i32 0, i32 1
  store i64 4, i64* %452, align 8
  store i32 0, i32* %66, align 4
  br label %526

453:                                              ; preds = %116
  %454 = load %struct.header_info*, %struct.header_info** %64, align 8
  %455 = load i8*, i8** %65, align 8
  store %struct.header_info* %454, %struct.header_info** %53, align 8
  store i8* %455, i8** %54, align 8
  %456 = load %struct.header_info*, %struct.header_info** %53, align 8
  %457 = bitcast [32 x i8]* %55 to i8*
  %458 = load i8*, i8** %54, align 8
  store %struct.header_info* %456, %struct.header_info** %47, align 8
  store i8* %457, i8** %48, align 8
  store i64 1, i64* %49, align 8
  store i64 32, i64* %50, align 8
  store i8* %458, i8** %51, align 8
  %459 = load i8*, i8** %48, align 8
  %460 = load i8*, i8** %51, align 8
  %461 = load %struct.header_info*, %struct.header_info** %47, align 8
  %462 = getelementptr inbounds %struct.header_info, %struct.header_info* %461, i32 0, i32 1
  %463 = load i64, i64* %462, align 8
  %464 = getelementptr inbounds i8, i8* %460, i64 %463
  %465 = load i64, i64* %49, align 8
  %466 = load i64, i64* %50, align 8
  %467 = mul i64 %465, %466
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %459, i8* align 1 %464, i64 %467, i1 false) #7
  %468 = load i64, i64* %49, align 8
  %469 = load i64, i64* %50, align 8
  %470 = mul i64 %468, %469
  %471 = load %struct.header_info*, %struct.header_info** %47, align 8
  %472 = getelementptr inbounds %struct.header_info, %struct.header_info* %471, i32 0, i32 1
  %473 = load i64, i64* %472, align 8
  %474 = add i64 %473, %470
  store i64 %474, i64* %472, align 8
  %475 = load i64, i64* %49, align 8
  %476 = load i64, i64* %50, align 8
  %477 = mul i64 %475, %476
  %478 = icmp ne i64 %477, 32
  br i1 %478, label %479, label %482

479:                                              ; preds = %453
  %480 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.7, i64 0, i64 0))
  %481 = sext i32 %480 to i64
  store i64 %481, i64* @order_gurantee3, align 8
  store i32 -1, i32* %52, align 4
  br label %493

482:                                              ; preds = %453
  %483 = load %struct.header_info*, %struct.header_info** %53, align 8
  %484 = getelementptr inbounds %struct.header_info, %struct.header_info* %483, i32 0, i32 6
  store i64 4, i64* %484, align 8
  %485 = load %struct.header_info*, %struct.header_info** %53, align 8
  %486 = getelementptr inbounds %struct.header_info, %struct.header_info* %485, i32 0, i32 5
  store i64 10, i64* %486, align 8
  %487 = load %struct.header_info*, %struct.header_info** %53, align 8
  %488 = getelementptr inbounds %struct.header_info, %struct.header_info* %487, i32 0, i32 2
  store i64 1, i64* %488, align 8
  %489 = load %struct.header_info*, %struct.header_info** %53, align 8
  %490 = getelementptr inbounds %struct.header_info, %struct.header_info* %489, i32 0, i32 3
  store i64 1, i64* %490, align 8
  %491 = load %struct.header_info*, %struct.header_info** %53, align 8
  %492 = getelementptr inbounds %struct.header_info, %struct.header_info* %491, i32 0, i32 4
  store i64 0, i64* %492, align 8
  store i32 0, i32* %52, align 4
  br label %493

493:                                              ; preds = %479, %482
  %494 = load i32, i32* %52, align 4
  store i32 %494, i32* %66, align 4
  br label %526

495:                                              ; preds = %116
  %496 = load %struct.header_info*, %struct.header_info** %64, align 8
  store %struct.header_info* %496, %struct.header_info** %56, align 8
  %497 = load %struct.header_info*, %struct.header_info** %56, align 8
  %498 = getelementptr inbounds %struct.header_info, %struct.header_info* %497, i32 0, i32 6
  store i64 4, i64* %498, align 8
  %499 = load %struct.header_info*, %struct.header_info** %56, align 8
  %500 = getelementptr inbounds %struct.header_info, %struct.header_info* %499, i32 0, i32 5
  store i64 10, i64* %500, align 8
  %501 = load %struct.header_info*, %struct.header_info** %56, align 8
  %502 = getelementptr inbounds %struct.header_info, %struct.header_info* %501, i32 0, i32 2
  store i64 1, i64* %502, align 8
  %503 = load %struct.header_info*, %struct.header_info** %56, align 8
  %504 = getelementptr inbounds %struct.header_info, %struct.header_info* %503, i32 0, i32 3
  store i64 1, i64* %504, align 8
  %505 = load %struct.header_info*, %struct.header_info** %56, align 8
  %506 = getelementptr inbounds %struct.header_info, %struct.header_info* %505, i32 0, i32 4
  store i64 0, i64* %506, align 8
  store i32 0, i32* %66, align 4
  br label %526

507:                                              ; preds = %116
  %508 = load %struct.header_info*, %struct.header_info** %64, align 8
  store %struct.header_info* %508, %struct.header_info** %57, align 8
  %509 = load %struct.header_info*, %struct.header_info** %57, align 8
  %510 = getelementptr inbounds %struct.header_info, %struct.header_info* %509, i32 0, i32 4
  store i64 0, i64* %510, align 8
  %511 = load %struct.header_info*, %struct.header_info** %57, align 8
  %512 = getelementptr inbounds %struct.header_info, %struct.header_info* %511, i32 0, i32 2
  store i64 1, i64* %512, align 8
  %513 = load %struct.header_info*, %struct.header_info** %57, align 8
  %514 = getelementptr inbounds %struct.header_info, %struct.header_info* %513, i32 0, i32 3
  store i64 1, i64* %514, align 8
  %515 = load %struct.header_info*, %struct.header_info** %57, align 8
  %516 = getelementptr inbounds %struct.header_info, %struct.header_info* %515, i32 0, i32 6
  store i64 6, i64* %516, align 8
  %517 = load %struct.header_info*, %struct.header_info** %57, align 8
  %518 = getelementptr inbounds %struct.header_info, %struct.header_info* %517, i32 0, i32 5
  store i64 8, i64* %518, align 8
  %519 = load %struct.header_info*, %struct.header_info** %57, align 8
  %520 = getelementptr inbounds %struct.header_info, %struct.header_info* %519, i32 0, i32 1
  store i64 0, i64* %520, align 8
  store i32 0, i32* %66, align 4
  br label %526

521:                                              ; preds = %116
  %522 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([93 x i8], [93 x i8]* @.str.11, i64 0, i64 0))
  %523 = sext i32 %522 to i64
  store i64 %523, i64* @order_gurantee3, align 8
  store i32 -2, i32* %66, align 4
  %524 = load %struct.header_info*, %struct.header_info** %64, align 8
  %525 = getelementptr inbounds %struct.header_info, %struct.header_info* %524, i32 0, i32 5
  store i64 1, i64* %525, align 8
  br label %526

526:                                              ; preds = %116, %521, %507, %495, %493, %434, %432, %378, %376
  %527 = load %struct.header_info*, %struct.header_info** %64, align 8
  %528 = getelementptr inbounds %struct.header_info, %struct.header_info* %527, i32 0, i32 1
  %529 = load i64, i64* %528, align 8
  %530 = load %struct.header_info*, %struct.header_info** %64, align 8
  %531 = getelementptr inbounds %struct.header_info, %struct.header_info* %530, i32 0, i32 0
  store i64 %529, i64* %531, align 8
  %532 = load i32, i32* %66, align 4
  store i32 %532, i32* %63, align 4
  br label %533

533:                                              ; preds = %526, %93
  %534 = load i32, i32* %63, align 4
  ret i32 %534
}

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { alwaysinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind }
attributes #8 = { nounwind readonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 11.1.0-6"}
