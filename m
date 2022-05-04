Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE30C519CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348121AbiEDKeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348108AbiEDKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:34:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973BD192B3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:30:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p189so590512wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVvWe9CoZBTdNyE3eHbun0xPih5mbPe7IlFMtVIhZ0k=;
        b=G/k6F7kYqnZzccb/RHvYUNQ+cmItTgNY2NoAzmvysDGNT9sYZQ+gnOOEp9NrTXesP/
         nllwOMFbfQzmDY79kENJAS3Cr9of3xravd1Cs8QaC52GH4DTYELD1BuPp6aH1ejniSMl
         Yow1xWQpSz9DCQCsNcZ0RDnRkY2dmPELeMhJqERNvHAk3ikwaLajXlK74wdgNvBVVCAQ
         sYuB6Omwr3P9ADIRWwesA2VNLz2rPDHMkaQnzdSaeu16Lg72w72CMKjpCqGWD1Yk6dM8
         sq26YYAW10WDCeouuFJPPsH5FIX930Xq5sDhKa3tiLBIsc2jJiR7vQ5myGG3u/LDmzCn
         CFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVvWe9CoZBTdNyE3eHbun0xPih5mbPe7IlFMtVIhZ0k=;
        b=3D+iP50xnRVcsM8aNo4DUGDqKkXi2rrE6sPZGrDfXB2c32ERsQw++Px7bi1o20kyq0
         Yu0KU7QWPXdmW8Yu3JIHO5BShy1UwoXBh901X7mZIDUbdrcy4FAxH6Qul1/b1Y4NyZu7
         iaVKP17gf8sbeCuFg2kOfsa12b0/vR5rjy0bta14e8rQZJXhIyDjLPcJnLhen679bZRI
         nwBqjXn1Cna463bXXgqGQPQNUXkFmdYL/nRZQveCNhxKt1PYTJaR/l3msXgR3v9WDMj0
         hqplgSGP3XTL3RUvbg9BJcjA2gI6aMAHqhaEX/J4EKEOvAhT6hLcCrs6fk0iOrCHf1Zx
         B0kA==
X-Gm-Message-State: AOAM530qHgtqDF+pdmyMr6XF3L7KOMEBPAwlSe4x6ohRDF03awgDKlNN
        h8++qOBFF8Z2383kloxcAhmeVQ==
X-Google-Smtp-Source: ABdhPJynx1ZvRXZ75QK4hcCQuYNk4l01zutV1yAb+3OC1A919J6T4sHa6uQUS5Htut6lA6azQH8elg==
X-Received: by 2002:a7b:cc17:0:b0:38d:af7:3848 with SMTP id f23-20020a7bcc17000000b0038d0af73848mr7164990wmh.41.1651660239194;
        Wed, 04 May 2022 03:30:39 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k6-20020a05600c1c8600b0039429bfebebsm7521395wms.3.2022.05.04.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:30:38 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 1/2] hwmon: acpi_power_meter: fix style issue
Date:   Wed,  4 May 2022 10:30:27 +0000
Message-Id: <20220504103028.493155-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504103028.493155-1-clabbe@baylibre.com>
References: <20220504103028.493155-1-clabbe@baylibre.com>
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

