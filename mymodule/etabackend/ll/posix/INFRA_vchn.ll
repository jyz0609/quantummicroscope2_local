; ModuleID = 'etabackend/cpp/INFRA_vchn.cpp'
source_filename = "etabackend/cpp/INFRA_vchn.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.circular_buf_t = type { i64*, i64, i64, i64 }
%struct.VCHN_t = type <{ i64*, i8*, i8*, %struct.circular_buf_t*, i8, i8, i8, [5 x i8] }>

@controlflow_guarantee = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [52 x i8] c"\0A [ERROR]Memalloc failed for this VFILE, aborting.\0A\00", align 1
@.str.1 = private unnamed_addr constant [54 x i8] c"\0A [ERROR]Memalloc failed for POOL_timetag, aborting.\0A\00", align 1
@.str.2 = private unnamed_addr constant [53 x i8] c"\0A [ERROR]Memalloc failed for POOL_fileid, aborting.\0A\00", align 1
@.str.3 = private unnamed_addr constant [50 x i8] c"\0A [ERROR]Memalloc failed for POOL_chn, aborting.\0A\00", align 1
@.str.4 = private unnamed_addr constant [54 x i8] c"\0A [ERROR]Memalloc failed for VFILES index, aborting.\0A\00", align 1
@.str.5 = private unnamed_addr constant [34 x i8] c"\0A [FATAL]Buffer overflow! at %llx\00", align 1

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @circular_buf_reset(%struct.circular_buf_t* %0) #0 {
  %2 = alloca %struct.circular_buf_t*, align 8
  %3 = alloca i32, align 4
  store %struct.circular_buf_t* %0, %struct.circular_buf_t** %2, align 8
  store i32 -1, i32* %3, align 4
  %4 = load %struct.circular_buf_t*, %struct.circular_buf_t** %2, align 8
  %5 = icmp ne %struct.circular_buf_t* %4, null
  br i1 %5, label %6, label %11

6:                                                ; preds = %1
  %7 = load %struct.circular_buf_t*, %struct.circular_buf_t** %2, align 8
  %8 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %7, i32 0, i32 1
  store i64 0, i64* %8, align 8
  %9 = load %struct.circular_buf_t*, %struct.circular_buf_t** %2, align 8
  %10 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %9, i32 0, i32 2
  store i64 0, i64* %10, align 8
  store i32 0, i32* %3, align 4
  br label %11

11:                                               ; preds = %6, %1
  %12 = load i32, i32* %3, align 4
  ret i32 %12
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @circular_buf_put(%struct.circular_buf_t* %0, i64 %1) #0 {
  %3 = alloca %struct.circular_buf_t*, align 8
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  store %struct.circular_buf_t* %0, %struct.circular_buf_t** %3, align 8
  store i64 %1, i64* %4, align 8
  store i32 -1, i32* %5, align 4
  %6 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %7 = icmp ne %struct.circular_buf_t* %6, null
  br i1 %7, label %8, label %46

8:                                                ; preds = %2
  %9 = load i64, i64* %4, align 8
  %10 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %11 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %10, i32 0, i32 0
  %12 = load i64*, i64** %11, align 8
  %13 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %14 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %13, i32 0, i32 1
  %15 = load i64, i64* %14, align 8
  %16 = getelementptr inbounds i64, i64* %12, i64 %15
  store i64 %9, i64* %16, align 8
  %17 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %18 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %17, i32 0, i32 1
  %19 = load i64, i64* %18, align 8
  %20 = add nsw i64 %19, 1
  %21 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %22 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %21, i32 0, i32 3
  %23 = load i64, i64* %22, align 8
  %24 = srem i64 %20, %23
  %25 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %26 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %25, i32 0, i32 1
  store i64 %24, i64* %26, align 8
  %27 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %28 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %27, i32 0, i32 1
  %29 = load i64, i64* %28, align 8
  %30 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %31 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %30, i32 0, i32 2
  %32 = load i64, i64* %31, align 8
  %33 = icmp eq i64 %29, %32
  br i1 %33, label %34, label %45

34:                                               ; preds = %8
  %35 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %36 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %35, i32 0, i32 2
  %37 = load i64, i64* %36, align 8
  %38 = add nsw i64 %37, 1
  %39 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %40 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %39, i32 0, i32 3
  %41 = load i64, i64* %40, align 8
  %42 = srem i64 %38, %41
  %43 = load %struct.circular_buf_t*, %struct.circular_buf_t** %3, align 8
  %44 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %43, i32 0, i32 2
  store i64 %42, i64* %44, align 8
  br label %45

45:                                               ; preds = %34, %8
  store i32 0, i32* %5, align 4
  br label %46

46:                                               ; preds = %45, %2
  %47 = load i32, i32* %5, align 4
  ret i32 %47
}

; Function Attrs: alwaysinline uwtable
define dso_local i32 @circular_buf_get(%struct.circular_buf_t* %0, i64* %1, i1 zeroext %2) #1 {
  %4 = alloca %struct.circular_buf_t, align 8
  %5 = alloca %struct.circular_buf_t*, align 8
  %6 = alloca i64*, align 8
  %7 = alloca i8, align 1
  %8 = alloca i32, align 4
  %9 = alloca %struct.circular_buf_t, align 8
  store %struct.circular_buf_t* %0, %struct.circular_buf_t** %5, align 8
  store i64* %1, i64** %6, align 8
  %10 = zext i1 %2 to i8
  store i8 %10, i8* %7, align 1
  store i32 -1, i32* %8, align 4
  %11 = load %struct.circular_buf_t*, %struct.circular_buf_t** %5, align 8
  %12 = icmp ne %struct.circular_buf_t* %11, null
  br i1 %12, label %13, label %51

13:                                               ; preds = %3
  %14 = load i64*, i64** %6, align 8
  %15 = icmp ne i64* %14, null
  br i1 %15, label %16, label %51

16:                                               ; preds = %13
  %17 = load %struct.circular_buf_t*, %struct.circular_buf_t** %5, align 8
  %18 = bitcast %struct.circular_buf_t* %9 to i8*
  %19 = bitcast %struct.circular_buf_t* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %18, i8* align 8 %19, i64 32, i1 false)
  %20 = bitcast %struct.circular_buf_t* %4 to i8*
  %21 = bitcast %struct.circular_buf_t* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %20, i8* align 1 %21, i64 32, i1 false)
  %22 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %4, i32 0, i32 1
  %23 = load i64, i64* %22, align 8
  %24 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %4, i32 0, i32 2
  %25 = load i64, i64* %24, align 8
  %26 = icmp eq i64 %23, %25
  br i1 %26, label %51, label %27

27:                                               ; preds = %16
  %28 = load %struct.circular_buf_t*, %struct.circular_buf_t** %5, align 8
  %29 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %28, i32 0, i32 0
  %30 = load i64*, i64** %29, align 8
  %31 = load %struct.circular_buf_t*, %struct.circular_buf_t** %5, align 8
  %32 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %31, i32 0, i32 2
  %33 = load i64, i64* %32, align 8
  %34 = getelementptr inbounds i64, i64* %30, i64 %33
  %35 = load i64, i64* %34, align 8
  %36 = load i64*, i64** %6, align 8
  store i64 %35, i64* %36, align 8
  %37 = load i8, i8* %7, align 1
  %38 = trunc i8 %37 to i1
  br i1 %38, label %39, label %50

39:                                               ; preds = %27
  %40 = load %struct.circular_buf_t*, %struct.circular_buf_t** %5, align 8
  %41 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %40, i32 0, i32 2
  %42 = load i64, i64* %41, align 8
  %43 = add nsw i64 %42, 1
  %44 = load %struct.circular_buf_t*, %struct.circular_buf_t** %5, align 8
  %45 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %44, i32 0, i32 3
  %46 = load i64, i64* %45, align 8
  %47 = srem i64 %43, %46
  %48 = load %struct.circular_buf_t*, %struct.circular_buf_t** %5, align 8
  %49 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %48, i32 0, i32 2
  store i64 %47, i64* %49, align 8
  br label %50

50:                                               ; preds = %39, %27
  store i32 0, i32* %8, align 4
  br label %51

51:                                               ; preds = %50, %16, %13, %3
  %52 = load i32, i32* %8, align 4
  ret i32 %52
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local zeroext i1 @circular_buf_empty(%struct.circular_buf_t* byval(%struct.circular_buf_t) align 8 %0) #0 {
  %2 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %0, i32 0, i32 1
  %3 = load i64, i64* %2, align 8
  %4 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %0, i32 0, i32 2
  %5 = load i64, i64* %4, align 8
  %6 = icmp eq i64 %3, %5
  ret i1 %6
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: alwaysinline nounwind uwtable
define dso_local zeroext i1 @circular_buf_full(%struct.circular_buf_t* byval(%struct.circular_buf_t) align 8 %0) #0 {
  %2 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %0, i32 0, i32 1
  %3 = load i64, i64* %2, align 8
  %4 = add nsw i64 %3, 1
  %5 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %0, i32 0, i32 3
  %6 = load i64, i64* %5, align 8
  %7 = srem i64 %4, %6
  %8 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %0, i32 0, i32 2
  %9 = load i64, i64* %8, align 8
  %10 = icmp eq i64 %7, %9
  ret i1 %10
}

