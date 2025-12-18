#!/usr/bin/env bash

################################################################################
# Description:
#   This Bash script automates the process of flashing Jetson devices with
#   customizable parameters such as device vendor, product, module, JetPack
#   version, storage device, and user name. It downloads appropriate files,
#   prepares them, creates an image, and flashes the connected Jetson device.
#
# Usage:
#   ./flash_jetson.sh <product> <device_module> <jetpack_version>
#                      <storage_device> <keep_files> <user_name>
#
#   Parameters:
#     <product>          : The product model of the Jetson device
#     <device_module>    : The specific module of the Jetson device
#     <jetpack_version>  : The JetPack version to be flashed
#     <storage_device>   : The storage device type (Micro SD or NVMe SSD)
#     <keep_files>       : A boolean indicating whether to keep installation files
#     <user_name>        : The username for downloading files and folder creation
#
# Notes:
#   - Make sure to run the script with appropriate permissions (e.g., sudo).
#   - Stop the udisks2 service before flashing if it interferes with the process.
#   - Ensure that the script is executed on a system with Ubuntu 20.04 or 18.04.
#   - The script may prompt for password when accessing system resources.
#   - Adjust the URLs and version numbers based on the latest available releases.
#
# Copyright 2024 OmniWise Teknoloji A.S.
#
# Licensed under the GNU General Public License, version 3 (GPLv3).
# You may obtain a copy of the License at
#
#     https://www.gnu.org/licenses/gpl-3.0.html
#
# This script is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.
################################################################################

# Global Variables
product="$1"
device_module="$2"
jetpack_version="$3"
storage_device="$4"
keep_files="$5"
user_name="$6"
device_flashed=""
device_name=""
host_version=""

# Source files
source ./data/urls.sh

# Functions
function err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

function d315_62(){
    j_version=$(echo "$jetpack_version" | cut -d " " -f 1)
    cfg_folder_name='generic'
    cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra || { err "Failed to change directory"; exit 1; }
    sudo tools/l4t_create_default_user.sh -u "nvidia" -p "nvidia" -a -n "tegra-ubuntu" --accept-license
    cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra/settings/D315 || { err "Failed to change directory"; exit 1; }
    sudo rsync -a --exclude=".*" "./pinmux/" "../../bootloader/"
    sudo chmod +x ./addition_setup.sh
    sudo ./addition_setup.sh 0
    cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra || { err "Failed to change directory"; exit 1; }
}

# Checking Host Computer Version Compatibility
host_version=$(sudo -S cat /etc/os-release | grep 'VERSION_ID' | cut -d '"' -f 2)
jetpack_initial="${jetpack_version:0:1}"

if [[ "${host_version}" == '20.04' || "${host_version}" == '18.04' ]] || [[ "${host_version}" == '22.04' && "${jetpack_initial}" -ge 5 ]]; then
  echo "Ubuntu version is compatible, processing with flashing"
else
  err "Your host computer Ubuntu version is ${host_version}, please use Ubuntu 20.04 or 18.04"
  exit 1
fi

# Selection of the module
if [[ "${product}" == 'Orin' ]]; then
  
  if [[ "${device_module}" == 'AGX Orin' ]]; then
    device_flashed="agx_orin_devkit"
    device_name="jetson-agx-orin-devkit"
  fi

elif [[ "${product}" == 'Xavier' ]]; then

  if [[ "${device_module}" == 'AGX Xavier' ]]; then
    device_flashed="agx_xavier_xavier_nx"
    device_name="jetson-agx-xavier-devkit"
  elif [[ "${device_module}" == 'Xavier NX' ]]; then
    device_flashed="agx_xavier_xavier_nx"
    device_name="jetson-xavier-nx-devkit"
  fi

elif [[ "${product}" == 'D131L' ||  "${product}" == 'Blanet' ]]; then
  product="D131L"
  if [[ "${device_module}" == 'Orin NX' ]]; then
    device_flashed="D131L"
    device_name="jetson-orin-d131"
  elif [[ "${device_module}" == 'Orin Nano - 4GB' ]]; then
    device_flashed="D131L"
    device_name="jetson-orin-nano-devkit"
  fi

