Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A14D57CD01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiGUOOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGUON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:13:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7254AF1;
        Thu, 21 Jul 2022 07:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F9561F7C;
        Thu, 21 Jul 2022 14:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D753AC341CF;
        Thu, 21 Jul 2022 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658412832;
        bh=qAm/QOqg2XuYrHbiK4eEimRBIp7akpTmMns9VF5vM9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kemjQQ85SFJkvMQS+1wntExif6lymPSqAOoS+Hutw5XR+/3qtRBJtPtjVIwbcszz2
         cuMhZeH1G93TWttA+5eyUdKuWD0z8J1bbvGeB+erdSVZ24QMXnKWY4ceCrZcv9qfJl
         /dpnTru9s/vasKbvTegz8C6uiyl4/Nx5NinUzI/7ypzpgC6FdwIJxBsWSrFrEPgNK/
         QG7xCb9a4LP7iCW21UQERsBFu9xP+d3k95UU4ghtCF/AvkjYSmjegU6/y2zluNgfZs
         nGgcTICnWKFUwJ5N4lHikaQ/uwUIjqEpcjFFUL03oRxr9+wtaEW0Jdc10rsqmRLsxF
         4hOA/YywhI4iQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-oxnas@groups.io, linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: [PATCH 1/6] ARM: refresh defconfig files
Date:   Thu, 21 Jul 2022 16:13:20 +0200
Message-Id: <20220721141325.2413920-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220721141325.2413920-1-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A lot of Kconfig options have changed over the years, and we tend
to not do a blind 'make defconfig' to refresh the files, to ensure
we catch options that should not have gone away.

I used some a bit of scripting to only rework the bits where an
option moved around in any of the defconfig files, without also
dropping any of the other lines, to make it clearer which options
we no longer have.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/am200epdkit_defconfig    |  26 ++---
 arch/arm/configs/aspeed_g4_defconfig      |  16 +--
 arch/arm/configs/aspeed_g5_defconfig      |  16 +--
 arch/arm/configs/assabet_defconfig        |   8 +-
 arch/arm/configs/at91_dt_defconfig        |  10 +-
 arch/arm/configs/axm55xx_defconfig        |  22 ++--
 arch/arm/configs/badge4_defconfig         |   8 +-
 arch/arm/configs/bcm2835_defconfig        |  36 +++----
 arch/arm/configs/cerfcube_defconfig       |  16 +--
 arch/arm/configs/clps711x_defconfig       |   2 +-
 arch/arm/configs/cm_x300_defconfig        |  26 ++---
 arch/arm/configs/cns3420vb_defconfig      |  18 ++--
 arch/arm/configs/colibri_pxa270_defconfig |  32 +++---
 arch/arm/configs/colibri_pxa300_defconfig |  10 +-
 arch/arm/configs/collie_defconfig         |  20 ++--
 arch/arm/configs/corgi_defconfig          |  44 ++++----
 arch/arm/configs/davinci_all_defconfig    |  26 ++---
 arch/arm/configs/dove_defconfig           |  28 ++---
 arch/arm/configs/ep93xx_defconfig         |  16 +--
 arch/arm/configs/eseries_pxa_defconfig    |  26 ++---
 arch/arm/configs/exynos_defconfig         |  20 ++--
 arch/arm/configs/ezx_defconfig            |  72 ++++++-------
 arch/arm/configs/footbridge_defconfig     |  14 +--
 arch/arm/configs/h3600_defconfig          |  10 +-
 arch/arm/configs/h5000_defconfig          |  18 ++--
 arch/arm/configs/hackkit_defconfig        |   4 +-
 arch/arm/configs/hisi_defconfig           |  24 ++---
 arch/arm/configs/imx_v4_v5_defconfig      |   8 +-
 arch/arm/configs/imx_v6_v7_defconfig      |   8 +-
 arch/arm/configs/integrator_defconfig     |   2 +-
 arch/arm/configs/iop32x_defconfig         |  20 ++--
 arch/arm/configs/jornada720_defconfig     |  10 +-
 arch/arm/configs/keystone_defconfig       |  62 +++++------
 arch/arm/configs/lart_defconfig           |   6 +-
 arch/arm/configs/lpc18xx_defconfig        |  12 +--
 arch/arm/configs/lpc32xx_defconfig        |   8 +-
 arch/arm/configs/lpd270_defconfig         |   6 +-
 arch/arm/configs/lubbock_defconfig        |  10 +-
 arch/arm/configs/magician_defconfig       |  30 +++---
 arch/arm/configs/mainstone_defconfig      |   4 +-
 arch/arm/configs/milbeaut_m10v_defconfig  |   6 +-
 arch/arm/configs/mini2440_defconfig       |   6 +-
 arch/arm/configs/mmp2_defconfig           |  28 ++---
 arch/arm/configs/moxart_defconfig         |  18 ++--
 arch/arm/configs/mps2_defconfig           |  14 +--
 arch/arm/configs/multi_v4t_defconfig      |   4 +-
 arch/arm/configs/multi_v5_defconfig       |  12 +--
 arch/arm/configs/multi_v7_defconfig       |  62 +++++------
 arch/arm/configs/mv78xx0_defconfig        |  32 +++---
 arch/arm/configs/mvebu_v5_defconfig       |  28 ++---
 arch/arm/configs/mvebu_v7_defconfig       |   2 +-
 arch/arm/configs/mxs_defconfig            |   4 +-
 arch/arm/configs/neponset_defconfig       |  24 ++---
 arch/arm/configs/netwinder_defconfig      |  10 +-
 arch/arm/configs/nhk8815_defconfig        |   6 +-
 arch/arm/configs/omap1_defconfig          |  74 ++++++-------
 arch/arm/configs/omap2plus_defconfig      |  16 +--
 arch/arm/configs/orion5x_defconfig        |  32 +++---
 arch/arm/configs/oxnas_v6_defconfig       |  14 +--
 arch/arm/configs/palmz72_defconfig        |  14 +--
 arch/arm/configs/pcm027_defconfig         |  22 ++--
 arch/arm/configs/pleb_defconfig           |   6 +-
 arch/arm/configs/pxa168_defconfig         |  18 ++--
 arch/arm/configs/pxa255-idp_defconfig     |  10 +-
 arch/arm/configs/pxa3xx_defconfig         |  18 ++--
 arch/arm/configs/pxa910_defconfig         |  22 ++--
 arch/arm/configs/pxa_defconfig            | 126 +++++++++++-----------
 arch/arm/configs/qcom_defconfig           |  60 +++++------
 arch/arm/configs/realview_defconfig       |   8 +-
 arch/arm/configs/rpc_defconfig            |  18 ++--
 arch/arm/configs/s3c2410_defconfig        |   8 +-
 arch/arm/configs/s3c6400_defconfig        |   2 +-
 arch/arm/configs/s5pv210_defconfig        |   4 +-
 arch/arm/configs/sama5_defconfig          |   8 +-
 arch/arm/configs/sama7_defconfig          |   8 +-
 arch/arm/configs/shannon_defconfig        |   8 +-
 arch/arm/configs/simpad_defconfig         |  18 ++--
 arch/arm/configs/socfpga_defconfig        |   4 +-
 arch/arm/configs/spear13xx_defconfig      |  16 +--
 arch/arm/configs/spear3xx_defconfig       |  10 +-
 arch/arm/configs/spear6xx_defconfig       |   8 +-
 arch/arm/configs/spitz_defconfig          |  44 ++++----
 arch/arm/configs/stm32_defconfig          |  14 +--
 arch/arm/configs/sunxi_defconfig          |   2 +-
 arch/arm/configs/tct_hammer_defconfig     |  12 +--
 arch/arm/configs/tegra_defconfig          |  18 ++--
 arch/arm/configs/trizeps4_defconfig       |  58 +++++-----
 arch/arm/configs/u8500_defconfig          |   2 +-
 arch/arm/configs/versatile_defconfig      |   4 +-
 arch/arm/configs/vexpress_defconfig       |   4 +-
 arch/arm/configs/vf610m4_defconfig        |   2 +-
 arch/arm/configs/viper_defconfig          |  28 ++---
 arch/arm/configs/vt8500_v6_v7_defconfig   |   2 +-
 arch/arm/configs/xcep_defconfig           |  30 +++---
 arch/arm/configs/zeus_defconfig           |  26 ++---
 95 files changed, 904 insertions(+), 904 deletions(-)

diff --git a/arch/arm/configs/am200epdkit_defconfig b/arch/arm/configs/am200epdkit_defconfig
index 9252ce0e722b..bd57a66d8f2b 100644
--- a/arch/arm/configs/am200epdkit_defconfig
+++ b/arch/arm/configs/am200epdkit_defconfig
@@ -1,25 +1,24 @@
 CONFIG_LOCALVERSION="gum"
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_PREEMPT=y
 CONFIG_EXPERT=y
 # CONFIG_EPOLL is not set
 # CONFIG_SHMEM is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_GUMSTIX=y
-CONFIG_PCCARD=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyS0,115200n8 root=1f01 rootfstype=jffs2"
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_SWAP is not set
+CONFIG_SLAB=y
+# CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
@@ -35,6 +34,7 @@ CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=m
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_H4=y
+CONFIG_PCCARD=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -48,14 +48,15 @@ CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PXA2XX=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_SD=m
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=m
 CONFIG_PATA_PCMCIA=m
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=m
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
@@ -84,16 +85,15 @@ CONFIG_VFAT_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_RUBIN=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DETECT_SOFTLOCKUP is not set
-# CONFIG_DEBUG_PREEMPT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_ARC4=m
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 5d20057bdc43..dfb803753ea1 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -1,5 +1,4 @@
 CONFIG_KERNEL_XZ=y
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -17,9 +16,6 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_AIO is not set
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB_FREELIST_RANDOM=y
-CONFIG_SLAB_FREELIST_HARDENED=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G4=y
@@ -30,7 +26,6 @@ CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_KEXEC=y
-CONFIG_FIRMWARE_MEMMAP=y
 CONFIG_JUMP_LABEL=y
 CONFIG_STRICT_KERNEL_RWX=y
 # CONFIG_BLK_DEV_BSG is not set
@@ -38,6 +33,10 @@ CONFIG_STRICT_KERNEL_RWX=y
 # CONFIG_MQ_IOSCHED_DEADLINE is not set
 # CONFIG_MQ_IOSCHED_KYBER is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SWAP is not set
+CONFIG_SLAB_FREELIST_RANDOM=y
+CONFIG_SLAB_FREELIST_HARDENED=y
+# CONFIG_COMPAT_BRK is not set
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -57,12 +56,12 @@ CONFIG_NET_NCSI=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_FIRMWARE_MEMMAP=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PARTITIONED_MASTER=y
 CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
-CONFIG_SPI_ASPEED_SMC=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_BLOCK=y
@@ -88,9 +87,9 @@ CONFIG_FTGMAC100=y
 # CONFIG_NET_VENDOR_MELLANOX is not set
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROSEMI is not set
+# CONFIG_NET_VENDOR_NI is not set
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
 # CONFIG_NET_VENDOR_QUALCOMM is not set
 # CONFIG_NET_VENDOR_RENESAS is not set
 # CONFIG_NET_VENDOR_ROCKER is not set
@@ -134,6 +133,7 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_ASPEED=y
 CONFIG_I2C_FSI=y
 CONFIG_SPI=y
+CONFIG_SPI_ASPEED_SMC=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_ASPEED=y
@@ -245,8 +245,8 @@ CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index ae4f3c56ae6b..7586fb475a1b 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -1,5 +1,4 @@
 CONFIG_KERNEL_XZ=y
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -17,9 +16,6 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_AIO is not set
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB_FREELIST_RANDOM=y
-CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G5=y
@@ -36,13 +32,16 @@ CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_FIRMWARE_MEMMAP=y
 CONFIG_JUMP_LABEL=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEBUG_FS is not set
 # CONFIG_MQ_IOSCHED_DEADLINE is not set
 # CONFIG_MQ_IOSCHED_KYBER is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SWAP is not set
+CONFIG_SLAB_FREELIST_RANDOM=y
+CONFIG_SLAB_FREELIST_HARDENED=y
+# CONFIG_COMPAT_BRK is not set
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -70,12 +69,12 @@ CONFIG_NET_NCSI=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_FIRMWARE_MEMMAP=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PARTITIONED_MASTER=y
 CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
-CONFIG_SPI_ASPEED_SMC=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_BLOCK=y
@@ -103,9 +102,9 @@ CONFIG_FTGMAC100=y
 # CONFIG_NET_VENDOR_MELLANOX is not set
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROSEMI is not set
+# CONFIG_NET_VENDOR_NI is not set
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
 # CONFIG_NET_VENDOR_QUALCOMM is not set
 # CONFIG_NET_VENDOR_RENESAS is not set
 # CONFIG_NET_VENDOR_ROCKER is not set
@@ -156,6 +155,7 @@ CONFIG_I2C_ASPEED=y
 CONFIG_I2C_FSI=y
 CONFIG_I2C_SLAVE=y
 CONFIG_SPI=y
+CONFIG_SPI_ASPEED_SMC=y
 CONFIG_SPI_FSI=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
@@ -274,8 +274,8 @@ CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index 04c86ff558da..db80b8193e66 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -1,11 +1,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_SA1100=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -13,6 +10,8 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=32M console=ttySA0,38400n8 initrd=0xc0800000,3M root=/dev/ram"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
+CONFIG_MODULES=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -20,6 +19,8 @@ CONFIG_INET=y
 CONFIG_IRDA=m
 CONFIG_IRLAN=m
 CONFIG_SA1100_FIR=m
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_SA1100=y
 CONFIG_MTD=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -51,6 +52,5 @@ CONFIG_MSDOS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index db15a8be6389..da90ce9cd42e 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -9,7 +8,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
-CONFIG_SLAB=y
 CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
@@ -27,8 +25,9 @@ CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 r
 CONFIG_KEXEC=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SWAP is not set
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -66,6 +65,7 @@ CONFIG_ATMEL_SSC=y
 CONFIG_EEPROM_AT24=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
@@ -139,9 +139,9 @@ CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_ATMEL_ISI=y
+CONFIG_VIDEO_MT9V032=m
 CONFIG_VIDEO_OV2640=m
 CONFIG_VIDEO_OV7740=m
-CONFIG_VIDEO_MT9V032=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
 CONFIG_DRM_PANEL_SIMPLE=y
@@ -206,8 +206,8 @@ CONFIG_PWM_ATMEL=y
 CONFIG_PWM_ATMEL_HLCDC_PWM=y
 CONFIG_PWM_ATMEL_TCB=y
 CONFIG_EXT4_FS=y
-CONFIG_AUTOFS_FS=m
 CONFIG_FANOTIFY=y
+CONFIG_AUTOFS_FS=m
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_UBIFS_FS=y
diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index 46075216ee6d..c6850a6b9a8b 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -3,6 +3,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
 CONFIG_AUDIT=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASKSTATS=y
@@ -21,12 +22,8 @@ CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
-# CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_AXXIA=y
-CONFIG_GPIO_PCA953X=y
 CONFIG_ARM_LPAE=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_430973=y
@@ -37,26 +34,26 @@ CONFIG_ARM_ERRATA_754327=y
 CONFIG_ARM_ERRATA_764369=y
 CONFIG_ARM_ERRATA_775420=y
 CONFIG_ARM_ERRATA_798181=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
 CONFIG_PCIE_AXXIA=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
 CONFIG_HOTPLUG_CPU=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
 CONFIG_HIGHMEM=y
-CONFIG_KSM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
+# CONFIG_SUSPEND is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=y
-# CONFIG_SUSPEND is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_KSM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -76,6 +73,8 @@ CONFIG_INET_IPCOMP=y
 CONFIG_NETWORK_PHY_TIMESTAMPING=y
 CONFIG_BRIDGE=y
 # CONFIG_WIRELESS is not set
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
@@ -142,9 +141,10 @@ CONFIG_DP83640_PHY=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PL061=y
-CONFIG_POWER_SUPPLY=y
+CONFIG_GPIO_PCA953X=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_AXXIA=y
+CONFIG_POWER_SUPPLY=y
 CONFIG_SENSORS_ADT7475=y
 CONFIG_SENSORS_JC42=y
 CONFIG_SENSORS_LM75=y
@@ -224,6 +224,7 @@ CONFIG_NFS_FSCACHE=y
 CONFIG_SUNRPC_DEBUG=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_CRYPTO_XCBC=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
