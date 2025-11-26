; ModuleID = 'etabackend/cpp/PARSE_TimeTags.cpp'
source_filename = "etabackend/cpp/PARSE_TimeTags.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ttf_reader = type { i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i8* }
%union.anon = type { i32 }
%struct.anon = type { i32 }
%union.anon.0 = type { i64 }
%struct.anon.1 = type { i32 }
%union.anon.2 = type { i32 }
%struct.anon.3 = type { i32 }
%struct.anon.4 = type { i32 }
%union.anon.5 = type { i32 }
%struct.anon.6 = type { i32 }
%struct.TTTRRecord = type { i64, i16 }
%struct.SITTTRStruct = type { i32, i32, i64 }
%union.COMPTTTRRecord = type { %struct.anon.7 }
%struct.anon.7 = type { i40 }
%union.bh4bytesRec = type { i32 }
%struct.ETA033Struct = type { i32, i32 }
%struct.anon.8 = type { i32 }

@order_gurantee = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [30 x i8] c"\0A [FATAL] Illegal Chan:  %1u\0A\00", align 1
@.str.1 = private unnamed_addr constant [40 x i8] c"\0A [FATAL]\0AIllegal virtual_channel:  %1u\00", align 1
@.str.2 = private unnamed_addr constant [44 x i8] c"\0A [ERROR]ERROR: Unsupported timetag format.\00", align 1

; Function Attrs: alwaysinline uwtable
define dso_local void @ProcessPHT2(%struct.ttf_reader* %0, i32 %1, i64* nonnull align 8 dereferenceable(8) %2, i8* nonnull align 1 dereferenceable(1) %3, i64* nonnull align 8 dereferenceable(8) %4) #0 {
  %6 = alloca %struct.ttf_reader*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i64*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i64*, align 8
  %11 = alloca i32, align 4
  %12 = alloca i64, align 8
  %13 = alloca %union.anon, align 4
  %14 = alloca i32, align 4
  store %struct.ttf_reader* %0, %struct.ttf_reader** %6, align 8
  store i32 %1, i32* %7, align 4
  store i64* %2, i64** %8, align 8
  store i8* %3, i8** %9, align 8
  store i64* %4, i64** %10, align 8
  store i32 210698240, i32* %11, align 4
  %15 = load i32, i32* %7, align 4
  %16 = bitcast %union.anon* %13 to i32*
  store i32 %15, i32* %16, align 4
  %17 = bitcast %union.anon* %13 to %struct.anon*
  %18 = bitcast %struct.anon* %17 to i32*
  %19 = load i32, i32* %18, align 4
  %20 = lshr i32 %19, 28
  %21 = icmp eq i32 %20, 15
  br i1 %21, label %22, label %59

22:                                               ; preds = %5
  %23 = bitcast %union.anon* %13 to %struct.anon*
  %24 = bitcast %struct.anon* %23 to i32*
  %25 = load i32, i32* %24, align 4
  %26 = and i32 %25, 268435455
  %27 = and i32 %26, 15
  store i32 %27, i32* %14, align 4
  %28 = load i32, i32* %14, align 4
  %29 = icmp eq i32 %28, 0
  br i1 %29, label %30, label %34

30:                                               ; preds = %22
  %31 = load i64*, i64** %10, align 8
  %32 = load i64, i64* %31, align 8
  %33 = add nsw i64 %32, 210698240
  store i64 %33, i64* %31, align 8
  br label %58

34:                                               ; preds = %22
  %35 = load i64*, i64** %10, align 8
  %36 = load i64, i64* %35, align 8
  %37 = bitcast %union.anon* %13 to %struct.anon*
  %38 = bitcast %struct.anon* %37 to i32*
  %39 = load i32, i32* %38, align 4
  %40 = and i32 %39, 268435455
  %41 = zext i32 %40 to i64
  %42 = add nsw i64 %36, %41
  store i64 %42, i64* %12, align 8
  %43 = load i64, i64* %12, align 8
  %44 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %45 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %44, i32 0, i32 2
  %46 = load i64, i64* %45, align 8
  %47 = mul nsw i64 %43, %46
  %48 = load i64*, i64** %8, align 8
  store i64 %47, i64* %48, align 8
  %49 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %50 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %49, i32 0, i32 9
  %51 = load i64, i64* %50, align 8
  %52 = load i32, i32* %14, align 4
  %53 = call i32 @llvm.cttz.i32(i32 %52, i1 true)
  %54 = sext i32 %53 to i64
  %55 = add nsw i64 %51, %54
  %56 = trunc i64 %55 to i8
  %57 = load i8*, i8** %9, align 8
  store i8 %56, i8* %57, align 1
  br label %58

58:                                               ; preds = %34, %30
  br label %102

59:                                               ; preds = %5
  %60 = bitcast %union.anon* %13 to %struct.anon*
  %61 = bitcast %struct.anon* %60 to i32*
  %62 = load i32, i32* %61, align 4
  %63 = lshr i32 %62, 28
  %64 = icmp sgt i32 %63, 4
  br i1 %64, label %65, label %75

65:                                               ; preds = %59
  %66 = bitcast %union.anon* %13 to %struct.anon*
  %67 = bitcast %struct.anon* %66 to i32*
  %68 = load i32, i32* %67, align 4
  %69 = lshr i32 %68, 28
  %70 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str, i64 0, i64 0), i32 %69)
  %71 = sext i32 %70 to i64
  store i64 %71, i64* @order_gurantee, align 8
  br label %72

72:                                               ; preds = %65, %72
  %73 = load i64, i64* @order_gurantee, align 8
  %74 = add nsw i64 %73, 1
  store i64 %74, i64* @order_gurantee, align 8
  br label %72

75:                                               ; preds = %59
  %76 = load i64*, i64** %10, align 8
  %77 = load i64, i64* %76, align 8
  %78 = bitcast %union.anon* %13 to %struct.anon*
  %79 = bitcast %struct.anon* %78 to i32*
  %80 = load i32, i32* %79, align 4
  %81 = and i32 %80, 268435455
  %82 = zext i32 %81 to i64
  %83 = add nsw i64 %77, %82
  store i64 %83, i64* %12, align 8
  %84 = load i64, i64* %12, align 8
  %85 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %86 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %85, i32 0, i32 2
  %87 = load i64, i64* %86, align 8
  %88 = mul nsw i64 %84, %87
  %89 = load i64*, i64** %8, align 8
  store i64 %88, i64* %89, align 8
  %90 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %91 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %90, i32 0, i32 8
  %92 = load i64, i64* %91, align 8
  %93 = bitcast %union.anon* %13 to %struct.anon*
  %94 = bitcast %struct.anon* %93 to i32*
  %95 = load i32, i32* %94, align 4
  %96 = lshr i32 %95, 28
  %97 = zext i32 %96 to i64
  %98 = add nsw i64 %92, %97
  %99 = trunc i64 %98 to i8
  %100 = load i8*, i8** %9, align 8
  store i8 %99, i8* %100, align 1
  br label %101

101:                                              ; preds = %75
  br label %102

102:                                              ; preds = %101, %58
  ret void
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.cttz.i32(i32, i1 immarg) #1

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: alwaysinline nounwind uwtable
define dso_local void @ProcessHHT2(%struct.ttf_reader* %0, i32 %1, i32 %2, i64* nonnull align 8 dereferenceable(8) %3, i8* nonnull align 1 dereferenceable(1) %4, i64* nonnull align 8 dereferenceable(8) %5) #3 {
  %7 = alloca %struct.ttf_reader*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i64*, align 8
  %11 = alloca i8*, align 8
  %12 = alloca i64*, align 8
  %13 = alloca i64, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca %union.anon.0, align 8
  store %struct.ttf_reader* %0, %struct.ttf_reader** %7, align 8
  store i32 %1, i32* %8, align 4
  store i32 %2, i32* %9, align 4
  store i64* %3, i64** %10, align 8
  store i8* %4, i8** %11, align 8
  store i64* %5, i64** %12, align 8
  store i32 33552000, i32* %14, align 4
  store i32 33554432, i32* %15, align 4
  %17 = load i32, i32* %8, align 4
  %18 = zext i32 %17 to i64
  %19 = bitcast %union.anon.0* %16 to i64*
  store i64 %18, i64* %19, align 8
  %20 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %21 = bitcast %struct.anon.1* %20 to i32*
  %22 = load i32, i32* %21, align 8
  %23 = lshr i32 %22, 31
  %24 = icmp eq i32 %23, 1
  br i1 %24, label %25, label %132

25:                                               ; preds = %6
  %26 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %27 = bitcast %struct.anon.1* %26 to i32*
  %28 = load i32, i32* %27, align 8
  %29 = lshr i32 %28, 25
  %30 = and i32 %29, 63
  %31 = icmp eq i32 %30, 63
  br i1 %31, label %32, label %61

32:                                               ; preds = %25
  %33 = load i32, i32* %9, align 4
  %34 = icmp eq i32 %33, 1
  br i1 %34, label %35, label %39

35:                                               ; preds = %32
  %36 = load i64*, i64** %12, align 8
  %37 = load i64, i64* %36, align 8
  %38 = add i64 %37, 33552000
  store i64 %38, i64* %36, align 8
  br label %60

39:                                               ; preds = %32
  %40 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %41 = bitcast %struct.anon.1* %40 to i32*
  %42 = load i32, i32* %41, align 8
  %43 = and i32 %42, 33554431
  %44 = icmp eq i32 %43, 0
  br i1 %44, label %45, label %49

45:                                               ; preds = %39
  %46 = load i64*, i64** %12, align 8
  %47 = load i64, i64* %46, align 8
  %48 = add i64 %47, 33554432
  store i64 %48, i64* %46, align 8
  br label %59

49:                                               ; preds = %39
  %50 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %51 = bitcast %struct.anon.1* %50 to i32*
  %52 = load i32, i32* %51, align 8
  %53 = and i32 %52, 33554431
  %54 = zext i32 %53 to i64
  %55 = mul i64 33554432, %54
  %56 = load i64*, i64** %12, align 8
  %57 = load i64, i64* %56, align 8
  %58 = add i64 %57, %55
  store i64 %58, i64* %56, align 8
  br label %59

59:                                               ; preds = %49, %45
  br label %60

60:                                               ; preds = %59, %35
  br label %61

61:                                               ; preds = %60, %25
  %62 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %63 = bitcast %struct.anon.1* %62 to i32*
  %64 = load i32, i32* %63, align 8
  %65 = lshr i32 %64, 25
  %66 = and i32 %65, 63
  %67 = icmp sge i32 %66, 1
  br i1 %67, label %68, label %103

68:                                               ; preds = %61
  %69 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %70 = bitcast %struct.anon.1* %69 to i32*
  %71 = load i32, i32* %70, align 8
  %72 = lshr i32 %71, 25
  %73 = and i32 %72, 63
  %74 = icmp sle i32 %73, 15
  br i1 %74, label %75, label %103

75:                                               ; preds = %68
  %76 = load i64*, i64** %12, align 8
  %77 = load i64, i64* %76, align 8
  %78 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %79 = bitcast %struct.anon.1* %78 to i32*
  %80 = load i32, i32* %79, align 8
  %81 = and i32 %80, 33554431
  %82 = zext i32 %81 to i64
  %83 = add nsw i64 %77, %82
  store i64 %83, i64* %13, align 8
  %84 = load i64, i64* %13, align 8
  %85 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %86 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %85, i32 0, i32 2
  %87 = load i64, i64* %86, align 8
  %88 = mul nsw i64 %84, %87
  %89 = load i64*, i64** %10, align 8
  store i64 %88, i64* %89, align 8
  %90 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %91 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %90, i32 0, i32 9
  %92 = load i64, i64* %91, align 8
  %93 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %94 = bitcast %struct.anon.1* %93 to i32*
  %95 = load i32, i32* %94, align 8
  %96 = lshr i32 %95, 25
  %97 = and i32 %96, 63
  %98 = call i32 @llvm.cttz.i32(i32 %97, i1 true)
  %99 = sext i32 %98 to i64
  %100 = add nsw i64 %92, %99
  %101 = trunc i64 %100 to i8
  %102 = load i8*, i8** %11, align 8
  store i8 %101, i8* %102, align 1
  br label %103

