Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B814905BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiAQKKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbiAQKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:10:01 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD53C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 02:10:01 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u11so15550239plh.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 02:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=GWAKRaqzcC+I3EL6268UUAjZ8aE+eDwCkX5smZz7T3c=;
        b=JGK/3h4tRw3PYRSfbFoo5v8I9I4+IvA2FviICIsZNb+8WlWjIGnRLL4aBXZEoStxA3
         CvYC/OcubraSa3HWR6G336eQZT4m9P9xHCiixBxCpHQlzq7CPqx9wvoJXzgNRrP/nUt4
         DBOQAq+99ceK+0mXlspYSoi0fgOrEo35ZH99kB3FdJGVzPQDwO1fJhmmvLih1C/j1J0P
         o4TbNn3n7hScYb2IauYOgBXm7MVy1E0gxgDO6Nc9dxvQTiB0biUL8kI8fpX47HMsPMcg
         GhBWMmVbTAV1/xJDVSKSe7jyG/trIIDY22ETDOX66B4xU2Dk3ZrR88ddiPTebBmKgVw9
         IdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GWAKRaqzcC+I3EL6268UUAjZ8aE+eDwCkX5smZz7T3c=;
        b=HLhRc+IJrJmOHd0P0viqgEcp1cI0vwikvxQ9aRoe7Ior6rU5YmJt2Ov7LS8Bk1eQ13
         oWHRhJqioEMT/wwOCYRnMTnOOX8u3FuZSAYSOxqiLO09ZtRtf3XxZMwdwtxe6pu4Cm5d
         bqhjhRrtoS49mrgYVw25in0nwF84jkAOd2WWCNFukhH3tgPoYElQIGSySWJACzoQAK9a
         pMckmENJvmY4HgsAlXsBn/+y6BS2VdMZm75PXwemdYyv09VtgsnTL7SYvRGiurjrCRAV
         GoRBI0b4krrNiaOlHIK7x+5l6s30dJ+c1n7Ae1I/EqFyxM+FLup8BXP+YrTdlLYjOvJm
         4omw==
X-Gm-Message-State: AOAM532iAHY51XLFp7ZaZqY3pRLPD+OUftT4GNCFRY2fZ0kUp6ZsHpn0
        3hVHNwD31I+rn1JrPB7xvqM=
X-Google-Smtp-Source: ABdhPJyz3g8fmREHazW3FlYjqMu/UTKaQlahsty8tV/piqCCRc/QGEzaWqfLmxeJSDufrJideLorSg==
X-Received: by 2002:a17:90b:3884:: with SMTP id mu4mr10493126pjb.133.1642414200940;
        Mon, 17 Jan 2022 02:10:00 -0800 (PST)
Received: from owen.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id n42sm5401509pfv.147.2022.01.17.02.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 02:10:00 -0800 (PST)
From:   owen <qwt9588@gmail.com>
X-Google-Original-From: owen <qwt9588@gamil.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, owen <qwt9588@gmail.com>
Subject: [PATCH v5] drm/bridge: anx7625: Return -EPROBE_DEFER if the dsi host was not found
Date:   Mon, 17 Jan 2022 18:09:49 +0800
Message-Id: <20220117100949.9542-1-qwt9588@gamil.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: owen <qwt9588@gmail.com>

It will connect to the mipi dsi host and find the corresponding 
mipi dsi host node, but the node registered by the mipi dsi host 
has not been loaded yet. of_find_mipi_dsi_host_by_node() returns -EINVAL 
which causes the calling driver to fail.

If the anx7625 driver is loaded afterwards the driver requesting 
the mipi dsi host will not notice this.

Better approach is to return -EPROBE_DEFER in such case. 
Then when the anx7625 driver appears the driver requesting 
the mipi dsi host will be probed again.

Signed-off-by: owen <qwt9588@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 2346dbcc505f..297bbeb5aae0 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1660,7 +1660,7 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
 	host = of_find_mipi_dsi_host_by_node(ctx->pdata.mipi_host_node);
 	if (!host) {
 		DRM_DEV_ERROR(dev, "fail to find dsi host.\n");
-		return -EINVAL;
+		return -EPROBE_DEFER;
 	}
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
-- 
2.31.0