@@ -233,6 +234,5 @@ CONFIG_RCU_CPU_STALL_TIMEOUT=60
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_GCM=y
-CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_SHA256=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index d9119da65f48..cdf3e3f99942 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -1,7 +1,5 @@
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
-CONFIG_MODULES=y
-CONFIG_MODVERSIONS=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_BADGE4=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -10,6 +8,9 @@ CONFIG_CMDLINE="init=/linuxrc root=/dev/mtdblock3"
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=m
+CONFIG_MODULES=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -101,10 +102,9 @@ CONFIG_MINIX_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
 CONFIG_SMB_FS=m
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 9270512c14ea..445f38bc340d 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -2,6 +2,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_LOG_BUF_SHIFT=18
@@ -19,19 +20,12 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
-# CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_JUMP_LABEL=y
 CONFIG_CC_STACKPROTECTOR_REGULAR=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
-CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
-CONFIG_KSM=y
-CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
@@ -44,9 +38,15 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=y
 CONFIG_VFP=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_SUSPEND is not set
 CONFIG_PM=y
+CONFIG_JUMP_LABEL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_KSM=y
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -63,8 +63,7 @@ CONFIG_MAC80211=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
-CONFIG_DMA_CMA=y
-CONFIG_CMA_SIZE_MBYTES=32
+CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_CONSTANTS=y
@@ -152,7 +151,6 @@ CONFIG_BCM2835_MBOX=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=y
-CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -171,20 +169,22 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+# CONFIG_XZ_DEC_ARM is not set
+# CONFIG_XZ_DEC_ARMTHUMB is not set
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
 CONFIG_BOOT_PRINTK_DELAY=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_LOCKUP_DETECTOR=y
-CONFIG_SCHED_TRACER=y
-CONFIG_STACK_TRACER=y
-CONFIG_FUNCTION_PROFILER=y
-CONFIG_TEST_KSTRTOX=y
 CONFIG_DEBUG_FS=y
 CONFIG_KGDB=y
 CONFIG_KGDB_KDB=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_FUNCTION_PROFILER=y
+CONFIG_STACK_TRACER=y
+CONFIG_SCHED_TRACER=y
 CONFIG_STRICT_DEVMEM=y
-# CONFIG_XZ_DEC_ARM is not set
-# CONFIG_XZ_DEC_ARMTHUMB is not set
+CONFIG_TEST_KSTRTOX=y
diff --git a/arch/arm/configs/cerfcube_defconfig b/arch/arm/configs/cerfcube_defconfig
index 3f910bbf1bfd..8c9b6ddf026a 100644
--- a/arch/arm/configs/cerfcube_defconfig
+++ b/arch/arm/configs/cerfcube_defconfig
@@ -1,14 +1,9 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_CERF=y
 CONFIG_SA1100_CERF_FLASH_16MB=y
-CONFIG_PCCARD=m
-CONFIG_PCMCIA_SA1100=m
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -18,6 +13,10 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=m
 CONFIG_FPE_FASTFPE=y
 CONFIG_PM=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -27,9 +26,11 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 # CONFIG_IPV6 is not set
+CONFIG_PCCARD=m
+CONFIG_PCMCIA_SA1100=m
 CONFIG_MTD=y
-CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
@@ -60,11 +61,10 @@ CONFIG_NFS_V4=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V4=y
 CONFIG_SMB_FS=m
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 63a153f5cf68..b56d82d4eacd 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -4,7 +4,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_LZMA=y
 CONFIG_EMBEDDED=y
-CONFIG_SLOB=y
 CONFIG_JUMP_LABEL=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_CLPS711X=y
@@ -17,6 +16,7 @@ CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 # CONFIG_COREDUMP is not set
+CONFIG_SLOB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/arm/configs/cm_x300_defconfig b/arch/arm/configs/cm_x300_defconfig
index bb0fcd82d2a7..232c891a7471 100644
--- a/arch/arm/configs/cm_x300_defconfig
+++ b/arch/arm/configs/cm_x300_defconfig
@@ -1,20 +1,15 @@
 CONFIG_LOCALVERSION="-cm-x300"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
-CONFIG_GPIO_PCA953X=y
 CONFIG_MACH_CM_X300=y
-CONFIG_NO_HZ=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -24,6 +19,10 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_FPE_NWFPE=y
 CONFIG_APM_EMULATION=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -55,6 +54,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_DM9000=y
@@ -80,6 +80,7 @@ CONFIG_I2C_PXA=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCA953X=y
 # CONFIG_HWMON is not set
 CONFIG_PMIC_DA903X=y
 CONFIG_REGULATOR=y
@@ -91,8 +92,6 @@ CONFIG_LCD_TDO24M=y
 CONFIG_BACKLIGHT_DA903X=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
-CONFIG_FONTS=y
-CONFIG_FONT_6x11=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
@@ -147,18 +146,19 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CIFS=m
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-CONFIG_DEBUG_FS=y
+CONFIG_CRYPTO_MICHAEL_MIC=m
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_T10DIF=y
+CONFIG_FONTS=y
+CONFIG_FONT_6x11=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_AES=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/arm/configs/cns3420vb_defconfig b/arch/arm/configs/cns3420vb_defconfig
index 63fa2eb21b75..416728cffadb 100644
--- a/arch/arm/configs/cns3420vb_defconfig
+++ b/arch/arm/configs/cns3420vb_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
@@ -9,23 +8,23 @@ CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_PERF_EVENTS is not set
-CONFIG_SLAB=y
 CONFIG_PROFILING=y
+CONFIG_ARCH_MULTI_V6=y
+CONFIG_ARCH_CNS3XXX=y
+CONFIG_MACH_CNS3420VB=y
+CONFIG_CMDLINE="console=ttyS0,38400 mem=128M root=/dev/mmcblk0p1 ro rootwait"
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_IOSCHED_BFQ=m
-CONFIG_ARCH_MULTI_V6=y
 #CONFIG_ARCH_MULTI_V7 is not set
-CONFIG_ARCH_CNS3XXX=y
-CONFIG_MACH_CNS3420VB=y
 CONFIG_DEBUG_CNS3XXX=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttyS0,38400 mem=128M root=/dev/mmcblk0p1 ro rootwait"
+# CONFIG_SWAP is not set
+CONFIG_SLAB=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -36,6 +35,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=20000
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 # CONFIG_SATA_PMP is not set
 # CONFIG_ATA_SFF is not set
@@ -43,9 +43,9 @@ CONFIG_ATA=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
@@ -59,6 +59,6 @@ CONFIG_AUTOFS4_FS=y
 CONFIG_FSCACHE=y
 CONFIG_TMPFS=y
 # CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_FS=y
 # CONFIG_ARM_UNWIND is not set
 CONFIG_CRC_CCITT=y
+CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index b29898fd6a12..14bc9a1e185b 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -1,5 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
@@ -9,20 +10,19 @@ CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
-CONFIG_SLAB=y
+# CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_ARCH_PXA=y
+CONFIG_MACH_COLIBRI=y
+CONFIG_AEABI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_ARCH_MULTI_V7 is not set
-CONFIG_ARCH_PXA=y
-CONFIG_MACH_COLIBRI=y
-CONFIG_PREEMPT=y
-CONFIG_AEABI=y
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -64,22 +64,22 @@ CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PXA2XX=y
 CONFIG_MTD_BLOCK2MTD=y
+CONFIG_MTD_ONENAND=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DISKONCHIP=y
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x4000000
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
 CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
-CONFIG_MTD_ONENAND=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=8
 CONFIG_NETDEVICES=y
-CONFIG_PHYLIB=y
 CONFIG_NET_ETHERNET=y
 CONFIG_DM9000=y
+CONFIG_PHYLIB=y
 CONFIG_HOSTAP=y
 CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
@@ -107,9 +107,6 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
 CONFIG_LOGO=y
 # CONFIG_USB_HID is not set
 CONFIG_USB=y
@@ -143,13 +140,8 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
-CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
 CONFIG_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_PCBC=m
@@ -161,3 +153,11 @@ CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRC_CCITT=y
 CONFIG_CRC16=y
 CONFIG_LIBCRC32C=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_PRINTK_TIME=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_USER=y
+CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/colibri_pxa300_defconfig b/arch/arm/configs/colibri_pxa300_defconfig
index f9d110294644..1aaab3d01be0 100644
--- a/arch/arm/configs/colibri_pxa300_defconfig
+++ b/arch/arm/configs/colibri_pxa300_defconfig
@@ -1,6 +1,3 @@
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_COLIBRI300=y
@@ -8,6 +5,8 @@ CONFIG_AEABI=y
 CONFIG_CMDLINE="console=ttyS0,115200 rw"
 CONFIG_CPU_IDLE=y
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -18,6 +17,7 @@ CONFIG_IPV6=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_AX88796=y
@@ -48,12 +48,12 @@ CONFIG_EXT3_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_AES=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_ARC4=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 36384fd575f8..ff40d3214729 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
@@ -6,22 +5,23 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_BASE_FULL is not set
 # CONFIG_EPOLL is not set
-CONFIG_SLOB=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_COLLIE=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_SA1100=y
-CONFIG_PCMCIA_DEBUG=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
+# CONFIG_SWAP is not set
+CONFIG_SLOB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_SA1100=y
+CONFIG_PCMCIA_DEBUG=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -48,12 +48,12 @@ CONFIG_KEYBOARD_LOCOMO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_SERIO_SERPORT is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CS=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 # CONFIG_HWMON is not set
 CONFIG_MCP_SA11X0=y
 CONFIG_MCP_UCB1200=y
@@ -64,8 +64,6 @@ CONFIG_FB_SA1100=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
-CONFIG_FONTS=y
-CONFIG_FONT_MINI_4x6=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_LOCOMO=y
@@ -80,9 +78,11 @@ CONFIG_ROMFS_FS=y
 CONFIG_NLS_DEFAULT="cp437"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_CRC_CCITT=y
+CONFIG_FONTS=y
+CONFIG_FONT_MINI_4x6=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DETECT_SOFTLOCKUP is not set
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_CRC_CCITT=y
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index 96c677c98bc7..8bc19fc9ca6c 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -1,14 +1,11 @@
 CONFIG_SYSVIPC=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_PXA_SHARPSL=y
@@ -16,14 +13,15 @@ CONFIG_MACH_POODLE=y
 CONFIG_MACH_CORGI=y
 CONFIG_MACH_SHEPHERD=y
 CONFIG_MACH_HUSKY=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_PXA2XX=y
-CONFIG_PREEMPT=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PM=y
 CONFIG_NET=y
@@ -81,6 +79,8 @@ CONFIG_BT_HCIBT3C=m
 CONFIG_BT_HCIBLUECARD=m
 CONFIG_BT_HCIBTUART=m
 CONFIG_BT_HCIVHCI=m
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_PXA2XX=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -95,10 +95,15 @@ CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
+CONFIG_PCMCIA_PCNET=m
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_ASYNC=m
 CONFIG_USB_CATC=m
 CONFIG_USB_KAWETH=m
 CONFIG_USB_PEGASUS=m
@@ -106,10 +111,6 @@ CONFIG_USB_RTL8150=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
 CONFIG_NET_PCMCIA=y
-CONFIG_PCMCIA_PCNET=m
-CONFIG_PPP=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
@@ -120,11 +121,11 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_UINPUT=m
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=m
 CONFIG_SERIAL_8250_CS=m
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 CONFIG_I2C=y
 CONFIG_I2C_PXA=y
 CONFIG_SPI=y
@@ -136,13 +137,8 @@ CONFIG_LCD_CORGI=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
 CONFIG_SOUND=y
 CONFIG_SOUND_PRIME=y
-CONFIG_USB_KBD=m
-CONFIG_USB_MOUSE=m
 CONFIG_HID_A4TECH=m
 CONFIG_HID_APPLE=m
 CONFIG_HID_BELKIN=m
@@ -159,6 +155,8 @@ CONFIG_HID_PETALYNX=m
 CONFIG_HID_SAMSUNG=m
 CONFIG_HID_SONY=m
 CONFIG_HID_SUNPLUS=m
+CONFIG_USB_KBD=m
+CONFIG_USB_MOUSE=m
 CONFIG_USB=m
 CONFIG_USB_MON=m
 CONFIG_USB_SL811_HCD=m
@@ -220,16 +218,12 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_SMB_FS=m
 CONFIG_SMB_NLS_DEFAULT=y
-CONFIG_PARTITION_ADVANCED=y
+CONFIG_NFS_V4=m
 CONFIG_NLS_DEFAULT="cp437"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_DEBUG_PREEMPT is not set
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_LL=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_ECB=m
@@ -252,3 +246,9 @@ CONFIG_CRYPTO_TWOFISH=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_CCITT=y
 CONFIG_LIBCRC32C=m
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index b58d45a03607..673dd230a229 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -1,8 +1,8 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -10,14 +10,9 @@ CONFIG_CGROUPS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_MULTIPLATFORM=y
-CONFIG_ARCH_MULTI_V7=n
 CONFIG_ARCH_MULTI_V5=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_DAVINCI=y
 CONFIG_ARCH_DAVINCI_DM644x=y
 CONFIG_ARCH_DAVINCI_DM355=y
@@ -32,9 +27,7 @@ CONFIG_MACH_MITYOMAPL138=y
 CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_DAVINCI_MUX_DEBUG=y
 CONFIG_DAVINCI_MUX_WARNINGS=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -48,6 +41,13 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
 CONFIG_CPUFREQ_DT=m
 CONFIG_CPU_IDLE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_SWAP is not set
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -65,7 +65,6 @@ CONFIG_BT_HCIUART_LL=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER=m
-CONFIG_DMA_CMA=y
 CONFIG_DA8XX_MSTPRI=y
 CONFIG_MTD=m
 CONFIG_MTD_TESTS=m
@@ -95,8 +94,8 @@ CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
 CONFIG_DM9000=y
 CONFIG_TI_DAVINCI_EMAC=y
-CONFIG_LSI_ET1011C_PHY=y
 CONFIG_LXT_PHY=y
+CONFIG_LSI_ET1011C_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_PPP=m
 CONFIG_PPP_DEFLATE=m
@@ -262,10 +261,11 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_T10DIF=m
+CONFIG_DMA_CMA=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_ARM_UNWIND is not set
 CONFIG_DEBUG_USER=y
-# CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_T10DIF=m
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index f8fb4758f80d..33d13c425d80 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -3,20 +3,12 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
 # CONFIG_ARCH_MULTI_V6 is not set
 CONFIG_ARCH_MULTI_V7=y
 CONFIG_ARCH_DOVE=y
 CONFIG_MACH_DOVE_DB=y
 CONFIG_MACH_CM_A510=y
 CONFIG_MACH_DOVE_DT=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCI_MVEBU=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -24,6 +16,10 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -33,6 +29,9 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_MVEBU=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
@@ -53,6 +52,7 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 CONFIG_SATA_MV=y
@@ -117,14 +117,8 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
-CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_FS=y
-# CONFIG_SCHED_DEBUG is not set
 CONFIG_TIMER_STATS=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
@@ -142,3 +136,9 @@ CONFIG_CRYPTO_LZO=y
 CONFIG_CRYPTO_DEV_MARVELL_CESA=y
 CONFIG_CRC_CCITT=y
 CONFIG_LIBCRC32C=y
+CONFIG_PRINTK_TIME=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index fef802b7af8c..290d93a06f67 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -5,12 +5,6 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_MULTI_V4T=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_EP93XX=y
@@ -36,6 +30,11 @@ CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyAM0,115200 root=/dev/nfs ip=bootp"
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -52,8 +51,8 @@ CONFIG_IPV6=y
 # CONFIG_IPV6_SIT is not set
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
-CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
@@ -68,6 +67,7 @@ CONFIG_EEPROM_LEGACY=y
 CONFIG_SCSI=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NETDEVICES=y
 CONFIG_EP93XX_ETH=y
 CONFIG_USB_RTL8150=y
@@ -124,6 +124,7 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_LIBCRC32C=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_SPINLOCK=y
@@ -131,4 +132,3 @@ CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_LIBCRC32C=y
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index 2146adc1825e..5c58aa407897 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -3,27 +3,24 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_PXA_ESERIES=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_IWMMXT=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA=m
-CONFIG_PCMCIA_PXA2XX=m
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_KEXEC=y
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
+CONFIG_SLAB=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -39,6 +36,9 @@ CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_MAC80211_RC_PID=y
 # CONFIG_MAC80211_RC_MINSTREL is not set
