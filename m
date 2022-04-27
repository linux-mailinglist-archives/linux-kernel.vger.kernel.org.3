Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08491511A04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbiD0Odw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiD0Oda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:33:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB3F2630;
        Wed, 27 Apr 2022 07:30:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so2743311wrg.12;
        Wed, 27 Apr 2022 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svV9IgBLsOwIZmPj9x7hu2PTvXDW3pGjVejTuhnh/mI=;
        b=MDnnrjiWGOwxINe0CR2NtRtg3tFohitnFemsC7KPWxPgakmlwCBapdJpZ1PQv10tIt
         NNFVT+oJi3BBncAEcqp1VzW+9ubQbT9W2S5/Po8pwj7jQPF8ru9RFwtAzzObjk+x54GL
         RfOIboxHsC5p7JABnxayDVk91IK7vmXe3kqB+c0BpECFyW1qGiSvtdhOQyUpBhlHwoxU
         SZobtnVNXBX5maDtcE8SJTBAMo0ujMvEgUc1rsoHcwcpPk3rO6PuRpL44KAmOMKEfAiL
         v9Ez/NsHpvzaJK5jQ1zLTJKYpZnJ2ta/ZZPbp1gJ9FULmCE5GauIetkO+BarSbB26f4I
         PUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svV9IgBLsOwIZmPj9x7hu2PTvXDW3pGjVejTuhnh/mI=;
        b=vCdOMnAM8C13yvy9DkndPI8j3tHSr35W/SlBpd4So/oSt2LuXK33CxYo1BqZazXxFu
         8FRBWf6sx3R+atZK0lhk9jhIIVFPNFJt/nHm6PLRZtZE6iK1eh42AcLRaNPBc3FK8MCQ
         ZACTnL0Q6alVcwbOqwamwian9Hd/hPUsXsb38EqUDL8LS9tl0k1OrjpPU2ILmxX+/Okg
         jZ44H31l5asbm0tJtgB5O5oTMm7SQFvekp+cduYHRdHsZ1wD4/7AXmoXiFYWxq0VMRsj
         HoRHNOZiyUjpHuNuenPf3jlzyqIDUATyZlNa0hmp5esLKaaFz87IeywwayorA1b+yeeE
         SV6Q==
X-Gm-Message-State: AOAM531mUTWGo+e6Z+omqe70uzB4pHuj9TpY9jZ9oM8iMjHbOS0Hkey2
        VOsyXXT7VVh4ClE30FKovUc=
X-Google-Smtp-Source: ABdhPJyWckK2wEaJ73czrMXjyObmWPbFHWzDIiDtLWunHnZstbRXpOZFTOOkAjj0DjFFtwPUhM1bMQ==
X-Received: by 2002:adf:eb07:0:b0:207:8534:2ef6 with SMTP id s7-20020adfeb07000000b0020785342ef6mr22294174wrn.62.1651069815015;
        Wed, 27 Apr 2022 07:30:15 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f393100d379c1e4199524ea.dip0.t-ipconnect.de. [2003:cf:9f39:3100:d379:c1e4:1995:24ea])
        by smtp.googlemail.com with ESMTPSA id i14-20020a1c540e000000b00393dc91e9c9sm1721625wmb.17.2022.04.27.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:30:14 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] hwmon: (asus-ec-sensors) add PRIME X470-PRO board
Date:   Wed, 27 Apr 2022 16:30:01 +0200
Message-Id: <20220427143001.1443605-5-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
References: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board is supposed to be handled by the asus-wmi-sensors driver,
but due to a buggy WMI implementation the driver and the official ASUS
software make the BIOS hang together with fan controls [1, 2].

This driver complements values provided by the SIO chip and does not
freeze the BIOS, as tested by a user [2].

[1] https://github.com/electrified/asus-wmi-sensors/blob/master/README.md
[2] https://github.com/zeule/asus-ec-sensors/issues/12

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 109c3920d77c..998d49d6b799 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -137,10 +137,41 @@ enum ec_sensors {
 
 enum board_family {
 	family_unknown,
+	family_amd_400_series,
 	family_amd_500_series,
 };
 
 /* All the known sensors for ASUS EC controllers */
+static const struct ec_sensor_info sensors_family_amd_400[] = {
+	[ec_sensor_temp_chipset] =
+		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
+	[ec_sensor_temp_cpu] =
+		EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
+	[ec_sensor_temp_mb] =
+		EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
+	[ec_sensor_temp_t_sensor] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
+	[ec_sensor_temp_vrm] =
+		EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
+	[ec_sensor_in_cpu_core] =
+		EC_SENSOR("CPU Core", hwmon_in, 2, 0x00, 0xa2),
+	[ec_sensor_fan_cpu_opt] =
+		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xbc),
+	[ec_sensor_fan_vrm_hs] =
+		EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2),
+	[ec_sensor_fan_chipset] =
+		/* no chipset fans in this generation */
+		EC_SENSOR("Chipset", hwmon_fan, 0, 0x00, 0x00),
+	[ec_sensor_fan_water_flow] =
+		EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xb4),
+	[ec_sensor_curr_cpu] =
+		EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4),
+	[ec_sensor_temp_water_in] =
+		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x0d),
+	[ec_sensor_temp_water_out] =
+		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x0b),
+};
+
 static const struct ec_sensor_info sensors_family_amd_500[] = {
 	[ec_sensor_temp_chipset] =
 		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
@@ -186,6 +217,15 @@ struct ec_board_info {
 };
 
 static const struct ec_board_info board_info[] = {
+	{
+		.board_names = {"PRIME X470-PRO"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+			SENSOR_FAN_CPU_OPT |
+			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+		.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+		.family = family_amd_400_series,
+	},
 	{
 		.board_names = {"PRIME X570-PRO"},
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
@@ -753,6 +793,9 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	ec_data->board_info = pboard_info;
 
 	switch (ec_data->board_info->family) {
+	case family_amd_400_series:
+		ec_data->sensors_info = sensors_family_amd_400;
+		break;
 	case family_amd_500_series:
 		ec_data->sensors_info = sensors_family_amd_500;
 		break;
-- 
2.35.1

