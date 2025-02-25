# distutils: language=c++

cdef extern from "embree3/rtcore.h":

    #rtcore_config.h

    cdef int RTC_VERSION_MAJOR
    cdef int RTC_VERSION_MINOR
    cdef int RTC_VERSION_PATCH

    #rtcore_device.h

    # typedef struct __RTCDevice {}* RTCDevice;
    ctypedef void* RTCDevice

    RTCDevice rtcNewDevice(const char* cfg)
    void rtcRetainDevice(RTCDevice device)
    void rtcReleaseDevice(RTCDevice device)

    cdef enum RTCError:
        RTC_ERROR_NONE
        RTC_ERROR_UNKNOWN
        RTC_ERROR_INVALID_ARGUMENT
        RTC_ERROR_INVALID_OPERATION
        RTC_ERROR_OUT_OF_MEMORY
        RTC_ERROR_UNSUPPORTED_CPU
        RTC_ERROR_CANCELLED
    RTCError rtcGetDeviceError(RTCDevice device)

    ctypedef void (*RTCErrorFunc)(void* userPtr, const RTCError code, const char* str)
    void rtcSetDeviceErrorFunction(RTCDevice device, RTCErrorFunc func, void* userPtr)

    # ctypedef bint (*RTCMemoryMonitorFunction)(void* userPtr, ssize_t bytes, bint post)
    # void rtcSetDeviceMemoryMonitorFunction(RTCDevice device, RTCMemoryMonitorFunction func, void* userPtr)

    cdef enum RTCIntersectContextFlags:
        RTC_INTERSECT_CONTEXT_FLAG_NONE
        RTC_INTERSECT_CONTEXT_FLAG_INCOHERENT
        RTC_INTERSECT_CONTEXT_FLAG_COHERENT

    # cython comment: If the header file declares a big struct and you only want to use a few members,
    # you only need to declare the members you’re interested in.
    # Leaving the rest out doesn’t do any harm, because the C compiler will use the full definition
    # from the header file.
    cdef struct RTCIntersectContext:
        RTCIntersectContextFlags flags

    void rtcInitIntersectContext(RTCIntersectContext* context)

    cdef unsigned int RTC_INVALID_GEOMETRY_ID

    # from rtcore_common.h
    cdef enum RTCFormat:
          RTC_FORMAT_UNDEFINED = 0

          # 8-bit unsigned integer
          RTC_FORMAT_UCHAR = 0x1001
          RTC_FORMAT_UCHAR2
          RTC_FORMAT_UCHAR3
          RTC_FORMAT_UCHAR4

          # 8-bit signed integer
          RTC_FORMAT_CHAR = 0x2001
          RTC_FORMAT_CHAR2
          RTC_FORMAT_CHAR3
          RTC_FORMAT_CHAR4

          # 16-bit unsigned integer
          RTC_FORMAT_USHORT = 0x3001
          RTC_FORMAT_USHORT2
          RTC_FORMAT_USHORT3
          RTC_FORMAT_USHORT4

          # 16-bit signed integer
          RTC_FORMAT_SHORT = 0x4001
          RTC_FORMAT_SHORT2
          RTC_FORMAT_SHORT3
          RTC_FORMAT_SHORT4

          # 32-bit unsigned integer
          RTC_FORMAT_UINT = 0x5001
          RTC_FORMAT_UINT2
          RTC_FORMAT_UINT3
          RTC_FORMAT_UINT4

          # 32-bit signed integer
          RTC_FORMAT_INT = 0x6001
          RTC_FORMAT_INT2
          RTC_FORMAT_INT3
          RTC_FORMAT_INT4

          # 64-bit unsigned integer
          RTC_FORMAT_ULLONG = 0x7001
          RTC_FORMAT_ULLONG2
          RTC_FORMAT_ULLONG3
          RTC_FORMAT_ULLONG4

          # 64-bit signed integer
          RTC_FORMAT_LLONG = 0x8001
          RTC_FORMAT_LLONG2
          RTC_FORMAT_LLONG3
          RTC_FORMAT_LLONG4

          # 32-bit float
          RTC_FORMAT_FLOAT = 0x9001
          RTC_FORMAT_FLOAT2
          RTC_FORMAT_FLOAT3
          RTC_FORMAT_FLOAT4
          RTC_FORMAT_FLOAT5
          RTC_FORMAT_FLOAT6
          RTC_FORMAT_FLOAT7
          RTC_FORMAT_FLOAT8
          RTC_FORMAT_FLOAT9
          RTC_FORMAT_FLOAT10
          RTC_FORMAT_FLOAT11
          RTC_FORMAT_FLOAT12
          RTC_FORMAT_FLOAT13
          RTC_FORMAT_FLOAT14
          RTC_FORMAT_FLOAT15
          RTC_FORMAT_FLOAT16

          # 32-bit float matrix (row-major order)
          RTC_FORMAT_FLOAT2X2_ROW_MAJOR = 0x9122
          RTC_FORMAT_FLOAT2X3_ROW_MAJOR = 0x9123
          RTC_FORMAT_FLOAT2X4_ROW_MAJOR = 0x9124
          RTC_FORMAT_FLOAT3X2_ROW_MAJOR = 0x9132
          RTC_FORMAT_FLOAT3X3_ROW_MAJOR = 0x9133
          RTC_FORMAT_FLOAT3X4_ROW_MAJOR = 0x9134
          RTC_FORMAT_FLOAT4X2_ROW_MAJOR = 0x9142
          RTC_FORMAT_FLOAT4X3_ROW_MAJOR = 0x9143
          RTC_FORMAT_FLOAT4X4_ROW_MAJOR = 0x9144

          # 32-bit float matrix (column-major order)
          RTC_FORMAT_FLOAT2X2_COLUMN_MAJOR = 0x9222
          RTC_FORMAT_FLOAT2X3_COLUMN_MAJOR = 0x9223
          RTC_FORMAT_FLOAT2X4_COLUMN_MAJOR = 0x9224
          RTC_FORMAT_FLOAT3X2_COLUMN_MAJOR = 0x9232
          RTC_FORMAT_FLOAT3X3_COLUMN_MAJOR = 0x9233
          RTC_FORMAT_FLOAT3X4_COLUMN_MAJOR = 0x9234
          RTC_FORMAT_FLOAT4X2_COLUMN_MAJOR = 0x9242
          RTC_FORMAT_FLOAT4X3_COLUMN_MAJOR = 0x9243
          RTC_FORMAT_FLOAT4X4_COLUMN_MAJOR = 0x9244

          # special 12-byte format for grids
          RTC_FORMAT_GRID = 0xA001


cdef extern from "embree3/rtcore_ray.h":
    pass

cdef struct Vertex:
    float x, y, z, r

cdef struct Triangle:
    int v0, v1, v2

cdef struct Vec3f:
    float x, y, z

cdef void print_error(RTCError code)

cdef class EmbreeDevice:  #TODO check if this intermediate level is really needed?
    cdef RTCDevice device
