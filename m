Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10E347CAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbhLVBwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhLVBwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:52:49 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B493C061401;
        Tue, 21 Dec 2021 17:52:49 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z9so598928qtj.9;
        Tue, 21 Dec 2021 17:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQkmQz6HJhAqMlw92lg2wrj8I+GCLRULRUiwNt0lmtc=;
        b=Va2jxNVSNv2ptwwP9p65n9lFHGnYo+EXlUVTyXoxFgzlSsiAYIUqp6x9XIXIwjSX3S
         /y6Y+eEhOScsm8WsdJSWCdxS2y2GE9fVABQZW0PedNpI2amdlhcFMTCzo7NRA2tUySos
         M6HubJ79js+XUPGn9Lv27hv1inMaGLKrR71Uul61J/biWx5155hTPbjrpl3QPbMaEEYg
         QzkKWsXhRC65WUL/8hN2aHjXxtmTpUn/YO/hKrWMBL2424Rk6JCif7YZGJaGkHuoRiMf
         Nw8VVPDdaXwN7zt8BPW1JCmnBM5oakzkAS5qLvnEzkd32fPIv3QQu9SVRtOe3rHevz15
         HEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQkmQz6HJhAqMlw92lg2wrj8I+GCLRULRUiwNt0lmtc=;
        b=fTSTBpVXSRe1HTJc7yZ8oWi//B7t7DRRSMpuu5uF06sH19q1Yq+PobYGgjCYE1WUNZ
         vhIIcGkNOPv1c1MGGkuviVGVa+IPc5o46bgxcq8qFo37Sp3fxbCZ4gKkqLmibaJZK6WJ
         SKitL4q9utT1D/iGTP5OVBBDucd7DtCZqEweEDOpvFHw/rAscot21EFqiOStknalxatf
         9jnrnqtLUP0rKnD8qPCvTI5rb+DM+0Mqh1vTAh5wt1SMu9sK2MY6kmZ8h6VvA4rBXTyp
         fPqwZ044VMBlEWiujYEDEhdyztrFqYHS3wPxo6ESVOo/53oWY7VqvTT4Y9cAxLM7lqc1
         EEoQ==
X-Gm-Message-State: AOAM533WsLK5nw7KRvpCf28BKP9L9MSKp6KzgTM4W+KukBxFoP+zoJe6
        xg3TVDljIYmAKQ4zV6SBV8g=
X-Google-Smtp-Source: ABdhPJx8r4AMQqj8gu3lcE5V010u38u9Ql6n7rfMLhsDygCqS1ft3pAMjZ/dedcOyRUo9OTulCAv1g==
X-Received: by 2002:ac8:7d47:: with SMTP id h7mr774644qtb.188.1640137968298;
        Tue, 21 Dec 2021 17:52:48 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id d4sm658161qkn.79.2021.12.21.17.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 17:52:47 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v6 1/7] ARM: imx: Add initial support for i.MXRT10xx family
Date:   Tue, 21 Dec 2021 20:52:38 -0500
Message-Id: <20211222015244.2464671-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222015244.2464671-1-Mr.Bossman075@gmail.com>
References: <20211222015244.2464671-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@benettiengineering.com>

The i.MXRT10xx family of processors features NXP's implementation of the
Arm Cortex-M7 core and in some case the Arm Cortex-M4 core too.

This patch aims to add an initial support for imxrt.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
[Jesse: removed SOC_IMXRT's 'depends on ARCH_MULTI_V7' and 'select
ARM_GIC if ARCH_MULTI_V7']
---
V1->V2:
* Remove depends ARCH_MULTI_V7
* Remove select PINCTRL_IMXRT
* Change commit description
V2->V3:
* Nothing done
V3->V4:
* Nothing done
V4->V5:
* Nothing done
V5->V6:
* Nothing done
---
 arch/arm/mach-imx/Kconfig      |  7 +++++++
 arch/arm/mach-imx/Makefile     |  2 ++
 arch/arm/mach-imx/mach-imxrt.c | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/arm/mach-imx/mach-imxrt.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f296bac467c8..c5a59158722b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -227,6 +227,13 @@ config SOC_IMX7ULP
 	help
 	  This enables support for Freescale i.MX7 Ultra Low Power processor.
 
+config SOC_IMXRT
+	bool "i.MXRT support"
+	depends on ARM_SINGLE_ARMV7M
+	select ARMV7M_SYSTICK if ARM_SINGLE_ARMV7M
+	help
+	  This enables support for Freescale i.MXRT Crossover processor.
+
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select ARM_GIC if ARCH_MULTI_V7
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index d5291ed9186a..6fb3965b9ae6 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -63,6 +63,8 @@ obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
 obj-$(CONFIG_SOC_IMX51) += mach-imx51.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
 
+obj-$(CONFIG_SOC_IMXRT) += mach-imxrt.o
+
 obj-$(CONFIG_SOC_VF610) += mach-vf610.o
 
 obj-$(CONFIG_SOC_LS1021A) += mach-ls1021a.o
diff --git a/arch/arm/mach-imx/mach-imxrt.c b/arch/arm/mach-imx/mach-imxrt.c
new file mode 100644
index 000000000000..2063a3059c84
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imxrt.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019
+ * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
+ */
+
+#include <linux/kernel.h>
+#include <asm/mach/arch.h>
+#include <asm/v7m.h>
+
+static const char *const imxrt_compat[] __initconst = {
+	"fsl,imxrt1050",
+	NULL
+};
+
+DT_MACHINE_START(IMXRTDT, "IMXRT (Device Tree Support)")
+	.dt_compat = imxrt_compat,
+	.restart = armv7m_restart,
+MACHINE_END
-- 
2.34.1

