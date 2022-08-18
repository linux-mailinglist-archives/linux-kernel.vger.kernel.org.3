Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64895984F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245422AbiHRN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245419AbiHRN42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9CAB81DC;
        Thu, 18 Aug 2022 06:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF124616EA;
        Thu, 18 Aug 2022 13:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C55C43141;
        Thu, 18 Aug 2022 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830950;
        bh=TMim+Ik73CVKauxq/BtFH8BZq8AUFq2/qPOsdY3BbdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KAgbPO9f9rDeZMqey4BFgtdd81P7RF88f+Fln94PLC54LWS8r2bpkAk0Teu70XhZg
         yATf/bmyhfP16JSPU8/tceAuAuG/rlXPMz0HcPUwGMmpIdtHLcC8ZedpJhUrF5J/Mf
         G6dsPNJE8KWM3ZErJg+wejUISK1xKcZ8lGnGW/WYx6/Y383dwmRyh4aNW+I2Gka/AB
         iaR8z5JXdEa3DFAW8g7E5t7VCXAtSWXpziGRDcC5S6i/DrM4+kMwwPQl9T70STLvz4
         iSnkPaUonB7zOD4D29vEAzuZhE0RaoKoCk2VxVXYIWvYyT/kiiB8dPCvufWf5cT8L/
         7nXdP6LmMXTzw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Qin Jian <qinjian@cqplus1.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shannon Nelson <snelson@pensando.io>,
        Peter Chen <peter.chen@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 01/11] ARM: defconfig: reorder defconfig files
Date:   Thu, 18 Aug 2022 15:55:22 +0200
Message-Id: <20220818135522.3143514-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818135522.3143514-1-arnd@kernel.org>
References: <20220818135522.3143514-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The debug-info and can subystem options have moved around in the
'savedefconfig' output, so fix these up to reduce the clutter
from the savedefconfig command.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/at91_dt_defconfig   |  2 +-
 arch/arm/configs/dove_defconfig      |  2 +-
 arch/arm/configs/exynos_defconfig    |  2 +-
 arch/arm/configs/imx_v6_v7_defconfig |  2 +-
 arch/arm/configs/keystone_defconfig  |  6 +++---
 arch/arm/configs/lpc18xx_defconfig   |  2 +-
 arch/arm/configs/mmp2_defconfig      |  2 +-
 arch/arm/configs/mps2_defconfig      |  2 +-
 arch/arm/configs/multi_v5_defconfig  |  2 +-
 arch/arm/configs/multi_v7_defconfig  | 12 ++++++------
 arch/arm/configs/mvebu_v5_defconfig  |  2 +-
 arch/arm/configs/mxs_defconfig       |  4 ++--
 arch/arm/configs/omap1_defconfig     |  2 +-
 arch/arm/configs/omap2plus_defconfig |  4 ++--
 arch/arm/configs/orion5x_defconfig   |  2 +-
 arch/arm/configs/pxa168_defconfig    |  2 +-
 arch/arm/configs/pxa910_defconfig    |  2 +-
 arch/arm/configs/pxa_defconfig       |  2 +-
 arch/arm/configs/s3c6400_defconfig   |  2 +-
 arch/arm/configs/s5pv210_defconfig   |  2 +-
 arch/arm/configs/sama5_defconfig     |  6 +++---
 arch/arm/configs/sama7_defconfig     |  4 ++--
 arch/arm/configs/shmobile_defconfig  |  2 +-
 arch/arm/configs/socfpga_defconfig   |  6 +++---
 arch/arm/configs/sp7021_defconfig    |  2 +-
 arch/arm/configs/spear13xx_defconfig |  2 +-
 arch/arm/configs/spear3xx_defconfig  |  2 +-
 arch/arm/configs/spear6xx_defconfig  |  2 +-
 arch/arm/configs/stm32_defconfig     |  2 +-
 arch/arm/configs/sunxi_defconfig     |  2 +-
 arch/arm/configs/tegra_defconfig     |  2 +-
 arch/arm/configs/vexpress_defconfig  |  2 +-
 32 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index da90ce9cd42e..5cc72266eaff 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -40,7 +40,6 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_DIAG is not set
 CONFIG_IPV6_SIT_6RD=y
 CONFIG_CAN=y
-CONFIG_CAN_AT91=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_DEVTMPFS=y
@@ -81,6 +80,7 @@ CONFIG_DM9000=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_DAVICOM_PHY=y
 CONFIG_MICREL_PHY=y
+CONFIG_CAN_AT91=y
 CONFIG_LIBERTAS=m
 CONFIG_LIBERTAS_SDIO=m
 CONFIG_LIBERTAS_SPI=m
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 16ed5c110e8d..a9aa6458d46c 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -116,7 +116,6 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
 CONFIG_TIMER_STATS=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
@@ -136,6 +135,7 @@ CONFIG_CRC_CCITT=y
 CONFIG_LIBCRC32C=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 1ce74f46e114..e3c99d40ffbc 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -374,8 +374,8 @@ CONFIG_FONTS=y
 CONFIG_FONT_7x14=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 01012537a9b9..f692463da019 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -65,7 +65,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_NETFILTER=y
 CONFIG_CAN=y
-CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
 CONFIG_BT_BNEP=m
 CONFIG_BT_HCIUART=y
@@ -136,6 +135,7 @@ CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_MICREL_PHY=y
 CONFIG_AT803X_PHY=y
+CONFIG_CAN_FLEXCAN=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=y
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 68b89b90ca29..97f958d55019 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -109,8 +109,6 @@ CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP_SCTP=y
 CONFIG_VLAN_8021Q=y
 CONFIG_CAN=m
-CONFIG_CAN_C_CAN=m
-CONFIG_CAN_C_CAN_PLATFORM=m
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_DEVTMPFS=y
@@ -137,6 +135,8 @@ CONFIG_TI_KEYSTONE_NETCP_ETHSS=y
 CONFIG_MARVELL_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_DP83867_PHY=y
+CONFIG_CAN_C_CAN=m
+CONFIG_CAN_C_CAN_PLATFORM=m
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_GPIO_DECODER=m
@@ -224,7 +224,6 @@ CONFIG_NFSD=y
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_CRYPTO_USER=y
 CONFIG_CRYPTO_AUTHENC=y
 CONFIG_CRYPTO_CBC=y
@@ -236,5 +235,6 @@ CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_DMA_CMA=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 142c1700f450..56eae6a0a311 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -150,9 +150,9 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SLUB_DEBUG is not set
diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 4d39c615117b..7984640e994e 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -73,10 +73,10 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRC_CCITT=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 # CONFIG_DYNAMIC_DEBUG is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index 700568474549..3ed73f184d83 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -94,9 +94,9 @@ CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index e0be0e0023f3..5f3ed81228b0 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -290,8 +290,8 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_DEV_MARVELL_CESA=y
 CONFIG_CRC_CCITT=y
 CONFIG_LIBCRC32C=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 12b35008571f..7ac539231a90 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -167,12 +167,6 @@ CONFIG_NET_DSA=m
 CONFIG_QRTR=m
 CONFIG_QRTR_SMD=m
 CONFIG_CAN=y
-CONFIG_CAN_AT91=m
-CONFIG_CAN_FLEXCAN=m
-CONFIG_CAN_SUN4I=y
-CONFIG_CAN_XILINXCAN=y
-CONFIG_CAN_RCAR=m
-CONFIG_CAN_MCP251X=y
 CONFIG_BT=m
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_BCM=y
@@ -300,6 +294,12 @@ CONFIG_MARVELL_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
+CONFIG_CAN_AT91=m
+CONFIG_CAN_FLEXCAN=m
+CONFIG_CAN_SUN4I=y
+CONFIG_CAN_XILINXCAN=y
+CONFIG_CAN_RCAR=m
+CONFIG_CAN_MCP251X=y
 CONFIG_MDIO_MSCC_MIIM=m
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_RTL8152=m
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index ef3a33ebc29a..587685182735 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -184,13 +184,13 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_DEV_MARVELL_CESA=y
 CONFIG_CRC_CCITT=y
 CONFIG_LIBCRC32C=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 155553ee06f4..6fbe93375998 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -38,7 +38,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CAN=m
-CONFIG_CAN_FLEXCAN=m
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -62,6 +61,7 @@ CONFIG_ICPLUS_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_SMSC_PHY=y
+CONFIG_CAN_FLEXCAN=m
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC95XX=y
 # CONFIG_WLAN is not set
@@ -163,8 +163,8 @@ CONFIG_CRC_ITU_T=m
 CONFIG_CRC7=m
 CONFIG_FONTS=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_FRAME_WARN=2048
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 54a9f50122af..28a5354bf801 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -218,7 +218,6 @@ CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_UTF8=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
@@ -232,6 +231,7 @@ CONFIG_FONT_8x16=y
 CONFIG_FONT_6x11=y
 CONFIG_FONT_MINI_4x6=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 99d015cf8919..e273365838cb 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -249,8 +249,6 @@ CONFIG_NET_ACT_POLICE=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_NET_SWITCHDEV=y
 CONFIG_CAN=m
-CONFIG_CAN_C_CAN=m
-CONFIG_CAN_C_CAN_PLATFORM=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
@@ -350,6 +348,8 @@ CONFIG_AT803X_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_DP83848_PHY=y
 CONFIG_DP83867_PHY=y
+CONFIG_CAN_C_CAN=m
+CONFIG_CAN_C_CAN_PLATFORM=m
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 1311d9583fcc..22fde5ce5cf6 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -138,9 +138,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_DEV_MARVELL_CESA=y
 CONFIG_CRC_T10DIF=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 # CONFIG_SLUB_DEBUG is not set
 CONFIG_LATENCYTOP=y
 # CONFIG_FTRACE is not set
diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index 70d327895ccf..e4a004260c2e 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -50,9 +50,9 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRC_CCITT=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 5072bde71508..7adf90df6795 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -58,9 +58,9 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRC_CCITT=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 CONFIG_DEBUG_MMP_UART2=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 104a45722799..95c03ee20d28 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -646,7 +646,6 @@ CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_TIMER_STATS=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MANAGER=y
@@ -682,6 +681,7 @@ CONFIG_FONT_6x11=y
 CONFIG_FONT_MINI_4x6=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_FRAME_WARN=0
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index 4f04f583c738..93258d5b57ff 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -62,8 +62,8 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 789e900a8a08..ab9fec22a825 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -115,8 +115,8 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_CRC_CCITT=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_RT_MUTEXES=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 3a6a4851ef26..877bbe7b777e 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -43,9 +43,6 @@ CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_NET_DSA=m
 CONFIG_VLAN_8021Q=m
 CONFIG_CAN=y
-CONFIG_CAN_AT91=y
-CONFIG_CAN_M_CAN=y
-CONFIG_CAN_M_CAN_PLATFORM=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
@@ -90,6 +87,9 @@ CONFIG_MACB=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_MICREL_PHY=y
+CONFIG_CAN_AT91=y
+CONFIG_CAN_M_CAN=y
+CONFIG_CAN_M_CAN_PLATFORM=y
 CONFIG_USB_LAN78XX=m
 CONFIG_LIBERTAS_THINFIRM=m
 CONFIG_LIBERTAS_THINFIRM_USB=m
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 0384030d8b25..8803536854c6 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -59,8 +59,6 @@ CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_NET_DSA=m
 CONFIG_VLAN_8021Q=m
 CONFIG_CAN=y
-CONFIG_CAN_M_CAN=y
-CONFIG_CAN_M_CAN_PLATFORM=y
 CONFIG_BT=y
 CONFIG_BT_RFCOMM=y
 CONFIG_BT_RFCOMM_TTY=y
@@ -107,6 +105,8 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_MACB=y
 CONFIG_MICREL_PHY=y
+CONFIG_CAN_M_CAN=y
+CONFIG_CAN_M_CAN_PLATFORM=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index a29bebb3742e..fa3b0031a72b 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -33,7 +33,6 @@ CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_CAN=y
-CONFIG_CAN_RCAR=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_RCAR_GEN2=y
@@ -57,6 +56,7 @@ CONFIG_RAVB=y
 CONFIG_SMSC911X=y
 CONFIG_MICREL_PHY=y
 CONFIG_SMSC_PHY=y
+CONFIG_CAN_RCAR=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index d91ae3f0d698..70739e09d0f4 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -33,9 +33,6 @@ CONFIG_NETWORK_PHY_TIMESTAMPING=y
 CONFIG_VLAN_8021Q=y
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_CAN=y
-CONFIG_CAN_C_CAN=y
-CONFIG_CAN_C_CAN_PLATFORM=y
-CONFIG_CAN_DEBUG_DEVICES=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCIE_ALTERA=y
@@ -70,6 +67,9 @@ CONFIG_IXGBE=m
 CONFIG_STMMAC_ETH=y
 CONFIG_MARVELL_PHY=y
 CONFIG_MICREL_PHY=y
+CONFIG_CAN_C_CAN=y
+CONFIG_CAN_C_CAN_PLATFORM=y
+CONFIG_CAN_DEBUG_DEVICES=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_STMPE=y
diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp7021_defconfig
index 703b9aaa40f0..aa7dfd670db5 100644
--- a/arch/arm/configs/sp7021_defconfig
+++ b/arch/arm/configs/sp7021_defconfig
@@ -13,7 +13,6 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_PERF_EVENTS=y
-CONFIG_SLAB=y
 CONFIG_ARCH_SUNPLUS=y
 # CONFIG_VDSO is not set
 CONFIG_SMP=y
@@ -25,6 +24,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_SLAB=y
 CONFIG_UEVENT_HELPER=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 0227dd566c28..bfde0c86cdc5 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -98,7 +98,7 @@ CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 254d970a4011..a96ed5cf778e 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -78,7 +78,7 @@ CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index 2809c4eb77e7..3d631b1f3cfa 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -67,7 +67,7 @@ CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 1f5446cda8b6..dc1a32f50b7e 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -74,9 +74,9 @@ CONFIG_NLS=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 3d14827e0a31..06e91ee422fd 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CAN=y
-CONFIG_CAN_SUN4I=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -52,6 +51,7 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_MICREL_PHY=y
 CONFIG_REALTEK_PHY=y
+CONFIG_CAN_SUN4I=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_SUN4I_LRADC=y
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 71400af6cef4..9c270e3cb9d9 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -54,7 +54,6 @@ CONFIG_IPV6_MIP6=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_CAN=y
-CONFIG_CAN_MCP251X=y
 CONFIG_BT=y
 CONFIG_BT_RFCOMM=y
 CONFIG_BT_BNEP=y
@@ -99,6 +98,7 @@ CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_IGB=y
 CONFIG_R8169=y
+CONFIG_CAN_MCP251X=y
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index 4e3a0133e4d3..ac3fd7523698 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -133,8 +133,8 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_CRYPTO_HW is not set
 CONFIG_DMA_CMA=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
-- 
2.29.2