elif [[ "${product}" == 'D131' ]]; then

  if [[ "${device_module}" == 'Orin Nano' ]]; then

    if [[ "${jetpack_version}" == '5.1.3 - L4T 35.5.0' ]]; then
      device_flashed="D131"
      device_name="jetson-orin-d131"
    elif [[ "${jetpack_version}" == '5.1.2 - L4T 35.4.1' || "${jetpack_version}" == '5.1.1 - L4T 35.3.1' ]]; then
      device_flashed="D131"
      device_name="jetson-orin-nano-d131on"
    elif [[ "${jetpack_version}" == '6.0 - L4T 36.3' ]]; then
      device_flashed="D131"
      device_name="jetson-orin-d131"
    elif [[ "${jetpack_version}" == '6.2 - L4T 36.4.3' ]]; then
      device_flashed="D131"
      device_name="jetson-orin-d131-super"
    fi
  fi

elif [[ "${product}" == 'Pulsar' ]]; then
    product="D315"
    device_flashed="D315"
    device_name="jetson-agx-orin-d315ao"

elif [[ "${product}" == 'D315' ]]; then
    device_flashed="D315"
    device_name="jetson-agx-orin-d315ao"

elif [[ "${product}" == 'J401' ]]; then
    device_flashed="J401"df

elif [[ "${product}" == 'Nano' ]]; then
  device_flashed="Nano"
  device_name="jetson-nano-devkit"

fi

# Checking whether a force recovery device is connected to the host
if [[ ${host_version} == '20.04'  || ${host_version} == '22.04' ]]; then
  recovery_status=$(lsusb | grep 'NVIDIA Corp.' | cut -d " " -f 7)
elif [[ ${host_version} == '18.04' ]]; then
  recovery_status=$(lsusb | grep 'NVidia Corp.' | cut -d " " -f 7)
fi

if [[ ! "${recovery_status^^}" == 'NVIDIA' ]]; then
  err "Cannot find a force recovery device"
  exit 1
fi

# Flashing the device
# Downloading the required files based on JetPack version and device
jetpack_code=$(echo "${jetpack_version//\./_}" | cut -d " " -f 1)


if (( "${jetpack_code:0:1}" != 4 )) && \
   [[ "${device_flashed}" != "D131" ]] && \
   [[ "${device_flashed}" != "D315" ]] && \
   [[ "${device_flashed}" != "J401" ]] && \
   [[ ! ("${device_flashed}" == "D131L" && "${jetpack_code}" == '6_1') ]]; then

  device_flashed='ALL'

fi

download_link_1="${device_flashed^^}_${jetpack_code}[0]"
download_link_2="${device_flashed^^}_${jetpack_code}[1]"
download_link_3="${device_flashed^^}_${jetpack_code}[2]"
filename_1="bsp_files_${device_flashed}_${jetpack_code}.tbz2"
filename_2="sample_root_files_${device_flashed}_${jetpack_code}.tbz2"
filename_3="secure_boot_${device_flashed}_${jetpack_code}.tbz2"

# Creating necessary folders and downloading files if they don't exist
if [[ ! -d ~/openzeka ]]; then
  if ! sudo -u "${user_name}" mkdir ~/openzeka; then
    err "Unable to create openzeka folder"
    exit 1
  fi
fi

if [[ ! -e ~/openzeka/"${filename_1}" ]]; then
echo "downloading file ${filename_1}"
  if ! sudo -u "${user_name}" wget -O ~/openzeka/"${filename_1}" "${!download_link_1}"; then
    err "Unable to download BSP files"
    exit 1
  fi
fi

