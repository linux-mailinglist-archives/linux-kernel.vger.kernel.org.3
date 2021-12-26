Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAB47F69E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhLZLZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhLZLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:25:24 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3D2C061757
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d9so26632245wrb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3w0cyRxbnflG1Lzaa+D9LFgBBXj2WLi8B2+0IaB0cco=;
        b=PwXLZV+6O9zswzpPoQeLANPNLyAa5j9TTefYDsBvxzJHw7hsiT7vgEJO67viIuaBiK
         joS9USvBHQU7W3SIlSlVlgL1mYDZ9GdAj6OOVHGzOLhwrXOtxouH24D1FvTOcNPBx1hu
         cgYJFZ0JNDK45DRlTqL7+hohi4LKCBmpHJMZ7FYsBeaLfb3+QvZpNbnybehWxIYzAW9A
         zIdhrscxtU7zpauASJezylBL9be5Gt7PrhZ4YGNwtTDe/dk3r/8eHOBjzyS88i2wv2vz
         I6dy2YgPWM+zzpAj2FRI6ftDhWK37okU082jWiQr1P8b2ZnvThZubK2qMqrpGqHTwjcb
         AcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3w0cyRxbnflG1Lzaa+D9LFgBBXj2WLi8B2+0IaB0cco=;
        b=3dvxusH76/Ayb4wOpdQ1DIuSVRA0nVf3BD/ALwH1S7qPsmEP++UMfyR3ClR0V9QoFI
         nplSpdst10baKGkiBtH3qpowvZvplfznVVms6B8xp9eGEdwRMUvQ2zCUSRuQ814SWEm5
         qkDQy8e6gkXFgoXpyjEc42DhPblSjVOImsNIAGWP4u46sJsZQfIt1qrZsLzYkggYdGGc
         +5o0LrfNZQtjV1Ii09aVvOqBra8hfrvOZuUleY1jhA3r/HSfFaI1XVUP6avcUMv7MjG6
         Y+RKt1jYGL8qVxaaerSfkqWmqwaITUausH8w6nImnbu4N1CApFXu23Ji2KM96JedQwBB
         7yzQ==
X-Gm-Message-State: AOAM532WP/G6gqOw3rcEeGzyEuppiJyhLwg10Ww3YelBpyuZxyvkuSZP
        9HCiJB2FJQVruh2/cidpp4k=
X-Google-Smtp-Source: ABdhPJyMMwBvN0I/TVcPJvi99lJUbcE0uky0CFSE//bOHq3fI8piG76lCpdID1rhkzRsL/yanK1mSw==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr9352371wru.241.1640517922894;
        Sun, 26 Dec 2021 03:25:22 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g12sm13654743wrd.71.2021.12.26.03.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:25:22 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     contact@emersion.fr
Cc:     ville.syrjala@linux.intel.com, dmitry.baryshkov@linaro.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, marex@denx.de, stefan@agner.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, yannick.fertre@foss.st.com,
        philippe.cornu@foss.st.com, benjamin.gaignard@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 6/6] drm/stm: ltdc: Drop format_mod_supported function
Date:   Sun, 26 Dec 2021 12:25:03 +0100
Message-Id: <20211226112503.31771-7-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226112503.31771-1-jose.exposito89@gmail.com>
References: <20211226112503.31771-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "drm_plane_funcs.format_mod_supported" can be removed in favor of
the default implementation.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/stm/ltdc.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index dbdee954692a..ef909e50f0e4 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -925,16 +925,6 @@ static void ltdc_plane_atomic_print_state(struct drm_printer *p,
 	fpsi->counter = 0;
 }
 
-static bool ltdc_plane_format_mod_supported(struct drm_plane *plane,
-					    u32 format,
-					    u64 modifier)
-{
-	if (modifier == DRM_FORMAT_MOD_LINEAR)
-		return true;
-
-	return false;
-}
-
 static const struct drm_plane_funcs ltdc_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -943,7 +933,6 @@ static const struct drm_plane_funcs ltdc_plane_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 	.atomic_print_state = ltdc_plane_atomic_print_state,
-	.format_mod_supported = ltdc_plane_format_mod_supported,
 };
 
 static const struct drm_plane_helper_funcs ltdc_plane_helper_funcs = {
-- 
2.25.1

