Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E74791BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbhLQQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbhLQQnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:43:42 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE07C061747;
        Fri, 17 Dec 2021 08:43:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z7so9968627edc.11;
        Fri, 17 Dec 2021 08:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+vpZiLGopVhbYaJLmpdtyEiut3DxKPDgvYr0Y0r6uaE=;
        b=dZ/eHG5WAkkaucevKU13Hu/i81ZJRs6qdXoRcUWG5BpYaTC+r6jmxxbsb4d+wRnY3D
         MWCeRcGrklwlI2aUs9OmXtVDHvKwcxoxbXwyt9H3KqmjwZd7X1fsCPkotsWxhNRqCWc+
         +AN2id4Uz++PZ669qxe4xywaRXykPsi3coEeFbsx1aV7Qg9bavvW6qnW77Zn2BGkh47e
         gfD78r9eZF2VImOFQRvGUiOTChU4Ke4euK/SOHS+JhfW2fVgNFQMMPdfYtfpbCajopxC
         jGId37B3rDeM08J5kKqam8yb9k2a6lB6bDh3enu2J+PWtgOqIKYHajAzz2faFoz63vyM
         eOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vpZiLGopVhbYaJLmpdtyEiut3DxKPDgvYr0Y0r6uaE=;
        b=A+KBAndLIURDa1S9ZLFaEn10riXVpORR5DfUfLpjcARFzxenzb4pWY8RC5cxTWVmz1
         3ijbdYKu0TEROc9jUKT0efvP2NYg2vM55ENH4X86g9r0vaBucD4pvDssc39cmAt4r9cS
         zq5/ExZoCIznakDQF2sWSczSZb0Dpx2ahz56S+zt3Q8IzTYEV7mGWtW7dLw/pygmN7tr
         aVZfaRUHRzV5gxK7RYFoUhhf2bgJaOyNgnKtPPpD7Y7yaFrFUI6t6xJrWckXKwIrildF
         20J5Coj5B396C29tQq7ezAD1fip3rgNROwi0PK5YjddFSg+MccpQ9RVi0iVL4QfgBIco
         lRHQ==
X-Gm-Message-State: AOAM531U3i8tGM+zysa8auXE810lFehwBhvatVmTOTcm1xRbKehlAaXL
        i3n9UHziE59duxHS+pG1agA=
X-Google-Smtp-Source: ABdhPJzIBOQKjPthX/WSStL2nDV2XaD2/hUXTEFO8h6bHoIYEFMwNYOWQcJlLsX5/qB1wgbVxoo15g==
X-Received: by 2002:a17:906:2a48:: with SMTP id k8mr3328272eje.758.1639759420494;
        Fri, 17 Dec 2021 08:43:40 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f34ba00f711d38e28b691af.dip0.t-ipconnect.de. [2003:cf:9f34:ba00:f711:d38e:28b6:91af])
        by smtp.googlemail.com with ESMTPSA id f22sm3955906edf.93.2021.12.17.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:43:40 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (asus_wmi_ec_sensors) remove the driver
Date:   Fri, 17 Dec 2021 17:43:06 +0100
Message-Id: <20211217164307.1514192-4-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217164307.1514192-1-eugene.shalygin@gmail.com>
References: <20211217164307.1514192-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is superceeded by asus-ec-sensors

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 MAINTAINERS                         |   7 -
 drivers/hwmon/Kconfig               |  12 -
 drivers/hwmon/Makefile              |   1 -
 drivers/hwmon/asus_wmi_ec_sensors.c | 621 ----------------------------
 4 files changed, 641 deletions(-)
 delete mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 845f09bc0457..6d2589d1d242 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3005,13 +3005,6 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/asus_wmi_sensors.c
 
