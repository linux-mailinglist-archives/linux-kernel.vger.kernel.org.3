Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4BD49FD7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349889AbiA1QCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:02:06 -0500
Received: from mout.perfora.net ([74.208.4.196]:58873 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349583AbiA1QB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:01:56 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LyX1k-1m99r428Wc-015pOZ;
 Fri, 28 Jan 2022 17:01:36 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/12] arm64: defconfig: rebuild default configuration
Date:   Fri, 28 Jan 2022 17:00:53 +0100
Message-Id: <20220128160100.1228537-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128160100.1228537-1-marcel@ziswiler.com>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S/Kw8PFYQkLvCBtUwi9oFfj1vbQcaz7ehUSsTj7e0UmPhG72XDF
 rHbFsP4cc65ZDNEdXCXaBMZzFVdTRU4Q5i56A/WxbjLaUvOsMWVyy3Fjhf5T37SOPb2D6Gs
 5B03I/3TZp9Np0x79KAoHuU56OHtje1f/koDPHZdq28L7W+9LFa2bsyn+sOFuMrn+Pko1D1
 4rtCCsBGBWZcNqXsv2q6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nrfhMwIvVfs=:7CXT7wowMBddvZB1/8j/Az
 DPxwOnbL6ffW/xeXKsip0mHfXiaDFXERWz4jkELt+HVP3cPUn2RocYhxzrzDTFnueA1AxzGwJ
 /d8P3drIVqPwRhUzmuZ7KAPzU/owI2K2Zwdl5lzUnlth6dmClMz39vbGFsvnkJvXu/WqiXzX3
 pUR2qNQ4Sklc6QU9mf2JIEV0Clo2JlYtyavhxDMLVtqZjok1Y6h0sKbexSjplkHLLbfYBCc7C
 HOo7eO2T0P0Wjddp9JfZy80S1Jpq2YbvLXJ5kezLw8hHU2kAFOFi1hqdSz01Kagw+URnxAMKU
 9oBgX9totBDB5ADtOVsxFhfk2vN2z1eYdJokkj3y4QK+444bOcMhCFGBoZKAR6I7wayNmqbBW
 DGPhcSbwO+JMVz9lHEtpPpWj9uoOz7mNVJfZE2GS6/T/keOktGkfe1pe93Co+T7miCshVnCuZ
 JCAyE7sC8GKzVzCGJ8ov6uRpARyo9J/G8zMdVLf3x9P0UDZV1S71ssl5lsOs8e0H3QFxBWPXN
 H6Ioum5qCh9MeM5Hez9KdTXdWgCXGDHU3C50X/qVdyhtpa1FhvQyfMt/eF8GwWroeakarNtof
 5W82uVc0TjpBf9VKevROSkYW1D3Be+Hcy1vLtR7q12/8fRC+RUwn4GVK8NAIPnPFKqUCFBVPN
 OgbOJmbtSgyVQi0y4TciaVBmTQhFpzAnZwdEwFgL/zyw2OIYcyy+eI4LUjUw0rM1vkxE/hhGv
 UADQgoNGuyf8J0Hh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Run "make defconfig; make savedefconfig" to rebuild defconfig.

This dropped the following configuration options which are nowaday's
already enabled (resp. disabled) by default:

CONFIG_MEMCG_SWAP=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
# CONFIG_BT_HS is not set
CONFIG_FSL_MC_BUS=y
CONFIG_QCOM_SCM=y
CONFIG_MFD_CROS_EC_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_DRM_DISPLAY_CONNECTOR=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_USB_CONN_GPIO=m
CONFIG_USB_XHCI_PCI=m
CONFIG_SDM_GCC_845=y
CONFIG_SM_DISPCC_8250=y
CONFIG_SM_GCC_8150=y
CONFIG_SM_GCC_8250=y
CONFIG_COMMON_CLK_ZYNQMP=y

CONFIG_POWER_AVS was renamed to POWER_AVS_OMAP in commit bca815d62054
("PM: AVS: smartreflex Move driver to soc specific drivers"). As there
are no 64-bit Arm OMAPs it getting dropped seems fair.

Note that the following user-selectable configuration options have been
preserved:

