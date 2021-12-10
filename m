Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0B470B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbhLJUPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344127AbhLJUPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:15:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB45C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 12:11:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so18315695ybj.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mVZR4NW2NH5z/l+VDAPU353h9uYgJcW0LaZCIEsF1jk=;
        b=LtVI2zYkXnuBq/kjSog3krMAswj0f4DadCb+rkLJKX2utG6x1szOvIP9QzSDgzBIcm
         Ch9DMsrH6Rcsw1hhgTJJvkdAQyS5XdQv5yAOYwWWrno57zfqRVhqezFIG0GpapKcv+1e
         NTyp2pOey8lHPSth8GNQod2Tk228xjt+t/2Q8p9+OXIgFtLmEqL+P1VRGZ30IbGmQed8
         YeYEjX48RhmGDeB5lE3mpZP7hc9Hlr3SQJpYIuDRVe1C/EKfeY/RhQoCaTi3aqBoE/0B
         xXxRXxFjGfEDuaQD1EMT6T83miSczCmaNawkxX78nAA6PshO8FdEzPm3Ldj/2vbIxmbJ
         5C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mVZR4NW2NH5z/l+VDAPU353h9uYgJcW0LaZCIEsF1jk=;
        b=QYOM65ABPIV4ApLnDcL2jmw7XFtaoQkUtzQP+RadnwuNg8n8wkALAekxkO0loz/EeV
         /MdUmxmWJ4Ndk1pPOSEMwnwGrpo7JcIgaIZEE9cJ5jqvIG7abwlD/NRw2genh6Is2jGX
         ssQVJ6YFocuHl/pFb9x35DM7l/VeKhZSu+LZy0mv8Anxa0qi8qCGNtOzxzDpcBkHOqgz
         6H1+x3nRKM7PEPNKPW2c/LwqzI2U5snPVCWMfGKJljjFXoh7DwtGZh1wcng7YPJO4Gtz
         n/9JBRAKSHyqvEAT8RLZ95s0dgvbZLdkd4OVpYhmQXMcpeURC1jW73/nKipoGg9vBlRB
         Lidw==
X-Gm-Message-State: AOAM530o/ioPoHJZj+8CCsuq5BoMjO6WkGUdeud1Ncldpz5zzg6ke6OQ
        YW2wzMXFc4OwmD9yNgSyMNMcWLTBAv11
X-Google-Smtp-Source: ABdhPJz1lgeFMYc85C/POqMgxCQmHqxO2zBUc3vvCO1jWDYUoNFx7IkHZAuGeq1O012657U4w+NRPMLP/hbZ
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:9ecf:cc67:420b:ba67])
 (user=rajatja job=sendgmr) by 2002:a05:6902:114a:: with SMTP id
 p10mr16953372ybu.272.1639167108627; Fri, 10 Dec 2021 12:11:48 -0800 (PST)
Date:   Fri, 10 Dec 2021 12:11:43 -0800
Message-Id: <20211210201144.1975655-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 1/2] drm/privacy_screen_x86: Add entry for ChromeOS privacy-screen
From:   Rajat Jain <rajatja@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        gwendal@google.com, seanpaul@google.com, marcheau@google.com,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a static entry in the x86 table, to detect and wait for
privacy-screen on some ChromeOS platforms.

Please note that this means that if CONFIG_CHROMEOS_PRIVACY_SCREEN is
enabled, and if "GOOG0010" device is found in ACPI, then the i915 probe
shall return EPROBE_DEFER until a platform driver actually registers the
privacy-screen: https://hansdegoede.livejournal.com/25948.html

Signed-off-by: Rajat Jain <rajatja@google.com>
---
This patch is rebased on top of linux-next/master

 drivers/gpu/drm/drm_privacy_screen_x86.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
index a2cafb294ca6..3728870a98e7 100644
--- a/drivers/gpu/drm/drm_privacy_screen_x86.c
+++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
@@ -45,6 +45,17 @@ static bool __init detect_thinkpad_privacy_screen(void)
 
 	return (output & 0x10000) ? true : false;
 }
+#elif IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
+
+static bool __init detect_chromeos_privacy_screen(void)
+{
+	if (!acpi_dev_present("GOOG0010", NULL, -1))
+		return false;
+
+	pr_info("%s: Need to wait for ChromeOS privacy-screen", __func__);
+	return true;
+
+}
 #endif
 
 static const struct arch_init_data arch_init_data[] __initconst = {
@@ -57,6 +68,15 @@ static const struct arch_init_data arch_init_data[] __initconst = {
 		},
 		.detect = detect_thinkpad_privacy_screen,
 	},
+#elif IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
+	{
+		.lookup = {
+			.dev_id = NULL,
+			.con_id = NULL,
+			.provider = "privacy_screen-GOOG0010:00",
+		},
+		.detect = detect_chromeos_privacy_screen,
+	},
 #endif
 };
 
-- 
2.34.1.173.g76aa8bc2d0-goog