+CONFIG_PCCARD=y
+CONFIG_PCMCIA=m
+CONFIG_PCMCIA_PXA2XX=m
 # CONFIG_STANDALONE is not set
 CONFIG_MTD=m
 CONFIG_MTD_RAW_NAND=m
@@ -46,6 +46,7 @@ CONFIG_MTD_NAND_TMIO=m
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=m
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=m
 # CONFIG_SATA_PMP is not set
@@ -62,8 +63,8 @@ CONFIG_KEYBOARD_GPIO=m
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_WM97XX=m
 # CONFIG_SERIO is not set
-CONFIG_SERIAL_PXA=y
 # CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_PXA=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_MFD_T7L66XB=y
@@ -76,8 +77,6 @@ CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_MINI_4x6=y
 CONFIG_SOUND=y
 CONFIG_SND=m
 CONFIG_SND_MIXER_OSS=m
@@ -97,10 +96,11 @@ CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_FONTS=y
+CONFIG_FONT_MINI_4x6=y
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index aa061074db78..94d4eb2cb8a4 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -18,7 +18,6 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
-CONFIG_ENERGY_MODEL=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
@@ -34,6 +33,7 @@ CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_ADVANCED_DEBUG=y
+CONFIG_ENERGY_MODEL=y
 CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA256_ARM=m
@@ -170,8 +170,6 @@ CONFIG_THERMAL_EMULATION=y
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MFD_CROS_EC_DEV=y
-CONFIG_CHROME_PLATFORMS=y
-CONFIG_CROS_EC=y
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
 CONFIG_MFD_MAX77693=y
@@ -207,19 +205,19 @@ CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_VIDEO_SAMSUNG_EXYNOS4_IS=m
 CONFIG_VIDEO_S5P_FIMC=m
 CONFIG_VIDEO_S5P_MIPI_CSIS=m
 CONFIG_VIDEO_EXYNOS_FIMC_LITE=m
 CONFIG_VIDEO_EXYNOS4_FIMC_IS=m
-CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
-CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_V4L_TEST_DRIVERS=y
 CONFIG_VIDEO_VIVID=m
-CONFIG_VIDEO_S5K6A3=m
 CONFIG_VIDEO_S5C73M3=m
+CONFIG_VIDEO_S5K6A3=m
 CONFIG_DRM=y
 CONFIG_DRM_EXYNOS=y
 CONFIG_DRM_EXYNOS_FIMD=y
@@ -295,11 +293,11 @@ CONFIG_MMC_DW_EXYNOS=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_CLASS_FLASH=y
-CONFIG_LEDS_AAT1290=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
-CONFIG_LEDS_MAX77693=y
 CONFIG_LEDS_MAX8997=y
+CONFIG_LEDS_AAT1290=y
+CONFIG_LEDS_MAX77693=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX8998=y
@@ -309,6 +307,8 @@ CONFIG_RTC_DRV_S5M=y
 CONFIG_RTC_DRV_S3C=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC=y
 CONFIG_CROS_EC_I2C=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_COMMON_CLK_MAX77686=y
@@ -319,12 +319,12 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
-CONFIG_EXYNOS5422_DMC=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_MAX14577=y
 CONFIG_EXTCON_MAX77693=y
 CONFIG_EXTCON_MAX8997=y
+CONFIG_EXYNOS5422_DMC=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
 CONFIG_STMPE_ADC=y
@@ -377,9 +377,9 @@ CONFIG_FONT_7x14=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 # CONFIG_DETECT_HUNG_TASK is not set
 CONFIG_PROVE_LOCKING=y
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index 5d000c8be44e..d3240089bbfb 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -1,25 +1,19 @@
 CONFIG_LOCALVERSION="-ezx200910312315"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_BZIP2=y
 CONFIG_RD_LZMA=y
 CONFIG_EXPERT=y
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_PXA_EZX=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -33,9 +27,15 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPU_IDLE=y
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=m
-CONFIG_BINFMT_MISC=m
 CONFIG_PM=y
 CONFIG_APM_EMULATION=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_BINFMT_MISC=m
+CONFIG_SLAB=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -72,6 +72,7 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
+CONFIG_NF_NAT=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_LED=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
@@ -113,7 +114,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_NF_NAT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
@@ -179,15 +179,15 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-# CONFIG_WLAN is not set
 CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
+CONFIG_PPP_MULTILINK=y
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
 # CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
@@ -199,9 +199,9 @@ CONFIG_INPUT_MISC=y
 CONFIG_INPUT_UINPUT=y
 CONFIG_INPUT_PCAP=y
 # CONFIG_SERIO is not set
+CONFIG_LEGACY_PTY_COUNT=8
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-CONFIG_LEGACY_PTY_COUNT=8
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -218,27 +218,27 @@ CONFIG_REGULATOR_PCAP=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
 CONFIG_MEDIA_TUNER_CUSTOMISE=y
+CONFIG_RADIO_TEA5764=y
+# CONFIG_MEDIA_TUNER_MC44S803 is not set
+# CONFIG_MEDIA_TUNER_MT2060 is not set
+# CONFIG_MEDIA_TUNER_MT20XX is not set
+# CONFIG_MEDIA_TUNER_MT2131 is not set
+# CONFIG_MEDIA_TUNER_MT2266 is not set
+# CONFIG_MEDIA_TUNER_MXL5005S is not set
+# CONFIG_MEDIA_TUNER_MXL5007T is not set
+# CONFIG_MEDIA_TUNER_QT1010 is not set
 # CONFIG_MEDIA_TUNER_SIMPLE is not set
-# CONFIG_MEDIA_TUNER_TDA8290 is not set
-# CONFIG_MEDIA_TUNER_TDA827X is not set
 # CONFIG_MEDIA_TUNER_TDA18271 is not set
+# CONFIG_MEDIA_TUNER_TDA827X is not set
+# CONFIG_MEDIA_TUNER_TDA8290 is not set
 # CONFIG_MEDIA_TUNER_TDA9887 is not set
 # CONFIG_MEDIA_TUNER_TEA5761 is not set
 # CONFIG_MEDIA_TUNER_TEA5767 is not set
-# CONFIG_MEDIA_TUNER_MT20XX is not set
-# CONFIG_MEDIA_TUNER_MT2060 is not set
-# CONFIG_MEDIA_TUNER_MT2266 is not set
-# CONFIG_MEDIA_TUNER_MT2131 is not set
-# CONFIG_MEDIA_TUNER_QT1010 is not set
 # CONFIG_MEDIA_TUNER_XC2028 is not set
 # CONFIG_MEDIA_TUNER_XC5000 is not set
-# CONFIG_MEDIA_TUNER_MXL5005S is not set
-# CONFIG_MEDIA_TUNER_MXL5007T is not set
-# CONFIG_MEDIA_TUNER_MC44S803 is not set
 # CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set
 CONFIG_VIDEO_PXA27x=y
 # CONFIG_V4L_USB_DRIVERS is not set
-CONFIG_RADIO_TEA5764=y
 CONFIG_FB=y
 CONFIG_FB_PXA=y
 CONFIG_FB_PXA_OVERLAY=y
@@ -248,8 +248,6 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_MINI_4x6=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_MIXER_OSS=y
@@ -260,8 +258,8 @@ CONFIG_SND_PCM_OSS=y
 # CONFIG_SND_USB is not set
 CONFIG_SND_SOC=y
 CONFIG_SND_PXA2XX_SOC=y
-# CONFIG_USB_HID is not set
 CONFIG_HID_APPLE=m
+# CONFIG_USB_HID is not set
 CONFIG_USB=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_GADGET=y
@@ -354,14 +352,8 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_PROVE_LOCKING=y
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
@@ -389,3 +381,11 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_FONTS=y
+CONFIG_FONT_MINI_4x6=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_PROVE_LOCKING=y
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 7a32de51f0fa..10905e53067c 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -4,7 +4,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_HOTPLUG is not set
-CONFIG_MODULES=y
 CONFIG_ARCH_FOOTBRIDGE=y
 CONFIG_ARCH_CATS=y
 CONFIG_ARCH_EBSA285_HOST=y
@@ -16,6 +15,10 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
 CONFIG_BINFMT_AOUT=y
+CONFIG_MODULES=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ACORN_PARTITION=y
+CONFIG_ACORN_PARTITION_ADFS=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -71,17 +74,17 @@ CONFIG_VORTEX=y
 CONFIG_NET_PCI=y
 CONFIG_NE2K_PCI=y
 CONFIG_PPP=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
+CONFIG_PPP_ASYNC=m
 CONFIG_SLIP=m
 CONFIG_SLIP_COMPRESSED=y
 CONFIG_SLIP_SMART=y
 CONFIG_SLIP_MODE_SLIP6=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_21285=y
 CONFIG_SERIAL_21285_CONSOLE=y
+CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_PRINTER=m
 CONFIG_DS1620=y
 CONFIG_NWBUTTON=y
@@ -109,9 +112,6 @@ CONFIG_ADFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_ACORN_PARTITION=y
-CONFIG_ACORN_PARTITION_ADFS=y
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index c02b3e409610..6066aea1d9c2 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -1,19 +1,16 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_H3600=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_SA1100=y
-CONFIG_PREEMPT=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 # CONFIG_CPU_FREQ_STAT is not set
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -23,6 +20,8 @@ CONFIG_IRLAN=m
 CONFIG_IRNET=m
 CONFIG_IRCOMM=m
 # CONFIG_WIRELESS is not set
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_SA1100=y
 CONFIG_MTD=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -36,6 +35,7 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
diff --git a/arch/arm/configs/h5000_defconfig b/arch/arm/configs/h5000_defconfig
index a67d6020aee5..3b170cfbf537 100644
--- a/arch/arm/configs/h5000_defconfig
+++ b/arch/arm/configs/h5000_defconfig
@@ -5,10 +5,6 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
@@ -21,6 +17,10 @@ CONFIG_KEXEC=y
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_APM_EMULATION=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -43,9 +43,9 @@ CONFIG_MTD_PHYSMAP=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+CONFIG_LEGACY_PTY_COUNT=32
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-CONFIG_LEGACY_PTY_COUNT=32
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
@@ -60,11 +60,7 @@ CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
-CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_FTRACE is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
@@ -73,3 +69,7 @@ CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_DEFLATE=y
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_CCITT=y
+CONFIG_PRINTK_TIME=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/arm/configs/hackkit_defconfig b/arch/arm/configs/hackkit_defconfig
index 742d18cdabde..826497b28b6e 100644
--- a/arch/arm/configs/hackkit_defconfig
+++ b/arch/arm/configs/hackkit_defconfig
@@ -1,7 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_HACKKIT=y
 CONFIG_LEDS=y
@@ -12,6 +11,7 @@ CONFIG_CMDLINE="console=ttySA0,115200 root=/dev/ram0 initrd=0xc0400000,8M init=/
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
+CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -38,8 +38,8 @@ CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index 74d611e41e02..1db5356b1ccd 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -1,24 +1,25 @@
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_LZMA=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_CMDLINE_PARTITION=y
-CONFIG_ARCH_HIX5HD2=y
 CONFIG_ARCH_HIP01=y
 CONFIG_ARCH_HIP04=y
+CONFIG_ARCH_HIX5HD2=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_PM=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMDLINE_PARTITION=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -39,20 +40,20 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_PINCTRL_SINGLE=y
-CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIOLIB=y
-CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_MFD_SYSCON=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_DRM=y
 CONFIG_FB_SIMPLE=y
@@ -66,13 +67,13 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_MMC=y
-CONFIG_RTC_CLASS=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_PLTFM=y
+CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_DMADEVICES=y
-CONFIG_DW_DMAC=y
 CONFIG_PL330_DMA=y
+CONFIG_DW_DMAC=y
 CONFIG_PWM=y
 CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_EXT4_FS=y
@@ -81,11 +82,10 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOCKUP_DETECTOR=y
-CONFIG_VFP=y
 CONFIG_VFPv3=y
+CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 1d9fa77bbafc..c32bdbc07d0c 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
@@ -8,8 +7,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
@@ -30,7 +27,9 @@ CONFIG_PM_DEBUG=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_SWAP is not set
+CONFIG_SLAB=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -63,6 +62,7 @@ CONFIG_MTD_UBI=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_PATA_IMX=y
 CONFIG_NETDEVICES=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 88a3602c4e58..01012537a9b9 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -13,8 +13,6 @@ CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
-# CONFIG_SLUB_DEBUG is not set
-# CONFIG_COMPAT_BRK is not set
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_MXC=y
 CONFIG_SOC_IMX31=y
@@ -58,6 +56,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_BINFMT_MISC=m
+# CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -258,14 +257,14 @@ CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
-CONFIG_VIDEO_MUX=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_MUX=y
 CONFIG_VIDEO_CODA=m
 CONFIG_VIDEO_IMX_PXP=y
-CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_OV2680=m
 CONFIG_VIDEO_OV5640=m
 CONFIG_VIDEO_OV5645=m
+CONFIG_VIDEO_ADV7180=m
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_MSM=y
@@ -468,6 +467,7 @@ CONFIG_PRINTK_TIME=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
+# CONFIG_SLUB_DEBUG is not set
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_PROVE_LOCKING=y
 # CONFIG_FTRACE is not set
diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 5b485722ccf9..9ca43c84b452 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -81,5 +81,5 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index ead14c3f23d8..6d91b3cbd881 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -3,10 +3,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_IOP32X=y
 CONFIG_MACH_GLANTANK=y
@@ -19,6 +15,10 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs ip=bootp cachepolicy=writealloc"
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -45,6 +45,7 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_SATA_SIL=y
 CONFIG_SATA_VITESSE=y
@@ -95,12 +96,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_KEYS=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_LRW=y
@@ -127,3 +122,8 @@ CONFIG_CRYPTO_TEA=y
 CONFIG_CRYPTO_TWOFISH=y
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_LIBCRC32C=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_USER=y
+CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_LL_UART_8250=y
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index 069f60ffdcd8..0521f427efce 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -1,18 +1,15 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
-CONFIG_MODULES=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_JORNADA720=y
 CONFIG_SA1100_JORNADA720_SSP=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_SA1100=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
 CONFIG_PM=y
+CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -24,9 +21,12 @@ CONFIG_IRDA=m
 CONFIG_IRLAN=m
 CONFIG_IRCOMM=m
 CONFIG_SA1100_FIR=m
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_SA1100=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
@@ -40,9 +40,9 @@ CONFIG_KEYBOARD_HP7XX=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_HP7XX=y
+CONFIG_LEGACY_PTY_COUNT=32
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
-CONFIG_LEGACY_PTY_COUNT=32
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_S1D13XXX=y
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index b1bcb858216b..f40b969b486e 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -1,43 +1,41 @@
-# CONFIG_SWAP is not set
 CONFIG_POSIX_MQUEUE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_SCHED=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_CGROUP_SCHED=y
-CONFIG_BLK_CGROUP=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_KALLSYMS_ALL=y
 # CONFIG_ELF_CORE is not set
 # CONFIG_BASE_FULL is not set
+CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_FORCE_LOAD=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARM_LPAE=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
 CONFIG_PCI_KEYSTONE=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_ARM_PSCI=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_CMA=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_SUSPEND is not set
 CONFIG_PM=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_SWAP is not set
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -113,9 +111,11 @@ CONFIG_VLAN_8021Q=y
 CONFIG_CAN=m
 CONFIG_CAN_C_CAN=m
 CONFIG_CAN_C_CAN_PLATFORM=m
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_DMA_CMA=y
+CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -131,10 +131,15 @@ CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
+CONFIG_TI_CPTS=y
 CONFIG_TI_KEYSTONE_NETCP=y
 CONFIG_TI_KEYSTONE_NETCP_ETHSS=y
-CONFIG_TI_CPTS=y
 CONFIG_MARVELL_PHY=y
+CONFIG_MICREL_PHY=y
+CONFIG_DP83867_PHY=y
+CONFIG_INPUT_EVDEV=m
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_GPIO_DECODER=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
@@ -144,6 +149,7 @@ CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DAVINCI=y
 CONFIG_SPI=y
+CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
 CONFIG_PTP_1588_CLOCK=y
@@ -152,9 +158,10 @@ CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_DAVINCI=y
 CONFIG_GPIO_SYSCON=y
-CONFIG_POWER_SUPPLY=y
+CONFIG_GPIO_PCA953X=m
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_KEYSTONE=y
+CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_DAVINCI_WATCHDOG=y
@@ -166,8 +173,8 @@ CONFIG_USB_MON=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC3=y
-CONFIG_NOP_USB_XCEIV=y
 CONFIG_KEYSTONE_USB_PHY=y
