Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4044B21B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiBKJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:24:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbiBKJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:24:23 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F11B81
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:24:22 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LeehE-1o5Vwl07hu-00qU54;
 Fri, 11 Feb 2022 10:24:01 +0100
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
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/12] arm64: defconfig: rebuild default configuration
Date:   Fri, 11 Feb 2022 10:23:15 +0100
Message-Id: <20220211092322.287487-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220211092322.287487-1-marcel@ziswiler.com>
References: <20220211092322.287487-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hnRap2lO+NR1q2H57xBFH0zzt2zWB6J2jpuBBlmRUhtqz3+DFkh
 U56P7OhGxzRXHtct2Sbp/Vek5sgxnROLtcyq5AYAUOCWWAEVHbhkYxGtcktqhkU7LxZIhJB
 EKDsElrLPCHG+7R37UPZIcxPKPFhGuAoZEoVCzo1CTIm9f2uREqjsftR9XivH9LGlJa369G
 YxZKAXFo3QQwrpOfh1txA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DXtJYxZGdgA=:frAwcT0CAfKFRXU0RVcle6
 ZvSpT06pYHYWOSf4Fm4Om9yNOrVRBj7U0+lh4WBhwYlXLKjP5y+Hc4ixBALKWNla6U85cO/Ep
 SA6uYZh1Hrg/g7noV88hhwYaIFh48Rz2464HhuQGIIreemqcFcggyNm2MsEAlPxSEuQ+MAUBX
 7XhlRTI/6KwimtXTS1glb2me3Gxr4OESHFTBznPxWivOC/6ZsP9R/unXmed3820NuIa/GU2+H
 d4Hdv+QqP9h1thw92cDlcXehY2okcZUk3FRo89+dKrESgpO6iRVjCVu6UYyFkA6jQPnpZAbkc
 VZbfQ2fqwYnR/Tna/iKYt4AsFc80sdqrkt/gBCkS3cZxUJxz8CdI9Up5J6PS1ZOI0AWG5I0Gj
 JZnwjp/bOB6/eJ+CwmTphFxRu2hk0uKJff9jNkkm+fq+mi8ReAazQMDoSHQqKhTspMKXyu1pR
 3+6LS13U2bveEZUtVPVhjwG5nZaivwjOWGzB7Z/zfWt2f1IPRfCxLkY0UqMFRONPZz+If8fyn
 qjtrYhy62MTNXJWK3hX/e9bXluf9h7Gd3uYI1kZhFxGWDn3ACksKs6YVG5w6hrCN9gkUe98kX
 trZi6uRv8uDUcOuv7PUOiScylprtrTeelk9bjkpzJz+UDhVRSlJonXcT2jZHSkBPxuDmVP5MI
 SkFX4AWLsptzbJtvBkA1jXPx0yjOPaMzV6yu2ibf/e+igAz0sJ48SyTODAQTMg8xdyavum6Ul
 a5Z/aEmgKn3x5xB5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

(no changes since v3)

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

