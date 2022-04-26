Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616C9510BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355756AbiDZWTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355706AbiDZWSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:18:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52F743AC1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so1340749wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iOP2NQFztziZ3pG+HriOirkDnCYWSf0u15l1vopF39g=;
        b=GLWRBwqChGmda03/DWLMG702tFwmIIfyNEXkhDZ6ihbsRy8Y3hMF6ClLKucK+56LwA
         5gu1sbyyu3yMqj9hKC9ib/xqekxZHZ3Ryl0mYJru2IxLPZl+oWuRnCQ+75aw/SSZIXMD
         a/MvQN9piW40uYl9L70G9T4wV34Uy+rJDlAmcOtcl1nXETTJXvLLjFqujHOJMeJ8UFnk
         yl3ukEQ2AWERHwo1HoSgbRJZ0bHo+YjBAuBMTCa0qXxbMgwTQaecPqt8pHlymky1u+yM
         1N2fNS2cGZcRvIT0Zr+T52MijGt3NDyB+2U0u4e3jrKVzFMW7HBqRJWP2sqQnFwj6He2
         s8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOP2NQFztziZ3pG+HriOirkDnCYWSf0u15l1vopF39g=;
        b=uePVbv0XwBuFvK9gX2C6VzerEpny3MSdXWXMZeiN0DewFRpbCOsu99qPN3GuyibRPm
         eNQdSKoFMXeXF/1M9kufpxMQQ9KRNFlegbhKZQKPg+wIuEEQoejnZIWRDczkY8GiyH0B
         gSVJmI4YgNSp8A/ghM5Iv9fEPxsY1sj2pazSjslGjSDEun0tci1//iNAfgcn4dCzpO3M
         NBGwxzezAJJw8H4tNj9UmEdt+JF4sHm5nxLE+VnbPdksNrVf20ShTBXRRlj8OSnktSdd
         xU6xn9RtKdhvcougn99fmzPE34eS3+OnixHPLfFonk/Elr4Di5/UFAQNXkUCu7EcfJm7
         HU0w==
X-Gm-Message-State: AOAM5331pg4yzpg9n/5AxSuQhHpImyWBlpwW6obZmCMmM44PZbkdmvJS
        we+Q9y8n65w9fn8pzGqQ7TyvyA==
X-Google-Smtp-Source: ABdhPJxRdwO9UJyj54JTQE6/hmyLh8iBaBLA2sQ+recJNzEUvb7jjlleG2eAPkRGzzITOvkuoMvsRw==
X-Received: by 2002:a05:600c:4e4d:b0:38f:11ed:595 with SMTP id e13-20020a05600c4e4d00b0038f11ed0595mr23317660wmq.64.1651011341262;
        Tue, 26 Apr 2022 15:15:41 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] thermal/core: Remove unneeded EXPORT_SYMBOLS
Date:   Wed, 27 Apr 2022 00:15:16 +0200
Message-Id: <20220426221523.3056696-9-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different functions are exporting the symbols but are actually only
used by the thermal framework internals. Remove these EXPORT_SYMBOLS.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 41d6898ec5b3..76b831d9e0e9 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -39,7 +39,6 @@ int get_tz_trend(struct thermal_zone *tz, int trip)
 
 	return trend;
 }
-EXPORT_SYMBOL(get_tz_trend);
 
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone *tz,
@@ -228,7 +227,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	}
 	mutex_unlock(&cdev->lock);
 }
-EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
  * thermal_zone_get_slope - return the slope attribute of the thermal zone
-- 
2.25.1

