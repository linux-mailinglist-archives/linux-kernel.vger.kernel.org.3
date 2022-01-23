Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DDA497260
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiAWPTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiAWPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:19:06 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23AAC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 07:19:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso18002398wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 07:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=J2UMRvQ9bGDS8m5A2ZaIoatGYf156drXrvbt1E7Y0kM=;
        b=BaPYk3cz5CSp2mXj1dJCLXNrD6ld9SN7PqmiTBuGMhO9jXDLpH0u69DELDSOt4g8tf
         O8Iw/+xk0uV3mc6OMzhxWiCh6GpBtCwZjML8p/y0ljPseJ+cGIaWo33pZiBaLgWXcf7U
         vUswCWNO4u1Dz9RGUwwMzwHpOs3Gwx7YyALZW6wv4YECZ8FzDiZO94QtdvlEYIiE7tfy
         /7hETXh33/UPSrsSt2Ndc2T2fe7iaqo9eo/vjc3UJFrSirKb+Z49xToVdaSx9uUBBpg3
         jHWEJd1FgyQ/8no4eRj3p25be/0ZR3bWU7pKD5altXc0pfG4ZhJKEAXZu9+3ux+H4Ygg
         OPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J2UMRvQ9bGDS8m5A2ZaIoatGYf156drXrvbt1E7Y0kM=;
        b=7P2C7lgHiK4JKMT1/TaXV7OphSa02WScE+k1Tc1klZEKRLnNm2fPo5z4C8Ej1JZivx
         CQHFeUSywgZ0g/LdpKimSRXdfkjk3k/jpqztI5AtG3n7M3LFcphucwYcTF61sKRkon64
         hYiH0KVc5VtiUtC8qGEBoODWUacGnyz6822VivdJuLjqElxbdfQxA5GXl/N+BfdtZ+ja
         Yz9avClYRZOr83KQ0Y0h87aNHhV+l53ZBp5NhCLe1jTruJCGQkIEUdD/dz8m+rSYgnu1
         dEXnK7UEB+X2Xn1EaNb+PMmTTSPiB5CRzGe0FtxEIZ1PGMFGNwAIeYGWZDHgMZyhuthf
         Er3w==
X-Gm-Message-State: AOAM533OXpau2jE+4Sd4wrWnpJ6LIGBQMYbHIkEeZro8LOGIvcU8CwSv
        04FFlccUahhF7UpIfq0nU1s=
X-Google-Smtp-Source: ABdhPJyU0Jp2swuxRWeSvuDxkqQvGu61dkGQnafoc7QwAtcUBENwbgpkm1TfePlYVFXx1sgL3WOwow==
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr8388585wmh.113.1642951144349;
        Sun, 23 Jan 2022 07:19:04 -0800 (PST)
Received: from localhost (ipv6-54ac198c2dcfb6fe.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:54ac:198c:2dcf:b6fe])
        by smtp.gmail.com with ESMTPSA id a24sm9917299wmm.31.2022.01.23.07.19.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jan 2022 07:19:03 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Oliver Graute <oliver.graute@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] drm/panel: simple: add SGD GKTW70SDAD1SD
Date:   Sun, 23 Jan 2022 16:18:31 +0100
Message-Id: <20220123151833.19293-1-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Patchwork-Bot: notify
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Solomon Goldentek Display Model: GKTW70SDAD1SD
to panel-simple.

The panel spec from Variscite can be found at:
https://www.variscite.com/wp-content/uploads/2017/12/VLCD-CAP-GLD-RGB.pdf

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---

v5:
- rebased

v4:

- added the datasheet labels
- added Reviewed-by

v3:

- added flags
- added delay

v2:

- changed bpc to 6
- set max value of pixelclock
- increased hfront_porch and hback_porch
- dropped connector-type

adding of bus_format = MEDIA_BUS_FMT_RGB666_1X18 results in wrong colors.
omitting bus_format and using some default is better (Tux Pinguin is colored
fine)

 drivers/gpu/drm/panel/panel-simple.c | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index eb475a3a774b..0fd88c3f752c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3065,6 +3065,36 @@ static const struct panel_desc satoz_sat050at40h12r2 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing sgd_gktw70sdad1sd_timing = {
+	.pixelclock = {30000000, 30000000, 40000000},
+	.hactive = { 800, 800, 800},
+	.hfront_porch = {40, 40, 40},
+	.hback_porch = {40, 40, 40},
+	.hsync_len = {48, 48, 48},
+	.vactive = {480, 480, 480},
+	.vfront_porch = {13, 13, 13},
+	.vback_porch = {29, 29, 29},
+	.vsync_len = {3, 3, 3},
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+			DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
+};
+
+static const struct panel_desc sgd_gktw70sdad1sd = {
+	.timings = &sgd_gktw70sdad1sd_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 153,
+		.height = 86,
+	},
+	.delay = {
+		.prepare = 20 + 20 + 10 + 10, /* T0 + T2 + T3 + T4 */
+		.enable = 50, /* T5 */
+		.disable = 50, /* T5 */
+		.unprepare =  10 + 10 + 20 + 20, /* T4 + T3 + T2 + T0 */
+	},
+};
+
 static const struct drm_display_mode sharp_lq070y3dg3b_mode = {
 	.clock = 33260,
 	.hdisplay = 800,
@@ -3857,6 +3887,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "satoz,sat050at40h12r2",
 		.data = &satoz_sat050at40h12r2,
+	}, {
+		.compatible = "sgd,gktw70sdad1sd",
+		.data = &sgd_gktw70sdad1sd,
 	}, {
 		.compatible = "sharp,lq035q7db03",
 		.data = &sharp_lq035q7db03,
-- 
2.17.1