; Function Attrs: alwaysinline uwtable
define dso_local i32 @VFILE_init(%struct.VCHN_t* %0, i64 %1, i64 %2, i8* %3, i64 %4) #1 {
  %6 = alloca %struct.circular_buf_t*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %struct.VCHN_t*, align 8
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i8*, align 8
  %13 = alloca i64, align 8
  %14 = alloca i64, align 8
  store %struct.VCHN_t* %0, %struct.VCHN_t** %9, align 8
  store i64 %1, i64* %10, align 8
  store i64 %2, i64* %11, align 8
  store i8* %3, i8** %12, align 8
  store i64 %4, i64* %13, align 8
  %15 = load i64, i64* %10, align 8
  %16 = load %struct.VCHN_t*, %struct.VCHN_t** %9, align 8
  %17 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %16, i32 0, i32 4
  %18 = load i8, i8* %17, align 8
  %19 = zext i8 %18 to i64
  %20 = sub nsw i64 %15, %19
  store i64 %20, i64* %14, align 8
  %21 = load i8*, i8** %12, align 8
  %22 = bitcast i8* %21 to i64*
  %23 = load %struct.VCHN_t*, %struct.VCHN_t** %9, align 8
  %24 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %23, i32 0, i32 3
  %25 = load %struct.circular_buf_t*, %struct.circular_buf_t** %24, align 8
  %26 = load i64, i64* %14, align 8
  %27 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %25, i64 %26
  %28 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %27, i32 0, i32 0
  store i64* %22, i64** %28, align 8
  %29 = load %struct.VCHN_t*, %struct.VCHN_t** %9, align 8
  %30 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %29, i32 0, i32 3
  %31 = load %struct.circular_buf_t*, %struct.circular_buf_t** %30, align 8
  %32 = load i64, i64* %14, align 8
  %33 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %31, i64 %32
  %34 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %33, i32 0, i32 0
  %35 = load i64*, i64** %34, align 8
  %36 = icmp eq i64* %35, null
  br i1 %36, label %37, label %40

37:                                               ; preds = %5
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str, i64 0, i64 0))
  %39 = sext i32 %38 to i64
  store i64 %39, i64* @controlflow_guarantee, align 8
  store i32 -1, i32* %8, align 4
  br label %67

40:                                               ; preds = %5
  %41 = load i64, i64* %13, align 8
  %42 = icmp eq i64 %41, 1
  br i1 %42, label %43, label %65

43:                                               ; preds = %40
  %44 = load i64, i64* %11, align 8
  %45 = load %struct.VCHN_t*, %struct.VCHN_t** %9, align 8
  %46 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %45, i32 0, i32 3
  %47 = load %struct.circular_buf_t*, %struct.circular_buf_t** %46, align 8
  %48 = load i64, i64* %14, align 8
  %49 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %47, i64 %48
  %50 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %49, i32 0, i32 3
  store i64 %44, i64* %50, align 8
  %51 = load %struct.VCHN_t*, %struct.VCHN_t** %9, align 8
  %52 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %51, i32 0, i32 3
  %53 = load %struct.circular_buf_t*, %struct.circular_buf_t** %52, align 8
  %54 = load i64, i64* %14, align 8
  %55 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %53, i64 %54
  store %struct.circular_buf_t* %55, %struct.circular_buf_t** %6, align 8
  store i32 -1, i32* %7, align 4
  %56 = load %struct.circular_buf_t*, %struct.circular_buf_t** %6, align 8
  %57 = icmp ne %struct.circular_buf_t* %56, null
  br i1 %57, label %58, label %63

58:                                               ; preds = %43
  %59 = load %struct.circular_buf_t*, %struct.circular_buf_t** %6, align 8
  %60 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %59, i32 0, i32 1
  store i64 0, i64* %60, align 8
  %61 = load %struct.circular_buf_t*, %struct.circular_buf_t** %6, align 8
  %62 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %61, i32 0, i32 2
  store i64 0, i64* %62, align 8
  store i32 0, i32* %7, align 4
  br label %63

63:                                               ; preds = %43, %58
  %64 = load i32, i32* %7, align 4
  br label %66

65:                                               ; preds = %40
  br label %66

66:                                               ; preds = %65, %63
  store i32 0, i32* %8, align 4
  br label %67

67:                                               ; preds = %66, %37
  %68 = load i32, i32* %8, align 4
  ret i32 %68
}

declare dso_local i32 @printf(i8*, ...) #3

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @POOL_update(%struct.VCHN_t* %0, i64 %1, i8 zeroext %2, i8 zeroext %3) #0 {
  %5 = alloca %struct.VCHN_t*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8, align 1
  %8 = alloca i8, align 1
  %9 = alloca i8, align 1
  %10 = alloca i8, align 1
  %11 = alloca i8, align 1
  %12 = alloca i8, align 1
  store %struct.VCHN_t* %0, %struct.VCHN_t** %5, align 8
  store i64 %1, i64* %6, align 8
  store i8 %2, i8* %7, align 1
  store i8 %3, i8* %8, align 1
  %13 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %14 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %13, i32 0, i32 5
  %15 = load i8, i8* %14, align 1
  %16 = zext i8 %15 to i32
  %17 = load i8, i8* %7, align 1
  %18 = zext i8 %17 to i32
  %19 = add nsw i32 %16, %18
  %20 = trunc i32 %19 to i8
  store i8 %20, i8* %9, align 1
  %21 = load i64, i64* %6, align 8
  %22 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %23 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %22, i32 0, i32 0
  %24 = load i64*, i64** %23, align 8
  %25 = load i8, i8* %9, align 1
  %26 = zext i8 %25 to i64
  %27 = getelementptr inbounds i64, i64* %24, i64 %26
  store i64 %21, i64* %27, align 8
  %28 = load i8, i8* %7, align 1
  %29 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %30 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %29, i32 0, i32 1
  %31 = load i8*, i8** %30, align 8
  %32 = load i8, i8* %9, align 1
  %33 = zext i8 %32 to i64
  %34 = getelementptr inbounds i8, i8* %31, i64 %33
  store i8 %28, i8* %34, align 1
  %35 = load i8, i8* %8, align 1
  %36 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %37 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %36, i32 0, i32 2
  %38 = load i8*, i8** %37, align 8
  %39 = load i8, i8* %9, align 1
  %40 = zext i8 %39 to i64
  %41 = getelementptr inbounds i8, i8* %38, i64 %40
  store i8 %35, i8* %41, align 1
  br label %42

42:                                               ; preds = %158, %4
  %43 = load i8, i8* %9, align 1
  %44 = zext i8 %43 to i32
  %45 = icmp sgt i32 %44, 0
  br i1 %45, label %46, label %160

46:                                               ; preds = %42
  %47 = load i8, i8* %9, align 1
  %48 = zext i8 %47 to i32
  %49 = sub nsw i32 %48, 1
  %50 = sdiv i32 %49, 2
  %51 = trunc i32 %50 to i8
  store i8 %51, i8* %10, align 1
  %52 = load i8, i8* %10, align 1
  %53 = zext i8 %52 to i32
  %54 = add nsw i32 %53, 1
  %55 = mul nsw i32 %54, 2
  %56 = sub nsw i32 %55, 1
  %57 = trunc i32 %56 to i8
  store i8 %57, i8* %11, align 1
  %58 = load i8, i8* %10, align 1
  %59 = zext i8 %58 to i32
  %60 = add nsw i32 %59, 1
  %61 = mul nsw i32 %60, 2
  %62 = trunc i32 %61 to i8
  store i8 %62, i8* %12, align 1
  %63 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %64 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %63, i32 0, i32 0
  %65 = load i64*, i64** %64, align 8
  %66 = load i8, i8* %11, align 1
  %67 = zext i8 %66 to i64
  %68 = getelementptr inbounds i64, i64* %65, i64 %67
  %69 = load i64, i64* %68, align 8
  %70 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %71 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %70, i32 0, i32 0
  %72 = load i64*, i64** %71, align 8
  %73 = load i8, i8* %12, align 1
  %74 = zext i8 %73 to i64
  %75 = getelementptr inbounds i64, i64* %72, i64 %74
  %76 = load i64, i64* %75, align 8
  %77 = icmp slt i64 %69, %76
  br i1 %77, label %78, label %118

78:                                               ; preds = %46
  %79 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %80 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %79, i32 0, i32 0
  %81 = load i64*, i64** %80, align 8
  %82 = load i8, i8* %11, align 1
  %83 = zext i8 %82 to i64
  %84 = getelementptr inbounds i64, i64* %81, i64 %83
  %85 = load i64, i64* %84, align 8
  %86 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %87 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %86, i32 0, i32 0
  %88 = load i64*, i64** %87, align 8
  %89 = load i8, i8* %10, align 1
  %90 = zext i8 %89 to i64
  %91 = getelementptr inbounds i64, i64* %88, i64 %90
  store i64 %85, i64* %91, align 8
  %92 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %93 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %92, i32 0, i32 1
  %94 = load i8*, i8** %93, align 8
  %95 = load i8, i8* %11, align 1
  %96 = zext i8 %95 to i64
  %97 = getelementptr inbounds i8, i8* %94, i64 %96
  %98 = load i8, i8* %97, align 1
  %99 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %100 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %99, i32 0, i32 1
  %101 = load i8*, i8** %100, align 8
  %102 = load i8, i8* %10, align 1
  %103 = zext i8 %102 to i64
  %104 = getelementptr inbounds i8, i8* %101, i64 %103
  store i8 %98, i8* %104, align 1
  %105 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %106 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %105, i32 0, i32 2
  %107 = load i8*, i8** %106, align 8
  %108 = load i8, i8* %11, align 1
  %109 = zext i8 %108 to i64
  %110 = getelementptr inbounds i8, i8* %107, i64 %109
  %111 = load i8, i8* %110, align 1
  %112 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %113 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %112, i32 0, i32 2
  %114 = load i8*, i8** %113, align 8
  %115 = load i8, i8* %10, align 1
  %116 = zext i8 %115 to i64
  %117 = getelementptr inbounds i8, i8* %114, i64 %116
  store i8 %111, i8* %117, align 1
  br label %158

