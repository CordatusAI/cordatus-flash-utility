# URLs for different Jetson versions
# Each array contains the URLs for BSP files and sample root filesystem
# The version numbers and URLs might need to be updated accordingly
readonly NANO_4_6_1=("https://developer.nvidia.com/embedded/l4t/r32_release_v7.1/t210/jetson-210_linux_r32.7.1_aarch64.tbz2" \
"https://developer.nvidia.com/embedded/l4t/r32_release_v7.1/t210/tegra_linux_sample-root-filesystem_r32.7.1_aarch64.tbz2")
readonly NANO_4_6_2=("https://developer.nvidia.com/embedded/l4t/r32_release_v7.2/t210/jetson-210_linux_r32.7.2_aarch64.tbz2" \
"https://developer.nvidia.com/embedded/l4t/r32_release_v7.2/t210/tegra_linux_sample-root-filesystem_r32.7.2_aarch64.tbz2")
readonly NANO_4_6_3=("https://developer.nvidia.com/downloads/remetpack-463r32releasev73t210jetson-210linur3273aarch64tbz2" \
"https://developer.nvidia.com/downloads/remeleasev73t210tegralinusample-root-filesystemr3273aarch64tbz2")
readonly NANO_4_6_4=("https://developer.nvidia.com/downloads/embedded/l4t/r32_release_v7.4/t210/jetson-210_linux_r32.7.4_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r32_release_v7.4/t210/tegra_linux_sample-root-filesystem_r32.7.4_aarch64.tbz2")
readonly NANO_4_6_5=("https://developer.nvidia.com/downloads/embedded/l4t/r32_release_v7.5/t210/jetson-210_linux_r32.7.5_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r32_release_v7.5/t210/tegra_linux_sample-root-filesystem_r32.7.5_aarch64.tbz2")
readonly AGX_XAVIER_XAVIER_NX_4_6_1=("https://developer.nvidia.com/embedded/l4t/r32_release_v7.1/t186/jetson_linux_r32.7.1_aarch64.tbz2" \
"https://developer.nvidia.com/embedded/l4t/r32_release_v7.1/t186/tegra_linux_sample-root-filesystem_r32.7.1_aarch64.tbz2")
readonly AGX_XAVIER_XAVIER_NX_4_6_2=("https://developer.nvidia.com/embedded/l4t/r32_release_v7.2/t186/jetson_linux_r32.7.2_aarch64.tbz2" \
"https://developer.nvidia.com/embedded/l4t/r32_release_v7.2/t186/tegra_linux_sample-root-filesystem_r32.7.2_aarch64.tbz2")
readonly AGX_XAVIER_XAVIER_NX_4_6_3=("https://developer.nvidia.com/downloads/remksjetpack-463r32releasev73t186jetsonlinur3273aarch64tbz2" \
"https://developer.nvidia.com/downloads/remeleasev73t186tegralinusample-root-filesystemr3273aarch64tbz2" \
"https://developer.nvidia.com/downloads/remsdksjetpack-463r32releasev73t186securebootr3273aarch64tbz2")
readonly AGX_XAVIER_XAVIER_NX_4_6_4=("https://developer.nvidia.com/downloads/embedded/l4t/r32_release_v7.4/t186/jetson_linux_r32.7.4_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r32_release_v7.4/t186/tegra_linux_sample-root-filesystem_r32.7.4_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r32_release_v7.4/t186/secureboot_r32.7.4_aarch64.tbz2")
readonly AGX_XAVIER_XAVIER_NX_4_6_5=("https://developer.nvidia.com/downloads/embedded/l4t/r32_release_v7.5/t186/jetson_linux_r32.7.5_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r32_release_v7.5/t186/tegra_linux_sample-root-filesystem_r32.7.5_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r32_release_v7.5/t186/secureboot_r32.7.5_aarch64.tbz2")
readonly ALL_5_0_2=("https://developer.nvidia.com/embedded/l4t/r35_release_v1.0/release/jetson_linux_r35.1.0_aarch64.tbz2" \
"https://developer.nvidia.com/embedded/l4t/r35_release_v1.0/release/tegra_linux_sample-root-filesystem_r35.1.0_aarch64.tbz2")
readonly ALL_5_1=("https://developer.nvidia.com/downloads/jetson-linux-r3521-aarch64tbz2" \
"https://developer.nvidia.com/downloads/linux-sample-root-filesystem-r3521aarch64tbz2")
readonly ALL_5_1_1=("https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v3.1/release/jetson_linux_r35.3.1_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v3.1/release/tegra_linux_sample-root-filesystem_r35.3.1_aarch64.tbz2" 
"http://download.comarge.com/omniwise/orin-nx/ONX101_5_1_1.zip")
readonly ALL_5_1_2=("https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v4.1/release/jetson_linux_r35.4.1_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v4.1/release/tegra_linux_sample-root-filesystem_r35.4.1_aarch64.tbz2" \
"http://download.comarge.com/omniwise/orin-nx/ONX101_5_1_2.zip")
readonly ALL_5_1_3=("https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v5.0/release/jetson_linux_r35.5.0_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v5.0/release/tegra_linux_sample-root-filesystem_r35.5.0_aarch64.tbz2" \
"http://download.comarge.com/omniwise/orin-nx/ONX101_5_1_3.zip")
readonly ALL_5_1_4=("https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v6.0/release/jetson_linux_r35.6.0_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v6.0/release/tegra_linux_sample-root-filesystem_r35.6.0_aarch64.tbz2")
readonly ALL_5_1_5=("https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v6.2/release/jetson_linux_r35.6.2_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v6.2/tegra_linux_sample-root-filesystem_r35.6.2_aarch64.tbz2")
readonly ALL_6_0_DP=("https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v2.0/release/jetson_linux_r36.2.0_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v2.0/release/tegra_linux_sample-root-filesystem_r36.2.0_aarch64.tbz2")
readonly ALL_6_0=("https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v3.0/release/jetson_linux_r36.3.0_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v3.0/release/tegra_linux_sample-root-filesystem_r36.3.0_aarch64.tbz2" \
"http://download.comarge.com/omniwise/orin-nx/ONX101_6_0.zip")
readonly ALL_6_1=("https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v4.0/release/Jetson_Linux_R36.4.0_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v4.0/release/Tegra_Linux_Sample-Root-Filesystem_R36.4.0_aarch64.tbz2")
readonly ALL_6_2=("https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v4.3/release/Jetson_Linux_r36.4.3_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v4.3/release/Tegra_Linux_Sample-Root-Filesystem_r36.4.3_aarch64.tbz2")
readonly ALL_6_2_1=("https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v4.4/release/Jetson_Linux_r36.4.4_aarch64.tbz2" \
"https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v4.4/release/Tegra_Linux_Sample-Root-Filesystem_r36.4.4_aarch64.tbz2")
readonly D131_6_2=("http://download.comarge.com/avermedia/orin-nano/AVERMEDIA_JETPACK-R1.1.0.6.2.0_desktop.tar.gz")
readonly D131L_6_1=("http://download.comarge.com/avermedia/orin-nano/D131_ORIN-R3.2.0.6.1.0.tar.gz")
readonly D131_5_1_3=("http://download.comarge.com/avermedia/orin-nano/D131_ORIN-R2.4.1.5.1.3.tar.gz")
readonly D131_5_1_2=("http://download.comarge.com/avermedia/orin-nano/D131ON-R2.1.0.5.1.2.tar.gz")
readonly D131_5_1_1=("http://download.comarge.com/avermedia/orin-nano/D131ON-R2.0.3.5.1.1.tar.gz")
readonly D315_5_0_2=("https://download.comarge.com/avermedia/agx-orin/D315AO-R2.1.8.5.0.2.tar.gz")
readonly D315_5_1_1=("https://download.comarge.com/avermedia/agx-orin/D315AO-R2.3.1.5.1.1.tar.gz")
readonly D315_5_1_2=("https://download.comarge.com/avermedia/agx-orin/D315AO-R2.4.1.5.1.2.tar.gz")
readonly D315_5_1_3=("https://download.comarge.com/avermedia/agx-orin/D315AO-R2.5.2.5.1.3.tar.gz")
readonly D315_6_0=("https://download.comarge.com/avermedia/agx-orin/D315AO-R3.1.0.6.0.0.tar.gz")
readonly D315_6_1=("https://download.comarge.com/avermedia/agx-orin/D315AO-36.4.0.6.1.tar.gz")
readonly D315_6_2=("https://download.comarge.com/avermedia/agx-orin/D315AO-36.4.3.6.2.tar.gz")
readonly J401_6_1=("https://download.comarge.com/seeed/orin-nx-16/J401ONX16-6.1.tar.gz")