CONFIG_SECCOMP=y
CONFIG_SLIMBUS=m
CONFIG_INTERCONNECT=y
CONFIG_CONFIGFS_FS=y

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v3:
- Not dropping CONFIG_SECCOMP=y, CONFIG_SLIMBUS=m, CONFIG_INTERCONNECT=y
  and CONFIG_CONFIGFS_FS=y as requested by Krzysztof.

Changes in v2:
- Done full defconfig analysis as requested by Krzysztof.

 arch/arm64/configs/defconfig | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 25a4eff126d4..530ad076b5cb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -15,7 +15,6 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_NUMA_BALANCING=y
 CONFIG_MEMCG=y
-CONFIG_MEMCG_SWAP=y
 CONFIG_BLK_CGROUP=y
 CONFIG_CGROUP_PIDS=y
 CONFIG_CGROUP_HUGETLB=y
@@ -85,7 +84,6 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
-CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM=m
@@ -181,7 +179,6 @@ CONFIG_CAN_RCAR=m
 CONFIG_CAN_RCAR_CANFD=m
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
-# CONFIG_BT_HS is not set
 # CONFIG_BT_LE is not set
 CONFIG_BT_LEDS=y
 # CONFIG_BT_DEBUGFS is not set
@@ -237,13 +234,11 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
 CONFIG_HISILICON_LPC=y
 CONFIG_TEGRA_ACONNECT=m
-CONFIG_FSL_MC_BUS=y
 CONFIG_ARM_SCMI_PROTOCOL=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
 CONFIG_INTEL_STRATIX10_RSU=m
-CONFIG_QCOM_SCM=y
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_IMX_SCU_PD=y
@@ -545,7 +540,6 @@ CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_BD9571MWV=m
 CONFIG_GPIO_MAX77620=y
 CONFIG_GPIO_SL28CPLD=m
-CONFIG_POWER_AVS=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_QCOM_PON=m
 CONFIG_POWER_RESET_XGENE=y
@@ -606,7 +600,6 @@ CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
-CONFIG_MFD_CROS_EC_DEV=y
 CONFIG_MFD_EXYNOS_LPASS=m
 CONFIG_MFD_HI6421_PMIC=y
 CONFIG_MFD_HI655X_PMIC=y
@@ -653,8 +646,6 @@ CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
 CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
 CONFIG_MEDIA_SDR_SUPPORT=y
 CONFIG_MEDIA_PLATFORM_SUPPORT=y
-CONFIG_MEDIA_CONTROLLER=y
-CONFIG_VIDEO_V4L2_SUBDEV_API=y
 # CONFIG_DVB_NET is not set
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
@@ -710,7 +701,6 @@ CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
-CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m
@@ -751,7 +741,6 @@ CONFIG_SND_HDA_CODEC_HDMI=m
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_SOC_FSL_ASRC=m
-CONFIG_SND_SOC_FSL_SAI=m
 CONFIG_SND_SOC_FSL_MICFIL=m
 CONFIG_SND_SOC_FSL_EASRC=m
 CONFIG_SND_IMX_SOC=m
@@ -812,11 +801,9 @@ CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_HID_MULTITOUCH=m
 CONFIG_I2C_HID_ACPI=m
 CONFIG_I2C_HID_OF=m
-CONFIG_USB_CONN_GPIO=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_PCI=m
 CONFIG_USB_XHCI_PCI_RENESAS=m
 CONFIG_USB_XHCI_TEGRA=y
 CONFIG_USB_EHCI_HCD=y
@@ -1004,20 +991,15 @@ CONFIG_QCS_GCC_404=y
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
 CONFIG_SDM_CAMCC_845=m
-CONFIG_SDM_GCC_845=y
 CONFIG_SDM_GPUCC_845=y
 CONFIG_SDM_VIDEOCC_845=y
 CONFIG_SDM_DISPCC_845=y
-CONFIG_SM_DISPCC_8250=y
-CONFIG_SM_GCC_8150=y
-CONFIG_SM_GCC_8250=y
 CONFIG_SM_GCC_8350=y
 CONFIG_SM_GPUCC_8150=y
 CONFIG_SM_GPUCC_8250=y
 CONFIG_QCOM_HFPLL=y
 CONFIG_CLK_GFM_LPASS_SM8250=m
 CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
-CONFIG_COMMON_CLK_ZYNQMP=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.33.1

