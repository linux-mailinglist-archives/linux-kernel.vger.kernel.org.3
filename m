Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18E747BDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhLUKNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhLUKNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:13:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEFDC061574;
        Tue, 21 Dec 2021 02:13:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t26so25835721wrb.4;
        Tue, 21 Dec 2021 02:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFpZdmylFWaxjp/eKztb6USl6FN9U+6JIs/PIPKjnRc=;
        b=pr/JtJb6WF0mQRD4vOqRacTgAvypWKEfk5V8syiJ9sIDUxNN7jQrq1XKXDsBABqB3H
         DXLpsoP5dGydBjl/uyIiN40HdW11PvdjEe2DTpV9AvR7iiiSmPkvo6q5qo0QuYpmSn1b
         RkHn18uFSr0cv2V73JCTMQ5RsP2+Tpl8Opl/ZvaVRVPiKlvJqEZ9keLBs9oPJV9BQthg
         5qijCUVRCAZbuQzKWRfM8525TyNqDiqukLQhd6Ayr+oj3VAi8UBbl8moRwUl2PIwK05Q
         /liEv1cmO+FYYCWkD9PB9pEF1nKTnN65qxU23KALNBNKH9eFoDluBspEw9LtzjTGXd6w
         vXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFpZdmylFWaxjp/eKztb6USl6FN9U+6JIs/PIPKjnRc=;
        b=g7GtURQcZ0d+oaR8dtlO11v9VpUIqPBQsu9kxST+UoEDwN6c+W7YsyOxVoczxI+ErB
         6gxl4EwhcIRLj+XLyKlCostTB/BCDIcvRtc6F1frxcEf6UCQYJsfoSIbiuvj0rqjYA9i
         nzgI+mVeHdpXxY42V7/Dk/eXSNDJv6AX+ZPRGGZnLDqQCxl85oslNXF3BCrrAV6CnVgN
         /Zly2HOXYhedWvTxaW+EbmR8gyJXczXBVPKr/PVH8DSK7UYrEHt1xa72oGy+F7EzTcYJ
         D6FcG+dqImVgGp+riUZ07kZ4vS+Lqbiefl0mMQtYiOPgRlXtlgrIKkTrFcYPnGJBkaNm
         t9zQ==
X-Gm-Message-State: AOAM531xYr6I3VQ7f2xZtPwBXZCBX7tDkkaeyVYmyvaJQJNCNQ5+vxkZ
        l7b9UHpDASo7eawVF9tdL0I=
X-Google-Smtp-Source: ABdhPJzAPRTEhTqDe67YQMa1+RCtyyuXKyFuoRwZlIZMVBSj/As0a4YnwYmSvRWTIecaf4LuQzMRTA==
X-Received: by 2002:adf:d1e9:: with SMTP id g9mr2088396wrd.238.1640081609809;
        Tue, 21 Dec 2021 02:13:29 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id m21sm18012267wrb.2.2021.12.21.02.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 02:13:29 -0800 (PST)
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
Subject: [PATCH 2/3] drm/msm/mdp4: Add format_mod_supported function
Date:   Tue, 21 Dec 2021 11:13:18 +0100
Message-Id: <20211221101319.7980-3-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
index 49bdabea8ed5..8809f1633786 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
@@ -80,6 +80,13 @@ static int mdp4_plane_set_property(struct drm_plane *plane,
 	return -EINVAL;
 }
 
+static bool mdp4_plane_format_mod_supported(struct drm_plane *plane, u32 format,
+		u64 modifier)
+{
+	return (modifier == DRM_FORMAT_MOD_SAMSUNG_64_32_TILE) ||
+	       (modifier == DRM_FORMAT_MOD_LINEAR);
+}
+
 static const struct drm_plane_funcs mdp4_plane_funcs = {
 		.update_plane = drm_atomic_helper_update_plane,
 		.disable_plane = drm_atomic_helper_disable_plane,
@@ -88,6 +95,7 @@ static const struct drm_plane_funcs mdp4_plane_funcs = {
 		.reset = drm_atomic_helper_plane_reset,
 		.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 		.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+		.format_mod_supported = mdp4_plane_format_mod_supported,
 };
 
 static void mdp4_plane_cleanup_fb(struct drm_plane *plane,
-- 
2.25.1

