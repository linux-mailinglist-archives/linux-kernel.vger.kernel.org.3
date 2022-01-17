Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900A3490716
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbiAQLVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbiAQLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:21:32 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC53C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:21:32 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c6so12454745plh.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCp1Yld/vpc2MEgC67K2Cu0TtaZ+rl5TSq3oT9JL66c=;
        b=DySnb2akplB5B2gFkfTkn9N7CWEm3VhLRDOcyWKHwInQ+Jl941EHqwXnklWSzLYcMj
         Xx+9z1LWwSdSYYO29yOskFpwRZfDdtomwz8dhJKo5rAmaBxIG9zWvi+QjmluFOz4q+7H
         O3a8Pt16MC1MY14u8Do9KH3Glx6plCsujTXlbOXqE5m38ZJsU/6u7JWlT/QauTt5ZSoB
         H8P7SoGm1zvFKMex3Gil13uD7TPPmYTl/P7lqaQFBhIi3+3N+eQ78v2N1rcay/ZS/r97
         2P2N1rFAvoWiqu+wcmeEWYXZwPu+BrGyrkLLuJClmbJ9OYErBmPiyk0XhtUZkAYUaFTM
         Lkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCp1Yld/vpc2MEgC67K2Cu0TtaZ+rl5TSq3oT9JL66c=;
        b=C+/1Mvn0LZ66il4vt2kUqdsKg81VqRdwWiIzKz8sQ4vAoeDuaxHn3crJV3GLylHSyc
         Vn3yMzILwiGofSn+oq1/8Wns1puV59mnoProSSDQ8jTV7uBo2wJyI3iuU1s48FebMC4A
         1jnhWTnbs6840DoNFvK++ft63poF2kspLDIrlsXqgmoYx5b6tyCv4cqqF6zEIGwysPqN
         LsU/CavnqEBpV4+N9G/h7VDPAxqEeJQWz/mYFjf4LkU5luAGIObFJwH3R48yWmUnANzV
         ymOoGdXQCC7TWGexHqVEYYJ9ClHbmXdJ6WG/ZJg6SVDY33nSF7mkuWBDNPie01lNONJd
         yKCg==
X-Gm-Message-State: AOAM532NUpyMQoZ36RMKDwLBhUxaMfY6wdLrkCsXHP+lD1FHeHlijjzZ
        zVA2ca2nCT08ViFWhMaWeOE=
X-Google-Smtp-Source: ABdhPJxaYCEXTeRD+ovcFEEJTeAhoTOAiDir6d7G3UF3S7wnWg0yP70GSg56NZlduFTxdHgGhvmW2g==
X-Received: by 2002:a17:903:1d2:b0:14a:8c22:cd11 with SMTP id e18-20020a17090301d200b0014a8c22cd11mr17419729plh.118.1642418491854;
        Mon, 17 Jan 2022 03:21:31 -0800 (PST)
Received: from localhost.localdomain ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id j6sm3991599pjn.20.2022.01.17.03.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 03:21:31 -0800 (PST)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rex Nie <rexnie3@gmail.com>
Subject: [PATCH] drm/panel: Add panel-edp: add lcd innolux,n140hca-eac
Date:   Mon, 17 Jan 2022 19:21:24 +0800
Message-Id: <20220117112124.2358888-1-rexnie3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

innolux,n140hca-eac is a eDP-based LCD panel. This panel has 1920x1080
resolution in 14-inch TFT panel.

Signed-off-by: Rex Nie <rexnie3@gmail.com>
---
 .../display/panel/innolux,n140hca-eac.yaml    | 43 +++++++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c             | 26 +++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,n140hca-eac.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,n140hca-eac.yaml b/Documentation/devicetree/bindings/display/panel/innolux,n140hca-eac.yaml
new file mode 100644
index 000000000000..5493e383c97c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,n140hca-eac.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/innolux,n140hca-eac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Innolux N140HCA-EAC 14 inch eDP 1080p display panel
+
+maintainers:
+  - Sandeep Panda <spanda@codeaurora.org>
+  - Douglas Anderson <dianders@chromium.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: innolux,n140hca-eac
+
+  enable-gpios: true
+  power-supply: true
+  backlight: true
+  no-hpd: true
+
+required:
+  - compatible
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    panel_edp: panel-edp {
+        compatible = "innolux,n140hca-eac";
+        enable-gpios = <&pio 96 GPIO_ACTIVE_HIGH>;
+        power-supply = <&pp3300_disp_x>;
+        backlight = <&backlight_lcd0>;
+        no-hpd;
+    };
+
+...
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 176ef0c3cc1d..3682986608dc 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1303,6 +1303,29 @@ static const struct panel_desc innolux_n125hce_gn1 = {
 	},
 };
 
+static const struct display_timing innolux_n140hca_eac_timing = {
+	.pixelclock = { 72600000, 76420000, 80240000 },
+	.hactive = { 1920, 1920, 1920 },
+	.hfront_porch = { 80, 80, 80 },
+	.hback_porch = { 190, 190, 190 },
+	.hsync_len = { 60, 60, 60 },
+	.vactive = { 1080, 1080, 1080 },
+	.vfront_porch = { 6, 6, 6 },
+	.vback_porch = { 38, 38, 38 },
+	.vsync_len = { 8, 8, 8 },
+	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
+};
+
+static const struct panel_desc innolux_n140hca_eac = {
+	.timings = &innolux_n140hca_eac_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 309,
+		.height = 174,
+	},
+};
+
 static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
 	.clock = 206016,
 	.hdisplay = 2160,
@@ -1682,6 +1705,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,n125hce-gn1",
 		.data = &innolux_n125hce_gn1,
+	}, {
+		.compatible = "innolux,n140hca-eac",
+		.data = &innolux_n140hca_eac,
 	}, {
 		.compatible = "innolux,p120zdg-bf1",
 		.data = &innolux_p120zdg_bf1,
-- 
2.25.1