103:                                              ; preds = %75, %68, %61
  %104 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %105 = bitcast %struct.anon.1* %104 to i32*
  %106 = load i32, i32* %105, align 8
  %107 = lshr i32 %106, 25
  %108 = and i32 %107, 63
  %109 = icmp eq i32 %108, 0
  br i1 %109, label %110, label %131

110:                                              ; preds = %103
  %111 = load i64*, i64** %12, align 8
  %112 = load i64, i64* %111, align 8
  %113 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %114 = bitcast %struct.anon.1* %113 to i32*
  %115 = load i32, i32* %114, align 8
  %116 = and i32 %115, 33554431
  %117 = zext i32 %116 to i64
  %118 = add nsw i64 %112, %117
  store i64 %118, i64* %13, align 8
  %119 = load i64, i64* %13, align 8
  %120 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %121 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %120, i32 0, i32 2
  %122 = load i64, i64* %121, align 8
  %123 = mul nsw i64 %119, %122
  %124 = load i64*, i64** %10, align 8
  store i64 %123, i64* %124, align 8
  %125 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %126 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %125, i32 0, i32 8
  %127 = load i64, i64* %126, align 8
  %128 = add nsw i64 %127, 0
  %129 = trunc i64 %128 to i8
  %130 = load i8*, i8** %11, align 8
  store i8 %129, i8* %130, align 1
  br label %131

131:                                              ; preds = %110, %103
  br label %160

132:                                              ; preds = %6
  %133 = load i64*, i64** %12, align 8
  %134 = load i64, i64* %133, align 8
  %135 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %136 = bitcast %struct.anon.1* %135 to i32*
  %137 = load i32, i32* %136, align 8
  %138 = and i32 %137, 33554431
  %139 = zext i32 %138 to i64
  %140 = add nsw i64 %134, %139
  store i64 %140, i64* %13, align 8
  %141 = load i64, i64* %13, align 8
  %142 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %143 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %142, i32 0, i32 2
  %144 = load i64, i64* %143, align 8
  %145 = mul nsw i64 %141, %144
  %146 = load i64*, i64** %10, align 8
  store i64 %145, i64* %146, align 8
  %147 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %148 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %147, i32 0, i32 8
  %149 = load i64, i64* %148, align 8
  %150 = bitcast %union.anon.0* %16 to %struct.anon.1*
  %151 = bitcast %struct.anon.1* %150 to i32*
  %152 = load i32, i32* %151, align 8
  %153 = lshr i32 %152, 25
  %154 = and i32 %153, 63
  %155 = zext i32 %154 to i64
  %156 = add nsw i64 %149, %155
  %157 = add nsw i64 %156, 1
  %158 = trunc i64 %157 to i8
  %159 = load i8*, i8** %11, align 8
  store i8 %158, i8* %159, align 1
  br label %160

160:                                              ; preds = %132, %131
  ret void
}

; Function Attrs: alwaysinline uwtable
define dso_local void @ProcessPHT3(%struct.ttf_reader* %0, i32 %1, i64* nonnull align 8 dereferenceable(8) %2, i8* nonnull align 1 dereferenceable(1) %3, i64* nonnull align 8 dereferenceable(8) %4) #0 {
  %6 = alloca %struct.ttf_reader*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i64*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i64*, align 8
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  %13 = alloca %union.anon.2, align 4
  store %struct.ttf_reader* %0, %struct.ttf_reader** %6, align 8
  store i32 %1, i32* %7, align 4
  store i64* %2, i64** %8, align 8
  store i8* %3, i8** %9, align 8
  store i64* %4, i64** %10, align 8
  store i32 65536, i32* %12, align 4
  %14 = load i32, i32* %7, align 4
  %15 = bitcast %union.anon.2* %13 to i32*
  store i32 %14, i32* %15, align 4
  %16 = bitcast %union.anon.2* %13 to %struct.anon.3*
  %17 = bitcast %struct.anon.3* %16 to i32*
  %18 = load i32, i32* %17, align 4
  %19 = lshr i32 %18, 28
  %20 = icmp eq i32 %19, 15
  br i1 %20, label %21, label %66

21:                                               ; preds = %5
  %22 = bitcast %union.anon.2* %13 to %struct.anon.4*
  %23 = bitcast %struct.anon.4* %22 to i32*
  %24 = load i32, i32* %23, align 4
  %25 = lshr i32 %24, 16
  %26 = and i32 %25, 4095
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %32

28:                                               ; preds = %21
  %29 = load i64*, i64** %10, align 8
  %30 = load i64, i64* %29, align 8
  %31 = add nsw i64 %30, 65536
  store i64 %31, i64* %29, align 8
  br label %65

32:                                               ; preds = %21
  %33 = load i64*, i64** %10, align 8
  %34 = load i64, i64* %33, align 8
  %35 = bitcast %union.anon.2* %13 to %struct.anon.3*
  %36 = bitcast %struct.anon.3* %35 to i32*
  %37 = load i32, i32* %36, align 4
  %38 = and i32 %37, 65535
  %39 = zext i32 %38 to i64
  %40 = add nsw i64 %34, %39
  store i64 %40, i64* %11, align 8
  %41 = load i64, i64* %11, align 8
  %42 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %43 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %42, i32 0, i32 4
  %44 = load i64, i64* %43, align 8
  %45 = mul nsw i64 %41, %44
  %46 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %47 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %46, i32 0, i32 3
  %48 = load i64, i64* %47, align 8
  %49 = mul nsw i64 0, %48
  %50 = add nsw i64 %45, %49
  %51 = load i64*, i64** %8, align 8
  store i64 %50, i64* %51, align 8
  %52 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %53 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %52, i32 0, i32 9
  %54 = load i64, i64* %53, align 8
  %55 = bitcast %union.anon.2* %13 to %struct.anon.4*
  %56 = bitcast %struct.anon.4* %55 to i32*
  %57 = load i32, i32* %56, align 4
  %58 = lshr i32 %57, 16
  %59 = and i32 %58, 4095
  %60 = call i32 @llvm.cttz.i32(i32 %59, i1 true)
  %61 = sext i32 %60 to i64
  %62 = add nsw i64 %54, %61
  %63 = trunc i64 %62 to i8
  %64 = load i8*, i8** %9, align 8
  store i8 %63, i8* %64, align 1
  br label %65

65:                                               ; preds = %32, %28
  br label %125

66:                                               ; preds = %5
  %67 = bitcast %union.anon.2* %13 to %struct.anon.3*
  %68 = bitcast %struct.anon.3* %67 to i32*
  %69 = load i32, i32* %68, align 4
  %70 = lshr i32 %69, 28
  %71 = icmp eq i32 %70, 0
  br i1 %71, label %78, label %72

72:                                               ; preds = %66
  %73 = bitcast %union.anon.2* %13 to %struct.anon.3*
  %74 = bitcast %struct.anon.3* %73 to i32*
  %75 = load i32, i32* %74, align 4
  %76 = lshr i32 %75, 28
  %77 = icmp sgt i32 %76, 4
  br i1 %77, label %78, label %88

78:                                               ; preds = %72, %66
  %79 = bitcast %union.anon.2* %13 to %struct.anon.3*
  %80 = bitcast %struct.anon.3* %79 to i32*
  %81 = load i32, i32* %80, align 4
  %82 = lshr i32 %81, 28
  %83 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.1, i64 0, i64 0), i32 %82)
  %84 = sext i32 %83 to i64
  store i64 %84, i64* @order_gurantee, align 8
  br label %85

85:                                               ; preds = %78, %85
  %86 = load i64, i64* @order_gurantee, align 8
  %87 = add nsw i64 %86, 1
  store i64 %87, i64* @order_gurantee, align 8
  br label %85

88:                                               ; preds = %72
  %89 = load i64*, i64** %10, align 8
  %90 = load i64, i64* %89, align 8
  %91 = bitcast %union.anon.2* %13 to %struct.anon.3*
  %92 = bitcast %struct.anon.3* %91 to i32*
  %93 = load i32, i32* %92, align 4
  %94 = and i32 %93, 65535
  %95 = zext i32 %94 to i64
  %96 = add nsw i64 %90, %95
  store i64 %96, i64* %11, align 8
  %97 = load i64, i64* %11, align 8
  %98 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %99 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %98, i32 0, i32 4
  %100 = load i64, i64* %99, align 8
  %101 = mul nsw i64 %97, %100
  %102 = bitcast %union.anon.2* %13 to %struct.anon.3*
  %103 = bitcast %struct.anon.3* %102 to i32*
  %104 = load i32, i32* %103, align 4
  %105 = lshr i32 %104, 16
  %106 = and i32 %105, 4095
  %107 = zext i32 %106 to i64
  %108 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %109 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %108, i32 0, i32 3
  %110 = load i64, i64* %109, align 8
  %111 = mul nsw i64 %107, %110
  %112 = add nsw i64 %101, %111
  %113 = load i64*, i64** %8, align 8
  store i64 %112, i64* %113, align 8
  %114 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %115 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %114, i32 0, i32 8
  %116 = load i64, i64* %115, align 8
  %117 = bitcast %union.anon.2* %13 to %struct.anon.3*
  %118 = bitcast %struct.anon.3* %117 to i32*
  %119 = load i32, i32* %118, align 4
  %120 = lshr i32 %119, 28
  %121 = zext i32 %120 to i64
  %122 = add nsw i64 %116, %121
  %123 = trunc i64 %122 to i8
  %124 = load i8*, i8** %9, align 8
  store i8 %123, i8* %124, align 1
  br label %125

125:                                              ; preds = %88, %65
  ret void
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local void @ProcessHHT3(%struct.ttf_reader* %0, i32 %1, i32 %2, i64* nonnull align 8 dereferenceable(8) %3, i8* nonnull align 1 dereferenceable(1) %4, i64* nonnull align 8 dereferenceable(8) %5) #3 {
  %7 = alloca %struct.ttf_reader*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i64*, align 8
  %11 = alloca i8*, align 8
  %12 = alloca i64*, align 8
  %13 = alloca i32, align 4
  %14 = alloca %union.anon.5, align 4
  store %struct.ttf_reader* %0, %struct.ttf_reader** %7, align 8
  store i32 %1, i32* %8, align 4
  store i32 %2, i32* %9, align 4
  store i64* %3, i64** %10, align 8
  store i8* %4, i8** %11, align 8
  store i64* %5, i64** %12, align 8
  store i32 1024, i32* %13, align 4
  %15 = load i32, i32* %8, align 4
  %16 = bitcast %union.anon.5* %14 to i32*
  store i32 %15, i32* %16, align 4
  %17 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %18 = bitcast %struct.anon.6* %17 to i32*
  %19 = load i32, i32* %18, align 4
  %20 = lshr i32 %19, 31
  %21 = icmp eq i32 %20, 1
  br i1 %21, label %22, label %100

22:                                               ; preds = %6
  %23 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %24 = bitcast %struct.anon.6* %23 to i32*
  %25 = load i32, i32* %24, align 4
  %26 = lshr i32 %25, 25
  %27 = and i32 %26, 63
  %28 = icmp eq i32 %27, 63
  br i1 %28, label %29, label %53

