Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B9B5674BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiGEQqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGEQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:46:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F56713DE4;
        Tue,  5 Jul 2022 09:46:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CB5D2204F0;
        Tue,  5 Jul 2022 16:46:35 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A68D22C141;
        Tue,  5 Jul 2022 16:46:35 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Remove VR41xx support
Date:   Tue,  5 Jul 2022 18:46:25 +0200
Message-Id: <20220705164632.97942-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No (active) developer owns this hardware, so let's remove Linux support.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/Kbuild.platforms              |   1 -
 arch/mips/Kconfig                       |  23 -
 arch/mips/Makefile                      |   1 -
 arch/mips/configs/capcella_defconfig    |  91 ---
 arch/mips/configs/e55_defconfig         |  37 --
 arch/mips/configs/mpc30x_defconfig      |  53 --
 arch/mips/configs/tb0219_defconfig      |  76 ---
 arch/mips/configs/tb0226_defconfig      |  71 ---
 arch/mips/configs/tb0287_defconfig      |  84 ---
 arch/mips/configs/workpad_defconfig     |  67 ---
 arch/mips/include/asm/cpu-type.h        |  11 -
 arch/mips/include/asm/cpu.h             |   3 +-
 arch/mips/include/asm/mach-vr41xx/irq.h |   9 -
 arch/mips/include/asm/mipsregs.h        |  14 -
 arch/mips/include/asm/pgtable-32.h      |   5 -
 arch/mips/include/asm/pgtable-64.h      |   5 -
 arch/mips/include/asm/vermagic.h        |   2 -
 arch/mips/include/asm/vr41xx/capcella.h |  30 -
 arch/mips/include/asm/vr41xx/giu.h      |  41 --
 arch/mips/include/asm/vr41xx/irq.h      |  97 ----
 arch/mips/include/asm/vr41xx/mpc30x.h   |  24 -
 arch/mips/include/asm/vr41xx/pci.h      |  77 ---
 arch/mips/include/asm/vr41xx/siu.h      |  45 --
 arch/mips/include/asm/vr41xx/tb0219.h   |  29 -
 arch/mips/include/asm/vr41xx/tb0226.h   |  30 -
 arch/mips/include/asm/vr41xx/tb0287.h   |  30 -
 arch/mips/include/asm/vr41xx/vr41xx.h   | 148 -----
 arch/mips/kernel/cpu-probe.c            |  40 --
 arch/mips/lib/dump_tlb.c                |   8 -
 arch/mips/mm/c-r4k.c                    |  44 --
 arch/mips/mm/tlbex.c                    |  35 --
 arch/mips/pci/Makefile                  |   6 -
 arch/mips/pci/fixup-capcella.c          |  37 --
 arch/mips/pci/fixup-mpc30x.c            |  36 --
 arch/mips/pci/fixup-tb0219.c            |  38 --
 arch/mips/pci/fixup-tb0226.c            |  73 ---
 arch/mips/pci/fixup-tb0287.c            |  52 --
 arch/mips/pci/ops-vr41xx.c              | 113 ----
 arch/mips/pci/pci-vr41xx.c              | 309 ----------
 arch/mips/pci/pci-vr41xx.h              | 141 -----
 arch/mips/vr41xx/Kconfig                | 104 ----
 arch/mips/vr41xx/Makefile               |   5 -
 arch/mips/vr41xx/Platform               |  29 -
 arch/mips/vr41xx/casio-e55/Makefile     |   6 -
 arch/mips/vr41xx/casio-e55/setup.c      |  27 -
 arch/mips/vr41xx/common/Makefile        |   6 -
 arch/mips/vr41xx/common/bcu.c           | 210 -------
 arch/mips/vr41xx/common/cmu.c           | 242 --------
 arch/mips/vr41xx/common/giu.c           | 110 ----
 arch/mips/vr41xx/common/icu.c           | 714 ------------------------
 arch/mips/vr41xx/common/init.c          |  60 --
 arch/mips/vr41xx/common/irq.c           | 106 ----
 arch/mips/vr41xx/common/pmu.c           | 123 ----
 arch/mips/vr41xx/common/rtc.c           | 105 ----
 arch/mips/vr41xx/common/siu.c           | 142 -----
 arch/mips/vr41xx/common/type.c          |  11 -
 arch/mips/vr41xx/ibm-workpad/Makefile   |   6 -
 arch/mips/vr41xx/ibm-workpad/setup.c    |  27 -
 58 files changed, 1 insertion(+), 4068 deletions(-)
 delete mode 100644 arch/mips/configs/capcella_defconfig
 delete mode 100644 arch/mips/configs/e55_defconfig
 delete mode 100644 arch/mips/configs/mpc30x_defconfig
 delete mode 100644 arch/mips/configs/tb0219_defconfig
 delete mode 100644 arch/mips/configs/tb0226_defconfig
 delete mode 100644 arch/mips/configs/tb0287_defconfig
 delete mode 100644 arch/mips/configs/workpad_defconfig
 delete mode 100644 arch/mips/include/asm/mach-vr41xx/irq.h
 delete mode 100644 arch/mips/include/asm/vr41xx/capcella.h
 delete mode 100644 arch/mips/include/asm/vr41xx/giu.h
 delete mode 100644 arch/mips/include/asm/vr41xx/irq.h
 delete mode 100644 arch/mips/include/asm/vr41xx/mpc30x.h
 delete mode 100644 arch/mips/include/asm/vr41xx/pci.h
 delete mode 100644 arch/mips/include/asm/vr41xx/siu.h
 delete mode 100644 arch/mips/include/asm/vr41xx/tb0219.h
 delete mode 100644 arch/mips/include/asm/vr41xx/tb0226.h
 delete mode 100644 arch/mips/include/asm/vr41xx/tb0287.h
 delete mode 100644 arch/mips/include/asm/vr41xx/vr41xx.h
 delete mode 100644 arch/mips/pci/fixup-capcella.c
 delete mode 100644 arch/mips/pci/fixup-mpc30x.c
 delete mode 100644 arch/mips/pci/fixup-tb0219.c
 delete mode 100644 arch/mips/pci/fixup-tb0226.c
 delete mode 100644 arch/mips/pci/fixup-tb0287.c
 delete mode 100644 arch/mips/pci/ops-vr41xx.c
 delete mode 100644 arch/mips/pci/pci-vr41xx.c
 delete mode 100644 arch/mips/pci/pci-vr41xx.h
 delete mode 100644 arch/mips/vr41xx/Kconfig
 delete mode 100644 arch/mips/vr41xx/Makefile
 delete mode 100644 arch/mips/vr41xx/Platform
 delete mode 100644 arch/mips/vr41xx/casio-e55/Makefile
 delete mode 100644 arch/mips/vr41xx/casio-e55/setup.c
 delete mode 100644 arch/mips/vr41xx/common/Makefile
 delete mode 100644 arch/mips/vr41xx/common/bcu.c
 delete mode 100644 arch/mips/vr41xx/common/cmu.c
 delete mode 100644 arch/mips/vr41xx/common/giu.c
 delete mode 100644 arch/mips/vr41xx/common/icu.c
 delete mode 100644 arch/mips/vr41xx/common/init.c
 delete mode 100644 arch/mips/vr41xx/common/irq.c
 delete mode 100644 arch/mips/vr41xx/common/pmu.c
 delete mode 100644 arch/mips/vr41xx/common/rtc.c
 delete mode 100644 arch/mips/vr41xx/common/siu.c
 delete mode 100644 arch/mips/vr41xx/common/type.c
 delete mode 100644 arch/mips/vr41xx/ibm-workpad/Makefile
 delete mode 100644 arch/mips/vr41xx/ibm-workpad/setup.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 1bc4282af064..5d04438ee12e 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -33,7 +33,6 @@ platform-$(CONFIG_SIBYTE_BCM1x55)	+= sibyte/
 platform-$(CONFIG_SIBYTE_BCM1x80)	+= sibyte/
 platform-$(CONFIG_SNI_RM)		+= sni/
 platform-$(CONFIG_MACH_TX49XX)		+= txx9/
-platform-$(CONFIG_MACH_VR41XX)		+= vr41xx/
 
 # include the platform specific files
 include $(patsubst %/, $(srctree)/arch/mips/%/Platform, $(platform-y))
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index db09d45d59ec..8db38817320b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -588,14 +588,6 @@ config MACH_PIC32
 	  Microchip PIC32 is a family of general-purpose 32 bit MIPS core
 	  microcontrollers.
 
-config MACH_VR41XX
-	bool "NEC VR4100 series based machines"
-	select CEVT_R4K
-	select CSRC_R4K
-	select SYS_HAS_CPU_VR41XX
-	select SYS_SUPPORTS_MIPS16
-	select GPIOLIB
-
 config MACH_NINTENDO64
 	bool "Nintendo 64 console"
 	select CEVT_R4K
@@ -1012,7 +1004,6 @@ source "arch/mips/ralink/Kconfig"
 source "arch/mips/sgi-ip27/Kconfig"
 source "arch/mips/sibyte/Kconfig"
 source "arch/mips/txx9/Kconfig"
-source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/cavium-octeon/Kconfig"
 source "arch/mips/loongson2ef/Kconfig"
 source "arch/mips/loongson32/Kconfig"
@@ -1579,17 +1570,6 @@ config CPU_R3000
 	  might be a safe bet.  If the resulting kernel does not work,
 	  try to recompile with R3000.
 
-config CPU_VR41XX
-	bool "R41xx"
-	depends on SYS_HAS_CPU_VR41XX
-	select CPU_SUPPORTS_32BIT_KERNEL
-	select CPU_SUPPORTS_64BIT_KERNEL
-	help
-	  The options selects support for the NEC VR4100 series of processors.
-	  Only choose this option if you have one of these processors as a
-	  kernel built with this option will not run on any other type of
-	  processor or vice versa.
-
 config CPU_R4300
 	bool "R4300"
 	depends on SYS_HAS_CPU_R4300
@@ -1905,9 +1885,6 @@ config SYS_HAS_CPU_P5600
 config SYS_HAS_CPU_R3000
 	bool
 
-config SYS_HAS_CPU_VR41XX
-	bool
-
 config SYS_HAS_CPU_R4300
 	bool
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index bb236de13133..4d2a3e73fc45 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -159,7 +159,6 @@ cflags-y += $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 #
 cflags-$(CONFIG_CPU_R3000)	+= -march=r3000
 cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
-cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
 cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R1)	+= -march=mips32 -Wa,--trap
diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
deleted file mode 100644
index 7bf8971af53b..000000000000
--- a/arch/mips/configs/capcella_defconfig
+++ /dev/null
@@ -1,91 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MACH_VR41XX=y
-CONFIG_ZAO_CAPCELLA=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=m
-CONFIG_NET_KEY=y
-CONFIG_NET_KEY_MIGRATE=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_TCP_MD5SIG=y
-# CONFIG_IPV6 is not set
-CONFIG_NETWORK_SECMARK=y
-CONFIG_IP_SCTP=m
-CONFIG_FW_LOADER=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_ATA=y
-CONFIG_PATA_LEGACY=y
-CONFIG_NETDEVICES=y
-CONFIG_8139TOO=y
-CONFIG_PHYLIB=m
-CONFIG_CICADA_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_MARVELL_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_SMSC_PHY=m
-CONFIG_VITESSE_PHY=m
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_VR41XX=y
-CONFIG_SERIAL_VR41XX_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_GPIO_VR41XX=y
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_VR41XX=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-CONFIG_AUTOFS4_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_LRW=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_CAMELLIA=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_FCRYPT=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_DEFLATE=m
-# CONFIG_CRYPTO_HW is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="mem=32M console=ttyVR0,38400"
diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
deleted file mode 100644
index fd82b858a8f0..000000000000
--- a/arch/mips/configs/e55_defconfig
+++ /dev/null
@@ -1,37 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MACH_VR41XX=y
-CONFIG_CASIO_E55=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_ATA=y
-CONFIG_PATA_LEGACY=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_VR41XX=y
-CONFIG_SERIAL_VR41XX_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_GPIO_VR41XX=y
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_VR41XX=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-CONFIG_AUTOFS4_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyVR0,19200 ide0=0x1f0,0x3f6,40 mem=8M"
diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
deleted file mode 100644
index d4e038802510..000000000000
--- a/arch/mips/configs/mpc30x_defconfig
+++ /dev/null
@@ -1,53 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_RELAY=y
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MACH_VR41XX=y
-CONFIG_VICTOR_MPC30X=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=m
-CONFIG_NET_KEY=y
-CONFIG_NET_KEY_MIGRATE=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-# CONFIG_IPV6 is not set
-CONFIG_NETWORK_SECMARK=y
-CONFIG_CONNECTOR=m
-CONFIG_ATA_OVER_ETH=m
-CONFIG_BLK_DEV_SD=y
-CONFIG_ATA=y
-CONFIG_PATA_LEGACY=y
-CONFIG_NETDEVICES=y
-CONFIG_USB_PEGASUS=m
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_VR41XX=y
-CONFIG_SERIAL_VR41XX_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_GPIO_VR41XX=y
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_USB=m
-CONFIG_USB_OHCI_HCD=m
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_VR41XX=y
-CONFIG_EXT2_FS=y
-CONFIG_AUTOFS4_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_CONFIGFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="mem=32M console=ttyVR0,19200 ide0=0x170,0x376,73"
diff --git a/arch/mips/configs/tb0219_defconfig b/arch/mips/configs/tb0219_defconfig
deleted file mode 100644
index c56d8ab14ba6..000000000000
--- a/arch/mips/configs/tb0219_defconfig
+++ /dev/null
@@ -1,76 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MACH_VR41XX=y
-CONFIG_TANBAC_TB0219=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_NET_IPIP=m
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_IPV6 is not set
-CONFIG_NETWORK_SECMARK=y
-CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_NETDEVICES=y
-CONFIG_8139TOO=y
-CONFIG_R8169=y
-CONFIG_VIA_RHINE=y
-CONFIG_VIA_RHINE_MMIO=y
-CONFIG_VIA_VELOCITY=y
-CONFIG_CICADA_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_MARVELL_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_SMSC_PHY=m
-CONFIG_VITESSE_PHY=m
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_VR41XX=y
-CONFIG_SERIAL_VR41XX_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_GPIO_TB0219=y
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_USB=m
-CONFIG_USB_MON=m
-CONFIG_USB_EHCI_HCD=m
-# CONFIG_USB_EHCI_TT_NEWSCHED is not set
-CONFIG_USB_OHCI_HCD=m
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_VR41XX=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-CONFIG_AUTOFS4_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CRAMFS=m
-CONFIG_ROMFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="cca=3 mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
deleted file mode 100644
index 6e1423428f02..000000000000
--- a/arch/mips/configs/tb0226_defconfig
+++ /dev/null
@@ -1,71 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MACH_VR41XX=y
-CONFIG_TANBAC_TB0226=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_IPV6 is not set
-CONFIG_NETWORK_SECMARK=y
-CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_SCSI=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_SCAN_ASYNC=y
-CONFIG_SCSI_SAS_LIBSAS=m
-# CONFIG_SCSI_LOWLEVEL is not set
-CONFIG_NETDEVICES=y
-CONFIG_E100=y
-CONFIG_USB_CATC=m
-CONFIG_USB_KAWETH=m
-CONFIG_USB_PEGASUS=m
-CONFIG_USB_RTL8150=m
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_VR41XX=y
-CONFIG_SERIAL_VR41XX_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_USB=y
-CONFIG_USB_EHCI_HCD=y
-# CONFIG_USB_EHCI_TT_NEWSCHED is not set
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_ACM=y
-CONFIG_USB_STORAGE=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_VR41XX=y
-CONFIG_EXT2_FS=y
-CONFIG_AUTOFS4_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CRAMFS=m
-CONFIG_ROMFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=m
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="cca=3 mem=32M console=ttyVR0,115200"
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
deleted file mode 100644
index cf65a0879ece..000000000000
--- a/arch/mips/configs/tb0287_defconfig
+++ /dev/null
@@ -1,84 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MACH_VR41XX=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_NET_IPIP=m
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-CONFIG_TCP_CONG_ADVANCED=y
-CONFIG_TCP_CONG_BIC=y
-CONFIG_TCP_CONG_CUBIC=m
-# CONFIG_IPV6 is not set
-CONFIG_NETWORK_SECMARK=y
-CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_SCAN_ASYNC=y
-# CONFIG_SCSI_LOWLEVEL is not set
-CONFIG_ATA=y
-CONFIG_PATA_SIL680=y
-CONFIG_NETDEVICES=y
-CONFIG_8139TOO=y
-CONFIG_R8169=y
-CONFIG_VIA_RHINE=y
-CONFIG_VIA_RHINE_MMIO=y
-CONFIG_VIA_VELOCITY=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_SERIAL_VR41XX=y
-CONFIG_SERIAL_VR41XX_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_GPIO_VR41XX=y
-# CONFIG_HWMON is not set
-CONFIG_MFD_SM501=y
-CONFIG_FB=y
-CONFIG_FB_SM501=y
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_USB=m
-CONFIG_USB_MON=m
-CONFIG_USB_EHCI_HCD=m
-# CONFIG_USB_EHCI_TT_NEWSCHED is not set
-CONFIG_USB_OHCI_HCD=m
-CONFIG_USB_STORAGE=m
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-CONFIG_XFS_FS=y
-CONFIG_XFS_QUOTA=y
-CONFIG_XFS_POSIX_ACL=y
-CONFIG_AUTOFS4_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CRAMFS=m
-CONFIG_ROMFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=m
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="cca=3 mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
deleted file mode 100644
index 7e16da0bde8c..000000000000
--- a/arch/mips/configs/workpad_defconfig
+++ /dev/null
@@ -1,67 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MACH_VR41XX=y
-CONFIG_IBM_WORKPAD=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_VRC4171=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=m
-CONFIG_NET_KEY=y
-CONFIG_NET_KEY_MIGRATE=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_IPV6 is not set
-CONFIG_NETWORK_SECMARK=y
-CONFIG_BLK_DEV_RAM=m
-# CONFIG_SCSI_PROC_FS is not set
-# CONFIG_SCSI_LOWLEVEL is not set
-CONFIG_ATA=y
-# CONFIG_ATA_VERBOSE_ERROR is not set
-# CONFIG_ATA_FORCE is not set
-# CONFIG_ATA_BMDMA is not set
-CONFIG_NETDEVICES=y
-CONFIG_PCMCIA_3C574=m
-CONFIG_PCMCIA_3C589=m
-CONFIG_PCMCIA_NMCLAN=m
-CONFIG_PCMCIA_FMVJ18X=m
-CONFIG_PCMCIA_AXNET=m
-CONFIG_PCMCIA_PCNET=m
-CONFIG_PCMCIA_SMC91C92=m
-CONFIG_PCMCIA_XIRC2PS=m
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_VR41XX=y
-CONFIG_SERIAL_VR41XX_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_GPIO_VR41XX=y
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_VR41XX=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT3_FS=y
-CONFIG_AUTOFS4_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_NFS_FS=m
-CONFIG_NFSD=m
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyVR0,19200 ide0=0x170,0x376,49 mem=16M"
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 5582ff0c247e..a4a66bd93748 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -105,17 +105,6 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_R3081E:
 #endif
 
