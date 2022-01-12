Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD90248CE04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiALVtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiALVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:49:48 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9337C06173F;
        Wed, 12 Jan 2022 13:49:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s30so12874310lfo.7;
        Wed, 12 Jan 2022 13:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3rnP+krtV/CZXNrZMFcoh1rVGhR/Cm40MPurpzxHec=;
        b=ICzV5OZYp0axM8E6tZ33uQ1jSCGg0ziJmWRJkme4+K+JYbuKy3SpgdNMwn/IuGcnIP
         xB8FDtisPkBpgLb7lsA9852CmM7+tccq52mZneXn1iPrjvpj1fcWv+nWrYqt2yLECqxq
         /fkbRF4YKwZyIXRHTiN5EfoWL/msEa1Zf0hkV2JbOo5rfNg5c17k5g4tyuDajR0vcvpd
         B0k0iqR1Cvq9xblFapdI0Ee1Bc3nvFUS6F5/9GF2avrCiGtMORKegjwD7IMiztga1qNA
         4SX9ZxCcD14dsuGECUcGEjZVp4Jm3lQZxhNsV85d34BqVMeJD2HabE9ZXiDFu7EMNOYz
         r5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3rnP+krtV/CZXNrZMFcoh1rVGhR/Cm40MPurpzxHec=;
        b=G//CeA1zj6cc3mH5G0nXQPI60w8J6qAK9LP3hkE9G/LkXS1y12e/C3CZaNM1Ef0Mx5
         T5ZtNtBDmjVnZv0D2jyowVGLmqHyl+bGCUJ0HheoxAIhDUDHTAkYuB0cmAYwmwtqy751
         kKBaBdeYkC5/0jEjXKScQQwtIunYMtMIDi3cN+FRrPxUp0SXdIq159Xrb5IwfrSqqpuc
         tO4lhUqbq+zEoK27HyZn+PLHEkD/xrnkaUXK7RXtWzoOyOsx8alyf/k7iUqhfCUHDLZe
         uWJGIjhCzGfjFCA3hrAQwaZpWOgSNl2bWKNtssTcdElQ3UFvUba2tmfqlSPLIfvw72IK
         p6Dg==
X-Gm-Message-State: AOAM5311CsaA9DtJRhT2fvHQWEvA/NI6yP/Tf1Mr5TP0B9BvKF+lLOIb
        wNRZbzzH02wATc7Sy2A6NV18G4dWqLc=
X-Google-Smtp-Source: ABdhPJztV4IHyOuCpVBVrqzOm7BUaqURkhK+Iy6jboiq/uvgtHCOCTPV8O9TS44tCxhZVInQO61Opw==
X-Received: by 2002:ac2:5e85:: with SMTP id b5mr1299812lfq.0.1642024186144;
        Wed, 12 Jan 2022 13:49:46 -0800 (PST)
Received: from localhost.localdomain ([94.179.50.100])
        by smtp.gmail.com with ESMTPSA id m21sm99399lfg.121.2022.01.12.13.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 13:49:45 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Aleksa Savic <savicaleksa83@gmail.com>,
        Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus_wmi_sensors) add ASUS ROG STRIX B450-F GAMING II
Date:   Wed, 12 Jan 2022 23:49:17 +0200
Message-Id: <20220112214917.11662-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS ROG STRIX B450-F GAMING II has support of the same WMI
monitoring method as ASUS ROG STRIX B450-F GAMING.

This commit adds "ASUS ROG STRIX B450-F GAMING II" to
the list of boards that can be monitored using ASUS WMI.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/asus_wmi_sensors.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
index c80eee874b6c..8fdcb62ae52d 100644
--- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -77,6 +77,7 @@ static const struct dmi_system_id asus_wmi_dmi_table[] = {
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VII HERO (WI-FI)"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B450-E GAMING"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B450-F GAMING"),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B450-F GAMING II"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B450-I GAMING"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X399-E GAMING"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X470-F GAMING"),

base-commit: 00f5117c5f785b95b13663e52dcdcf684a47d4e3
-- 
2.34.1