-ASUS WMI EC HARDWARE MONITOR DRIVER
-M:	Eugene Shalygin <eugene.shalygin@gmail.com>
-M:	Denis Pauk <pauk.denis@gmail.com>
-L:	linux-hwmon@vger.kernel.org
-S:	Maintained
-F:	drivers/hwmon/asus_wmi_ec_sensors.c
-
 ASUS EC HARDWARE MONITOR DRIVER
 M:	Eugene Shalygin <eugene.shalygin@gmail.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2c16b19d2c03..6f43c5dcb0dd 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2241,18 +2241,6 @@ config SENSORS_ASUS_WMI
 	  This driver can also be built as a module. If so, the module
 	  will be called asus_wmi_sensors.
 
-config SENSORS_ASUS_WMI_EC
-	tristate "ASUS WMI B550/X570"
-	depends on ACPI_WMI
-	help
-	  If you say yes here you get support for the ACPI embedded controller
-	  hardware monitoring interface found in B550/X570 ASUS motherboards.
-	  This driver will provide readings of fans, voltages and temperatures
-	  through the system firmware.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called asus_wmi_sensors_ec.
-
 config SENSORS_ASUS_EC
 	tristate "ASUS EC Sensors"
 	help
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 2e5c216bb5d7..71eb2d548e20 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_SENSORS_ACPI_POWER) += acpi_power_meter.o
 obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
 obj-$(CONFIG_SENSORS_ASUS_EC)	+= asus-ec-sensors.o
 obj-$(CONFIG_SENSORS_ASUS_WMI)	+= asus_wmi_sensors.o
-obj-$(CONFIG_SENSORS_ASUS_WMI_EC)	+= asus_wmi_ec_sensors.o
 
 # Native drivers
 # asb100, then w83781d go first, as they can override other drivers' addresses.
