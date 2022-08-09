Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B798658E2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiHIWGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiHIWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1497AA8
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n185so6924250wmn.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DCGZJNnTNRxapeV7V7/86oJke50DUo9T/8u4uKpg7OE=;
        b=BH43yErG6uHSnDVJb4xyCvjIkvUmTzsxEmCrsHjMgxaWTPulZoQNpfNMwuUXmCa5Ot
         zPml5m0HBlfkf293YzAW3jMf5/aHKm5PSTIlwM5Y7YENWOb0ufUhC3pWmWeils9HxEWo
         YiY1YOfavxNJdnKpkA5GIQ7lF6HvESqL8W2dZ4W+naSeybsDkk/eSh6Hmk0e9PZSptnf
         jFE2riJ8ay3eHMKtdyP6mOgBHJwUvuImMErcLixHxKUs6gB0DKYIIaWyZZbPcrFWpeYY
         pOwlnEmJbRq9uwFedt2ZdNHJUnTk1IoA41Z5S8zAd14Q6jraazJ1EEq4tqD/qOmj9BEd
         iLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DCGZJNnTNRxapeV7V7/86oJke50DUo9T/8u4uKpg7OE=;
        b=bAEFXo4KaSbyQhVZBh5ikU956PjMNBSG5tXdMl06kvIth0ALx489hGTrT8FNHz+VF0
         WctdlEOI8OLCGxxBtz+i1HZiEOXTkOWc5QdS5PoN9fmo7o8CuUJPF/Oazs4hIW9s3F7r
         bQqlPywMkSupFCkBjlkAQfwQue8Tz4sP+vv/qlbK0h6BO4ma1vtoFdH7bS68YHwqw/wP
         W9Wy6QrfDC2WTPvogn+mz8PPJZTA1dNK3KcxQ5jCCRJTpGVSUd/HApKAr+jCFuYYQFGh
         EBNSdwChL6gtR9+5E0cuy9tNHS9IWEFls3OH5fjpDMPugr7ZdhAfpRSKXb6kvDAIWjxO
         X1TA==
X-Gm-Message-State: ACgBeo3AjLqOjz0VfPgJKTX5kzRZ58x4ArJhNZ0c2GMuOmrSzLv3SIaJ
        LYo/Q/fgSXq6Uqke1uPJRkKbpg==
X-Google-Smtp-Source: AA6agR5bPqPTfTNhvaPfu/PwGgBm+2Yslrbp0QONkaANUUSWaPfcPPNeSupgay29AgJrD1wi3qZnOQ==
X-Received: by 2002:a05:600c:19cc:b0:3a3:3cfe:d548 with SMTP id u12-20020a05600c19cc00b003a33cfed548mr293243wmq.6.1660082715542;
        Tue, 09 Aug 2022 15:05:15 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 14/26] thermal/core/OF: Remove unused functions
Date:   Wed, 10 Aug 2022 00:04:24 +0200
Message-Id: <20220809220436.711020-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dead code: of_thermal_get_trip_points()

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h |  7 -------
 drivers/thermal/thermal_of.c   | 17 -----------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 194e98a5b102..04565746afbf 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -145,8 +145,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 #ifdef CONFIG_THERMAL_OF
 int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
-const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *);
 #else
 static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
@@ -157,11 +155,6 @@ static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 {
 	return false;
 }
-static inline const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
-{
-	return NULL;
-}
 #endif
 
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 70171fb4283f..d8bba0009194 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -54,23 +54,6 @@ bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
 
-/**
- * of_thermal_get_trip_points - function to get access to a globally exported
- *				trip points
- *
- * @tz:	pointer to a thermal zone
- *
- * This function provides a pointer to trip points table
- *
- * Return: pointer to trip points table, NULL otherwise
- */
-const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
-{
-	return tz->trips;
-}
-EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-- 
2.34.1