+CONFIG_NOP_USB_XCEIV=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
@@ -180,6 +187,8 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_ONESHOT=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_LEDS_TRIGGER_ACTIVITY=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
@@ -196,7 +205,6 @@ CONFIG_PWM_TIECAP=m
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_RESET_TI_SCI=m
 CONFIG_RESET_TI_SYSCON=m
-CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_FANOTIFY=y
@@ -216,10 +224,7 @@ CONFIG_NFSD=y
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_SHIRQ=y
-CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_USER=y
 CONFIG_CRYPTO_AUTHENC=y
 CONFIG_CRYPTO_CBC=y
@@ -229,12 +234,7 @@ CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_USER_API_SKCIPHER=y
-CONFIG_SPI_CADENCE_QUADSPI=y
-CONFIG_INPUT_MISC=y
-CONFIG_INPUT_EVDEV=m
-CONFIG_INPUT_GPIO_DECODER=m
-CONFIG_GPIO_PCA953X=m
-CONFIG_LEDS_TRIGGER_ACTIVITY=y
-CONFIG_LEDS_TRIGGER_CPU=y
-CONFIG_MICREL_PHY=y
-CONFIG_DP83867_PHY=y
+CONFIG_DMA_CMA=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_SHIRQ=y
+CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index 2dfa33d7dca3..f4966d033a65 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -1,7 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_LART=y
 CONFIG_LEDS=y
@@ -14,6 +13,7 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
 CONFIG_PM=y
+CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
@@ -37,9 +37,9 @@ CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
 CONFIG_NET_ETHERNET=y
 CONFIG_PPP=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_ASYNC=m
 CONFIG_SLIP=m
 CONFIG_SLIP_COMPRESSED=y
 CONFIG_SERIAL_SA1100=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 688c9849eec8..bb7f54c51871 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -15,8 +15,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_EVENTFD is not set
 # CONFIG_AIO is not set
 CONFIG_EMBEDDED=y
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_SLUB_DEBUG is not set
 # CONFIG_MMU is not set
 CONFIG_ARCH_LPC18XX=y
 CONFIG_SET_MEM_PARAM=y
@@ -27,10 +25,10 @@ CONFIG_FLASH_SIZE=0x00080000
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
 # CONFIG_COREDUMP is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -60,6 +58,7 @@ CONFIG_SRAM=y
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
@@ -92,11 +91,11 @@ CONFIG_KEYBOARD_GPIO_POLLED=y
 # CONFIG_VT is not set
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C_LPC2K=y
 CONFIG_SPI=y
@@ -155,9 +154,10 @@ CONFIG_CRC7=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_FS=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SLUB_DEBUG is not set
 # CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 6c3e4a141963..afa0aceedc2b 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -10,7 +10,6 @@ CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EMBEDDED=y
-CONFIG_SLAB=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_LPC32XX=y
 CONFIG_AEABI=y
@@ -24,9 +23,9 @@ CONFIG_VFP=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -60,6 +59,7 @@ CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
@@ -93,11 +93,11 @@ CONFIG_SERIAL_HS_LPC32XX_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_PNX=y
-CONFIG_GPIO_LPC32XX=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
+CONFIG_GPIO_LPC32XX=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCF857X=y
 CONFIG_SENSORS_DS620=y
@@ -189,8 +189,8 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_GDB_SCRIPTS=y
-CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PANIC_TIMEOUT=5
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
index 5c0a671ed294..ce142e52a195 100644
--- a/arch/arm/configs/lpd270_defconfig
+++ b/arch/arm/configs/lpd270_defconfig
@@ -1,7 +1,5 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SLAB=y
-CONFIG_MODULES=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_LOGICPD_PXA270=y
@@ -10,6 +8,8 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -53,8 +53,8 @@ CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_INFO=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
index cf49dc1629a7..8875befb7927 100644
--- a/arch/arm/configs/lubbock_defconfig
+++ b/arch/arm/configs/lubbock_defconfig
@@ -1,24 +1,24 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_MODULES=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_LUBBOCK=y
 # CONFIG_ARM_THUMB is not set
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_PXA2XX=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_PXA2XX=y
 CONFIG_MTD=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -29,9 +29,9 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
-CONFIG_SMC91X=y
 CONFIG_NET_PCMCIA=y
 CONFIG_PCMCIA_PCNET=y
+CONFIG_SMC91X=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_SA1111=y
@@ -46,8 +46,8 @@ CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_INFO=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index 13da808ffa13..aaddc07c16d9 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -1,20 +1,17 @@
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_H4700=y
 CONFIG_MACH_MAGICIAN=y
-CONFIG_NO_HZ=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -24,6 +21,9 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -60,11 +60,11 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_NETDEVICES=y
 CONFIG_PPP=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_MPPE=m
 # CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_PPP_ASYNC=m
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
@@ -73,19 +73,19 @@ CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_UINPUT=m
 # CONFIG_SERIO is not set
-CONFIG_SERIAL_PXA=y
 # CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_PXA=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_PXA=y
 CONFIG_W1_MASTER_DS1WM=y
+CONFIG_HTC_EGPIO=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_PDA_POWER=y
 CONFIG_BATTERY_DS2760=y
 # CONFIG_HWMON is not set
 CONFIG_MFD_ASIC3=y
-CONFIG_HTC_EGPIO=y
 CONFIG_HTC_PASIC3=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_GPIO=y
@@ -99,8 +99,6 @@ CONFIG_BACKLIGHT_PWM=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
-CONFIG_FONTS=y
-CONFIG_FONT_MINI_4x6=y
 CONFIG_SOUND=y
 CONFIG_SND=m
 CONFIG_SND_MIXER_OSS=m
@@ -112,6 +110,7 @@ CONFIG_SND_PXA2XX_SOC=m
 CONFIG_USB=y
 CONFIG_USB_MON=m
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VBUS_DRAW=500
 CONFIG_USB_PXA27X=y
@@ -121,7 +120,6 @@ CONFIG_USB_GADGETFS=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
-CONFIG_USB_GPIO_VBUS=y
 CONFIG_MMC=y
 CONFIG_SDIO_UART=m
 CONFIG_MMC_PXA=y
@@ -148,6 +146,11 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_1251=m
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_CCITT=y
+CONFIG_FONTS=y
+CONFIG_FONT_MINI_4x6=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
@@ -155,7 +158,4 @@ CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
-CONFIG_CRYPTO=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_CCITT=y
diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
index 03b4c61bdadd..52de8b15c349 100644
--- a/arch/arm/configs/mainstone_defconfig
+++ b/arch/arm/configs/mainstone_defconfig
@@ -1,6 +1,5 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_MODULES=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_MAINSTONE=y
@@ -11,6 +10,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -44,8 +44,8 @@ CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_INFO=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index 7c07f9893a0f..37739b61b0c3 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -45,7 +45,6 @@ CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_EFI_VARS=m
-CONFIG_EFI_CAPSULE_LOADER=m
 CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
@@ -64,8 +63,7 @@ CONFIG_CMDLINE_PARTITION=y
 CONFIG_CMA=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_DMA_CMA=y
-CONFIG_CMA_SIZE_MBYTES=64
+CONFIG_EFI_CAPSULE_LOADER=m
 CONFIG_OF_OVERLAY=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -115,5 +113,7 @@ CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_CCITT=m
 CONFIG_CRC_ITU_T=m
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 3ef48e79b410..4da0055409e5 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -3,7 +3,6 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_COMPAT_BRK is not set
 CONFIG_ARCH_MULTI_V4T=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_S3C24XX=y
@@ -19,7 +18,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_BLK_DEV_INTEGRITY=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
@@ -28,6 +26,7 @@ CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_LDM_PARTITION=y
 CONFIG_BINFMT_MISC=m
+# CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -104,6 +103,7 @@ CONFIG_SCSI=m
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=m
 CONFIG_CHR_DEV_SG=m
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_TUN=m
@@ -330,8 +330,8 @@ CONFIG_FONT_8x8=y
 CONFIG_FONT_MINI_4x6=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index a5e8d2235a1a..bfa28daf458d 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -1,22 +1,22 @@
 CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MMP=y
 CONFIG_MACH_BROWNSTONE=y
 CONFIG_MACH_FLINT=y
 CONFIG_MACH_MARVELL_JASPER=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on console=ttyS2,38400 mem=128M user_debug=255 earlyprintk"
 CONFIG_VFP=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -28,9 +28,9 @@ CONFIG_IP_PNP=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_GENERIC=y
+CONFIG_MTD_RAW_NAND=y
 # CONFIG_BLK_DEV is not set
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
@@ -39,9 +39,9 @@ CONFIG_SMC91X=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_PXA=y
@@ -55,17 +55,17 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_MAX8925=y
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX8925=y
-CONFIG_MMC=y
-# CONFIG_DNOTIFY is not set
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
+# CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=y
 CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
@@ -73,10 +73,11 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
+CONFIG_CRC_CCITT=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_DYNAMIC_DEBUG is not set
@@ -85,4 +86,3 @@ CONFIG_DEBUG_LL=y
 CONFIG_DEBUG_MMP_UART3=y
 CONFIG_EARLY_PRINTK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_CCITT=y
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index eacc089d86c5..a4c2bb37fe5a 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -1,7 +1,7 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_ELF_CORE is not set
@@ -11,18 +11,17 @@ CONFIG_IKCONFIG_PROC=y
 # CONFIG_EVENTFD is not set
 # CONFIG_AIO is not set
 CONFIG_EMBEDDED=y
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_SLUB_DEBUG is not set
-# CONFIG_COMPAT_BRK is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MOXART=y
 CONFIG_MACH_UC7112LX=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_ATAGS is not set
 CONFIG_ARM_APPENDED_DTB=y
+# CONFIG_SWAP is not set
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -118,10 +117,15 @@ CONFIG_EXT3_FS=y
 CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_JFFS2_FS=y
+CONFIG_KEYS=y
+CONFIG_CRC32_BIT=y
+CONFIG_DMA_API_DEBUG=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_KGDB=y
 CONFIG_DEBUG_PAGEALLOC=y
+# CONFIG_SLUB_DEBUG is not set
 CONFIG_DEBUG_OBJECTS=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_STACK_USAGE=y
@@ -131,12 +135,8 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_PROVE_LOCKING=y
-CONFIG_DMA_API_DEBUG=y
-CONFIG_KGDB=y
 CONFIG_DEBUG_LL=y
 CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_DEBUG_UART_PHYS=0x98200000
 CONFIG_DEBUG_UART_VIRT=0xf9820000
 CONFIG_EARLY_PRINTK=y
-CONFIG_KEYS=y
-CONFIG_CRC32_BIT=y
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index c1e98e33a348..81d3edb35d3e 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -1,5 +1,6 @@
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
@@ -10,21 +11,19 @@ CONFIG_EXPERT=y
 # CONFIG_SIGNALFD is not set
 # CONFIG_EVENTFD is not set
 # CONFIG_AIO is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_SLUB_DEBUG is not set
-# CONFIG_BLOCK is not set
 # CONFIG_MMU is not set
 CONFIG_ARCH_MPS2=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x21000000
 CONFIG_DRAM_SIZE=0x1000000
-CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_ATAGS is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+# CONFIG_SUSPEND is not set
+# CONFIG_BLOCK is not set
 CONFIG_BINFMT_FLAT=y
 # CONFIG_COREDUMP is not set
-# CONFIG_SUSPEND is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -67,9 +66,9 @@ CONFIG_SMSC911X=y
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_MPS2_UART_CONSOLE=y
 CONFIG_SERIAL_MPS2_UART=y
+CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
@@ -99,7 +98,8 @@ CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_FS=y
+# CONFIG_SLUB_DEBUG is not set
 # CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MEMTEST=y
diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
index e530107be412..9f5b3f5dc8b6 100644
--- a/arch/arm/configs/multi_v4t_defconfig
+++ b/arch/arm/configs/multi_v4t_defconfig
@@ -3,7 +3,6 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
-CONFIG_SLOB=y
 CONFIG_ARCH_MULTI_V4T=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_AT91=y
@@ -11,13 +10,13 @@ CONFIG_SOC_AT91RM9200=y
 CONFIG_ARCH_CLPS711X=y
 CONFIG_ARCH_MXC=y
 CONFIG_SOC_IMX1=y
+CONFIG_ARCH_NSPIRE=y
 CONFIG_ARCH_INTEGRATOR=y
 CONFIG_ARCH_INTEGRATOR_AP=y
 CONFIG_INTEGRATOR_IMPD1=y
 CONFIG_INTEGRATOR_CM720T=y
 CONFIG_INTEGRATOR_CM920T=y
 CONFIG_INTEGRATOR_CM922T_XA10=y
-CONFIG_ARCH_NSPIRE=y
 CONFIG_AEABI=y
 # CONFIG_ATAGS is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -28,6 +27,7 @@ CONFIG_ARM_CLPS711X_CPUIDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_COREDUMP is not set
+CONFIG_SLOB=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index f8d301150732..eecec57260cd 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -53,6 +53,7 @@ CONFIG_MACH_RD88F5181L_GE=y
 CONFIG_MACH_RD88F5181L_FXO=y
 CONFIG_MACH_RD88F6183AP_GE=y
 CONFIG_ARCH_SUNXI=y
+CONFIG_ARCH_VERSATILE=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
@@ -78,7 +79,6 @@ CONFIG_NET_PKTGEN=m
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_PCI_MVEBU=y
-CONFIG_ARCH_VERSATILE=y
 CONFIG_PCI_VERSATILE=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -98,17 +98,14 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_ASPEED_SMC=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_VIRTIO_BLK=y
 CONFIG_ATMEL_SSC=m
 CONFIG_EEPROM_AT24=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=m
-CONFIG_VIRTIO_PCI=y
-CONFIG_VIRTIO_MMIO=y
-CONFIG_VIRTIO_BLK=y
 CONFIG_CHR_DEV_SG=m
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
@@ -161,6 +158,7 @@ CONFIG_I2C_AT91=y
 CONFIG_I2C_IMX=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_SPI=y
+CONFIG_SPI_ASPEED_SMC=y
 CONFIG_SPI_ATMEL=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_ORION=y
@@ -273,6 +271,8 @@ CONFIG_RTC_DRV_ASPEED=m
 CONFIG_DMADEVICES=y
 CONFIG_AT_HDMAC=y
 CONFIG_MV_XOR=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_MMIO=y
 CONFIG_STAGING=y
 CONFIG_ASPEED_LPC_CTRL=m
 CONFIG_ASPEED_LPC_SNOOP=m
@@ -308,9 +308,9 @@ CONFIG_CRYPTO_DEV_MARVELL_CESA=y
 CONFIG_CRC_CCITT=y
 CONFIG_LIBCRC32C=y
 CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6780da0c9781..cff991cfe864 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -6,6 +6,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_ARCH_VIRT=y
+CONFIG_ARCH_AIROHA=y
 CONFIG_ARCH_ACTIONS=y
 CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_ARTPEC=y
@@ -38,7 +39,6 @@ CONFIG_MACH_BERLIN_BG2=y
 CONFIG_MACH_BERLIN_BG2CD=y
 CONFIG_MACH_BERLIN_BG2Q=y
 CONFIG_ARCH_DIGICOLOR=y
-CONFIG_ARCH_AIROHA=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HISI=y
@@ -131,12 +131,6 @@ CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_ARM_QCOM_SPM_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_ARM_SCMI_PROTOCOL=y
-CONFIG_RASPBERRYPI_FIRMWARE=y
-CONFIG_TRUSTED_FOUNDATIONS=y
-CONFIG_BCM47XX_NVRAM=y
-CONFIG_BCM47XX_SPROM=y
-CONFIG_EFI_CAPSULE_LOADER=m
 CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
@@ -209,6 +203,12 @@ CONFIG_PCI_EPF_TEST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_OMAP_OCP2SCP=y
+CONFIG_ARM_SCMI_PROTOCOL=y
+CONFIG_RASPBERRYPI_FIRMWARE=y
+CONFIG_TRUSTED_FOUNDATIONS=y
+CONFIG_BCM47XX_NVRAM=y
+CONFIG_BCM47XX_SPROM=y
+CONFIG_EFI_CAPSULE_LOADER=m
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -229,7 +229,6 @@ CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_NAND_STM32_FMC2=y
 CONFIG_MTD_NAND_PL35X=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_ASPEED_SMC=m
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -261,13 +260,13 @@ CONFIG_SATA_MV=y
 CONFIG_SATA_RCAR=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_VENDOR_ASIX=y