118:                                              ; preds = %46
  %119 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %120 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %119, i32 0, i32 0
  %121 = load i64*, i64** %120, align 8
  %122 = load i8, i8* %12, align 1
  %123 = zext i8 %122 to i64
  %124 = getelementptr inbounds i64, i64* %121, i64 %123
  %125 = load i64, i64* %124, align 8
  %126 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %127 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %126, i32 0, i32 0
  %128 = load i64*, i64** %127, align 8
  %129 = load i8, i8* %10, align 1
  %130 = zext i8 %129 to i64
  %131 = getelementptr inbounds i64, i64* %128, i64 %130
  store i64 %125, i64* %131, align 8
  %132 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %133 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %132, i32 0, i32 1
  %134 = load i8*, i8** %133, align 8
  %135 = load i8, i8* %12, align 1
  %136 = zext i8 %135 to i64
  %137 = getelementptr inbounds i8, i8* %134, i64 %136
  %138 = load i8, i8* %137, align 1
  %139 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %140 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %139, i32 0, i32 1
  %141 = load i8*, i8** %140, align 8
  %142 = load i8, i8* %10, align 1
  %143 = zext i8 %142 to i64
  %144 = getelementptr inbounds i8, i8* %141, i64 %143
  store i8 %138, i8* %144, align 1
  %145 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %146 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %145, i32 0, i32 2
  %147 = load i8*, i8** %146, align 8
  %148 = load i8, i8* %12, align 1
  %149 = zext i8 %148 to i64
  %150 = getelementptr inbounds i8, i8* %147, i64 %149
  %151 = load i8, i8* %150, align 1
  %152 = load %struct.VCHN_t*, %struct.VCHN_t** %5, align 8
  %153 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %152, i32 0, i32 2
  %154 = load i8*, i8** %153, align 8
  %155 = load i8, i8* %10, align 1
  %156 = zext i8 %155 to i64
  %157 = getelementptr inbounds i8, i8* %154, i64 %156
  store i8 %151, i8* %157, align 1
  br label %158

158:                                              ; preds = %118, %78
  %159 = load i8, i8* %10, align 1
  store i8 %159, i8* %9, align 1
  br label %42

160:                                              ; preds = %42
  ret i32 0
}

; Function Attrs: alwaysinline uwtable
define dso_local i32 @VCHN_init(%struct.VCHN_t* %0, i64 %1, i64 %2, i64 %3, i8* %4, i8* %5, i8* %6, i64 %7, i64 %8, i8* %9) #1 {
  %11 = alloca i32, align 4
  %12 = alloca %struct.VCHN_t*, align 8
  %13 = alloca i64, align 8
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i8*, align 8
  %17 = alloca i8*, align 8
  %18 = alloca i8*, align 8
  %19 = alloca i64, align 8
  %20 = alloca i64, align 8
  %21 = alloca i8*, align 8
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  store %struct.VCHN_t* %0, %struct.VCHN_t** %12, align 8
  store i64 %1, i64* %13, align 8
  store i64 %2, i64* %14, align 8
  store i64 %3, i64* %15, align 8
  store i8* %4, i8** %16, align 8
  store i8* %5, i8** %17, align 8
  store i8* %6, i8** %18, align 8
  store i64 %7, i64* %19, align 8
  store i64 %8, i64* %20, align 8
  store i8* %9, i8** %21, align 8
  %24 = load i64, i64* %13, align 8
  %25 = trunc i64 %24 to i8
  %26 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %27 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %26, i32 0, i32 5
  store i8 %25, i8* %27, align 1
  %28 = load i64, i64* %14, align 8
  %29 = trunc i64 %28 to i8
  %30 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %31 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %30, i32 0, i32 6
  store i8 %29, i8* %31, align 2
  %32 = load i8*, i8** %16, align 8
  %33 = bitcast i8* %32 to i64*
  %34 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %35 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %34, i32 0, i32 0
  store i64* %33, i64** %35, align 8
  %36 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %37 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %36, i32 0, i32 0
  %38 = load i64*, i64** %37, align 8
  %39 = icmp eq i64* %38, null
  br i1 %39, label %40, label %43

40:                                               ; preds = %10
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.1, i64 0, i64 0))
  %42 = sext i32 %41 to i64
  store i64 %42, i64* @controlflow_guarantee, align 8
  store i32 -1, i32* %11, align 4
  br label %140

43:                                               ; preds = %10
  %44 = load i8*, i8** %17, align 8
  %45 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %46 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %45, i32 0, i32 1
  store i8* %44, i8** %46, align 8
  %47 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %48 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %47, i32 0, i32 1
  %49 = load i8*, i8** %48, align 8
  %50 = icmp eq i8* %49, null
  br i1 %50, label %51, label %54

51:                                               ; preds = %43
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([53 x i8], [53 x i8]* @.str.2, i64 0, i64 0))
  %53 = sext i32 %52 to i64
  store i64 %53, i64* @controlflow_guarantee, align 8
  store i32 -1, i32* %11, align 4
  br label %140

54:                                               ; preds = %43
  %55 = load i8*, i8** %18, align 8
  %56 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %57 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %56, i32 0, i32 2
  store i8* %55, i8** %57, align 8
  %58 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %59 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %58, i32 0, i32 2
  %60 = load i8*, i8** %59, align 8
  %61 = icmp eq i8* %60, null
  br i1 %61, label %62, label %65

62:                                               ; preds = %54
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.3, i64 0, i64 0))
  %64 = sext i32 %63 to i64
  store i64 %64, i64* @controlflow_guarantee, align 8
  store i32 -1, i32* %11, align 4
  br label %140

65:                                               ; preds = %54
  %66 = load i64, i64* %19, align 8
  %67 = icmp eq i64 %66, 255
  br i1 %67, label %68, label %122

68:                                               ; preds = %65
  store i32 0, i32* %22, align 4
  br label %69

69:                                               ; preds = %93, %68
  %70 = load i32, i32* %22, align 4
  %71 = sext i32 %70 to i64
  %72 = load i64, i64* %15, align 8
  %73 = icmp slt i64 %71, %72
  br i1 %73, label %74, label %96

74:                                               ; preds = %69
  %75 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %76 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %75, i32 0, i32 0
  %77 = load i64*, i64** %76, align 8
  %78 = load i32, i32* %22, align 4
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds i64, i64* %77, i64 %79
  store i64 9223372036854775807, i64* %80, align 8
  %81 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %82 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %81, i32 0, i32 1
  %83 = load i8*, i8** %82, align 8
  %84 = load i32, i32* %22, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds i8, i8* %83, i64 %85
  store i8 -1, i8* %86, align 1
  %87 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %88 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %87, i32 0, i32 2
  %89 = load i8*, i8** %88, align 8
  %90 = load i32, i32* %22, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds i8, i8* %89, i64 %91
  store i8 -1, i8* %92, align 1
  br label %93

93:                                               ; preds = %74
  %94 = load i32, i32* %22, align 4
  %95 = add nsw i32 %94, 1
  store i32 %95, i32* %22, align 4
  br label %69

96:                                               ; preds = %69
  store i32 0, i32* %23, align 4
  br label %97

97:                                               ; preds = %118, %96
  %98 = load i32, i32* %23, align 4
  %99 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %100 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %99, i32 0, i32 5
  %101 = load i8, i8* %100, align 1
  %102 = zext i8 %101 to i32
  %103 = icmp slt i32 %98, %102
  br i1 %103, label %104, label %121

104:                                              ; preds = %97
  %105 = load i32, i32* %23, align 4
  %106 = trunc i32 %105 to i8
  %107 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %108 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %107, i32 0, i32 1
  %109 = load i8*, i8** %108, align 8
  %110 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %111 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %110, i32 0, i32 5
  %112 = load i8, i8* %111, align 1
  %113 = zext i8 %112 to i32
  %114 = load i32, i32* %23, align 4
  %115 = add nsw i32 %113, %114
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds i8, i8* %109, i64 %116
  store i8 %106, i8* %117, align 1
  br label %118

118:                                              ; preds = %104
  %119 = load i32, i32* %23, align 4
  %120 = add nsw i32 %119, 1
  store i32 %120, i32* %23, align 4
  br label %97

121:                                              ; preds = %97
  br label %123

122:                                              ; preds = %65
  br label %123

123:                                              ; preds = %122, %121
  %124 = load i64, i64* %20, align 8
  %125 = trunc i64 %124 to i8
  %126 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %127 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %126, i32 0, i32 4
  store i8 %125, i8* %127, align 8
  %128 = load i8*, i8** %21, align 8
  %129 = bitcast i8* %128 to %struct.circular_buf_t*
  %130 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %131 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %130, i32 0, i32 3
  store %struct.circular_buf_t* %129, %struct.circular_buf_t** %131, align 8
  %132 = load %struct.VCHN_t*, %struct.VCHN_t** %12, align 8
  %133 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %132, i32 0, i32 3
  %134 = load %struct.circular_buf_t*, %struct.circular_buf_t** %133, align 8
  %135 = icmp eq %struct.circular_buf_t* %134, null
  br i1 %135, label %136, label %139

136:                                              ; preds = %123
  %137 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.4, i64 0, i64 0))
  %138 = sext i32 %137 to i64
  store i64 %138, i64* @controlflow_guarantee, align 8
  store i32 -1, i32* %11, align 4
  br label %140

139:                                              ; preds = %123
  store i32 0, i32* %11, align 4
  br label %140

140:                                              ; preds = %139, %136, %62, %51, %40
  %141 = load i32, i32* %11, align 4
  ret i32 %141
}

