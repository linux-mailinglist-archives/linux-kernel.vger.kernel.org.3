Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E8E51D0FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389317AbiEFGGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385745AbiEFGGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:06:13 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB99443C7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:02:31 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7F3C183C61
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1651816950;
        bh=A2U5Iv3Qm5H9df801JFAAJpGtCA128Fr/pKj/dgq79c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExTZKmMB8IfpaEGhATDQWId3PC0hbTDYO0xP/iSIZNBjSLYIStT/Mv3W74QAw4DAo
         0SJwgiYvjr/McusWE8GWycmk2eO8imLWqY2yyKhwnqkONXq3f+qGVHZtWwTV8zDNAB
         4jn4FIK2RnbFHhI0daDSAajDhBfPsSaOQM1iEh5XrS7fzj+a7AybsVuKvcPR5hrOu9
         9/RsBwMr/6fat2M4URRE+6EI8wS6I2C9O6yAl83huQkcBbVnRQ5n1QJ483V7WJ2mQR
         4MP3cz800WJPBjswjgQwEOoI5agh7cAJRw9cNC8Reorc6VimD/Y9ifpugsFh6osl+J
         c1YJamhs+/XJA==
Received: by janitor.denx.de (Postfix, from userid 108)
        id E9520A02C5; Fri,  6 May 2022 08:02:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id 74B91A0114;
        Fri,  6 May 2022 08:02:18 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id 659353E098D; Fri,  6 May 2022 08:02:18 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
Cc:     Philip Oberfichtner <pro@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        matthias.winker@de.bosch.com
Subject: [PATCH v5 2/4] drm/panel: simple: Add DataImage FG1001L0DSSWMG01 panel support
Date:   Fri,  6 May 2022 07:59:46 +0200
Message-Id: <20220506055948.971924-2-pro@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220506055948.971924-1-pro@denx.de>
References: <20220506055948.971924-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DataImage FG1001L0DSSWMG01 10.1" 1280x800 TFT LCD panel support.

Signed-off-by: Philip Oberfichtner <pro@denx.de>

---

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: matthias.winker@de.bosch.com

---

Changes in v5: none
Changes in v4: none
Changes in v3: new
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a34f4198a534..710628c9f7da 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1402,6 +1402,30 @@ static const struct panel_desc chunghwa_claa101wb01 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing dataimage_fg1001l0dsswmg01_timing = {
+	.pixelclock = { 68900000, 71110000, 73400000 },
+	.hactive = { 1280, 1280, 1280 },
+	.vactive = { 800, 800, 800 },
+	.hback_porch = { 100, 100, 100 },
+	.hfront_porch = { 100, 100, 100 },
+	.vback_porch = { 5, 5, 5 },
+	.vfront_porch = { 5, 5, 5 },
+	.hsync_len = { 24, 24, 24 },
+	.vsync_len = { 3, 3, 3 },
+	.flags = DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW,
+};
+
+static const struct panel_desc dataimage_fg1001l0dsswmg01 = {
+	.timings = &dataimage_fg1001l0dsswmg01_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+};
+
 static const struct drm_display_mode dataimage_scf0700c48ggu18_mode = {
 	.clock = 33260,
 	.hdisplay = 800,
@@ -3768,6 +3792,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "chunghwa,claa101wb01",
 		.data = &chunghwa_claa101wb01
+	}, {
+		.compatible = "dataimage,fg1001l0dsswmg01",
+		.data = &dataimage_fg1001l0dsswmg01,
 	}, {
 		.compatible = "dataimage,scf0700c48ggu18",
 		.data = &dataimage_scf0700c48ggu18,
-- 
2.34.1