-#ifdef CONFIG_SYS_HAS_CPU_VR41XX
-	case CPU_VR41XX:
-	case CPU_VR4111:
-	case CPU_VR4121:
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-	case CPU_VR4181:
-	case CPU_VR4181A:
-#endif
-
 #ifdef CONFIG_SYS_HAS_CPU_R4300
 	case CPU_R4300:
 	case CPU_R4310:
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 00a3fc7d778d..ecb9854cb432 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -305,8 +305,7 @@ enum cpu_type_enum {
 	CPU_R4000PC, CPU_R4000SC, CPU_R4000MC, CPU_R4200, CPU_R4300, CPU_R4310,
 	CPU_R4400PC, CPU_R4400SC, CPU_R4400MC, CPU_R4600, CPU_R4640, CPU_R4650,
 	CPU_R4700, CPU_R5000, CPU_R5500, CPU_NEVADA, CPU_R10000,
-	CPU_R12000, CPU_R14000, CPU_R16000, CPU_VR41XX, CPU_VR4111, CPU_VR4121,
-	CPU_VR4122, CPU_VR4131, CPU_VR4133, CPU_VR4181, CPU_VR4181A, CPU_RM7000,
+	CPU_R12000, CPU_R14000, CPU_R16000, CPU_RM7000,
 	CPU_SR71000, CPU_TX49XX,
 
 	/*
diff --git a/arch/mips/include/asm/mach-vr41xx/irq.h b/arch/mips/include/asm/mach-vr41xx/irq.h
deleted file mode 100644
index 4281b2b9344d..000000000000
--- a/arch/mips/include/asm/mach-vr41xx/irq.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_MACH_VR41XX_IRQ_H
-#define __ASM_MACH_VR41XX_IRQ_H
-
-#include <asm/vr41xx/irq.h> /* for MIPS_CPU_IRQ_BASE */
-
-#include <asm/mach-generic/irq.h>
-
-#endif /* __ASM_MACH_VR41XX_IRQ_H */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 305651af15b3..99eeafe6dcab 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -164,18 +164,6 @@
 /*
  * Values for PageMask register
  */
-#ifdef CONFIG_CPU_VR41XX
-
-/* Why doesn't stupidity hurt ... */
-
-#define PM_1K		0x00000000
-#define PM_4K		0x00001800
-#define PM_16K		0x00007800
-#define PM_64K		0x0001f800
-#define PM_256K		0x0007f800
-
-#else
-
 #define PM_4K		0x00000000
 #define PM_8K		0x00002000
 #define PM_16K		0x00006000
@@ -194,8 +182,6 @@
 #define PM_256M		0x1fffe000
 #define PM_1G		0x7fffe000
 
-#endif
-
 /*
  * Default page size for a given kernel configuration
  */
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 95df9c293d8d..c4964c86600a 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -185,14 +185,9 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 #else
 
 #define MAX_POSSIBLE_PHYSMEM_BITS 32
-#ifdef CONFIG_CPU_VR41XX
-#define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
-#define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
-#else
 #define pte_pfn(x)		((unsigned long)((x).pte >> _PFN_SHIFT))
 #define pfn_pte(pfn, prot)	__pte(((unsigned long long)(pfn) << _PFN_SHIFT) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot)	__pmd(((unsigned long long)(pfn) << _PFN_SHIFT) | pgprot_val(prot))
-#endif
 #endif /* defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32) */
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 41921acdc9d8..fd051c24d314 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -303,14 +303,9 @@ static inline void pud_clear(pud_t *pudp)
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
-#ifdef CONFIG_CPU_VR41XX
-#define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
-#define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
-#else
 #define pte_pfn(x)		((unsigned long)((x).pte >> _PFN_SHIFT))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
-#endif
 
 #ifndef __PAGETABLE_PMD_FOLDED
 static inline pmd_t *pud_pgtable(pud_t pud)
diff --git a/arch/mips/include/asm/vermagic.h b/arch/mips/include/asm/vermagic.h
index 1c33922eb945..7645f77c8272 100644
--- a/arch/mips/include/asm/vermagic.h
+++ b/arch/mips/include/asm/vermagic.h
@@ -22,8 +22,6 @@
 #define MODULE_PROC_FAMILY "MIPS64_R6 "
 #elif defined CONFIG_CPU_R3000
 #define MODULE_PROC_FAMILY "R3000 "
-#elif defined CONFIG_CPU_VR41XX
-#define MODULE_PROC_FAMILY "VR41XX "
 #elif defined CONFIG_CPU_R4300
 #define MODULE_PROC_FAMILY "R4300 "
 #elif defined CONFIG_CPU_R4X00
diff --git a/arch/mips/include/asm/vr41xx/capcella.h b/arch/mips/include/asm/vr41xx/capcella.h
deleted file mode 100644
index d45a33969951..000000000000
--- a/arch/mips/include/asm/vr41xx/capcella.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  capcella.h, Include file for ZAO Networks Capcella.
- *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#ifndef __ZAO_CAPCELLA_H
-#define __ZAO_CAPCELLA_H
-
-#include <asm/vr41xx/irq.h>
-
-/*
- * General-Purpose I/O Pin Number
- */
-#define PC104PLUS_INTA_PIN		2
-#define PC104PLUS_INTB_PIN		3
-#define PC104PLUS_INTC_PIN		4
-#define PC104PLUS_INTD_PIN		5
-
-/*
- * Interrupt Number
- */
-#define RTL8139_1_IRQ			GIU_IRQ(PC104PLUS_INTC_PIN)
-#define RTL8139_2_IRQ			GIU_IRQ(PC104PLUS_INTD_PIN)
-#define PC104PLUS_INTA_IRQ		GIU_IRQ(PC104PLUS_INTA_PIN)
-#define PC104PLUS_INTB_IRQ		GIU_IRQ(PC104PLUS_INTB_PIN)
-#define PC104PLUS_INTC_IRQ		GIU_IRQ(PC104PLUS_INTC_PIN)
-#define PC104PLUS_INTD_IRQ		GIU_IRQ(PC104PLUS_INTD_PIN)
-
-#endif /* __ZAO_CAPCELLA_H */
diff --git a/arch/mips/include/asm/vr41xx/giu.h b/arch/mips/include/asm/vr41xx/giu.h
deleted file mode 100644
index 0211fa89897a..000000000000
--- a/arch/mips/include/asm/vr41xx/giu.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Include file for NEC VR4100 series General-purpose I/O Unit.
- *
- *  Copyright (C) 2005-2009  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#ifndef __NEC_VR41XX_GIU_H
-#define __NEC_VR41XX_GIU_H
-
-/*
- * NEC VR4100 series GIU platform device IDs.
- */
-enum {
-	GPIO_50PINS_PULLUPDOWN,
-	GPIO_36PINS,
-	GPIO_48PINS_EDGE_SELECT,
-};
-
-typedef enum {
-	IRQ_TRIGGER_LEVEL,
-	IRQ_TRIGGER_EDGE,
-	IRQ_TRIGGER_EDGE_FALLING,
-	IRQ_TRIGGER_EDGE_RISING,
-} irq_trigger_t;
-
-typedef enum {
-	IRQ_SIGNAL_THROUGH,
-	IRQ_SIGNAL_HOLD,
-} irq_signal_t;
-
-extern void vr41xx_set_irq_trigger(unsigned int pin, irq_trigger_t trigger,
-				   irq_signal_t signal);
-
-typedef enum {
-	IRQ_LEVEL_LOW,
-	IRQ_LEVEL_HIGH,
-} irq_level_t;
-
-extern void vr41xx_set_irq_level(unsigned int pin, irq_level_t level);
-
-#endif /* __NEC_VR41XX_GIU_H */
diff --git a/arch/mips/include/asm/vr41xx/irq.h b/arch/mips/include/asm/vr41xx/irq.h
deleted file mode 100644
index 2f3d552f9566..000000000000
--- a/arch/mips/include/asm/vr41xx/irq.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * include/asm-mips/vr41xx/irq.h
- *
- * Interrupt numbers for NEC VR4100 series.
- *
- * Copyright (C) 1999 Michael Klar
- * Copyright (C) 2001, 2002 Paul Mundt
- * Copyright (C) 2002 MontaVista Software, Inc.
- * Copyright (C) 2002 TimeSys Corp.
- * Copyright (C) 2003-2006 Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#ifndef __NEC_VR41XX_IRQ_H
-#define __NEC_VR41XX_IRQ_H
-
-/*
- * CPU core Interrupt Numbers
- */
-#define MIPS_CPU_IRQ_BASE	0
-#define MIPS_CPU_IRQ(x)		(MIPS_CPU_IRQ_BASE + (x))
-#define MIPS_SOFTINT0_IRQ	MIPS_CPU_IRQ(0)
-#define MIPS_SOFTINT1_IRQ	MIPS_CPU_IRQ(1)
-#define INT0_IRQ		MIPS_CPU_IRQ(2)
-#define INT1_IRQ		MIPS_CPU_IRQ(3)
-#define INT2_IRQ		MIPS_CPU_IRQ(4)
-#define INT3_IRQ		MIPS_CPU_IRQ(5)
-#define INT4_IRQ		MIPS_CPU_IRQ(6)
-#define TIMER_IRQ		MIPS_CPU_IRQ(7)
-
-/*
- * SYINT1 Interrupt Numbers
- */
-#define SYSINT1_IRQ_BASE	8
-#define SYSINT1_IRQ(x)		(SYSINT1_IRQ_BASE + (x))
-#define BATTRY_IRQ		SYSINT1_IRQ(0)
-#define POWER_IRQ		SYSINT1_IRQ(1)
-#define RTCLONG1_IRQ		SYSINT1_IRQ(2)
-#define ELAPSEDTIME_IRQ		SYSINT1_IRQ(3)
-/* RFU */
-#define PIU_IRQ			SYSINT1_IRQ(5)
-#define AIU_IRQ			SYSINT1_IRQ(6)
-#define KIU_IRQ			SYSINT1_IRQ(7)
-#define GIUINT_IRQ		SYSINT1_IRQ(8)
-#define SIU_IRQ			SYSINT1_IRQ(9)
-#define BUSERR_IRQ		SYSINT1_IRQ(10)
-#define SOFTINT_IRQ		SYSINT1_IRQ(11)
-#define CLKRUN_IRQ		SYSINT1_IRQ(12)
-#define DOZEPIU_IRQ		SYSINT1_IRQ(13)
-#define SYSINT1_IRQ_LAST	DOZEPIU_IRQ
-
-/*
- * SYSINT2 Interrupt Numbers
- */
-#define SYSINT2_IRQ_BASE	24
-#define SYSINT2_IRQ(x)		(SYSINT2_IRQ_BASE + (x))
-#define RTCLONG2_IRQ		SYSINT2_IRQ(0)
-#define LED_IRQ			SYSINT2_IRQ(1)
-#define HSP_IRQ			SYSINT2_IRQ(2)
-#define TCLOCK_IRQ		SYSINT2_IRQ(3)
-#define FIR_IRQ			SYSINT2_IRQ(4)
-#define CEU_IRQ			SYSINT2_IRQ(4)	/* same number as FIR_IRQ */
-#define DSIU_IRQ		SYSINT2_IRQ(5)
-#define PCI_IRQ			SYSINT2_IRQ(6)
-#define SCU_IRQ			SYSINT2_IRQ(7)
-#define CSI_IRQ			SYSINT2_IRQ(8)
-#define BCU_IRQ			SYSINT2_IRQ(9)
-#define ETHERNET_IRQ		SYSINT2_IRQ(10)
-#define SYSINT2_IRQ_LAST	ETHERNET_IRQ
-
-/*
- * GIU Interrupt Numbers
- */
-#define GIU_IRQ_BASE		40
-#define GIU_IRQ(x)		(GIU_IRQ_BASE + (x))	/* IRQ 40-71 */
-#define GIU_IRQ_LAST		GIU_IRQ(31)
-
-/*
- * VRC4173 Interrupt Numbers
- */
-#define VRC4173_IRQ_BASE	72
-#define VRC4173_IRQ(x)		(VRC4173_IRQ_BASE + (x))
-#define VRC4173_USB_IRQ		VRC4173_IRQ(0)
-#define VRC4173_PCMCIA2_IRQ	VRC4173_IRQ(1)
-#define VRC4173_PCMCIA1_IRQ	VRC4173_IRQ(2)
-#define VRC4173_PS2CH2_IRQ	VRC4173_IRQ(3)
-#define VRC4173_PS2CH1_IRQ	VRC4173_IRQ(4)
-#define VRC4173_PIU_IRQ		VRC4173_IRQ(5)
-#define VRC4173_AIU_IRQ		VRC4173_IRQ(6)
-#define VRC4173_KIU_IRQ		VRC4173_IRQ(7)
-#define VRC4173_GIU_IRQ		VRC4173_IRQ(8)
-#define VRC4173_AC97_IRQ	VRC4173_IRQ(9)
-#define VRC4173_AC97INT1_IRQ	VRC4173_IRQ(10)
-/* RFU */
-#define VRC4173_DOZEPIU_IRQ	VRC4173_IRQ(13)
-#define VRC4173_IRQ_LAST	VRC4173_DOZEPIU_IRQ
-
-#endif /* __NEC_VR41XX_IRQ_H */
diff --git a/arch/mips/include/asm/vr41xx/mpc30x.h b/arch/mips/include/asm/vr41xx/mpc30x.h
deleted file mode 100644
index 9f977e18d72f..000000000000
--- a/arch/mips/include/asm/vr41xx/mpc30x.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  mpc30x.h, Include file for Victor MP-C303/304.
- *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#ifndef __VICTOR_MPC30X_H
-#define __VICTOR_MPC30X_H
-
-#include <asm/vr41xx/irq.h>
-
-/*
- * General-Purpose I/O Pin Number
- */
-#define VRC4173_PIN			1
-#define MQ200_PIN			4
-
-/*
- * Interrupt Number
- */
-#define VRC4173_CASCADE_IRQ		GIU_IRQ(VRC4173_PIN)
-#define MQ200_IRQ			GIU_IRQ(MQ200_PIN)
-
-#endif /* __VICTOR_MPC30X_H */
diff --git a/arch/mips/include/asm/vr41xx/pci.h b/arch/mips/include/asm/vr41xx/pci.h
deleted file mode 100644
index ad93b5e89017..000000000000
--- a/arch/mips/include/asm/vr41xx/pci.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Include file for NEC VR4100 series PCI Control Unit.
- *
- *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#ifndef __NEC_VR41XX_PCI_H
-#define __NEC_VR41XX_PCI_H
-
-#define PCI_MASTER_ADDRESS_MASK 0x7fffffffU
-
-struct pci_master_address_conversion {
-	uint32_t bus_base_address;
-	uint32_t address_mask;
-	uint32_t pci_base_address;
-};
-
-struct pci_target_address_conversion {
-	uint32_t address_mask;
-	uint32_t bus_base_address;
-};
-
-typedef enum {
-	CANNOT_LOCK_FROM_DEVICE,
-	CAN_LOCK_FROM_DEVICE,
-} pci_exclusive_access_t;
-
-struct pci_mailbox_address {
-	uint32_t base_address;
-};
-
-struct pci_target_address_window {
-	uint32_t base_address;
-};
-
-typedef enum {
-	PCI_ARBITRATION_MODE_FAIR,
-	PCI_ARBITRATION_MODE_ALTERNATE_0,
-	PCI_ARBITRATION_MODE_ALTERNATE_B,
-} pci_arbiter_priority_control_t;
-
-typedef enum {
-	PCI_TAKE_AWAY_GNT_DISABLE,
-	PCI_TAKE_AWAY_GNT_ENABLE,
-} pci_take_away_gnt_mode_t;
-
-struct pci_controller_unit_setup {
-	struct pci_master_address_conversion *master_memory1;
-	struct pci_master_address_conversion *master_memory2;
-
-	struct pci_target_address_conversion *target_memory1;
-	struct pci_target_address_conversion *target_memory2;
-
-	struct pci_master_address_conversion *master_io;
-
-	pci_exclusive_access_t exclusive_access;
-
-	uint32_t pci_clock_max;
-	uint8_t wait_time_limit_from_irdy_to_trdy;	/* Only VR4122 is supported */
-
-	struct pci_mailbox_address *mailbox;
-	struct pci_target_address_window *target_window1;
-	struct pci_target_address_window *target_window2;
-
-	uint8_t master_latency_timer;
-	uint8_t retry_limit;
-
-	pci_arbiter_priority_control_t arbiter_priority_control;
-	pci_take_away_gnt_mode_t take_away_gnt_mode;
-
-	struct resource *mem_resource;
-	struct resource *io_resource;
-};
-
-extern void vr41xx_pciu_setup(struct pci_controller_unit_setup *setup);
-
-#endif /* __NEC_VR41XX_PCI_H */
diff --git a/arch/mips/include/asm/vr41xx/siu.h b/arch/mips/include/asm/vr41xx/siu.h
deleted file mode 100644
index e920cd2cf8b2..000000000000
--- a/arch/mips/include/asm/vr41xx/siu.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Include file for NEC VR4100 series Serial Interface Unit.
- *
- *  Copyright (C) 2005-2008  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#ifndef __NEC_VR41XX_SIU_H
-#define __NEC_VR41XX_SIU_H
-
-#define SIU_PORTS_MAX 2
-
-typedef enum {
-	SIU_INTERFACE_RS232C,
-	SIU_INTERFACE_IRDA,
-} siu_interface_t;
-
-extern void vr41xx_select_siu_interface(siu_interface_t interface);
-
-typedef enum {
-	SIU_USE_IRDA,
-	FIR_USE_IRDA,
-} irda_use_t;
-
-extern void vr41xx_use_irda(irda_use_t use);
-
-typedef enum {
-	SHARP_IRDA,
-	TEMIC_IRDA,
-	HP_IRDA,
-} irda_module_t;
-
-typedef enum {
-	IRDA_TX_1_5MBPS,
-	IRDA_TX_4MBPS,
-} irda_speed_t;
-
-extern void vr41xx_select_irda_module(irda_module_t module, irda_speed_t speed);
-
-#ifdef CONFIG_SERIAL_VR41XX_CONSOLE
-extern void vr41xx_siu_early_setup(struct uart_port *port);
-#else
-static inline void vr41xx_siu_early_setup(struct uart_port *port) {}
-#endif
-
-#endif /* __NEC_VR41XX_SIU_H */
diff --git a/arch/mips/include/asm/vr41xx/tb0219.h b/arch/mips/include/asm/vr41xx/tb0219.h
deleted file mode 100644
index 01e96d6c2dbd..000000000000
--- a/arch/mips/include/asm/vr41xx/tb0219.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  tb0219.h, Include file for TANBAC TB0219.
- *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@linux-mips.org>
- *
- *  Modified for TANBAC TB0219:
- *  Copyright (C) 2003 Megasolution Inc.  <matsu@megasolution.jp>
- */
-#ifndef __TANBAC_TB0219_H
-#define __TANBAC_TB0219_H
-
-#include <asm/vr41xx/irq.h>
-
-/*
- * General-Purpose I/O Pin Number
- */
-#define TB0219_PCI_SLOT1_PIN		2
-#define TB0219_PCI_SLOT2_PIN		3
-#define TB0219_PCI_SLOT3_PIN		4
-
-/*
- * Interrupt Number
- */
-#define TB0219_PCI_SLOT1_IRQ		GIU_IRQ(TB0219_PCI_SLOT1_PIN)
-#define TB0219_PCI_SLOT2_IRQ		GIU_IRQ(TB0219_PCI_SLOT2_PIN)
-#define TB0219_PCI_SLOT3_IRQ		GIU_IRQ(TB0219_PCI_SLOT3_PIN)
-
-#endif /* __TANBAC_TB0219_H */
diff --git a/arch/mips/include/asm/vr41xx/tb0226.h b/arch/mips/include/asm/vr41xx/tb0226.h
deleted file mode 100644
index 64993d14916d..000000000000
--- a/arch/mips/include/asm/vr41xx/tb0226.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  tb0226.h, Include file for TANBAC TB0226.
- *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#ifndef __TANBAC_TB0226_H
-#define __TANBAC_TB0226_H
-
-#include <asm/vr41xx/irq.h>
-
-/*
- * General-Purpose I/O Pin Number
- */
-#define GD82559_1_PIN			2
-#define GD82559_2_PIN			3
-#define UPD720100_INTA_PIN		4
-#define UPD720100_INTB_PIN		8
-#define UPD720100_INTC_PIN		13
-
-/*
- * Interrupt Number
- */
-#define GD82559_1_IRQ			GIU_IRQ(GD82559_1_PIN)
-#define GD82559_2_IRQ			GIU_IRQ(GD82559_2_PIN)
-#define UPD720100_INTA_IRQ		GIU_IRQ(UPD720100_INTA_PIN)
-#define UPD720100_INTB_IRQ		GIU_IRQ(UPD720100_INTB_PIN)
-#define UPD720100_INTC_IRQ		GIU_IRQ(UPD720100_INTC_PIN)
-
-#endif /* __TANBAC_TB0226_H */
diff --git a/arch/mips/include/asm/vr41xx/tb0287.h b/arch/mips/include/asm/vr41xx/tb0287.h
deleted file mode 100644
index 3ddc913860d5..000000000000
--- a/arch/mips/include/asm/vr41xx/tb0287.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  tb0287.h, Include file for TANBAC TB0287 mini-ITX board.
- *
- *  Copyright (C) 2005	Media Lab Inc. <ito@mlb.co.jp>
- *
- *  This code is largely based on tb0219.h.
- */
-#ifndef __TANBAC_TB0287_H
-#define __TANBAC_TB0287_H
-
-#include <asm/vr41xx/irq.h>
-
-/*
- * General-Purpose I/O Pin Number
- */
-#define TB0287_PCI_SLOT_PIN		2
-#define TB0287_SM501_PIN		3
-#define TB0287_SIL680A_PIN		8
-#define TB0287_RTL8110_PIN		13
-
-/*
- * Interrupt Number
- */
-#define TB0287_PCI_SLOT_IRQ		GIU_IRQ(TB0287_PCI_SLOT_PIN)
-#define TB0287_SM501_IRQ		GIU_IRQ(TB0287_SM501_PIN)
-#define TB0287_SIL680A_IRQ		GIU_IRQ(TB0287_SIL680A_PIN)
-#define TB0287_RTL8110_IRQ		GIU_IRQ(TB0287_RTL8110_PIN)
-
-#endif /* __TANBAC_TB0287_H */
diff --git a/arch/mips/include/asm/vr41xx/vr41xx.h b/arch/mips/include/asm/vr41xx/vr41xx.h
deleted file mode 100644
index 9a4b36b756e2..000000000000
--- a/arch/mips/include/asm/vr41xx/vr41xx.h
+++ /dev/null
@@ -1,148 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * include/asm-mips/vr41xx/vr41xx.h
- *
- * Include file for NEC VR4100 series.
- *
- * Copyright (C) 1999 Michael Klar
- * Copyright (C) 2001, 2002 Paul Mundt
- * Copyright (C) 2002 MontaVista Software, Inc.
- * Copyright (C) 2002 TimeSys Corp.
- * Copyright (C) 2003-2008 Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#ifndef __NEC_VR41XX_H
-#define __NEC_VR41XX_H
-
-#include <linux/interrupt.h>
-
-/*
- * CPU Revision
- */
-/* VR4122 0x00000c70-0x00000c72 */
-#define PRID_VR4122_REV1_0	0x00000c70
-#define PRID_VR4122_REV2_0	0x00000c70
-#define PRID_VR4122_REV2_1	0x00000c70
-#define PRID_VR4122_REV3_0	0x00000c71
-#define PRID_VR4122_REV3_1	0x00000c72
-
-/* VR4181A 0x00000c73-0x00000c7f */
-#define PRID_VR4181A_REV1_0	0x00000c73
-#define PRID_VR4181A_REV1_1	0x00000c74
-
-/* VR4131 0x00000c80-0x00000c83 */
-#define PRID_VR4131_REV1_2	0x00000c80
-#define PRID_VR4131_REV2_0	0x00000c81
-#define PRID_VR4131_REV2_1	0x00000c82
-#define PRID_VR4131_REV2_2	0x00000c83
-
-/* VR4133 0x00000c84- */
-#define PRID_VR4133		0x00000c84
-
-/*
- * Bus Control Uint
- */
-extern unsigned long vr41xx_calculate_clock_frequency(void);
-extern unsigned long vr41xx_get_vtclock_frequency(void);
-extern unsigned long vr41xx_get_tclock_frequency(void);
-
-/*
- * Clock Mask Unit
- */
-typedef enum {
-	PIU_CLOCK,
-	SIU_CLOCK,
-	AIU_CLOCK,
-	KIU_CLOCK,
-	FIR_CLOCK,
-	DSIU_CLOCK,
-	CSI_CLOCK,
-	PCIU_CLOCK,
-	HSP_CLOCK,
-	PCI_CLOCK,
-	CEU_CLOCK,
-	ETHER0_CLOCK,
-	ETHER1_CLOCK
-} vr41xx_clock_t;
-
-extern void vr41xx_supply_clock(vr41xx_clock_t clock);
-extern void vr41xx_mask_clock(vr41xx_clock_t clock);
-
-/*
- * Interrupt Control Unit
- */
-extern int vr41xx_set_intassign(unsigned int irq, unsigned char intassign);
-extern int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int));
-
-#define PIUINT_COMMAND		0x0040
-#define PIUINT_DATA		0x0020
-#define PIUINT_PAGE1		0x0010
-#define PIUINT_PAGE0		0x0008
-#define PIUINT_DATALOST		0x0004
-#define PIUINT_STATUSCHANGE	0x0001
-
-extern void vr41xx_enable_piuint(uint16_t mask);
-extern void vr41xx_disable_piuint(uint16_t mask);
-
-#define AIUINT_INPUT_DMAEND	0x0800
-#define AIUINT_INPUT_DMAHALT	0x0400
-#define AIUINT_INPUT_DATALOST	0x0200
-#define AIUINT_INPUT_DATA	0x0100
-#define AIUINT_OUTPUT_DMAEND	0x0008
-#define AIUINT_OUTPUT_DMAHALT	0x0004
-#define AIUINT_OUTPUT_NODATA	0x0002
-
-extern void vr41xx_enable_aiuint(uint16_t mask);
-extern void vr41xx_disable_aiuint(uint16_t mask);
-
-#define KIUINT_DATALOST		0x0004
-#define KIUINT_DATAREADY	0x0002
-#define KIUINT_SCAN		0x0001
-
-extern void vr41xx_enable_kiuint(uint16_t mask);
-extern void vr41xx_disable_kiuint(uint16_t mask);
-
-#define DSIUINT_CTS		0x0800
-#define DSIUINT_RXERR		0x0400
-#define DSIUINT_RX		0x0200
-#define DSIUINT_TX		0x0100
-#define DSIUINT_ALL		0x0f00
-
-extern void vr41xx_enable_dsiuint(uint16_t mask);
-extern void vr41xx_disable_dsiuint(uint16_t mask);
-
-#define FIRINT_UNIT		0x0010
-#define FIRINT_RX_DMAEND	0x0008
-#define FIRINT_RX_DMAHALT	0x0004
-#define FIRINT_TX_DMAEND	0x0002
-#define FIRINT_TX_DMAHALT	0x0001
-
-extern void vr41xx_enable_firint(uint16_t mask);
-extern void vr41xx_disable_firint(uint16_t mask);
-
-extern void vr41xx_enable_pciint(void);
-extern void vr41xx_disable_pciint(void);
-
-extern void vr41xx_enable_scuint(void);
-extern void vr41xx_disable_scuint(void);
-
-#define CSIINT_TX_DMAEND	0x0040
-#define CSIINT_TX_DMAHALT	0x0020
-#define CSIINT_TX_DATA		0x0010
-#define CSIINT_TX_FIFOEMPTY	0x0008
-#define CSIINT_RX_DMAEND	0x0004
-#define CSIINT_RX_DMAHALT	0x0002
-#define CSIINT_RX_FIFOEMPTY	0x0001
-
-extern void vr41xx_enable_csiint(uint16_t mask);
-extern void vr41xx_disable_csiint(uint16_t mask);
-
-extern void vr41xx_enable_bcuint(void);
-extern void vr41xx_disable_bcuint(void);
-
-#ifdef CONFIG_SERIAL_VR41XX_CONSOLE
-extern void vr41xx_siu_setup(void);
-#else
-static inline void vr41xx_siu_setup(void) {}
-#endif
-
-#endif /* __NEC_VR41XX_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d510f628ee03..7ddf07f255f3 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1115,46 +1115,6 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
-	case PRID_IMP_VR41XX:
-		set_isa(c, MIPS_CPU_ISA_III);
-		c->fpu_msk31 |= FPU_CSR_CONDX;
-		c->options = R4K_OPTS;
-		c->tlbsize = 32;
-		switch (c->processor_id & 0xf0) {
-		case PRID_REV_VR4111:
-			c->cputype = CPU_VR4111;
-			__cpu_name[cpu] = "NEC VR4111";
-			break;
-		case PRID_REV_VR4121:
-			c->cputype = CPU_VR4121;
-			__cpu_name[cpu] = "NEC VR4121";
-			break;
-		case PRID_REV_VR4122:
-			if ((c->processor_id & 0xf) < 0x3) {
-				c->cputype = CPU_VR4122;
-				__cpu_name[cpu] = "NEC VR4122";
-			} else {
-				c->cputype = CPU_VR4181A;
-				__cpu_name[cpu] = "NEC VR4181A";
-			}
-			break;
-		case PRID_REV_VR4130:
-			if ((c->processor_id & 0xf) < 0x4) {
-				c->cputype = CPU_VR4131;
-				__cpu_name[cpu] = "NEC VR4131";
-			} else {
-				c->cputype = CPU_VR4133;
-				c->options |= MIPS_CPU_LLSC;
-				__cpu_name[cpu] = "NEC VR4133";
-			}
-			break;
-		default:
-			printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
-			c->cputype = CPU_VR41XX;
-			__cpu_name[cpu] = "NEC Vr41xx";
-			break;
-		}
-		break;
 	case PRID_IMP_R4300:
 		c->cputype = CPU_R4300;
 		__cpu_name[cpu] = "R4300";
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 4256423632c4..8ce97b8741fd 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -58,14 +58,6 @@ static inline const char *msk2str(unsigned int mask)
 	case PM_2M:	return "2Mb";
 	case PM_8M:	return "8Mb";
 	case PM_32M:	return "32Mb";
