Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE24928EF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbiARO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:56:33 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:51750 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344773AbiAROy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:54:27 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20IBxOsE014314;
        Tue, 18 Jan 2022 08:53:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=cHG2T95GkMFg9HkotdNEAkG+vNASe6V+mLIIky/93Iw=;
 b=Lvy7W7iq9C1PnwjQYRllggnwQPxanVVWF/Bh+RjlNk1KBIaIyAosr9qHUqWu0XIYERce
 MpX82FeU2DYpcDbnumQyPScwUwJuScivYFy8/BSvRvr0Y6yQdjGYXJ9ik5b01kRfwy23
 Em34T9X9+gqK1I1xxsTpxU5wDrjLLbHTvXymxJRFaLCJNZRzGeLEDKpTRzUtKEg2AHWB
 mvZ5puMLoK3FBgIr9IS2DtKeXjRTS/6d+vRcLDKDDHiQOMcQ1Dzh9RvQDcpQ+zomwelf
 NFUhuxygaOM/TtqK2Cp4XJbcW3S1AyTl1/T3+XJbYSuClqQObTjSapN8K6Fsxr5qS4gD uw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dn8k2s8t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Jan 2022 08:53:42 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 14:53:41 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 18 Jan 2022 14:53:41 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 74ED17C;
        Tue, 18 Jan 2022 14:53:39 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 06/10] ACPI: i2c-multi-instantiate: Rename it for a generic bus driver name
