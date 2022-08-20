Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D259AC0C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbiHTHRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343851AbiHTHRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:17:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82673C6947;
        Sat, 20 Aug 2022 00:17:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y141so6101723pfb.7;
        Sat, 20 Aug 2022 00:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NaF0Qk2p6j2196mNUJaF8uknQCNZGqPcFXW4blntr18=;
        b=JCBmNFewKTYyy3azun5/TuWRXSH+3XD273uPDSPRl37mfN0afYyoUA7pdya1QaU3L/
         hoF3B8K6/Bs7eYnCCu+CCrIRragkX58pIVOyzcoDQblmtQKcVNMEWe4gWeVS+HoUhj/+
         l2PdmX3kLjkuc0bn84u/AI8P5MmYjyI28zfE2Dto5xEYubt0jcisrJl7VHpcpNN8wpCg
         A2r51iteAajnOQfsmprDIVBIMMAvJMPiz0qGzHvgiDntxVQ1d8jVn1dJgn0CU09grxIU
         K9GutODXoVi6SmVZSnPAwU7cT1qF6PqO7F+Wc+PW8c53KUeMjCptDtmr/hdRiPnH+Cum
         yx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NaF0Qk2p6j2196mNUJaF8uknQCNZGqPcFXW4blntr18=;
        b=ZOhBb+lNyhjYJF81nQKqLnkiWX2LkrL2M5+se+fdWu90HSrXuUcupRQi6dRXmSMEdh
         2wLgTcVFcKTJKaBVWLLb2uVbWVnra06rKflk7o02ktYT3Dqa7XVMjPfHdUJQNYa+hchm
         bGJOR8Rnz1vlNHZiGQvzor3/VTjQiwm/LwZqkqXwh7TfCxeGvX/IpwUa8+pQsndhC0sm
         eRyAF0P/Qmxx/hYSGabbojyCx/6O1qtffIYuBEAngeyL0tgsjSGr6tMDMpvk85cjw/pu
         Qa0kcTCCQHsJ24wVno8RJkI+AbVrzCmlw3ckG3a7tiZDxBzzpoNBbx5ZeGNwQy1F4Ab5
         4r6g==
X-Gm-Message-State: ACgBeo0/uq8uPEn4dWT+U5oULtnSNg+cocDb+z0yL0HtWWFC8aL7Fdbr
        Fd/lCWRAThOp6mwrGVy5wzxm92zt4wdGtO99988=
X-Google-Smtp-Source: AA6agR5e4LbPReWIOgnjJpHOBuF592FLzh2H9BusO1kFefpEOrAcugidLU4zG1E8aJSmOANkruyB+g==
X-Received: by 2002:a63:1624:0:b0:41a:9dea:1c80 with SMTP id w36-20020a631624000000b0041a9dea1c80mr9203015pgl.400.1660979851663;
        Sat, 20 Aug 2022 00:17:31 -0700 (PDT)
Received: from mithil.localdomain ([103.19.226.223])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a694f00b001faf273e4afsm1459019pjm.35.2022.08.20.00.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 00:17:31 -0700 (PDT)
From:   Mithil Bavishi <bavishimithil@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, bavishimithil@gmail.com,
        contact@paulk.fr
Subject: [PATCH 03/10] power: reset: Add TWL6030 power driver, with minimal support for power off
Date:   Sat, 20 Aug 2022 12:46:53 +0530
Message-Id: <20220820071659.1215-4-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820071659.1215-1-bavishimithil@gmail.com>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <contact@paulk.fr>

This adds a TWL6030 power driver, that currently only supports powering
off the device when the TWL is used as system power controller.

This driver might be extended to support more power-related features of the
TWL6030.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 drivers/power/reset/Kconfig         | 10 ++++
 drivers/power/reset/Makefile        |  1 +
 drivers/power/reset/twl6030-power.c | 93 +++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 drivers/power/reset/twl6030-power.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 39117b697..5156b1613 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -316,3 +316,13 @@ config TWL4030_POWER
           and load scripts controlling which resources are switched off/on
           or reset when a sleep, wakeup or warm reset event occurs.
 endif
+
+config TWL6030_POWER
+	bool "TI TWL6030 power resources"
+	depends on TWL4030_CORE && ARM
+	help
+	  Say yes here if you want to use the power resources on the
+	  TWL6030 family chips.
+
+	  When used as system power controller, this driver allows turning off
+	  the main power supply.
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index e9db25b09..692d51cef 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
 obj-$(CONFIG_TWL4030_POWER) += twl4030-power.o
+obj-$(CONFIG_TWL6030_POWER) += twl6030-power.o
diff --git a/drivers/power/reset/twl6030-power.c b/drivers/power/reset/twl6030-power.c
new file mode 100644
index 000000000..78c8a02a3
--- /dev/null
+++ b/drivers/power/reset/twl6030-power.c
@@ -0,0 +1,93 @@
+/*
+ * TWL6030 power
+ *
+ * Copyright (C) 2016 Paul Kocialkowski <contact@paulk.fr>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/mfd/twl.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#define TWL6030_PHOENIX_DEV_ON		0x25
+
+#define TWL6030_PHOENIX_APP_DEVOFF	BIT(0)
+#define TWL6030_PHOENIX_CON_DEVOFF	BIT(1)
+#define TWL6030_PHOENIX_MOD_DEVOFF	BIT(2)
+
+void twl6030_power_off(void)
+{
+	int err;
+
+	err = twl_i2c_write_u8(TWL6030_MODULE_ID0, TWL6030_PHOENIX_APP_DEVOFF |
+		TWL6030_PHOENIX_CON_DEVOFF | TWL6030_PHOENIX_MOD_DEVOFF,
+		TWL6030_PHOENIX_DEV_ON);
+	if (err)
+		pr_err("TWL6030 Unable to power off\n");
+}
+
+static bool twl6030_power_use_poweroff(struct device_node *node)
+{
+	if (of_property_read_bool(node, "ti,system-power-controller"))
+		return true;
+
+	return false;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id twl6030_power_of_match[] = {
+	{
+		.compatible = "ti,twl6030-power",
+	},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, twl6030_power_of_match);
+#endif	/* CONFIG_OF */
+
+static int twl6030_power_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+
+	if (!node) {
+		dev_err(&pdev->dev, "Platform data is missing\n");
+		return -EINVAL;
+	}
+
+	/* Board has to be wired properly to use this feature */
+	if (twl6030_power_use_poweroff(node) && !pm_power_off)
+		pm_power_off = twl6030_power_off;
+
+	return 0;
+}
+
+static int twl6030_power_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver twl6030_power_driver = {
+	.driver = {
+		.name	= "twl6030_power",
+		.of_match_table = of_match_ptr(twl6030_power_of_match),
+	},
+	.probe		= twl6030_power_probe,
+	.remove		= twl6030_power_remove,
+};
+
+module_platform_driver(twl6030_power_driver);
+
+MODULE_AUTHOR("Paul Kocialkowski <contact@paulk.fr>");
+MODULE_DESCRIPTION("Power management for TWL6030");
+MODULE_LICENSE("GPL");
-- 
2.25.1