-#endif
-#ifndef CONFIG_CPU_VR41XX
-	case PM_1M:	return "1Mb";
-	case PM_4M:	return "4Mb";
-	case PM_16M:	return "16Mb";
-	case PM_64M:	return "64Mb";
-	case PM_256M:	return "256Mb";
-	case PM_1G:	return "1Gb";
 #endif
 	}
 	return "";
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ccb9e47322b0..a549fa98c2f4 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1194,50 +1194,6 @@ static void probe_pcache(void)
 		c->options |= MIPS_CPU_PREFETCH;
 		break;
 
-	case CPU_VR4133:
-		write_c0_config(config & ~VR41_CONF_P4K);
-		fallthrough;
-	case CPU_VR4131:
-		/* Workaround for cache instruction bug of VR4131 */
-		if (c->processor_id == 0x0c80U || c->processor_id == 0x0c81U ||
-		    c->processor_id == 0x0c82U) {
-			config |= 0x00400000U;
-			if (c->processor_id == 0x0c80U)
-				config |= VR41_CONF_BP;
-			write_c0_config(config);
-		} else
-			c->options |= MIPS_CPU_CACHE_CDEX_P;
-
-		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
-		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
-		c->icache.ways = 2;
-		c->icache.waybit = __ffs(icache_size/2);
-
-		dcache_size = 1 << (10 + ((config & CONF_DC) >> 6));
-		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
-		c->dcache.ways = 2;
-		c->dcache.waybit = __ffs(dcache_size/2);
-		break;
-
-	case CPU_VR41XX:
-	case CPU_VR4111:
-	case CPU_VR4121:
-	case CPU_VR4122:
-	case CPU_VR4181:
-	case CPU_VR4181A:
-		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
-		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
-		c->icache.ways = 1;
-		c->icache.waybit = 0;	/* doesn't matter */
-
-		dcache_size = 1 << (10 + ((config & CONF_DC) >> 6));
-		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
-		c->dcache.ways = 1;
-		c->dcache.waybit = 0;	/* does not matter */
-
-		c->options |= MIPS_CPU_CACHE_CDEX_P;
-		break;
-
 	case CPU_RM7000:
 		rm7k_erratum31();
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 8dbbd99fc7e8..e09a64fe3e94 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -586,25 +586,6 @@ void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		tlbw(p);
 		break;
 
-	case CPU_VR4111:
-	case CPU_VR4121:
-	case CPU_VR4122:
-	case CPU_VR4181:
-	case CPU_VR4181A:
-		uasm_i_nop(p);
-		uasm_i_nop(p);
-		tlbw(p);
-		uasm_i_nop(p);
-		uasm_i_nop(p);
-		break;
-
-	case CPU_VR4131:
-	case CPU_VR4133:
-		uasm_i_nop(p);
-		uasm_i_nop(p);
-		tlbw(p);
-		break;
-
 	case CPU_XBURST:
 		tlbw(p);
 		uasm_i_nop(p);
@@ -995,22 +976,6 @@ static void build_adjust_context(u32 **p, unsigned int ctx)
 	unsigned int shift = 4 - (PTE_T_LOG2 + 1) + PAGE_SHIFT - 12;
 	unsigned int mask = (PTRS_PER_PTE / 2 - 1) << (PTE_T_LOG2 + 1);
 
