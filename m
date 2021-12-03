Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DAA467A31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381741AbhLCP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:27:26 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39104 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245140AbhLCP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:27:25 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J5GnW1lqbz9vf8f
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:23:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZpxcjcYvSlkh for <linux-kernel@vger.kernel.org>;
        Fri,  3 Dec 2021 09:23:59 -0600 (CST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J5GnV71kYz9vf8d
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:23:58 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J5GnV71kYz9vf8d
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J5GnV71kYz9vf8d
Received: by mail-pj1-f70.google.com with SMTP id o4-20020a17090a3d4400b001a66f10df6cso1961367pjf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLGGvUHQifyobmz3LmGMV247Dhq0W2shJ3e+qEVTIds=;
        b=TNPaDNzF3K1VhbVDf4I1R5nZaBqAX6g77HbzJdKGnY8RO6IY/AyhqsDuO2Od0a5tu3
         LEKGoEXrT5vTDVyMVrFBWynlxEK2wRyn/TLPqShENHAhrIjwNg4+dKtb9Io5Zsfg0NLA
         V7DopEhSs1IF4LyxnB6EVfDotiDVjzndgeHRNxPemnaxHf/JWtcwFPelz6GdIfkQZHJ1
         1GkeAl/xxISXAv7T+cAYvg27PuVHwZXGkKRyM1tL18KQlU2pgq9z/0zx14B5Dx48zDca
         S0K1ywGE3yLPfsFmguVhVzkzuebFcbBPMzbqadlkVCiGsy7mlvlDaeLBIfN5DrDlJvLq
         o2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLGGvUHQifyobmz3LmGMV247Dhq0W2shJ3e+qEVTIds=;
        b=zc6GJARjK6xn2bjF9FDaq2Ng/YgzfwbGtlEz3DDI2/l5+uAn7gRiBMxKJzZTd8sLK7
         rrq+INULjiwWxEUyxqTdvwoqRtkIZoqOvG7Ev+nuKQGe2lcPzmzw5J9IkYq76ljUX8M9
         gYKyPJp/8uoPeZNbtU+R/aqxZCLJpLow1c6CxK/rHAfiTLMSvEkU+r7OXV1xGP/7loWk
         95bjQMr4PlpIfGjGnsQF87r42odTarhcA+HkIAG5eovvrBqRqQ2suUTOYZcwt5VLJ7MF
         G3O20drWa9EiEGXUe6zzZ20p5aMyAJGbKKHzMWSCrS+xDnh3dQqgWA5Io064MK1qpGLc
         R9qw==
X-Gm-Message-State: AOAM533XvuyE4GWj1a4rYgezO/DMlqunsf3+DrAEFZIjHzDgqLJA07it
        ai/FAky0nEHVD0Egh9BcWjUWPhjBaF+zUs0n2u0HXSf4XC2n5at3rqzi7TXANGZEUj6+W45foPs
        4H6WjEr3esx1svAFuijFRtU8Fqr6W
X-Received: by 2002:a17:90b:1d03:: with SMTP id on3mr1285024pjb.68.1638545037867;
        Fri, 03 Dec 2021 07:23:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjkihQgC/+XOXAxkIe19mpdvtqNj0OFzj+orHDGdZiV+ukP/97LX7BCjS9Dn2qd5/hJVGyUw==
X-Received: by 2002:a17:90b:1d03:: with SMTP id on3mr1284989pjb.68.1638545037601;
        Fri, 03 Dec 2021 07:23:57 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.93.212])
        by smtp.gmail.com with ESMTPSA id z4sm3550613pfg.101.2021.12.03.07.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 07:23:57 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/radeon/radeon_connectors: Fix a NULL pointer dereference in radeon_fp_native_mode()
Date:   Fri,  3 Dec 2021 23:23:50 +0800
Message-Id: <20211203152350.105099-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CADnq5_ONy+=6ufko6aBiTDwBsUuRGqqJxcDvNmAEoELUMJMxWw@mail.gmail.com>
References: <CADnq5_ONy+=6ufko6aBiTDwBsUuRGqqJxcDvNmAEoELUMJMxWw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In radeon_fp_native_mode(), the return value of drm_mode_duplicate() is
assigned to mode and there is a dereference of it in
radeon_fp_native_mode(), which could lead to a NULL pointer
dereference on failure of drm_mode_duplicate().

Fix this bug by adding a check of mode.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_RADEON=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: d2efdf6d6f42 ("drm/radeon/kms: add cvt mode if we only have lvds w/h and no edid (v4)")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
Changes in v2:
  -  Add a similar check in else clause

 drivers/gpu/drm/radeon/radeon_connectors.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 607ad5620bd9..7953830cc8b5 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -473,6 +473,9 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
 	    native_mode->vdisplay != 0 &&
 	    native_mode->clock != 0) {
 		mode = drm_mode_duplicate(dev, native_mode);
+		if (!mode)
+			return NULL;
+
 		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
 		drm_mode_set_name(mode);
 
@@ -487,6 +490,9 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
 		 * simpler.
 		 */
 		mode = drm_cvt_mode(dev, native_mode->hdisplay, native_mode->vdisplay, 60, true, false, false);
+		if (!mode)
+			return NULL;
+
 		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
 		DRM_DEBUG_KMS("Adding cvt approximation of native panel mode %s\n", mode->name);
 	}
-- 
2.25.1

