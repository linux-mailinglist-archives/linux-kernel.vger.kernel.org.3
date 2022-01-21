Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31AD496123
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381416AbiAUOeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:34:24 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:43644 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381101AbiAUOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:33:23 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20L6W2WU017662;
        Fri, 21 Jan 2022 08:33:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=/TLrm4d3U/sEY8UqGOdlkkiMo7BlmRWnr/kv/z56glc=;
 b=OayBnmrdkOwIA2LB6/LujBGvMNNaEO+wJ08JTG9LHP9NnbIbzTokNH0ZKVUu3SFNpg7m
 hHcakHjp7mybjCXFFH2fT/9fDlq38bnMMkhnoosXXE4XhtDik06ZQ3D/umakQBXv47DW
 6UUPojXotVBU/8ZJiyaisNGv1J85jim+QVLiVAPYezjRcWJ4ZSQgDiocCuBSCBGqe3t4
 E8yOoO8sDlVJXrxwBKX8WJhGQAwJmJIqZoHXvxDEARO2GQ7j517lqmEL0S6BrMI4HlOY
 eObfHb57wYf1N2pz6wAlkq30fLN77365TUpR+mf3/itGSRMtmYQS/zXxm6m1pF+pRPx0 Ww== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhyq0up3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 08:33:00 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 14:32:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 14:32:58 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 186B945D;
        Fri, 21 Jan 2022 14:32:58 +0000 (UTC)
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
Subject: [PATCH v5 5/9] platform/x86: i2c-multi-instantiate: Rename it for a generic serial driver name
Date:   Fri, 21 Jan 2022 14:32:50 +0000
Message-ID: <20220121143254.6432-6-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121143254.6432-1-sbinding@opensource.cirrus.com>
References: <20220121143254.6432-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: G3HlgXnm8H3UWllofW035CK-x4VFZklJ
X-Proofpoint-ORIG-GUID: G3HlgXnm8H3UWllofW035CK-x4VFZklJ
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Rename I2C multi instantiate driver to serial-multi-instantiate for
upcoming addition of SPI support

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 MAINTAINERS                                   |  4 +-
 drivers/acpi/scan.c                           |  2 +-
 drivers/platform/x86/Kconfig                  |  4 +-
 drivers/platform/x86/Makefile                 |  2 +-
 ...stantiate.c => serial-multi-instantiate.c} | 89 +++++++++----------
 5 files changed, 50 insertions(+), 51 deletions(-)
 rename drivers/platform/x86/{i2c-multi-instantiate.c => serial-multi-instantiate.c} (52%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e828542b089..be50537ea6bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -388,11 +388,11 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
 
-ACPI I2C MULTI INSTANTIATE DRIVER
+ACPI SERIAL MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/i2c-multi-instantiate.c
+F:	drivers/platform/x86/serial-multi-instantiate.c
 
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@arm.com>
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1331756d4cfc..8b237eb4e029 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1738,7 +1738,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * must be instantiated for each, each with its own i2c_device_id.
 	 * Normally we only instantiate an i2c-client for the first resource,
 	 * using the ACPI HID as id. These special cases are handled by the
-	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
+	 * drivers/platform/x86/serial-multi-instantiate.c driver, which knows
 	 * which i2c_device_id to use for each resource.
 	 */
 		{"BSG1160", },
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 24deeeb29af2..5b65d687f046 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -990,7 +990,7 @@ config TOPSTAR_LAPTOP
 
 	  If you have a Topstar laptop, say Y or M here.
 
-config I2C_MULTI_INSTANTIATE
+config SERIAL_MULTI_INSTANTIATE
 	tristate "I2C multi instantiate pseudo device driver"
 	depends on I2C && ACPI
 	help
@@ -999,7 +999,7 @@ config I2C_MULTI_INSTANTIATE
 	  for each device in the firmware-node.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called i2c-multi-instantiate.
+	  will be called serial-multi-instantiate.
 
 config MLX_PLATFORM
 	tristate "Mellanox Technologies platform support"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c12a9b044fd8..9527088bba7f 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -110,7 +110,7 @@ obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 
 # Platform drivers
 obj-$(CONFIG_FW_ATTR_CLASS)		+= firmware_attributes_class.o
-obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
+obj-$(CONFIG_SERIAL_MULTI_INSTANTIATE)	+= serial-multi-instantiate.o
 obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
similarity index 52%
rename from drivers/platform/x86/i2c-multi-instantiate.c
rename to drivers/platform/x86/serial-multi-instantiate.c
index 4956a1df5b90..32fb3f904547 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * I2C multi-instantiate driver, pseudo driver to instantiate multiple
+ * Serial multi-instantiate driver, pseudo driver to instantiate multiple
  * i2c-clients from a single fwnode.
  *
  * Copyright 2018 Hans de Goede <hdegoede@redhat.com>
@@ -21,29 +21,29 @@
 #define IRQ_RESOURCE_GPIO	1
 #define IRQ_RESOURCE_APIC	2
 
-struct i2c_inst_data {
+struct smi_instance {
 	const char *type;
 	unsigned int flags;
 	int irq_idx;
 };
 
-struct i2c_multi_inst_data {
-	int num_clients;
-	struct i2c_client *clients[];
+struct smi {
+	int i2c_num;
+	struct i2c_client *i2c_devs[];
 };
 
-static int i2c_multi_inst_probe(struct platform_device *pdev)
+static int smi_probe(struct platform_device *pdev)
 {
-	struct i2c_multi_inst_data *multi;
-	const struct i2c_inst_data *inst_data;
 	struct i2c_board_info board_info = {};
+	const struct smi_instance *inst;
 	struct device *dev = &pdev->dev;
 	struct acpi_device *adev;
+	struct smi *smi;
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
+	smi = devm_kmalloc(dev, struct_size(smi, i2c_devs, ret), GFP_KERNEL);
+	if (!smi)
 		return -ENOMEM;
 
-	multi->num_clients = ret;
+	smi->i2c_num = ret;
 
-	for (i = 0; i < multi->num_clients && inst_data[i].type; i++) {
+	for (i = 0; i < smi->i2c_num && inst[i].type; i++) {
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
+		smi->i2c_devs[i] = i2c_acpi_new_device(dev, i, &board_info);
+		if (IS_ERR(smi->i2c_devs[i])) {
+			ret = dev_err_probe(dev, PTR_ERR(smi->i2c_devs[i]),
 					    "Error creating i2c-client, idx %d\n", i);
 			goto error;
 		}
 	}
-	if (i < multi->num_clients) {
+	if (i < smi->i2c_num) {
 		dev_err(dev, "Error finding driver, idx %d\n", i);
 		ret = -ENODEV;
 		goto error;
 	}
 
-	platform_set_drvdata(pdev, multi);
+	platform_set_drvdata(pdev, smi);
 	return 0;
 
 error:
 	while (--i >= 0)
-		i2c_unregister_device(multi->clients[i]);
+		i2c_unregister_device(smi->i2c_devs[i]);
 
 	return ret;
 }
 
-static int i2c_multi_inst_remove(struct platform_device *pdev)
+static int smi_remove(struct platform_device *pdev)
 {
-	struct i2c_multi_inst_data *multi = platform_get_drvdata(pdev);
+	struct smi *smi = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < multi->num_clients; i++)
-		i2c_unregister_device(multi->clients[i]);
+	for (i = 0; i < smi->i2c_num; i++)
+		i2c_unregister_device(smi->i2c_devs[i]);
 
 	return 0;
 }
 
-static const struct i2c_inst_data bsg1160_data[]  = {
+static const struct smi_instance bsg1160_data[]  = {
 	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
 	{ "bmc150_magn" },
 	{ "bmg160" },
 	{}
 };
 
-static const struct i2c_inst_data bsg2150_data[]  = {
+static const struct smi_instance bsg2150_data[]  = {
 	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
 	{ "bmc150_magn" },
 	/* The resources describe a 3th client, but it is not really there. */
@@ -139,7 +138,7 @@ static const struct i2c_inst_data bsg2150_data[]  = {
 	{}
 };
 
-static const struct i2c_inst_data int3515_data[]  = {
+static const struct smi_instance int3515_data[]  = {
 	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
 	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
 	{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
@@ -148,27 +147,27 @@ static const struct i2c_inst_data int3515_data[]  = {
 };
 
 /*
- * Note new device-ids must also be added to i2c_multi_instantiate_ids in
+ * Note new device-ids must also be added to serial_multi_instantiate_ids in
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
  */
-static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
+static const struct acpi_device_id smi_acpi_ids[] = {
 	{ "BSG1160", (unsigned long)bsg1160_data },
 	{ "BSG2150", (unsigned long)bsg2150_data },
 	{ "INT3515", (unsigned long)int3515_data },
 	{ }
 };
-MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
+MODULE_DEVICE_TABLE(acpi, smi_acpi_ids);
 
-static struct platform_driver i2c_multi_inst_driver = {
+static struct platform_driver smi_driver = {
 	.driver	= {
-		.name = "I2C multi instantiate pseudo device driver",
-		.acpi_match_table = i2c_multi_inst_acpi_ids,
+		.name = "Serial multi instantiate pseudo device driver",
+		.acpi_match_table = smi_acpi_ids,
 	},
-	.probe = i2c_multi_inst_probe,
-	.remove = i2c_multi_inst_remove,
+	.probe = smi_probe,
+	.remove = smi_remove,
 };
-module_platform_driver(i2c_multi_inst_driver);
+module_platform_driver(smi_driver);
 
-MODULE_DESCRIPTION("I2C multi instantiate pseudo device driver");
+MODULE_DESCRIPTION("Serial multi instantiate pseudo device driver");
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_LICENSE("GPL");
-- 
2.25.1

