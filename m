Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875B14C780C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbiB1SkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiB1Sjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:39:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D738A457BA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:29:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2823064wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VuAEmRESdE1T8c0q/a9AI7lflQyuoHxCApNPqjz7qjk=;
        b=HPyz6eOXC+4y8YUbQRLNrR4LMh1Kv+NGGJVFmbMdT1VyiOBRoQE0YGm3MQ8olw0sns
         7Gg0e5hQzA6WKacJkM01pFfLEDxHQOjyK5mPoE8U11EJdH4GVT51dCGcPNG/6zPbRa3p
         dG8ZAstyvEf0wU/qi4n/PsrN1l4m/XC3ygvgQ3cLLVgBuTSSePwUJD7vJTgO0Ceqexug
         yYs1/ulY9Q6iWA5XG36iHDETUfI+Zwu20e8amUFEcEfhsrowd0RT6UbJXIQtVHUYkrDp
         /N/L3PqBqM4TnL1Vd+FtA/1Y51I2y1tjKeczypvLJarcrDIpBXqZmxZBlQM5Xnonfa+d
         ExLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VuAEmRESdE1T8c0q/a9AI7lflQyuoHxCApNPqjz7qjk=;
        b=uZKr75Y+5F+CayQDTg++EY6BBp0pp3wxHl/ZioQOPnC+slIm/aTrOHmXA3M8oBEgEL
         JG9X7W7e9MwJA2UEcTUV3ZA3O56jRc0kaih9Iu3V33X3tG2iFHFMKDkMmhPBNpMeOj+4
         3JD/3f5uCI+VxEyt2mNbmHuM1ykapF54utOt5bOTFVknrfdL1YeSlnDXDfaTuoIkKzw5
         JH6ZUVLEU22+gmIWcumSoSa1I8s2gRMHXHGQexQmRaaao22LMOrEzuF1SSwRev8eLzdc
         oD2zJJp5HJ3AJKF6ODKtjbM3tySHseaX61ToDovApF0edTfLknWvIov5ZqnnhW2/8NtN
         ZACg==
X-Gm-Message-State: AOAM531unMS2W/rLXiYUfZ3M8ZGXYlyeg9YVmfFr8EcbzuSt8Cb2/jwD
        R4+Lgayo4mE5VucuPDXjalA=
X-Google-Smtp-Source: ABdhPJyJp3llhyLATodOqljj1tta971rpXwYbhIWthcZ7mXCvjqXpybAWh5xhub+FMGzliloP4Bh4g==
X-Received: by 2002:a7b:c383:0:b0:381:1b50:a9d with SMTP id s3-20020a7bc383000000b003811b500a9dmr14436066wmj.90.1646072953239;
        Mon, 28 Feb 2022 10:29:13 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id p190-20020a1c29c7000000b00381227166b2sm175538wmp.41.2022.02.28.10.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:29:12 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     andrzej.hajda@intel.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        maxime@cerno.tech, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/bridge: parade-ps8622: switch to devm_drm_of_get_bridge
Date:   Mon, 28 Feb 2022 19:29:04 +0100
Message-Id: <20220228182904.22982-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function "drm_of_find_panel_or_bridge" has been deprecated in
favor of "devm_drm_of_get_bridge".

Switch to the new function and reduce boilerplate.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 614b19f0f1b7..37b308850b4e 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -452,18 +452,13 @@ static int ps8622_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct ps8622_bridge *ps8622;
 	struct drm_bridge *panel_bridge;
-	struct drm_panel *panel;
 	int ret;
 
 	ps8622 = devm_kzalloc(dev, sizeof(*ps8622), GFP_KERNEL);
 	if (!ps8622)
 		return -ENOMEM;
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &panel, NULL);
-	if (ret)
-		return ret;
-
-	panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 0, 0);
 	if (IS_ERR(panel_bridge))
 		return PTR_ERR(panel_bridge);
 
-- 
2.25.1

