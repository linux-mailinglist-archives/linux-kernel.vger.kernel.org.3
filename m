Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C247BDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhLUKNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhLUKNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:13:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E0EC061574;
        Tue, 21 Dec 2021 02:13:32 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v11so25794492wrw.10;
        Tue, 21 Dec 2021 02:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DEyc+NVxVKi+L8yckVOHzJw2NoQPHaqK818Sh5CD0II=;
        b=lxMPKYkdr/tQQ5EF9glUhX8o6TAPzZHvOOcoty8aNGCRmqkX67V5uOWbfJu2le08B+
         k5Vb67u4Hj9e6ds5NQVE1QBG2BLEftP90TQPLF5pUYHG9RBeIIV3aZxipCeyzGSFDIBP
         Gw/UzNTUcXDmfnIC5nii9VhaJ7ubVO//u+xpHk8ftoqOnGirhOFZaEW/W3pNAnfUzgaH
         vBvxWdEUh9havG6ympZQiTKQCMg/xhVwAIWo6ByxJ3Hw6jIcSMsMdm3yZWtBmx/IZj5E
         iyrYtaF263Fe4tH/Dz1A2sKmma4e/WamHVQeGJYLWfMOBNEG1vzkzYQAZ5eJHzbdooWx
         C6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEyc+NVxVKi+L8yckVOHzJw2NoQPHaqK818Sh5CD0II=;
        b=OGLTQGLXwSKN25dstDQXR5SNnubrGYtrbiBw3k2rzlQprYhXNug6PY2xPQDSbu7sI7
         tRJ9saJsx2E34c/r2klkOHAeJdNULEToDFO3nQIsUM9GXm1sWOlGdcZ7gnrEAX/0cXHJ
         veai0YGteKiAICEqcJN+2k9wCNYTc1a0s1sbn4+3HIHOr5Az8P0kCpDXI+Q/jxmWkHXN
         dC1PiH60sz3Kc1c4BAbXENhqTK1XjCG7fd6NFWgyBBk96YaO3QZMrP/PDctq4KECHazW
         nnYSXEEj/sniSZmqe2Z/Ks6N7otcqoXPXRk+TToRxE+09He0lMeV9IidX/ng+6yzOwqS
         GKrA==
X-Gm-Message-State: AOAM532kdbYgnvwqvtA7I6I16NphIE8CFD652gGckNx6Z/kd0SMHsn4C
        OwD8B8e0vPbsml4DssMqPgk=
X-Google-Smtp-Source: ABdhPJwlXh9Hinn/Wk7ysQCkWYtXKp4CzjPNtpjWfGGw6aNsx8L9xFEr+Qk++VuuE6LFwzWkgksbVQ==
X-Received: by 2002:adf:fdc9:: with SMTP id i9mr2018666wrs.660.1640081611007;
        Tue, 21 Dec 2021 02:13:31 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id m21sm18012267wrb.2.2021.12.21.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 02:13:30 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     robdclark@gmail.com
Cc:     maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        maxime@cerno.tech, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 3/3] drm/sun4i: Add format_mod_supported function
Date:   Tue, 21 Dec 2021 11:13:19 +0100
Message-Id: <20211221101319.7980-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221101319.7980-1-jose.exposito89@gmail.com>
References: <20211221101319.7980-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the missing "drm_plane_funcs.format_mod_supported" function
to avoid exposing an invalid IN_FORMATS blob with modifiers but no
formats.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 7 +++++++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 7845c2a53a7f..728563f23cd6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -331,6 +331,12 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 			      true, zpos, old_zpos);
 }
 
+static bool sun8i_ui_layer_format_mod_supported(struct drm_plane *plane,
+						u32 format, u64 modifier)
+{
+	return (modifier == DRM_FORMAT_MOD_LINEAR);
+}
+
 static const struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
 	.atomic_check	= sun8i_ui_layer_atomic_check,
 	.atomic_disable	= sun8i_ui_layer_atomic_disable,
@@ -344,6 +350,7 @@ static const struct drm_plane_funcs sun8i_ui_layer_funcs = {
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.reset			= drm_atomic_helper_plane_reset,
 	.update_plane		= drm_atomic_helper_update_plane,
+	.format_mod_supported	= sun8i_ui_layer_format_mod_supported,
 };
 
 static const u32 sun8i_ui_layer_formats[] = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index bb7c43036dfa..d17813a7cac3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -435,6 +435,12 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 			      true, zpos, old_zpos);
 }
 
+static bool sun8i_vi_layer_format_mod_supported(struct drm_plane *plane,
+						u32 format, u64 modifier)
+{
+	return (modifier == DRM_FORMAT_MOD_LINEAR);
+}
+
 static const struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
 	.atomic_check	= sun8i_vi_layer_atomic_check,
 	.atomic_disable	= sun8i_vi_layer_atomic_disable,
@@ -448,6 +454,7 @@ static const struct drm_plane_funcs sun8i_vi_layer_funcs = {
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.reset			= drm_atomic_helper_plane_reset,
 	.update_plane		= drm_atomic_helper_update_plane,
+	.format_mod_supported	= sun8i_vi_layer_format_mod_supported,
 };
 
 /*
-- 
2.25.1

