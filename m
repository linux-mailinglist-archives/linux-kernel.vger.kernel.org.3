Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2082956CE65
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiGJJVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJJVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 05:21:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1232EDFC8;
        Sun, 10 Jul 2022 02:21:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay25so1520987wmb.1;
        Sun, 10 Jul 2022 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cWliLwufi6NExgI1uDOPDdV7gzELeMYN5Wr9YUPC9IQ=;
        b=PoRUhvc7/CCjDbsjQh1suwNlUgqXZz3hKcojTVymSbCVA6piSxNwLpEUi77qc0/y3v
         FxxGve1qj3mD2v4Ivd2VEYzk0cnISnOLooJ6gUwgOvQnBqnFtRV1HDLaM51vslO5br8q
         xxjkVf290vSCOe+sRYTXAQR/C8sH4jb0xBerg7K9a77pvB9hR0roCj5OO48CWQEfdGUr
         pangr+/bjRP6ack7DivCJsT/wrg3v8hxHTXtYiZ9ue1/VUqlTw8ZpkJHCrjErCRX2/g+
         QiAZwkEwPMqt82v3hixT621PuCUYD31zMr8pXb4bHBJg9xZ2rfxj9I5gdsthyUSz/QFG
         r2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cWliLwufi6NExgI1uDOPDdV7gzELeMYN5Wr9YUPC9IQ=;
        b=yV9uXYrxasvdA7pxb3MStetdd1aoeI+6EdUjK9peoT/ZvEpnKmfGZgq6odxVq6ZTin
         yQkhgyhRBiSUGtFLhrejpf7ACrgf2BiIgZ+jNex+WiFhNXxyk46clKfIS+giqoRk2yAJ
         ruVnyJuy4wyIV2T0CQMqBtGwCpKNZ24aZx7yZcjgG3pHVm73c2Jlyf8mjcellOce/MBu
         j/UD2A6NKauSD8LPs6TnnJsfqVfTHlelojQJzpamYqRtlzjEMHhaxLSdMHSIhsoyWBrS
         ic8x5cIBUYaEJQCJXyEJfEhUzA4EjlnFurINvVZ2f223Zx5E0TD3ZJQZ4qNdtyMhaKVz
         e1xg==
X-Gm-Message-State: AJIora/4DWq1O2H/BcPuj2pKgpPOia7y+lsHgtsdEMK7byQlu3oNKvTx
        pbjCYKjdZ68WcPK/VBd4JTuEAsxdMssUEw==
X-Google-Smtp-Source: AGRyM1sssfpNFRy6dOdyv1/oll2v/zPkDR7f1ITLNx09thnHqa+Tugs4AdD3Z5aqSVLVDG6ttHBb9g==
X-Received: by 2002:a05:600c:5114:b0:3a2:d4bf:c0ba with SMTP id o20-20020a05600c511400b003a2d4bfc0bamr9594148wms.155.1657444902511;
        Sun, 10 Jul 2022 02:21:42 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f2e4000d7544521133919bb.dip0.t-ipconnect.de. [2003:cf:9f2e:4000:d754:4521:1339:19bb])
        by smtp.googlemail.com with ESMTPSA id c9-20020adfed89000000b0021d9233e7e6sm3854976wro.54.2022.07.10.02.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 02:21:41 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Nabajour <nab@halo.lampshade.ch>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add definitions for ROG ZENITH II EXTREME
Date:   Sun, 10 Jul 2022 11:21:35 +0200
Message-Id: <20220710092135.1743411-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nabajour <nab@halo.lampshade.ch>

Add definitions for ROG ZENITH II EXTREME and some unknown yet
temperature sensors in the second EC bank. Details are accessible at
[1,2].

[1] https://github.com/zeule/asus-ec-sensors/pull/26
[2] https://github.com/zeule/asus-ec-sensors/issues/16

Signed-off-by: Nabajour <nab@halo.lampshade.ch>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 47 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 1e40c123db77..02f4ad314a1e 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -22,6 +22,7 @@ Supported boards:
  * ROG STRIX X570-F GAMING
  * ROG STRIX X570-I GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
+ * ROG ZENITH II EXTREME
 
 Authors:
     - Eugene Shalygin <eugene.shalygin@gmail.com>
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 625c2baa35ec..3049537130be 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -56,6 +56,8 @@ static char *mutex_path_override;
 
 #define ASUS_HW_ACCESS_MUTEX_RMTW_ASMX	"\\RMTW.ASMX"
 
+#define ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0 "\\_SB_.PCI0.SBRG.SIO1.MUT0"
+
 #define MAX_IDENTICAL_BOARD_VARIATIONS	3
 
 /* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
@@ -121,6 +123,18 @@ enum ec_sensors {
 	ec_sensor_temp_water_in,
 	/* "Water_Out" temperature sensor reading [℃] */
 	ec_sensor_temp_water_out,
