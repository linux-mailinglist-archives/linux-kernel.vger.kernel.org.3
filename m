Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3824D7010
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiCLRAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 12:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiCLRAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 12:00:02 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E64D9D4DD;
        Sat, 12 Mar 2022 08:58:53 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9872D5C00F3;
        Sat, 12 Mar 2022 11:58:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 12 Mar 2022 11:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=yPyexJVh3nRaxA
        wi8JDvJedOH1n8cn7H4dOuQSm5pMQ=; b=mP3A81rmOnDN954FUwfziId5V4zNcy
        EUBi5wuMsyK/0cn8QwDAfUkuGgSv43dWV2mdg9RJexoFxGHk04xWCdZJWRm3v7DQ
        F3Qsr2yB/ZninI302Ne3aK9u5d+HsonemWLIa7UBbLfxMbF8qbRJmABn1fOHLC3L
        oxWZA+oGD8skHbPnUwpXHL5Jeqy/kGIaH2QJVHBpnNhTsL4hf1vQQNTmOcm00Zy+
        +4/RXVTxtKyTIiMIzhHGGCUsGGhOvbtunBFChbxTyk2/nwStDMeu79mJEh/nu8jh
        t1mWHm/QQ60igh4dvscBEx6uA6Yz2pb11vu/MiPcEOUJgnET3BQ9Ma+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yPyexJ
        Vh3nRaxAwi8JDvJedOH1n8cn7H4dOuQSm5pMQ=; b=c7JItLhFUGX2o/he+5Vfj8
        xBNZbhb543rnEkf/0ViawMFKWy8QNFEBtSKK7ILjpIbODXHy6dbfCKLxljr6gfY8
        4P8GWmF5x/+peBz0SE8pNyU4DVOKQJQ9lvq3L3OtGQ/5D3IBmlnMuIMQb7mnG6/X
        7shJmPSobzkP+XV9tsHjWwUDHqmyk6HLCd+O4xJ7K3BwdQLT8EnU77u+6iVwtOgn
        TstuKi9XP8LeLNcKw2RAzHJeJ2eUjCV51Zor1aa/19fTXV11UervhnZEV37le6M1
        KEu4suaxcGusVSTx+HsyH2YsrMFZabTz6TuDr9FdMnBlA8Wsrby5XU61LCFBJMVw
        ==
X-ME-Sender: <xms:TNEsYoy40_koOPdJmup5346srZZIt1csQgil1yhklXNacV0R1HlN6Q>
    <xme:TNEsYsR3-WeKlmunPQExNgomk1VAQUPkapGhHEHYAA316wMm4VxZ9MR8kIE-9p-mT
    -k4GuOLuI8QLTAIRLo>
X-ME-Received: <xmr:TNEsYqVu4r4chrqP0VSxBUPRoqDlGDh3P2P0MCp9bW2YpWAhJDgLNyMArJ-diwCFJqwCcOsELwp6KvQevwRxja-DVZ8roUTtIx920A36-HO79zfMgGFRb0yF_ASYacM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:TNEsYmjG0BBlRjT4gMolxeHiRF75CH8Ng66mEVxOZmPSNiaR9vzyEQ>
    <xmx:TNEsYqCuSQ-lDiP4F_JX5OETrAZpih0qFEK4x9tkiErYC5qZO0_0wg>
    <xmx:TNEsYnK2qfFTmtiM59BH6dIIW9nv7QpeskgTYE8TxxuqPVRHGCutKg>
    <xmx:TNEsYitRxOpAJNfw2soB8Tl55EY5TM-pcQnmxgmGkDjXVj2oDTcgyA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Mar 2022 11:58:50 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowsk <krzysztof.kozlowski@canonical.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] nvmem: Add Apple eFuse driver
Date:   Sat, 12 Mar 2022 17:58:37 +0100
Message-Id: <20220312165837.40687-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220312165837.40687-1-sven@svenpeter.dev>
References: <20220312165837.40687-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v2 -> v3:
  - removed .owner = THIS_MODULE again since it's already done by the
    core as pointed out by Krzysztof Kozlowski
v1 -> v2:
  - fixed sparse warning about __iomem by introducing
    struct apple_efuses_priv as done in other nvmem drivers
  - make sure the driver actually works as a module by
    setting .owner to THIS_MODULE and adding MODULE_DEVICE_TABLE
    pointed out by Joey Gouly

 MAINTAINERS                  |  1 +
 drivers/nvmem/Kconfig        | 12 ++++++
 drivers/nvmem/Makefile       |  2 +
 drivers/nvmem/apple-efuses.c | 80 ++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)
 create mode 100644 drivers/nvmem/apple-efuses.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 24deb0e8f731..a93318a1dda8 100644
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
index da414617a54d..bba29d1aec96 100644
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
+	  Say y here to enable support for reading eFuses on Apple SoCs
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
index 000000000000..9b7c87102104
--- /dev/null
+++ b/drivers/nvmem/apple-efuses.c
@@ -0,0 +1,80 @@
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
+struct apple_efuses_priv {
+	void __iomem *fuses;
+};
+
+static int apple_efuses_read(void *context, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct apple_efuses_priv *priv = context;
+	u32 *dst = val;
+
+	while (bytes >= sizeof(u32)) {
+		*dst++ = readl_relaxed(priv->fuses + offset);
+		bytes -= sizeof(u32);
+		offset += sizeof(u32);
+	}
+
+	return 0;
+}
+
+static int apple_efuses_probe(struct platform_device *pdev)
+{
+	struct apple_efuses_priv *priv;
+	struct resource *res;
+	struct nvmem_config config = {
+		.dev = &pdev->dev,
+		.read_only = true,
+		.reg_read = apple_efuses_read,
+		.stride = sizeof(u32),
+		.word_size = sizeof(u32),
+		.name = "apple_efuses_nvmem",
+		.id = NVMEM_DEVID_AUTO,
+		.root_only = true,
+	};
+
+	priv = devm_kzalloc(config.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->fuses = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->fuses))
+		return PTR_ERR(priv->fuses);
+
+	config.priv = priv;
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
+MODULE_DEVICE_TABLE(of, apple_efuses_of_match);
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

