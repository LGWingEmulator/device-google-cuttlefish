LOCAL_PATH := $(call my-dir)

cvd_host_package_tar := $(HOST_OUT)/cvd-host_package.tar.gz

.PHONY: hosttar
hosttar: $(cvd_host_package_tar)

# Build this by default when a developer types make
droidcore: $(cvd_host_package_tar)

# Build and store them on the build server.
$(call dist-for-goals, dist_files, $(cvd_host_package_tar))

bin_path := $(notdir $(HOST_OUT_EXECUTABLES))
lib_path := $(notdir $(HOST_OUT_SHARED_LIBRARIES))
tests_path := $(notdir $(HOST_OUT_NATIVE_TESTS))
webrtc_files_path := usr/share/webrtc
modem_simulator_path := etc/modem_simulator

cvd_host_executables := \
    adb \
    allocd \
    allocd_client \
    adbshell \
    launch_cvd \
    lpmake \
    lpunpack \
    socket_vsock_proxy \
    adb_connector \
    stop_cvd \
    vnc_server \
    kernel_log_monitor \
    extract-vmlinux \
    crosvm \
    aarch64-linux-gnu/crosvm \
    aarch64-linux-gnu/libepoxy.so.0 \
    aarch64-linux-gnu/libgbm.so.1 \
    aarch64-linux-gnu/libminijail.so \
    aarch64-linux-gnu/libvirglrenderer.so.1 \
    x86_64-linux-gnu/crosvm \
    x86_64-linux-gnu/libc++.so.1 \
    x86_64-linux-gnu/libandroid-emu-shared.so \
    x86_64-linux-gnu/libemugl_common.so \
    x86_64-linux-gnu/libOpenglRender.so \
    x86_64-linux-gnu/libgfxstream_backend.so \
    logcat_receiver \
    config_server \
    tombstone_receiver \
    console_forwarder \
    assemble_cvd \
    run_cvd \
    cvd_status \
    powerwash_cvd \
    webRTC \
    webrtc_operator \
    metrics \
    fsck.f2fs \
    resize.f2fs \
    make_f2fs \
    ms-tpm-20-ref \
    lz4 \
    mkenvimage \
    tapsetiff \
    newfs_msdos \
    secure_env \
    log_tee \
    modem_simulator \
    gnss_grpc_proxy \

cvd_host_tests := \
    monotonic_time_test \
    cuttlefish_net_tests \
    modem_simulator_test \

cvd_host_shared_libraries := \
    libbase.so \
    libcuttlefish_fs.so \
    libcuttlefish_utils.so \
    libcuttlefish_allocd_utils.so \
    cuttlefish_tcp_socket.so \
    cuttlefish_net.so \
    liblog.so \
    libnl.so \
    libc++.so \
    libcutils.so \
    libpuresoftkeymasterdevice_host.so \
    liblp.so \
    libsparse-host.so \
    libcrypto-host.so \
    libcrypto_utils.so \
    libext4_utils.so \
    libz-host.so \
    libicuuc-host.so \
    libicui18n-host.so \
    libandroidicu-host.so \
    libcuttlefish_device_config.so \
    cdisk_spec.so \
    libprotobuf-cpp-full.so \
    libziparchive.so \
    libvpx.so \
    libssl-host.so \
    libopus.so \
    libyuv.so \
    libjpeg.so \
    libkeymaster_messages.so \
    libkeymaster_portable.so \
    libsoft_attestation_cert.so \
    libcuttlefish_security.so \
    tpm2-tss2-esys.so \
    tpm2-tss2-mu.so \
    tpm2-tss2-rc.so \
    tpm2-tss2-sys.so \
    tpm2-tss2-tcti.so \
    tpm2-tss2-util.so \
    libgatekeeper.so \
    ms-tpm-20-ref-lib.so \
    libcap.so \
    libdrm.so \
    libepoxy.so \
    libfdt.so \
    libgbm.so \
    libminijail.so \
    libvirglrenderer.so \
    libwayland_client.so

webrtc_assets := \
    index.html \
    style.css \
    js/logcat.js \
    js/app.js \
    js/cf_webrtc.js \

webrtc_certs := \
    server.crt \
    server.key \
    server.p12 \
    trusted.pem \

cvd_host_webrtc_files := \
    $(addprefix assets/,$(webrtc_assets)) \
    $(addprefix certs/,$(webrtc_certs)) \

modem_simulator_files := \
     iccprofile_for_sim0.xml \
     iccprofile_for_sim0_for_CtsCarrierApiTestCases.xml \
     numeric_operator.xml \

include external/crosvm/seccomp/host_package.mk

cvd_host_package_files := \
     $(addprefix $(bin_path)/,$(cvd_host_executables)) \
     $(addprefix $(lib_path)/,$(cvd_host_shared_libraries)) \
     $(foreach test,$(cvd_host_tests), ${tests_path}/$(test)/$(test)) \
     $(addprefix $(webrtc_files_path)/,$(cvd_host_webrtc_files)) \
     $(addprefix $(modem_simulator_path)/files/,$(modem_simulator_files)) \
     $(crosvm_inline_seccomp_policy_x86_64) \
     $(crosvm_inline_seccomp_policy_aarch64) \

$(cvd_host_package_tar): PRIVATE_FILES := $(cvd_host_package_files)
$(cvd_host_package_tar): $(addprefix $(HOST_OUT)/,$(cvd_host_package_files))
	$(hide) rm -rf $@ && tar Scfz $@.tmp -C $(HOST_OUT) $(PRIVATE_FILES)
	$(hide) mv $@.tmp $@
