Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1E485B54
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbiAEWIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244803AbiAEWH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:27 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678FCC034001
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id v13so572228pfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/IuSp3Y38S2vt00bgOi6OL/cnqEjvY89FjrAH96lLck=;
        b=Hh0FkNaCuRsotDlfcIZfsT5NLuKqITOrrht3qbo39j2JGeXryuoDkg7fHQ0kVthveD
         cwjbsbTUO7pqTF1rZXCtf+CwhYrV6TmweMDUdSW5TjjpC/+kwD08reF0rJ/R2jOLgQMX
         zMkv9zvVferEtkW0DGLiVeRLEUrlWtxOw3pD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/IuSp3Y38S2vt00bgOi6OL/cnqEjvY89FjrAH96lLck=;
        b=q8eZlSfs6xZ253LmigY4zCTVEJlhsQGTMBli1zibASYWn39xEaW17T+2l1dm7jndWK
         /W7GFJnf4fMInbLfdOfF8rEHI3+m3/9tV3T855po1Ah1+/vUnL3iwo6ocxs3lAlo61tY
         3ak6OjoEYQzCxQWIeVYJqKzJ1dwjMuCbNrhWXaM+tskfXCBzy3uw1WdY3YO70l0/214F
         E7jdknFYm20vmrTIUThONGKRY/76WIKZYqWOrfB45nqTrmgE7awo0nFdRkU8zQMtpOQ8
         Lb22+2om4Sln5L4jNQ3nFp6vs3ZNus2iZ3jnwrfbwMO/OZ+drccfEUy/gBupLGI3mm8O
         4syw==
X-Gm-Message-State: AOAM5316iePGXvHk2fjoO+pADrLLA4CgDUYLMPeoLSUq8QBzL1vwdEmw
        Sip/xd5LieAQbUb6Ih4PmuwFTw==
X-Google-Smtp-Source: ABdhPJwTwZqb5UvU/zSHL/zlEI8zfQWAg6dlq2gWNR0Z1SnHhiignHs5ZnXRdUX8MZnGWqL1foiDrQ==
X-Received: by 2002:a63:920e:: with SMTP id o14mr15565315pgd.216.1641420442965;
        Wed, 05 Jan 2022 14:07:22 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id j206sm98255pfd.94.2022.01.05.14.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:22 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        jic23@kernel.org, dtor@chromium.org, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org, lee.jones@linaro.org, pmalani@chromium.org,
        sre@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lgirdwood@gmail.com,
        a.zummo@towertech.it, cychiang@chromium.org, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 10/17] HID: google: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:46 -0800
Message-Id: <20220105220653.122451-11-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220105220653.122451-1-gwendal@chromium.org>
References: <20220105220653.122451-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'make nsdeps' to add missing dependencies.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 0403beb3104b9e..b5d3fa1097a97d 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -640,3 +640,4 @@ static void __exit hammer_exit(void)
 module_exit(hammer_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
-- 
2.34.1.448.ga2b2bfdf31-goog

