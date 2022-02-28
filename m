Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFD34C7830
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiB1Smn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240821AbiB1SmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:42:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8E9245A6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:37:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r10so16899864wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FlcmLpC9MBKD3947PIF9JBPxwRTyA5/sqH+s1PuwUHA=;
        b=S5++n9QxaQfiFhgQFs96jfErSI/ww1y7RpotfHjiJEWLsph0ZM/igU4VDtQfolrv7z
         jUOFYtkgyTZDnHbFp+D185jf2GxZa4+rpL6Pkrcuws8veJn7YEwjBQFuL1CKU7VT0+QE
         UeCpiTSDs3iIHb70piAFIZygkYVrN51zrxA1VO1108x5+WQpnpNfkHQaGil6eg8IgErG
         E95mQRsHwvyCdnrsdonlQZjnRtLF3UJxJ3YFAtzGy7sqHQsn84H5ZfGh9Q/gDDf3CAFe
         wemf6FQ6pAsU8L5DgJMEmQk4ypOFFeyG6BLRYdQU/fmN0N5l3/GkP+7LeSOagPMWsG3i
         ndJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FlcmLpC9MBKD3947PIF9JBPxwRTyA5/sqH+s1PuwUHA=;
        b=1phxtEkUz6pvYRBbFgsMk8lkjjiz8713Kf86UYcUOWVJ6AFN8ypG0byN2S4oEhcR2H
         VhEJBrbR4jNylOwkZjr9GHeRgHdA89PpkOC2a7mpqHAb4sHWYOadX5eKjoJW6av5z0kg
         UzIjFNXSUQd2K6Ck+U0ybW5SDguQ2GRrtKobKUXI8odIBzSIIjwnFzUybVUFRFhJr55c
         WaOiZ3FQPFSLIO6AZMmnIkzZv2IN6fbZjK7jUNUDnJwmFhDKaXaT6VK8SYXWaG/VwOTa
         AN8zeWiyIIMUTL4mUaYbyNhlddmBCzX3pHVf+D7f9aqFw2vguL+RmHe2EAAkEddNuVps
         qB5w==
X-Gm-Message-State: AOAM532xXb8boiPWgbQ0Vg8AHLHp3h5/HaTV01fqz1k6dQgRD4mx5BhT
        zciMKbXaAnKMw6opUF5tqjE=
X-Google-Smtp-Source: ABdhPJzdPnTmp+jt9Q6auFBhuceMuV3NSfET7n29J8hcSME3Pn3qZnJsDTxIqxll+743o4mXZnt2Og==
X-Received: by 2002:adf:bbcd:0:b0:1ed:b9a6:c66d with SMTP id z13-20020adfbbcd000000b001edb9a6c66dmr16931748wrg.455.1646073448611;
        Mon, 28 Feb 2022 10:37:28 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d4ec3000000b001ea95eba44dsm11118198wrv.109.2022.02.28.10.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:37:28 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     andrzej.hajda@intel.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        maxime@cerno.tech, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/bridge: ti-sn65dsi83: switch to devm_drm_of_get_bridge
Date:   Mon, 28 Feb 2022 19:37:24 +0100
Message-Id: <20220228183724.25030-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 945f08de45f1..91cc00b66d3c 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -552,8 +552,6 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
 	struct drm_bridge *panel_bridge;
 	struct device *dev = ctx->dev;
 	struct device_node *endpoint;
-	struct drm_panel *panel;
-	int ret;
 
 	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
 	ctx->dsi_lanes = of_property_count_u32_elems(endpoint, "data-lanes");
@@ -588,14 +586,9 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
 		}
 	}
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, 0, &panel, &panel_bridge);
-	if (ret < 0)
-		return ret;
-	if (panel) {
-		panel_bridge = devm_drm_panel_bridge_add(dev, panel);
-		if (IS_ERR(panel_bridge))
-			return PTR_ERR(panel_bridge);
-	}
+	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
+	if (IS_ERR(panel_bridge))
+		return PTR_ERR(panel_bridge);
 
 	ctx->panel_bridge = panel_bridge;
 
-- 
2.25.1

