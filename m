Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74624FAE20
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiDJN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbiDJN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 09:56:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E646580C1;
        Sun, 10 Apr 2022 06:54:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8345A5C00F9;
        Sun, 10 Apr 2022 09:54:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 10 Apr 2022 09:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=Ra2f5OVvum6qyC
        ydfuFWdYT4SYyCGdf7Q2RUJs0cQhY=; b=FSdu5GymRcPlnjOkH4jXL+KBZVD9Ot
        ZkAeLxgjSMlRDTVUVK7o2UKWoySzFROYPDYPb9XGV+pTGeY7CbC2biPO2INsDeIT
        J/49tu2KfeNnZwzVkPvYJsqZc53FJ7fZiz7+TE5Q96qgEszQkvAuLzRN//0upvUh
        2VMumYNdpRJ70gyDc24nJbKZauHKkVGhmvcd1PWbCyZGO4pWCZ1T9G9t/pVLEGzC
        S0rmJSFRO9nc54+zpKKKBXbNFWM87aRl+qAavUy2MybUdtYY4jRCcghyhFpvugJC
        Py4nYyIEYnl+29QnyHUw+CGtX7o6uU+6bQoy9vxOmqmCjVkU2ab2NmMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Ra2f5O
        Vvum6qyCydfuFWdYT4SYyCGdf7Q2RUJs0cQhY=; b=nys6of3i69rmu2dpmwQ4eO
        iqI7CqFlToo0BAcAMluwurS3c4UHgotzxI47SIIw/1BdMNyzGxzInye75pzXXJjU
        LiZNKxXM+CcGLo5AxT7tUQhIATIVjAT/2di14HT7OUiuNcvsNvMd1ln9PefK8jYy
        4+4/N5N6DOyNTGD6WFH9aGuuIeYJPMCjydnBWdj5Tk6a2cWoD3a+pDzVzZbiQ8oT
        JZfXATF0qMl6qxEUyWnsA5xkSHKUCyjWAQZCrdLOQ8GRNZl8Md0luM5Zm159Q3Tz
        HU0qXz1HoWbjJwzl/NzQv/fAxBHFcImkETx02OC67fUwxYPhlQOHXCmnRbFzx/JQ
        ==
X-ME-Sender: <xms:kuFSYs-NCi08A0VMohqZ2xZUXlf2Q0_lgR_8H0E1CDrbLE9noCY8Qw>
    <xme:kuFSYkt3sC1F-Ul5xtmAEaa0L2yiG4IMDWQ6-vqKJ1sbSd-mPveujJ7II7cNHlVPj
    yJwBBEZNZEFtQ33XW8>
X-ME-Received: <xmr:kuFSYiCF1PlEoRzOCI9e1ohSBnVDPIYI-tQ9pPUcoMbxvbBi-FLlGlbsiwQkrXFgCmAZDQH1Glitzej8w2IaFfEC5RIFwdxjG3hWmqlzzUYquN_ovNYx8P6MwarTygI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:kuFSYsfaeg0CLFcxpSK4NtZ2sphFeN1dTmMrJqdMTdFhh0fT_gFSmA>
    <xmx:kuFSYhO1lZtF80nsXDYwK-Sifc6mSMhg5Lgg5YWSK3wsZFT6-06stQ>
    <xmx:kuFSYmnH16ejr2LZSgsz-BLxYTIznltp5P-oA6O1CJOiK2z_e_lV7g>
    <xmx:kuFSYko7KEF4k48F1VMBIPYrI_sDgMOdWvkMjQtIM8Z8Miv9ZyfmKA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Apr 2022 09:54:24 -0400 (EDT)
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
Subject: [PATCH v4 3/3] nvmem: Add Apple eFuse driver
Date:   Sun, 10 Apr 2022 15:54:14 +0200
Message-Id: <20220410135414.20606-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220410135414.20606-1-sven@svenpeter.dev>
References: <20220410135414.20606-1-sven@svenpeter.dev>
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
v3 -> v4:
  - rebased on 5.18-rc1 and split off MAINTAINER changes as requested
    by Srinivas Kandagatla
v2 -> v3:
  - removed .owner = THIS_MODULE again since it's already done by the
    core as pointed out by Krzysztof Kozlowski
v1 -> v2:
  - fixed sparse warning about __iomem by introducing
    struct apple_efuses_priv as done in other nvmem drivers
  - make sure the driver actually works as a module by
    setting .owner to THIS_MODULE and adding MODULE_DEVICE_TABLE
    pointed out by Joey Gouly

 drivers/nvmem/Kconfig        | 12 ++++++
 drivers/nvmem/Makefile       |  2 +
 drivers/nvmem/apple-efuses.c | 80 ++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/nvmem/apple-efuses.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 555aa77a574d..6283e09cc1e9 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -324,4 +324,16 @@ config NVMEM_SUNPLUS_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sunplus-ocotp.
 
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
index 891958e29d25..00e136a0a123 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -65,3 +65,5 @@ obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
 nvmem-layerscape-sfp-y		:= layerscape-sfp.o
 obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
 nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
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

