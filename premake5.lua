project "grpc"
	kind "StaticLib"
	language "C++"
    staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"src/cpp/**.cpp",
		"src/cpp/**.h",
		"src/cpp/**.cc",
	}
	protoc -I=$PWD/googleapis --grpc_out=. --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` $PWD/googleapis/google/logging/v2/logging.proto
	includedirs
    {
		".",
        "include",
		"src/core/ext/upb-gen",
		
		"third_party/abseil-cpp",
		"third_party/protobuf/src",
		"third_party/boringssl-with-bazel/src/include",
		"third_party\opentelemetry-cpp\sdk\include",
		"third_party/upb",
		"third_party/re2",
		
    }

	filter "system:windows"
		systemversion "latest"
		cppdialect "C++17"

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++17"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

    filter "configurations:Dist"
		runtime "Release"
		optimize "on"
        symbols "off"