if [[ ! -e ~/openzeka/"${filename_2}" ]] && \
   [[ "${device_flashed}" != "D131" ]] && \
   [[ "${device_flashed}" != "D315" ]] && \
   [[ "${device_flashed}" != "J401" ]] && \
   [[ ! ("${device_flashed}" == "D131L" && "${jetpack_code}" == '6_1') ]]; then

     echo "downloading file ${filename_2}"
     if ! sudo -u "${user_name}" wget -O ~/openzeka/"${filename_2}" "${!download_link_2}"; then
       err "Unable to download Sample Root Filesystem"
       exit 1
     fi

fi


if [[  "${jetpack_code}" == '4_6_3' || "${jetpack_code}" == '4_6_4' || "${jetpack_code}" == '4_6_5' ||  "${product}" == "ONX-101" ]]; then
echo "downloading file ${filename_3}"
  if [[  "${product}" == 'Xavier' || "${product}" == 'ONX-101' ]]; then
      if [[ ! -e ~/openzeka/"${filename_3}" ]]; then
        if ! sudo -u "${user_name}" wget -O ~/openzeka/"${filename_3}" "${!download_link_3}"; then
          err "Unable to download Secure Boot Files"
          exit 1
        fi
    fi
  fi

fi

echo "Downloading has been finished!"

