Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F4A48CF8D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiAMAI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbiAMAIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:08:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40CDC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 16:08:19 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so8152635pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 16:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EBDsiqdsFoIT2e8QhFpduAtN91LgcYXAbLf3F3iJzI=;
        b=NY0SY+DU2XHQGeZvTOB1YC0YOaJ7QO85McclsFVBNaKSvIJQxvyzKt7l/b6pEJyYdY
         6UtytVRpzDxpdrx7W6DfC856BHmn00VX3DiqDY+p/74mrzeySbbcUThCmzwwxZAooDiy
         6wuQ65Seib07MoIP1Uhnic/sBNh4tlARBfhWKbC/NqPG+nHQr07nZAJZy9t7iyeG2X7U
         RU9lYMyE6FucMvjVe2bkymwt8JuKLjImNy/aXrkMK5ruIj0VbGUabcb51aokCEbiQ+7+
         YLctWvcz2aRz/2MeRHHNdewW00bafd6QQ2ZsiueWrGAuaHZX/ZR1E+M6tMeysbrun4wW
         uP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EBDsiqdsFoIT2e8QhFpduAtN91LgcYXAbLf3F3iJzI=;
        b=qwwA8pZ2hFj5y50nDANonDjOiI5UvlO6bDHxUoda6RrrJQ2ceXu9cDLRyvX3LigQsO
         7CbKOnR2ZBBYz5YFd9HOrZOTKG8VD9HJ+ftCdW+sOzyG3Gw4hCr+8OB01rUkIvEredWu
         X6KcqnTNLBpBblN8teBDTNrPVznSDXI3k0qUSPtVeuos1rvOJxcZP/9mO6rq8irSzyho
         kodnopTUczZAI1VvE843bXfpzy9A1fzypPEmzkQgkUSDsgdxHrw90+Th6I1sssUrsU3u
         C0hUzQITA/0UB2AE90ImC3RK6ibkkWydYBQoQ5AelhpgsXn6SqSq9Vx/P0/JrRpR/qor
         CQ2w==
X-Gm-Message-State: AOAM530QcsIDRAJg6qMEUoCw7+/xGoGVvoThOvxMLwkSrSMeOYV0zaEJ
        BYFeVpQz233RqQ1UOK/S/wA/WH8Ejj37a8si
X-Google-Smtp-Source: ABdhPJzA/NIBBhxRbcpuwbMBYX3cBJL1mSbMrgdnLioKZNp+/niWBa423dyqGsNxQQKLI3LzA0He3Q==
X-Received: by 2002:a63:7d08:: with SMTP id y8mr1844300pgc.143.1642032499217;
        Wed, 12 Jan 2022 16:08:19 -0800 (PST)
Received: from raven-lpc.lan ([130.105.10.199])
        by smtp.googlemail.com with ESMTPSA id y23sm699272pfa.80.2022.01.12.16.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 16:08:18 -0800 (PST)
From:   Raymond Jay Golo <rjgolo@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     rjgolo@gmail.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RESEND] drm: panel-orientation-quirks: Add quirk for the 1Netbook OneXPlayer
Date:   Thu, 13 Jan 2022 08:06:20 +0800
Message-Id: <20220113000619.90988-1-rjgolo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 1Netbook OneXPlayer uses a panel which has been mounted
90 degrees rotated. Add a quirk for this.

Signed-off-by: Raymond Jay Golo <rjgolo@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 042bb80383c9..b910978d3e48 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -115,6 +115,12 @@ static const struct drm_dmi_panel_orientation_data lcd1280x1920_rightside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd1600x2560_leftside_up = {
+	.width = 1600,
+	.height = 2560,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct dmi_system_id orientation_data[] = {
 	{	/* Acer One 10 (S1003) */
 		.matches = {
@@ -275,6 +281,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Default string"),
 		},
 		.driver_data = (void *)&onegx1_pro,
+	}, {	/* OneXPlayer */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
 	}, {	/* Samsung GalaxyBook 10.6 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-- 
2.34.1

