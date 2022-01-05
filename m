Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D578C485B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbiAEWKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244799AbiAEWI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:08:26 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702DCC033241
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:37 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 205so610417pfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=joT4Hamr7nYYsX0sIQtfBrT59kXuUShi7UkeBn3j3RA=;
        b=Zfg/NHmiXaeR9Ee9SbID3n8FNUluxp7uH32s1HGGjON6yeZ4a+1NCK9vE/Dr45/Avc
         2jNCgKJcWI9h3q9P9WuCwJB23BTkninpded66iLip/4/RxDCqmLPaJ8uUdhB2dtNO9Ke
         2SMwqLCZ3p+0GWDefa6R06nG3y0/6eIYi3U24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=joT4Hamr7nYYsX0sIQtfBrT59kXuUShi7UkeBn3j3RA=;
        b=Z0gkcbYA0nsPVgyWBWetWKWxS6xp+CL+9WI1qiY0CsCYjUOi+z5A4mB2txHCWarEm6
         FiI/Xw3EIRSvAupx2A3JHAkLodAxL4Zq3hDG81ch5uTxwgNebcVNps3HkvBhkKy4s9IB
         li3sJA47P8op7FgdowdqAxdEnFXpqXH4+LvyvHPBW6z0nCeTDQ1j4EKxlqjRVdYT2ep6
         c4sT5SyoE7AKE/MDy1uy39uGo0MauY8pXjGepog5VkrrmIE8TvXY8/sJpdXqRlxKYhJH
         wOl/JiG8x/w1zKDeBSwuxmiK1L2twsusG1ajx19E9dHlJLspLngWMeLd/j10eEK5m3KW
         nVWw==
X-Gm-Message-State: AOAM5309Mc1bWTs33iHjbDWSq3902LBkhrYyJsFlQI6+x3EX+pIcBMgU
        Xd4TxEVxanEQeXVk59w9cjaSdA==
X-Google-Smtp-Source: ABdhPJwfPfDT1z9x6OW0mb2fLPTf3i1CvbbFd6UYGViO1N5c7itG3VJW4in7BtsefpkbU0Vy/yLy8A==
X-Received: by 2002:a63:6f49:: with SMTP id k70mr39086646pgc.358.1641420457055;
        Wed, 05 Jan 2022 14:07:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id j16sm88106pfu.216.2022.01.05.14.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:36 -0800 (PST)
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
Subject: [PATCH 17/17] ASoC: cros_ec_codec: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:53 -0800
Message-Id: <20220105220653.122451-18-gwendal@chromium.org>
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
 sound/soc/codecs/cros_ec_codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 9b92e1a0d1a3a7..8d8fb8403fb80a 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -1062,6 +1062,7 @@ static struct platform_driver cros_ec_codec_platform_driver = {
 module_platform_driver(cros_ec_codec_platform_driver);
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("ChromeOS EC codec driver");
 MODULE_AUTHOR("Cheng-Yi Chiang <cychiang@chromium.org>");
 MODULE_ALIAS("platform:cros-ec-codec");
-- 
2.34.1.448.ga2b2bfdf31-goog

