Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAB64C5AC1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiB0L6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiB0L6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:58:36 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6F61B786;
        Sun, 27 Feb 2022 03:57:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 313E03200DA8;
        Sun, 27 Feb 2022 06:57:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 27 Feb 2022 06:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=LHnbTtvZh1F0Dh
        tswLT8iTo1M9auO3PUzzd56DEi4/0=; b=RrXS5VRdvbBrnsrwu8P2ZJUjQ56j1p
        L7u/Uz1rDrWawiUyjvdE8e+Z4YLYub5AoIcqvxfcMXMtw1OrgGhdgSpe+EYACb7d
        CgCLBVvdlbFA4ZVX9JGBFwH1xI694kNhdWaW/UPz5bkVf2Rjt9m1nhpemPpQAKP0
        5mym2CIQ2aq8QHRwX/xb/Asqc0GcO2QONJMr1HhTsV/qtACQPnjo4iu5d3S9VXGK
        f/rLbLskbCXPZqnGoWXVz+4O14SS4a3Funpha+Guhk4OQk8YRH3PRJvFtHoJ5D0+
        SnLLg69HH2LtgfqCXM4dOIPtB0J/22wsBjz+R5F9pEl4GmIsaYQxV1Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LHnbTt
        vZh1F0DhtswLT8iTo1M9auO3PUzzd56DEi4/0=; b=UuJXtkDYzzmDv3+PlvrF75
        IMSF+7TIjjIQ2zGFSCAJDUBZQxFwofks4FSECuCpKl1vIEe5hdPtmTxC1/FoIaRj
        NLRbj/CNsNtM1nVSPkaCvOCS/z0F/HbgeGRKm2JTkXoC7UapkSpECtJRVEH5RZOq
        QPodUEULOaR8Td6jBH/BgqFQThktGkGbHX9hAOrqio36yQAWjU32pOcMfMpU9rJ1
        AcvlQKlhPlU09mMtX4RlV4kry6GpExnibfiMCm6/jSDsUBesjydfsfcO772pj1Rp
        2v4uS02Fjpw4+nHPdnadIHTeGyVtByvh/PF9hIX/uwiCx8r7cdQT67U2tOhv4iVw
        ==
X-ME-Sender: <xms:RGcbYhXthoKQia9AKkoSozz16sSA9n1xtgdbsp0R_5KH1ZzDm-CL_w>
    <xme:RGcbYhnsxdnbdg_eaa8OEzqS187Es-FBZl-RALc_0006Zi0y3cgFDovX6glNqXoaQ
    nh0oBpLL_dt9V_Pjb0>
X-ME-Received: <xmr:RGcbYtZU0NcEOO3_FJ6lrex6s1wcKB7crA2HxjQvcyVzvZ6uzkXEJN7BKg56dlccqIM5FGQ07vtVGVQ1hD9CrLAZO1FdQG30llDbmy0gY0YbAA3CY7y61rFje7gr9QE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfefjeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:RGcbYkXPFx4eFBXiBqAxD4v2_H5_hPvQ0XnZtZ1bamPgLMuIKGjRIw>
    <xmx:RGcbYrkCO1r19ScyiBj-roI26PzcOM6Sj20Ydt7zFchKiegAmkO8Eg>
    <xmx:RGcbYhf7BOERXdmCMcTBrHKbhP0bWBq1brxGFf2-SW8PPHlr2HKe1g>
    <xmx:RGcbYpWu1iRebcoDB5JBwZOBXh-gm4Z_cRQy0C4jCFhKA_w1Q2_Fjw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Feb 2022 06:57:55 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvmem: Add Apple eFuse driver
Date:   Sun, 27 Feb 2022 12:57:43 +0100
Message-Id: <20220227115743.69059-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220227115743.69059-1-sven@svenpeter.dev>
References: <20220227115743.69059-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs contain eFuses used to store factory-programmed data such
as calibration values for the PCIe or the Type-C PHY. They are organized
as 32bit values exposed as MMIO.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS                  |  1 +
 drivers/nvmem/Kconfig        | 12 +++++++
 drivers/nvmem/Makefile       |  2 ++
 drivers/nvmem/apple-efuses.c | 67 ++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)
 create mode 100644 drivers/nvmem/apple-efuses.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bc57af09c80..031198aec108 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1781,6 +1781,7 @@ F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/irqchip/irq-apple-aic.c
 F:	drivers/mailbox/apple-mailbox.c
+F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
 F:	drivers/soc/apple/*
 F:	drivers/watchdog/apple_wdt.c
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index da414617a54d..ef6a13c8a4d6 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -300,4 +300,16 @@ config NVMEM_BRCM_NVRAM
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
 
+config NVMEM_APPLE_EFUSES
+	tristate "Apple eFuse support"
+	depends on ARCH_APPLE || COMPILE_TEST
+	default ARCH_APPLE
+	help
+	  Say y here to enabled support for reading eFuses on Apple SoCs
+	  such as the M1. These are e.g. used to store factory programmed
+	  calibration data required for the PCIe or the USB-C PHY.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called nvmem-apple-efuses.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index dcbbde35b6a8..1a8e54691d3e 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -61,3 +61,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
 nvmem-rmem-y			:= rmem.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y		:= brcm_nvram.o
+obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
+nvmem-apple-efuses-y 		:= apple-efuses.o
diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
new file mode 100644
index 000000000000..925fc0033b83
--- /dev/null
+++ b/drivers/nvmem/apple-efuses.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Apple SoC eFuse driver
+ *
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+
+static int apple_efuses_read(void *context, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	void __iomem *fuses = context;
+	u32 *dst = val;
+
+	while (bytes >= sizeof(u32)) {
+		*dst++ = readl_relaxed(fuses + offset);
+		bytes -= sizeof(u32);
+		offset += sizeof(u32);
+	}
+
+	return 0;
+}
+
+static int apple_efuses_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct nvmem_config config = {
+		.dev = &pdev->dev,
+		.read_only = true,
+		.reg_read = apple_efuses_read,
+		.stride = sizeof(u32),
+		.word_size = sizeof(u32),
+		.name = "apple_efuses_nvmem",
+		.id = NVMEM_DEVID_AUTO,
+	};
+
+	config.priv = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(config.priv))
+		return PTR_ERR(config.priv);
+
+	config.size = resource_size(res);
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
+}
+
+static const struct of_device_id apple_efuses_of_match[] = {
+	{ .compatible = "apple,efuses", },
+	{}
+};
+
+static struct platform_driver apple_efuses_driver = {
+	.driver = {
+		.name = "apple_efuses",
+		.of_match_table = apple_efuses_of_match,
+	},
+	.probe = apple_efuses_probe,
+};
+
+module_platform_driver(apple_efuses_driver);
+
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