29:                                               ; preds = %22
  %30 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %31 = bitcast %struct.anon.6* %30 to i32*
  %32 = load i32, i32* %31, align 4
  %33 = and i32 %32, 1023
  %34 = icmp eq i32 %33, 0
  br i1 %34, label %38, label %35

35:                                               ; preds = %29
  %36 = load i32, i32* %9, align 4
  %37 = icmp eq i32 %36, 1
  br i1 %37, label %38, label %42

38:                                               ; preds = %35, %29
  %39 = load i64*, i64** %12, align 8
  %40 = load i64, i64* %39, align 8
  %41 = add i64 %40, 1024
  store i64 %41, i64* %39, align 8
  br label %52

42:                                               ; preds = %35
  %43 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %44 = bitcast %struct.anon.6* %43 to i32*
  %45 = load i32, i32* %44, align 4
  %46 = and i32 %45, 1023
  %47 = zext i32 %46 to i64
  %48 = mul i64 1024, %47
  %49 = load i64*, i64** %12, align 8
  %50 = load i64, i64* %49, align 8
  %51 = add i64 %50, %48
  store i64 %51, i64* %49, align 8
  br label %52

52:                                               ; preds = %42, %38
  br label %53

53:                                               ; preds = %52, %22
  %54 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %55 = bitcast %struct.anon.6* %54 to i32*
  %56 = load i32, i32* %55, align 4
  %57 = lshr i32 %56, 25
  %58 = and i32 %57, 63
  %59 = icmp sge i32 %58, 1
  br i1 %59, label %60, label %99

60:                                               ; preds = %53
  %61 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %62 = bitcast %struct.anon.6* %61 to i32*
  %63 = load i32, i32* %62, align 4
  %64 = lshr i32 %63, 25
  %65 = and i32 %64, 63
  %66 = icmp sle i32 %65, 15
  br i1 %66, label %67, label %99

67:                                               ; preds = %60
  %68 = load i64*, i64** %12, align 8
  %69 = load i64, i64* %68, align 8
  %70 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %71 = bitcast %struct.anon.6* %70 to i32*
  %72 = load i32, i32* %71, align 4
  %73 = and i32 %72, 1023
  %74 = zext i32 %73 to i64
  %75 = add nsw i64 %69, %74
  %76 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %77 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %76, i32 0, i32 4
  %78 = load i64, i64* %77, align 8
  %79 = mul nsw i64 %75, %78
  %80 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %81 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %80, i32 0, i32 3
  %82 = load i64, i64* %81, align 8
  %83 = mul nsw i64 0, %82
  %84 = add nsw i64 %79, %83
  %85 = load i64*, i64** %10, align 8
  store i64 %84, i64* %85, align 8
  %86 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %87 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %86, i32 0, i32 9
  %88 = load i64, i64* %87, align 8
  %89 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %90 = bitcast %struct.anon.6* %89 to i32*
  %91 = load i32, i32* %90, align 4
  %92 = lshr i32 %91, 25
  %93 = and i32 %92, 63
  %94 = call i32 @llvm.cttz.i32(i32 %93, i1 true)
  %95 = sext i32 %94 to i64
  %96 = add nsw i64 %88, %95
  %97 = trunc i64 %96 to i8
  %98 = load i8*, i8** %11, align 8
  store i8 %97, i8* %98, align 1
  br label %99

99:                                               ; preds = %67, %60, %53
  br label %137

100:                                              ; preds = %6
  %101 = load i64*, i64** %12, align 8
  %102 = load i64, i64* %101, align 8
  %103 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %104 = bitcast %struct.anon.6* %103 to i32*
  %105 = load i32, i32* %104, align 4
  %106 = and i32 %105, 1023
  %107 = zext i32 %106 to i64
  %108 = add nsw i64 %102, %107
  %109 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %110 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %109, i32 0, i32 4
  %111 = load i64, i64* %110, align 8
  %112 = mul nsw i64 %108, %111
  %113 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %114 = bitcast %struct.anon.6* %113 to i32*
  %115 = load i32, i32* %114, align 4
  %116 = lshr i32 %115, 10
  %117 = and i32 %116, 32767
  %118 = zext i32 %117 to i64
  %119 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %120 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %119, i32 0, i32 3
  %121 = load i64, i64* %120, align 8
  %122 = mul nsw i64 %118, %121
  %123 = add nsw i64 %112, %122
  %124 = load i64*, i64** %10, align 8
  store i64 %123, i64* %124, align 8
  %125 = load %struct.ttf_reader*, %struct.ttf_reader** %7, align 8
  %126 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %125, i32 0, i32 8
  %127 = load i64, i64* %126, align 8
  %128 = bitcast %union.anon.5* %14 to %struct.anon.6*
  %129 = bitcast %struct.anon.6* %128 to i32*
  %130 = load i32, i32* %129, align 4
  %131 = lshr i32 %130, 25
  %132 = and i32 %131, 63
  %133 = zext i32 %132 to i64
  %134 = add nsw i64 %127, %133
  %135 = trunc i64 %134 to i8
  %136 = load i8*, i8** %11, align 8
  store i8 %135, i8* %136, align 1
  br label %137

137:                                              ; preds = %100, %99
  ret void
}

; Function Attrs: alwaysinline uwtable
define dso_local i64 @FileReader_pop_event(%struct.ttf_reader* %0, i8 zeroext %1, i8* %2) #0 {
  %4 = alloca %struct.ttf_reader*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i64*, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i64*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %union.anon.5, align 4
  %12 = alloca %struct.ttf_reader*, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i64*, align 8
  %16 = alloca i8*, align 8
  %17 = alloca i64*, align 8
  %18 = alloca i64, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca %union.anon.0, align 8
  %22 = alloca %struct.ttf_reader*, align 8
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i64*, align 8
  %26 = alloca i8*, align 8
  %27 = alloca i64*, align 8
  %28 = alloca i32, align 4
  %29 = alloca %union.anon.5, align 4
  %30 = alloca %struct.ttf_reader*, align 8
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i64*, align 8
  %34 = alloca i8*, align 8
  %35 = alloca i64*, align 8
  %36 = alloca i64, align 8
  %37 = alloca i32, align 4
  %38 = alloca i32, align 4
  %39 = alloca %union.anon.0, align 8
  %40 = alloca %struct.ttf_reader*, align 8
  %41 = alloca i32, align 4
  %42 = alloca i64*, align 8
  %43 = alloca i8*, align 8
  %44 = alloca i64*, align 8
  %45 = alloca i64, align 8
  %46 = alloca i32, align 4
  %47 = alloca %union.anon.2, align 4
  %48 = alloca %struct.ttf_reader*, align 8
  %49 = alloca i32, align 4
  %50 = alloca i64*, align 8
  %51 = alloca i8*, align 8
  %52 = alloca i64*, align 8
  %53 = alloca i32, align 4
  %54 = alloca i64, align 8
  %55 = alloca %union.anon, align 4
  %56 = alloca i32, align 4
  %57 = alloca i64, align 8
  %58 = alloca %struct.ttf_reader*, align 8
  %59 = alloca i8, align 1
  %60 = alloca i8*, align 8
  %61 = alloca %struct.ttf_reader*, align 8
  %62 = alloca i64, align 8
  %63 = alloca i8, align 1
  %64 = alloca i64, align 8
  %65 = alloca i64, align 8
  %66 = alloca i64, align 8
  %67 = alloca i32, align 4
  %68 = alloca %struct.TTTRRecord, align 8
  %69 = alloca %struct.TTTRRecord*, align 8
  %70 = alloca %struct.SITTTRStruct*, align 8
  %71 = alloca %union.COMPTTTRRecord*, align 8
  %72 = alloca %union.bh4bytesRec*, align 8
  %73 = alloca %struct.ETA033Struct*, align 8
  %74 = alloca i32, align 4
  store %struct.ttf_reader* %0, %struct.ttf_reader** %58, align 8
  store i8 %1, i8* %59, align 1
  store i8* %2, i8** %60, align 8
  %75 = load %struct.ttf_reader*, %struct.ttf_reader** %58, align 8
  %76 = load i8, i8* %59, align 1
  %77 = zext i8 %76 to i64
  %78 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %75, i64 %77
  store %struct.ttf_reader* %78, %struct.ttf_reader** %61, align 8
  br label %79

79:                                               ; preds = %3, %1116
  store i64 9223372036854775807, i64* %62, align 8
  store i8 -1, i8* %63, align 1
  %80 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %81 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %80, i32 0, i32 11
  %82 = load i64, i64* %81, align 8
  %83 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %84 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %83, i32 0, i32 5
  %85 = load i64, i64* %84, align 8
  %86 = mul nsw i64 %82, %85
  store i64 %86, i64* %64, align 8
  %87 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %88 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %87, i32 0, i32 0
  %89 = load i64, i64* %88, align 8
  %90 = load i64, i64* %64, align 8
  %91 = add nsw i64 %89, %90
  store i64 %91, i64* %65, align 8
  %92 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %93 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %92, i32 0, i32 0
  %94 = load i64, i64* %93, align 8
  %95 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %96 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %95, i32 0, i32 10
  %97 = load i64, i64* %96, align 8
  %98 = add nsw i64 %94, %97
  store i64 %98, i64* %66, align 8
  %99 = load i64, i64* %64, align 8
  %100 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %101 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %100, i32 0, i32 10
  %102 = load i64, i64* %101, align 8
  %103 = icmp sge i64 %99, %102
  br i1 %103, label %104, label %105

104:                                              ; preds = %79
  br label %1125

105:                                              ; preds = %79
  %106 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %107 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %106, i32 0, i32 14
  %108 = load i8*, i8** %107, align 8
  %109 = bitcast i8* %108 to i32*
  %110 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %111 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %110, i32 0, i32 11
  %112 = load i64, i64* %111, align 8
  %113 = getelementptr inbounds i32, i32* %109, i64 %112
  %114 = load i32, i32* %113, align 4
  store i32 %114, i32* %67, align 4
  %115 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %116 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %115, i32 0, i32 6
  %117 = load i64, i64* %116, align 8
  switch i64 %117, label %1106 [
    i64 66051, label %118
    i64 66307, label %210
    i64 66052, label %325
    i64 66308, label %473
    i64 16843268, label %599
    i64 66053, label %599
    i64 66054, label %599
    i64 16843524, label %747
    i64 66309, label %747
    i64 66310, label %747
    i64 4, label %873
    i64 1, label %898
    i64 2, label %923
    i64 5, label %954
    i64 6, label %1048
  ]

118:                                              ; preds = %105
  %119 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %120 = load i32, i32* %67, align 4
  %121 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %122 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %121, i32 0, i32 12
  store %struct.ttf_reader* %119, %struct.ttf_reader** %48, align 8
  store i32 %120, i32* %49, align 4
  store i64* %62, i64** %50, align 8
  store i8* %63, i8** %51, align 8
  store i64* %122, i64** %52, align 8
  store i32 210698240, i32* %53, align 4
  %123 = load i32, i32* %49, align 4
  %124 = bitcast %union.anon* %55 to i32*
  store i32 %123, i32* %124, align 4
  %125 = bitcast %union.anon* %55 to %struct.anon*
  %126 = bitcast %struct.anon* %125 to i32*
  %127 = load i32, i32* %126, align 4
  %128 = lshr i32 %127, 28
  %129 = icmp eq i32 %128, 15
  br i1 %129, label %130, label %167

130:                                              ; preds = %118
  %131 = bitcast %union.anon* %55 to %struct.anon*
  %132 = bitcast %struct.anon* %131 to i32*
  %133 = load i32, i32* %132, align 4
  %134 = and i32 %133, 268435455
  %135 = and i32 %134, 15
  store i32 %135, i32* %56, align 4
  %136 = load i32, i32* %56, align 4
  %137 = icmp eq i32 %136, 0
  br i1 %137, label %138, label %142