-CONFIG_SPI_AX88796C=m
 CONFIG_VIRTIO_NET=y
 CONFIG_B53_SPI_DRIVER=m
 CONFIG_B53_MDIO_DRIVER=m
 CONFIG_B53_MMAP_DRIVER=m
 CONFIG_NET_DSA_BCM_SF2=m
 CONFIG_SUN4I_EMAC=y
+CONFIG_SPI_AX88796C=m
 CONFIG_BCMGENET=m
 CONFIG_BGMAC_BCMA=y
 CONFIG_SYSTEMPORT=m
@@ -300,7 +299,6 @@ CONFIG_MARVELL_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
-CONFIG_USB_BRCMSTB=m
 CONFIG_MDIO_MSCC_MIIM=m
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_RTL8152=m
@@ -437,6 +435,7 @@ CONFIG_I2C_RCAR=y
 CONFIG_I2C_CROS_EC_TUNNEL=m
 CONFIG_I2C_SLAVE_EEPROM=y
 CONFIG_SPI=y
+CONFIG_SPI_ASPEED_SMC=m
 CONFIG_SPI_ATMEL=m
 CONFIG_SPI_ATMEL_QUADSPI=m
 CONFIG_SPI_BCM2835=y
@@ -467,10 +466,10 @@ CONFIG_SPI_SPIDEV=y
 CONFIG_SPMI=y
 CONFIG_PTP_1588_CLOCK=y
 CONFIG_PINCTRL_AS3722=y
-CONFIG_PINCTRL_STMFX=y
 CONFIG_PINCTRL_MICROCHIP_SGPIO=y
 CONFIG_PINCTRL_OCELOT=y
 CONFIG_PINCTRL_PALMAS=y
+CONFIG_PINCTRL_STMFX=y
 CONFIG_PINCTRL_OWL=y
 CONFIG_PINCTRL_S500=y
 CONFIG_PINCTRL_MSM=y
@@ -513,7 +512,6 @@ CONFIG_BATTERY_ACT8945A=y
 CONFIG_BATTERY_CPCAP=m
 CONFIG_BATTERY_SBS=y
 CONFIG_BATTERY_BQ27XXX=m
-CONFIG_BATTERY_ACER_A500=m
 CONFIG_AXP20X_POWER=m
 CONFIG_BATTERY_MAX17040=m
 CONFIG_BATTERY_MAX17042=m
@@ -525,6 +523,7 @@ CONFIG_CHARGER_MAX8997=m
 CONFIG_CHARGER_MAX8998=m
 CONFIG_CHARGER_SMB347=m
 CONFIG_CHARGER_TPS65090=y
+CONFIG_BATTERY_ACER_A500=m
 CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_SENSORS_ASPEED=m
 CONFIG_SENSORS_IIO_HWMON=y
@@ -579,7 +578,6 @@ CONFIG_GXP_WATCHDOG=y
 CONFIG_BCMA_HOST_SOC=y
 CONFIG_BCMA_DRIVER_GMAC_CMN=y
 CONFIG_BCMA_DRIVER_GPIO=y
-CONFIG_MFD_ACER_A500_EC=m
 CONFIG_MFD_ACT8945A=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_AS3722=y
@@ -612,6 +610,7 @@ CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
 CONFIG_MFD_STM32_LPTIMER=m
 CONFIG_MFD_STPMIC1=y
+CONFIG_MFD_ACER_A500_EC=m
 CONFIG_REGULATOR_ACT8865=y
 CONFIG_REGULATOR_ACT8945A=y
 CONFIG_REGULATOR_ANATOP=y
@@ -666,31 +665,31 @@ CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
-CONFIG_VIDEO_MMP_CAMERA=m
+CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_ASPEED=m
-CONFIG_VIDEO_STM32_DCMI=m
+CONFIG_VIDEO_ATMEL_ISC=m
+CONFIG_VIDEO_ATMEL_XISC=m
+CONFIG_VIDEO_ATMEL_ISI=m
+CONFIG_VIDEO_MICROCHIP_CSI2DC=m
+CONFIG_VIDEO_MMP_CAMERA=m
+CONFIG_VIDEO_TEGRA_VDE=m
 CONFIG_VIDEO_RENESAS_CEU=m
+CONFIG_VIDEO_RCAR_VIN=m
+CONFIG_VIDEO_RENESAS_FDP1=m
+CONFIG_VIDEO_RENESAS_JPU=m
+CONFIG_VIDEO_RENESAS_VSP1=m
+CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_VIDEO_SAMSUNG_EXYNOS4_IS=m
 CONFIG_VIDEO_S5P_FIMC=m
 CONFIG_VIDEO_S5P_MIPI_CSIS=m
 CONFIG_VIDEO_EXYNOS_FIMC_LITE=m
 CONFIG_VIDEO_EXYNOS4_FIMC_IS=m
-CONFIG_VIDEO_RCAR_VIN=m
-CONFIG_VIDEO_ATMEL_ISC=m
-CONFIG_VIDEO_ATMEL_XISC=m
-CONFIG_VIDEO_ATMEL_ISI=m
-CONFIG_VIDEO_MICROCHIP_CSI2DC=m
-CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
-CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_VIDEO_STI_BDISP=m
-CONFIG_VIDEO_STI_HVA=m
 CONFIG_VIDEO_STI_DELTA=m
-CONFIG_VIDEO_RENESAS_FDP1=m
-CONFIG_VIDEO_RENESAS_JPU=m
-CONFIG_VIDEO_RENESAS_VSP1=m
-CONFIG_VIDEO_TEGRA_VDE=m
+CONFIG_VIDEO_STI_HVA=m
+CONFIG_VIDEO_STM32_DCMI=m
 CONFIG_V4L_TEST_DRIVERS=y
 CONFIG_VIDEO_VIVID=m
 CONFIG_VIDEO_ADV7180=m
@@ -727,13 +726,13 @@ CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
-CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
 CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
 CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
-CONFIG_DRM_LVDS_CODEC=m
+CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
 CONFIG_DRM_DISPLAY_CONNECTOR=m
+CONFIG_DRM_LVDS_CODEC=m
 CONFIG_DRM_NXP_PTN3460=m
 CONFIG_DRM_PARADE_PS8622=m
 CONFIG_DRM_SII902X=m
@@ -835,6 +834,7 @@ CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MVEBU=y
 CONFIG_USB_XHCI_TEGRA=m
+CONFIG_USB_BRCMSTB=m
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_STI=y
 CONFIG_USB_EHCI_EXYNOS=m
@@ -939,10 +939,10 @@ CONFIG_LEDS_CLASS_FLASH=m
 CONFIG_LEDS_CPCAP=m
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
-CONFIG_LEDS_MAX77693=m
 CONFIG_LEDS_MAX8997=m
 CONFIG_LEDS_ACER_A500=m
 CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_MAX77693=m
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_ONESHOT=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
@@ -1165,10 +1165,10 @@ CONFIG_KEYSTONE_IRQ=y
 CONFIG_RESET_MCHP_SPARX5=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
+CONFIG_PHY_BRCM_USB=m
 CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_PHY_BERLIN_SATA=y
 CONFIG_PHY_BERLIN_USB=y
-CONFIG_PHY_BRCM_USB=m
 CONFIG_PHY_MMP3_USB=m
 CONFIG_PHY_LAN966X_SERDES=m
 CONFIG_PHY_CPCAP_USB=m
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index cd703c15798f..980be9fb5e21 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -1,14 +1,12 @@
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
-# CONFIG_SLUB_DEBUG is not set
 CONFIG_PROFILING=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V6 is not set
 # CONFIG_ARCH_MULTI_V7 is not set
@@ -16,15 +14,17 @@ CONFIG_ARCH_MV78XX0=y
 CONFIG_MACH_DB78X00_BP=y
 CONFIG_MACH_RD78X00_MASA=y
 CONFIG_MACH_TERASTATION_WXL=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BSD_DISKLABEL=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -52,25 +52,26 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
-CONFIG_MARVELL_PHY=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 CONFIG_NET_PCI=y
 CONFIG_MV643XX_ETH=y
 # CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_MARVELL_PHY=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
+CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -110,21 +111,20 @@ CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_BSD_DISKLABEL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
+CONFIG_CRYPTO_CBC=m
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_SLUB_DEBUG is not set
 CONFIG_SCHEDSTATS=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index d57ff30dabff..16bd80f0fcfa 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -2,12 +2,9 @@ CONFIG_SYSVIPC=y
 CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=19
 CONFIG_PROFILING=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_KIRKWOOD=y
@@ -34,8 +31,6 @@ CONFIG_MACH_WNR854T=y
 CONFIG_MACH_RD88F5181L_GE=y
 CONFIG_MACH_RD88F5181L_FXO=y
 CONFIG_MACH_RD88F6183AP_GE=y
-CONFIG_PCI_MVEBU=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -47,6 +42,9 @@ CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_KIRKWOOD_CPUIDLE=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -61,6 +59,7 @@ CONFIG_NET_SWITCHDEV=y
 CONFIG_NET_PKTGEN=m
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
+CONFIG_PCI_MVEBU=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
@@ -84,6 +83,7 @@ CONFIG_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_MV=y
@@ -93,9 +93,9 @@ CONFIG_NET_DSA_MV88E6XXX=y
 CONFIG_MV643XX_ETH=y
 CONFIG_R8169=y
 CONFIG_MARVELL_PHY=y
-CONFIG_MWL8K=m
 CONFIG_LIBERTAS=y
 CONFIG_LIBERTAS_SDIO=y
+CONFIG_MWL8K=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
@@ -195,15 +195,15 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
 CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_FS=y
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_CRYPTO_CBC=m
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_DEV_MARVELL_CESA=y
+CONFIG_CRC_CCITT=y
+CONFIG_LIBCRC32C=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
-CONFIG_CRYPTO_DEV_MARVELL_CESA=y
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRC_CCITT=y
-CONFIG_LIBCRC32C=y
diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 7b713c083a2a..ea86d88cc3d4 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -4,7 +4,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
-CONFIG_SLAB=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_375=y
@@ -24,6 +23,7 @@ CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index ca32446b187f..eb204eb98a42 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -15,7 +15,6 @@ CONFIG_CGROUPS=y
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PERF_EVENTS=y
-# CONFIG_COMPAT_BRK is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXS=y
 CONFIG_AEABI=y
@@ -25,6 +24,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_BLK_DEV_INTEGRITY=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -163,9 +163,9 @@ CONFIG_CRC7=m
 CONFIG_FONTS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_WARN=2048
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_BLK_DEV_IO_TRACE=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 018a1092d0e7..bc70ca29a166 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -1,14 +1,9 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
 CONFIG_ASSABET_NEPONSET=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_SA1100=y
-CONFIG_PCMCIA_SA1111=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
@@ -18,14 +13,21 @@ CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtd
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
 CONFIG_PM=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_MSDOS_PARTITION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_SA1100=y
+CONFIG_PCMCIA_SA1111=y
 CONFIG_MTD=y
-CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
@@ -39,20 +41,20 @@ CONFIG_BLK_DEV_SD=m
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_VENDOR_SMC=y
+CONFIG_PCMCIA_PCNET=y
 CONFIG_SMC9194=y
 CONFIG_SMC91X=y
 CONFIG_NET_PCMCIA=y
-CONFIG_PCMCIA_PCNET=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_SA1111=y
-CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_LEGACY_PTY_COUNT=64
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CS=y
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
-CONFIG_LEGACY_PTY_COUNT=64
+CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_WATCHDOG=y
@@ -73,12 +75,10 @@ CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_MSDOS_PARTITION is not set
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index c3c171cec91b..41b97e9a7506 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -10,6 +10,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=0x801"
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -51,9 +52,6 @@ CONFIG_977_WATCHDOG=y
 CONFIG_FB=y
 CONFIG_FB_CYBER2000=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SOUND_PRIME=y
@@ -72,7 +70,6 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_SMB_FS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_CODEPAGE_852=y
@@ -80,6 +77,9 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 907d6512821a..1d0e47b2ae32 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -10,14 +9,14 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
-CONFIG_SLAB=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_NOMADIK=y
 CONFIG_MACH_NOMADIK_8815NHK=y
 CONFIG_AEABI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_SWAP is not set
+CONFIG_SLAB=y
 CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -59,6 +58,7 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 14c17a218ec5..930e53e8b3ed 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -1,34 +1,30 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-# CONFIG_KALLSYMS is not set
 # CONFIG_ELF_CORE is not set
 # CONFIG_BASE_FULL is not set
 # CONFIG_SHMEM is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-CONFIG_SLOB=y
+# CONFIG_KALLSYMS is not set
 CONFIG_PROFILING=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP1=y
-CONFIG_OMAP_RESET_CLOCKS=y
-# CONFIG_OMAP_MUX is not set
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_DM_TIMER=y
 CONFIG_ARCH_OMAP730=y
 CONFIG_ARCH_OMAP850=y
 CONFIG_ARCH_OMAP16XX=y
+# CONFIG_OMAP_MUX is not set
+CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_MACH_OMAP_INNOVATOR=y
 CONFIG_MACH_OMAP_H2=y
 CONFIG_MACH_OMAP_H3=y
@@ -45,20 +41,22 @@ CONFIG_MACH_NOKIA770=y
 CONFIG_MACH_AMS_DELTA=y
 CONFIG_MACH_OMAP_GENERIC=y
 # CONFIG_ARM_THUMB is not set
-CONFIG_PCCARD=y
-CONFIG_OMAP_CF=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_LEDS=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_MISC=y
-CONFIG_PM=y
 # CONFIG_SUSPEND is not set
+CONFIG_PM=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BINFMT_MISC=y
+# CONFIG_SWAP is not set
+CONFIG_SLOB=y
+# CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -79,6 +77,8 @@ CONFIG_BT_RFCOMM=y
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=y
 CONFIG_BT_HIDP=y
+CONFIG_PCCARD=y
+CONFIG_OMAP_CF=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_CONNECTOR=y
@@ -99,12 +99,21 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=m
 CONFIG_PATA_PCMCIA=m
 CONFIG_NETDEVICES=y
 CONFIG_TUN=y
 CONFIG_PHYLIB=y
 CONFIG_SMC91X=y
+CONFIG_PPP=y
+CONFIG_PPP_BSDCOMP=y
+CONFIG_PPP_DEFLATE=y
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_ASYNC=y
+CONFIG_SLIP=y
+CONFIG_SLIP_COMPRESSED=y
 CONFIG_USB_CATC=y
 CONFIG_USB_KAWETH=y
 CONFIG_USB_PEGASUS=y
@@ -112,14 +121,6 @@ CONFIG_USB_RTL8150=y
 CONFIG_USB_USBNET=y
 # CONFIG_USB_NET_AX8817X is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
-CONFIG_PPP=y
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=y
-CONFIG_PPP_DEFLATE=y
-CONFIG_PPP_BSDCOMP=y
-CONFIG_SLIP=y
-CONFIG_SLIP_COMPRESSED=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_EVBUG=y
@@ -130,11 +131,11 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_UINPUT=y
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=3
 CONFIG_SERIAL_8250_RUNTIME_UARTS=3
-# CONFIG_LEGACY_PTYS is not set
 CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -156,11 +157,6 @@ CONFIG_FB_OMAP_LCD_MIPID=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
-CONFIG_FONT_6x11=y
-CONFIG_FONT_MINI_4x6=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
@@ -222,7 +218,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_CODEPAGE_852=y
@@ -235,13 +230,8 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_UTF8=y
 # CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_USER=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
@@ -249,3 +239,13 @@ CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_LIBCRC32C=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_FONT_6x11=y
+CONFIG_FONT_MINI_4x6=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9380df6b530f..db16d71592dd 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -22,11 +22,8 @@ CONFIG_CGROUP_PERF=y
 CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_SLAB=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_MULTI_V6=y
-CONFIG_POWER_AVS_OMAP=y
-CONFIG_POWER_AVS_OMAP_CLASS3=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_ARCH_OMAP2=y
 CONFIG_ARCH_OMAP3=y
@@ -35,6 +32,8 @@ CONFIG_SOC_OMAP5=y
 CONFIG_SOC_AM33XX=y
 CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
+CONFIG_POWER_AVS_OMAP=y
+CONFIG_POWER_AVS_OMAP_CLASS3=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
 CONFIG_SMP=y
@@ -69,9 +68,9 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=y
+CONFIG_SLAB=y
 CONFIG_CMA=y
 CONFIG_ZSMALLOC=m
 CONFIG_NET=y