diff --git a/drivers/hwmon/asus_wmi_ec_sensors.c b/drivers/hwmon/asus_wmi_ec_sensors.c
deleted file mode 100644
index 22a1459305a7..000000000000
--- a/drivers/hwmon/asus_wmi_ec_sensors.c
+++ /dev/null
@@ -1,621 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * HWMON driver for ASUS B550/X570 motherboards that publish sensor
- * values via the embedded controller registers.
- *
- * Copyright (C) 2021 Eugene Shalygin <eugene.shalygin@gmail.com>
- * Copyright (C) 2018-2019 Ed Brindley <kernel@maidavale.org>
- *
- * EC provides:
- * - Chipset temperature
- * - CPU temperature
- * - Motherboard temperature
- * - T_Sensor temperature
- * - VRM temperature
- * - Water In temperature
- * - Water Out temperature
- * - CPU Optional Fan RPM
- * - Chipset Fan RPM
- * - Water Flow Fan RPM
- * - CPU current
- */
-
-#include <linux/acpi.h>
-#include <linux/dmi.h>
-#include <linux/hwmon.h>
-#include <linux/init.h>
-#include <linux/jiffies.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/nls.h>
-#include <linux/units.h>
-#include <linux/wmi.h>
-
-#include <asm/unaligned.h>
-
-#define ASUSWMI_MONITORING_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
-#define ASUSWMI_METHODID_BLOCK_READ_EC	0x42524543 /* BREC */
-/* From the ASUS DSDT source */
-#define ASUSWMI_BREC_REGISTERS_MAX	16
-#define ASUSWMI_MAX_BUF_LEN		128
-#define SENSOR_LABEL_LEN		16
-
-static u32 hwmon_attributes[hwmon_max] = {
-	[hwmon_chip]	= HWMON_C_REGISTER_TZ,
-	[hwmon_temp]	= HWMON_T_INPUT | HWMON_T_LABEL,
-	[hwmon_in]	= HWMON_I_INPUT | HWMON_I_LABEL,
-	[hwmon_curr]	= HWMON_C_INPUT | HWMON_C_LABEL,
-	[hwmon_fan]	= HWMON_F_INPUT | HWMON_F_LABEL,
-};
-
-struct asus_wmi_ec_sensor_address {
-	u8 index;
-	u8 bank;
-	u8 size;
-};
-
-#define MAKE_SENSOR_ADDRESS(size_i, bank_i, index_i) {	\
-	.size = size_i,					\
-	.bank = bank_i,					\
-	.index = index_i,				\
-}
-
-struct ec_sensor_info {
-	struct asus_wmi_ec_sensor_address addr;
-	char label[SENSOR_LABEL_LEN];
-	enum hwmon_sensor_types type;
-};
-
-#define EC_SENSOR(sensor_label, sensor_type, size, bank, index) {	\
-	.addr = MAKE_SENSOR_ADDRESS(size, bank, index),			\
-	.label = sensor_label,						\
-	.type = sensor_type,						\
-}
-
-enum known_ec_sensor {
-	SENSOR_TEMP_CHIPSET,
-	SENSOR_TEMP_CPU,
-	SENSOR_TEMP_MB,
-	SENSOR_TEMP_T_SENSOR,
-	SENSOR_TEMP_VRM,
-	SENSOR_FAN_CPU_OPT,
-	SENSOR_FAN_CHIPSET,
-	SENSOR_FAN_VRM_HS,
-	SENSOR_FAN_WATER_FLOW,
-	SENSOR_CURR_CPU,
-	SENSOR_TEMP_WATER_IN,
-	SENSOR_TEMP_WATER_OUT,
-	SENSOR_MAX
-};
-
-/* All known sensors for ASUS EC controllers */
-static const struct ec_sensor_info known_ec_sensors[] = {
-	[SENSOR_TEMP_CHIPSET]	= EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
-	[SENSOR_TEMP_CPU]	= EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
-	[SENSOR_TEMP_MB]	= EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
-	[SENSOR_TEMP_T_SENSOR]	= EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
-	[SENSOR_TEMP_VRM]	= EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
-	[SENSOR_FAN_CPU_OPT]	= EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
-	[SENSOR_FAN_VRM_HS]	= EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2),
-	[SENSOR_FAN_CHIPSET]	= EC_SENSOR("Chipset", hwmon_fan, 2, 0x00, 0xb4),
-	[SENSOR_FAN_WATER_FLOW]	= EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc),
-	[SENSOR_CURR_CPU]	= EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4),
-	[SENSOR_TEMP_WATER_IN]	= EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
-	[SENSOR_TEMP_WATER_OUT]	= EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
-};
-
-struct asus_wmi_data {
-	const enum known_ec_sensor known_board_sensors[SENSOR_MAX + 1];
-};
-
-/* boards with EC support */
-static struct asus_wmi_data sensors_board_PW_X570_P = {
-	.known_board_sensors = {
-		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB, SENSOR_TEMP_VRM,
-		SENSOR_FAN_CHIPSET,
-		SENSOR_MAX
-	},
-};
-
-static struct asus_wmi_data sensors_board_PW_X570_A = {
-	.known_board_sensors = {
-		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB, SENSOR_TEMP_VRM,
-		SENSOR_FAN_CHIPSET,
-		SENSOR_CURR_CPU,
-		SENSOR_MAX
-	},
-};
-
-static struct asus_wmi_data sensors_board_R_C8H = {
-	.known_board_sensors = {
-		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
-		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
-		SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT,
-		SENSOR_FAN_CPU_OPT, SENSOR_FAN_CHIPSET, SENSOR_FAN_WATER_FLOW,
-		SENSOR_CURR_CPU,
-		SENSOR_MAX
-	},
-};
-
-/* Same as Hero but without chipset fan */
-static struct asus_wmi_data sensors_board_R_C8DH = {
-	.known_board_sensors = {
-		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
-		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
-		SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT,
-		SENSOR_FAN_CPU_OPT, SENSOR_FAN_WATER_FLOW,
-		SENSOR_CURR_CPU,
-		SENSOR_MAX
-	},
-};
-
-/* Same as Hero but without water */
-static struct asus_wmi_data sensors_board_R_C8F = {
-	.known_board_sensors = {
-		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
-		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
-		SENSOR_FAN_CPU_OPT, SENSOR_FAN_CHIPSET,
-		SENSOR_CURR_CPU,
-		SENSOR_MAX
-	},
-};
-
-static struct asus_wmi_data sensors_board_RS_B550_E_G = {
-	.known_board_sensors = {
-		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
-		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
-		SENSOR_FAN_CPU_OPT,
-		SENSOR_MAX
-	},
-};
-
-static struct asus_wmi_data sensors_board_RS_B550_I_G = {
-	.known_board_sensors = {
-		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
-		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
-		SENSOR_FAN_VRM_HS,
-		SENSOR_CURR_CPU,
-		SENSOR_MAX
-	},
-};
-
-static struct asus_wmi_data sensors_board_RS_X570_E_G = {
-	.known_board_sensors = {
-		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
-		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
-		SENSOR_FAN_CHIPSET,
-		SENSOR_CURR_CPU,
-		SENSOR_MAX
-	},
-};
-
-#define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, sensors) {			\
-	.matches = {								\
-		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),	\
-		DMI_EXACT_MATCH(DMI_BOARD_NAME, name),				\
-	},									\
-	.driver_data = sensors,							\
-}
-
-static const struct dmi_system_id asus_wmi_ec_dmi_table[] = {
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X570-PRO", &sensors_board_PW_X570_P),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE", &sensors_board_PW_X570_A),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII DARK HERO", &sensors_board_R_C8DH),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII FORMULA", &sensors_board_R_C8F),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII HERO", &sensors_board_R_C8H),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-E GAMING", &sensors_board_RS_B550_E_G),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-I GAMING", &sensors_board_RS_B550_I_G),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-E GAMING", &sensors_board_RS_X570_E_G),
-	{}
-};
-MODULE_DEVICE_TABLE(dmi, asus_wmi_ec_dmi_table);
-
-struct ec_sensor {
-	enum known_ec_sensor info_index;
-	long cached_value;
-};
-
-/**
- * struct asus_wmi_ec_info - sensor info.
- * @sensors: list of sensors.
- * @read_arg: UTF-16LE string to pass to BRxx() WMI function.
- * @read_buffer: decoded output from WMI result.
- * @nr_sensors: number of board EC sensors.
- * @nr_registers: number of EC registers to read (sensor might span more than 1 register).
- * @last_updated: in jiffies.
- */
-struct asus_wmi_ec_info {
-	struct ec_sensor sensors[SENSOR_MAX];
-	char read_arg[(ASUSWMI_BREC_REGISTERS_MAX * 4 + 1) * 2];
-	u8 read_buffer[ASUSWMI_BREC_REGISTERS_MAX];
-	unsigned int nr_sensors;
-	unsigned int nr_registers;
-	unsigned long last_updated;
-};
-
-struct asus_wmi_sensors {
-	struct asus_wmi_ec_info ec;
-	/* lock access to internal cache */
-	struct mutex lock;
-};
-
-static int asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec,
-					  const enum known_ec_sensor *bsi)
-{
-	struct ec_sensor *s = ec->sensors;
-	int i;
-
-	ec->nr_sensors = 0;
-	ec->nr_registers = 0;
-
-	for (i = 0; bsi[i] != SENSOR_MAX; i++) {
-		s[i].info_index = bsi[i];
-		ec->nr_sensors++;
-		ec->nr_registers += known_ec_sensors[bsi[i]].addr.size;
-	}
-
-	return 0;
-}
-
-/*
- * The next four functions convert to or from BRxx string argument format.
- * The format of the string is as follows:
- * - The string consists of two-byte UTF-16LE characters.
- * - The value of the very first byte in the string is equal to the total
- *   length of the next string in bytes, thus excluding the first two-byte
- *   character.
- * - The rest of the string encodes the pairs of (bank, index) pairs, where
- *   both values are byte-long (0x00 to 0xFF).
- * - Numbers are encoded as UTF-16LE hex values.
- */
-static int asus_wmi_ec_decode_reply_buffer(const u8 *in, u32 length, u8 *out)
-{
-	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
-	u32 len = min_t(u32, get_unaligned_le16(in), length - 2);
-
-	utf16s_to_utf8s((wchar_t *)(in + 2), len / 2, UTF16_LITTLE_ENDIAN, buffer, sizeof(buffer));
-
-	return hex2bin(out, buffer, len / 4);
-}
-
-static void asus_wmi_ec_encode_registers(const u8 *in, u32 len, char *out)
-{
-	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
-
-	bin2hex(buffer, in, len);
-
-	utf8s_to_utf16s(buffer, len * 2, UTF16_LITTLE_ENDIAN, (wchar_t *)(out + 2), len * 2);
-
-	put_unaligned_le16(len * 4, out);
-}
-
-static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *ec)
-{
-	u8 registers[ASUSWMI_BREC_REGISTERS_MAX * 2];
-	const struct ec_sensor_info *si;
-	int i, j, offset;
-
-	offset = 0;
-	for (i = 0; i < ec->nr_sensors; i++) {
-		si = &known_ec_sensors[ec->sensors[i].info_index];
-		for (j = 0; j < si->addr.size; j++) {
-			registers[offset++] = si->addr.bank;
-			registers[offset++] = si->addr.index + j;
-		}
-	}
-
-	asus_wmi_ec_encode_registers(registers, offset, ec->read_arg);
-}
-
-static int asus_wmi_ec_block_read(u32 method_id, char *query, u8 *out)
-{
-	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_buffer input;
-	union acpi_object *obj;
-	acpi_status status;
-	int ret;
-
-	/* The first byte of the BRxx() argument string has to be the string size. */
-	input.length = query[0] + 2;
-	input.pointer = query;
-	status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0, method_id, &input, &output);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	obj = output.pointer;
-	if (!obj)
-		return -EIO;
-
-	if (obj->type != ACPI_TYPE_BUFFER || obj->buffer.length < 2) {
-		ret = -EIO;
-		goto out_free_obj;
-	}
-
-	ret = asus_wmi_ec_decode_reply_buffer(obj->buffer.pointer, obj->buffer.length, out);
-
-out_free_obj:
-	ACPI_FREE(obj);
-	return ret;
-}
-
-static inline long get_sensor_value(const struct ec_sensor_info *si, u8 *data)
-{
-	switch (si->addr.size) {
-	case 1:
-		return *data;
-	case 2:
-		return get_unaligned_be16(data);
-	case 4:
-		return get_unaligned_be32(data);
-	default:
-		return 0;
-	}
-}
-
-static void asus_wmi_ec_update_ec_sensors(struct asus_wmi_ec_info *ec)
-{
-	const struct ec_sensor_info *si;
-	struct ec_sensor *s;
-	u8 i_sensor;
-	u8 *data;
-
-	data = ec->read_buffer;
-	for (i_sensor = 0; i_sensor < ec->nr_sensors; i_sensor++) {
-		s = &ec->sensors[i_sensor];
-		si = &known_ec_sensors[s->info_index];
-		s->cached_value = get_sensor_value(si, data);
-		data += si->addr.size;
-	}
-}
-
-static long asus_wmi_ec_scale_sensor_value(long value, int data_type)
-{
-	switch (data_type) {
-	case hwmon_curr:
-	case hwmon_temp:
-	case hwmon_in:
-		return value * MILLI;
-	default:
-		return value;
-	}
-}
-
-static int asus_wmi_ec_find_sensor_index(const struct asus_wmi_ec_info *ec,
-					 enum hwmon_sensor_types type, int channel)
-{
-	int i;
-
-	for (i = 0; i < ec->nr_sensors; i++) {
-		if (known_ec_sensors[ec->sensors[i].info_index].type == type) {
-			if (channel == 0)
-				return i;
-
-			channel--;
-		}
-	}
-	return -EINVAL;
-}
-
-static int asus_wmi_ec_get_cached_value_or_update(struct asus_wmi_sensors *sensor_data,
-						  int sensor_index,
-						  long *value)
-{
-	struct asus_wmi_ec_info *ec = &sensor_data->ec;
-	int ret = 0;
-
-	mutex_lock(&sensor_data->lock);
-
-	if (time_after(jiffies, ec->last_updated + HZ)) {
-		ret = asus_wmi_ec_block_read(ASUSWMI_METHODID_BLOCK_READ_EC,
-					     ec->read_arg, ec->read_buffer);
-		if (ret)
-			goto unlock;
-
-		asus_wmi_ec_update_ec_sensors(ec);
-		ec->last_updated = jiffies;
-	}
-
-	*value = ec->sensors[sensor_index].cached_value;
-
-unlock:
-	mutex_unlock(&sensor_data->lock);
-
-	return ret;
-}
-
-/* Now follow the functions that implement the hwmon interface */
-
-static int asus_wmi_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
-				  u32 attr, int channel, long *val)
-{
-	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
-	struct asus_wmi_ec_info *ec = &sensor_data->ec;
-	int ret, sidx, info_index;
-	long value = 0;
-
-	sidx = asus_wmi_ec_find_sensor_index(ec, type, channel);
-	if (sidx < 0)
-		return sidx;
-
-	ret = asus_wmi_ec_get_cached_value_or_update(sensor_data, sidx, &value);
-	if (ret)
-		return ret;
-
-	info_index = ec->sensors[sidx].info_index;
-	*val = asus_wmi_ec_scale_sensor_value(value, known_ec_sensors[info_index].type);
-
-	return ret;
-}
-
-static int asus_wmi_ec_hwmon_read_string(struct device *dev,
-					 enum hwmon_sensor_types type, u32 attr,
-					 int channel, const char **str)
-{
-	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
-	struct asus_wmi_ec_info *ec = &sensor_data->ec;
-	int sensor_index;
-
-	sensor_index = asus_wmi_ec_find_sensor_index(ec, type, channel);
-	*str = known_ec_sensors[ec->sensors[sensor_index].info_index].label;
-
-	return 0;
-}
-
-static umode_t asus_wmi_ec_hwmon_is_visible(const void *drvdata,
-					    enum hwmon_sensor_types type, u32 attr,
-					    int channel)
-{
-	const struct asus_wmi_sensors *sensor_data = drvdata;
-	const struct asus_wmi_ec_info *ec = &sensor_data->ec;
-	int index;
-
-	index = asus_wmi_ec_find_sensor_index(ec, type, channel);
-
-	return index < 0 ? 0 : 0444;
-}
-
-static int asus_wmi_hwmon_add_chan_info(struct hwmon_channel_info *asus_wmi_hwmon_chan,
-					struct device *dev, int num,
-					enum hwmon_sensor_types type, u32 config)
-{
-	u32 *cfg;
-
-	cfg = devm_kcalloc(dev, num + 1, sizeof(*cfg), GFP_KERNEL);
-	if (!cfg)
-		return -ENOMEM;
-
-	asus_wmi_hwmon_chan->type = type;
-	asus_wmi_hwmon_chan->config = cfg;
-	memset32(cfg, config, num);
-
-	return 0;
-}
-
-static const struct hwmon_ops asus_wmi_ec_hwmon_ops = {
-	.is_visible = asus_wmi_ec_hwmon_is_visible,
-	.read = asus_wmi_ec_hwmon_read,
-	.read_string = asus_wmi_ec_hwmon_read_string,
-};
-
-static struct hwmon_chip_info asus_wmi_ec_chip_info = {
-	.ops = &asus_wmi_ec_hwmon_ops,
-};
-
-static int asus_wmi_ec_configure_sensor_setup(struct device *dev,
-					      const enum known_ec_sensor *bsi)
-{
-	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
-	struct asus_wmi_ec_info *ec = &sensor_data->ec;
-	struct hwmon_channel_info *asus_wmi_hwmon_chan;
-	const struct hwmon_channel_info **asus_wmi_ci;
-	int nr_count[hwmon_max] = {}, nr_types = 0;
-	const struct hwmon_chip_info *chip_info;
-	const struct ec_sensor_info *si;
-	enum hwmon_sensor_types type;
-	struct device *hwdev;
-	int i, ret;
-
-	ret = asus_wmi_ec_fill_board_sensors(ec, bsi);
-	if (ret)
-		return ret;
-
-	if (!sensor_data->ec.nr_sensors)
-		return -ENODEV;
-
-	for (i = 0; i < ec->nr_sensors; i++) {
-		si = &known_ec_sensors[ec->sensors[i].info_index];
-		if (!nr_count[si->type])
-			nr_types++;
-		nr_count[si->type]++;
-	}
-
-	if (nr_count[hwmon_temp]) {
-		nr_count[hwmon_chip]++;
-		nr_types++;
-	}
-
-	/*
-	 * If we can get values for all the registers in a single query,
-	 * the query will not change from call to call.
-	 */
-	asus_wmi_ec_make_block_read_query(ec);
-
-	asus_wmi_hwmon_chan = devm_kcalloc(dev, nr_types, sizeof(*asus_wmi_hwmon_chan),
-					   GFP_KERNEL);
-	if (!asus_wmi_hwmon_chan)
-		return -ENOMEM;
-
-	asus_wmi_ci = devm_kcalloc(dev, nr_types + 1, sizeof(*asus_wmi_ci), GFP_KERNEL);
-	if (!asus_wmi_ci)
-		return -ENOMEM;
-
-	asus_wmi_ec_chip_info.info = asus_wmi_ci;
-	chip_info = &asus_wmi_ec_chip_info;
-
-	for (type = 0; type < hwmon_max; type++) {
-		if (!nr_count[type])
-			continue;
-
-		ret = asus_wmi_hwmon_add_chan_info(asus_wmi_hwmon_chan, dev,
-						   nr_count[type], type,
-						   hwmon_attributes[type]);
-		if (ret)
-			return ret;
-
-		*asus_wmi_ci++ = asus_wmi_hwmon_chan++;
-	}
-
-	dev_dbg(dev, "board has %d EC sensors that span %d registers",
-		ec->nr_sensors, ec->nr_registers);
-
-	hwdev = devm_hwmon_device_register_with_info(dev, "asus_wmi_ec_sensors",
-						     sensor_data, chip_info, NULL);
-
-	return PTR_ERR_OR_ZERO(hwdev);
-}
-
-static int asus_wmi_probe(struct wmi_device *wdev, const void *context)
-{
-	struct asus_wmi_sensors *sensor_data;
-	struct asus_wmi_data *board_sensors;
-	const struct dmi_system_id *dmi_id;
-	const enum known_ec_sensor *bsi;
-	struct device *dev = &wdev->dev;
-
-	dmi_id = dmi_first_match(asus_wmi_ec_dmi_table);
-	if (!dmi_id)
-		return -ENODEV;
-
-	board_sensors = dmi_id->driver_data;
-	bsi = board_sensors->known_board_sensors;
-
-	sensor_data = devm_kzalloc(dev, sizeof(*sensor_data), GFP_KERNEL);
-	if (!sensor_data)
-		return -ENOMEM;
-
-	mutex_init(&sensor_data->lock);
-
-	dev_set_drvdata(dev, sensor_data);
-
-	return asus_wmi_ec_configure_sensor_setup(dev, bsi);
-}
-
-static const struct wmi_device_id asus_ec_wmi_id_table[] = {
-	{ ASUSWMI_MONITORING_GUID, NULL },
-	{ }
-};
-
-static struct wmi_driver asus_sensors_wmi_driver = {
-	.driver = {
-		.name = "asus_wmi_ec_sensors",
-	},
-	.id_table = asus_ec_wmi_id_table,
-	.probe = asus_wmi_probe,
-};
-module_wmi_driver(asus_sensors_wmi_driver);
-
-MODULE_AUTHOR("Ed Brindley <kernel@maidavale.org>");
-MODULE_AUTHOR("Eugene Shalygin <eugene.shalygin@gmail.com>");
-MODULE_DESCRIPTION("Asus WMI Sensors Driver");
-MODULE_LICENSE("GPL");
-- 
2.34.1

