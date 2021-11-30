Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4197846376E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbhK3Oxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:53:32 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:56398 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242554AbhK3Ow2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:52:28 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3Q8f2BFYz9w4Rr
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2WBTjIvMHDhL for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 08:49:06 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3Q8d72B1z9w4Rv
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:49:05 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3Q8d72B1z9w4Rv
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3Q8d72B1z9w4Rv
Received: by mail-pj1-f69.google.com with SMTP id gf15-20020a17090ac7cf00b001a9a31687d0so6901454pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKUA5rulho7/zo1ULnuDGtU3hFtIpEJdfFzpP4bqLSk=;
        b=GeK2kPOS68r652pwNSRxEaAW/b/2tt84HoSKWLnqyqPdVPl4ucwQ+mMlReYNSho7SF
         +sha56JoOg34qC7EaQh4IyuQQZ4oaOtBdBjrxjJ+f8pithTUf3Zr/gb0ZdFOqnIUAoJU
         RVYhqDa4M1u5Zkp/QQdNSReB7yO4zl01to//Z6JN4rwmCYKGEdP1uKGMEtPODj20OqLq
         YgpO3ENCThW3nGWNthqOb91bDF5PjI/JfYtJcuqsIwHc6edcrwISgV4lZwZwJ6J/VoYt
         D9aIjinT/QRXiDFiztTJLOPjnSt+gDhu2+6Kds5nC+/R6X55CMCBR3NOlh1pf3fm0/B4
         qzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKUA5rulho7/zo1ULnuDGtU3hFtIpEJdfFzpP4bqLSk=;
        b=EyIy3SnAN6brnOr9Yk4ug7SHtIM/Rpu+kBEbtHvLd1/8D3s0CcJLGpiIyTDLW+aL+t
         Z5k57dhyxBNLPiVkE5jUai5GT6PpEut/pCvfT/uiOa1+BYQZJxhFvIXiDLqBFhEowei+
         Ww9vBGYfyOjGMah0yiT7vptEURY9XUOv0L42JlbHG55Tqm+AysBbN/ViMxfPaZqH1Pkb
         102pO1Qol7q7k4MD2TOaesvnrrJuyVjqk8O7PV1wgftfBeUrH3S+Q9890TvpDIsrBerT
         b1c9tpoI4V2T10zgpgD/cEHinuqqAppLwGE2bM48+QkPKh6h7um/tgPhAQXAk8xwjfDP
         aWWg==
X-Gm-Message-State: AOAM532R/S/9aBJ8t21etJ49qkN3vhtltJ8TIfTaBs3I9q3Y0VIc7W4+
        Fa8OakRkBhe/NKkUI4KaTfRVkOnWtXU+0FfMAGmKOmC7Dv/esGJnZr7X3hPPRThBxmhQbdlk7Qm
        hJ2bc9It28fhe0KVGEXwFBnI/sYwi
X-Received: by 2002:a17:90b:4f86:: with SMTP id qe6mr6665853pjb.198.1638283745319;
        Tue, 30 Nov 2021 06:49:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzg5tqfIsb7cPPfYTW5uP2EKJprEpWzmVo1SJk8rR74gWfThL7r7GfAmz1doU8srd5YKcoi1Q==
X-Received: by 2002:a17:90b:4f86:: with SMTP id qe6mr6665827pjb.198.1638283745110;
        Tue, 30 Nov 2021 06:49:05 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id s5sm14762936pgq.62.2021.11.30.06.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:49:04 -0800 (PST)
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
Subject: [PATCH] drm/radeon/radeon_connectors: Fix a NULL pointer dereference in radeon_fp_native_mode()
Date:   Tue, 30 Nov 2021 22:48:27 +0800
Message-Id: <20211130144827.163717-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
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
 drivers/gpu/drm/radeon/radeon_connectors.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 607ad5620bd9..49f187614f96 100644
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
 
-- 
2.25.1