@@ -316,6 +315,7 @@ CONFIG_PCI_ENDPOINT_TEST=m
 CONFIG_EEPROM_AT24=m
 CONFIG_EEPROM_AT25=m
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI_PLATFORM=y
@@ -494,15 +494,15 @@ CONFIG_REGULATOR_TWL4030=y
 CONFIG_RC_CORE=m
 CONFIG_LIRC=y
 CONFIG_RC_DEVICES=y
-CONFIG_IR_SPI=m
-CONFIG_IR_RX51=m
 CONFIG_IR_GPIO_TX=m
 CONFIG_IR_PWM_TX=m
+CONFIG_IR_RX51=m
+CONFIG_IR_SPI=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_OMAP3=m
-CONFIG_VIDEO_TVP5150=m
 CONFIG_VIDEO_MT9P031=m
+CONFIG_VIDEO_TVP5150=m
 CONFIG_DRM=m
 CONFIG_DRM_OMAP=m
 CONFIG_OMAP5_DSS_HDMI=y
@@ -727,8 +727,8 @@ CONFIG_FONT_8x16=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_INFO_SPLIT=y
 CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_DEBUG_INFO_SPLIT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_SCHEDSTATS=y
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index b9e3b647e732..8fcab7b22a07 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -1,16 +1,10 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
-# CONFIG_SLUB_DEBUG is not set
 CONFIG_PROFILING=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_BSD_DISKLABEL=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V6 is not set
 # CONFIG_ARCH_MULTI_V7 is not set
@@ -39,7 +33,6 @@ CONFIG_MACH_WNR854T=y
 CONFIG_MACH_RD88F5181L_GE=y
 CONFIG_MACH_RD88F5181L_FXO=y
 CONFIG_MACH_RD88F6183AP_GE=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -47,6 +40,11 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BSD_DISKLABEL=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -58,6 +56,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_NET_DSA=y
 CONFIG_NET_PKTGEN=m
+# CONFIG_VGA_ARB is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -69,13 +68,14 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_RAW_NAND=y
-CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_MTD_NAND_ORION=y
+CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
@@ -103,7 +103,6 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_SENSORS_LM75=y
-# CONFIG_VGA_ARB is not set
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
@@ -148,17 +147,18 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
+CONFIG_CRYPTO_CBC=m
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_DEV_MARVELL_CESA=y
+CONFIG_CRC_T10DIF=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
+# CONFIG_SLUB_DEBUG is not set
 CONFIG_LATENCYTOP=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_DEV_MARVELL_CESA=y
-CONFIG_CRC_T10DIF=y
diff --git a/arch/arm/configs/oxnas_v6_defconfig b/arch/arm/configs/oxnas_v6_defconfig
index de37f7e90999..600f78b363dd 100644
--- a/arch/arm/configs/oxnas_v6_defconfig
+++ b/arch/arm/configs/oxnas_v6_defconfig
@@ -7,16 +7,11 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_STRICT_KERNEL_RWX=y
 CONFIG_STRICT_MODULE_RWX=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_CMDLINE_PARTITION=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_OXNAS=y
 CONFIG_MACH_OX820=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
-CONFIG_CMA=y
 CONFIG_FORCE_MAX_ZONEORDER=12
 CONFIG_SECCOMP=y
 CONFIG_ARM_APPENDED_DTB=y
@@ -26,6 +21,11 @@ CONFIG_EFI=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_VFP=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMDLINE_PARTITION=y
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -44,8 +44,6 @@ CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_DMA_CMA=y
-CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -88,5 +86,7 @@ CONFIG_PSTORE_RAM=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/palmz72_defconfig b/arch/arm/configs/palmz72_defconfig
index e6acb1d588e2..fc6553bede61 100644
--- a/arch/arm/configs/palmz72_defconfig
+++ b/arch/arm/configs/palmz72_defconfig
@@ -1,17 +1,14 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_PXA_PALM=y
 # CONFIG_MACH_PALMTX is not set
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -19,6 +16,9 @@ CONFIG_CMDLINE="mem=32M console=tty root=/dev/mmcblk0"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_APM_EMULATION=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -52,8 +52,6 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_DEBUG=y
@@ -72,5 +70,7 @@ CONFIG_TMPFS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_866=y
 CONFIG_NLS_UTF8=y
-CONFIG_DEBUG_USER=y
 CONFIG_CRC_T10DIF=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/pcm027_defconfig b/arch/arm/configs/pcm027_defconfig
index 106d5bef48e2..69a318f74216 100644
--- a/arch/arm/configs/pcm027_defconfig
+++ b/arch/arm/configs/pcm027_defconfig
@@ -1,6 +1,8 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
@@ -8,22 +10,20 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_PCM027=y
 CONFIG_MACH_PCM990_BASEBOARD=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_SWAP is not set
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -43,6 +43,7 @@ CONFIG_MTD_PHYSMAP=y
 # CONFIG_BLK_DEV is not set
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
@@ -51,9 +52,9 @@ CONFIG_SMC91X=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -84,7 +85,6 @@ CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_DEFAULT="iso8859-15"
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_15=y
diff --git a/arch/arm/configs/pleb_defconfig b/arch/arm/configs/pleb_defconfig
index 2170148b975c..1b5a6c28d3fb 100644
--- a/arch/arm/configs/pleb_defconfig
+++ b/arch/arm/configs/pleb_defconfig
@@ -1,11 +1,9 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_HOTPLUG is not set
 # CONFIG_SHMEM is not set
-CONFIG_MODULES=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_PLEB=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -14,6 +12,8 @@ CONFIG_CMDLINE="console=ttySA0,9600 mem=16M@0xc0000000 mem=16M@0xc8000000 root=/
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
+# CONFIG_SWAP is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -21,9 +21,9 @@ CONFIG_INET=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
-CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index 0947f022954d..d7090c4aeb1e 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -1,12 +1,6 @@
 CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_MMP=y
 CONFIG_MACH_ASPENITE=y
 CONFIG_MACH_ZYLONITE2=y
 CONFIG_MACH_AVENGERS_LITE=y
@@ -16,8 +10,14 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_ARCH_MMP=y
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M"
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -34,9 +34,9 @@ CONFIG_SMC91X=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
@@ -49,12 +49,12 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
+CONFIG_CRC_CCITT=y
 CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_CCITT=y
diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
index 5663245e9534..a0b2027bc92a 100644
--- a/arch/arm/configs/pxa255-idp_defconfig
+++ b/arch/arm/configs/pxa255-idp_defconfig
@@ -1,6 +1,5 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_MODULES=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_PXA_IDP=y
@@ -11,6 +10,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs ip=dhcp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -38,9 +38,6 @@ CONFIG_FB=y
 CONFIG_FB_PXA=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
 CONFIG_LOGO=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
@@ -48,8 +45,11 @@ CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_INFO=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
index 228d4271748b..b1cce2a8c74c 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -1,22 +1,22 @@
 CONFIG_SYSVIPC=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_KALLSYMS_ALL=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_LITTLETON=y
 CONFIG_MACH_TAVOREVB=y
 CONFIG_MACH_SAAR=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=64M debug"
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -31,11 +31,11 @@ CONFIG_IP_PNP=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 CONFIG_MTD_ONENAND_GENERIC=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_MTD_NAND_MARVELL=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
@@ -48,9 +48,9 @@ CONFIG_KEYBOARD_PXA27x=y
 CONFIG_KEYBOARD_PXA930_ROTARY=y
 CONFIG_MOUSE_PXA930_TRKBALL=y
 CONFIG_INPUT_TOUCHSCREEN=y
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 # CONFIG_I2C_HELPER_AUTO is not set
@@ -79,8 +79,6 @@ CONFIG_BACKLIGHT_DA903X=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
-CONFIG_FONTS=y
-CONFIG_FONT_6x11=y
 CONFIG_LOGO=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
@@ -106,9 +104,11 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
+CONFIG_FONTS=y
+CONFIG_FONT_6x11=y
 CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index b21196372158..634ab55ff69d 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -1,23 +1,23 @@
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
+CONFIG_ARCH_MMP=y
+CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M earlyprintk"
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_MMP=y
 CONFIG_MACH_TAVOREVB=y
 CONFIG_MACH_TTC_DKB=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M earlyprintk"
 CONFIG_FPE_NWFPE=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -34,9 +34,12 @@ CONFIG_SMC91X=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
 CONFIG_SPI=y
+# CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_MMP_DISP=y
 CONFIG_MMP_DISP_CONTROLLER=y
@@ -44,9 +47,6 @@ CONFIG_MMP_SPI=y
 CONFIG_MMP_PANEL_TPOHVGA=y
 CONFIG_MMP_FB=y
 CONFIG_LOGO=y
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_TMPFS=y
@@ -57,9 +57,10 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
+CONFIG_CRC_CCITT=y
 CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_USER=y
@@ -67,4 +68,3 @@ CONFIG_DEBUG_LL=y
 CONFIG_DEBUG_MMP_UART2=y
 CONFIG_EARLY_PRINTK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_CCITT=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 1db70dfd32d2..ed92947244a1 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -3,6 +3,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
@@ -11,18 +12,7 @@ CONFIG_LOG_BUF_SHIFT=13
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
-CONFIG_SLOB=y
 CONFIG_PROFILING=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_FORCE_LOAD=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_LDM_PARTITION=y
-CONFIG_CMDLINE_PARTITION=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_LUBBOCK=y
@@ -75,15 +65,7 @@ CONFIG_TOSA_USE_EXT_KEYCODES=y
 CONFIG_MACH_ICONTROL=y
 CONFIG_ARCH_PXA_ESERIES=y
 CONFIG_MACH_ZIPIT2=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCIEPORTBUS=y
-CONFIG_PCCARD=m
-CONFIG_YENTA=m
-CONFIG_PCMCIA_PXA2XX=m
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-# CONFIG_COMPACTION is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/ram0 ro"
@@ -98,7 +80,24 @@ CONFIG_CPUFREQ_DT=m
 CONFIG_ARM_PXA2xx_CPUFREQ=m
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
+CONFIG_ARM_CRYPTO=y
+CONFIG_CRYPTO_SHA1_ARM=m
+CONFIG_CRYPTO_SHA256_ARM=m
+CONFIG_CRYPTO_SHA512_ARM=m
+CONFIG_CRYPTO_AES_ARM=m
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_LDM_PARTITION=y
+CONFIG_CMDLINE_PARTITION=y
 CONFIG_BINFMT_MISC=y
+CONFIG_SLOB=y
+# CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -152,17 +151,23 @@ CONFIG_MAC80211=m
 CONFIG_RFKILL=y
 CONFIG_RFKILL_INPUT=y
 CONFIG_RFKILL_GPIO=m
+CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_PCI_MSI=y
+CONFIG_PCCARD=m
+CONFIG_YENTA=m
+CONFIG_PCMCIA_PXA2XX=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_CONNECTOR=y
+CONFIG_MTD_AR7_PARTS=m
+CONFIG_MTD_CMDLINE_PARTS=m
+CONFIG_MTD_OF_PARTS=m
+CONFIG_MTD_AFS_PARTS=m
 CONFIG_MTD_REDBOOT_PARTS=m
 CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=0
 CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
 CONFIG_MTD_REDBOOT_PARTS_READONLY=y
-CONFIG_MTD_CMDLINE_PARTS=m
-CONFIG_MTD_AFS_PARTS=m
-CONFIG_MTD_OF_PARTS=m
-CONFIG_MTD_AR7_PARTS=m
 CONFIG_MTD_BLOCK=m
 CONFIG_NFTL=m
 CONFIG_NFTL_RW=y
@@ -180,23 +185,23 @@ CONFIG_MTD_PXA2XX=m
 CONFIG_MTD_M25P80=m
 CONFIG_MTD_BLOCK2MTD=y
 CONFIG_MTD_DOCG3=m
+CONFIG_MTD_ONENAND=m
+CONFIG_MTD_ONENAND_VERIFY_WRITE=y
+CONFIG_MTD_ONENAND_GENERIC=m
 CONFIG_MTD_RAW_NAND=m
-CONFIG_MTD_NAND_ECC_SW_BCH=y
+CONFIG_MTD_NAND_SHARPSL=m
+CONFIG_MTD_NAND_MARVELL=m
+CONFIG_MTD_NAND_TMIO=m
+CONFIG_MTD_NAND_BRCMNAND=m
 CONFIG_MTD_NAND_GPIO=m
+CONFIG_MTD_NAND_PLATFORM=m
 CONFIG_MTD_NAND_DISKONCHIP=m
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x4000000
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
 CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
-CONFIG_MTD_NAND_SHARPSL=m
-CONFIG_MTD_NAND_MARVELL=m
 CONFIG_MTD_NAND_CM_X270=m
-CONFIG_MTD_NAND_TMIO=m
-CONFIG_MTD_NAND_BRCMNAND=m
-CONFIG_MTD_NAND_PLATFORM=m
-CONFIG_MTD_ONENAND=m
-CONFIG_MTD_ONENAND_VERIFY_WRITE=y
-CONFIG_MTD_ONENAND_GENERIC=m
+CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_SPI_NOR=m
 CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_BLOCK=y
@@ -210,8 +215,6 @@ CONFIG_AD525X_DPOT_I2C=m
 CONFIG_ICS932S401=m
 CONFIG_APDS9802ALS=m
 CONFIG_ISL29003=m
-CONFIG_IIO=m
-CONFIG_AD5446=m
 CONFIG_EEPROM_AT24=m
 CONFIG_SENSORS_LIS3_SPI=m
 CONFIG_SCSI=y
@@ -242,13 +245,13 @@ CONFIG_SMC91X=m
 CONFIG_SMSC911X=m
 CONFIG_STMMAC_ETH=m
 CONFIG_PHYLIB=y
-CONFIG_AT803X_PHY=m
-CONFIG_MARVELL_PHY=m
 CONFIG_SMSC_PHY=m
 CONFIG_BROADCOM_PHY=y
 CONFIG_ICPLUS_PHY=m
 CONFIG_MICREL_PHY=m
 CONFIG_FIXED_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_AT803X_PHY=m
 CONFIG_MDIO_BITBANG=y
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
@@ -272,16 +275,16 @@ CONFIG_HOSTAP=m
 CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
 CONFIG_HOSTAP_CS=m
-CONFIG_LIBERTAS=m
-CONFIG_LIBERTAS_SDIO=m
 CONFIG_HERMES=m
 CONFIG_PCMCIA_HERMES=m
 CONFIG_PCMCIA_SPECTRUM=m
+CONFIG_LIBERTAS=m
+CONFIG_LIBERTAS_SDIO=m
+CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
 CONFIG_RT2X00=m
 CONFIG_RT73USB=m
 CONFIG_RT2800USB=m
-CONFIG_MWIFIEX=m
-CONFIG_MWIFIEX_SDIO=m
 CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_INPUT_MATRIXKMAP=y
 CONFIG_INPUT_MOUSEDEV=m
@@ -354,16 +357,17 @@ CONFIG_SPI_XILINX=m
 CONFIG_SPI_SPIDEV=m
 CONFIG_PPS=y
 CONFIG_DEBUG_GPIO=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_DWAPB=m
 CONFIG_GPIO_GENERIC_PLATFORM=m
 CONFIG_GPIO_MAX732X=m
 CONFIG_GPIO_PCA953X=m
 CONFIG_GPIO_PCF857X=m
+CONFIG_HTC_EGPIO=y
 CONFIG_GPIO_PALMAS=y
 CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_GPIO_MAX7301=m
-CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY_DEBUG=y
 CONFIG_PDA_POWER=m
 CONFIG_BATTERY_SBS=m
@@ -387,13 +391,8 @@ CONFIG_MFD_AS3711=y
 CONFIG_MFD_BCM590XX=m
 CONFIG_MFD_AXP20X=y
 CONFIG_MFD_CROS_EC_DEV=m
-CONFIG_CHROME_PLATFORMS=y
-CONFIG_CROS_EC=m
-CONFIG_CROS_EC_I2C=m
-CONFIG_CROS_EC_SPI=m
 CONFIG_MFD_ASIC3=y
 CONFIG_PMIC_DA903X=y
-CONFIG_HTC_EGPIO=y
 CONFIG_HTC_PASIC3=m
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77693=y
@@ -441,8 +440,8 @@ CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
-CONFIG_VIDEO_PXA27x=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_PXA27x=m
 CONFIG_DRM=m
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_TILEBLITTING=y
@@ -462,12 +461,12 @@ CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
-CONFIG_SND_SEQUENCER=m
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_DYNAMIC_MINORS=y
 CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