; Function Attrs: alwaysinline uwtable
define dso_local i32 @VCHN_put(%struct.VCHN_t* %0, i64 %1, i8 zeroext %2) #1 {
  %4 = alloca %struct.circular_buf_t*, align 8
  %5 = alloca i32, align 4
  %6 = alloca %struct.VCHN_t*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i8, align 1
  %9 = alloca i8, align 1
  %10 = alloca i8, align 1
  %11 = alloca i8, align 1
  %12 = alloca i8, align 1
  %13 = alloca i8, align 1
  %14 = alloca %struct.circular_buf_t, align 8
  %15 = alloca %struct.circular_buf_t*, align 8
  %16 = alloca i64, align 8
  %17 = alloca i32, align 4
  %18 = alloca %struct.VCHN_t*, align 8
  %19 = alloca i64, align 8
  %20 = alloca i8, align 1
  %21 = alloca i8, align 1
  %22 = alloca i8, align 1
  %23 = alloca i8, align 1
  %24 = alloca i8, align 1
  %25 = alloca i8, align 1
  %26 = alloca i32, align 4
  %27 = alloca %struct.VCHN_t*, align 8
  %28 = alloca i64, align 8
  %29 = alloca i8, align 1
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i8, align 1
  %33 = alloca i32, align 4
  %34 = alloca %struct.circular_buf_t, align 8
  %35 = alloca i32, align 4
  store %struct.VCHN_t* %0, %struct.VCHN_t** %27, align 8
  store i64 %1, i64* %28, align 8
  store i8 %2, i8* %29, align 1
  %36 = load i8, i8* %29, align 1
  %37 = zext i8 %36 to i32
  %38 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %39 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %38, i32 0, i32 4
  %40 = load i8, i8* %39, align 8
  %41 = zext i8 %40 to i32
  %42 = sub nsw i32 %37, %41
  store i32 %42, i32* %30, align 4
  %43 = load i32, i32* %30, align 4
  %44 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %45 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %44, i32 0, i32 6
  %46 = load i8, i8* %45, align 2
  %47 = zext i8 %46 to i32
  %48 = add nsw i32 %43, %47
  store i32 %48, i32* %31, align 4
  %49 = load i64, i64* %28, align 8
  %50 = icmp eq i64 %49, 9223372036854775807
  br i1 %50, label %51, label %220

51:                                               ; preds = %3
  %52 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %53 = load i64, i64* %28, align 8
  %54 = load i32, i32* %31, align 4
  %55 = trunc i32 %54 to i8
  %56 = load i8, i8* %29, align 1
  store %struct.VCHN_t* %52, %struct.VCHN_t** %18, align 8
  store i64 %53, i64* %19, align 8
  store i8 %55, i8* %20, align 1
  store i8 %56, i8* %21, align 1
  %57 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %58 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %57, i32 0, i32 5
  %59 = load i8, i8* %58, align 1
  %60 = zext i8 %59 to i32
  %61 = load i8, i8* %20, align 1
  %62 = zext i8 %61 to i32
  %63 = add nsw i32 %60, %62
  %64 = trunc i32 %63 to i8
  store i8 %64, i8* %22, align 1
  %65 = load i64, i64* %19, align 8
  %66 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %67 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %66, i32 0, i32 0
  %68 = load i64*, i64** %67, align 8
  %69 = load i8, i8* %22, align 1
  %70 = zext i8 %69 to i64
  %71 = getelementptr inbounds i64, i64* %68, i64 %70
  store i64 %65, i64* %71, align 8
  %72 = load i8, i8* %20, align 1
  %73 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %74 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %73, i32 0, i32 1
  %75 = load i8*, i8** %74, align 8
  %76 = load i8, i8* %22, align 1
  %77 = zext i8 %76 to i64
  %78 = getelementptr inbounds i8, i8* %75, i64 %77
  store i8 %72, i8* %78, align 1
  %79 = load i8, i8* %21, align 1
  %80 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %81 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %80, i32 0, i32 2
  %82 = load i8*, i8** %81, align 8
  %83 = load i8, i8* %22, align 1
  %84 = zext i8 %83 to i64
  %85 = getelementptr inbounds i8, i8* %82, i64 %84
  store i8 %79, i8* %85, align 1
  br label %86

86:                                               ; preds = %202, %51
  %87 = load i8, i8* %22, align 1
  %88 = zext i8 %87 to i32
  %89 = icmp sgt i32 %88, 0
  br i1 %89, label %90, label %204

90:                                               ; preds = %86
  %91 = load i8, i8* %22, align 1
  %92 = zext i8 %91 to i32
  %93 = sub nsw i32 %92, 1
  %94 = sdiv i32 %93, 2
  %95 = trunc i32 %94 to i8
  store i8 %95, i8* %23, align 1
  %96 = load i8, i8* %23, align 1
  %97 = zext i8 %96 to i32
  %98 = add nsw i32 %97, 1
  %99 = mul nsw i32 %98, 2
  %100 = sub nsw i32 %99, 1
  %101 = trunc i32 %100 to i8
  store i8 %101, i8* %24, align 1
  %102 = load i8, i8* %23, align 1
  %103 = zext i8 %102 to i32
  %104 = add nsw i32 %103, 1
  %105 = mul nsw i32 %104, 2
  %106 = trunc i32 %105 to i8
  store i8 %106, i8* %25, align 1
  %107 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %108 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %107, i32 0, i32 0
  %109 = load i64*, i64** %108, align 8
  %110 = load i8, i8* %24, align 1
  %111 = zext i8 %110 to i64
  %112 = getelementptr inbounds i64, i64* %109, i64 %111
  %113 = load i64, i64* %112, align 8
  %114 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %115 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %114, i32 0, i32 0
  %116 = load i64*, i64** %115, align 8
  %117 = load i8, i8* %25, align 1
  %118 = zext i8 %117 to i64
  %119 = getelementptr inbounds i64, i64* %116, i64 %118
  %120 = load i64, i64* %119, align 8
  %121 = icmp slt i64 %113, %120
  br i1 %121, label %122, label %162

122:                                              ; preds = %90
  %123 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %124 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %123, i32 0, i32 0
  %125 = load i64*, i64** %124, align 8
  %126 = load i8, i8* %24, align 1
  %127 = zext i8 %126 to i64
  %128 = getelementptr inbounds i64, i64* %125, i64 %127
  %129 = load i64, i64* %128, align 8
  %130 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %131 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %130, i32 0, i32 0
  %132 = load i64*, i64** %131, align 8
  %133 = load i8, i8* %23, align 1
  %134 = zext i8 %133 to i64
  %135 = getelementptr inbounds i64, i64* %132, i64 %134
  store i64 %129, i64* %135, align 8
  %136 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %137 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %136, i32 0, i32 1
  %138 = load i8*, i8** %137, align 8
  %139 = load i8, i8* %24, align 1
  %140 = zext i8 %139 to i64
  %141 = getelementptr inbounds i8, i8* %138, i64 %140
  %142 = load i8, i8* %141, align 1
  %143 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %144 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %143, i32 0, i32 1
  %145 = load i8*, i8** %144, align 8
  %146 = load i8, i8* %23, align 1
  %147 = zext i8 %146 to i64
  %148 = getelementptr inbounds i8, i8* %145, i64 %147
  store i8 %142, i8* %148, align 1
  %149 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %150 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %149, i32 0, i32 2
  %151 = load i8*, i8** %150, align 8
  %152 = load i8, i8* %24, align 1
  %153 = zext i8 %152 to i64
  %154 = getelementptr inbounds i8, i8* %151, i64 %153
  %155 = load i8, i8* %154, align 1
  %156 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %157 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %156, i32 0, i32 2
  %158 = load i8*, i8** %157, align 8
  %159 = load i8, i8* %23, align 1
  %160 = zext i8 %159 to i64
  %161 = getelementptr inbounds i8, i8* %158, i64 %160
  store i8 %155, i8* %161, align 1
  br label %202

162:                                              ; preds = %90
  %163 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %164 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %163, i32 0, i32 0
  %165 = load i64*, i64** %164, align 8
  %166 = load i8, i8* %25, align 1
  %167 = zext i8 %166 to i64
  %168 = getelementptr inbounds i64, i64* %165, i64 %167
  %169 = load i64, i64* %168, align 8
  %170 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %171 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %170, i32 0, i32 0
  %172 = load i64*, i64** %171, align 8
  %173 = load i8, i8* %23, align 1
  %174 = zext i8 %173 to i64
  %175 = getelementptr inbounds i64, i64* %172, i64 %174
  store i64 %169, i64* %175, align 8
  %176 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %177 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %176, i32 0, i32 1
  %178 = load i8*, i8** %177, align 8
  %179 = load i8, i8* %25, align 1
  %180 = zext i8 %179 to i64
  %181 = getelementptr inbounds i8, i8* %178, i64 %180
  %182 = load i8, i8* %181, align 1
  %183 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %184 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %183, i32 0, i32 1
  %185 = load i8*, i8** %184, align 8
  %186 = load i8, i8* %23, align 1
  %187 = zext i8 %186 to i64
  %188 = getelementptr inbounds i8, i8* %185, i64 %187
  store i8 %182, i8* %188, align 1
  %189 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %190 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %189, i32 0, i32 2
  %191 = load i8*, i8** %190, align 8
  %192 = load i8, i8* %25, align 1
  %193 = zext i8 %192 to i64
  %194 = getelementptr inbounds i8, i8* %191, i64 %193
  %195 = load i8, i8* %194, align 1
  %196 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %197 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %196, i32 0, i32 2
  %198 = load i8*, i8** %197, align 8
  %199 = load i8, i8* %23, align 1
  %200 = zext i8 %199 to i64
  %201 = getelementptr inbounds i8, i8* %198, i64 %200
  store i8 %195, i8* %201, align 1
  br label %202

