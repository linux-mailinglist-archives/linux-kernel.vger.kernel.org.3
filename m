Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86D04E38DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 07:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiCVGZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 02:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiCVGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 02:25:35 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 664002E9EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:23:57 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7841:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Tue, 22 Mar 2022 14:16:35 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     krzysztof.kozlowski@canonical.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v11 9/9] ARM: sp7021_defconfig: Add Sunplus SP7021 defconfig
Date:   Tue, 22 Mar 2022 14:17:00 +0800
Message-Id: <8372ee2fcf361a3af7233450c4403178052ceee2.1647928316.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1647928315.git.qinjian@cqplus1.com>
References: <cover.1647928315.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic Sunplus SP7021 based board defconfig

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 MAINTAINERS                         |  1 +
 arch/arm/configs/multi_v7_defconfig |  1 +
 arch/arm/configs/sp7021_defconfig   | 61 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/arm/configs/sp7021_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 38890c055..93f4de6c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2747,6 +2747,7 @@ F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	arch/arm/configs/sp7021_*defconfig
 F:	arch/arm/mach-sunplus/
 F:	drivers/clk/clk-sp7021.c
 F:	drivers/irqchip/irq-sp7021-intc.c
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8863fa969..a3bd9dbd8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -86,6 +86,7 @@ CONFIG_MACH_SPEAR1310=y
 CONFIG_MACH_SPEAR1340=y
 CONFIG_ARCH_STI=y
 CONFIG_ARCH_STM32=y
+CONFIG_ARCH_SUNPLUS=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_UNIPHIER=y
diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp7021_defconfig
new file mode 100644
index 000000000..cda16d33a
--- /dev/null
+++ b/arch/arm/configs/sp7021_defconfig
@@ -0,0 +1,61 @@
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_PERF_EVENTS=y
+CONFIG_SLAB=y
+CONFIG_ARCH_SUNPLUS=y
+# CONFIG_VDSO is not set
+CONFIG_SMP=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
+CONFIG_THUMB2_KERNEL=y
+CONFIG_FORCE_MAX_ZONEORDER=12
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_UEVENT_HELPER=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_INPUT_SPARSEKMAP=y
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_STAGING=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_RESET_CONTROLLER=y
+CONFIG_EXT4_FS=y
+# CONFIG_DNOTIFY is not set
+CONFIG_FANOTIFY=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_IOCHARSET="utf8"
+CONFIG_EXFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_USER=y
-- 
2.33.1