+CONFIG_SND_SEQUENCER=m
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_ATMEL_SOC=m
@@ -575,6 +574,7 @@ CONFIG_USB_LCD=m
 CONFIG_USB_CYTHERM=m
 CONFIG_USB_IDMOUSE=m
 CONFIG_USB_GPIO_VBUS=y
+CONFIG_USB_GPIO_VBUS=m
 CONFIG_USB_ISP1301=m
 CONFIG_USB_GADGET=m
 CONFIG_USB_GADGET_VBUS_DRAW=500
@@ -621,9 +621,9 @@ CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_MAX8907=m
 CONFIG_RTC_DRV_RS5C372=m
 CONFIG_RTC_DRV_ISL1208=m
-CONFIG_RTC_DRV_PALMAS=m
 CONFIG_RTC_DRV_PCF8563=m
 CONFIG_RTC_DRV_PCF8583=m
+CONFIG_RTC_DRV_PALMAS=m
 CONFIG_RTC_DRV_TPS6586X=m
 CONFIG_RTC_DRV_TPS65910=m
 CONFIG_RTC_DRV_S35390A=m
@@ -638,10 +638,16 @@ CONFIG_PXA_DMA=y
 CONFIG_DW_DMAC=m
 CONFIG_UIO=y
 CONFIG_CROS_EC_CHARDEV=m
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC=m
+CONFIG_CROS_EC_I2C=m
+CONFIG_CROS_EC_SPI=m
 CONFIG_COMMON_CLK_S2MPS11=m
 CONFIG_PM_DEVFREQ=y
 CONFIG_EXTCON=y
 CONFIG_MEMORY=y
+CONFIG_IIO=m
+CONFIG_AD5446=m
 CONFIG_PWM=y
 CONFIG_PWM_PXA=m
 CONFIG_PHY_SAMSUNG_USB2=m
@@ -707,17 +713,8 @@ CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
-CONFIG_PRINTK_TIME=y
-CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
-CONFIG_FRAME_WARN=0
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_SHIRQ=y
 CONFIG_TIMER_STATS=y
-CONFIG_FUNCTION_TRACER=y
-CONFIG_FTRACE_SYSCALLS=y
-CONFIG_DEBUG_USER=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_CRYPTD=m
@@ -743,11 +740,6 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
-CONFIG_ARM_CRYPTO=y
-CONFIG_CRYPTO_SHA1_ARM=m
-CONFIG_CRYPTO_SHA256_ARM=m
-CONFIG_CRYPTO_SHA512_ARM=m
-CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=m
 CONFIG_FONTS=y
@@ -755,3 +747,11 @@ CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_FONT_6x11=y
 CONFIG_FONT_MINI_4x6=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_FRAME_WARN=0
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_SHIRQ=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_FTRACE_SYSCALLS=y
diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 5cd935ee148a..e7b9d6d6212e 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -1,39 +1,38 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
-# CONFIG_SLUB_DEBUG is not set
-# CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_MSM8X60=y
 CONFIG_ARCH_MSM8960=y
 CONFIG_ARCH_MSM8974=y
 CONFIG_ARCH_MDM9615=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCIE_QCOM=y
 CONFIG_SMP=y
-CONFIG_PREEMPT=y
+CONFIG_ARM_PSCI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_COMPAT_BRK is not set
 CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -56,15 +55,18 @@ CONFIG_BT_HCIUART_BCM=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_RFKILL=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_QCOM=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
+CONFIG_MTD_QCOMSMEM_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_MTD_QCOMSMEM_PARTS=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -133,10 +135,10 @@ CONFIG_PINCTRL_MSM8660=y
 CONFIG_PINCTRL_MSM8960=y
 CONFIG_PINCTRL_MDM9615=y
 CONFIG_PINCTRL_MSM8X74=y
-CONFIG_PINCTRL_SDX55=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
 CONFIG_GPIOLIB=y
+CONFIG_PINCTRL_SDX55=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_MSM=y
@@ -144,15 +146,17 @@ CONFIG_CHARGER_QCOM_SMBB=y
 CONFIG_CHARGER_BQ24190=m
 CONFIG_THERMAL=y
 CONFIG_QCOM_TSENS=y
+CONFIG_WATCHDOG=y
+CONFIG_QCOM_WDT=y
 CONFIG_MFD_PM8XXX=y
 CONFIG_MFD_QCOM_RPM=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_RPM=y
+CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
-CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_DRM=y
 CONFIG_DRM_MSM=m
@@ -160,11 +164,11 @@ CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_ANALOGIX_ANX78XX=m
 CONFIG_FB=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_LM3630A=y
 CONFIG_BACKLIGHT_LP855X=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_DYNAMIC_MINORS=y
@@ -180,6 +184,7 @@ CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MSM=y
 CONFIG_USB_ACM=y
+CONFIG_USB_DWC3=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
@@ -196,7 +201,6 @@ CONFIG_USB_CONFIGFS_ECM=y
 CONFIG_USB_CONFIGFS_F_FS=y
 CONFIG_USB_ULPI_BUS=y
 CONFIG_USB_ETH=m
-CONFIG_USB_DWC3=y
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
@@ -218,8 +222,8 @@ CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A7PLL=y
 CONFIG_QCOM_CLK_APCS_SDX55=y
 CONFIG_QCOM_CLK_RPM=y
-CONFIG_QCOM_CLK_RPMH=y
 CONFIG_QCOM_CLK_SMD_RPM=y
+CONFIG_QCOM_CLK_RPMH=y
 CONFIG_APQ_MMCC_8084=y
 CONFIG_IPQ_GCC_4019=y
 CONFIG_IPQ_LCC_806X=y
@@ -229,12 +233,12 @@ CONFIG_MDM_LCC_9615=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_SDX_GCC_55=y
-CONFIG_MSM_IOMMU=y
-CONFIG_ARM_SMMU=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_MAILBOX=y
 CONFIG_QCOM_APCS_IPC=y
+CONFIG_MSM_IOMMU=y
+CONFIG_ARM_SMMU=y
 CONFIG_REMOTEPROC=y
 CONFIG_QCOM_ADSP_PIL=y
 CONFIG_QCOM_Q6V5_PAS=y
@@ -247,12 +251,12 @@ CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_OCMEM=y
 CONFIG_QCOM_PM=y
+CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
-CONFIG_QCOM_RPMH=y
-CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_WCNSS_CTRL=y
 CONFIG_EXTCON_QCOM_SPMI_MISC=y
 CONFIG_IIO=y
@@ -270,10 +274,10 @@ CONFIG_BMP280=y
 CONFIG_PWM=y
 CONFIG_PHY_QCOM_APQ8064_SATA=y
 CONFIG_PHY_QCOM_IPQ806X_SATA=y
-CONFIG_PHY_QCOM_USB_HS=y
-CONFIG_PHY_QCOM_USB_HSIC=y
 CONFIG_PHY_QCOM_QMP=y
+CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
+CONFIG_PHY_QCOM_USB_HSIC=y
 CONFIG_QCOM_QFPROM=y
 CONFIG_INTERCONNECT=y
 CONFIG_INTERCONNECT_QCOM=y
@@ -299,8 +303,8 @@ CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_USER_API=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
-CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_USER_API_RNG=m
+CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
@@ -309,9 +313,5 @@ CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
+# CONFIG_SLUB_DEBUG is not set
 # CONFIG_SCHED_DEBUG is not set
-CONFIG_WATCHDOG=y
-CONFIG_QCOM_WDT=y
-CONFIG_ARM_PSCI=y
-CONFIG_CPU_FREQ=y
-CONFIG_CPUFREQ_DT=y
diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index 3ef3521c19db..92f803c2805c 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -1,10 +1,8 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_FULL=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_PERF_EVENTS=y
-CONFIG_SLAB=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_REALVIEW=y
 CONFIG_MACH_REALVIEW_EB=y
@@ -21,7 +19,8 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=10.1.69.3:/work/nfsroot ip=dhcp console=tt
 CONFIG_VFP=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_SWAP is not set
+CONFIG_SLAB=y
 CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -43,6 +42,7 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NETDEVICES=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
@@ -95,9 +95,9 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index c090643b1ecb..a908663044ba 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -2,16 +2,17 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_RPC=y
 CONFIG_CPU_SA110=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -33,6 +34,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_ARXESCSI=m
@@ -55,12 +57,12 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_MOUSE_PS2 is not set
 CONFIG_MOUSE_RISCPC=y
 # CONFIG_SERIO_SERPORT is not set
+CONFIG_LEGACY_PTY_COUNT=64
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=16
 CONFIG_SERIAL_8250_RUNTIME_UARTS=8
 CONFIG_SERIAL_8250_ACORN=y
-CONFIG_LEGACY_PTY_COUNT=64
 CONFIG_PRINTER=m
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
@@ -69,9 +71,6 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_FB=y
 CONFIG_FB_ACORN=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x16=y
-CONFIG_FONT_ACORN_8x8=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SOUND_PRIME=m
@@ -89,10 +88,8 @@ CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_ADFS_FS=y
 CONFIG_NFS_FS=y
-CONFIG_PARTITION_ADVANCED=y
 # CONFIG_ACORN_PARTITION_CUMANA is not set
 # CONFIG_ACORN_PARTITION_EESOX is not set
-CONFIG_BSD_DISKLABEL=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
@@ -120,8 +117,11 @@ CONFIG_NLS_ISO8859_6=m
 CONFIG_NLS_ISO8859_7=m
 CONFIG_NLS_ISO8859_9=m
 CONFIG_NLS_KOI8_R=m
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x16=y
+CONFIG_FONT_ACORN_8x8=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 CONFIG_DEBUG_LL_UART_8250=y
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index 12fa6ca14dcc..a455fd772e5b 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -3,7 +3,6 @@ CONFIG_IKCONFIG=m
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
 CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
@@ -46,10 +45,10 @@ CONFIG_FPE_NWFPE_XP=y
 CONFIG_APM_EMULATION=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_SOLARIS_X86_PARTITION=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -206,6 +205,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_CHR_DEV_SCH=m
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SCAN_ASYNC=y
@@ -252,7 +252,6 @@ CONFIG_INPUT_YEALINK=m
 CONFIG_INPUT_CM109=m
 CONFIG_INPUT_UINPUT=m
 CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=8
@@ -261,6 +260,7 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
+CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_DEV_BUS=m
 CONFIG_PRINTER=y
 CONFIG_PPDEV=y
@@ -431,8 +431,8 @@ CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index 59a258d504aa..fad45f32180d 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -72,8 +72,8 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
 CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 70919716f815..fa3ca4642719 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -21,7 +21,6 @@ CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_SOLARIS_X86_PARTITION=y
@@ -48,6 +47,7 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NETDEVICES=y
 CONFIG_BRCMFMAC=m
 CONFIG_INPUT_EVDEV=y
@@ -116,8 +116,8 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_CRC_CCITT=y
 CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 18852803522e..3a6a4851ef26 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -7,7 +6,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
-CONFIG_SLAB=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
@@ -26,8 +24,9 @@ CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SWAP is not set
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -72,6 +71,7 @@ CONFIG_ATMEL_SSC=y
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_NET_DSA_MICROCHIP_KSZ9477=m
@@ -152,11 +152,11 @@ CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_ATMEL_ISC=y
 CONFIG_VIDEO_ATMEL_ISI=y
+CONFIG_VIDEO_MT9V032=m
 CONFIG_VIDEO_OV2640=m
 CONFIG_VIDEO_OV5640=m
 CONFIG_VIDEO_OV7670=m
 CONFIG_VIDEO_OV7740=m
-CONFIG_VIDEO_MT9V032=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
 CONFIG_DRM_PANEL_SIMPLE=y
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 63302858b9c4..0384030d8b25 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -14,8 +13,6 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_IO_URING is not set
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
-# CONFIG_VM_EVENT_COUNTERS is not set
-CONFIG_SLAB=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_SAMA7G5=y
 CONFIG_ATMEL_CLOCKSOURCE_TCB=y
@@ -43,8 +40,11 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_EFI_PARTITION is not set
 # CONFIG_COREDUMP is not set
+# CONFIG_SWAP is not set
+CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
 CONFIG_CMA=y
+# CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -229,9 +229,9 @@ CONFIG_CRC_ITU_T=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_CMA_ALIGNMENT=9
+# CONFIG_DEBUG_MISC is not set
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_DEBUG_FS=y
-# CONFIG_DEBUG_MISC is not set
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
diff --git a/arch/arm/configs/shannon_defconfig b/arch/arm/configs/shannon_defconfig
index de33abdeb6fa..9c1de40132b2 100644
--- a/arch/arm/configs/shannon_defconfig
+++ b/arch/arm/configs/shannon_defconfig
@@ -1,20 +1,21 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_SHANNON=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_SA1100=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttySA0,9600 console=tty1 root=/dev/mtdblock2 init=/linuxrc"
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_SA1100=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -40,5 +41,4 @@ CONFIG_VFAT_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_MINIX_FS=y
 CONFIG_NFS_FS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/simpad_defconfig b/arch/arm/configs/simpad_defconfig
index 28d99d8895f9..042f9626e0ee 100644
--- a/arch/arm/configs/simpad_defconfig
+++ b/arch/arm/configs/simpad_defconfig
@@ -1,20 +1,18 @@
 CONFIG_LOCALVERSION="oe1"
 CONFIG_SYSVIPC=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
-CONFIG_MODULES=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_SIMPAD=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_SA1100=y
-CONFIG_PREEMPT=y
 CONFIG_LEDS=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mtdparts=sa1100:512k(boot),1m(kernel),-(root) console=ttySA0 root=1f02 noinitrd mem=64M jffs2_orphaned_inodes=delete rootfstype=jffs2"
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PM=y
 CONFIG_NET=y
@@ -37,6 +35,8 @@ CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=m
 CONFIG_BT_BNEP_MC_FILTER=y
 CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_SA1100=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -56,19 +56,19 @@ CONFIG_DUMMY=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCI=y
 CONFIG_NET_PCMCIA=y
-CONFIG_PCMCIA_3C589=m
 CONFIG_PCMCIA_3C574=m
+CONFIG_PCMCIA_3C589=m
 CONFIG_PCMCIA_PCNET=m
 CONFIG_PCMCIA_SMC91C92=m
 CONFIG_PCMCIA_XIRC2PS=m
 CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPPOE=m
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=600
 CONFIG_INPUT_EVDEV=m
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 2d9404ea52c6..9d4f352a57de 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -20,7 +20,6 @@ CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -52,7 +51,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
-CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_OF_OVERLAY=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -64,6 +62,7 @@ CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_ALTERA_TSE=m
@@ -88,6 +87,7 @@ CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
+CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_SPI_DESIGNWARE=y
 CONFIG_SPI_DW_MMIO=y
 CONFIG_SPI_SPIDEV=y
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 065553326b39..bcfef1c7befe 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -1,18 +1,11 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR13XX=y
 CONFIG_MACH_SPEAR1310=y
 CONFIG_MACH_SPEAR1340=y
 # CONFIG_SWP_EMULATE is not set
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCIE_SPEAR13XX=y
 CONFIG_SMP=y
 # CONFIG_SMP_ON_UP is not set
 # CONFIG_ARM_CPU_TOPOLOGY is not set
@@ -20,6 +13,10 @@ CONFIG_AEABI=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_UNIX=y
@@ -28,6 +25,9 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_NET_IPIP=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_SPEAR13XX=y
 CONFIG_MTD=y
 CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -97,8 +97,8 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
+CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_INFO=y
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index afca722d6605..a46fc0adb284 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -1,16 +1,16 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR3XX=y
 CONFIG_MACH_SPEAR300=y
 CONFIG_MACH_SPEAR310=y
 CONFIG_MACH_SPEAR320=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_MTD=y
@@ -77,8 +77,8 @@ CONFIG_JFFS2_FS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
+CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_INFO=y
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index bc32c02cb86b..a4d6470a0ed9 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -1,13 +1,13 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_PLAT_SPEAR=y
+CONFIG_ARCH_SPEAR6XX=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
-# CONFIG_ARCH_MULTI_V7 is not set
-CONFIG_PLAT_SPEAR=y
-CONFIG_ARCH_SPEAR6XX=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_MTD=y
@@ -66,8 +66,8 @@ CONFIG_JFFS2_FS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
+CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_INFO=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 43d079ee342a..4630aac47a8e 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -1,27 +1,25 @@
 CONFIG_SYSVIPC=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_PXA_SHARPSL=y
 CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_PXA2XX=y
-CONFIG_PREEMPT=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PM=y
 CONFIG_NET=y