202:                                              ; preds = %162, %122
  %203 = load i8, i8* %23, align 1
  store i8 %203, i8* %22, align 1
  br label %86

204:                                              ; preds = %86
  %205 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %206 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %205, i32 0, i32 3
  %207 = load %struct.circular_buf_t*, %struct.circular_buf_t** %206, align 8
  %208 = load i32, i32* %30, align 4
  %209 = sext i32 %208 to i64
  %210 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %207, i64 %209
  store %struct.circular_buf_t* %210, %struct.circular_buf_t** %4, align 8
  store i32 -1, i32* %5, align 4
  %211 = load %struct.circular_buf_t*, %struct.circular_buf_t** %4, align 8
  %212 = icmp ne %struct.circular_buf_t* %211, null
  br i1 %212, label %213, label %218

213:                                              ; preds = %204
  %214 = load %struct.circular_buf_t*, %struct.circular_buf_t** %4, align 8
  %215 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %214, i32 0, i32 1
  store i64 0, i64* %215, align 8
  %216 = load %struct.circular_buf_t*, %struct.circular_buf_t** %4, align 8
  %217 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %216, i32 0, i32 2
  store i64 0, i64* %217, align 8
  store i32 0, i32* %5, align 4
  br label %218

218:                                              ; preds = %204, %213
  %219 = load i32, i32* %5, align 4
  store i32 -1, i32* %26, align 4
  br label %477

220:                                              ; preds = %3
  %221 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %222 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %221, i32 0, i32 5
  %223 = load i8, i8* %222, align 1
  %224 = zext i8 %223 to i32
  %225 = load i32, i32* %31, align 4
  %226 = add nsw i32 %224, %225
  %227 = trunc i32 %226 to i8
  store i8 %227, i8* %32, align 1
  %228 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %229 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %228, i32 0, i32 0
  %230 = load i64*, i64** %229, align 8
  %231 = load i8, i8* %32, align 1
  %232 = zext i8 %231 to i64
  %233 = getelementptr inbounds i64, i64* %230, i64 %232
  %234 = load i64, i64* %233, align 8
  %235 = icmp eq i64 %234, 9223372036854775807
  br i1 %235, label %236, label %391

236:                                              ; preds = %220
  %237 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %238 = load i64, i64* %28, align 8
  %239 = load i32, i32* %31, align 4
  %240 = trunc i32 %239 to i8
  %241 = load i8, i8* %29, align 1
  store %struct.VCHN_t* %237, %struct.VCHN_t** %6, align 8
  store i64 %238, i64* %7, align 8
  store i8 %240, i8* %8, align 1
  store i8 %241, i8* %9, align 1
  %242 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %243 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %242, i32 0, i32 5
  %244 = load i8, i8* %243, align 1
  %245 = zext i8 %244 to i32
  %246 = load i8, i8* %8, align 1
  %247 = zext i8 %246 to i32
  %248 = add nsw i32 %245, %247
  %249 = trunc i32 %248 to i8
  store i8 %249, i8* %10, align 1
  %250 = load i64, i64* %7, align 8
  %251 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %252 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %251, i32 0, i32 0
  %253 = load i64*, i64** %252, align 8
  %254 = load i8, i8* %10, align 1
  %255 = zext i8 %254 to i64
  %256 = getelementptr inbounds i64, i64* %253, i64 %255
  store i64 %250, i64* %256, align 8
  %257 = load i8, i8* %8, align 1
  %258 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %259 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %258, i32 0, i32 1
  %260 = load i8*, i8** %259, align 8
  %261 = load i8, i8* %10, align 1
  %262 = zext i8 %261 to i64
  %263 = getelementptr inbounds i8, i8* %260, i64 %262
  store i8 %257, i8* %263, align 1
  %264 = load i8, i8* %9, align 1
  %265 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %266 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %265, i32 0, i32 2
  %267 = load i8*, i8** %266, align 8
  %268 = load i8, i8* %10, align 1
  %269 = zext i8 %268 to i64
  %270 = getelementptr inbounds i8, i8* %267, i64 %269
  store i8 %264, i8* %270, align 1
  br label %271

271:                                              ; preds = %387, %236
  %272 = load i8, i8* %10, align 1
  %273 = zext i8 %272 to i32
  %274 = icmp sgt i32 %273, 0
  br i1 %274, label %275, label %389

275:                                              ; preds = %271
  %276 = load i8, i8* %10, align 1
  %277 = zext i8 %276 to i32
  %278 = sub nsw i32 %277, 1
  %279 = sdiv i32 %278, 2
  %280 = trunc i32 %279 to i8
  store i8 %280, i8* %11, align 1
  %281 = load i8, i8* %11, align 1
  %282 = zext i8 %281 to i32
  %283 = add nsw i32 %282, 1
  %284 = mul nsw i32 %283, 2
  %285 = sub nsw i32 %284, 1
  %286 = trunc i32 %285 to i8
  store i8 %286, i8* %12, align 1
  %287 = load i8, i8* %11, align 1
  %288 = zext i8 %287 to i32
  %289 = add nsw i32 %288, 1
  %290 = mul nsw i32 %289, 2
  %291 = trunc i32 %290 to i8
  store i8 %291, i8* %13, align 1
  %292 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %293 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %292, i32 0, i32 0
  %294 = load i64*, i64** %293, align 8
  %295 = load i8, i8* %12, align 1
  %296 = zext i8 %295 to i64
  %297 = getelementptr inbounds i64, i64* %294, i64 %296
  %298 = load i64, i64* %297, align 8
  %299 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %300 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %299, i32 0, i32 0
  %301 = load i64*, i64** %300, align 8
  %302 = load i8, i8* %13, align 1
  %303 = zext i8 %302 to i64
  %304 = getelementptr inbounds i64, i64* %301, i64 %303
  %305 = load i64, i64* %304, align 8
  %306 = icmp slt i64 %298, %305
  br i1 %306, label %307, label %347

307:                                              ; preds = %275
  %308 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %309 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %308, i32 0, i32 0
  %310 = load i64*, i64** %309, align 8
  %311 = load i8, i8* %12, align 1
  %312 = zext i8 %311 to i64
  %313 = getelementptr inbounds i64, i64* %310, i64 %312
  %314 = load i64, i64* %313, align 8
  %315 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %316 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %315, i32 0, i32 0
  %317 = load i64*, i64** %316, align 8
  %318 = load i8, i8* %11, align 1
  %319 = zext i8 %318 to i64
  %320 = getelementptr inbounds i64, i64* %317, i64 %319
  store i64 %314, i64* %320, align 8
  %321 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %322 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %321, i32 0, i32 1
  %323 = load i8*, i8** %322, align 8
  %324 = load i8, i8* %12, align 1
  %325 = zext i8 %324 to i64
  %326 = getelementptr inbounds i8, i8* %323, i64 %325
  %327 = load i8, i8* %326, align 1
  %328 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %329 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %328, i32 0, i32 1
  %330 = load i8*, i8** %329, align 8
  %331 = load i8, i8* %11, align 1
  %332 = zext i8 %331 to i64
  %333 = getelementptr inbounds i8, i8* %330, i64 %332
  store i8 %327, i8* %333, align 1
  %334 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %335 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %334, i32 0, i32 2
  %336 = load i8*, i8** %335, align 8
  %337 = load i8, i8* %12, align 1
  %338 = zext i8 %337 to i64
  %339 = getelementptr inbounds i8, i8* %336, i64 %338
  %340 = load i8, i8* %339, align 1
  %341 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %342 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %341, i32 0, i32 2
  %343 = load i8*, i8** %342, align 8
  %344 = load i8, i8* %11, align 1
  %345 = zext i8 %344 to i64
  %346 = getelementptr inbounds i8, i8* %343, i64 %345
  store i8 %340, i8* %346, align 1
  br label %387

347:                                              ; preds = %275
  %348 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %349 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %348, i32 0, i32 0
  %350 = load i64*, i64** %349, align 8
  %351 = load i8, i8* %13, align 1
  %352 = zext i8 %351 to i64
  %353 = getelementptr inbounds i64, i64* %350, i64 %352
  %354 = load i64, i64* %353, align 8
  %355 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %356 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %355, i32 0, i32 0
  %357 = load i64*, i64** %356, align 8
  %358 = load i8, i8* %11, align 1
  %359 = zext i8 %358 to i64
  %360 = getelementptr inbounds i64, i64* %357, i64 %359
  store i64 %354, i64* %360, align 8
  %361 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %362 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %361, i32 0, i32 1
  %363 = load i8*, i8** %362, align 8
  %364 = load i8, i8* %13, align 1
  %365 = zext i8 %364 to i64
  %366 = getelementptr inbounds i8, i8* %363, i64 %365
  %367 = load i8, i8* %366, align 1
  %368 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %369 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %368, i32 0, i32 1
  %370 = load i8*, i8** %369, align 8
  %371 = load i8, i8* %11, align 1
  %372 = zext i8 %371 to i64
  %373 = getelementptr inbounds i8, i8* %370, i64 %372
  store i8 %367, i8* %373, align 1
  %374 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %375 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %374, i32 0, i32 2
  %376 = load i8*, i8** %375, align 8
  %377 = load i8, i8* %13, align 1
  %378 = zext i8 %377 to i64
  %379 = getelementptr inbounds i8, i8* %376, i64 %378
  %380 = load i8, i8* %379, align 1
  %381 = load %struct.VCHN_t*, %struct.VCHN_t** %6, align 8
  %382 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %381, i32 0, i32 2
  %383 = load i8*, i8** %382, align 8
  %384 = load i8, i8* %11, align 1
  %385 = zext i8 %384 to i64
  %386 = getelementptr inbounds i8, i8* %383, i64 %385
  store i8 %380, i8* %386, align 1
  br label %387