138:                                              ; preds = %130
  %139 = load i64*, i64** %52, align 8
  %140 = load i64, i64* %139, align 8
  %141 = add nsw i64 %140, 210698240
  store i64 %141, i64* %139, align 8
  br label %166

142:                                              ; preds = %130
  %143 = load i64*, i64** %52, align 8
  %144 = load i64, i64* %143, align 8
  %145 = bitcast %union.anon* %55 to %struct.anon*
  %146 = bitcast %struct.anon* %145 to i32*
  %147 = load i32, i32* %146, align 4
  %148 = and i32 %147, 268435455
  %149 = zext i32 %148 to i64
  %150 = add nsw i64 %144, %149
  store i64 %150, i64* %54, align 8
  %151 = load i64, i64* %54, align 8
  %152 = load %struct.ttf_reader*, %struct.ttf_reader** %48, align 8
  %153 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %152, i32 0, i32 2
  %154 = load i64, i64* %153, align 8
  %155 = mul nsw i64 %151, %154
  %156 = load i64*, i64** %50, align 8
  store i64 %155, i64* %156, align 8
  %157 = load %struct.ttf_reader*, %struct.ttf_reader** %48, align 8
  %158 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %157, i32 0, i32 9
  %159 = load i64, i64* %158, align 8
  %160 = load i32, i32* %56, align 4
  %161 = call i32 @llvm.cttz.i32(i32 %160, i1 true)
  %162 = sext i32 %161 to i64
  %163 = add nsw i64 %159, %162
  %164 = trunc i64 %163 to i8
  %165 = load i8*, i8** %51, align 8
  store i8 %164, i8* %165, align 1
  br label %166

166:                                              ; preds = %142, %138
  br label %209

167:                                              ; preds = %118
  %168 = bitcast %union.anon* %55 to %struct.anon*
  %169 = bitcast %struct.anon* %168 to i32*
  %170 = load i32, i32* %169, align 4
  %171 = lshr i32 %170, 28
  %172 = icmp sgt i32 %171, 4
  br i1 %172, label %173, label %183

173:                                              ; preds = %167
  %174 = bitcast %union.anon* %55 to %struct.anon*
  %175 = bitcast %struct.anon* %174 to i32*
  %176 = load i32, i32* %175, align 4
  %177 = lshr i32 %176, 28
  %178 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str, i64 0, i64 0), i32 %177)
  %179 = sext i32 %178 to i64
  store i64 %179, i64* @order_gurantee, align 8
  br label %180

180:                                              ; preds = %180, %173
  %181 = load i64, i64* @order_gurantee, align 8
  %182 = add nsw i64 %181, 1
  store i64 %182, i64* @order_gurantee, align 8
  br label %180

183:                                              ; preds = %167
  %184 = load i64*, i64** %52, align 8
  %185 = load i64, i64* %184, align 8
  %186 = bitcast %union.anon* %55 to %struct.anon*
  %187 = bitcast %struct.anon* %186 to i32*
  %188 = load i32, i32* %187, align 4
  %189 = and i32 %188, 268435455
  %190 = zext i32 %189 to i64
  %191 = add nsw i64 %185, %190
  store i64 %191, i64* %54, align 8
  %192 = load i64, i64* %54, align 8
  %193 = load %struct.ttf_reader*, %struct.ttf_reader** %48, align 8
  %194 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %193, i32 0, i32 2
  %195 = load i64, i64* %194, align 8
  %196 = mul nsw i64 %192, %195
  %197 = load i64*, i64** %50, align 8
  store i64 %196, i64* %197, align 8
  %198 = load %struct.ttf_reader*, %struct.ttf_reader** %48, align 8
  %199 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %198, i32 0, i32 8
  %200 = load i64, i64* %199, align 8
  %201 = bitcast %union.anon* %55 to %struct.anon*
  %202 = bitcast %struct.anon* %201 to i32*
  %203 = load i32, i32* %202, align 4
  %204 = lshr i32 %203, 28
  %205 = zext i32 %204 to i64
  %206 = add nsw i64 %200, %205
  %207 = trunc i64 %206 to i8
  %208 = load i8*, i8** %51, align 8
  store i8 %207, i8* %208, align 1
  br label %209

209:                                              ; preds = %166, %183
  br label %1109

210:                                              ; preds = %105
  %211 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %212 = load i32, i32* %67, align 4
  %213 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %214 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %213, i32 0, i32 12
  store %struct.ttf_reader* %211, %struct.ttf_reader** %40, align 8
  store i32 %212, i32* %41, align 4
  store i64* %62, i64** %42, align 8
  store i8* %63, i8** %43, align 8
  store i64* %214, i64** %44, align 8
  store i32 65536, i32* %46, align 4
  %215 = load i32, i32* %41, align 4
  %216 = bitcast %union.anon.2* %47 to i32*
  store i32 %215, i32* %216, align 4
  %217 = bitcast %union.anon.2* %47 to %struct.anon.3*
  %218 = bitcast %struct.anon.3* %217 to i32*
  %219 = load i32, i32* %218, align 4
  %220 = lshr i32 %219, 28
  %221 = icmp eq i32 %220, 15
  br i1 %221, label %222, label %265

222:                                              ; preds = %210
  %223 = bitcast %union.anon.2* %47 to %struct.anon.4*
  %224 = bitcast %struct.anon.4* %223 to i32*
  %225 = load i32, i32* %224, align 4
  %226 = lshr i32 %225, 16
  %227 = and i32 %226, 4095
  %228 = icmp eq i32 %227, 0
  br i1 %228, label %229, label %233

229:                                              ; preds = %222
  %230 = load i64*, i64** %44, align 8
  %231 = load i64, i64* %230, align 8
  %232 = add nsw i64 %231, 65536
  store i64 %232, i64* %230, align 8
  br label %264

233:                                              ; preds = %222
  %234 = load i64*, i64** %44, align 8
  %235 = load i64, i64* %234, align 8
  %236 = bitcast %union.anon.2* %47 to %struct.anon.3*
  %237 = bitcast %struct.anon.3* %236 to i32*
  %238 = load i32, i32* %237, align 4
  %239 = and i32 %238, 65535
  %240 = zext i32 %239 to i64
  %241 = add nsw i64 %235, %240
  store i64 %241, i64* %45, align 8
  %242 = load i64, i64* %45, align 8
  %243 = load %struct.ttf_reader*, %struct.ttf_reader** %40, align 8
  %244 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %243, i32 0, i32 4
  %245 = load i64, i64* %244, align 8
  %246 = mul nsw i64 %242, %245
  %247 = load %struct.ttf_reader*, %struct.ttf_reader** %40, align 8
  %248 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %247, i32 0, i32 3
  %249 = load i64, i64* %248, align 8
  %250 = load i64*, i64** %42, align 8
  store i64 %246, i64* %250, align 8
  %251 = load %struct.ttf_reader*, %struct.ttf_reader** %40, align 8
  %252 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %251, i32 0, i32 9
  %253 = load i64, i64* %252, align 8
  %254 = bitcast %union.anon.2* %47 to %struct.anon.4*
  %255 = bitcast %struct.anon.4* %254 to i32*
  %256 = load i32, i32* %255, align 4
  %257 = lshr i32 %256, 16
  %258 = and i32 %257, 4095
  %259 = call i32 @llvm.cttz.i32(i32 %258, i1 true)
  %260 = sext i32 %259 to i64
  %261 = add nsw i64 %253, %260
  %262 = trunc i64 %261 to i8
  %263 = load i8*, i8** %43, align 8
  store i8 %262, i8* %263, align 1
  br label %264

264:                                              ; preds = %233, %229
  br label %324

265:                                              ; preds = %210
  %266 = bitcast %union.anon.2* %47 to %struct.anon.3*
  %267 = bitcast %struct.anon.3* %266 to i32*
  %268 = load i32, i32* %267, align 4
  %269 = lshr i32 %268, 28
  %270 = icmp eq i32 %269, 0
  br i1 %270, label %277, label %271

271:                                              ; preds = %265
  %272 = bitcast %union.anon.2* %47 to %struct.anon.3*
  %273 = bitcast %struct.anon.3* %272 to i32*
  %274 = load i32, i32* %273, align 4
  %275 = lshr i32 %274, 28
  %276 = icmp sgt i32 %275, 4
  br i1 %276, label %277, label %287

277:                                              ; preds = %271, %265
  %278 = bitcast %union.anon.2* %47 to %struct.anon.3*
  %279 = bitcast %struct.anon.3* %278 to i32*
  %280 = load i32, i32* %279, align 4
  %281 = lshr i32 %280, 28
  %282 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.1, i64 0, i64 0), i32 %281)
  %283 = sext i32 %282 to i64
  store i64 %283, i64* @order_gurantee, align 8
  br label %284

284:                                              ; preds = %284, %277
  %285 = load i64, i64* @order_gurantee, align 8
  %286 = add nsw i64 %285, 1
  store i64 %286, i64* @order_gurantee, align 8
  br label %284

287:                                              ; preds = %271
  %288 = load i64*, i64** %44, align 8
  %289 = load i64, i64* %288, align 8
  %290 = bitcast %union.anon.2* %47 to %struct.anon.3*
  %291 = bitcast %struct.anon.3* %290 to i32*
  %292 = load i32, i32* %291, align 4
  %293 = and i32 %292, 65535
  %294 = zext i32 %293 to i64
  %295 = add nsw i64 %289, %294
  store i64 %295, i64* %45, align 8
  %296 = load i64, i64* %45, align 8
  %297 = load %struct.ttf_reader*, %struct.ttf_reader** %40, align 8
  %298 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %297, i32 0, i32 4
  %299 = load i64, i64* %298, align 8
  %300 = mul nsw i64 %296, %299
  %301 = bitcast %union.anon.2* %47 to %struct.anon.3*
  %302 = bitcast %struct.anon.3* %301 to i32*
  %303 = load i32, i32* %302, align 4
  %304 = lshr i32 %303, 16
  %305 = and i32 %304, 4095
  %306 = zext i32 %305 to i64
  %307 = load %struct.ttf_reader*, %struct.ttf_reader** %40, align 8
  %308 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %307, i32 0, i32 3
  %309 = load i64, i64* %308, align 8
  %310 = mul nsw i64 %306, %309
  %311 = add nsw i64 %300, %310
  %312 = load i64*, i64** %42, align 8
  store i64 %311, i64* %312, align 8
  %313 = load %struct.ttf_reader*, %struct.ttf_reader** %40, align 8
  %314 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %313, i32 0, i32 8
  %315 = load i64, i64* %314, align 8
  %316 = bitcast %union.anon.2* %47 to %struct.anon.3*
  %317 = bitcast %struct.anon.3* %316 to i32*
  %318 = load i32, i32* %317, align 4
  %319 = lshr i32 %318, 28
  %320 = zext i32 %319 to i64
  %321 = add nsw i64 %315, %320
  %322 = trunc i64 %321 to i8
  %323 = load i8*, i8** %43, align 8
  store i8 %322, i8* %323, align 1
  br label %324

324:                                              ; preds = %264, %287
  br label %1109