@@ -78,6 +76,8 @@ CONFIG_BT_HCIBT3C=m
 CONFIG_BT_HCIBLUECARD=m
 CONFIG_BT_HCIBTUART=m
 CONFIG_BT_HCIVHCI=m
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_PXA2XX=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -91,10 +91,15 @@ CONFIG_CHR_DEV_ST=m
 CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
+CONFIG_PCMCIA_PCNET=m
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_ASYNC=m
 CONFIG_USB_CATC=m
 CONFIG_USB_KAWETH=m
 CONFIG_USB_PEGASUS=m
@@ -102,10 +107,6 @@ CONFIG_USB_RTL8150=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
 CONFIG_NET_PCMCIA=y
-CONFIG_PCMCIA_PCNET=m
-CONFIG_PPP=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
@@ -116,11 +117,11 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_UINPUT=m
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=m
 CONFIG_SERIAL_8250_CS=m
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 CONFIG_SPI=y
 CONFIG_SPI_PXA2XX=y
 CONFIG_FB=y
@@ -131,11 +132,6 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
-CONFIG_USB_KBD=m
-CONFIG_USB_MOUSE=m
 CONFIG_HID_A4TECH=m
 CONFIG_HID_APPLE=m
 CONFIG_HID_BELKIN=m
@@ -152,6 +148,8 @@ CONFIG_HID_PETALYNX=m
 CONFIG_HID_SAMSUNG=m
 CONFIG_HID_SONY=m
 CONFIG_HID_SUNPLUS=m
+CONFIG_USB_KBD=m
+CONFIG_USB_MOUSE=m
 CONFIG_USB=m
 CONFIG_USB_MON=m
 CONFIG_USB_OHCI_HCD=m
@@ -220,16 +218,12 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_SMB_FS=m
 CONFIG_SMB_NLS_DEFAULT=y
-CONFIG_PARTITION_ADVANCED=y
+CONFIG_NFS_V4=m
 CONFIG_NLS_DEFAULT="cp437"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_DEBUG_PREEMPT is not set
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_LL=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_ECB=m
@@ -252,3 +246,9 @@ CONFIG_CRYPTO_TWOFISH=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_CCITT=y
 CONFIG_LIBCRC32C=m
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 71d6bfcf4551..25fbd8a6ad15 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -1,5 +1,6 @@
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
@@ -11,8 +12,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_EVENTFD is not set
 # CONFIG_AIO is not set
 CONFIG_EMBEDDED=y
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_SLUB_DEBUG is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_MMU is not set
 CONFIG_ARCH_STM32=y
@@ -21,7 +20,6 @@ CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x90000000
 CONFIG_FLASH_MEM_BASE=0x08000000
 CONFIG_FLASH_SIZE=0x00200000
-CONFIG_PREEMPT=y
 # CONFIG_ATAGS is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -29,6 +27,7 @@ CONFIG_XIP_KERNEL=y
 CONFIG_XIP_PHYS_ADDR=0x08008000
 CONFIG_BINFMT_FLAT=y
 # CONFIG_COREDUMP is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
@@ -38,9 +37,9 @@ CONFIG_KEYBOARD_GPIO=y
 # CONFIG_VT is not set
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
+CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -74,12 +73,13 @@ CONFIG_EXT3_FS=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
 CONFIG_NLS=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC7=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SLUB_DEBUG is not set
 # CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO=y
-CONFIG_CRC_ITU_T=y
-CONFIG_CRC7=y
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 8ba7935bd039..3d14827e0a31 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -97,9 +97,9 @@ CONFIG_IR_SUNXI=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SUN4I_CSI=y
 CONFIG_VIDEO_SUN6I_CSI=y
-CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SUN8I_DEINTERLACE=y
 CONFIG_VIDEO_SUN8I_ROTATE=y
 CONFIG_DRM=y
diff --git a/arch/arm/configs/tct_hammer_defconfig b/arch/arm/configs/tct_hammer_defconfig
index 46cbae6d1b1f..6cc2f108056f 100644
--- a/arch/arm/configs/tct_hammer_defconfig
+++ b/arch/arm/configs/tct_hammer_defconfig
@@ -1,18 +1,14 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-# CONFIG_KALLSYMS is not set
 # CONFIG_ELF_CORE is not set
 # CONFIG_SHMEM is not set
-CONFIG_SLOB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+# CONFIG_KALLSYMS is not set
 CONFIG_ARCH_MULTI_V4T=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_S3C24XX=y
@@ -21,6 +17,10 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=64M root=/dev/ram0 init=/linuxrc rw"
 CONFIG_FPE_NWFPE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_SWAP is not set
+CONFIG_SLOB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -55,5 +55,5 @@ CONFIG_JFFS2_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_LL=y
 CONFIG_CRC_CCITT=y
+CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index c209722399d7..ed4685589e38 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -16,7 +16,6 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ELF_CORE is not set
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
-CONFIG_SLAB=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_SMP=y
 CONFIG_HIGHMEM=y
@@ -29,12 +28,11 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_SLAB=y
 CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -80,6 +78,7 @@ CONFIG_PCI_TEGRA=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEGRA_GMI=y
+CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_MTD=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
@@ -91,6 +90,7 @@ CONFIG_ISL29003=y
 CONFIG_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
@@ -114,9 +114,9 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_TEGRA=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_KEYBOARD_CAP11XX=y
+CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_MOUSE_ELAN_I2C=m
 CONFIG_MOUSE_ELAN_I2C_SMBUS=y
-CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
 CONFIG_TOUCHSCREEN_ELAN=y
@@ -139,6 +139,7 @@ CONFIG_I2C_MUX_GPIO=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_TEGRA=y
+CONFIG_I2C_CROS_EC_TUNNEL=m
 CONFIG_SPI=y
 CONFIG_SPI_TEGRA114=y
 CONFIG_SPI_TEGRA20_SFLASH=y
@@ -158,9 +159,9 @@ CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_BATTERY_SBS=y
-CONFIG_CHARGER_BQ24735=y
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_CHARGER_GPIO=y
+CONFIG_CHARGER_BQ24735=y
 CONFIG_CHARGER_SMB347=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_BATTERY_ACER_A500=y
@@ -198,8 +199,10 @@ CONFIG_REGULATOR_TPS6586X=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
-CONFIG_USB_VIDEO_CLASS=y
 CONFIG_USB_GSPCA=y
+CONFIG_USB_VIDEO_CLASS=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_TEGRA_VDE=y
 CONFIG_DRM=y
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_TEGRA=y
@@ -286,13 +289,10 @@ CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
 CONFIG_STAGING_MEDIA=y
-CONFIG_V4L_MEM2MEM_DRIVERS=y
-CONFIG_VIDEO_TEGRA_VDE=y
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_I2C=m
 CONFIG_CROS_EC_SPI=m
-CONFIG_I2C_CROS_EC_TUNNEL=m
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index baeba4667e9b..db0444aada48 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -1,5 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
@@ -8,25 +9,23 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_TRIZEPS_PXA=y
 CONFIG_MACH_TRIZEPS4=y
-CONFIG_PCCARD=y
-# CONFIG_PCMCIA_LOAD_CIS is not set
-CONFIG_PCMCIA_PXA2XX=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="root=fe01 console=ttyS0,38400n8 loglevel=5"
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
 CONFIG_PM=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_LDM_PARTITION=y
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -55,6 +54,9 @@ CONFIG_BT_BNEP_MC_FILTER=y
 CONFIG_BT_BNEP_PROTO_FILTER=y
 CONFIG_BT_HIDP=m
 CONFIG_CFG80211=y
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_LOAD_CIS is not set
+CONFIG_PCMCIA_PXA2XX=y
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
 CONFIG_MTD_REDBOOT_PARTS=y
@@ -77,13 +79,13 @@ CONFIG_MTD_DOC2001PLUS=y
 CONFIG_MTD_DOCPROBE_ADVANCED=y
 CONFIG_MTD_DOCPROBE_ADDRESS=0x4000000
 CONFIG_MTD_DOCPROBE_HIGH=y
+CONFIG_MTD_ONENAND=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DISKONCHIP=y
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x4000000
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
 CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
-CONFIG_MTD_ONENAND=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=y
@@ -97,9 +99,17 @@ CONFIG_ATA=m
 CONFIG_PATA_PCMCIA=m
 CONFIG_PATA_PLATFORM=m
 CONFIG_NETDEVICES=y
-CONFIG_PHYLIB=y
 CONFIG_NET_ETHERNET=y
 CONFIG_DM9000=y
+CONFIG_PHYLIB=y
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MPPE=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
 CONFIG_HOSTAP=y
 CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
@@ -107,14 +117,6 @@ CONFIG_HOSTAP_CS=y
 CONFIG_HERMES=y
 CONFIG_PCMCIA_HERMES=y
 CONFIG_PCMCIA_SPECTRUM=y
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPP_MPPE=m
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=640
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
 CONFIG_INPUT_EVDEV=y
@@ -142,17 +144,14 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_SEQUENCER=y
 CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
 CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
+CONFIG_SND_SEQUENCER=y
 CONFIG_SND_PXA2XX_AC97=y
 CONFIG_SND_USB_AUDIO=m
 # CONFIG_USB_HID is not set
@@ -191,8 +190,6 @@ CONFIG_NFSD=y
 CONFIG_NFSD_V4=y
 CONFIG_SMB_FS=m
 CONFIG_CIFS=m
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_LDM_PARTITION=y
 CONFIG_NLS_DEFAULT="iso8859-15"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
@@ -200,9 +197,6 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_USER=y
 CONFIG_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_PCBC=m
@@ -212,3 +206,9 @@ CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRC_CCITT=y
 CONFIG_CRC16=y
 CONFIG_LIBCRC32C=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index a352207a64d7..3bdc217667a6 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -21,6 +20,7 @@ CONFIG_NEON=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
+# CONFIG_SWAP is not set
 CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index c2d79a67f81f..67e3f9138306 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -4,7 +4,6 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_VERSATILE=y
 CONFIG_AEABI=y
@@ -15,6 +14,7 @@ CONFIG_VFP=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_SLAB=y
 CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -88,8 +88,8 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
+CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index 947987730eb7..acfe53205780 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -28,7 +28,6 @@ CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_CMA=y
 CONFIG_NET=y
@@ -56,6 +55,7 @@ CONFIG_MTD_UBI=y
 CONFIG_VIRTIO_BLK=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_SCSI_VIRTIO=y
 CONFIG_ATA=y
 CONFIG_NETDEVICES=y
@@ -136,8 +136,8 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_CRYPTO_HW is not set
 CONFIG_DMA_CMA=y
 CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index 70fdbfd83484..2e47cc57a928 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -16,9 +16,9 @@ CONFIG_FLASH_SIZE=0x01000000
 CONFIG_CMDLINE="console=/dev/ttyLP2"
 CONFIG_XIP_KERNEL=y
 CONFIG_XIP_PHYS_ADDR=0x0f000080
+# CONFIG_SUSPEND is not set
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
-# CONFIG_SUSPEND is not set
 # CONFIG_UEVENT_HELPER is not set
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_defconfig
index 7c1029716ea5..3ef71a2cd602 100644
--- a/arch/arm/configs/viper_defconfig
+++ b/arch/arm/configs/viper_defconfig
@@ -1,20 +1,13 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=13
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
 # CONFIG_SHMEM is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_VIPER=y
 CONFIG_IWMMXT=y
-CONFIG_PCCARD=m
-CONFIG_PCMCIA_PXA2XX=m
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -26,6 +19,11 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=m
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_FPE_FASTFPE=y
 CONFIG_PM=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_SWAP is not set
+CONFIG_SLAB=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -41,6 +39,8 @@ CONFIG_BT_BNEP=m
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_H4=y
 CONFIG_BT_HCIUART_BCSP=y
+CONFIG_PCCARD=m
+CONFIG_PCMCIA_PXA2XX=m
 CONFIG_FW_LOADER=m
 CONFIG_MTD=y
 CONFIG_MTD_REDBOOT_PARTS=y
@@ -61,20 +61,21 @@ CONFIG_MTD_PXA2XX=y
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=m
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=m
 # CONFIG_SATA_PMP is not set
 CONFIG_PATA_PCMCIA=m
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_ASYNC=m
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
 CONFIG_NET_PCMCIA=y
-CONFIG_PPP=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_INPUT_MOUSEDEV=m
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=m
@@ -94,12 +95,12 @@ CONFIG_INPUT_MISC=y
 CONFIG_INPUT_UINPUT=m
 # CONFIG_CONSOLE_TRANSLATIONS is not set
 # CONFIG_VT_CONSOLE is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=m
 CONFIG_SERIAL_8250_NR_UARTS=5
 CONFIG_SERIAL_8250_RUNTIME_UARTS=5
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_HELPER_AUTO is not set
@@ -146,16 +147,15 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
+CONFIG_CRC_T10DIF=m
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_FTRACE is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_ARC4=m
-CONFIG_CRC_T10DIF=m
diff --git a/arch/arm/configs/vt8500_v6_v7_defconfig b/arch/arm/configs/vt8500_v6_v7_defconfig
index 9b85326ba287..cb8d38e9562a 100644
--- a/arch/arm/configs/vt8500_v6_v7_defconfig
+++ b/arch/arm/configs/vt8500_v6_v7_defconfig
@@ -50,8 +50,8 @@ CONFIG_I2C_WMT=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_WM8750=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
-CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_SUPPLY=y
 CONFIG_MFD_SYSCON=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
diff --git a/arch/arm/configs/xcep_defconfig b/arch/arm/configs/xcep_defconfig
index 3752672f980e..9c2f039fc09a 100644
--- a/arch/arm/configs/xcep_defconfig
+++ b/arch/arm/configs/xcep_defconfig
@@ -1,6 +1,8 @@
 CONFIG_LOCALVERSION=".xcep-itech"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
@@ -10,26 +12,24 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
 # CONFIG_SHMEM is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLOB=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLOCK is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_XCEP=y
 CONFIG_IWMMXT=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=mtd4 rootfstype=jffs2 ro console=ttyS0,115200"
 CONFIG_FPE_NWFPE=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+# CONFIG_BLOCK is not set
+CONFIG_SLOB=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
@@ -54,9 +54,9 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=m
 CONFIG_I2C_CHARDEV=m
@@ -78,13 +78,13 @@ CONFIG_NFS_V3=y
 CONFIG_NLS=m
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_UTF8=m
+# CONFIG_CRYPTO_HW is not set
+CONFIG_LIBCRC32C=m
 CONFIG_PRINTK_TIME=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
 # CONFIG_ARM_UNWIND is not set
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
-CONFIG_LIBCRC32C=m
diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defconfig
index 03a12fb51259..9a72be595fce 100644
--- a/arch/arm/configs/zeus_defconfig
+++ b/arch/arm/configs/zeus_defconfig
@@ -1,14 +1,9 @@
 CONFIG_SYSVIPC=y
 CONFIG_TINY_RCU=y
 CONFIG_LOG_BUF_SHIFT=13
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_ARCOM_ZEUS=y
-CONFIG_PCCARD=m
-CONFIG_PCMCIA_PXA2XX=m
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -21,6 +16,9 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_APM_EMULATION=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -39,6 +37,8 @@ CONFIG_BT_HCIUART_BCSP=y
 CONFIG_CFG80211=m
 CONFIG_LIB80211=m
 CONFIG_MAC80211=m
+CONFIG_PCCARD=m
+CONFIG_PCMCIA_PXA2XX=m
 CONFIG_MTD=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_REDBOOT_PARTS_READONLY=y
@@ -59,21 +59,22 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_EEPROM_AT24=m
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=m
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=m
 # CONFIG_SATA_PMP is not set
 CONFIG_PATA_PCMCIA=m
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_DM9000=y
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_ASYNC=m
 CONFIG_HERMES=m
 CONFIG_PCMCIA_HERMES=m
 CONFIG_RT2X00=m
 CONFIG_RT73USB=m
 CONFIG_NET_PCMCIA=y
-CONFIG_PPP=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=m
 # CONFIG_INPUT_KEYBOARD is not set
@@ -90,11 +91,11 @@ CONFIG_TOUCHSCREEN_TOUCHWIN=m
 CONFIG_TOUCHSCREEN_TOUCHIT213=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_UINPUT=m
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=7
 CONFIG_SERIAL_8250_RUNTIME_UARTS=7
-# CONFIG_LEGACY_PTYS is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_HELPER_AUTO is not set
@@ -161,14 +162,13 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_CRC_T10DIF=m
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=m
-- 
2.29.2

