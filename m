Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AFB4CEB80
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 13:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiCFMTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 07:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiCFMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 07:19:32 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879791114F;
        Sun,  6 Mar 2022 04:18:38 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id E78915802BB;
        Sun,  6 Mar 2022 07:18:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 06 Mar 2022 07:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=fAqBZoyuXQbc0j
        buBUfb/Ov5yXGEQBn0rxhq7UBBsaM=; b=vKfmb+l6J6pFh49CxyzDJHfC+DJPva
        OnOKC84BiDG0ASp1tfKfOc7SAKVOk+JhXRkUaINFp0+DTlDdYbpl7WNfjaLW6dkq
        3OClfcIFgCKFH+9JpcSPF5LOguY/C6bO0oZe+RuH0GJCW1akZrPWvW4wVsKCb8wh
        vlUdntqal7GEqnQQZMJn42av9Fk0izXdaCkh5cK/DjFNWfIz7qZm1DnDCD/Ve2af
        5aC/IdRhaX637vk6QyejVg2PZj1lqSZHppPAhQctMDq28CisRgSZGKpoNApF0ApW
        23PlTX9xNJpaAQEm/kBsdznnzlNzdMIvr9nYY1X/El5bsMAmtCIkd8Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fAqBZo
        yuXQbc0jbuBUfb/Ov5yXGEQBn0rxhq7UBBsaM=; b=EX5FSqR5H2MUYWHSAGXHMO
        uXUNweBpBl6uXA6hgCbI1omawj02EC9QS15pdj2H1T8vz+dTNS4I3+LjskMsPmjB
        aND7Zv8nrm1ARU2ZiTTmObySoBl48Q/WhTHyaAeMN6VURPpSrlRbqXEI7PqKHV9D
        XCHZrR4B6Jjwn1j73Ekrekix1tW2tFGhRwveazfMfLBO9FUcKfuR9xzuTKKUvcYe
        hIOjNJdx5J1MvqrFy8pn4ftvHByFwOAG9pirp03Qez7GfAb8qjcKRR1eDSlwrN/W
        B0W+nSI0WWxPaktWwhSNnplO6SCigjhwQ8AIqdIwMVPYvz5VIzgNrxh992VSsw5A
        ==
X-ME-Sender: <xms:naYkYolAt3JaglncPM_q0SgLzH_9_RSNEWgSI-AUa9gT2FO45Y5dwg>
    <xme:naYkYn2sQxBNl--wQdG4NsexJma9e_13E8uF4tl72Eq8oVZFX868kj67tWOepcxUK
    0Tw9sWxPh_HzDXOnuU>
X-ME-Received: <xmr:naYkYmoXZRoq96nQHVh9OITRiwKH-vFvv_bwP1TKpxU2Sbmpwvdv18qFQw_j7dRFJIX03lyJV2MOCbIba22_MjhkbJvG2QYpRrIjhS8xp51IhnGfw0BaWm2pIngHN08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudduvddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:naYkYkmgr9bagCFd1l7_jUSf5m618nllMhf4FUHLFkYx2QJGwlUk9Q>
    <xmx:naYkYm2ZWICu4Ma7pF2d0troxT9MmbG8lwaY8UclZdxmv2m_zpKsBQ>
    <xmx:naYkYrvd87b3chnk5z_AEDUjLhDILEmbgk7uJTTUNxVYBMTN3YsO5g>
    <xmx:naYkYkxlAQDrgtXagbU2PG4o-Xo2nuEOMcB9jzs_AgDke7i-rRdpXg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Mar 2022 07:18:35 -0500 (EST)
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
Subject: [PATCH v2 2/2] nvmem: Add Apple eFuse driver
Date:   Sun,  6 Mar 2022 13:18:16 +0100
Message-Id: <20220306121816.70537-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220306121816.70537-1-sven@svenpeter.dev>
References: <20220306121816.70537-1-sven@svenpeter.dev>
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
v1 -> v2:
  - fixed sparse warning about __iomem by introducing
    struct apple_efuses_priv as done in other nvmem drivers
  - make sure the driver actually works as a module by
    setting .owner to THIS_MODULE and adding MODULE_DEVICE_TABLE
    pointed out by Joey Gouly

 MAINTAINERS                  |  1 +
 drivers/nvmem/Kconfig        | 12 ++++++
 drivers/nvmem/Makefile       |  2 +
 drivers/nvmem/apple-efuses.c | 82 ++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 drivers/nvmem/apple-efuses.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f70d8525cbd4..e3e973a3f651 100644
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
index 000000000000..dd5576ec5408
--- /dev/null
+++ b/drivers/nvmem/apple-efuses.c
@@ -0,0 +1,82 @@
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
+		.owner = THIS_MODULE,
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
+		.owner = THIS_MODULE,
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

