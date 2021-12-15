Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7221B4754B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhLOI4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbhLOI4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:56:03 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E19C061574;
        Wed, 15 Dec 2021 00:56:03 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id j17so21117897qtx.2;
        Wed, 15 Dec 2021 00:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbfkGjADP1JP/ccn6Y79dw0BB+q77R8upChfhWhpbLY=;
        b=QXkOpqLoRDDSGEf+AKDxWv1QFdCmuMqUjVA8i/659rKFxt5MDdmYGq1Va3+xt4xFWn
         IbmRS6G79/ayBNeyvLsUXJa5B25V31ewyeG6mriDRl05OyLYuonJjzZkz5/gzgRBWwSY
         FujwC5lJEo49cYy1CCLMPqhWg1fIqquQ7F1PsTfqC4edm3O6I6OqqjsYmkCkDIDcqBBv
         3K+E9Jov4WP9Src1YIj53P5sSLYU2RgOjKiQd6tqUUrMgPwb85qooPV4q/htvnGcJiOz
         04fzUV19TQL/zQhrxkcxDCBiCQrFo0YchSj5plkEyKKSN4KMhRsV/KI0kBjbP2e75lo7
         ovsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbfkGjADP1JP/ccn6Y79dw0BB+q77R8upChfhWhpbLY=;
        b=Oj9mRjwX5b8V4VElGzpmfkEu/lLUlOxKF/XAq8fMmmJdjZxWKh+P55cHGrFrJJfOvR
         uhGkJLTFme0Nv2ralsGGcy8fM8Su5LLvB3ea5S2ov98Mn+YalNqNiGU3FzU6LXkD4R1X
         n83/buU8cv5QvIMsl94gF6ggHg2UuRGsBKdldQJCd1WN67G+HfGMTkTGoeNGsBoDc8Pf
         XU9oh/K+fvKwUyL+kQq17t/P9od6YtLMMlKMR6qydOpDH6N89V/eChfpGCPCQZcR3I5s
         omVVzzYFCpCBcl5J6krJarfc4FCAYd0yvgH7Lp9t3sUt928MxNopTuAO9ovSW0gqVaN+
         IXQw==
X-Gm-Message-State: AOAM531apPkUC3GszdwFhY0J016LIX7FaZn6GtMSmsKiPHwdoqSR0jAG
        6qqpErN586Hm2JrCQF3GtcrN3ROwx9o=
X-Google-Smtp-Source: ABdhPJzLfQfHP7IxlGx7vxk8z92ch8kS1M5ARNToa0yOaFgzRN1nbpR8d1Z4m+rwQRnrr/BsDfzCQw==
X-Received: by 2002:ac8:5949:: with SMTP id 9mr10885179qtz.522.1639558562394;
        Wed, 15 Dec 2021 00:56:02 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q185sm696876qke.64.2021.12.15.00.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 00:56:01 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     robdclark@gmail.com
Cc:     sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch, swboyd@chromium.org, quic_khsieh@quicinc.com,
        dmitry.baryshkov@linaro.org, bjorn.andersson@linaro.org,
        linux@roeck-us.net, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/msm/dp: remove unneeded variable
Date:   Wed, 15 Dec 2021 08:55:54 +0000
Message-Id: <20211215085554.444351-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8d9c19dbf33e..7cc4d21f2091 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -416,12 +416,11 @@ static int dp_display_usbpd_configure_cb(struct device *dev)
 
 static int dp_display_usbpd_disconnect_cb(struct device *dev)
 {
-	int rc = 0;
 	struct dp_display_private *dp = dev_get_dp_display_private(dev);
 
 	dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
 
-	return rc;
+	return 0;
 }
 
 static void dp_display_handle_video_request(struct dp_display_private *dp)
-- 
2.25.1

