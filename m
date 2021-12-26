Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634B947F69D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhLZLZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbhLZLZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:25:23 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1187C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t18so26472042wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uC+zpueN0jaqztWM7eUqBfpEMbmsR8tb66iIJAnvGU=;
        b=RwDE0YPkDLqtqo7Dvnlm/ydiYanOQlnAMem2isy3ndgorcODT7JcvNFIyr443LTwSg
         WliRTsg8U5K6xpvrcgejsyGKhya4NPPV1Uea3wAuINZpe69Qi4Co3GCY8+RCvB5zICJN
         79sCOX7fKsf0zNbAvzhCEj30xYFAmhu4mxWkaRe0EvJkW/pW8fygcR8ybIZ/WTrgKhBW
         WcMktKG4ZIskNlW/H43GfZIK16XeZawEhw7iKEf6idJrc9oK20T4+HFBD3es+GpMVzr9
         czP8Xc5f78UoC+IsRP3PfKQz9Rc6Zl71pPJ9HwZfuNpEHKkQuf3Bn8gfrACtKdQA8/At
         oNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3uC+zpueN0jaqztWM7eUqBfpEMbmsR8tb66iIJAnvGU=;
        b=NvADWLi8kowgF0GnE0vIKJd8l6OYsrZLp+ORemlnRN34K1so90lhn6bOAwHN96TTD+
         03PeSZFrQxyjqozxPKRkqcyDEp7NaCalW3XiNgsM4vOhlnZvTz5/5SknxfkDeP9FOaMS
         VmXtEvyz59VkzlnO9Bzzwc1vqa90uxceW3rqkIZ7vJjxAEQfeooPYjuoNUAnmAyHRixu
         XkL01bYrLHWLZ+YlV3Me5sCxlmOBmCbxIvL8eAFYU5WvDUQBdlNVbyZJuH+f+VJHXy2X
         Pqu0fqJq/krAoS3ya9qln6MoDwVtv8OTUPEMjj6mUtP5HiSPY2Y5ILhBGjLlVv+DhRei
         qfmg==
X-Gm-Message-State: AOAM531R9dOsf2yAFI2fxzCmol+JGxn052O/CSO7ILK2l9CjSyUopBFp
        toOHybJN6CDZTZqKX5bgTGk=
X-Google-Smtp-Source: ABdhPJwPiaAlI5ue8SBY/hNuXdX5I1LiZxPv2bA/DypMkY+1VW51yINEbKM/DxTgrTs1AI5TJvkxhw==
X-Received: by 2002:adf:9004:: with SMTP id h4mr9898117wrh.593.1640517921215;
        Sun, 26 Dec 2021 03:25:21 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g12sm13654743wrd.71.2021.12.26.03.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:25:20 -0800 (PST)
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
Subject: [PATCH v3 5/6] drm: mxsfb: Drop format_mod_supported function
Date:   Sun, 26 Dec 2021 12:25:02 +0100
Message-Id: <20211226112503.31771-6-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index 0655582ae8ed..df32e1c3cc5d 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -554,13 +554,6 @@ static void mxsfb_plane_overlay_atomic_update(struct drm_plane *plane,
 	writel(ctrl, mxsfb->base + LCDC_AS_CTRL);
 }
 
-static bool mxsfb_format_mod_supported(struct drm_plane *plane,
-				       uint32_t format,
-				       uint64_t modifier)
-{
-	return modifier == DRM_FORMAT_MOD_LINEAR;
-}
-
 static const struct drm_plane_helper_funcs mxsfb_plane_primary_helper_funcs = {
 	.atomic_check = mxsfb_plane_atomic_check,
 	.atomic_update = mxsfb_plane_primary_atomic_update,
@@ -572,7 +565,6 @@ static const struct drm_plane_helper_funcs mxsfb_plane_overlay_helper_funcs = {
 };
 
 static const struct drm_plane_funcs mxsfb_plane_funcs = {
-	.format_mod_supported	= mxsfb_format_mod_supported,
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-- 
2.25.1

