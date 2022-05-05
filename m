Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3BB51BC98
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354712AbiEEKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbiEEKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:02:07 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E3D4F477
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:58:26 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9385383F00
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:58:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1651744705;
        bh=S/6p0htncYSfhLix5DVhME9QfIOV+njezUVc7zFW1wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cvz3oDcF3XYcqhmC+J4L2EY8OTBUuAlVOYusFxX5oFMMoWpiHcJIKKY1H8YITutmf
         w7El/7H2UCUM59gwff/2D9+Sw8muc6z++EzTt2xHqOzroZ9zgp/D/CftG9cg9HVVMK
         XRwShZySINuquIshtC3xmFNDjYFKoOgt58SoKguthhKM+ZKIxWlnKyl6W/mCA3ERcP
         tPtSAyrn3tEqpDWY44uDYeOrR3kTKmHLyl8oE4z36+RwYnbAFZT55xifs4cWLfCoPc
         CQF4c70L3l5RhMieBsY+Tul0MKuQ6MCBuputd1+YMmT42ehpl+RDitRJRvaHhHrdmt
         AxmAYqFcSg/WA==
Received: by janitor.denx.de (Postfix, from userid 108)
        id 4E44EA012A; Thu,  5 May 2022 11:58:25 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id E8D1CA0058;
        Thu,  5 May 2022 11:58:17 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id DEA9D3E07D7; Thu,  5 May 2022 11:58:17 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
Cc:     Philip Oberfichtner <pro@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        matthias.winker@de.bosch.com
Subject: [PATCH v4 2/4] drm/panel: simple: Add DataImage FG1001L0DSSWMG01 panel support
Date:   Thu,  5 May 2022 11:57:26 +0200
Message-Id: <20220505095725.902447-2-pro@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220505095725.902447-1-pro@denx.de>
References: <20220505095725.902447-1-pro@denx.de>
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