# # Removing the old folder
if [[ -d ~/openzeka/Linux_for_Tegra ]]; then
  echo "Removing old files..."
  cd ~/openzeka/ || { err "Failed to change directory"; exit 1; }
  sudo rm -r Linux_for_Tegra ./*.txt ./*.sh ./*.ko ./*.conf ./*.common ./*.dtsi ./*.dts ./*.dtb Image
fi

# Extracting the downloaded files

if [[ "${device_flashed}" == "D131" ]] || [[ "${device_flashed}" == "D315" ]] || [[ "${device_flashed}" == "D131L" && "${jetpack_code}" == '6_1' ]]; then
  command="zxf"
elif [[ "${device_flashed}" == "J401" ]]; then
  command="xpf"
else
  command="xf"
fi

echo "Extracting ${filename_1}, this may take a while..."
if ! sudo tar ${command} ~/openzeka/"${filename_1}" -C ~/openzeka/; then
  err "Unable to extract BSP files"
  exit 1
fi

if [[ "${device_flashed}" != "D131" ]] && \
   [[ "${device_flashed}" != "D315" ]] && \
   [[ "${device_flashed}" != "J401" ]] && \
   [[ ! ("${device_flashed}" == "D131L" && "${jetpack_code}" == '6_1') ]]; then

     echo "Extracting ${filename_2}, this may take a while..."
     if ! sudo tar xpf ~/openzeka/"${filename_2}" -C ~/openzeka/Linux_for_Tegra/rootfs/; then
       err "Unable to extract Sample Root Filesystem"
       exit 1
     fi

     if [[ "${jetpack_code}" == '4_6_3' || "${jetpack_code}" == '4_6_4' || "${jetpack_code}" == '4_6_5' ]]; then
       if [[  "${product}" == 'Xavier' ]]; then
         echo "Extracting ${filename_3} ..."
         if ! sudo tar xvjf ~/openzeka/"${filename_3}" -C ~/openzeka/; then
           err "Unable to extract Secure Boot Files"
           exit 1
         fi
       fi
       df 
     fi

fi

# Applying binaries, preparing the additional files and flashing the device based on storage device type

if [[ "${device_flashed}" != "D131" ]] && [[ "${device_flashed}" != "D315" ]] && [[ "${device_flashed}" != "J401" ]] && [[ ! ("${device_flashed}" == "D131L" && "${jetpack_code}" == '6_1') ]]; then

  echo "Applying binaries ..."
  cd ~/openzeka/Linux_for_Tegra/ || { err "Failed to change directory"; exit 1; }
  if ! sudo ./apply_binaries.sh; then
    err "Unable to apply binaries"
    exit 1
  fi

  if ! sudo ./tools/l4t_flash_prerequisites.sh; then
    err "Unable to complete flash prerequisites"
    exit 1
  fi

  if [[  "${product}" == 'ONX-101' ]]; then
    echo "Extracting and preparing ${filename_3} ..."
    cd ~/openzeka/ || { err "Failed to change directory"; exit 1; }
    if ! sudo -u "${user_name}" unzip ~/openzeka/"${filename_3}"; then
      err "Unable to extract Secure Boot Files"
      exit 1
    fi

    chmod u+x orin_nx_replace_files.sh
    sudo ./orin_nx_replace_files.sh

  fi
fi

# Flashing the device

if [[ "${storage_device}" == 'Micro SD' ]]; then
  
  if [[ "${product}" == 'D315' ]]; then
    d315_62
  fi

  if [[ "${device_module}" == 'AGX Orin' && "${jetpack_version}" == '6.0.DP - L4T 36.2' ]] || [[ "${device_module}" == 'AGX Orin' && "${jetpack_version}" == '6.2 - L4T 36.4.3' ]] || [[ "${product}" == 'D315' ]]; then
    boot_dev='internal'
  else
    boot_dev='mmcblk0p1'
  fi

  echo "sudo ./flash.sh ${device_name} ${boot_dev}"
  if ! sudo ./flash.sh "${device_name}" "${boot_dev}"; then
    err "Unable to flash the device"
    exit 1
  fi



elif [[ "${storage_device}" == 'NVMe SSD' ]]; then

  if [[ "${product}" == 'ONX-101' ]]; then

    if [[ "${jetpack_code}" == '6_0' ]]; then
      l4t_config="flash_l4t_t234_nvme.xml"
      bootloader_config="generic"
    else
      l4t_config="flash_l4t_external.xml"
      bootloader_config="t186ref"
    fi    

    cd ~/openzeka/Linux_for_Tegra/ || { err "Failed to change directory"; exit 1; }
    if ! sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device nvme0n1p1 -c tools/kernel_flash/"${l4t_config}" \
    -p "-c bootloader/${bootloader_config}/cfg/flash_t234_qspi.xml" --showlogs --network usb0 p3509-a02+p3767-0000 internal; then
      err "Unable to flash the device"
      exit 1
    fi

  elif [[ "${product}" == 'D131' ]] || [[ "${product}" == 'D315' ]] || [[ ("${device_flashed}" == "D131L" && "${jetpack_code}" == '6_1') ]]; then

    j_version=$(echo "$jetpack_version" | cut -d " " -f 1)
    
    if [[ "${jetpack_version}" == '6.0 - L4T 36.3' ]] || [[ "${jetpack_version}" == '6.1 - L4T 36.4.0' ]] || [[ "${jetpack_version}" == '6.2 - L4T 36.4.3' ]] || [[ "${jetpack_version}" == '6.2.1 - L4T 36.4.4' ]]; then
      cfg_folder_name='generic'
    else
      cfg_folder_name='t186ref'
    fi
    
    if [[ "${product}" == 'D315' ]] && [[ "${jetpack_version}" == '5.0.2 - L4T 35.1' ]] ; then
      cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_AGX_ORIN_TARGETS/Linux_for_Tegra || { err "Failed to change directory"; exit 1; }  
    elif [[ "${jetpack_version}" == '6.2 - L4T 36.4.3' ]] ; then
      cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra || { err "Failed to change directory"; exit 1; }
    elif [[ "${jetpack_version}" == '6.2.1 - L4T 36.4.4' ]] ; then
      cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra || { err "Failed to change directory"; exit 1; }   
    else
      cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON/Linux_for_Tegra || { err "Failed to change directory"; exit 1; }      
    fi
    
    sudo tools/l4t_create_default_user.sh -u "nvidia" -p "nvidia" -a -n "tegra-ubuntu" --accept-license

    if [[ "${product}" == 'D131' ]]; then
    
      if [[ "${jetpack_version}" == '5.1.3 - L4T 35.5.0' ]]; then
        sudo ./setup.sh 5
      elif [[ "${jetpack_version}" == '6.2 - L4T 36.4.3' ]]; then
        sudo echo -e "CARRIER_BOARD_NAME=D131\nMODE_TYPE=" > "./rootfs/etc/avt_carrier_board.conf"
        cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra/settings/D131 || { err "Failed to change directory"; exit 1; }
        sudo rsync -a --exclude=".*" "./pinmux/" "../../bootloader/"
        sudo chmod +x ./addition_setup.sh
        sudo ./addition_setup.sh 1 4
        cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra || { err "Failed to change directory"; exit 1; }
      else
        sudo ./setup.sh 8
      fi
    elif [[ "${product}" == 'D131L' ]]; then
    
        sudo ./setup.sh 7

    elif [[ "${product}" == 'D315' ]]; then
      
      if [[ "${jetpack_version}" == '6.1 - L4T 36.4.0' ]] || [[ "${jetpack_version}" == '6.2 - L4T 36.4.3' ]] || [[ "${jetpack_version}" == '6.2.1 - L4T 36.4.4' ]]; then
        cam_selection="0"
      else
        cam_selection="8"
      fi

      if [[ "${jetpack_version}" == '6.2 - L4T 36.4.3' ]]; then
        cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra/settings/D315 || { err "Failed to change directory"; exit 1; }
        sudo rsync -a --exclude=".*" "./pinmux/" "../../bootloader/"
        sudo chmod +x ./addition_setup.sh
        sudo ./addition_setup.sh "$cam_selection"
        cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra || { err "Failed to change directory"; exit 1; }
      elif [[ "${jetpack_version}" == '6.2.1 - L4T 36.4.4' ]]; then
        cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra || { err "Failed to change directory"; exit 1; }
        
        cd "$HOME/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra/rootfs/usr/lib/modules/5.15.148-tegra/updates/drivers/media/i2c/" > /dev/null || exit 1
    
        sudo mv max9295.ko.bak max9295.ko 2>/dev/null 
        sudo mv max9296.ko.bak max9296.ko 2>/dev/null 
        sudo mv max96712.ko.bak max96712.ko 2>/dev/null 
        sudo mv nv_imx390.ko.bak nv_imx390.ko 2>/dev/null 

        echo -e "CARRIER_BOARD_NAME=D315\nMODE_TYPE=" | sudo tee "${THIS_DIR}/rootfs/etc/avt_carrier_board.conf" > /dev/null

        cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra/settings/D315 || { err "Failed to change directory"; exit 1; }
        sudo rsync -avc --exclude=".*" "./patch/" ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra/

        sudo chmod +x ./addition_setup.sh
        sudo ./addition_setup.sh "$cam_selection"
        cd ~/openzeka/JetPack_"${j_version}"_Linux_JETSON_desktop/Linux_for_Tegra || { err "Failed to change directory"; exit 1; }

      else
        sudo ./setup.sh "$cam_selection"
      fi
    fi

    if ! sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device nvme0n1p1 -c tools/kernel_flash/flash_l4t_external.xml \
    -p "-c bootloader/${cfg_folder_name}/cfg/flash_t234_qspi.xml" --showlogs --network usb0 "${device_name}" internal; then
      err "Unable to flash the device"
      exit 1
    fi
  elif [[ "${product}" == 'J401' ]]; then

    cd ~/openzeka/mfi_recomputer-orin-j401 || { err "Failed to change directory"; exit 1; }
    if ! sudo ./tools/kernel_flash/l4t_initrd_flash.sh --flash-only --massflash 1 --network usb0  --showlogs; then
      err "Unable to flash the device"
      exit 1
    fi

  else
    echo "./nvsdkmanager_flash.sh --storage nvme0n1p1"
    if ! sudo ./nvsdkmanager_flash.sh --storage nvme0n1p1; then
      err "Unable to flash the device"
      exit 1
    fi
  fi

fi

# Removing installation files if requested
if [[ "${keep_files}" == 'False' ]]; then
echo "Deleting installation files"
  if ! sudo rm -r ~/openzeka; then
    err "Unable to delete installation files"
    exit 1
  fi
fi

echo "Your device has been flashed successfully..."

exit 0