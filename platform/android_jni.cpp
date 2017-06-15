#ifdef __ANDROID__
#include "main.h"
#include <essentia.h>
#include <jni.h>
#include <android/log.h>

#define DECLARE_JNI_INTERFACE( ret, name, ... ) \
		JNIEXPORT ret JNICALL Java_ru_mtuci_musicanalyzer_CoreLib_##name( JNIEnv *env, jclass clazz, __VA_ARGS__ )

std::string GetStdStringFromJString( JNIEnv *env, jstring jstr )
{
	if( !jstr ) return "";

	std::vector<char> v;

	const jchar *arr = env->GetStringChars( jstr, NULL );

	for( int i = 0; i < env->GetStringLength( jstr ); i++ )
	{
		v.push_back( (char) arr[i] );
	}

	env->ReleaseStringChars( jstr, arr );

	return std::string( v.begin(), v.end() );
}

extern "C"
{

DECLARE_JNI_INTERFACE( jint, analyzeToFile, jstring audioFile, jstring out )
{
	std::string input, output;

	input = GetStdStringFromJString( env, audioFile );
	output = GetStdStringFromJString( env, out );

	return ma::analyzeToFile( input, "", output );
}

DECLARE_JNI_INTERFACE( jint, classifyToFile, jstring analyzeFile, jstring profileFile, jstring out )
{
	std::string input, output, profile;

	input = GetStdStringFromJString( env, analyzeFile );
	output = GetStdStringFromJString( env, out );
	profile = GetStdStringFromJString( env, profileFile );

	return ma::classifyToFile( input, profile, output );
}

JNIEXPORT jint JNI_OnLoad( JavaVM *vm, void *reserved )
{
	essentia::init();

	return JNI_VERSION_1_6;
}

}

#endif // ANDROID
