Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E484E87A9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 14:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiC0MRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 08:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiC0MQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 08:16:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFEF37A0E;
        Sun, 27 Mar 2022 05:15:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o10so23515215ejd.1;
        Sun, 27 Mar 2022 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4ZqenwWmPW0skuS2J9N+QRi5X/+snz4/hXf3e+SE94=;
        b=CRoLD6UegOKBpo1G6ixwRpuQpIoBjTkP3ogFKlZsDqRVQMTxlE34E7RQ0kvMWgU13z
         pQvtcdZXQ0IEjXgL5OKTmkfE7hxjE6jN5F02FD31hBt4fkHTYTieKHKXSGJfU52/J0MK
         47AKpkhQX2ttRwkjNkJm231OQTLkXRJtIzE/UtJpE9RXch7c/kxSplaTJcurGaCO6W3W
         pzgW8kB/jpSN7fuX0b+pTf5NfDm1DKB8ccj+u4Yq/QWM1XCXPoSsJ45qaDSjmUnCeVqW
         35AhAu/lS+ggF3vFyjzx7YaEk0aejiJ8FWgM5ZWeZrvanY4dXVbIH0F7bduH3rbMXlLC
         eJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4ZqenwWmPW0skuS2J9N+QRi5X/+snz4/hXf3e+SE94=;
        b=kGCvjLPPRvh4tNp3S+EQRc26C2LF9qvc0er5vBpnndKcV3I6wfRF/0Xr3x8CGGlqQ4
         S96rdTlsF0xqyKisXuPWPOV9DKu0lPOzAlFY7La34LFOKUK54mgD9rxoOXxKISF3dtxx
         84LV+PLy+xDVBTxb+6iElO43FDLRc0T5X6xv6XFq2/XWZQn7etULhE/wsD4KyeNtqVuz
         f8D+pMI6L7iU8/LaE7BqQMiZaOF38SIP3iAVmvY0snXQsW7zOwwL5NoaOW1YHQx+bbLM
         gTWuulYs60qJIWFQ2atYd3Ahpjszh1Hr4RC+NQrFMBbXd2Ll2t/8ZixkkR7iqHcTih2F
         RgfQ==
X-Gm-Message-State: AOAM530W/gEn0UxApd4Mc7N2CjMuJENdTYQA0iFDPB51t2Ll8i6KNAU0
        V6ZiPFis0RvRuSL78wEWKe0=
X-Google-Smtp-Source: ABdhPJy6f16s5PmNJUsXBrTRkotz24owRvjZ0kbXNY/+Ut1f2weCS4jcJzq+8YicgcPNV2M6uwJKOg==
X-Received: by 2002:a17:907:3f9c:b0:6d8:116d:476b with SMTP id hr28-20020a1709073f9c00b006d8116d476bmr21152184ejc.432.1648383312207;
        Sun, 27 Mar 2022 05:15:12 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f06c2008407e4c213cb9d01.dip0.t-ipconnect.de. [2003:cf:9f06:c200:8407:e4c2:13cb:9d01])
        by smtp.googlemail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm4530127ejc.64.2022.03.27.05.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:15:11 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] hwmon: (asus-ec-sensors) add PRIME X470-PRO board
Date:   Sun, 27 Mar 2022 14:14:04 +0200
Message-Id: <20220327121404.1702631-5-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
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

This board is supposed to be handled by the asus-wmi-sensors driver,
but due to a buggy WMI implementation the driver and the official ASUS
software make the BIOS hang together with fan controls.

This driver complements values provided by the SIO chip and does not
freeze the BIOS, as tested by a user [2].

[1] https://github.com/electrified/asus-wmi-sensors/blob/master/README.md
[2] https://github.com/zeule/asus-ec-sensors/issues/12

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index b4060ed1f0fa..ce0e1d97b60b 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -136,10 +136,41 @@ enum ec_sensors {
 #define SENSOR_TEMP_WATER_OUT BIT(ec_sensor_temp_water_out)
 
 enum board_family {
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
@@ -185,6 +216,15 @@ struct ec_board_info {
 };
 
 static const struct ec_board_info board_info[] __initconst = {
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
@@ -762,7 +802,11 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, ec_data);
 	ec_data->board_info = *pboard_info;
+
 	switch (ec_data->board_info.family) {
+	case family_amd_400_series:
+		ec_data->sensors_info = sensors_family_amd_400;
+		break;
 	case family_amd_500_series:
 		ec_data->sensors_info = sensors_family_amd_500;
 		break;
-- 
2.35.1