-	switch (current_cpu_type()) {
-	case CPU_VR41XX:
-	case CPU_VR4111:
-	case CPU_VR4121:
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4181:
-	case CPU_VR4181A:
-	case CPU_VR4133:
-		shift += 2;
-		break;
-
-	default:
-		break;
-	}
-
 	if (shift)
 		UASM_i_SRL(p, ctx, ctx, shift);
 	uasm_i_andi(p, ctx, ctx, mask);
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index ed0388485a15..a6e9785b537e 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_PCI_DRIVERS_GENERIC)+= pci-generic.o
 obj-$(CONFIG_MIPS_BONITO64)	+= ops-bonito64.o
 obj-$(CONFIG_PCI_GT64XXX_PCI0)	+= ops-gt64xxx_pci0.o
 obj-$(CONFIG_MIPS_MSC)		+= ops-msc.o
-obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
 obj-$(CONFIG_PCI_TX4927)	+= ops-tx4927.o
 obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
@@ -42,14 +41,9 @@ obj-$(CONFIG_PCI_LANTIQ)	+= pci-lantiq.o ops-lantiq.o
 obj-$(CONFIG_SOC_MT7620)	+= pci-mt7620.o
 obj-$(CONFIG_SOC_RT288X)	+= pci-rt2880.o
 obj-$(CONFIG_SOC_RT3883)	+= pci-rt3883.o
-obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
-obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
-obj-$(CONFIG_TANBAC_TB0287)	+= fixup-tb0287.o
 obj-$(CONFIG_SOC_TX4927)	+= pci-tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= pci-tx4938.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o
-obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
-obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_MIKROTIK_RB532)	+= pci-rc32434.o ops-rc32434.o fixup-rc32434.o
 obj-$(CONFIG_CAVIUM_OCTEON_SOC) += pci-octeon.o pcie-octeon.o
 