Date:   Tue, 18 Jan 2022 14:52:47 +0000
Message-ID: <20220118145251.1548-7-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
References: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Wm9lIOa2RMv5RJeFSUXSxflsKpfspxx1
X-Proofpoint-ORIG-GUID: Wm9lIOa2RMv5RJeFSUXSxflsKpfspxx1
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Rename I2C multi instantiate driver to bus-multi-instantiate for
upcoming addition of SPI support

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 MAINTAINERS                                   |  4 +-
 drivers/acpi/Kconfig                          |  4 +-
 drivers/acpi/Makefile                         |  2 +-
 ...-instantiate.c => bus-multi-instantiate.c} | 89 +++++++++----------
 drivers/acpi/scan.c                           |  2 +-
 5 files changed, 50 insertions(+), 51 deletions(-)
 rename drivers/acpi/{i2c-multi-instantiate.c => bus-multi-instantiate.c} (53%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546f9e149d28..df2d7b43b133 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -388,11 +388,11 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
 
-ACPI I2C MULTI INSTANTIATE DRIVER
+ACPI BUS MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/acpi/i2c-multi-instantiate.c
+F:	drivers/acpi/bus-multi-instantiate.c
 
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@arm.com>
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 2fd78366af6f..cb414113c238 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -295,7 +295,7 @@ config ACPI_PROCESSOR
 	  To compile this driver as a module, choose M here:
 	  the module will be called processor.
 
-config ACPI_I2C_MULTI_INST
+config ACPI_BUS_MULTI_INST
 	tristate "I2C multi instantiate pseudo device driver"
 	depends on I2C
 	help
@@ -304,7 +304,7 @@ config ACPI_I2C_MULTI_INST
 	  for each device in the firmware-node.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called i2c-multi-instantiate.
+	  will be called bus-multi-instantiate.
 
 config ACPI_IPMI
 	tristate "IPMI"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d4db7fb0baf0..2bb3b5c40019 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -104,7 +104,7 @@ obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
-obj-$(CONFIG_ACPI_I2C_MULTI_INST)	+= i2c-multi-instantiate.o
+obj-$(CONFIG_ACPI_BUS_MULTI_INST)	+= bus-multi-instantiate.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/i2c-multi-instantiate.c b/drivers/acpi/bus-multi-instantiate.c
similarity index 53%
rename from drivers/acpi/i2c-multi-instantiate.c
rename to drivers/acpi/bus-multi-instantiate.c
index 4956a1df5b90..982dfecfd27c 100644
--- a/drivers/acpi/i2c-multi-instantiate.c
+++ b/drivers/acpi/bus-multi-instantiate.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * I2C multi-instantiate driver, pseudo driver to instantiate multiple
+ * Bus multi-instantiate driver, pseudo driver to instantiate multiple
  * i2c-clients from a single fwnode.
  *
  * Copyright 2018 Hans de Goede <hdegoede@redhat.com>
@@ -21,29 +21,29 @@
 #define IRQ_RESOURCE_GPIO	1
 #define IRQ_RESOURCE_APIC	2
 
-struct i2c_inst_data {
+struct bmi_instance {
 	const char *type;
 	unsigned int flags;
 	int irq_idx;
 };
 
-struct i2c_multi_inst_data {
-	int num_clients;
-	struct i2c_client *clients[];
+struct bmi {
+	int i2c_num;
+	struct i2c_client *i2c_devs[];
 };
 
-static int i2c_multi_inst_probe(struct platform_device *pdev)
+static int bmi_probe(struct platform_device *pdev)
 {
-	struct i2c_multi_inst_data *multi;
-	const struct i2c_inst_data *inst_data;
 	struct i2c_board_info board_info = {};
+	const struct bmi_instance *inst;
 	struct device *dev = &pdev->dev;
 	struct acpi_device *adev;
+	struct bmi *bmi;
 	char name[32];
 	int i, ret;
 
-	inst_data = device_get_match_data(dev);
-	if (!inst_data) {
+	inst = device_get_match_data(dev);
+	if (!inst) {
 		dev_err(dev, "Error ACPI match data is missing\n");
 		return -ENODEV;
 	}
@@ -55,33 +55,32 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	multi = devm_kmalloc(dev, struct_size(multi, clients, ret), GFP_KERNEL);
-	if (!multi)
+	bmi = devm_kmalloc(dev, struct_size(bmi, i2c_devs, ret), GFP_KERNEL);
+	if (!bmi)
 		return -ENOMEM;
 
-	multi->num_clients = ret;
+	bmi->i2c_num = ret;
 
-	for (i = 0; i < multi->num_clients && inst_data[i].type; i++) {
+	for (i = 0; i < bmi->i2c_num && inst[i].type; i++) {
 		memset(&board_info, 0, sizeof(board_info));
-		strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
-		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev),
-			 inst_data[i].type, i);
+		strlcpy(board_info.type, inst[i].type, I2C_NAME_SIZE);
+		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst[i].type, i);
 		board_info.dev_name = name;
-		switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
+		switch (inst[i].flags & IRQ_RESOURCE_TYPE) {
 		case IRQ_RESOURCE_GPIO:
-			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
+			ret = acpi_dev_gpio_irq_get(adev, inst[i].irq_idx);
 			if (ret < 0) {
 				dev_err(dev, "Error requesting irq at index %d: %d\n",
-					inst_data[i].irq_idx, ret);
+						inst[i].irq_idx, ret);
 				goto error;
 			}
 			board_info.irq = ret;
 			break;
 		case IRQ_RESOURCE_APIC:
-			ret = platform_get_irq(pdev, inst_data[i].irq_idx);
+			ret = platform_get_irq(pdev, inst[i].irq_idx);
 			if (ret < 0) {
 				dev_dbg(dev, "Error requesting irq at index %d: %d\n",
-					inst_data[i].irq_idx, ret);
+					inst[i].irq_idx, ret);
 				goto error;
 			}
 			board_info.irq = ret;
@@ -90,48 +89,48 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 			board_info.irq = 0;
 			break;
 		}
-		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
-		if (IS_ERR(multi->clients[i])) {
-			ret = dev_err_probe(dev, PTR_ERR(multi->clients[i]),
+		bmi->i2c_devs[i] = i2c_acpi_new_device(dev, i, &board_info);
+		if (IS_ERR(bmi->i2c_devs[i])) {
+			ret = dev_err_probe(dev, PTR_ERR(bmi->i2c_devs[i]),
 					    "Error creating i2c-client, idx %d\n", i);
 			goto error;
 		}
 	}
-	if (i < multi->num_clients) {
+	if (i < bmi->i2c_num) {
 		dev_err(dev, "Error finding driver, idx %d\n", i);
 		ret = -ENODEV;
 		goto error;
 	}
 
-	platform_set_drvdata(pdev, multi);
+	platform_set_drvdata(pdev, bmi);
 	return 0;
 
 error:
 	while (--i >= 0)
-		i2c_unregister_device(multi->clients[i]);
+		i2c_unregister_device(bmi->i2c_devs[i]);
 
 	return ret;
 }
 
-static int i2c_multi_inst_remove(struct platform_device *pdev)
+static int bmi_remove(struct platform_device *pdev)
 {
-	struct i2c_multi_inst_data *multi = platform_get_drvdata(pdev);
+	struct bmi *bmi = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < multi->num_clients; i++)
-		i2c_unregister_device(multi->clients[i]);
+	for (i = 0; i < bmi->i2c_num; i++)
+		i2c_unregister_device(bmi->i2c_devs[i]);
 
 	return 0;
 }
 
-static const struct i2c_inst_data bsg1160_data[]  = {
+static const struct bmi_instance bsg1160_data[]  = {
 	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
 	{ "bmc150_magn" },
 	{ "bmg160" },
 	{}
 };
 
-static const struct i2c_inst_data bsg2150_data[]  = {
+static const struct bmi_instance bsg2150_data[]  = {
 	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
 	{ "bmc150_magn" },
 	/* The resources describe a 3th client, but it is not really there. */
@@ -139,7 +138,7 @@ static const struct i2c_inst_data bsg2150_data[]  = {
 	{}
 };
 
-static const struct i2c_inst_data int3515_data[]  = {
+static const struct bmi_instance int3515_data[]  = {
 	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
 	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
 	{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
@@ -148,27 +147,27 @@ static const struct i2c_inst_data int3515_data[]  = {
 };
 
 /*
- * Note new device-ids must also be added to i2c_multi_instantiate_ids in
+ * Note new device-ids must also be added to bus_multi_instantiate_ids in
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
  */
-static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
+static const struct acpi_device_id bmi_acpi_ids[] = {
 	{ "BSG1160", (unsigned long)bsg1160_data },
 	{ "BSG2150", (unsigned long)bsg2150_data },
 	{ "INT3515", (unsigned long)int3515_data },
 	{ }
 };
-MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
+MODULE_DEVICE_TABLE(acpi, bmi_acpi_ids);
 
-static struct platform_driver i2c_multi_inst_driver = {
+static struct platform_driver bmi_driver = {
 	.driver	= {
-		.name = "I2C multi instantiate pseudo device driver",
-		.acpi_match_table = i2c_multi_inst_acpi_ids,
+		.name = "Bus multi instantiate pseudo device driver",
+		.acpi_match_table = bmi_acpi_ids,
 	},
-	.probe = i2c_multi_inst_probe,
-	.remove = i2c_multi_inst_remove,
+	.probe = bmi_probe,
+	.remove = bmi_remove,
 };
-module_platform_driver(i2c_multi_inst_driver);
+module_platform_driver(bmi_driver);
 
-MODULE_DESCRIPTION("I2C multi instantiate pseudo device driver");
+MODULE_DESCRIPTION("Bus multi instantiate pseudo device driver");
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3e85a02f6ba2..a015a3b1d6f2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1738,7 +1738,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * must be instantiated for each, each with its own i2c_device_id.
 	 * Normally we only instantiate an i2c-client for the first resource,
 	 * using the ACPI HID as id. These special cases are handled by the
-	 * drivers/acpi/i2c-multi-instantiate.c driver, which knows
+	 * drivers/acpi/bus-multi-instantiate.c driver, which knows
 	 * which i2c_device_id to use for each resource.
 	 */
 		{"BSG1160", },
-- 
2.25.1

