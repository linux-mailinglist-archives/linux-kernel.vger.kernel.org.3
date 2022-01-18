Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7504928E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbiAROyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:54:45 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:63344 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344337AbiAROyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:54:00 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20I1MV5t021792;
        Tue, 18 Jan 2022 08:53:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=YkKWuYqHlYN+uhZ693dYf8OMpvb2YiGDbgFVPAVglcA=;
 b=HUVtNz0iCMLrdAuhwgzakdXSUDuRRe+G5mI8CFuy42g1DM51Xr8+FvrZyRrWHvYlBEa5
 GOU/pXC+RwXfml/IdUk7to9XE90GQmR4XCcOLyohSONhW6PHCS6ATFJXiz70rKvKcxU1
 n2VRjmzxnA2hZSHFgBk098KxeDO1c6Qe4HtopmlaeoK0L7AISiRYFoxOcmpyLBUbwRXL
 sGpXyESmBYcngKyBxH7fMnHSJmrqzUk7/+Z8qJMZI9S9+jrT2uEvuKg5XFVhIoQJuW2P
 3jMwaJ+lw1MF9l9il3GcrFh+bDD/qCrCqOdLR+Y+Zzg2WNpYRZFhQa5Q5jbu6fZ/bbTs FQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dnaxhs9nc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Jan 2022 08:53:40 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 14:53:39 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 18 Jan 2022 14:53:39 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9109AB13;
        Tue, 18 Jan 2022 14:53:37 +0000 (UTC)
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
Subject: [PATCH v3 05/10] platform/x86: i2c-multi-instantiate: Move it to drivers/acpi folder
Date:   Tue, 18 Jan 2022 14:52:46 +0000
Message-ID: <20220118145251.1548-6-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
References: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: h4wy_AJ5f5ZEYElDJVqkuKqZaNfd4b8X
X-Proofpoint-ORIG-GUID: h4wy_AJ5f5ZEYElDJVqkuKqZaNfd4b8X
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Moving I2C multi instantiate driver to drivers/acpi folder for
upcoming conversion into a generic bus multi instantiate
driver for SPI and I2C

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 MAINTAINERS                                           |  2 +-
 drivers/acpi/Kconfig                                  | 11 +++++++++++
 drivers/acpi/Makefile                                 |  1 +
 .../{platform/x86 => acpi}/i2c-multi-instantiate.c    |  0
 drivers/acpi/scan.c                                   |  2 +-
 drivers/platform/x86/Kconfig                          | 11 -----------
 drivers/platform/x86/Makefile                         |  1 -
 7 files changed, 14 insertions(+), 14 deletions(-)
 rename drivers/{platform/x86 => acpi}/i2c-multi-instantiate.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e828542b089..546f9e149d28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -392,7 +392,7 @@ ACPI I2C MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/i2c-multi-instantiate.c
+F:	drivers/acpi/i2c-multi-instantiate.c
 
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@arm.com>
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ba45541b1f1f..2fd78366af6f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -295,6 +295,17 @@ config ACPI_PROCESSOR
 	  To compile this driver as a module, choose M here:
 	  the module will be called processor.
 
+config ACPI_I2C_MULTI_INST
+	tristate "I2C multi instantiate pseudo device driver"
+	depends on I2C
+	help
+	  Some ACPI-based systems list multiple i2c-devices in a single ACPI
+	  firmware-node. This driver will instantiate separate i2c-clients
+	  for each device in the firmware-node.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called i2c-multi-instantiate.
+
 config ACPI_IPMI
 	tristate "IPMI"
 	depends on IPMI_HANDLER
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index bb757148e7ba..d4db7fb0baf0 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
+obj-$(CONFIG_ACPI_I2C_MULTI_INST)	+= i2c-multi-instantiate.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/acpi/i2c-multi-instantiate.c
similarity index 100%
rename from drivers/platform/x86/i2c-multi-instantiate.c
rename to drivers/acpi/i2c-multi-instantiate.c
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1331756d4cfc..3e85a02f6ba2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1738,7 +1738,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * must be instantiated for each, each with its own i2c_device_id.
 	 * Normally we only instantiate an i2c-client for the first resource,
 	 * using the ACPI HID as id. These special cases are handled by the
-	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
+	 * drivers/acpi/i2c-multi-instantiate.c driver, which knows
 	 * which i2c_device_id to use for each resource.
 	 */
 		{"BSG1160", },
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 24deeeb29af2..37c1c150508d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -990,17 +990,6 @@ config TOPSTAR_LAPTOP
 
 	  If you have a Topstar laptop, say Y or M here.
 
-config I2C_MULTI_INSTANTIATE
-	tristate "I2C multi instantiate pseudo device driver"
-	depends on I2C && ACPI
-	help
-	  Some ACPI-based systems list multiple i2c-devices in a single ACPI
-	  firmware-node. This driver will instantiate separate i2c-clients
-	  for each device in the firmware-node.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called i2c-multi-instantiate.
-
 config MLX_PLATFORM
 	tristate "Mellanox Technologies platform support"
 	depends on I2C && REGMAP
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c12a9b044fd8..6c7870190564 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -110,7 +110,6 @@ obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 
 # Platform drivers
 obj-$(CONFIG_FW_ATTR_CLASS)		+= firmware_attributes_class.o
-obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
 obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
-- 
2.25.1

