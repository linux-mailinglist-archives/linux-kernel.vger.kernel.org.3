Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD494B4161
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbiBNFhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:37:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiBNFhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:37:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9324EA18
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:37:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m10-20020a25800a000000b0061daa5b7151so31693545ybk.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RM7B/VP3RiMIbRxHXAkoswg4A5f1B95tqoOVGTsgT8Q=;
        b=TTbMKvwz6PseJb5lRAXLQiBv75QGAS10Z9JTQyCyZ32BBng4ecFDNGi05LGrA57+Fv
         +cgxTg66+Ae6IeLW50dDVi+h2CZqYrwt9erF1a+Qa3ZqUuQnXUpkEhOLGdZEDsmEtlOD
         aa4oKgzbTO7qdsYuMM9iefxLmoVMihDg2tb+VlAp/Hdb2c5gQwONJz1XJ01Jl5Ln9xl7
         jq4QV7B/naowDN69QoT8aNjnfHnCL5sbZxKazEBN2lAJpA8RKeNzdRDr0T2UqrxznoZr
         FC8aW/1Lq/VsZWV1tzNCy/EIcMbu6uaLKupmhBW6xUQeT0FcH85gsLXHR3nPNvCTJQ4R
         vDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RM7B/VP3RiMIbRxHXAkoswg4A5f1B95tqoOVGTsgT8Q=;
        b=1QS55yfjV7rllizRfsznIKyvJT8y3bsJKlpJkHXq4gghxcC4mljF506MBJpElMeNnR
         I4m1nSbzlgcQOu1dB4GCJEREFrzpOiyD0krU0WluyAtD/m0I5H49Qfn2kct6t/TKj6UI
         0ckpLORFOFlZnJC0iT3q6foyV2Qx91m/MCkM2SVke4wYF3fnIOnDJc6Nn+zC+8BqvHrF
         Ph4lJiVXnafoRsN5kJD5B9Pv9jIWEI96Kos1+Ujq3rWHIWz7wOgdY9az2InGeRpZT0dh
         xDcT8zdtsk1yf1RiDijEXmVgURktc7XN1LGT1HeKsoYF3vDrpVoesQpOfMfTDAmRvne/
         vorw==
X-Gm-Message-State: AOAM530RakpgGs/K5IgtJMopVJJZi1qG7L3fp9/azd+DK8gbo8Jgf/uz
        IdqZIDl37uyv1vADiQR0UJ6aVgx6Ft+b
X-Google-Smtp-Source: ABdhPJx+13Gw/OOKY8khKfw7V8FFpvA8xTR4gZkToZpRpsfvFKIV+UFm7cr8RGYsxDkI86AyD9bMelqUh6+q
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:f315:f92d:e3d3:2539])
 (user=tzungbi job=sendgmr) by 2002:a25:e705:: with SMTP id
 e5mr786251ybh.216.1644817049075; Sun, 13 Feb 2022 21:37:29 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:36:42 +0800
In-Reply-To: <20220214053646.3088298-1-tzungbi@google.com>
Message-Id: <20220214053646.3088298-2-tzungbi@google.com>
Mime-Version: 1.0
References: <20220214053646.3088298-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 1/5] platform/chrome: cros_kbd_led_backlight: sort headers alphabetically
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/platform/chrome/cros_kbd_led_backlight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index aa409f0201fb..f9587a562bb7 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -4,12 +4,12 @@
 // Copyright (C) 2012 Google, Inc.
 
 #include <linux/acpi.h>
-#include <linux/leds.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-- 
2.35.1.265.g69c8d7142f-goog

