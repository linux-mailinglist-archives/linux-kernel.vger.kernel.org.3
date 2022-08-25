Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5642C5A0A41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiHYH3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiHYH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:29:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B75DFA9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:29:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so485962pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JbGIvcsfEVLV1RHydnmdeBi6HQ0+QJqGOf7I2WG/zUU=;
        b=Gn19uEzPb7lUl0trxaRTO63z3RoJGahgxtzhBIpVj3lyr1LRBHrAq8oJ4fIhKo0UpP
         to4/XSiJLyZp8ZrSe8iPg0bH8AGAwBKMhxdeYi5x5vMf3cnEngrtZptU8h5fVPvSKgF5
         aDoq1Kv8rbqLGTV6rMFZ4e1PBb3hOdxscLNsHHeGKxRGvCQAbQXEcin0v5ck4nsvEaIk
         4sWhjdOx7TtGh77Y28V0lmHH/yEhiOJgEfhfReaPAx63g8ad5etZSzv8F4sS9/8jIV0E
         4UdcllTUSpQDeWqWp/EjGbC/eBz1yfWZZrPMtmL6yYWUWhI8iyiPA2sHu1AFbc2a23c3
         UTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JbGIvcsfEVLV1RHydnmdeBi6HQ0+QJqGOf7I2WG/zUU=;
        b=kunONdEl4wZs68ZHPmwgai81jB3h2djV9b+g2dbu/1TmbVyk6cR66k/wCfb1qVmXU8
         LPKSiZA0pnte99AqjYTZ9VeFzIBO4s0FgFFpgr81OqlOIySDi2/41Ari4bG58Izle/t7
         1NSLiMMQYKmJ6uQ8u/K5TtWtnGcZ00L2l6lVqiPFtiCuxiGp5GRYsHYBP1xZNviBQekl
         qhwXxM+qDpy+Fl2bJqmU3tw2YgKIQzvT2qKMBDj315SflTk/HLr+0TzER/c1TA5K/Q2I
         TuEps5tCghhyUKg767SwjHOcGppd4VYz+DAw9zqPawe/NyUl6mlbplpBzhoWs5f3hybe
         HkVw==
X-Gm-Message-State: ACgBeo2zeXCxnGgAY1GhvSusYq2PBi2qxZC5xVd6FcFfu+r6uH5Y1ven
        beG1Pqnt9bqEK5mKhDW2dLM=
X-Google-Smtp-Source: AA6agR5eNdfyGjsShlxMUK2iVcd7RJHNVejWbYcPuno1FY9q/ArdYNJAmLGhc8KM1dSd3IJ5yeGo7w==
X-Received: by 2002:a17:902:b581:b0:172:a34e:18fd with SMTP id a1-20020a170902b58100b00172a34e18fdmr2500538pls.163.1661412557593;
        Thu, 25 Aug 2022 00:29:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm11213146pfb.91.2022.08.25.00.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:29:17 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     jernej.skrabec@gmail.com
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/bridge: parade-ps8622: Remove the unneeded result variable
Date:   Thu, 25 Aug 2022 07:29:13 +0000
Message-Id: <20220825072913.229357-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value ps8622_set() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 309de802863d..c605cd725606 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -324,14 +324,12 @@ static int ps8622_send_config(struct ps8622_bridge *ps8622)
 static int ps8622_backlight_update(struct backlight_device *bl)
 {
 	struct ps8622_bridge *ps8622 = dev_get_drvdata(&bl->dev);
-	int ret, brightness = backlight_get_brightness(bl);
+	int brightness = backlight_get_brightness(bl);
 
 	if (!ps8622->enabled)
 		return -EINVAL;
 
-	ret = ps8622_set(ps8622->client, 0x01, 0xa7, brightness);
-
-	return ret;
+	return ps8622_set(ps8622->client, 0x01, 0xa7, brightness);
 }
 
 static const struct backlight_ops ps8622_backlight_ops = {
-- 
2.25.1
