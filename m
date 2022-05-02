Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3BE516FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385087AbiEBMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385073AbiEBMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:46:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7775413E9E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:42:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j15so19473586wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVvWe9CoZBTdNyE3eHbun0xPih5mbPe7IlFMtVIhZ0k=;
        b=BtfBeu1aqgUSyQZe0mcdvRYb4j2TlOHGS0GBgmr+zcQ4ScZSQr+K1DKeD5S6N/Ofpl
         pztcRIH6/NR6QIuTCyzBERhX8TOM7J5l0ghTn7CgX2/2LrUr6uyiNv4c0IIVgBbnCfuF
         VjWjH8kumF+/tkE7dJl3FD5pC2MMQq7GvGtiadpRUtKA0WEEWtypxfL7Eu2IxA7bKXTb
         yqQFkMtdKknCX1prLQMQ+5j6sR7opHwsQx3Y8c4bHOzY2JPjcZKdt5zPprM5tdupTemm
         +fTnb6kYK/dxEVN9ayKa8366ubv6qOYvD0W9uOL4rt09/BAn4uMKXre2mP4/gG+64JTI
         U2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVvWe9CoZBTdNyE3eHbun0xPih5mbPe7IlFMtVIhZ0k=;
        b=DRCAvzLelkmTbheKcV4mPT278EMjD9ZDyX3qcdQ7A7lzzR2dYev21V91tKvXJLsRo/
         p8TiGPdh/009MGmeVtuLiP4nu+KsmAe4Y0c4arz/1KSzE6mJcWjOc8RZyYP+U5kquKyA
         q0RzcBTY8Nyc/YioytJjAV/cucIgUz/0XguIae81hIOb9dKjM5rfrqyEHvJARPATZe1/
         7Oo1ucnXgwVVxCSs2+VIQXBWvxxiVMDtphCadDIMecn1bTrjpdWZaxpV5N6sWSrGI90K
         kr6XVkrZbxVUkTFVqnFq0ZuHn3Fe4BKw8lUM6nuW04mkzs7qT+n2qS0rjb2zU2vjVCod
         OOFA==
X-Gm-Message-State: AOAM533JCWNXtdHlK8aU8uJAoG133d1W7Dr8hJvIUeUCwSPdAsvkn3ke
        r66OYfVykdzlWNg1vWBbeautyE9j0t8Nlg==
X-Google-Smtp-Source: ABdhPJz/ybYbVPx+PHksA3jc6jfVx19vofEhtVZf31TSZntCS76xIG2EvhKN0/UCRxIrp4CsmUaYeQ==
X-Received: by 2002:adf:f64f:0:b0:209:ead2:e0ae with SMTP id x15-20020adff64f000000b00209ead2e0aemr9378966wrp.277.1651495376039;
        Mon, 02 May 2022 05:42:56 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n10-20020a05600c294a00b003942a244f30sm6254680wmd.9.2022.05.02.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 05:42:55 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] hwmon: acpi_power_meter: fix style issue
Date:   Mon,  2 May 2022 12:42:48 +0000
Message-Id: <20220502124249.682058-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix style issues found by checkpatch.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/hwmon/acpi_power_meter.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index c405a5869581..d2545a1be9fc 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -481,7 +481,7 @@ static struct sensor_template meter_attrs[] = {
 	RO_SENSOR_TEMPLATE("power1_average_interval_max", show_val, 1),
 	RO_SENSOR_TEMPLATE("power1_is_battery", show_val, 5),
 	RW_SENSOR_TEMPLATE(POWER_AVG_INTERVAL_NAME, show_avg_interval,
-		set_avg_interval, 0),
+			   set_avg_interval, 0),
 	{},
 };
 
@@ -530,6 +530,7 @@ static void remove_domain_devices(struct acpi_power_meter_resource *resource)
 
 	for (i = 0; i < resource->num_domain_devices; i++) {
 		struct acpi_device *obj = resource->domain_devices[i];
+
 		if (!obj)
 			continue;
 
@@ -580,7 +581,7 @@ static int read_domain_devices(struct acpi_power_meter_resource *resource)
 	}
 
 	resource->holders_dir = kobject_create_and_add("measures",
-					&resource->acpi_dev->dev.kobj);
+						       &resource->acpi_dev->dev.kobj);
 	if (!resource->holders_dir) {
 		res = -ENOMEM;
 		goto exit_free;
@@ -590,7 +591,7 @@ static int read_domain_devices(struct acpi_power_meter_resource *resource)
 
 	for (i = 0; i < pss->package.count; i++) {
 		struct acpi_device *obj;
-		union acpi_object *element = &(pss->package.elements[i]);
+		union acpi_object *element = &pss->package.elements[i];
 
 		/* Refuse non-references */
 		if (element->type != ACPI_TYPE_LOCAL_REFERENCE)
@@ -603,7 +604,7 @@ static int read_domain_devices(struct acpi_power_meter_resource *resource)
 			continue;
 
 		res = sysfs_create_link(resource->holders_dir, &obj->dev.kobj,
-				      kobject_name(&obj->dev.kobj));
+					kobject_name(&obj->dev.kobj));
 		if (res) {
 			acpi_dev_put(obj);
 			resource->domain_devices[i] = NULL;
@@ -788,7 +789,7 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
 	str = &resource->model_number;
 
 	for (i = 11; i < 14; i++) {
-		union acpi_object *element = &(pss->package.elements[i]);
+		union acpi_object *element = &pss->package.elements[i];
 
 		if (element->type != ACPI_TYPE_STRING) {
 			res = -EINVAL;
@@ -868,8 +869,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	if (!device)
 		return -EINVAL;
 
-	resource = kzalloc(sizeof(struct acpi_power_meter_resource),
-			   GFP_KERNEL);
+	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
 	if (!resource)
 		return -ENOMEM;
 
@@ -884,7 +884,8 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	if (res)
 		goto exit_free;
 
-	resource->trip[0] = resource->trip[1] = -1;
+	resource->trip[0] = -1;
+	resource->trip[1] = -1;
 
 	res = setup_attrs(resource);
 	if (res)
-- 
2.35.1

