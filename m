Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD804667B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359385AbhLBQVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:21:10 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:54876 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359376AbhLBQVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:21:09 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J4h224KPdz9w32x
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 16:17:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t3eT9MKNo2RQ for <linux-kernel@vger.kernel.org>;
        Thu,  2 Dec 2021 10:17:46 -0600 (CST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J4h221lB2z9w337
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 10:17:46 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J4h221lB2z9w337
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J4h221lB2z9w337
Received: by mail-pf1-f197.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so17683504pfx.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 08:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qgDUgiquyeE/HBpyk1r0o9owU/0QA0kjA2nxOoAn0vg=;
        b=gXXhkhGRPKwEEtTuml2rjG//g3S0E5irHeJYXmB/fAkm/rSWvG50Ptn6mCIfuhuwLO
         s+GsPIrsjU/3ol6TexAgYESgAIiQe7PBCSbYIIdssbk3/rWWef+TWJ9aMgkz5p4GZRFe
         IX4AZwkQtR45z6qZ0uLz8Rb7LdK44LmxI23/ScN9VYA1QkA6cryi8A1YH+D0tcQ5ltV0
         0NQHz+a2lbP9NIX/ly+XWt+RRXGxULP+6suY7f+Z5mM3sps+5CegsK2W/8GyzhdrxaAz
         8p80h+HqrdZL6JQLg9X4nuYl9UnYhU8Lkooi9Vn3/bE7ZY3z3LKH0I8hJORLzF5g00v+
         IaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgDUgiquyeE/HBpyk1r0o9owU/0QA0kjA2nxOoAn0vg=;
        b=sjVAWQoohjj7YOW4QrWpvxlG9MYasKMgDdifIVSQkOZ11hb2AE743jhGERJLXqcyLA
         fRe0SrT0dMvrM92D3EJTX7SLkzyP1IVMJILNyT0xnlb/vh96zc/eM6mymPqG6tQIquq6
         cSffAkuRKPKOOL6d9Ap6z5jvR+f4C0QLOnyLGpVHA13bEb6TjuxLUUc6zl5N7iMZAbrW
         0B5fyzVbHaGPj5++0UPrkfqbyi50pqlxiitoSR576vF+ozHyuKPxsIIHAHxg1bq0KPrI
         vmUBJqudVrthvAz4fd6JxrcH73vw6oQBh9AS5B+j6vKdp2RE85yxeI6otF6wR6EFCXg4
         R1lw==
X-Gm-Message-State: AOAM533qHQsvPTaN15a6fuz+zuTMOwyWI9/YALa7iQHz+pZptLWAJQk9
        0tgU4D05Ej6jR3lZglyGb5xSjXZJsQbVdlbLHS5QrjAyR03n5UMNTfkUzxVwa86JDtqxVkt5fG/
        ltOOKsx6qOENZDmXvwur8h5R/VycX
X-Received: by 2002:a17:902:9a09:b0:142:82e1:6cff with SMTP id v9-20020a1709029a0900b0014282e16cffmr16500989plp.47.1638461865445;
        Thu, 02 Dec 2021 08:17:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlBUbzHE8EObBvEJkQ4GrdSaOO5BVm897v2oE1K1vI9kxnT2PO8h97GZr1lIie/srkFKr7Yg==
X-Received: by 2002:a17:902:9a09:b0:142:82e1:6cff with SMTP id v9-20020a1709029a0900b0014282e16cffmr16500956plp.47.1638461865176;
        Thu, 02 Dec 2021 08:17:45 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.93.212])
        by smtp.gmail.com with ESMTPSA id s14sm273542pfk.73.2021.12.02.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:17:44 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, hongao <hongao@uniontech.com>,
        Jammy Zhou <Jammy.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: Fix a NULL pointer dereference in amdgpu_connector_lcd_native_mode()
Date:   Fri,  3 Dec 2021 00:17:36 +0800
Message-Id: <20211202161738.79176-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CADnq5_P8amQK60zD-2tkVWBneZCoLENe5KY_S6eqoAAyOieatg@mail.gmail.com>
References: <CADnq5_P8amQK60zD-2tkVWBneZCoLENe5KY_S6eqoAAyOieatg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amdgpu_connector_lcd_native_mode(), the return value of
drm_mode_duplicate() is assigned to mode, and there is a dereference
of it in amdgpu_connector_lcd_native_mode(), which will lead to a NULL
pointer dereference on failure of drm_mode_duplicate().

Fix this bug add a check of mode.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_AMDGPU=m show no new warnings, and
our static analyzer no longer warns about this code.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
Changes in v2:
  -  Fix the similar bug in else clause

 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 0de66f59adb8..df1f9b88a53f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -387,6 +387,9 @@ amdgpu_connector_lcd_native_mode(struct drm_encoder *encoder)
 	    native_mode->vdisplay != 0 &&
 	    native_mode->clock != 0) {
 		mode = drm_mode_duplicate(dev, native_mode);
+		if (!mode)
+			return NULL;
+
 		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
 		drm_mode_set_name(mode);
 
@@ -401,6 +404,9 @@ amdgpu_connector_lcd_native_mode(struct drm_encoder *encoder)
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

