Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3924682A2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbhLDGOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbhLDGOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:14:12 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043EEC061751;
        Fri,  3 Dec 2021 22:10:47 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id m25so5613650qtq.13;
        Fri, 03 Dec 2021 22:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZSeUEcPJQXd1jzUgiEdzxiZrc2BmM54vWdFfNb9zi0=;
        b=o7/E9de1MCLu1nLGkOd1DTwFwv1HLnc8uaIebncWyXSw1Pk+rbpR6StT3ofsMAtCSR
         7SK48rWarSzUtolz5XbYyoY8x6oylUXqrk8nE8TVkCtk+e5ywuIfMlJFz09WfEoY7Xqr
         adQvrPSs+2c3XPgpcqRGqD9YG34viSHwkOq7HF9mlTzbOlZ3V6ApGIsze40XPybPYPoC
         nvGyvJrQ6LPwmFvJr8dpS9Z0IIjzcVoaNTYky4pj0Tx9w6tET0u5WiWajOIofy2uh/Rf
         NitpOfmeXcfY3d6L3tE5Yzx1jnc+qVxrTxtiSjMoQcVFGpAQxJc4zAgtDCM/jCdnAnis
         a+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZSeUEcPJQXd1jzUgiEdzxiZrc2BmM54vWdFfNb9zi0=;
        b=xTcjRwlR7kzQ/tErTRHlhxJFPH23Y5Hw0Sx3XThFovpt1W6gbUp4qFdYG1OtWKElJt
         WynczQdxUoqBoelImCC8RxpkywjP5U7lYv8tcLjVi6dx+hgZxqoqO2PudFWKQhZGYncP
         0F2QlAjutwP7NyCpNlRN+3B8ApA/LTpqqoUX+vI//TS68PZR/EEkXKdqJda/S5n8AK3l
         KDSKfppU4p8AXQviI//hWiUxBxCIqPCoCDe7Pd7RZoKhXriUG24U3xEd4uogZDbrPRQE
         lmCZ26PZScWjAzCKJhnKdfTrXpLFv4nzP+BrjKGY6js0I4QHcSgv3WoLnFcIMpMH2bzM
         SBPg==
X-Gm-Message-State: AOAM530y7C+UGD+7qKB1npCRzdGJ3L5xoeaTgD9uBv6CoSzJd0mhdToH
        dZFEaYBp7VjGyrrmhy7jBv0=
X-Google-Smtp-Source: ABdhPJwuwLRYDHlQGXk8+SFarLL5mmFUND2JQK+xl3H3TyCg+e79FKrsN9Xjgq0+NMhkZSQPq38wjQ==
X-Received: by 2002:a05:622a:1901:: with SMTP id w1mr25090927qtc.134.1638598245985;
        Fri, 03 Dec 2021 22:10:45 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l1sm3500913qkp.125.2021.12.03.22.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 22:10:45 -0800 (PST)
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
Subject: [PATCH v4 01/13] ARM: imx: add initial support for i.MXRT10xx family
Date:   Sat,  4 Dec 2021 01:10:30 -0500
Message-Id: <20211204061042.1248028-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
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
---
 arch/arm/mach-imx/Kconfig      |  7 +++++++
 arch/arm/mach-imx/Makefile     |  2 ++
 arch/arm/mach-imx/mach-imxrt.c | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/arm/mach-imx/mach-imxrt.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index b407b024dde3..5ad3a8b9b4b6 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -239,6 +239,13 @@ config SOC_IMX7ULP
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
index d1506ef7a537..3b1145722a44 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -65,6 +65,8 @@ obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
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
2.34.0

