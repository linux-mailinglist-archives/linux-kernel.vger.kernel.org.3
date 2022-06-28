Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC58955E05C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbiF1JA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiF1JA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:00:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6997EB3;
        Tue, 28 Jun 2022 02:00:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cv13so11938841pjb.4;
        Tue, 28 Jun 2022 02:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3IiMMMDPLwz9F3UeFSzYtl7u8epQnprjfnqcTqmPDdc=;
        b=fdgeeJCygTbWPCwOcRdRnM5k89FhhxUXjcu7q4k2tnjMEcJyiYkKCYjTsdEAOW87tB
         w/LJTf+LO4X22TFU8tUXrtyWFwDPR52aYVR+q1ZWFT3vqv0NRZ6FGT/wkTLNThyRcp3Q
         UxbI4gGUkWYVxk0iRRZZuIF+HwkJ6wk8YTF/D3o9cVZcPRYr0qY+6SEtx/YsXUU17kBO
         B6v1tbxXZy0Ma72s+vAI2t+od7AWzoe8lR9/YGXO1n+iZcMgUWB2BmjI8JRRUlqjHvfZ
         PV0uHJjVrfaHmbeXn+Ti2vmUY8gbz5CFN/7us+y8mnoWHg41b4t7kDRSXK7lTTAT+M48
         IqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3IiMMMDPLwz9F3UeFSzYtl7u8epQnprjfnqcTqmPDdc=;
        b=tO3p3/Hsms6wLHUsJL84+j5VloojD5DKfML+iKJJcczqO0OgkdSlmttG+l1n6mCDxe
         6pPTA8BNhmC/eqAttYZpMH/j7nj3tSJwyFZymlqQFCHuClPesk4eZvle8uA8rzqJqeKu
         jMEZTDDeKj9T3+AGNJahihe5w2uivzkjvjJVAONc18mG0stDnB2haMaN2Uh2z0Mng5c2
         8qbYxCDZsIbnRs65QjLAFO+MianUivqoAe1DjJGJMGBIrNLs5EV3hoZqgsz5/VMWiF8u
         SmdzDSy8UFkjfIfg5h7q1Pp/vnnWYVx6uX1uyszJVjT3Y0mMJsCLHjXM1DSc2JZkyHoJ
         zhRA==
X-Gm-Message-State: AJIora+qeAnO5lF50u556QEg0uS+1/TpjzkjFgBlMyoMmYa+hiRilIZq
        PRzdFrmJPN72kaYfMteWKDm/8x+HAp0+fg==
X-Google-Smtp-Source: AGRyM1vLfFfPeOT7qcM6D3nurI9ZAJGl2I7PMQ26kHrnlwIMGUzDjswBsg44tVIcX7/8JAqZb+CBTw==
X-Received: by 2002:a17:90b:895:b0:1ec:827c:ef0f with SMTP id bj21-20020a17090b089500b001ec827cef0fmr25644802pjb.10.1656406856518;
        Tue, 28 Jun 2022 02:00:56 -0700 (PDT)
Received: from chrome.huaqin.com ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id bf20-20020a056a000d9400b00525392cb386sm8789688pfb.201.2022.06.28.02.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:00:56 -0700 (PDT)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, spanda@codeaurora.org, dianders@chromium.org,
        devicetree@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Rob Herring <robh@kernel.org>, Rex Nie <rexnie3@gmail.com>
Subject: [PATCH v2 1/2] drm/panel-edp: Add eDP innolux panel support
Date:   Tue, 28 Jun 2022 16:59:49 +0800
Message-Id: <20220628085949.2147920-1-rexnie3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Add support for the 14" innolux,n140hca-eac eDP panel.

Signed-off-by: Rex Nie <rexnie3@gmail.com>
Acked-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3626469c4cc2..2a8fcdffe80c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1355,6 +1355,29 @@ static const struct panel_desc innolux_n125hce_gn1 = {
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
@@ -1775,6 +1798,9 @@ static const struct of_device_id platform_of_match[] = {
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