387:                                              ; preds = %347, %307
  %388 = load i8, i8* %11, align 1
  store i8 %388, i8* %10, align 1
  br label %271

389:                                              ; preds = %271
  store i32 0, i32* %33, align 4
  %390 = load i32, i32* %33, align 4
  store i32 %390, i32* %26, align 4
  br label %477

391:                                              ; preds = %220
  %392 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %393 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %392, i32 0, i32 3
  %394 = load %struct.circular_buf_t*, %struct.circular_buf_t** %393, align 8
  %395 = load i32, i32* %30, align 4
  %396 = sext i32 %395 to i64
  %397 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %394, i64 %396
  %398 = bitcast %struct.circular_buf_t* %34 to i8*
  %399 = bitcast %struct.circular_buf_t* %397 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %398, i8* align 8 %399, i64 32, i1 false)
  %400 = bitcast %struct.circular_buf_t* %14 to i8*
  %401 = bitcast %struct.circular_buf_t* %34 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %400, i8* align 1 %401, i64 32, i1 false)
  %402 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %14, i32 0, i32 1
  %403 = load i64, i64* %402, align 8
  %404 = add nsw i64 %403, 1
  %405 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %14, i32 0, i32 3
  %406 = load i64, i64* %405, align 8
  %407 = srem i64 %404, %406
  %408 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %14, i32 0, i32 2
  %409 = load i64, i64* %408, align 8
  %410 = icmp eq i64 %407, %409
  br i1 %410, label %411, label %426

411:                                              ; preds = %391
  %412 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %413 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %412, i32 0, i32 3
  %414 = load %struct.circular_buf_t*, %struct.circular_buf_t** %413, align 8
  %415 = load i32, i32* %30, align 4
  %416 = sext i32 %415 to i64
  %417 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %414, i64 %416
  %418 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %417, i32 0, i32 0
  %419 = load i64*, i64** %418, align 8
  %420 = ptrtoint i64* %419 to i64
  %421 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.5, i64 0, i64 0), i64 %420)
  %422 = sext i32 %421 to i64
  store i64 %422, i64* @controlflow_guarantee, align 8
  br label %423

423:                                              ; preds = %411, %423
  %424 = load i64, i64* @controlflow_guarantee, align 8
  %425 = add nsw i64 %424, 1
  store i64 %425, i64* @controlflow_guarantee, align 8
  br label %423

426:                                              ; preds = %391
  %427 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %428 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %427, i32 0, i32 3
  %429 = load %struct.circular_buf_t*, %struct.circular_buf_t** %428, align 8
  %430 = load i32, i32* %30, align 4
  %431 = sext i32 %430 to i64
  %432 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %429, i64 %431
  %433 = load i64, i64* %28, align 8
  store %struct.circular_buf_t* %432, %struct.circular_buf_t** %15, align 8
  store i64 %433, i64* %16, align 8
  store i32 -1, i32* %17, align 4
  %434 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %435 = icmp ne %struct.circular_buf_t* %434, null
  br i1 %435, label %436, label %474

436:                                              ; preds = %426
  %437 = load i64, i64* %16, align 8
  %438 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %439 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %438, i32 0, i32 0
  %440 = load i64*, i64** %439, align 8
  %441 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %442 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %441, i32 0, i32 1
  %443 = load i64, i64* %442, align 8
  %444 = getelementptr inbounds i64, i64* %440, i64 %443
  store i64 %437, i64* %444, align 8
  %445 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %446 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %445, i32 0, i32 1
  %447 = load i64, i64* %446, align 8
  %448 = add nsw i64 %447, 1
  %449 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %450 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %449, i32 0, i32 3
  %451 = load i64, i64* %450, align 8
  %452 = srem i64 %448, %451
  %453 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %454 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %453, i32 0, i32 1
  store i64 %452, i64* %454, align 8
  %455 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %456 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %455, i32 0, i32 1
  %457 = load i64, i64* %456, align 8
  %458 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %459 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %458, i32 0, i32 2
  %460 = load i64, i64* %459, align 8
  %461 = icmp eq i64 %457, %460
  br i1 %461, label %462, label %473

462:                                              ; preds = %436
  %463 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %464 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %463, i32 0, i32 2
  %465 = load i64, i64* %464, align 8
  %466 = add nsw i64 %465, 1
  %467 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %468 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %467, i32 0, i32 3
  %469 = load i64, i64* %468, align 8
  %470 = srem i64 %466, %469
  %471 = load %struct.circular_buf_t*, %struct.circular_buf_t** %15, align 8
  %472 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %471, i32 0, i32 2
  store i64 %470, i64* %472, align 8
  br label %473

473:                                              ; preds = %462, %436
  store i32 0, i32* %17, align 4
  br label %474

474:                                              ; preds = %426, %473
  %475 = load i32, i32* %17, align 4
  store i32 %475, i32* %35, align 4
  %476 = load i32, i32* %35, align 4
  store i32 %476, i32* %26, align 4
  br label %477

477:                                              ; preds = %474, %389, %218
  %478 = load i32, i32* %26, align 4
  ret i32 %478
}

; Function Attrs: alwaysinline uwtable
define dso_local i64 @VCHN_next(%struct.VCHN_t* %0, i8* %1, i8* %2) #1 {
  %4 = alloca %struct.VCHN_t*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8, align 1
  %7 = alloca i8, align 1
  %8 = alloca i8, align 1
  %9 = alloca i8, align 1
  %10 = alloca i8, align 1
  %11 = alloca i8, align 1
  %12 = alloca %struct.circular_buf_t, align 8
  %13 = alloca %struct.circular_buf_t*, align 8
  %14 = alloca i64*, align 8
  %15 = alloca i8, align 1
  %16 = alloca i32, align 4
  %17 = alloca %struct.circular_buf_t, align 8
  %18 = alloca %struct.VCHN_t*, align 8
  %19 = alloca i64, align 8
  %20 = alloca i8, align 1
  %21 = alloca i8, align 1
  %22 = alloca i8, align 1
  %23 = alloca i8, align 1
  %24 = alloca i8, align 1
  %25 = alloca i8, align 1
  %26 = alloca %struct.circular_buf_t, align 8
  %27 = alloca %struct.VCHN_t*, align 8
  %28 = alloca i8*, align 8
  %29 = alloca i8*, align 8
  %30 = alloca i64, align 8
  %31 = alloca i8, align 1
  %32 = alloca i8, align 1
  %33 = alloca i32, align 4
  %34 = alloca %struct.circular_buf_t, align 8
  %35 = alloca i64, align 8
  store %struct.VCHN_t* %0, %struct.VCHN_t** %27, align 8
  store i8* %1, i8** %28, align 8
  store i8* %2, i8** %29, align 8
  %36 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %37 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %36, i32 0, i32 0
  %38 = load i64*, i64** %37, align 8
  %39 = getelementptr inbounds i64, i64* %38, i64 0
  %40 = load i64, i64* %39, align 8
  store i64 %40, i64* %30, align 8
  %41 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %42 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %41, i32 0, i32 1
  %43 = load i8*, i8** %42, align 8
  %44 = getelementptr inbounds i8, i8* %43, i64 0
  %45 = load i8, i8* %44, align 1
  store i8 %45, i8* %31, align 1
  %46 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %47 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %46, i32 0, i32 2
  %48 = load i8*, i8** %47, align 8
  %49 = getelementptr inbounds i8, i8* %48, i64 0
  %50 = load i8, i8* %49, align 1
  store i8 %50, i8* %32, align 1
  %51 = load i64, i64* %30, align 8
  %52 = icmp slt i64 %51, 9223372036854775807
  br i1 %52, label %53, label %434

53:                                               ; preds = %3
  %54 = load i8, i8* %31, align 1
  %55 = zext i8 %54 to i32
  %56 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %57 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %56, i32 0, i32 6
  %58 = load i8, i8* %57, align 2
  %59 = zext i8 %58 to i32
  %60 = sub nsw i32 %55, %59
  store i32 %60, i32* %33, align 4
  %61 = load i32, i32* %33, align 4
  %62 = icmp sge i32 %61, 0
  br i1 %62, label %63, label %433

63:                                               ; preds = %53
  %64 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %65 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %64, i32 0, i32 3
  %66 = load %struct.circular_buf_t*, %struct.circular_buf_t** %65, align 8
  %67 = load i32, i32* %33, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %66, i64 %68
  %70 = bitcast %struct.circular_buf_t* %34 to i8*
  %71 = bitcast %struct.circular_buf_t* %69 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %70, i8* align 8 %71, i64 32, i1 false)
  %72 = bitcast %struct.circular_buf_t* %26 to i8*
  %73 = bitcast %struct.circular_buf_t* %34 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %72, i8* align 1 %73, i64 32, i1 false)
  %74 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %26, i32 0, i32 1
  %75 = load i64, i64* %74, align 8
  %76 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %26, i32 0, i32 2
  %77 = load i64, i64* %76, align 8
  %78 = icmp eq i64 %75, %77
  br i1 %78, label %79, label %231