325:                                              ; preds = %105
  %326 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %327 = load i32, i32* %67, align 4
  %328 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %329 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %328, i32 0, i32 12
  store %struct.ttf_reader* %326, %struct.ttf_reader** %30, align 8
  store i32 %327, i32* %31, align 4
  store i32 1, i32* %32, align 4
  store i64* %62, i64** %33, align 8
  store i8* %63, i8** %34, align 8
  store i64* %329, i64** %35, align 8
  store i32 33552000, i32* %37, align 4
  store i32 33554432, i32* %38, align 4
  %330 = load i32, i32* %31, align 4
  %331 = zext i32 %330 to i64
  %332 = bitcast %union.anon.0* %39 to i64*
  store i64 %331, i64* %332, align 8
  %333 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %334 = bitcast %struct.anon.1* %333 to i32*
  %335 = load i32, i32* %334, align 8
  %336 = lshr i32 %335, 31
  %337 = icmp eq i32 %336, 1
  br i1 %337, label %338, label %444

338:                                              ; preds = %325
  %339 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %340 = bitcast %struct.anon.1* %339 to i32*
  %341 = load i32, i32* %340, align 8
  %342 = lshr i32 %341, 25
  %343 = and i32 %342, 63
  %344 = icmp eq i32 %343, 63
  br i1 %344, label %345, label %374

345:                                              ; preds = %338
  %346 = load i32, i32* %32, align 4
  %347 = icmp eq i32 %346, 1
  br i1 %347, label %348, label %352

348:                                              ; preds = %345
  %349 = load i64*, i64** %35, align 8
  %350 = load i64, i64* %349, align 8
  %351 = add i64 %350, 33552000
  store i64 %351, i64* %349, align 8
  br label %373

352:                                              ; preds = %345
  %353 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %354 = bitcast %struct.anon.1* %353 to i32*
  %355 = load i32, i32* %354, align 8
  %356 = and i32 %355, 33554431
  %357 = icmp eq i32 %356, 0
  br i1 %357, label %358, label %362

358:                                              ; preds = %352
  %359 = load i64*, i64** %35, align 8
  %360 = load i64, i64* %359, align 8
  %361 = add i64 %360, 33554432
  store i64 %361, i64* %359, align 8
  br label %372

362:                                              ; preds = %352
  %363 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %364 = bitcast %struct.anon.1* %363 to i32*
  %365 = load i32, i32* %364, align 8
  %366 = and i32 %365, 33554431
  %367 = zext i32 %366 to i64
  %368 = mul i64 33554432, %367
  %369 = load i64*, i64** %35, align 8
  %370 = load i64, i64* %369, align 8
  %371 = add i64 %370, %368
  store i64 %371, i64* %369, align 8
  br label %372

372:                                              ; preds = %362, %358
  br label %373

373:                                              ; preds = %372, %348
  br label %374

374:                                              ; preds = %373, %338
  %375 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %376 = bitcast %struct.anon.1* %375 to i32*
  %377 = load i32, i32* %376, align 8
  %378 = lshr i32 %377, 25
  %379 = and i32 %378, 63
  %380 = icmp sge i32 %379, 1
  br i1 %380, label %381, label %416

381:                                              ; preds = %374
  %382 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %383 = bitcast %struct.anon.1* %382 to i32*
  %384 = load i32, i32* %383, align 8
  %385 = lshr i32 %384, 25
  %386 = and i32 %385, 63
  %387 = icmp sle i32 %386, 15
  br i1 %387, label %388, label %416

388:                                              ; preds = %381
  %389 = load i64*, i64** %35, align 8
  %390 = load i64, i64* %389, align 8
  %391 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %392 = bitcast %struct.anon.1* %391 to i32*
  %393 = load i32, i32* %392, align 8
  %394 = and i32 %393, 33554431
  %395 = zext i32 %394 to i64
  %396 = add nsw i64 %390, %395
  store i64 %396, i64* %36, align 8
  %397 = load i64, i64* %36, align 8
  %398 = load %struct.ttf_reader*, %struct.ttf_reader** %30, align 8
  %399 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %398, i32 0, i32 2
  %400 = load i64, i64* %399, align 8
  %401 = mul nsw i64 %397, %400
  %402 = load i64*, i64** %33, align 8
  store i64 %401, i64* %402, align 8
  %403 = load %struct.ttf_reader*, %struct.ttf_reader** %30, align 8
  %404 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %403, i32 0, i32 9
  %405 = load i64, i64* %404, align 8
  %406 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %407 = bitcast %struct.anon.1* %406 to i32*
  %408 = load i32, i32* %407, align 8
  %409 = lshr i32 %408, 25
  %410 = and i32 %409, 63
  %411 = call i32 @llvm.cttz.i32(i32 %410, i1 true) #4
  %412 = sext i32 %411 to i64
  %413 = add nsw i64 %405, %412
  %414 = trunc i64 %413 to i8
  %415 = load i8*, i8** %34, align 8
  store i8 %414, i8* %415, align 1
  br label %416

416:                                              ; preds = %388, %381, %374
  %417 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %418 = bitcast %struct.anon.1* %417 to i32*
  %419 = load i32, i32* %418, align 8
  %420 = lshr i32 %419, 25
  %421 = and i32 %420, 63
  %422 = icmp eq i32 %421, 0
  br i1 %422, label %423, label %443

423:                                              ; preds = %416
  %424 = load i64*, i64** %35, align 8
  %425 = load i64, i64* %424, align 8
  %426 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %427 = bitcast %struct.anon.1* %426 to i32*
  %428 = load i32, i32* %427, align 8
  %429 = and i32 %428, 33554431
  %430 = zext i32 %429 to i64
  %431 = add nsw i64 %425, %430
  store i64 %431, i64* %36, align 8
  %432 = load i64, i64* %36, align 8
  %433 = load %struct.ttf_reader*, %struct.ttf_reader** %30, align 8
  %434 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %433, i32 0, i32 2
  %435 = load i64, i64* %434, align 8
  %436 = mul nsw i64 %432, %435
  %437 = load i64*, i64** %33, align 8
  store i64 %436, i64* %437, align 8
  %438 = load %struct.ttf_reader*, %struct.ttf_reader** %30, align 8
  %439 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %438, i32 0, i32 8
  %440 = load i64, i64* %439, align 8
  %441 = trunc i64 %440 to i8
  %442 = load i8*, i8** %34, align 8
  store i8 %441, i8* %442, align 1
  br label %443

443:                                              ; preds = %423, %416
  br label %472

444:                                              ; preds = %325
  %445 = load i64*, i64** %35, align 8
  %446 = load i64, i64* %445, align 8
  %447 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %448 = bitcast %struct.anon.1* %447 to i32*
  %449 = load i32, i32* %448, align 8
  %450 = and i32 %449, 33554431
  %451 = zext i32 %450 to i64
  %452 = add nsw i64 %446, %451
  store i64 %452, i64* %36, align 8
  %453 = load i64, i64* %36, align 8
  %454 = load %struct.ttf_reader*, %struct.ttf_reader** %30, align 8
  %455 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %454, i32 0, i32 2
  %456 = load i64, i64* %455, align 8
  %457 = mul nsw i64 %453, %456
  %458 = load i64*, i64** %33, align 8
  store i64 %457, i64* %458, align 8
  %459 = load %struct.ttf_reader*, %struct.ttf_reader** %30, align 8
  %460 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %459, i32 0, i32 8
  %461 = load i64, i64* %460, align 8
  %462 = bitcast %union.anon.0* %39 to %struct.anon.1*
  %463 = bitcast %struct.anon.1* %462 to i32*
  %464 = load i32, i32* %463, align 8
  %465 = lshr i32 %464, 25
  %466 = and i32 %465, 63
  %467 = zext i32 %466 to i64
  %468 = add nsw i64 %461, %467
  %469 = add nsw i64 %468, 1
  %470 = trunc i64 %469 to i8
  %471 = load i8*, i8** %34, align 8
  store i8 %470, i8* %471, align 1
  br label %472

472:                                              ; preds = %443, %444
  br label %1109

473:                                              ; preds = %105
  %474 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %475 = load i32, i32* %67, align 4
  %476 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %477 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %476, i32 0, i32 12
  store %struct.ttf_reader* %474, %struct.ttf_reader** %4, align 8
  store i32 %475, i32* %5, align 4
  store i32 1, i32* %6, align 4
  store i64* %62, i64** %7, align 8
  store i8* %63, i8** %8, align 8
  store i64* %477, i64** %9, align 8
  store i32 1024, i32* %10, align 4
  %478 = load i32, i32* %5, align 4
  %479 = bitcast %union.anon.5* %11 to i32*
  store i32 %478, i32* %479, align 4
  %480 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %481 = bitcast %struct.anon.6* %480 to i32*
  %482 = load i32, i32* %481, align 4
  %483 = lshr i32 %482, 31
  %484 = icmp eq i32 %483, 1
  br i1 %484, label %485, label %561

485:                                              ; preds = %473
  %486 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %487 = bitcast %struct.anon.6* %486 to i32*
  %488 = load i32, i32* %487, align 4
  %489 = lshr i32 %488, 25
  %490 = and i32 %489, 63
  %491 = icmp eq i32 %490, 63
  br i1 %491, label %492, label %516

492:                                              ; preds = %485
  %493 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %494 = bitcast %struct.anon.6* %493 to i32*
  %495 = load i32, i32* %494, align 4
  %496 = and i32 %495, 1023
  %497 = icmp eq i32 %496, 0
  br i1 %497, label %501, label %498

498:                                              ; preds = %492
  %499 = load i32, i32* %6, align 4
  %500 = icmp eq i32 %499, 1
  br i1 %500, label %501, label %505

501:                                              ; preds = %498, %492
  %502 = load i64*, i64** %9, align 8
  %503 = load i64, i64* %502, align 8
  %504 = add i64 %503, 1024
  store i64 %504, i64* %502, align 8
  br label %515

505:                                              ; preds = %498
  %506 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %507 = bitcast %struct.anon.6* %506 to i32*
  %508 = load i32, i32* %507, align 4
  %509 = and i32 %508, 1023
  %510 = zext i32 %509 to i64
  %511 = mul i64 1024, %510
  %512 = load i64*, i64** %9, align 8
  %513 = load i64, i64* %512, align 8
  %514 = add i64 %513, %511
  store i64 %514, i64* %512, align 8
  br label %515

515:                                              ; preds = %505, %501
  br label %516

516:                                              ; preds = %515, %485
  %517 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %518 = bitcast %struct.anon.6* %517 to i32*
  %519 = load i32, i32* %518, align 4
  %520 = lshr i32 %519, 25
  %521 = and i32 %520, 63
  %522 = icmp sge i32 %521, 1
  br i1 %522, label %523, label %560

523:                                              ; preds = %516
  %524 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %525 = bitcast %struct.anon.6* %524 to i32*
  %526 = load i32, i32* %525, align 4
  %527 = lshr i32 %526, 25
  %528 = and i32 %527, 63
  %529 = icmp sle i32 %528, 15
  br i1 %529, label %530, label %560

530:                                              ; preds = %523
  %531 = load i64*, i64** %9, align 8
  %532 = load i64, i64* %531, align 8
  %533 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %534 = bitcast %struct.anon.6* %533 to i32*
  %535 = load i32, i32* %534, align 4
  %536 = and i32 %535, 1023
  %537 = zext i32 %536 to i64
  %538 = add nsw i64 %532, %537
  %539 = load %struct.ttf_reader*, %struct.ttf_reader** %4, align 8
  %540 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %539, i32 0, i32 4
  %541 = load i64, i64* %540, align 8
  %542 = mul nsw i64 %538, %541
  %543 = load %struct.ttf_reader*, %struct.ttf_reader** %4, align 8
  %544 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %543, i32 0, i32 3
  %545 = load i64, i64* %544, align 8
  %546 = load i64*, i64** %7, align 8
  store i64 %542, i64* %546, align 8
  %547 = load %struct.ttf_reader*, %struct.ttf_reader** %4, align 8
  %548 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %547, i32 0, i32 9
  %549 = load i64, i64* %548, align 8
  %550 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %551 = bitcast %struct.anon.6* %550 to i32*
  %552 = load i32, i32* %551, align 4
  %553 = lshr i32 %552, 25
  %554 = and i32 %553, 63
  %555 = call i32 @llvm.cttz.i32(i32 %554, i1 true) #4
  %556 = sext i32 %555 to i64
  %557 = add nsw i64 %549, %556
  %558 = trunc i64 %557 to i8
  %559 = load i8*, i8** %8, align 8
  store i8 %558, i8* %559, align 1
  br label %560