+	/* "Water_Block_In" temperature sensor reading [℃] */
+	ec_sensor_temp_water_block_in,
+	/* "Water_Block_Out" temperature sensor reading [℃] */
+	ec_sensor_temp_water_block_out,
+	/* "T_sensor_2" temperature sensor reading [℃] */
+	ec_sensor_temp_t_sensor_2,
+	/* "Extra_1" temperature sensor reading [℃] */
+	ec_sensor_temp_sensor_extra_1,
+	/* "Extra_2" temperature sensor reading [℃] */
+	ec_sensor_temp_sensor_extra_2,
+	/* "Extra_3" temperature sensor reading [℃] */
+	ec_sensor_temp_sensor_extra_3,
 };
 
 #define SENSOR_TEMP_CHIPSET BIT(ec_sensor_temp_chipset)
@@ -136,6 +150,12 @@ enum ec_sensors {
 #define SENSOR_CURR_CPU BIT(ec_sensor_curr_cpu)
 #define SENSOR_TEMP_WATER_IN BIT(ec_sensor_temp_water_in)
 #define SENSOR_TEMP_WATER_OUT BIT(ec_sensor_temp_water_out)
+#define SENSOR_TEMP_WATER_BLOCK_IN BIT(ec_sensor_temp_water_block_in)
+#define SENSOR_TEMP_WATER_BLOCK_OUT BIT(ec_sensor_temp_water_block_out)
+#define SENSOR_TEMP_T_SENSOR_2 BIT(ec_sensor_temp_t_sensor_2)
+#define SENSOR_TEMP_SENSOR_EXTRA_1 BIT(ec_sensor_temp_sensor_extra_1)
+#define SENSOR_TEMP_SENSOR_EXTRA_2 BIT(ec_sensor_temp_sensor_extra_2)
+#define SENSOR_TEMP_SENSOR_EXTRA_3 BIT(ec_sensor_temp_sensor_extra_3)
 
 enum board_family {
 	family_unknown,
@@ -199,6 +219,18 @@ static const struct ec_sensor_info sensors_family_amd_500[] = {
 		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
 	[ec_sensor_temp_water_out] =
 		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
+	[ec_sensor_temp_water_block_in] =
+		EC_SENSOR("Water_Block_In", hwmon_temp, 1, 0x01, 0x02),
+	[ec_sensor_temp_water_block_out] =
+		EC_SENSOR("Water_Block_Out", hwmon_temp, 1, 0x01, 0x03),
+	[ec_sensor_temp_sensor_extra_1] =
+		EC_SENSOR("Extra_1", hwmon_temp, 1, 0x01, 0x09),
+	[ec_sensor_temp_t_sensor_2] =
+		EC_SENSOR("T_sensor_2", hwmon_temp, 1, 0x01, 0x0a),
+	[ec_sensor_temp_sensor_extra_2] =
+		EC_SENSOR("Extra_2", hwmon_temp, 1, 0x01, 0x0b),
+	[ec_sensor_temp_sensor_extra_3] =
+		EC_SENSOR("Extra_3", hwmon_temp, 1, 0x01, 0x0c),
 };
 
 static const struct ec_sensor_info sensors_family_intel_300[] = {
@@ -231,6 +263,9 @@ static const struct ec_sensor_info sensors_family_intel_600[] = {
 #define SENSOR_SET_TEMP_CHIPSET_CPU_MB                                         \
 	(SENSOR_TEMP_CHIPSET | SENSOR_TEMP_CPU | SENSOR_TEMP_MB)
 #define SENSOR_SET_TEMP_WATER (SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT)
+#define SENSOR_SET_WATER_BLOCK                                                 \
+	(SENSOR_TEMP_WATER_BLOCK_IN | SENSOR_TEMP_WATER_BLOCK_OUT)
+
 
 struct ec_board_info {
 	const char *board_names[MAX_IDENTICAL_BOARD_VARIATIONS];
@@ -378,6 +413,18 @@ static const struct ec_board_info board_info[] = {
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
 		.family = family_intel_600_series,
 	},
+	{
+		.board_names = {"ROG ZENITH II EXTREME"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET | SENSOR_FAN_VRM_HS |
+			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE |
+			SENSOR_SET_WATER_BLOCK |
+			SENSOR_TEMP_T_SENSOR_2 | SENSOR_TEMP_SENSOR_EXTRA_1 |
+			SENSOR_TEMP_SENSOR_EXTRA_2 | SENSOR_TEMP_SENSOR_EXTRA_3,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
+		.family = family_amd_500_series,
+	},
 	{}
 };
 
-- 
2.35.1