79:                                               ; preds = %63
  %80 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %81 = load i8, i8* %31, align 1
  %82 = load i8, i8* %32, align 1
  store %struct.VCHN_t* %80, %struct.VCHN_t** %4, align 8
  store i64 9223372036854775807, i64* %5, align 8
  store i8 %81, i8* %6, align 1
  store i8 %82, i8* %7, align 1
  %83 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %84 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %83, i32 0, i32 5
  %85 = load i8, i8* %84, align 1
  %86 = zext i8 %85 to i32
  %87 = load i8, i8* %6, align 1
  %88 = zext i8 %87 to i32
  %89 = add nsw i32 %86, %88
  %90 = trunc i32 %89 to i8
  store i8 %90, i8* %8, align 1
  %91 = load i64, i64* %5, align 8
  %92 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %93 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %92, i32 0, i32 0
  %94 = load i64*, i64** %93, align 8
  %95 = load i8, i8* %8, align 1
  %96 = zext i8 %95 to i64
  %97 = getelementptr inbounds i64, i64* %94, i64 %96
  store i64 %91, i64* %97, align 8
  %98 = load i8, i8* %6, align 1
  %99 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %100 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %99, i32 0, i32 1
  %101 = load i8*, i8** %100, align 8
  %102 = load i8, i8* %8, align 1
  %103 = zext i8 %102 to i64
  %104 = getelementptr inbounds i8, i8* %101, i64 %103
  store i8 %98, i8* %104, align 1
  %105 = load i8, i8* %7, align 1
  %106 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %107 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %106, i32 0, i32 2
  %108 = load i8*, i8** %107, align 8
  %109 = load i8, i8* %8, align 1
  %110 = zext i8 %109 to i64
  %111 = getelementptr inbounds i8, i8* %108, i64 %110
  store i8 %105, i8* %111, align 1
  br label %112

112:                                              ; preds = %228, %79
  %113 = load i8, i8* %8, align 1
  %114 = zext i8 %113 to i32
  %115 = icmp sgt i32 %114, 0
  br i1 %115, label %116, label %230

116:                                              ; preds = %112
  %117 = load i8, i8* %8, align 1
  %118 = zext i8 %117 to i32
  %119 = sub nsw i32 %118, 1
  %120 = sdiv i32 %119, 2
  %121 = trunc i32 %120 to i8
  store i8 %121, i8* %9, align 1
  %122 = load i8, i8* %9, align 1
  %123 = zext i8 %122 to i32
  %124 = add nsw i32 %123, 1
  %125 = mul nsw i32 %124, 2
  %126 = sub nsw i32 %125, 1
  %127 = trunc i32 %126 to i8
  store i8 %127, i8* %10, align 1
  %128 = load i8, i8* %9, align 1
  %129 = zext i8 %128 to i32
  %130 = add nsw i32 %129, 1
  %131 = mul nsw i32 %130, 2
  %132 = trunc i32 %131 to i8
  store i8 %132, i8* %11, align 1
  %133 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %134 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %133, i32 0, i32 0
  %135 = load i64*, i64** %134, align 8
  %136 = load i8, i8* %10, align 1
  %137 = zext i8 %136 to i64
  %138 = getelementptr inbounds i64, i64* %135, i64 %137
  %139 = load i64, i64* %138, align 8
  %140 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %141 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %140, i32 0, i32 0
  %142 = load i64*, i64** %141, align 8
  %143 = load i8, i8* %11, align 1
  %144 = zext i8 %143 to i64
  %145 = getelementptr inbounds i64, i64* %142, i64 %144
  %146 = load i64, i64* %145, align 8
  %147 = icmp slt i64 %139, %146
  br i1 %147, label %148, label %188

148:                                              ; preds = %116
  %149 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %150 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %149, i32 0, i32 0
  %151 = load i64*, i64** %150, align 8
  %152 = load i8, i8* %10, align 1
  %153 = zext i8 %152 to i64
  %154 = getelementptr inbounds i64, i64* %151, i64 %153
  %155 = load i64, i64* %154, align 8
  %156 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %157 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %156, i32 0, i32 0
  %158 = load i64*, i64** %157, align 8
  %159 = load i8, i8* %9, align 1
  %160 = zext i8 %159 to i64
  %161 = getelementptr inbounds i64, i64* %158, i64 %160
  store i64 %155, i64* %161, align 8
  %162 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %163 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %162, i32 0, i32 1
  %164 = load i8*, i8** %163, align 8
  %165 = load i8, i8* %10, align 1
  %166 = zext i8 %165 to i64
  %167 = getelementptr inbounds i8, i8* %164, i64 %166
  %168 = load i8, i8* %167, align 1
  %169 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %170 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %169, i32 0, i32 1
  %171 = load i8*, i8** %170, align 8
  %172 = load i8, i8* %9, align 1
  %173 = zext i8 %172 to i64
  %174 = getelementptr inbounds i8, i8* %171, i64 %173
  store i8 %168, i8* %174, align 1
  %175 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %176 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %175, i32 0, i32 2
  %177 = load i8*, i8** %176, align 8
  %178 = load i8, i8* %10, align 1
  %179 = zext i8 %178 to i64
  %180 = getelementptr inbounds i8, i8* %177, i64 %179
  %181 = load i8, i8* %180, align 1
  %182 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %183 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %182, i32 0, i32 2
  %184 = load i8*, i8** %183, align 8
  %185 = load i8, i8* %9, align 1
  %186 = zext i8 %185 to i64
  %187 = getelementptr inbounds i8, i8* %184, i64 %186
  store i8 %181, i8* %187, align 1
  br label %228

188:                                              ; preds = %116
  %189 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %190 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %189, i32 0, i32 0
  %191 = load i64*, i64** %190, align 8
  %192 = load i8, i8* %11, align 1
  %193 = zext i8 %192 to i64
  %194 = getelementptr inbounds i64, i64* %191, i64 %193
  %195 = load i64, i64* %194, align 8
  %196 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %197 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %196, i32 0, i32 0
  %198 = load i64*, i64** %197, align 8
  %199 = load i8, i8* %9, align 1
  %200 = zext i8 %199 to i64
  %201 = getelementptr inbounds i64, i64* %198, i64 %200
  store i64 %195, i64* %201, align 8
  %202 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %203 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %202, i32 0, i32 1
  %204 = load i8*, i8** %203, align 8
  %205 = load i8, i8* %11, align 1
  %206 = zext i8 %205 to i64
  %207 = getelementptr inbounds i8, i8* %204, i64 %206
  %208 = load i8, i8* %207, align 1
  %209 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %210 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %209, i32 0, i32 1
  %211 = load i8*, i8** %210, align 8
  %212 = load i8, i8* %9, align 1
  %213 = zext i8 %212 to i64
  %214 = getelementptr inbounds i8, i8* %211, i64 %213
  store i8 %208, i8* %214, align 1
  %215 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %216 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %215, i32 0, i32 2
  %217 = load i8*, i8** %216, align 8
  %218 = load i8, i8* %11, align 1
  %219 = zext i8 %218 to i64
  %220 = getelementptr inbounds i8, i8* %217, i64 %219
  %221 = load i8, i8* %220, align 1
  %222 = load %struct.VCHN_t*, %struct.VCHN_t** %4, align 8
  %223 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %222, i32 0, i32 2
  %224 = load i8*, i8** %223, align 8
  %225 = load i8, i8* %9, align 1
  %226 = zext i8 %225 to i64
  %227 = getelementptr inbounds i8, i8* %224, i64 %226
  store i8 %221, i8* %227, align 1
  br label %228

228:                                              ; preds = %188, %148
  %229 = load i8, i8* %9, align 1
  store i8 %229, i8* %8, align 1
  br label %112

230:                                              ; preds = %112
  br label %432

231:                                              ; preds = %63
  %232 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %233 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %232, i32 0, i32 3
  %234 = load %struct.circular_buf_t*, %struct.circular_buf_t** %233, align 8
  %235 = load i32, i32* %33, align 4
  %236 = sext i32 %235 to i64
  %237 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %234, i64 %236
  store %struct.circular_buf_t* %237, %struct.circular_buf_t** %13, align 8
  store i64* %35, i64** %14, align 8
  store i8 1, i8* %15, align 1
  store i32 -1, i32* %16, align 4
  %238 = load %struct.circular_buf_t*, %struct.circular_buf_t** %13, align 8
  %239 = icmp ne %struct.circular_buf_t* %238, null
  br i1 %239, label %240, label %278

240:                                              ; preds = %231
  %241 = load i64*, i64** %14, align 8
  %242 = icmp ne i64* %241, null
  br i1 %242, label %243, label %278

243:                                              ; preds = %240
  %244 = load %struct.circular_buf_t*, %struct.circular_buf_t** %13, align 8
  %245 = bitcast %struct.circular_buf_t* %17 to i8*
  %246 = bitcast %struct.circular_buf_t* %244 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %245, i8* align 8 %246, i64 32, i1 false)
  %247 = bitcast %struct.circular_buf_t* %12 to i8*
  %248 = bitcast %struct.circular_buf_t* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %247, i8* align 1 %248, i64 32, i1 false)
  %249 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %12, i32 0, i32 1
  %250 = load i64, i64* %249, align 8
  %251 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %12, i32 0, i32 2
  %252 = load i64, i64* %251, align 8
  %253 = icmp eq i64 %250, %252
  br i1 %253, label %278, label %254

254:                                              ; preds = %243
  %255 = load %struct.circular_buf_t*, %struct.circular_buf_t** %13, align 8
  %256 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %255, i32 0, i32 0
  %257 = load i64*, i64** %256, align 8
  %258 = load %struct.circular_buf_t*, %struct.circular_buf_t** %13, align 8
  %259 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %258, i32 0, i32 2
  %260 = load i64, i64* %259, align 8
  %261 = getelementptr inbounds i64, i64* %257, i64 %260
  %262 = load i64, i64* %261, align 8
  %263 = load i64*, i64** %14, align 8
  store i64 %262, i64* %263, align 8
  %264 = load i8, i8* %15, align 1
  %265 = trunc i8 %264 to i1
  br i1 %265, label %266, label %277