diff --git a/arch/mips/pci/fixup-capcella.c b/arch/mips/pci/fixup-capcella.c
deleted file mode 100644
index dc8cd98a1761..000000000000
--- a/arch/mips/pci/fixup-capcella.c
+++ /dev/null
@@ -1,37 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  fixup-cappcela.c, The ZAO Networks Capcella specific PCI fixups.
- *
- *  Copyright (C) 2002,2004  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <asm/vr41xx/capcella.h>
-
-/*
- * Shortcuts
- */
-#define INT1	RTL8139_1_IRQ
-#define INT2	RTL8139_2_IRQ
-#define INTA	PC104PLUS_INTA_IRQ
-#define INTB	PC104PLUS_INTB_IRQ
-#define INTC	PC104PLUS_INTC_IRQ
-#define INTD	PC104PLUS_INTD_IRQ
-
-static char irq_tab_capcella[][5] = {
- [11] = { -1, INT1, INT1, INT1, INT1 },
- [12] = { -1, INT2, INT2, INT2, INT2 },
- [14] = { -1, INTA, INTB, INTC, INTD }
-};
-
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	return irq_tab_capcella[slot][pin];
-}
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-mpc30x.c b/arch/mips/pci/fixup-mpc30x.c
deleted file mode 100644
index 27c75f268c4c..000000000000
--- a/arch/mips/pci/fixup-mpc30x.c
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  fixup-mpc30x.c, The Victor MP-C303/304 specific PCI fixups.
- *
- *  Copyright (C) 2002,2004  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <asm/vr41xx/mpc30x.h>
-
-static const int internal_func_irqs[] = {
-	VRC4173_CASCADE_IRQ,
-	VRC4173_AC97_IRQ,
-	VRC4173_USB_IRQ,
-};
-
-static const int irq_tab_mpc30x[] = {
- [12] = VRC4173_PCMCIA1_IRQ,
- [13] = VRC4173_PCMCIA2_IRQ,
- [29] = MQ200_IRQ,
-};
-
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	if (slot == 30)
-		return internal_func_irqs[PCI_FUNC(dev->devfn)];
-
-	return irq_tab_mpc30x[slot];
-}
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-tb0219.c b/arch/mips/pci/fixup-tb0219.c
deleted file mode 100644
index 43942998599b..000000000000
--- a/arch/mips/pci/fixup-tb0219.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  fixup-tb0219.c, The TANBAC TB0219 specific PCI fixups.
- *
- *  Copyright (C) 2003	Megasolution Inc. <matsu@megasolution.jp>
- *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <asm/vr41xx/tb0219.h>
-
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int irq = -1;
-
-	switch (slot) {
-	case 12:
-		irq = TB0219_PCI_SLOT1_IRQ;
-		break;
-	case 13:
-		irq = TB0219_PCI_SLOT2_IRQ;
-		break;
-	case 14:
-		irq = TB0219_PCI_SLOT3_IRQ;
-		break;
-	default:
-		break;
-	}
-
-	return irq;
-}
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-tb0226.c b/arch/mips/pci/fixup-tb0226.c
deleted file mode 100644
index a4d1efadfd4a..000000000000
--- a/arch/mips/pci/fixup-tb0226.c
+++ /dev/null
@@ -1,73 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  fixup-tb0226.c, The TANBAC TB0226 specific PCI fixups.
- *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <asm/vr41xx/giu.h>
-#include <asm/vr41xx/tb0226.h>
-
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int irq = -1;
-
-	switch (slot) {
-	case 12:
-		vr41xx_set_irq_trigger(GD82559_1_PIN,
-				       IRQ_TRIGGER_LEVEL,
-				       IRQ_SIGNAL_THROUGH);
-		vr41xx_set_irq_level(GD82559_1_PIN, IRQ_LEVEL_LOW);
-		irq = GD82559_1_IRQ;
-		break;
-	case 13:
-		vr41xx_set_irq_trigger(GD82559_2_PIN,
-				       IRQ_TRIGGER_LEVEL,
-				       IRQ_SIGNAL_THROUGH);
-		vr41xx_set_irq_level(GD82559_2_PIN, IRQ_LEVEL_LOW);
-		irq = GD82559_2_IRQ;
-		break;
-	case 14:
-		switch (pin) {
-		case 1:
-			vr41xx_set_irq_trigger(UPD720100_INTA_PIN,
-					       IRQ_TRIGGER_LEVEL,
-					       IRQ_SIGNAL_THROUGH);
-			vr41xx_set_irq_level(UPD720100_INTA_PIN,
-					     IRQ_LEVEL_LOW);
-			irq = UPD720100_INTA_IRQ;
-			break;
-		case 2:
-			vr41xx_set_irq_trigger(UPD720100_INTB_PIN,
-					       IRQ_TRIGGER_LEVEL,
-					       IRQ_SIGNAL_THROUGH);
-			vr41xx_set_irq_level(UPD720100_INTB_PIN,
-					     IRQ_LEVEL_LOW);
-			irq = UPD720100_INTB_IRQ;
-			break;
-		case 3:
-			vr41xx_set_irq_trigger(UPD720100_INTC_PIN,
-					       IRQ_TRIGGER_LEVEL,
-					       IRQ_SIGNAL_THROUGH);
-			vr41xx_set_irq_level(UPD720100_INTC_PIN,
-					     IRQ_LEVEL_LOW);
-			irq = UPD720100_INTC_IRQ;
-			break;
-		default:
-			break;
-		}
-		break;
-	default:
-		break;
-	}
-
-	return irq;
-}
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-tb0287.c b/arch/mips/pci/fixup-tb0287.c
deleted file mode 100644
index 721ec9ac1c76..000000000000
--- a/arch/mips/pci/fixup-tb0287.c
+++ /dev/null
@@ -1,52 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  fixup-tb0287.c, The TANBAC TB0287 specific PCI fixups.
- *
- *  Copyright (C) 2005	Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <asm/vr41xx/tb0287.h>
-
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	unsigned char bus;
-	int irq = -1;
-
-	bus = dev->bus->number;
-	if (bus == 0) {
-		switch (slot) {
-		case 16:
-			irq = TB0287_SM501_IRQ;
-			break;
-		case 17:
-			irq = TB0287_SIL680A_IRQ;
-			break;
-		default:
-			break;
-		}
-	} else if (bus == 1) {
-		switch (PCI_SLOT(dev->devfn)) {
-		case 0:
-			irq = TB0287_PCI_SLOT_IRQ;
-			break;
-		case 2:
-		case 3:
-			irq = TB0287_RTL8110_IRQ;
-			break;
-		default:
-			break;
-		}
-	} else if (bus > 1) {
-		irq = TB0287_PCI_SLOT_IRQ;
-	}
-
-	return irq;
-}
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/ops-vr41xx.c b/arch/mips/pci/ops-vr41xx.c
deleted file mode 100644
index 7b7709aa14c7..000000000000
--- a/arch/mips/pci/ops-vr41xx.c
+++ /dev/null
@@ -1,113 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  ops-vr41xx.c, PCI configuration routines for the PCIU of NEC VR4100 series.
- *
- *  Copyright (C) 2001-2003 MontaVista Software Inc.
- *    Author: Yoichi Yuasa <source@mvista.com>
- *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
- */
-#include <linux/pci.h>
-#include <linux/types.h>
-
-#include <asm/io.h>
-
-#define PCICONFDREG	(void __iomem *)KSEG1ADDR(0x0f000c14)
-#define PCICONFAREG	(void __iomem *)KSEG1ADDR(0x0f000c18)
-
-static inline int set_pci_configuration_address(unsigned char number,
-						unsigned int devfn, int where)
-{
-	if (number == 0) {
-		/*
-		 * Type 0 configuration
-		 */
-		if (PCI_SLOT(devfn) < 11 || where > 0xff)
-			return -EINVAL;
-
-		writel((1U << PCI_SLOT(devfn)) | (PCI_FUNC(devfn) << 8) |
-		       (where & 0xfc), PCICONFAREG);
-	} else {
-		/*
-		 * Type 1 configuration
-		 */
-		if (where > 0xff)
-			return -EINVAL;
-
-		writel(((uint32_t)number << 16) | ((devfn & 0xff) << 8) |
-		       (where & 0xfc) | 1U, PCICONFAREG);
-	}
-
-	return 0;
-}
-
-static int pci_config_read(struct pci_bus *bus, unsigned int devfn, int where,
-			   int size, uint32_t *val)
-{
-	uint32_t data;
-
-	*val = 0xffffffffU;
-	if (set_pci_configuration_address(bus->number, devfn, where) < 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	data = readl(PCICONFDREG);
-
-	switch (size) {
-	case 1:
-		*val = (data >> ((where & 3) << 3)) & 0xffU;
-		break;
-	case 2:
-		*val = (data >> ((where & 2) << 3)) & 0xffffU;
-		break;
-	case 4:
-		*val = data;
-		break;
-	default:
-		return PCIBIOS_FUNC_NOT_SUPPORTED;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pci_config_write(struct pci_bus *bus, unsigned int devfn, int where,
-			    int size, uint32_t val)
-{
-	uint32_t data;
-	int shift;
-
-	if (set_pci_configuration_address(bus->number, devfn, where) < 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	data = readl(PCICONFDREG);
-
-	switch (size) {
-	case 1:
-		shift = (where & 3) << 3;
-		data &= ~(0xffU << shift);
-		data |= ((val & 0xffU) << shift);
-		break;
-	case 2:
-		shift = (where & 2) << 3;
-		data &= ~(0xffffU << shift);
-		data |= ((val & 0xffffU) << shift);
-		break;
-	case 4:
-		data = val;
-		break;
-	default:
-		return PCIBIOS_FUNC_NOT_SUPPORTED;
-	}
-
-	writel(data, PCICONFDREG);
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-struct pci_ops vr41xx_pci_ops = {
-	.read	= pci_config_read,
-	.write	= pci_config_write,
-};
diff --git a/arch/mips/pci/pci-vr41xx.c b/arch/mips/pci/pci-vr41xx.c
deleted file mode 100644
index 4f250c55b6e6..000000000000
--- a/arch/mips/pci/pci-vr41xx.c
+++ /dev/null
@@ -1,309 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  pci-vr41xx.c, PCI Control Unit routines for the NEC VR4100 series.
- *
- *  Copyright (C) 2001-2003 MontaVista Software Inc.
- *    Author: Yoichi Yuasa <source@mvista.com>
- *  Copyright (C) 2004-2008  Yoichi Yuasa <yuasa@linux-mips.org>
- *  Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/types.h>
-
-#include <asm/cpu.h>
-#include <asm/io.h>
-#include <asm/vr41xx/pci.h>
-#include <asm/vr41xx/vr41xx.h>
-
-#include "pci-vr41xx.h"
-
-extern struct pci_ops vr41xx_pci_ops;
-
-static void __iomem *pciu_base;
-
-#define pciu_read(offset)		readl(pciu_base + (offset))
-#define pciu_write(offset, value)	writel((value), pciu_base + (offset))
-
-static struct pci_master_address_conversion pci_master_memory1 = {
-	.bus_base_address	= PCI_MASTER_MEM1_BUS_BASE_ADDRESS,
-	.address_mask		= PCI_MASTER_MEM1_ADDRESS_MASK,
-	.pci_base_address	= PCI_MASTER_MEM1_PCI_BASE_ADDRESS,
-};
-
-static struct pci_target_address_conversion pci_target_memory1 = {
-	.address_mask		= PCI_TARGET_MEM1_ADDRESS_MASK,
-	.bus_base_address	= PCI_TARGET_MEM1_BUS_BASE_ADDRESS,
-};
-
-static struct pci_master_address_conversion pci_master_io = {
-	.bus_base_address	= PCI_MASTER_IO_BUS_BASE_ADDRESS,
-	.address_mask		= PCI_MASTER_IO_ADDRESS_MASK,
-	.pci_base_address	= PCI_MASTER_IO_PCI_BASE_ADDRESS,
-};
-
-static struct pci_mailbox_address pci_mailbox = {
-	.base_address		= PCI_MAILBOX_BASE_ADDRESS,
-};
-
-static struct pci_target_address_window pci_target_window1 = {
-	.base_address		= PCI_TARGET_WINDOW1_BASE_ADDRESS,
-};
-
-static struct resource pci_mem_resource = {
-	.name	= "PCI Memory resources",
-	.start	= PCI_MEM_RESOURCE_START,
-	.end	= PCI_MEM_RESOURCE_END,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct resource pci_io_resource = {
-	.name	= "PCI I/O resources",
-	.start	= PCI_IO_RESOURCE_START,
-	.end	= PCI_IO_RESOURCE_END,
-	.flags	= IORESOURCE_IO,
-};
-
-static struct pci_controller_unit_setup vr41xx_pci_controller_unit_setup = {
-	.master_memory1				= &pci_master_memory1,
-	.target_memory1				= &pci_target_memory1,
-	.master_io				= &pci_master_io,
-	.exclusive_access			= CANNOT_LOCK_FROM_DEVICE,
-	.wait_time_limit_from_irdy_to_trdy	= 0,
-	.mailbox				= &pci_mailbox,
-	.target_window1				= &pci_target_window1,
-	.master_latency_timer			= 0x80,
-	.retry_limit				= 0,
-	.arbiter_priority_control		= PCI_ARBITRATION_MODE_FAIR,
-	.take_away_gnt_mode			= PCI_TAKE_AWAY_GNT_DISABLE,
-};
-
-static struct pci_controller vr41xx_pci_controller = {
-	.pci_ops	= &vr41xx_pci_ops,
-	.mem_resource	= &pci_mem_resource,
-	.io_resource	= &pci_io_resource,
-};
-
-void __init vr41xx_pciu_setup(struct pci_controller_unit_setup *setup)
-{
-	vr41xx_pci_controller_unit_setup = *setup;
-}
-
-static int __init vr41xx_pciu_init(void)
-{
-	struct pci_controller_unit_setup *setup;
-	struct pci_master_address_conversion *master;
-	struct pci_target_address_conversion *target;
-	struct pci_mailbox_address *mailbox;
-	struct pci_target_address_window *window;
-	unsigned long vtclock, pci_clock_max;
-	uint32_t val;
-
-	setup = &vr41xx_pci_controller_unit_setup;
-
-	if (request_mem_region(PCIU_BASE, PCIU_SIZE, "PCIU") == NULL)
-		return -EBUSY;
-
-	pciu_base = ioremap(PCIU_BASE, PCIU_SIZE);
-	if (pciu_base == NULL) {
-		release_mem_region(PCIU_BASE, PCIU_SIZE);
-		return -EBUSY;
-	}
-
-	/* Disable PCI interrupt */
-	vr41xx_disable_pciint();
-
-	/* Supply VTClock to PCIU */
-	vr41xx_supply_clock(PCIU_CLOCK);
-
-	/* Dummy write, waiting for supply of VTClock. */
-	vr41xx_disable_pciint();
-
-	/* Select PCI clock */
-	if (setup->pci_clock_max != 0)
-		pci_clock_max = setup->pci_clock_max;
-	else
-		pci_clock_max = PCI_CLOCK_MAX;
-	vtclock = vr41xx_get_vtclock_frequency();
-	if (vtclock < pci_clock_max)
-		pciu_write(PCICLKSELREG, EQUAL_VTCLOCK);
-	else if ((vtclock / 2) < pci_clock_max)
-		pciu_write(PCICLKSELREG, HALF_VTCLOCK);
-	else if (current_cpu_data.processor_id >= PRID_VR4131_REV2_1 &&
-		 (vtclock / 3) < pci_clock_max)
-		pciu_write(PCICLKSELREG, ONE_THIRD_VTCLOCK);
-	else if ((vtclock / 4) < pci_clock_max)
-		pciu_write(PCICLKSELREG, QUARTER_VTCLOCK);
-	else {
-		printk(KERN_ERR "PCI Clock is over 33MHz.\n");
-		iounmap(pciu_base);
-		return -EINVAL;
-	}
-
-	/* Supply PCI clock by PCI bus */
-	vr41xx_supply_clock(PCI_CLOCK);
-
-	if (setup->master_memory1 != NULL) {
-		master = setup->master_memory1;
-		val = IBA(master->bus_base_address) |
-		      MASTER_MSK(master->address_mask) |
-		      WINEN |
-		      PCIA(master->pci_base_address);
-		pciu_write(PCIMMAW1REG, val);
-	} else {
-		val = pciu_read(PCIMMAW1REG);
-		val &= ~WINEN;
-		pciu_write(PCIMMAW1REG, val);
-	}
-
-	if (setup->master_memory2 != NULL) {
-		master = setup->master_memory2;
-		val = IBA(master->bus_base_address) |
-		      MASTER_MSK(master->address_mask) |
-		      WINEN |
-		      PCIA(master->pci_base_address);
-		pciu_write(PCIMMAW2REG, val);
-	} else {
-		val = pciu_read(PCIMMAW2REG);
-		val &= ~WINEN;
-		pciu_write(PCIMMAW2REG, val);
-	}
-
-	if (setup->target_memory1 != NULL) {
-		target = setup->target_memory1;
-		val = TARGET_MSK(target->address_mask) |
-		      WINEN |
-		      ITA(target->bus_base_address);
-		pciu_write(PCITAW1REG, val);
-	} else {
-		val = pciu_read(PCITAW1REG);
-		val &= ~WINEN;
-		pciu_write(PCITAW1REG, val);
-	}
-
-	if (setup->target_memory2 != NULL) {
-		target = setup->target_memory2;
-		val = TARGET_MSK(target->address_mask) |
-		      WINEN |
-		      ITA(target->bus_base_address);
-		pciu_write(PCITAW2REG, val);
-	} else {
-		val = pciu_read(PCITAW2REG);
-		val &= ~WINEN;
-		pciu_write(PCITAW2REG, val);
-	}
-
-	if (setup->master_io != NULL) {
-		master = setup->master_io;
-		val = IBA(master->bus_base_address) |
-		      MASTER_MSK(master->address_mask) |
-		      WINEN |
-		      PCIIA(master->pci_base_address);
-		pciu_write(PCIMIOAWREG, val);
-	} else {
-		val = pciu_read(PCIMIOAWREG);
-		val &= ~WINEN;
-		pciu_write(PCIMIOAWREG, val);
-	}
-
-	if (setup->exclusive_access == CANNOT_LOCK_FROM_DEVICE)
-		pciu_write(PCIEXACCREG, UNLOCK);
-	else
-		pciu_write(PCIEXACCREG, 0);
-
-	if (current_cpu_type() == CPU_VR4122)
-		pciu_write(PCITRDYVREG, TRDYV(setup->wait_time_limit_from_irdy_to_trdy));
-
-	pciu_write(LATTIMEREG, MLTIM(setup->master_latency_timer));
-
-	if (setup->mailbox != NULL) {
-		mailbox = setup->mailbox;
-		val = MBADD(mailbox->base_address) | TYPE_32BITSPACE |
-		      MSI_MEMORY | PREF_APPROVAL;
-		pciu_write(MAILBAREG, val);
-	}
-
-	if (setup->target_window1) {
-		window = setup->target_window1;
-		val = PMBA(window->base_address) | TYPE_32BITSPACE |
-		      MSI_MEMORY | PREF_APPROVAL;
-		pciu_write(PCIMBA1REG, val);
-	}
-
-	if (setup->target_window2) {
-		window = setup->target_window2;
-		val = PMBA(window->base_address) | TYPE_32BITSPACE |
-		      MSI_MEMORY | PREF_APPROVAL;
-		pciu_write(PCIMBA2REG, val);
-	}
-
-	val = pciu_read(RETVALREG);
-	val &= ~RTYVAL_MASK;
-	val |= RTYVAL(setup->retry_limit);
-	pciu_write(RETVALREG, val);
-
-	val = pciu_read(PCIAPCNTREG);
-	val &= ~(TKYGNT | PAPC);
-
-	switch (setup->arbiter_priority_control) {
-	case PCI_ARBITRATION_MODE_ALTERNATE_0:
-		val |= PAPC_ALTERNATE_0;
-		break;
-	case PCI_ARBITRATION_MODE_ALTERNATE_B:
-		val |= PAPC_ALTERNATE_B;
-		break;
-	default:
-		val |= PAPC_FAIR;
-		break;
-	}
-
-	if (setup->take_away_gnt_mode == PCI_TAKE_AWAY_GNT_ENABLE)
-		val |= TKYGNT_ENABLE;
-
-	pciu_write(PCIAPCNTREG, val);
-
-	pciu_write(COMMANDREG, PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-			       PCI_COMMAND_MASTER | PCI_COMMAND_PARITY |
-			       PCI_COMMAND_SERR);
-
-	/* Clear bus error */
-	pciu_read(BUSERRADREG);
-
-	pciu_write(PCIENREG, PCIU_CONFIG_DONE);
-
-	if (setup->mem_resource != NULL)
-		vr41xx_pci_controller.mem_resource = setup->mem_resource;
-
-	if (setup->io_resource != NULL) {
-		vr41xx_pci_controller.io_resource = setup->io_resource;
-	} else {
-		set_io_port_base(IO_PORT_BASE);
-		ioport_resource.start = IO_PORT_RESOURCE_START;
-		ioport_resource.end = IO_PORT_RESOURCE_END;
-	}
-
-	if (setup->master_io) {
-		void __iomem *io_map_base;
-		struct resource *res = vr41xx_pci_controller.io_resource;
-		master = setup->master_io;
-		io_map_base = ioremap(master->bus_base_address,
-				      resource_size(res));
-		if (!io_map_base) {
-			iounmap(pciu_base);
-			return -EBUSY;
-		}
-
-		vr41xx_pci_controller.io_map_base = (unsigned long)io_map_base;
-	}
-
-	register_pci_controller(&vr41xx_pci_controller);
-
-	return 0;
-}
-
-arch_initcall(vr41xx_pciu_init);
diff --git a/arch/mips/pci/pci-vr41xx.h b/arch/mips/pci/pci-vr41xx.h
deleted file mode 100644
index 5595e4a39b2a..000000000000
--- a/arch/mips/pci/pci-vr41xx.h
+++ /dev/null
@@ -1,141 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  pci-vr41xx.h, Include file for PCI Control Unit of the NEC VR4100 series.
- *
- *  Copyright (C) 2002	MontaVista Software Inc.
- *    Author: Yoichi Yuasa <source@mvista.com>
- *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#ifndef __PCI_VR41XX_H
-#define __PCI_VR41XX_H
-
-#define PCIU_BASE		0x0f000c00UL
-#define PCIU_SIZE		0x200UL
-
-#define PCIMMAW1REG		0x00
-#define PCIMMAW2REG		0x04
-#define PCITAW1REG		0x08
-#define PCITAW2REG		0x0c
-#define PCIMIOAWREG		0x10
- #define IBA(addr)		((addr) & 0xff000000U)
- #define MASTER_MSK(mask)	(((mask) >> 11) & 0x000fe000U)
- #define PCIA(addr)		(((addr) >> 24) & 0x000000ffU)
- #define TARGET_MSK(mask)	(((mask) >> 8) & 0x000fe000U)
- #define ITA(addr)		(((addr) >> 24) & 0x000000ffU)
- #define PCIIA(addr)		(((addr) >> 24) & 0x000000ffU)
- #define WINEN			0x1000U
-#define PCICONFDREG		0x14
-#define PCICONFAREG		0x18
-#define PCIMAILREG		0x1c
-#define BUSERRADREG		0x24
- #define EA(reg)		((reg) &0xfffffffc)
-
-#define INTCNTSTAREG		0x28
- #define MABTCLR		0x80000000U
- #define TRDYCLR		0x40000000U
- #define PARCLR			0x20000000U
- #define MBCLR			0x10000000U
- #define SERRCLR		0x08000000U
- #define RTYCLR			0x04000000U
- #define MABCLR			0x02000000U
- #define TABCLR			0x01000000U
- /* RFU */
- #define MABTMSK		0x00008000U
- #define TRDYMSK		0x00004000U
- #define PARMSK			0x00002000U
- #define MBMSK			0x00001000U
- #define SERRMSK		0x00000800U
- #define RTYMSK			0x00000400U
- #define MABMSK			0x00000200U
- #define TABMSK			0x00000100U
- #define IBAMABT		0x00000080U
- #define TRDYRCH		0x00000040U
- #define PAR			0x00000020U
- #define MB			0x00000010U
- #define PCISERR		0x00000008U
- #define RTYRCH			0x00000004U
- #define MABORT			0x00000002U
- #define TABORT			0x00000001U
-
-#define PCIEXACCREG		0x2c
- #define UNLOCK			0x2U
- #define EAREQ			0x1U
-#define PCIRECONTREG		0x30
- #define RTRYCNT(reg)		((reg) & 0x000000ffU)
-#define PCIENREG		0x34
- #define PCIU_CONFIG_DONE	0x4U
-#define PCICLKSELREG		0x38
- #define EQUAL_VTCLOCK		0x2U
- #define HALF_VTCLOCK		0x0U
- #define ONE_THIRD_VTCLOCK	0x3U
- #define QUARTER_VTCLOCK	0x1U
-#define PCITRDYVREG		0x3c
- #define TRDYV(val)		((uint32_t)(val) & 0xffU)
-#define PCICLKRUNREG		0x60
-
-#define VENDORIDREG		0x100
-#define DEVICEIDREG		0x100
-#define COMMANDREG		0x104
-#define STATUSREG		0x104
-#define REVIDREG		0x108
-#define CLASSREG		0x108
-#define CACHELSREG		0x10c
-#define LATTIMEREG		0x10c
- #define MLTIM(val)		(((uint32_t)(val) << 7) & 0xff00U)
-#define MAILBAREG		0x110
-#define PCIMBA1REG		0x114
-#define PCIMBA2REG		0x118
- #define MBADD(base)		((base) & 0xfffff800U)
- #define PMBA(base)		((base) & 0xffe00000U)
- #define PREF			0x8U
- #define PREF_APPROVAL		0x8U
- #define PREF_DISAPPROVAL	0x0U
- #define TYPE			0x6U
- #define TYPE_32BITSPACE	0x0U
- #define MSI			0x1U
- #define MSI_MEMORY		0x0U
-#define INTLINEREG		0x13c
-#define INTPINREG		0x13c
-#define RETVALREG		0x140
-#define PCIAPCNTREG		0x140
- #define TKYGNT			0x04000000U
- #define TKYGNT_ENABLE		0x04000000U
- #define TKYGNT_DISABLE		0x00000000U
- #define PAPC			0x03000000U
- #define PAPC_ALTERNATE_B	0x02000000U
- #define PAPC_ALTERNATE_0	0x01000000U
- #define PAPC_FAIR		0x00000000U
- #define RTYVAL(val)		(((uint32_t)(val) << 7) & 0xff00U)
- #define RTYVAL_MASK		0xff00U
-
-#define PCI_CLOCK_MAX		33333333U
-
-/*
- * Default setup
- */
-#define PCI_MASTER_MEM1_BUS_BASE_ADDRESS	0x10000000U
-#define PCI_MASTER_MEM1_ADDRESS_MASK		0x7c000000U
-#define PCI_MASTER_MEM1_PCI_BASE_ADDRESS	0x10000000U
-
-#define PCI_TARGET_MEM1_ADDRESS_MASK		0x08000000U
-#define PCI_TARGET_MEM1_BUS_BASE_ADDRESS	0x00000000U
-
-#define PCI_MASTER_IO_BUS_BASE_ADDRESS		0x16000000U
-#define PCI_MASTER_IO_ADDRESS_MASK		0x7e000000U
-#define PCI_MASTER_IO_PCI_BASE_ADDRESS		0x00000000U
-
-#define PCI_MAILBOX_BASE_ADDRESS		0x00000000U
-
-#define PCI_TARGET_WINDOW1_BASE_ADDRESS		0x00000000U
-
-#define IO_PORT_BASE		KSEG1ADDR(PCI_MASTER_IO_BUS_BASE_ADDRESS)
-#define IO_PORT_RESOURCE_START	PCI_MASTER_IO_PCI_BASE_ADDRESS
-#define IO_PORT_RESOURCE_END	(~PCI_MASTER_IO_ADDRESS_MASK & PCI_MASTER_ADDRESS_MASK)
-
-#define PCI_IO_RESOURCE_START	0x01000000UL
-#define PCI_IO_RESOURCE_END	0x01ffffffUL
-
-#define PCI_MEM_RESOURCE_START	0x11000000UL
-#define PCI_MEM_RESOURCE_END	0x13ffffffUL
-
-#endif /* __PCI_VR41XX_H */
diff --git a/arch/mips/vr41xx/Kconfig b/arch/mips/vr41xx/Kconfig
deleted file mode 100644
index e0b651db371d..000000000000
--- a/arch/mips/vr41xx/Kconfig
+++ /dev/null
@@ -1,104 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-choice
-	prompt "Machine type"
-	depends on MACH_VR41XX
-	default TANBAC_TB022X
-
-config CASIO_E55
-	bool "CASIO CASSIOPEIA E-10/15/55/65"
-	select CEVT_R4K
-	select CSRC_R4K
-	select DMA_NONCOHERENT
-	select IRQ_MIPS_CPU
-	select ISA
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config IBM_WORKPAD
-	bool "IBM WorkPad z50"
-	select CEVT_R4K
-	select CSRC_R4K
-	select DMA_NONCOHERENT
-	select IRQ_MIPS_CPU
-	select ISA
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config TANBAC_TB022X
-	bool "TANBAC VR4131 multichip module and TANBAC VR4131DIMM"
-	select CEVT_R4K
-	select CSRC_R4K
-	select DMA_NONCOHERENT
-	select IRQ_MIPS_CPU
-	select HAVE_PCI
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	help
-	  The TANBAC VR4131 multichip module(TB0225) and
-	  the TANBAC VR4131DIMM(TB0229) are MIPS-based platforms
-	  manufactured by TANBAC.
-	  Please refer to <http://www.tanbac.co.jp/>
-	  about VR4131 multichip module and VR4131DIMM.
-
-config VICTOR_MPC30X
-	bool "Victor MP-C303/304"
-	select CEVT_R4K
-	select CSRC_R4K
-	select DMA_NONCOHERENT
-	select IRQ_MIPS_CPU
-	select HAVE_PCI
-	select PCI_VR41XX
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config ZAO_CAPCELLA
-	bool "ZAO Networks Capcella"
-	select CEVT_R4K
-	select CSRC_R4K
-	select DMA_NONCOHERENT
-	select IRQ_MIPS_CPU
-	select HAVE_PCI
-	select PCI_VR41XX
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-endchoice
-
-choice
-	prompt "Base board type"
-	depends on TANBAC_TB022X
-	default TANBAC_TB0287
-
-config TANBAC_TB0219
-	bool "TANBAC DIMM Evaluation Kit(TB0219)"
-	select GPIO_VR41XX
-	select PCI_VR41XX
-	help
-	  The TANBAC DIMM Evaluation Kit(TB0219) is a MIPS-based platform
-	  manufactured by TANBAC.
-	  Please refer to <http://www.tanbac.co.jp/> about DIMM Evaluation Kit.
-
-config TANBAC_TB0226
-	bool "TANBAC Mbase(TB0226)"
-	select GPIO_VR41XX
-	select PCI_VR41XX
-	help
-	  The TANBAC Mbase(TB0226) is a MIPS-based platform
-	  manufactured by TANBAC.
-	  Please refer to <http://www.tanbac.co.jp/> about Mbase.
-
-config TANBAC_TB0287
-	bool "TANBAC Mini-ITX DIMM base(TB0287)"
-	select PCI_VR41XX
-	help
-	  The TANBAC Mini-ITX DIMM base(TB0287) is a MIPS-based platform
-	  manufactured by TANBAC.
-	  Please refer to <http://www.tanbac.co.jp/> about Mini-ITX DIMM base.
-
-endchoice
-
-config PCI_VR41XX
-	bool "Add PCI control unit support of NEC VR4100 series"
-	depends on MACH_VR41XX && HAVE_PCI
-	default y
-	select PCI
diff --git a/arch/mips/vr41xx/Makefile b/arch/mips/vr41xx/Makefile
deleted file mode 100644
index 765020d5ee4d..000000000000
--- a/arch/mips/vr41xx/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-obj-$(CONFIG_MACH_VR41XX)	+= common/
-obj-$(CONFIG_CASIO_E55)		+= casio-e55/
-obj-$(CONFIG_IBM_WORKPAD)	+= ibm-workpad/
diff --git a/arch/mips/vr41xx/Platform b/arch/mips/vr41xx/Platform
deleted file mode 100644
index 3f593a3e5678..000000000000
--- a/arch/mips/vr41xx/Platform
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-# NEC VR4100 series based machines
-#
-cflags-$(CONFIG_MACH_VR41XX)	+= -I$(srctree)/arch/mips/include/asm/mach-vr41xx
-
-#
-# CASIO CASSIPEIA E-55/65 (VR4111)
-#
-load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
-
-#
-# IBM WorkPad z50 (VR4121)
-#
-load-$(CONFIG_IBM_WORKPAD)	+= 0xffffffff80004000
-
-#
-# TANBAC VR4131 multichip module(TB0225) and TANBAC VR4131DIMM(TB0229) (VR4131)
-#
-load-$(CONFIG_TANBAC_TB022X)	+= 0xffffffff80000000
-
-#
-# Victor MP-C303/304 (VR4122)
-#
-load-$(CONFIG_VICTOR_MPC30X)	+= 0xffffffff80001000
-
-#
-# ZAO Networks Capcella (VR4131)
-#
-load-$(CONFIG_ZAO_CAPCELLA)	+= 0xffffffff80000000
diff --git a/arch/mips/vr41xx/casio-e55/Makefile b/arch/mips/vr41xx/casio-e55/Makefile
deleted file mode 100644
index 65d30d7c86a9..000000000000
--- a/arch/mips/vr41xx/casio-e55/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the CASIO CASSIOPEIA E-55/65 specific parts of the kernel
-#
-
-obj-y			+= setup.o
diff --git a/arch/mips/vr41xx/casio-e55/setup.c b/arch/mips/vr41xx/casio-e55/setup.c
deleted file mode 100644
index 25ea7f19f891..000000000000
--- a/arch/mips/vr41xx/casio-e55/setup.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  setup.c, Setup for the CASIO CASSIOPEIA E-11/15/55/65.
- *
- *  Copyright (C) 2002-2006  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/init.h>
-#include <linux/ioport.h>
-
-#include <asm/io.h>
-
-#define E55_ISA_IO_BASE		0x1400c000
-#define E55_ISA_IO_SIZE		0x03ff4000
-#define E55_ISA_IO_START	0
-#define E55_ISA_IO_END		(E55_ISA_IO_SIZE - 1)
-#define E55_IO_PORT_BASE	KSEG1ADDR(E55_ISA_IO_BASE)
-
-static int __init casio_e55_setup(void)
-{
-	set_io_port_base(E55_IO_PORT_BASE);
-	ioport_resource.start = E55_ISA_IO_START;
-	ioport_resource.end = E55_ISA_IO_END;
-
-	return 0;
-}
-
-arch_initcall(casio_e55_setup);
diff --git a/arch/mips/vr41xx/common/Makefile b/arch/mips/vr41xx/common/Makefile
deleted file mode 100644
index 57d3eee29d5f..000000000000
--- a/arch/mips/vr41xx/common/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for common code of the NEC VR4100 series.
-#
-
-obj-y	+= bcu.o cmu.o giu.o icu.o init.o irq.o pmu.o rtc.o siu.o type.o
diff --git a/arch/mips/vr41xx/common/bcu.c b/arch/mips/vr41xx/common/bcu.c
deleted file mode 100644
index 0677d17796f6..000000000000
--- a/arch/mips/vr41xx/common/bcu.c
+++ /dev/null
@@ -1,210 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  bcu.c, Bus Control Unit routines for the NEC VR4100 series.
- *
- *  Copyright (C) 2002	MontaVista Software Inc.
- *    Author: Yoichi Yuasa <source@mvista.com>
- *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
- *  - Added support for NEC VR4111 and VR4121.
- *
- *  Yoichi Yuasa <yuasa@linux-mips.org>
- *  - Added support for NEC VR4133.
- */
-#include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <linux/types.h>
-
-#include <asm/cpu-type.h>
-#include <asm/cpu.h>
-#include <asm/io.h>
-
-#define CLKSPEEDREG_TYPE1	(void __iomem *)KSEG1ADDR(0x0b000014)
-#define CLKSPEEDREG_TYPE2	(void __iomem *)KSEG1ADDR(0x0f000014)
- #define CLKSP(x)		((x) & 0x001f)
- #define CLKSP_VR4133(x)	((x) & 0x0007)
-
- #define DIV2B			0x8000
- #define DIV3B			0x4000
- #define DIV4B			0x2000
-
- #define DIVT(x)		(((x) & 0xf000) >> 12)
- #define DIVVT(x)		(((x) & 0x0f00) >> 8)
-
- #define TDIVMODE(x)		(2 << (((x) & 0x1000) >> 12))
- #define VTDIVMODE(x)		(((x) & 0x0700) >> 8)
-
-static unsigned long vr41xx_vtclock;
-static unsigned long vr41xx_tclock;
-
-unsigned long vr41xx_get_vtclock_frequency(void)
-{
-	return vr41xx_vtclock;
-}
-
-EXPORT_SYMBOL_GPL(vr41xx_get_vtclock_frequency);
-
-unsigned long vr41xx_get_tclock_frequency(void)
-{
-	return vr41xx_tclock;
-}
-
-EXPORT_SYMBOL_GPL(vr41xx_get_tclock_frequency);
-
-static inline uint16_t read_clkspeed(void)
-{
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-	case CPU_VR4121: return readw(CLKSPEEDREG_TYPE1);
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133: return readw(CLKSPEEDREG_TYPE2);
-	default:
-		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
-		break;
-	}
-
-	return 0;
-}
-
-static inline unsigned long calculate_pclock(uint16_t clkspeed)
-{
-	unsigned long pclock = 0;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		pclock = 18432000 * 64;
-		pclock /= CLKSP(clkspeed);
-		break;
-	case CPU_VR4122:
-		pclock = 18432000 * 98;
-		pclock /= CLKSP(clkspeed);
-		break;
-	case CPU_VR4131:
-		pclock = 18432000 * 108;
-		pclock /= CLKSP(clkspeed);
-		break;
-	case CPU_VR4133:
-		switch (CLKSP_VR4133(clkspeed)) {
-		case 0:
-			pclock = 133000000;
-			break;
-		case 1:
-			pclock = 149000000;
-			break;
-		case 2:
-			pclock = 165900000;
-			break;
-		case 3:
-			pclock = 199100000;
-			break;
-		case 4:
-			pclock = 265900000;
-			break;
-		default:
-			printk(KERN_INFO "Unknown PClock speed for NEC VR4133\n");
-			break;
-		}
-		break;
-	default:
-		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
-		break;
-	}
-
-	printk(KERN_INFO "PClock: %ldHz\n", pclock);
-
-	return pclock;
-}
-
-static inline unsigned long calculate_vtclock(uint16_t clkspeed, unsigned long pclock)
-{
-	unsigned long vtclock = 0;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-		/* The NEC VR4111 doesn't have the VTClock. */
-		break;
-	case CPU_VR4121:
-		vtclock = pclock;
-		/* DIVVT == 9 Divide by 1.5 . VTClock = (PClock * 6) / 9 */
-		if (DIVVT(clkspeed) == 9)
-			vtclock = pclock * 6;
-		/* DIVVT == 10 Divide by 2.5 . VTClock = (PClock * 4) / 10 */
-		else if (DIVVT(clkspeed) == 10)
-			vtclock = pclock * 4;
-		vtclock /= DIVVT(clkspeed);
-		printk(KERN_INFO "VTClock: %ldHz\n", vtclock);
-		break;
-	case CPU_VR4122:
-		if(VTDIVMODE(clkspeed) == 7)
-			vtclock = pclock / 1;
-		else if(VTDIVMODE(clkspeed) == 1)
-			vtclock = pclock / 2;
-		else
-			vtclock = pclock / VTDIVMODE(clkspeed);
-		printk(KERN_INFO "VTClock: %ldHz\n", vtclock);
-		break;
-	case CPU_VR4131:
-	case CPU_VR4133:
-		vtclock = pclock / VTDIVMODE(clkspeed);
-		printk(KERN_INFO "VTClock: %ldHz\n", vtclock);
-		break;
-	default:
-		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
-		break;
-	}
-
-	return vtclock;
-}
-
-static inline unsigned long calculate_tclock(uint16_t clkspeed, unsigned long pclock,
-					     unsigned long vtclock)
-{
-	unsigned long tclock = 0;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-		if (!(clkspeed & DIV2B))
-			tclock = pclock / 2;
-		else if (!(clkspeed & DIV3B))
-			tclock = pclock / 3;
-		else if (!(clkspeed & DIV4B))
-			tclock = pclock / 4;
-		break;
-	case CPU_VR4121:
-		tclock = pclock / DIVT(clkspeed);
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		tclock = vtclock / TDIVMODE(clkspeed);
-		break;
-	default:
-		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
-		break;
-	}
-
-	printk(KERN_INFO "TClock: %ldHz\n", tclock);
-
-	return tclock;
-}
-
-void vr41xx_calculate_clock_frequency(void)
-{
-	unsigned long pclock;
-	uint16_t clkspeed;
-
-	clkspeed = read_clkspeed();
-
-	pclock = calculate_pclock(clkspeed);
-	vr41xx_vtclock = calculate_vtclock(clkspeed, pclock);
-	vr41xx_tclock = calculate_tclock(clkspeed, pclock, vr41xx_vtclock);
-}
-
-EXPORT_SYMBOL_GPL(vr41xx_calculate_clock_frequency);
diff --git a/arch/mips/vr41xx/common/cmu.c b/arch/mips/vr41xx/common/cmu.c
deleted file mode 100644
index e4cbe116b26d..000000000000
--- a/arch/mips/vr41xx/common/cmu.c
+++ /dev/null
@@ -1,242 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  cmu.c, Clock Mask Unit routines for the NEC VR4100 series.
- *
- *  Copyright (C) 2001-2002  MontaVista Software Inc.
- *    Author: Yoichi Yuasa <source@mvista.com>
- *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
- *  - Added support for NEC VR4111 and VR4121.
- *
- *  Yoichi Yuasa <yuasa@linux-mips.org>
- *  - Added support for NEC VR4133.
- */
-#include <linux/export.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/smp.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
-#include <asm/cpu.h>
-#include <asm/io.h>
-#include <asm/vr41xx/vr41xx.h>
-
-#define CMU_TYPE1_BASE	0x0b000060UL
-#define CMU_TYPE1_SIZE	0x4
-
-#define CMU_TYPE2_BASE	0x0f000060UL
-#define CMU_TYPE2_SIZE	0x4
-
-#define CMU_TYPE3_BASE	0x0f000060UL
-#define CMU_TYPE3_SIZE	0x8
-
-#define CMUCLKMSK	0x0
- #define MSKPIU		0x0001
- #define MSKSIU		0x0002
- #define MSKAIU		0x0004
- #define MSKKIU		0x0008
- #define MSKFIR		0x0010
- #define MSKDSIU	0x0820
- #define MSKCSI		0x0040
- #define MSKPCIU	0x0080
- #define MSKSSIU	0x0100
- #define MSKSHSP	0x0200
- #define MSKFFIR	0x0400
- #define MSKSCSI	0x1000
- #define MSKPPCIU	0x2000
-#define CMUCLKMSK2	0x4
- #define MSKCEU		0x0001
- #define MSKMAC0	0x0002
- #define MSKMAC1	0x0004
-
-static void __iomem *cmu_base;
-static uint16_t cmuclkmsk, cmuclkmsk2;
-static DEFINE_SPINLOCK(cmu_lock);
-
-#define cmu_read(offset)		readw(cmu_base + (offset))
-#define cmu_write(offset, value)	writew((value), cmu_base + (offset))
-
-void vr41xx_supply_clock(vr41xx_clock_t clock)
-{
-	spin_lock_irq(&cmu_lock);
-
-	switch (clock) {
-	case PIU_CLOCK:
-		cmuclkmsk |= MSKPIU;
-		break;
-	case SIU_CLOCK:
-		cmuclkmsk |= MSKSIU | MSKSSIU;
-		break;
-	case AIU_CLOCK:
-		cmuclkmsk |= MSKAIU;
-		break;
-	case KIU_CLOCK:
-		cmuclkmsk |= MSKKIU;
-		break;
-	case FIR_CLOCK:
-		cmuclkmsk |= MSKFIR | MSKFFIR;
-		break;
-	case DSIU_CLOCK:
-		if (current_cpu_type() == CPU_VR4111 ||
-		    current_cpu_type() == CPU_VR4121)
-			cmuclkmsk |= MSKDSIU;
-		else
-			cmuclkmsk |= MSKSIU | MSKDSIU;
-		break;
-	case CSI_CLOCK:
-		cmuclkmsk |= MSKCSI | MSKSCSI;
-		break;
-	case PCIU_CLOCK:
-		cmuclkmsk |= MSKPCIU;
-		break;
-	case HSP_CLOCK:
-		cmuclkmsk |= MSKSHSP;
-		break;
-	case PCI_CLOCK:
-		cmuclkmsk |= MSKPPCIU;
-		break;
-	case CEU_CLOCK:
-		cmuclkmsk2 |= MSKCEU;
-		break;
-	case ETHER0_CLOCK:
-		cmuclkmsk2 |= MSKMAC0;
-		break;
-	case ETHER1_CLOCK:
-		cmuclkmsk2 |= MSKMAC1;
-		break;
-	default:
-		break;
-	}
-
-	if (clock == CEU_CLOCK || clock == ETHER0_CLOCK ||
-	    clock == ETHER1_CLOCK)
-		cmu_write(CMUCLKMSK2, cmuclkmsk2);
-	else
-		cmu_write(CMUCLKMSK, cmuclkmsk);
-
-	spin_unlock_irq(&cmu_lock);
-}
-
-EXPORT_SYMBOL_GPL(vr41xx_supply_clock);
-
-void vr41xx_mask_clock(vr41xx_clock_t clock)
-{
-	spin_lock_irq(&cmu_lock);
-
-	switch (clock) {
-	case PIU_CLOCK:
-		cmuclkmsk &= ~MSKPIU;
-		break;
-	case SIU_CLOCK:
-		if (current_cpu_type() == CPU_VR4111 ||
-		    current_cpu_type() == CPU_VR4121) {
-			cmuclkmsk &= ~(MSKSIU | MSKSSIU);
-		} else {
-			if (cmuclkmsk & MSKDSIU)
-				cmuclkmsk &= ~MSKSSIU;
-			else
-				cmuclkmsk &= ~(MSKSIU | MSKSSIU);
-		}
-		break;
-	case AIU_CLOCK:
-		cmuclkmsk &= ~MSKAIU;
-		break;
-	case KIU_CLOCK:
-		cmuclkmsk &= ~MSKKIU;
-		break;
-	case FIR_CLOCK:
-		cmuclkmsk &= ~(MSKFIR | MSKFFIR);
-		break;
-	case DSIU_CLOCK:
-		if (current_cpu_type() == CPU_VR4111 ||
-		    current_cpu_type() == CPU_VR4121) {
-			cmuclkmsk &= ~MSKDSIU;
-		} else {
-			if (cmuclkmsk & MSKSSIU)
-				cmuclkmsk &= ~MSKDSIU;
-			else
-				cmuclkmsk &= ~(MSKSIU | MSKDSIU);
-		}
-		break;
-	case CSI_CLOCK:
-		cmuclkmsk &= ~(MSKCSI | MSKSCSI);
-		break;
-	case PCIU_CLOCK:
-		cmuclkmsk &= ~MSKPCIU;
-		break;
-	case HSP_CLOCK:
-		cmuclkmsk &= ~MSKSHSP;
-		break;
-	case PCI_CLOCK:
-		cmuclkmsk &= ~MSKPPCIU;
-		break;
-	case CEU_CLOCK:
-		cmuclkmsk2 &= ~MSKCEU;
-		break;
-	case ETHER0_CLOCK:
-		cmuclkmsk2 &= ~MSKMAC0;
-		break;
-	case ETHER1_CLOCK:
-		cmuclkmsk2 &= ~MSKMAC1;
-		break;
-	default:
-		break;
-	}
-
-	if (clock == CEU_CLOCK || clock == ETHER0_CLOCK ||
-	    clock == ETHER1_CLOCK)
-		cmu_write(CMUCLKMSK2, cmuclkmsk2);
-	else
-		cmu_write(CMUCLKMSK, cmuclkmsk);
-
-	spin_unlock_irq(&cmu_lock);
-}
-
-EXPORT_SYMBOL_GPL(vr41xx_mask_clock);
-
-static int __init vr41xx_cmu_init(void)
-{
-	unsigned long start, size;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		start = CMU_TYPE1_BASE;
-		size = CMU_TYPE1_SIZE;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-		start = CMU_TYPE2_BASE;
-		size = CMU_TYPE2_SIZE;
-		break;
-	case CPU_VR4133:
-		start = CMU_TYPE3_BASE;
-		size = CMU_TYPE3_SIZE;
-		break;
-	default:
-		panic("Unexpected CPU of NEC VR4100 series");
-		break;
-	}
-
-	if (request_mem_region(start, size, "CMU") == NULL)
-		return -EBUSY;
-
-	cmu_base = ioremap(start, size);
-	if (cmu_base == NULL) {
-		release_mem_region(start, size);
-		return -EBUSY;
-	}
-
-	cmuclkmsk = cmu_read(CMUCLKMSK);
-	if (current_cpu_type() == CPU_VR4133)
-		cmuclkmsk2 = cmu_read(CMUCLKMSK2);
-
-	return 0;
-}
-
-core_initcall(vr41xx_cmu_init);
diff --git a/arch/mips/vr41xx/common/giu.c b/arch/mips/vr41xx/common/giu.c
deleted file mode 100644
index 398c626411f8..000000000000
--- a/arch/mips/vr41xx/common/giu.c
+++ /dev/null
@@ -1,110 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  NEC VR4100 series GIU platform device.
- *
- *  Copyright (C) 2007	Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-
-#include <asm/cpu.h>
-#include <asm/vr41xx/giu.h>
-#include <asm/vr41xx/irq.h>
-
-static struct resource giu_50pins_pullupdown_resource[] __initdata = {
-	{
-		.start	= 0x0b000100,
-		.end	= 0x0b00011f,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= 0x0b0002e0,
-		.end	= 0x0b0002e3,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= GIUINT_IRQ,
-		.end	= GIUINT_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource giu_36pins_resource[] __initdata = {
-	{
-		.start	= 0x0f000140,
-		.end	= 0x0f00015f,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= GIUINT_IRQ,
-		.end	= GIUINT_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource giu_48pins_resource[] __initdata = {
-	{
-		.start	= 0x0f000140,
-		.end	= 0x0f000167,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= GIUINT_IRQ,
-		.end	= GIUINT_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static int __init vr41xx_giu_add(void)
-{
-	struct platform_device *pdev;
-	struct resource *res;
-	unsigned int num;
-	int retval;
-
-	pdev = platform_device_alloc("GIU", -1);
-	if (!pdev)
-		return -ENOMEM;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		pdev->id = GPIO_50PINS_PULLUPDOWN;
-		res = giu_50pins_pullupdown_resource;
-		num = ARRAY_SIZE(giu_50pins_pullupdown_resource);
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-		pdev->id = GPIO_36PINS;
-		res = giu_36pins_resource;
-		num = ARRAY_SIZE(giu_36pins_resource);
-		break;
-	case CPU_VR4133:
-		pdev->id = GPIO_48PINS_EDGE_SELECT;
-		res = giu_48pins_resource;
-		num = ARRAY_SIZE(giu_48pins_resource);
-		break;
-	default:
-		retval = -ENODEV;
-		goto err_free_device;
-	}
-
-	retval = platform_device_add_resources(pdev, res, num);
-	if (retval)
-		goto err_free_device;
-
-	retval = platform_device_add(pdev);
-	if (retval)
-		goto err_free_device;
-
-	return 0;
-
-err_free_device:
-	platform_device_put(pdev);
-
-	return retval;
-}
-device_initcall(vr41xx_giu_add);
diff --git a/arch/mips/vr41xx/common/icu.c b/arch/mips/vr41xx/common/icu.c
deleted file mode 100644
index 9240bcdbe74e..000000000000
--- a/arch/mips/vr41xx/common/icu.c
+++ /dev/null
@@ -1,714 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  icu.c, Interrupt Control Unit routines for the NEC VR4100 series.
- *
- *  Copyright (C) 2001-2002  MontaVista Software Inc.
- *    Author: Yoichi Yuasa <source@mvista.com>
- *  Copyright (C) 2003-2006  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
- *  - Added support for NEC VR4111 and VR4121.
- *
- *  Yoichi Yuasa <yuasa@linux-mips.org>
- *  - Coped with INTASSIGN of NEC VR4133.
- */
-#include <linux/errno.h>
-#include <linux/export.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/irq.h>
-#include <linux/smp.h>
-#include <linux/types.h>
-
-#include <asm/cpu.h>
-#include <asm/io.h>
-#include <asm/vr41xx/irq.h>
-#include <asm/vr41xx/vr41xx.h>
-
-static void __iomem *icu1_base;
-static void __iomem *icu2_base;
-
-static unsigned char sysint1_assign[16] = {
-	0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
-static unsigned char sysint2_assign[16] = {
-	2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
-
-#define ICU1_TYPE1_BASE 0x0b000080UL
-#define ICU2_TYPE1_BASE 0x0b000200UL
-
-#define ICU1_TYPE2_BASE 0x0f000080UL
-#define ICU2_TYPE2_BASE 0x0f0000a0UL
-
-#define ICU1_SIZE	0x20
-#define ICU2_SIZE	0x1c
-
-#define SYSINT1REG	0x00
-#define PIUINTREG	0x02
-#define INTASSIGN0	0x04
-#define INTASSIGN1	0x06
-#define GIUINTLREG	0x08
-#define DSIUINTREG	0x0a
-#define MSYSINT1REG	0x0c
-#define MPIUINTREG	0x0e
-#define MAIUINTREG	0x10
-#define MKIUINTREG	0x12
-#define MMACINTREG	0x12
-#define MGIUINTLREG	0x14
-#define MDSIUINTREG	0x16
-#define NMIREG		0x18
-#define SOFTREG		0x1a
-#define INTASSIGN2	0x1c
-#define INTASSIGN3	0x1e
-
-#define SYSINT2REG	0x00
-#define GIUINTHREG	0x02
-#define FIRINTREG	0x04
-#define MSYSINT2REG	0x06
-#define MGIUINTHREG	0x08
-#define MFIRINTREG	0x0a
-#define PCIINTREG	0x0c
- #define PCIINT0	0x0001
-#define SCUINTREG	0x0e
- #define SCUINT0	0x0001
-#define CSIINTREG	0x10
-#define MPCIINTREG	0x12
-#define MSCUINTREG	0x14
-#define MCSIINTREG	0x16
-#define BCUINTREG	0x18
- #define BCUINTR	0x0001
-#define MBCUINTREG	0x1a
-
-#define SYSINT1_IRQ_TO_PIN(x)	((x) - SYSINT1_IRQ_BASE)	/* Pin 0-15 */
-#define SYSINT2_IRQ_TO_PIN(x)	((x) - SYSINT2_IRQ_BASE)	/* Pin 0-15 */
-
-#define INT_TO_IRQ(x)		((x) + 2)	/* Int0-4 -> IRQ2-6 */
-
-#define icu1_read(offset)		readw(icu1_base + (offset))
-#define icu1_write(offset, value)	writew((value), icu1_base + (offset))
-
-#define icu2_read(offset)		readw(icu2_base + (offset))
-#define icu2_write(offset, value)	writew((value), icu2_base + (offset))
-
-#define INTASSIGN_MAX	4
-#define INTASSIGN_MASK	0x0007
-
-static inline uint16_t icu1_set(uint8_t offset, uint16_t set)
-{
-	uint16_t data;
-
-	data = icu1_read(offset);
-	data |= set;
-	icu1_write(offset, data);
-
-	return data;
-}
-
-static inline uint16_t icu1_clear(uint8_t offset, uint16_t clear)
-{
-	uint16_t data;
-
-	data = icu1_read(offset);
-	data &= ~clear;
-	icu1_write(offset, data);
-
-	return data;
-}
-
-static inline uint16_t icu2_set(uint8_t offset, uint16_t set)
-{
-	uint16_t data;
-
-	data = icu2_read(offset);
-	data |= set;
-	icu2_write(offset, data);
-
-	return data;
-}
-
-static inline uint16_t icu2_clear(uint8_t offset, uint16_t clear)
-{
-	uint16_t data;
-
-	data = icu2_read(offset);
-	data &= ~clear;
-	icu2_write(offset, data);
-
-	return data;
-}
-
-void vr41xx_enable_piuint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(PIU_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4111 ||
-	    current_cpu_type() == CPU_VR4121) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu1_set(MPIUINTREG, mask);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_enable_piuint);
-
-void vr41xx_disable_piuint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(PIU_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4111 ||
-	    current_cpu_type() == CPU_VR4121) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu1_clear(MPIUINTREG, mask);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_disable_piuint);
-
-void vr41xx_enable_aiuint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(AIU_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4111 ||
-	    current_cpu_type() == CPU_VR4121) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu1_set(MAIUINTREG, mask);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_enable_aiuint);
-
-void vr41xx_disable_aiuint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(AIU_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4111 ||
-	    current_cpu_type() == CPU_VR4121) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu1_clear(MAIUINTREG, mask);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_disable_aiuint);
-
-void vr41xx_enable_kiuint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(KIU_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4111 ||
-	    current_cpu_type() == CPU_VR4121) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu1_set(MKIUINTREG, mask);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_enable_kiuint);
-
-void vr41xx_disable_kiuint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(KIU_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4111 ||
-	    current_cpu_type() == CPU_VR4121) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu1_clear(MKIUINTREG, mask);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_disable_kiuint);
-
-void vr41xx_enable_macint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(ETHERNET_IRQ);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	icu1_set(MMACINTREG, mask);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-}
-
-EXPORT_SYMBOL(vr41xx_enable_macint);
-
-void vr41xx_disable_macint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(ETHERNET_IRQ);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	icu1_clear(MMACINTREG, mask);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-}
-
-EXPORT_SYMBOL(vr41xx_disable_macint);
-
-void vr41xx_enable_dsiuint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(DSIU_IRQ);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	icu1_set(MDSIUINTREG, mask);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-}
-
-EXPORT_SYMBOL(vr41xx_enable_dsiuint);
-
-void vr41xx_disable_dsiuint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(DSIU_IRQ);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	icu1_clear(MDSIUINTREG, mask);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-}
-
-EXPORT_SYMBOL(vr41xx_disable_dsiuint);
-
-void vr41xx_enable_firint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(FIR_IRQ);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	icu2_set(MFIRINTREG, mask);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-}
-
-EXPORT_SYMBOL(vr41xx_enable_firint);
-
-void vr41xx_disable_firint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(FIR_IRQ);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	icu2_clear(MFIRINTREG, mask);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-}
-
-EXPORT_SYMBOL(vr41xx_disable_firint);
-
-void vr41xx_enable_pciint(void)
-{
-	struct irq_desc *desc = irq_to_desc(PCI_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4122 ||
-	    current_cpu_type() == CPU_VR4131 ||
-	    current_cpu_type() == CPU_VR4133) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu2_write(MPCIINTREG, PCIINT0);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_enable_pciint);
-
-void vr41xx_disable_pciint(void)
-{
-	struct irq_desc *desc = irq_to_desc(PCI_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4122 ||
-	    current_cpu_type() == CPU_VR4131 ||
-	    current_cpu_type() == CPU_VR4133) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu2_write(MPCIINTREG, 0);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_disable_pciint);
-
-void vr41xx_enable_scuint(void)
-{
-	struct irq_desc *desc = irq_to_desc(SCU_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4122 ||
-	    current_cpu_type() == CPU_VR4131 ||
-	    current_cpu_type() == CPU_VR4133) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu2_write(MSCUINTREG, SCUINT0);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_enable_scuint);
-
-void vr41xx_disable_scuint(void)
-{
-	struct irq_desc *desc = irq_to_desc(SCU_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4122 ||
-	    current_cpu_type() == CPU_VR4131 ||
-	    current_cpu_type() == CPU_VR4133) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu2_write(MSCUINTREG, 0);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_disable_scuint);
-
-void vr41xx_enable_csiint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(CSI_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4122 ||
-	    current_cpu_type() == CPU_VR4131 ||
-	    current_cpu_type() == CPU_VR4133) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu2_set(MCSIINTREG, mask);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_enable_csiint);
-
-void vr41xx_disable_csiint(uint16_t mask)
-{
-	struct irq_desc *desc = irq_to_desc(CSI_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4122 ||
-	    current_cpu_type() == CPU_VR4131 ||
-	    current_cpu_type() == CPU_VR4133) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu2_clear(MCSIINTREG, mask);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_disable_csiint);
-
-void vr41xx_enable_bcuint(void)
-{
-	struct irq_desc *desc = irq_to_desc(BCU_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4122 ||
-	    current_cpu_type() == CPU_VR4131 ||
-	    current_cpu_type() == CPU_VR4133) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu2_write(MBCUINTREG, BCUINTR);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_enable_bcuint);
-
-void vr41xx_disable_bcuint(void)
-{
-	struct irq_desc *desc = irq_to_desc(BCU_IRQ);
-	unsigned long flags;
-
-	if (current_cpu_type() == CPU_VR4122 ||
-	    current_cpu_type() == CPU_VR4131 ||
-	    current_cpu_type() == CPU_VR4133) {
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		icu2_write(MBCUINTREG, 0);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_disable_bcuint);
-
-static void disable_sysint1_irq(struct irq_data *d)
-{
-	icu1_clear(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(d->irq));
-}
-
-static void enable_sysint1_irq(struct irq_data *d)
-{
-	icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(d->irq));
-}
-
-static struct irq_chip sysint1_irq_type = {
-	.name		= "SYSINT1",
-	.irq_mask	= disable_sysint1_irq,
-	.irq_unmask	= enable_sysint1_irq,
-};
-
-static void disable_sysint2_irq(struct irq_data *d)
-{
-	icu2_clear(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(d->irq));
-}
-
-static void enable_sysint2_irq(struct irq_data *d)
-{
-	icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(d->irq));
-}
-
-static struct irq_chip sysint2_irq_type = {
-	.name		= "SYSINT2",
-	.irq_mask	= disable_sysint2_irq,
-	.irq_unmask	= enable_sysint2_irq,
-};
-
-static inline int set_sysint1_assign(unsigned int irq, unsigned char assign)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-	uint16_t intassign0, intassign1;
-	unsigned int pin;
-
-	pin = SYSINT1_IRQ_TO_PIN(irq);
-
-	raw_spin_lock_irq(&desc->lock);
-
-	intassign0 = icu1_read(INTASSIGN0);
-	intassign1 = icu1_read(INTASSIGN1);
-
-	switch (pin) {
-	case 0:
-		intassign0 &= ~INTASSIGN_MASK;
-		intassign0 |= (uint16_t)assign;
-		break;
-	case 1:
-		intassign0 &= ~(INTASSIGN_MASK << 3);
-		intassign0 |= (uint16_t)assign << 3;
-		break;
-	case 2:
-		intassign0 &= ~(INTASSIGN_MASK << 6);
-		intassign0 |= (uint16_t)assign << 6;
-		break;
-	case 3:
-		intassign0 &= ~(INTASSIGN_MASK << 9);
-		intassign0 |= (uint16_t)assign << 9;
-		break;
-	case 8:
-		intassign0 &= ~(INTASSIGN_MASK << 12);
-		intassign0 |= (uint16_t)assign << 12;
-		break;
-	case 9:
-		intassign1 &= ~INTASSIGN_MASK;
-		intassign1 |= (uint16_t)assign;
-		break;
-	case 11:
-		intassign1 &= ~(INTASSIGN_MASK << 6);
-		intassign1 |= (uint16_t)assign << 6;
-		break;
-	case 12:
-		intassign1 &= ~(INTASSIGN_MASK << 9);
-		intassign1 |= (uint16_t)assign << 9;
-		break;
-	default:
-		raw_spin_unlock_irq(&desc->lock);
-		return -EINVAL;
-	}
-
-	sysint1_assign[pin] = assign;
-	icu1_write(INTASSIGN0, intassign0);
-	icu1_write(INTASSIGN1, intassign1);
-
-	raw_spin_unlock_irq(&desc->lock);
-
-	return 0;
-}
-
-static inline int set_sysint2_assign(unsigned int irq, unsigned char assign)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-	uint16_t intassign2, intassign3;
-	unsigned int pin;
-
-	pin = SYSINT2_IRQ_TO_PIN(irq);
-
-	raw_spin_lock_irq(&desc->lock);
-
-	intassign2 = icu1_read(INTASSIGN2);
-	intassign3 = icu1_read(INTASSIGN3);
-
-	switch (pin) {
-	case 0:
-		intassign2 &= ~INTASSIGN_MASK;
-		intassign2 |= (uint16_t)assign;
-		break;
-	case 1:
-		intassign2 &= ~(INTASSIGN_MASK << 3);
-		intassign2 |= (uint16_t)assign << 3;
-		break;
-	case 3:
-		intassign2 &= ~(INTASSIGN_MASK << 6);
-		intassign2 |= (uint16_t)assign << 6;
-		break;
-	case 4:
-		intassign2 &= ~(INTASSIGN_MASK << 9);
-		intassign2 |= (uint16_t)assign << 9;
-		break;
-	case 5:
-		intassign2 &= ~(INTASSIGN_MASK << 12);
-		intassign2 |= (uint16_t)assign << 12;
-		break;
-	case 6:
-		intassign3 &= ~INTASSIGN_MASK;
-		intassign3 |= (uint16_t)assign;
-		break;
-	case 7:
-		intassign3 &= ~(INTASSIGN_MASK << 3);
-		intassign3 |= (uint16_t)assign << 3;
-		break;
-	case 8:
-		intassign3 &= ~(INTASSIGN_MASK << 6);
-		intassign3 |= (uint16_t)assign << 6;
-		break;
-	case 9:
-		intassign3 &= ~(INTASSIGN_MASK << 9);
-		intassign3 |= (uint16_t)assign << 9;
-		break;
-	case 10:
-		intassign3 &= ~(INTASSIGN_MASK << 12);
-		intassign3 |= (uint16_t)assign << 12;
-		break;
-	default:
-		raw_spin_unlock_irq(&desc->lock);
-		return -EINVAL;
-	}
-
-	sysint2_assign[pin] = assign;
-	icu1_write(INTASSIGN2, intassign2);
-	icu1_write(INTASSIGN3, intassign3);
-
-	raw_spin_unlock_irq(&desc->lock);
-
-	return 0;
-}
-
-int vr41xx_set_intassign(unsigned int irq, unsigned char intassign)
-{
-	int retval = -EINVAL;
-
-	if (current_cpu_type() != CPU_VR4133)
-		return -EINVAL;
-
-	if (intassign > INTASSIGN_MAX)
-		return -EINVAL;
-
-	if (irq >= SYSINT1_IRQ_BASE && irq <= SYSINT1_IRQ_LAST)
-		retval = set_sysint1_assign(irq, intassign);
-	else if (irq >= SYSINT2_IRQ_BASE && irq <= SYSINT2_IRQ_LAST)
-		retval = set_sysint2_assign(irq, intassign);
-
-	return retval;
-}
-
-EXPORT_SYMBOL(vr41xx_set_intassign);
-
-static int icu_get_irq(unsigned int irq)
-{
-	uint16_t pend1, pend2;
-	uint16_t mask1, mask2;
-	int i;
-
-	pend1 = icu1_read(SYSINT1REG);
-	mask1 = icu1_read(MSYSINT1REG);
-
-	pend2 = icu2_read(SYSINT2REG);
-	mask2 = icu2_read(MSYSINT2REG);
-
-	mask1 &= pend1;
-	mask2 &= pend2;
-
-	if (mask1) {
-		for (i = 0; i < 16; i++) {
-			if (irq == INT_TO_IRQ(sysint1_assign[i]) && (mask1 & (1 << i)))
-				return SYSINT1_IRQ(i);
-		}
-	}
-
-	if (mask2) {
-		for (i = 0; i < 16; i++) {
-			if (irq == INT_TO_IRQ(sysint2_assign[i]) && (mask2 & (1 << i)))
-				return SYSINT2_IRQ(i);
-		}
-	}
-
-	printk(KERN_ERR "spurious ICU interrupt: %04x,%04x\n", pend1, pend2);
-
-	return -1;
-}
-
-static int __init vr41xx_icu_init(void)
-{
-	unsigned long icu1_start, icu2_start;
-	int i;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		icu1_start = ICU1_TYPE1_BASE;
-		icu2_start = ICU2_TYPE1_BASE;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		icu1_start = ICU1_TYPE2_BASE;
-		icu2_start = ICU2_TYPE2_BASE;
-		break;
-	default:
-		printk(KERN_ERR "ICU: Unexpected CPU of NEC VR4100 series\n");
-		return -ENODEV;
-	}
-
-	if (request_mem_region(icu1_start, ICU1_SIZE, "ICU") == NULL)
-		return -EBUSY;
-
-	if (request_mem_region(icu2_start, ICU2_SIZE, "ICU") == NULL) {
-		release_mem_region(icu1_start, ICU1_SIZE);
-		return -EBUSY;
-	}
-
-	icu1_base = ioremap(icu1_start, ICU1_SIZE);
-	if (icu1_base == NULL) {
-		release_mem_region(icu1_start, ICU1_SIZE);
-		release_mem_region(icu2_start, ICU2_SIZE);
-		return -ENOMEM;
-	}
-
-	icu2_base = ioremap(icu2_start, ICU2_SIZE);
-	if (icu2_base == NULL) {
-		iounmap(icu1_base);
-		release_mem_region(icu1_start, ICU1_SIZE);
-		release_mem_region(icu2_start, ICU2_SIZE);
-		return -ENOMEM;
-	}
-
-	icu1_write(MSYSINT1REG, 0);
-	icu1_write(MGIUINTLREG, 0xffff);
-
-	icu2_write(MSYSINT2REG, 0);
-	icu2_write(MGIUINTHREG, 0xffff);
-
-	for (i = SYSINT1_IRQ_BASE; i <= SYSINT1_IRQ_LAST; i++)
-		irq_set_chip_and_handler(i, &sysint1_irq_type,
-					 handle_level_irq);
-
-	for (i = SYSINT2_IRQ_BASE; i <= SYSINT2_IRQ_LAST; i++)
-		irq_set_chip_and_handler(i, &sysint2_irq_type,
-					 handle_level_irq);
-
-	cascade_irq(INT0_IRQ, icu_get_irq);
-	cascade_irq(INT1_IRQ, icu_get_irq);
-	cascade_irq(INT2_IRQ, icu_get_irq);
-	cascade_irq(INT3_IRQ, icu_get_irq);
-	cascade_irq(INT4_IRQ, icu_get_irq);
-
-	return 0;
-}
-
-core_initcall(vr41xx_icu_init);
diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
deleted file mode 100644
index 628dddf79a05..000000000000
--- a/arch/mips/vr41xx/common/init.c
+++ /dev/null
@@ -1,60 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  init.c, Common initialization routines for NEC VR4100 series.
- *
- *  Copyright (C) 2003-2009  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/irq.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-#include <asm/time.h>
-#include <asm/vr41xx/irq.h>
-#include <asm/vr41xx/vr41xx.h>
-
-#define IO_MEM_RESOURCE_START	0UL
-#define IO_MEM_RESOURCE_END	0x1fffffffUL
-
-static void __init iomem_resource_init(void)
-{
-	iomem_resource.start = IO_MEM_RESOURCE_START;
-	iomem_resource.end = IO_MEM_RESOURCE_END;
-}
-
-void __init plat_time_init(void)
-{
-	unsigned long tclock;
-
-	vr41xx_calculate_clock_frequency();
-
-	tclock = vr41xx_get_tclock_frequency();
-	if (current_cpu_data.processor_id == PRID_VR4131_REV2_0 ||
-	    current_cpu_data.processor_id == PRID_VR4131_REV2_1)
-		mips_hpt_frequency = tclock / 2;
-	else
-		mips_hpt_frequency = tclock / 4;
-}
-
-void __init plat_mem_setup(void)
-{
-	iomem_resource_init();
-
-	vr41xx_siu_setup();
-}
-
-void __init prom_init(void)
-{
-	int argc, i;
-	char **argv;
-
-	argc = fw_arg0;
-	argv = (char **)fw_arg1;
-
-	for (i = 1; i < argc; i++) {
-		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
-		if (i < (argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
-	}
-}
diff --git a/arch/mips/vr41xx/common/irq.c b/arch/mips/vr41xx/common/irq.c
deleted file mode 100644
index 8f68446ff2d9..000000000000
--- a/arch/mips/vr41xx/common/irq.c
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  Interrupt handing routines for NEC VR4100 series.
- *
- *  Copyright (C) 2005-2007  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/export.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <asm/irq_cpu.h>
-#include <asm/vr41xx/irq.h>
-
-typedef struct irq_cascade {
-	int (*get_irq)(unsigned int);
-} irq_cascade_t;
-
-static irq_cascade_t irq_cascade[NR_IRQS] __cacheline_aligned;
-
-int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int))
-{
-	int retval = 0;
-
-	if (irq >= NR_IRQS)
-		return -EINVAL;
-
-	if (irq_cascade[irq].get_irq != NULL)
-		free_irq(irq, NULL);
-
-	irq_cascade[irq].get_irq = get_irq;
-
-	if (get_irq != NULL) {
-		retval = request_irq(irq, no_action, IRQF_NO_THREAD,
-				     "cascade", NULL);
-		if (retval < 0)
-			irq_cascade[irq].get_irq = NULL;
-	}
-
-	return retval;
-}
-
-EXPORT_SYMBOL_GPL(cascade_irq);
-
-static void irq_dispatch(unsigned int irq)
-{
-	irq_cascade_t *cascade;
-
-	if (irq >= NR_IRQS) {
-		atomic_inc(&irq_err_count);
-		return;
-	}
-
-	cascade = irq_cascade + irq;
-	if (cascade->get_irq != NULL) {
-		struct irq_desc *desc = irq_to_desc(irq);
-		struct irq_data *idata = irq_desc_get_irq_data(desc);
-		struct irq_chip *chip = irq_desc_get_chip(desc);
-		int ret;
-
-		if (chip->irq_mask_ack)
-			chip->irq_mask_ack(idata);
-		else {
-			chip->irq_mask(idata);
-			chip->irq_ack(idata);
-		}
-		ret = cascade->get_irq(irq);
-		irq = ret;
-		if (ret < 0)
-			atomic_inc(&irq_err_count);
-		else
-			irq_dispatch(irq);
-		if (!irqd_irq_disabled(idata) && chip->irq_unmask)
-			chip->irq_unmask(idata);
-	} else
-		do_IRQ(irq);
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
-
-	if (pending & CAUSEF_IP7)
-		do_IRQ(TIMER_IRQ);
-	else if (pending & 0x7800) {
-		if (pending & CAUSEF_IP3)
-			irq_dispatch(INT1_IRQ);
-		else if (pending & CAUSEF_IP4)
-			irq_dispatch(INT2_IRQ);
-		else if (pending & CAUSEF_IP5)
-			irq_dispatch(INT3_IRQ);
-		else if (pending & CAUSEF_IP6)
-			irq_dispatch(INT4_IRQ);
-	} else if (pending & CAUSEF_IP2)
-		irq_dispatch(INT0_IRQ);
-	else if (pending & CAUSEF_IP0)
-		do_IRQ(MIPS_SOFTINT0_IRQ);
-	else if (pending & CAUSEF_IP1)
-		do_IRQ(MIPS_SOFTINT1_IRQ);
-	else
-		spurious_interrupt();
-}
-
-void __init arch_init_irq(void)
-{
-	mips_cpu_irq_init();
-}
diff --git a/arch/mips/vr41xx/common/pmu.c b/arch/mips/vr41xx/common/pmu.c
deleted file mode 100644
index 93cc7e0b30b1..000000000000
--- a/arch/mips/vr41xx/common/pmu.c
+++ /dev/null
@@ -1,123 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  pmu.c, Power Management Unit routines for NEC VR4100 series.
- *
- *  Copyright (C) 2003-2007  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/cpu.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/pm.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-
-#include <asm/cacheflush.h>
-#include <asm/cpu.h>
-#include <asm/idle.h>
-#include <asm/io.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
-
-#define PMU_TYPE1_BASE	0x0b0000a0UL
-#define PMU_TYPE1_SIZE	0x0eUL
-
-#define PMU_TYPE2_BASE	0x0f0000c0UL
-#define PMU_TYPE2_SIZE	0x10UL
-
-#define PMUCNT2REG	0x06
- #define SOFTRST	0x0010
-
-static void __iomem *pmu_base;
-
-#define pmu_read(offset)		readw(pmu_base + (offset))
-#define pmu_write(offset, value)	writew((value), pmu_base + (offset))
-
-static void __cpuidle vr41xx_cpu_wait(void)
-{
-	local_irq_disable();
-	if (!need_resched())
-		/*
-		 * "standby" sets IE bit of the CP0_STATUS to 1.
-		 */
-		__asm__("standby;\n");
-	else
-		local_irq_enable();
-}
-
-static inline void software_reset(void)
-{
-	uint16_t pmucnt2;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		pmucnt2 = pmu_read(PMUCNT2REG);
-		pmucnt2 |= SOFTRST;
-		pmu_write(PMUCNT2REG, pmucnt2);
-		break;
-	default:
-		set_c0_status(ST0_BEV | ST0_ERL);
-		change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-		__flush_cache_all();
-		write_c0_wired(0);
-		__asm__("jr	%0"::"r"(0xbfc00000));
-		break;
-	}
-}
-
-static void vr41xx_restart(char *command)
-{
-	local_irq_disable();
-	software_reset();
-	while (1) ;
-}
-
-static void vr41xx_halt(void)
-{
-	local_irq_disable();
-	printk(KERN_NOTICE "\nYou can turn off the power supply\n");
-	__asm__("hibernate;\n");
-}
-
-static int __init vr41xx_pmu_init(void)
-{
-	unsigned long start, size;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		start = PMU_TYPE1_BASE;
-		size = PMU_TYPE1_SIZE;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		start = PMU_TYPE2_BASE;
-		size = PMU_TYPE2_SIZE;
-		break;
-	default:
-		printk("Unexpected CPU of NEC VR4100 series\n");
-		return -ENODEV;
-	}
-
-	if (request_mem_region(start, size, "PMU") == NULL)
-		return -EBUSY;
-
-	pmu_base = ioremap(start, size);
-	if (pmu_base == NULL) {
-		release_mem_region(start, size);
-		return -EBUSY;
-	}
-
-	cpu_wait = vr41xx_cpu_wait;
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	pm_power_off = vr41xx_halt;
-
-	return 0;
-}
-
-core_initcall(vr41xx_pmu_init);
diff --git a/arch/mips/vr41xx/common/rtc.c b/arch/mips/vr41xx/common/rtc.c
deleted file mode 100644
index 5ce668317fe6..000000000000
--- a/arch/mips/vr41xx/common/rtc.c
+++ /dev/null
@@ -1,105 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  NEC VR4100 series RTC platform device.
- *
- *  Copyright (C) 2007	Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-
-#include <asm/cpu.h>
-#include <asm/vr41xx/irq.h>
-
-static struct resource rtc_type1_resource[] __initdata = {
-	{
-		.start	= 0x0b0000c0,
-		.end	= 0x0b0000df,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= 0x0b0001c0,
-		.end	= 0x0b0001df,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= ELAPSEDTIME_IRQ,
-		.end	= ELAPSEDTIME_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= RTCLONG1_IRQ,
-		.end	= RTCLONG1_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource rtc_type2_resource[] __initdata = {
-	{
-		.start	= 0x0f000100,
-		.end	= 0x0f00011f,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= 0x0f000120,
-		.end	= 0x0f00013f,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= ELAPSEDTIME_IRQ,
-		.end	= ELAPSEDTIME_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= RTCLONG1_IRQ,
-		.end	= RTCLONG1_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static int __init vr41xx_rtc_add(void)
-{
-	struct platform_device *pdev;
-	struct resource *res;
-	unsigned int num;
-	int retval;
-
-	pdev = platform_device_alloc("RTC", -1);
-	if (!pdev)
-		return -ENOMEM;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		res = rtc_type1_resource;
-		num = ARRAY_SIZE(rtc_type1_resource);
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		res = rtc_type2_resource;
-		num = ARRAY_SIZE(rtc_type2_resource);
-		break;
-	default:
-		retval = -ENODEV;
-		goto err_free_device;
-	}
-
-	retval = platform_device_add_resources(pdev, res, num);
-	if (retval)
-		goto err_free_device;
-
-	retval = platform_device_add(pdev);
-	if (retval)
-		goto err_free_device;
-
-	return 0;
-
-err_free_device:
-	platform_device_put(pdev);
-
-	return retval;
-}
-device_initcall(vr41xx_rtc_add);
diff --git a/arch/mips/vr41xx/common/siu.c b/arch/mips/vr41xx/common/siu.c
deleted file mode 100644
index b37a791541bd..000000000000
--- a/arch/mips/vr41xx/common/siu.c
+++ /dev/null
@@ -1,142 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  NEC VR4100 series SIU platform device.
- *
- *  Copyright (C) 2007-2008  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-#include <linux/serial_core.h>
-#include <linux/irq.h>
-
-#include <asm/cpu.h>
-#include <asm/vr41xx/siu.h>
-
-static unsigned int siu_type1_ports[SIU_PORTS_MAX] __initdata = {
-	PORT_VR41XX_SIU,
-	PORT_UNKNOWN,
-};
-
-static struct resource siu_type1_resource[] __initdata = {
-	{
-		.start	= 0x0c000000,
-		.end	= 0x0c00000a,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= SIU_IRQ,
-		.end	= SIU_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static unsigned int siu_type2_ports[SIU_PORTS_MAX] __initdata = {
-	PORT_VR41XX_SIU,
-	PORT_VR41XX_DSIU,
-};
-
-static struct resource siu_type2_resource[] __initdata = {
-	{
-		.start	= 0x0f000800,
-		.end	= 0x0f00080a,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= 0x0f000820,
-		.end	= 0x0f000829,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= SIU_IRQ,
-		.end	= SIU_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DSIU_IRQ,
-		.end	= DSIU_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static int __init vr41xx_siu_add(void)
-{
-	struct platform_device *pdev;
-	struct resource *res;
-	unsigned int num;
-	int retval;
-
-	pdev = platform_device_alloc("SIU", -1);
-	if (!pdev)
-		return -ENOMEM;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		pdev->dev.platform_data = siu_type1_ports;
-		res = siu_type1_resource;
-		num = ARRAY_SIZE(siu_type1_resource);
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		pdev->dev.platform_data = siu_type2_ports;
-		res = siu_type2_resource;
-		num = ARRAY_SIZE(siu_type2_resource);
-		break;
-	default:
-		retval = -ENODEV;
-		goto err_free_device;
-	}
-
-	retval = platform_device_add_resources(pdev, res, num);
-	if (retval)
-		goto err_free_device;
-
-	retval = platform_device_add(pdev);
-	if (retval)
-		goto err_free_device;
-
-	return 0;
-
-err_free_device:
-	platform_device_put(pdev);
-
-	return retval;
-}
-device_initcall(vr41xx_siu_add);
-
-void __init vr41xx_siu_setup(void)
-{
-	struct uart_port port;
-	struct resource *res;
-	unsigned int *type;
-	int i;
-
-	switch (current_cpu_type()) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		type = siu_type1_ports;
-		res = siu_type1_resource;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		type = siu_type2_ports;
-		res = siu_type2_resource;
-		break;
-	default:
-		return;
-	}
-
-	for (i = 0; i < SIU_PORTS_MAX; i++) {
-		port.line = i;
-		port.type = type[i];
-		if (port.type == PORT_UNKNOWN)
-			break;
-		port.mapbase = res[i].start;
-		port.membase = (unsigned char __iomem *)KSEG1ADDR(res[i].start);
-		vr41xx_siu_early_setup(&port);
-	}
-}
diff --git a/arch/mips/vr41xx/common/type.c b/arch/mips/vr41xx/common/type.c
deleted file mode 100644
index dddcf1eaa912..000000000000
--- a/arch/mips/vr41xx/common/type.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  type.c, System type for NEC VR4100 series.
- *
- *  Copyright (C) 2005	Yoichi Yuasa <yuasa@linux-mips.org>
- */
-
-const char *get_system_type(void)
-{
-	return "NEC VR4100 series";
-}
diff --git a/arch/mips/vr41xx/ibm-workpad/Makefile b/arch/mips/vr41xx/ibm-workpad/Makefile
deleted file mode 100644
index c7be704e7b81..000000000000
--- a/arch/mips/vr41xx/ibm-workpad/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the IBM WorkPad z50 specific parts of the kernel
-#
-
-obj-y			+= setup.o
diff --git a/arch/mips/vr41xx/ibm-workpad/setup.c b/arch/mips/vr41xx/ibm-workpad/setup.c
deleted file mode 100644
index 7e14d65c5d2d..000000000000
--- a/arch/mips/vr41xx/ibm-workpad/setup.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  setup.c, Setup for the IBM WorkPad z50.
- *
- *  Copyright (C) 2002-2006  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/init.h>
-#include <linux/ioport.h>
-
-#include <asm/io.h>
-
-#define WORKPAD_ISA_IO_BASE	0x15000000
-#define WORKPAD_ISA_IO_SIZE	0x03000000
-#define WORKPAD_ISA_IO_START	0
-#define WORKPAD_ISA_IO_END	(WORKPAD_ISA_IO_SIZE - 1)
-#define WORKPAD_IO_PORT_BASE	KSEG1ADDR(WORKPAD_ISA_IO_BASE)
-
-static int __init ibm_workpad_setup(void)
-{
-	set_io_port_base(WORKPAD_IO_PORT_BASE);
-	ioport_resource.start = WORKPAD_ISA_IO_START;
-	ioport_resource.end = WORKPAD_ISA_IO_END;
-
-	return 0;
-}
-
-arch_initcall(ibm_workpad_setup);
-- 
2.29.2

