Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2F5A1961
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbiHYTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbiHYTUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:20:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE366A44
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:20:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l1so28977900lfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kF9MhVcSbXaljKbuFL1RJfsDNuyI/P+cFQh4/nvdssI=;
        b=Z3O9KnWdeGQQyHdKD6xIdD1D3F7D3Mq4205E1Ze3dba3OzOQFo4hCla/cv6O7CqHen
         gw6iHhjSoXMnen0FA0JFZdPukmDfzHCV3wrGTpQiytxViMwv77Pm+ZSkpVM4Bgc254cA
         MV79FMi5QDtdWGthf0ov2Z3f+XwSr9lgVvNqH52cr6kR42jASUXKUJoQtFmhMJKf9tfW
         gDOpZBdUcAclHbWxBn8wVAr8ALnpdsli+8Q+tOxU3DVotBlQilW7wkA5tYiHUQyxtui5
         VARtKp/QoeUyWt5z7MWOjP1NkhVovHuLXlLWNkwEZLvdQMo0ofXo3aIn7jjImr5M9bJI
         cFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kF9MhVcSbXaljKbuFL1RJfsDNuyI/P+cFQh4/nvdssI=;
        b=r2zKnhDCy+CyJFn63CUlbEHmL8wMYZl02FOOlR46ee2YTiUDu+kihr3npqxpwIfFmo
         Ipv1nzlAXe35nNXvxrQZaI0GXvnE/WIxCU1XdYGF/j1cWW9Kt/bNNYycphAnV3FQjpIW
         wzijkdrfz4uXjnt8cFO+BzSQjVxDviw2/FIjml53HQy4Lv4uL9t6JwV4o40nW+/NJenR
         YM/Gz9tVrCyvtvd/oORBwaQJoo3T8F3R62nbTuSn7OWehYxrxN/WKpiJmwM4iBXp/8UV
         YrIbP9AIGYfe99Mkqn8GElQQ6DY74Jp2pcqhXoakw3JSEelQa97EZXdKdHMcsZwz8iAV
         SU2w==
X-Gm-Message-State: ACgBeo0sbmCFevnwlfStQBnl5UoGMZcJ+XkEbe98m6glWUeUAB3ZX4sN
        DST3bT8s4tQ8E1mn5onQwWw=
X-Google-Smtp-Source: AA6agR4S1Vt+QCpWxNLHgv/Ec0zp+VC3W/CaIotz+EYe+34gokNpcyUEQFEkIxH7EgSp966JtsnMAQ==
X-Received: by 2002:ac2:5225:0:b0:493:7fd:58ef with SMTP id i5-20020ac25225000000b0049307fd58efmr1462808lfl.330.1661455211212;
        Thu, 25 Aug 2022 12:20:11 -0700 (PDT)
Received: from localhost.localdomain (79.191.37.241.ipv4.supernova.orange.pl. [79.191.37.241])
        by smtp.gmail.com with ESMTPSA id z20-20020a2eb534000000b00261b58cbf03sm30896ljm.87.2022.08.25.12.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 12:20:10 -0700 (PDT)
From:   Maccraft123 <maccraft123mc@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Maya Matuszczyk <maccraft123mc@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for Aya Neo Air
Date:   Thu, 25 Aug 2022 21:19:47 +0200
Message-Id: <20220825191946.1678798-1-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.37.2
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

From: Maya Matuszczyk <maccraft123mc@gmail.com>

Yet another x86 gaming handheld.

This one has many SKUs with quite a few of DMI strings,
so let's just use a catchall, just as with Aya Neo Next.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index fc1728d46ac2..0b011b615495 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -103,6 +103,12 @@ static const struct drm_dmi_panel_orientation_data lcd800x1280_rightside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftside_up = {
+	.width = 1080,
+	.height = 1920,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
 	.width = 1200,
 	.height = 1920,
@@ -152,6 +158,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYA NEO 2021"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO AIR */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_BOARD_NAME, "AIR"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYA NEO NEXT */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.37.2