266:                                              ; preds = %254
  %267 = load %struct.circular_buf_t*, %struct.circular_buf_t** %13, align 8
  %268 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %267, i32 0, i32 2
  %269 = load i64, i64* %268, align 8
  %270 = add nsw i64 %269, 1
  %271 = load %struct.circular_buf_t*, %struct.circular_buf_t** %13, align 8
  %272 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %271, i32 0, i32 3
  %273 = load i64, i64* %272, align 8
  %274 = srem i64 %270, %273
  %275 = load %struct.circular_buf_t*, %struct.circular_buf_t** %13, align 8
  %276 = getelementptr inbounds %struct.circular_buf_t, %struct.circular_buf_t* %275, i32 0, i32 2
  store i64 %274, i64* %276, align 8
  br label %277

277:                                              ; preds = %266, %254
  store i32 0, i32* %16, align 4
  br label %278

278:                                              ; preds = %231, %240, %243, %277
  %279 = load i32, i32* %16, align 4
  %280 = load %struct.VCHN_t*, %struct.VCHN_t** %27, align 8
  %281 = load i64, i64* %35, align 8
  %282 = load i8, i8* %31, align 1
  %283 = load i8, i8* %32, align 1
  store %struct.VCHN_t* %280, %struct.VCHN_t** %18, align 8
  store i64 %281, i64* %19, align 8
  store i8 %282, i8* %20, align 1
  store i8 %283, i8* %21, align 1
  %284 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %285 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %284, i32 0, i32 5
  %286 = load i8, i8* %285, align 1
  %287 = zext i8 %286 to i32
  %288 = load i8, i8* %20, align 1
  %289 = zext i8 %288 to i32
  %290 = add nsw i32 %287, %289
  %291 = trunc i32 %290 to i8
  store i8 %291, i8* %22, align 1
  %292 = load i64, i64* %19, align 8
  %293 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %294 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %293, i32 0, i32 0
  %295 = load i64*, i64** %294, align 8
  %296 = load i8, i8* %22, align 1
  %297 = zext i8 %296 to i64
  %298 = getelementptr inbounds i64, i64* %295, i64 %297
  store i64 %292, i64* %298, align 8
  %299 = load i8, i8* %20, align 1
  %300 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %301 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %300, i32 0, i32 1
  %302 = load i8*, i8** %301, align 8
  %303 = load i8, i8* %22, align 1
  %304 = zext i8 %303 to i64
  %305 = getelementptr inbounds i8, i8* %302, i64 %304
  store i8 %299, i8* %305, align 1
  %306 = load i8, i8* %21, align 1
  %307 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %308 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %307, i32 0, i32 2
  %309 = load i8*, i8** %308, align 8
  %310 = load i8, i8* %22, align 1
  %311 = zext i8 %310 to i64
  %312 = getelementptr inbounds i8, i8* %309, i64 %311
  store i8 %306, i8* %312, align 1
  br label %313

313:                                              ; preds = %429, %278
  %314 = load i8, i8* %22, align 1
  %315 = zext i8 %314 to i32
  %316 = icmp sgt i32 %315, 0
  br i1 %316, label %317, label %431

317:                                              ; preds = %313
  %318 = load i8, i8* %22, align 1
  %319 = zext i8 %318 to i32
  %320 = sub nsw i32 %319, 1
  %321 = sdiv i32 %320, 2
  %322 = trunc i32 %321 to i8
  store i8 %322, i8* %23, align 1
  %323 = load i8, i8* %23, align 1
  %324 = zext i8 %323 to i32
  %325 = add nsw i32 %324, 1
  %326 = mul nsw i32 %325, 2
  %327 = sub nsw i32 %326, 1
  %328 = trunc i32 %327 to i8
  store i8 %328, i8* %24, align 1
  %329 = load i8, i8* %23, align 1
  %330 = zext i8 %329 to i32
  %331 = add nsw i32 %330, 1
  %332 = mul nsw i32 %331, 2
  %333 = trunc i32 %332 to i8
  store i8 %333, i8* %25, align 1
  %334 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %335 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %334, i32 0, i32 0
  %336 = load i64*, i64** %335, align 8
  %337 = load i8, i8* %24, align 1
  %338 = zext i8 %337 to i64
  %339 = getelementptr inbounds i64, i64* %336, i64 %338
  %340 = load i64, i64* %339, align 8
  %341 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %342 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %341, i32 0, i32 0
  %343 = load i64*, i64** %342, align 8
  %344 = load i8, i8* %25, align 1
  %345 = zext i8 %344 to i64
  %346 = getelementptr inbounds i64, i64* %343, i64 %345
  %347 = load i64, i64* %346, align 8
  %348 = icmp slt i64 %340, %347
  br i1 %348, label %349, label %389

349:                                              ; preds = %317
  %350 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %351 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %350, i32 0, i32 0
  %352 = load i64*, i64** %351, align 8
  %353 = load i8, i8* %24, align 1
  %354 = zext i8 %353 to i64
  %355 = getelementptr inbounds i64, i64* %352, i64 %354
  %356 = load i64, i64* %355, align 8
  %357 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %358 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %357, i32 0, i32 0
  %359 = load i64*, i64** %358, align 8
  %360 = load i8, i8* %23, align 1
  %361 = zext i8 %360 to i64
  %362 = getelementptr inbounds i64, i64* %359, i64 %361
  store i64 %356, i64* %362, align 8
  %363 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %364 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %363, i32 0, i32 1
  %365 = load i8*, i8** %364, align 8
  %366 = load i8, i8* %24, align 1
  %367 = zext i8 %366 to i64
  %368 = getelementptr inbounds i8, i8* %365, i64 %367
  %369 = load i8, i8* %368, align 1
  %370 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %371 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %370, i32 0, i32 1
  %372 = load i8*, i8** %371, align 8
  %373 = load i8, i8* %23, align 1
  %374 = zext i8 %373 to i64
  %375 = getelementptr inbounds i8, i8* %372, i64 %374
  store i8 %369, i8* %375, align 1
  %376 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %377 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %376, i32 0, i32 2
  %378 = load i8*, i8** %377, align 8
  %379 = load i8, i8* %24, align 1
  %380 = zext i8 %379 to i64
  %381 = getelementptr inbounds i8, i8* %378, i64 %380
  %382 = load i8, i8* %381, align 1
  %383 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %384 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %383, i32 0, i32 2
  %385 = load i8*, i8** %384, align 8
  %386 = load i8, i8* %23, align 1
  %387 = zext i8 %386 to i64
  %388 = getelementptr inbounds i8, i8* %385, i64 %387
  store i8 %382, i8* %388, align 1
  br label %429

389:                                              ; preds = %317
  %390 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %391 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %390, i32 0, i32 0
  %392 = load i64*, i64** %391, align 8
  %393 = load i8, i8* %25, align 1
  %394 = zext i8 %393 to i64
  %395 = getelementptr inbounds i64, i64* %392, i64 %394
  %396 = load i64, i64* %395, align 8
  %397 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %398 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %397, i32 0, i32 0
  %399 = load i64*, i64** %398, align 8
  %400 = load i8, i8* %23, align 1
  %401 = zext i8 %400 to i64
  %402 = getelementptr inbounds i64, i64* %399, i64 %401
  store i64 %396, i64* %402, align 8
  %403 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %404 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %403, i32 0, i32 1
  %405 = load i8*, i8** %404, align 8
  %406 = load i8, i8* %25, align 1
  %407 = zext i8 %406 to i64
  %408 = getelementptr inbounds i8, i8* %405, i64 %407
  %409 = load i8, i8* %408, align 1
  %410 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %411 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %410, i32 0, i32 1
  %412 = load i8*, i8** %411, align 8
  %413 = load i8, i8* %23, align 1
  %414 = zext i8 %413 to i64
  %415 = getelementptr inbounds i8, i8* %412, i64 %414
  store i8 %409, i8* %415, align 1
  %416 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %417 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %416, i32 0, i32 2
  %418 = load i8*, i8** %417, align 8
  %419 = load i8, i8* %25, align 1
  %420 = zext i8 %419 to i64
  %421 = getelementptr inbounds i8, i8* %418, i64 %420
  %422 = load i8, i8* %421, align 1
  %423 = load %struct.VCHN_t*, %struct.VCHN_t** %18, align 8
  %424 = getelementptr inbounds %struct.VCHN_t, %struct.VCHN_t* %423, i32 0, i32 2
  %425 = load i8*, i8** %424, align 8
  %426 = load i8, i8* %23, align 1
  %427 = zext i8 %426 to i64
  %428 = getelementptr inbounds i8, i8* %425, i64 %427
  store i8 %422, i8* %428, align 1
  br label %429

429:                                              ; preds = %389, %349
  %430 = load i8, i8* %23, align 1
  store i8 %430, i8* %22, align 1
  br label %313

431:                                              ; preds = %313
  br label %432

432:                                              ; preds = %431, %230
  br label %433

433:                                              ; preds = %432, %53
  br label %434

434:                                              ; preds = %433, %3
  %435 = load i8, i8* %32, align 1
  %436 = load i8*, i8** %29, align 8
  store i8 %435, i8* %436, align 1
  %437 = load i8, i8* %31, align 1
  %438 = load i8*, i8** %28, align 8
  store i8 %437, i8* %438, align 1
  %439 = load i64, i64* %30, align 8
  ret i64 %439
}

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { alwaysinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 11.1.0-6"}