560:                                              ; preds = %530, %523, %516
  br label %598

561:                                              ; preds = %473
  %562 = load i64*, i64** %9, align 8
  %563 = load i64, i64* %562, align 8
  %564 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %565 = bitcast %struct.anon.6* %564 to i32*
  %566 = load i32, i32* %565, align 4
  %567 = and i32 %566, 1023
  %568 = zext i32 %567 to i64
  %569 = add nsw i64 %563, %568
  %570 = load %struct.ttf_reader*, %struct.ttf_reader** %4, align 8
  %571 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %570, i32 0, i32 4
  %572 = load i64, i64* %571, align 8
  %573 = mul nsw i64 %569, %572
  %574 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %575 = bitcast %struct.anon.6* %574 to i32*
  %576 = load i32, i32* %575, align 4
  %577 = lshr i32 %576, 10
  %578 = and i32 %577, 32767
  %579 = zext i32 %578 to i64
  %580 = load %struct.ttf_reader*, %struct.ttf_reader** %4, align 8
  %581 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %580, i32 0, i32 3
  %582 = load i64, i64* %581, align 8
  %583 = mul nsw i64 %579, %582
  %584 = add nsw i64 %573, %583
  %585 = load i64*, i64** %7, align 8
  store i64 %584, i64* %585, align 8
  %586 = load %struct.ttf_reader*, %struct.ttf_reader** %4, align 8
  %587 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %586, i32 0, i32 8
  %588 = load i64, i64* %587, align 8
  %589 = bitcast %union.anon.5* %11 to %struct.anon.6*
  %590 = bitcast %struct.anon.6* %589 to i32*
  %591 = load i32, i32* %590, align 4
  %592 = lshr i32 %591, 25
  %593 = and i32 %592, 63
  %594 = zext i32 %593 to i64
  %595 = add nsw i64 %588, %594
  %596 = trunc i64 %595 to i8
  %597 = load i8*, i8** %8, align 8
  store i8 %596, i8* %597, align 1
  br label %598

598:                                              ; preds = %560, %561
  br label %1109

599:                                              ; preds = %105, %105, %105
  %600 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %601 = load i32, i32* %67, align 4
  %602 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %603 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %602, i32 0, i32 12
  store %struct.ttf_reader* %600, %struct.ttf_reader** %12, align 8
  store i32 %601, i32* %13, align 4
  store i32 2, i32* %14, align 4
  store i64* %62, i64** %15, align 8
  store i8* %63, i8** %16, align 8
  store i64* %603, i64** %17, align 8
  store i32 33552000, i32* %19, align 4
  store i32 33554432, i32* %20, align 4
  %604 = load i32, i32* %13, align 4
  %605 = zext i32 %604 to i64
  %606 = bitcast %union.anon.0* %21 to i64*
  store i64 %605, i64* %606, align 8
  %607 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %608 = bitcast %struct.anon.1* %607 to i32*
  %609 = load i32, i32* %608, align 8
  %610 = lshr i32 %609, 31
  %611 = icmp eq i32 %610, 1
  br i1 %611, label %612, label %718

612:                                              ; preds = %599
  %613 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %614 = bitcast %struct.anon.1* %613 to i32*
  %615 = load i32, i32* %614, align 8
  %616 = lshr i32 %615, 25
  %617 = and i32 %616, 63
  %618 = icmp eq i32 %617, 63
  br i1 %618, label %619, label %648

619:                                              ; preds = %612
  %620 = load i32, i32* %14, align 4
  %621 = icmp eq i32 %620, 1
  br i1 %621, label %622, label %626

622:                                              ; preds = %619
  %623 = load i64*, i64** %17, align 8
  %624 = load i64, i64* %623, align 8
  %625 = add i64 %624, 33552000
  store i64 %625, i64* %623, align 8
  br label %647

626:                                              ; preds = %619
  %627 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %628 = bitcast %struct.anon.1* %627 to i32*
  %629 = load i32, i32* %628, align 8
  %630 = and i32 %629, 33554431
  %631 = icmp eq i32 %630, 0
  br i1 %631, label %632, label %636

632:                                              ; preds = %626
  %633 = load i64*, i64** %17, align 8
  %634 = load i64, i64* %633, align 8
  %635 = add i64 %634, 33554432
  store i64 %635, i64* %633, align 8
  br label %646

636:                                              ; preds = %626
  %637 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %638 = bitcast %struct.anon.1* %637 to i32*
  %639 = load i32, i32* %638, align 8
  %640 = and i32 %639, 33554431
  %641 = zext i32 %640 to i64
  %642 = mul i64 33554432, %641
  %643 = load i64*, i64** %17, align 8
  %644 = load i64, i64* %643, align 8
  %645 = add i64 %644, %642
  store i64 %645, i64* %643, align 8
  br label %646

646:                                              ; preds = %636, %632
  br label %647

647:                                              ; preds = %646, %622
  br label %648

648:                                              ; preds = %647, %612
  %649 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %650 = bitcast %struct.anon.1* %649 to i32*
  %651 = load i32, i32* %650, align 8
  %652 = lshr i32 %651, 25
  %653 = and i32 %652, 63
  %654 = icmp sge i32 %653, 1
  br i1 %654, label %655, label %690

655:                                              ; preds = %648
  %656 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %657 = bitcast %struct.anon.1* %656 to i32*
  %658 = load i32, i32* %657, align 8
  %659 = lshr i32 %658, 25
  %660 = and i32 %659, 63
  %661 = icmp sle i32 %660, 15
  br i1 %661, label %662, label %690

662:                                              ; preds = %655
  %663 = load i64*, i64** %17, align 8
  %664 = load i64, i64* %663, align 8
  %665 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %666 = bitcast %struct.anon.1* %665 to i32*
  %667 = load i32, i32* %666, align 8
  %668 = and i32 %667, 33554431
  %669 = zext i32 %668 to i64
  %670 = add nsw i64 %664, %669
  store i64 %670, i64* %18, align 8
  %671 = load i64, i64* %18, align 8
  %672 = load %struct.ttf_reader*, %struct.ttf_reader** %12, align 8
  %673 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %672, i32 0, i32 2
  %674 = load i64, i64* %673, align 8
  %675 = mul nsw i64 %671, %674
  %676 = load i64*, i64** %15, align 8
  store i64 %675, i64* %676, align 8
  %677 = load %struct.ttf_reader*, %struct.ttf_reader** %12, align 8
  %678 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %677, i32 0, i32 9
  %679 = load i64, i64* %678, align 8
  %680 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %681 = bitcast %struct.anon.1* %680 to i32*
  %682 = load i32, i32* %681, align 8
  %683 = lshr i32 %682, 25
  %684 = and i32 %683, 63
  %685 = call i32 @llvm.cttz.i32(i32 %684, i1 true) #4
  %686 = sext i32 %685 to i64
  %687 = add nsw i64 %679, %686
  %688 = trunc i64 %687 to i8
  %689 = load i8*, i8** %16, align 8
  store i8 %688, i8* %689, align 1
  br label %690

690:                                              ; preds = %662, %655, %648
  %691 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %692 = bitcast %struct.anon.1* %691 to i32*
  %693 = load i32, i32* %692, align 8
  %694 = lshr i32 %693, 25
  %695 = and i32 %694, 63
  %696 = icmp eq i32 %695, 0
  br i1 %696, label %697, label %717

697:                                              ; preds = %690
  %698 = load i64*, i64** %17, align 8
  %699 = load i64, i64* %698, align 8
  %700 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %701 = bitcast %struct.anon.1* %700 to i32*
  %702 = load i32, i32* %701, align 8
  %703 = and i32 %702, 33554431
  %704 = zext i32 %703 to i64
  %705 = add nsw i64 %699, %704
  store i64 %705, i64* %18, align 8
  %706 = load i64, i64* %18, align 8
  %707 = load %struct.ttf_reader*, %struct.ttf_reader** %12, align 8
  %708 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %707, i32 0, i32 2
  %709 = load i64, i64* %708, align 8
  %710 = mul nsw i64 %706, %709
  %711 = load i64*, i64** %15, align 8
  store i64 %710, i64* %711, align 8
  %712 = load %struct.ttf_reader*, %struct.ttf_reader** %12, align 8
  %713 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %712, i32 0, i32 8
  %714 = load i64, i64* %713, align 8
  %715 = trunc i64 %714 to i8
  %716 = load i8*, i8** %16, align 8
  store i8 %715, i8* %716, align 1
  br label %717

717:                                              ; preds = %697, %690
  br label %746

718:                                              ; preds = %599
  %719 = load i64*, i64** %17, align 8
  %720 = load i64, i64* %719, align 8
  %721 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %722 = bitcast %struct.anon.1* %721 to i32*
  %723 = load i32, i32* %722, align 8
  %724 = and i32 %723, 33554431
  %725 = zext i32 %724 to i64
  %726 = add nsw i64 %720, %725
  store i64 %726, i64* %18, align 8
  %727 = load i64, i64* %18, align 8
  %728 = load %struct.ttf_reader*, %struct.ttf_reader** %12, align 8
  %729 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %728, i32 0, i32 2
  %730 = load i64, i64* %729, align 8
  %731 = mul nsw i64 %727, %730
  %732 = load i64*, i64** %15, align 8
  store i64 %731, i64* %732, align 8
  %733 = load %struct.ttf_reader*, %struct.ttf_reader** %12, align 8
  %734 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %733, i32 0, i32 8
  %735 = load i64, i64* %734, align 8
  %736 = bitcast %union.anon.0* %21 to %struct.anon.1*
  %737 = bitcast %struct.anon.1* %736 to i32*
  %738 = load i32, i32* %737, align 8
  %739 = lshr i32 %738, 25
  %740 = and i32 %739, 63
  %741 = zext i32 %740 to i64
  %742 = add nsw i64 %735, %741
  %743 = add nsw i64 %742, 1
  %744 = trunc i64 %743 to i8
  %745 = load i8*, i8** %16, align 8
  store i8 %744, i8* %745, align 1
  br label %746

746:                                              ; preds = %717, %718
  br label %1109

747:                                              ; preds = %105, %105, %105
  %748 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %749 = load i32, i32* %67, align 4
  %750 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %751 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %750, i32 0, i32 12
  store %struct.ttf_reader* %748, %struct.ttf_reader** %22, align 8
  store i32 %749, i32* %23, align 4
  store i32 2, i32* %24, align 4
  store i64* %62, i64** %25, align 8
  store i8* %63, i8** %26, align 8
  store i64* %751, i64** %27, align 8
  store i32 1024, i32* %28, align 4
  %752 = load i32, i32* %23, align 4
  %753 = bitcast %union.anon.5* %29 to i32*
  store i32 %752, i32* %753, align 4
  %754 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %755 = bitcast %struct.anon.6* %754 to i32*
  %756 = load i32, i32* %755, align 4
  %757 = lshr i32 %756, 31
  %758 = icmp eq i32 %757, 1
  br i1 %758, label %759, label %835

759:                                              ; preds = %747
  %760 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %761 = bitcast %struct.anon.6* %760 to i32*
  %762 = load i32, i32* %761, align 4
  %763 = lshr i32 %762, 25
  %764 = and i32 %763, 63
  %765 = icmp eq i32 %764, 63
  br i1 %765, label %766, label %790

766:                                              ; preds = %759
  %767 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %768 = bitcast %struct.anon.6* %767 to i32*
  %769 = load i32, i32* %768, align 4
  %770 = and i32 %769, 1023
  %771 = icmp eq i32 %770, 0
  br i1 %771, label %775, label %772

772:                                              ; preds = %766
  %773 = load i32, i32* %24, align 4
  %774 = icmp eq i32 %773, 1
  br i1 %774, label %775, label %779

775:                                              ; preds = %772, %766
  %776 = load i64*, i64** %27, align 8
  %777 = load i64, i64* %776, align 8
  %778 = add i64 %777, 1024
  store i64 %778, i64* %776, align 8
  br label %789

779:                                              ; preds = %772
  %780 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %781 = bitcast %struct.anon.6* %780 to i32*
  %782 = load i32, i32* %781, align 4
  %783 = and i32 %782, 1023
  %784 = zext i32 %783 to i64
  %785 = mul i64 1024, %784
  %786 = load i64*, i64** %27, align 8
  %787 = load i64, i64* %786, align 8
  %788 = add i64 %787, %785
  store i64 %788, i64* %786, align 8
  br label %789

789:                                              ; preds = %779, %775
  br label %790

790:                                              ; preds = %789, %759
  %791 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %792 = bitcast %struct.anon.6* %791 to i32*
  %793 = load i32, i32* %792, align 4
  %794 = lshr i32 %793, 25
  %795 = and i32 %794, 63
  %796 = icmp sge i32 %795, 1
  br i1 %796, label %797, label %834

797:                                              ; preds = %790
  %798 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %799 = bitcast %struct.anon.6* %798 to i32*
  %800 = load i32, i32* %799, align 4
  %801 = lshr i32 %800, 25
  %802 = and i32 %801, 63
  %803 = icmp sle i32 %802, 15
  br i1 %803, label %804, label %834

804:                                              ; preds = %797
  %805 = load i64*, i64** %27, align 8
  %806 = load i64, i64* %805, align 8
  %807 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %808 = bitcast %struct.anon.6* %807 to i32*
  %809 = load i32, i32* %808, align 4
  %810 = and i32 %809, 1023
  %811 = zext i32 %810 to i64
  %812 = add nsw i64 %806, %811
  %813 = load %struct.ttf_reader*, %struct.ttf_reader** %22, align 8
  %814 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %813, i32 0, i32 4
  %815 = load i64, i64* %814, align 8
  %816 = mul nsw i64 %812, %815
  %817 = load %struct.ttf_reader*, %struct.ttf_reader** %22, align 8
  %818 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %817, i32 0, i32 3
  %819 = load i64, i64* %818, align 8
  %820 = load i64*, i64** %25, align 8
  store i64 %816, i64* %820, align 8
  %821 = load %struct.ttf_reader*, %struct.ttf_reader** %22, align 8
  %822 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %821, i32 0, i32 9
  %823 = load i64, i64* %822, align 8
  %824 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %825 = bitcast %struct.anon.6* %824 to i32*
  %826 = load i32, i32* %825, align 4
  %827 = lshr i32 %826, 25
  %828 = and i32 %827, 63
  %829 = call i32 @llvm.cttz.i32(i32 %828, i1 true) #4
  %830 = sext i32 %829 to i64
  %831 = add nsw i64 %823, %830
  %832 = trunc i64 %831 to i8
  %833 = load i8*, i8** %26, align 8
  store i8 %832, i8* %833, align 1
  br label %834

834:                                              ; preds = %804, %797, %790
  br label %872

835:                                              ; preds = %747
  %836 = load i64*, i64** %27, align 8
  %837 = load i64, i64* %836, align 8
  %838 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %839 = bitcast %struct.anon.6* %838 to i32*
  %840 = load i32, i32* %839, align 4
  %841 = and i32 %840, 1023
  %842 = zext i32 %841 to i64
  %843 = add nsw i64 %837, %842
  %844 = load %struct.ttf_reader*, %struct.ttf_reader** %22, align 8
  %845 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %844, i32 0, i32 4
  %846 = load i64, i64* %845, align 8
  %847 = mul nsw i64 %843, %846
  %848 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %849 = bitcast %struct.anon.6* %848 to i32*
  %850 = load i32, i32* %849, align 4
  %851 = lshr i32 %850, 10
  %852 = and i32 %851, 32767
  %853 = zext i32 %852 to i64
  %854 = load %struct.ttf_reader*, %struct.ttf_reader** %22, align 8
  %855 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %854, i32 0, i32 3
  %856 = load i64, i64* %855, align 8
  %857 = mul nsw i64 %853, %856
  %858 = add nsw i64 %847, %857
  %859 = load i64*, i64** %25, align 8
  store i64 %858, i64* %859, align 8
  %860 = load %struct.ttf_reader*, %struct.ttf_reader** %22, align 8
  %861 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %860, i32 0, i32 8
  %862 = load i64, i64* %861, align 8
  %863 = bitcast %union.anon.5* %29 to %struct.anon.6*
  %864 = bitcast %struct.anon.6* %863 to i32*
  %865 = load i32, i32* %864, align 4
  %866 = lshr i32 %865, 25
  %867 = and i32 %866, 63
  %868 = zext i32 %867 to i64
  %869 = add nsw i64 %862, %868
  %870 = trunc i64 %869 to i8
  %871 = load i8*, i8** %26, align 8
  store i8 %870, i8* %871, align 1
  br label %872

872:                                              ; preds = %834, %835
  br label %1109

873:                                              ; preds = %105
  %874 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %875 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %874, i32 0, i32 14
  %876 = load i8*, i8** %875, align 8
  %877 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %878 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %877, i32 0, i32 11
  %879 = load i64, i64* %878, align 8
  %880 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %881 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %880, i32 0, i32 5
  %882 = load i64, i64* %881, align 8
  %883 = mul nsw i64 %879, %882
  %884 = getelementptr inbounds i8, i8* %876, i64 %883
  %885 = bitcast i8* %884 to %struct.TTTRRecord*
  store %struct.TTTRRecord* %885, %struct.TTTRRecord** %69, align 8
  %886 = load %struct.TTTRRecord*, %struct.TTTRRecord** %69, align 8
  %887 = getelementptr inbounds %struct.TTTRRecord, %struct.TTTRRecord* %886, i32 0, i32 0
  %888 = load i64, i64* %887, align 8
  store i64 %888, i64* %62, align 8
  %889 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %890 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %889, i32 0, i32 8
  %891 = load i64, i64* %890, align 8
  %892 = load %struct.TTTRRecord*, %struct.TTTRRecord** %69, align 8
  %893 = getelementptr inbounds %struct.TTTRRecord, %struct.TTTRRecord* %892, i32 0, i32 1
  %894 = load i16, i16* %893, align 8
  %895 = zext i16 %894 to i64
  %896 = add nsw i64 %891, %895
  %897 = trunc i64 %896 to i8
  store i8 %897, i8* %63, align 1
  br label %1109

898:                                              ; preds = %105
  %899 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %900 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %899, i32 0, i32 14
  %901 = load i8*, i8** %900, align 8
  %902 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %903 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %902, i32 0, i32 11
  %904 = load i64, i64* %903, align 8
  %905 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %906 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %905, i32 0, i32 5
  %907 = load i64, i64* %906, align 8
  %908 = mul nsw i64 %904, %907
  %909 = getelementptr inbounds i8, i8* %901, i64 %908
  %910 = bitcast i8* %909 to %struct.SITTTRStruct*
  store %struct.SITTTRStruct* %910, %struct.SITTTRStruct** %70, align 8
  %911 = load %struct.SITTTRStruct*, %struct.SITTTRStruct** %70, align 8
  %912 = getelementptr inbounds %struct.SITTTRStruct, %struct.SITTTRStruct* %911, i32 0, i32 2
  %913 = load i64, i64* %912, align 8
  store i64 %913, i64* %62, align 8
  %914 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %915 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %914, i32 0, i32 8
  %916 = load i64, i64* %915, align 8
  %917 = load %struct.SITTTRStruct*, %struct.SITTTRStruct** %70, align 8
  %918 = getelementptr inbounds %struct.SITTTRStruct, %struct.SITTTRStruct* %917, i32 0, i32 1
  %919 = load i32, i32* %918, align 4
  %920 = sext i32 %919 to i64
  %921 = add nsw i64 %916, %920
  %922 = trunc i64 %921 to i8
  store i8 %922, i8* %63, align 1
  br label %1109

923:                                              ; preds = %105
  %924 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %925 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %924, i32 0, i32 14
  %926 = load i8*, i8** %925, align 8
  %927 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %928 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %927, i32 0, i32 11
  %929 = load i64, i64* %928, align 8
  %930 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %931 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %930, i32 0, i32 5
  %932 = load i64, i64* %931, align 8
  %933 = mul nsw i64 %929, %932
  %934 = getelementptr inbounds i8, i8* %926, i64 %933
  %935 = bitcast i8* %934 to %union.COMPTTTRRecord*
  store %union.COMPTTTRRecord* %935, %union.COMPTTTRRecord** %71, align 8
  %936 = load %union.COMPTTTRRecord*, %union.COMPTTTRRecord** %71, align 8
  %937 = bitcast %union.COMPTTTRRecord* %936 to %struct.anon.7*
  %938 = bitcast %struct.anon.7* %937 to i64*
  %939 = load i64, i64* %938, align 8
  %940 = and i64 %939, 137438953471
  store i64 %940, i64* %62, align 8
  %941 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %942 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %941, i32 0, i32 8
  %943 = load i64, i64* %942, align 8
  %944 = load %union.COMPTTTRRecord*, %union.COMPTTTRRecord** %71, align 8
  %945 = bitcast %union.COMPTTTRRecord* %944 to %struct.anon.7*
  %946 = bitcast %struct.anon.7* %945 to i64*
  %947 = load i64, i64* %946, align 8
  %948 = lshr i64 %947, 37
  %949 = and i64 %948, 7
  %950 = trunc i64 %949 to i32
  %951 = zext i32 %950 to i64
  %952 = add nsw i64 %943, %951
  %953 = trunc i64 %952 to i8
  store i8 %953, i8* %63, align 1
  br label %1109

954:                                              ; preds = %105
  %955 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %956 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %955, i32 0, i32 14
  %957 = load i8*, i8** %956, align 8
  %958 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %959 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %958, i32 0, i32 11
  %960 = load i64, i64* %959, align 8
  %961 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %962 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %961, i32 0, i32 5
  %963 = load i64, i64* %962, align 8
  %964 = mul nsw i64 %960, %963
  %965 = getelementptr inbounds i8, i8* %957, i64 %964
  %966 = bitcast i8* %965 to %union.bh4bytesRec*
  store %union.bh4bytesRec* %966, %union.bh4bytesRec** %72, align 8
  %967 = load %union.bh4bytesRec*, %union.bh4bytesRec** %72, align 8
  %968 = bitcast %union.bh4bytesRec* %967 to %struct.anon.8*
  %969 = bitcast %struct.anon.8* %968 to i32*
  %970 = load i32, i32* %969, align 4
  %971 = and i32 %970, 4095
  %972 = zext i32 %971 to i64
  %973 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %974 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %973, i32 0, i32 12
  %975 = load i64, i64* %974, align 8
  %976 = add nsw i64 %972, %975
  %977 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %978 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %977, i32 0, i32 4
  %979 = load i64, i64* %978, align 8
  %980 = mul nsw i64 %976, %979
  %981 = load %union.bh4bytesRec*, %union.bh4bytesRec** %72, align 8
  %982 = bitcast %union.bh4bytesRec* %981 to %struct.anon.8*
  %983 = bitcast %struct.anon.8* %982 to i32*
  %984 = load i32, i32* %983, align 4
  %985 = lshr i32 %984, 16
  %986 = and i32 %985, 4095
  %987 = zext i32 %986 to i64
  %988 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %989 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %988, i32 0, i32 3
  %990 = load i64, i64* %989, align 8
  %991 = mul nsw i64 %987, %990
  %992 = add nsw i64 %980, %991
  store i64 %992, i64* %62, align 8
  %993 = load %union.bh4bytesRec*, %union.bh4bytesRec** %72, align 8
  %994 = bitcast %union.bh4bytesRec* %993 to %struct.anon.8*
  %995 = bitcast %struct.anon.8* %994 to i32*
  %996 = load i32, i32* %995, align 4
  %997 = lshr i32 %996, 31
  %998 = icmp ne i32 %997, 0
  br i1 %998, label %999, label %1000

999:                                              ; preds = %954
  store i64 9223372036854775807, i64* %62, align 8
  br label %1000

1000:                                             ; preds = %999, %954
  %1001 = load %union.bh4bytesRec*, %union.bh4bytesRec** %72, align 8
  %1002 = bitcast %union.bh4bytesRec* %1001 to %struct.anon.8*
  %1003 = bitcast %struct.anon.8* %1002 to i32*
  %1004 = load i32, i32* %1003, align 4
  %1005 = lshr i32 %1004, 30
  %1006 = and i32 %1005, 1
  %1007 = icmp ne i32 %1006, 0
  br i1 %1007, label %1008, label %1013

1008:                                             ; preds = %1000
  store i64 9223372036854775807, i64* %62, align 8
  %1009 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %1010 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %1009, i32 0, i32 12
  %1011 = load i64, i64* %1010, align 8
  %1012 = add nsw i64 %1011, 4096
  store i64 %1012, i64* %1010, align 8
  br label %1013

1013:                                             ; preds = %1008, %1000
  %1014 = load %union.bh4bytesRec*, %union.bh4bytesRec** %72, align 8
  %1015 = bitcast %union.bh4bytesRec* %1014 to %struct.anon.8*
  %1016 = bitcast %struct.anon.8* %1015 to i32*
  %1017 = load i32, i32* %1016, align 4
  %1018 = lshr i32 %1017, 28
  %1019 = and i32 %1018, 1
  %1020 = icmp ne i32 %1019, 0
  br i1 %1020, label %1021, label %1034

1021:                                             ; preds = %1013
  %1022 = load %union.bh4bytesRec*, %union.bh4bytesRec** %72, align 8
  %1023 = bitcast %union.bh4bytesRec* %1022 to %struct.anon.8*
  %1024 = bitcast %struct.anon.8* %1023 to i32*
  %1025 = load i32, i32* %1024, align 4
  %1026 = lshr i32 %1025, 12
  %1027 = and i32 %1026, 15
  %1028 = zext i32 %1027 to i64
  %1029 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %1030 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %1029, i32 0, i32 9
  %1031 = load i64, i64* %1030, align 8
  %1032 = add nsw i64 %1028, %1031
  %1033 = trunc i64 %1032 to i8
  store i8 %1033, i8* %63, align 1
  br label %1047

1034:                                             ; preds = %1013
  %1035 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %1036 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %1035, i32 0, i32 8
  %1037 = load i64, i64* %1036, align 8
  %1038 = load %union.bh4bytesRec*, %union.bh4bytesRec** %72, align 8
  %1039 = bitcast %union.bh4bytesRec* %1038 to %struct.anon.8*
  %1040 = bitcast %struct.anon.8* %1039 to i32*
  %1041 = load i32, i32* %1040, align 4
  %1042 = lshr i32 %1041, 12
  %1043 = and i32 %1042, 15
  %1044 = zext i32 %1043 to i64
  %1045 = add nsw i64 %1037, %1044
  %1046 = trunc i64 %1045 to i8
  store i8 %1046, i8* %63, align 1
  br label %1047

1047:                                             ; preds = %1034, %1021
  br label %1109

1048:                                             ; preds = %105
  %1049 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %1050 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %1049, i32 0, i32 14
  %1051 = load i8*, i8** %1050, align 8
  %1052 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %1053 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %1052, i32 0, i32 11
  %1054 = load i64, i64* %1053, align 8
  %1055 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %1056 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %1055, i32 0, i32 5
  %1057 = load i64, i64* %1056, align 8
  %1058 = mul nsw i64 %1054, %1057
  %1059 = getelementptr inbounds i8, i8* %1051, i64 %1058
  %1060 = bitcast i8* %1059 to %struct.ETA033Struct*
  store %struct.ETA033Struct* %1060, %struct.ETA033Struct** %73, align 8
  %1061 = load %struct.ETA033Struct*, %struct.ETA033Struct** %73, align 8
  %1062 = getelementptr inbounds %struct.ETA033Struct, %struct.ETA033Struct* %1061, i32 0, i32 1
  %1063 = load i32, i32* %1062, align 4
  %1064 = icmp sgt i32 %1063, 0
  br i1 %1064, label %1065, label %1105

1065:                                             ; preds = %1048
  %1066 = load %struct.ETA033Struct*, %struct.ETA033Struct** %73, align 8
  %1067 = getelementptr inbounds %struct.ETA033Struct, %struct.ETA033Struct* %1066, i32 0, i32 0
  %1068 = load i32, i32* %1067, align 4
  %1069 = icmp slt i32 %1068, 0
  br i1 %1069, label %1070, label %1088

1070:                                             ; preds = %1065
  %1071 = load %struct.ETA033Struct*, %struct.ETA033Struct** %73, align 8
  %1072 = getelementptr inbounds %struct.ETA033Struct, %struct.ETA033Struct* %1071, i32 0, i32 0
  %1073 = load i32, i32* %1072, align 4
  %1074 = sub nsw i32 0, %1073
  store i32 %1074, i32* %74, align 4
  %1075 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %1076 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %1075, i32 0, i32 8
  %1077 = load i64, i64* %1076, align 8
  %1078 = add nsw i64 %1077, 0
  %1079 = trunc i64 %1078 to i8
  store i8 %1079, i8* %63, align 1
  %1080 = load i32, i32* %74, align 4
  %1081 = sext i32 %1080 to i64
  %1082 = mul i64 327680000, %1081
  %1083 = load %struct.ETA033Struct*, %struct.ETA033Struct** %73, align 8
  %1084 = getelementptr inbounds %struct.ETA033Struct, %struct.ETA033Struct* %1083, i32 0, i32 1
  %1085 = load i32, i32* %1084, align 4
  %1086 = sext i32 %1085 to i64
  %1087 = add i64 %1082, %1086
  store i64 %1087, i64* %62, align 8
  br label %1104

1088:                                             ; preds = %1065
  %1089 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %1090 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %1089, i32 0, i32 8
  %1091 = load i64, i64* %1090, align 8
  %1092 = add nsw i64 %1091, 1
  %1093 = trunc i64 %1092 to i8
  store i8 %1093, i8* %63, align 1
  %1094 = load %struct.ETA033Struct*, %struct.ETA033Struct** %73, align 8
  %1095 = getelementptr inbounds %struct.ETA033Struct, %struct.ETA033Struct* %1094, i32 0, i32 0
  %1096 = load i32, i32* %1095, align 4
  %1097 = sext i32 %1096 to i64
  %1098 = mul i64 327680000, %1097
  %1099 = load %struct.ETA033Struct*, %struct.ETA033Struct** %73, align 8
  %1100 = getelementptr inbounds %struct.ETA033Struct, %struct.ETA033Struct* %1099, i32 0, i32 1
  %1101 = load i32, i32* %1100, align 4
  %1102 = sext i32 %1101 to i64
  %1103 = add i64 %1098, %1102
  store i64 %1103, i64* %62, align 8
  br label %1104

1104:                                             ; preds = %1088, %1070
  br label %1105

1105:                                             ; preds = %1104, %1048
  br label %1109

1106:                                             ; preds = %105
  %1107 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.2, i64 0, i64 0))
  %1108 = sext i32 %1107 to i64
  store i64 %1108, i64* @order_gurantee, align 8
  br label %1109

1109:                                             ; preds = %1106, %1105, %1047, %923, %898, %873, %872, %746, %598, %472, %324, %209
  %1110 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %1111 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %1110, i32 0, i32 11
  %1112 = load i64, i64* %1111, align 8
  %1113 = add nsw i64 %1112, 1
  store i64 %1113, i64* %1111, align 8
  %1114 = load i64, i64* %62, align 8
  %1115 = icmp eq i64 %1114, 9223372036854775807
  br i1 %1115, label %1116, label %1117

1116:                                             ; preds = %1109
  br label %79

1117:                                             ; preds = %1109
  %1118 = load i8, i8* %63, align 1
  %1119 = load i8*, i8** %60, align 8
  store i8 %1118, i8* %1119, align 1
  %1120 = load i64, i64* %62, align 8
  %1121 = load %struct.ttf_reader*, %struct.ttf_reader** %61, align 8
  %1122 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %1121, i32 0, i32 7
  %1123 = load i64, i64* %1122, align 8
  %1124 = add nsw i64 %1120, %1123
  store i64 %1124, i64* %57, align 8
  br label %1127

1125:                                             ; preds = %104
  %1126 = load i8*, i8** %60, align 8
  store i8 -1, i8* %1126, align 1
  store i64 9223372036854775807, i64* %57, align 8
  br label %1127

1127:                                             ; preds = %1125, %1117
  %1128 = load i64, i64* %57, align 8
  ret i64 %1128
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @FileReader_init(%struct.ttf_reader* %0, i8 zeroext %1, i8 zeroext %2, i8 zeroext %3, i8* %4) #3 {
  %6 = alloca %struct.ttf_reader*, align 8
  %7 = alloca i8, align 1
  %8 = alloca i8, align 1
  %9 = alloca i8, align 1
  %10 = alloca i8*, align 8
  %11 = alloca %struct.ttf_reader*, align 8
  store %struct.ttf_reader* %0, %struct.ttf_reader** %6, align 8
  store i8 %1, i8* %7, align 1
  store i8 %2, i8* %8, align 1
  store i8 %3, i8* %9, align 1
  store i8* %4, i8** %10, align 8
  %12 = load %struct.ttf_reader*, %struct.ttf_reader** %6, align 8
  %13 = load i8, i8* %7, align 1
  %14 = zext i8 %13 to i64
  %15 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %12, i64 %14
  store %struct.ttf_reader* %15, %struct.ttf_reader** %11, align 8
  %16 = load i8*, i8** %10, align 8
  %17 = load %struct.ttf_reader*, %struct.ttf_reader** %11, align 8
  %18 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %17, i32 0, i32 14
  store i8* %16, i8** %18, align 8
  %19 = load i8, i8* %8, align 1
  %20 = zext i8 %19 to i64
  %21 = load %struct.ttf_reader*, %struct.ttf_reader** %11, align 8
  %22 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %21, i32 0, i32 8
  store i64 %20, i64* %22, align 8
  %23 = load i8, i8* %9, align 1
  %24 = zext i8 %23 to i64
  %25 = load %struct.ttf_reader*, %struct.ttf_reader** %11, align 8
  %26 = getelementptr inbounds %struct.ttf_reader, %struct.ttf_reader* %25, i32 0, i32 9
  store i64 %24, i64* %26, align 8
  ret i32 0
}

attributes #0 = { alwaysinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 11.1.0-6"}
