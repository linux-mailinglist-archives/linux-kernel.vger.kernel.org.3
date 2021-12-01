Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26A3464564
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346431AbhLAD07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:26:59 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:48312 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346328AbhLAD05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:26:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3kvF0yhLz9vKMX
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 03:23:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H7Aa6Sb4H-0F for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 21:23:37 -0600 (CST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3kvD5x44z9vKMh
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:23:36 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3kvD5x44z9vKMh
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3kvD5x44z9vKMh
Received: by mail-pj1-f70.google.com with SMTP id h15-20020a17090a648f00b001a96c2c97abso7831553pjj.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 19:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcN89m0hNh8auiyKMnyR563+8hFhi5+/hyGQkE1jlAk=;
        b=Bk/yRbPP0oXG+bDwmG7kNY+y5Dbd5lFfpyT4lGWAETenIIuEDH35DX27RzZBA/bsU7
         uK5zr1Zm5oB/6t+bjqWAYyfzA5AEusq2Ge2aUcLEQlKYPAxV8noFh1N5h6rBioItyKMh
         pCaCv0fCpQM+j8UyphV1XFIAKBRsc4K1p5IQoqrBuqc8u5rtpfWui0vdgeE0apcRX+Lh
         DIRg+hzgwZyo4oFyzQ+jKytlkuIxLRpWl2XBgWRxzzEk+mTnM4xWOkkaK+6YlOhO8YtR
         bdtCX6GOl3LcduLKg39GBOm1uRxbafHpQ8MmYLjx5433rWLL1tt3ilQ90FF+cz/y/Qnc
         txFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcN89m0hNh8auiyKMnyR563+8hFhi5+/hyGQkE1jlAk=;
        b=1mSoyt+fcIJBIMabODL5MDWZPNIbCdpZw19GeQ8fYwx3mMjuAa6+fXZRTZIkaC633N
         KvdSY5+w95F/PQIgztg9d8ppg3nZT3jXYbhJY0JRw2QTbQFY2lh7mcBOCnre7Z69L3mL
         WqgMffuxqPOctfdL1Ynw4lJNvmV8fHRRvnz84Y/dUbUf96yu5seiEMmHgppYS6JwrOkk
         YtXbPamq253sPQZUpEcmaopW6Q6Jpfn2wb9h5pjnWA35mTe8YMk1oyr/LWRtHzlfukFJ
         Roc/D+SYCov3qzf8HRVyKUWi4UJXmokLkLToKwN3t/GkQZUrSaZIoUTKA6bjwH3BexGd
         LbJQ==
X-Gm-Message-State: AOAM530lXxDeqMxYkDaUmTOLdLBFMnjrANNMpQRqoccaD4WDPDOwFIEM
        K3rusOb6zFP7n28NbXDvk+/RJhAv1Vs6ZK5o7H0XzPVYSlhQ8ibLD7FopOu0aOQkT9qUjm+VNa2
        JGn7GKqwNx15GnduIjl++tWr8rKD4
X-Received: by 2002:a05:6a00:26f7:b0:494:72f3:e8a3 with SMTP id p55-20020a056a0026f700b0049472f3e8a3mr3362408pfw.37.1638329015952;
        Tue, 30 Nov 2021 19:23:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6LEQ1WK5rmgYHxSzQZ6XJ8+SXmljAje6xdJ/DZlh/Q5lYBueNR4OVAlZ2S1KJx990iXYBeA==
X-Received: by 2002:a05:6a00:26f7:b0:494:72f3:e8a3 with SMTP id p55-20020a056a0026f700b0049472f3e8a3mr3362384pfw.37.1638329015726;
        Tue, 30 Nov 2021 19:23:35 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id 13sm21998388pfp.216.2021.11.30.19.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 19:23:35 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, kernel test robot <lkp@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm/radeon/radeon_kms: Fix a NULL pointer dereference in  radeon_driver_open_kms()
Date:   Wed,  1 Dec 2021 11:23:30 +0800
Message-Id: <20211201032330.27157-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In radeon_driver_open_kms(), radeon_vm_bo_add() is assigned to
vm->ib_bo_va and passes and used in radeon_vm_bo_set_addr(). In
radeon_vm_bo_set_addr(), there is a dereference of vm->ib_bo_va,
which could lead to a NULL pointer dereference on failure of
radeon_vm_bo_add().

Fix this bug by adding a check of vm->ib_bo_va.

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

Fixes: cc9e67e3d700 ("drm/radeon: fix VM IB handling")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
Changes in v4:
  -  Initialize the variables to silence warning

Changes in v3:
  -  Fix the bug that good case will also be freed
  -  Improve code style

Changes in v2:
  -  Improve the error handling into goto style

 drivers/gpu/drm/radeon/radeon_kms.c | 37 ++++++++++++++++-------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 482fb0ae6cb5..9d0f840286a1 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -648,7 +648,9 @@ void radeon_driver_lastclose_kms(struct drm_device *dev)
 int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 {
 	struct radeon_device *rdev = dev->dev_private;
-	int r;
+	struct radeon_fpriv *fpriv = NULL;
+	struct radeon_vm *vm = NULL;
+	int r = 0;

 	file_priv->driver_priv = NULL;

@@ -660,8 +662,6 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	/* new gpu have virtual address space support */
 	if (rdev->family >= CHIP_CAYMAN) {
-		struct radeon_fpriv *fpriv;
-		struct radeon_vm *vm;
 
 		fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 		if (unlikely(!fpriv)) {
@@ -672,35 +672,38 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		if (rdev->accel_working) {
 			vm = &fpriv->vm;
 			r = radeon_vm_init(rdev, vm);
-			if (r) {
-				kfree(fpriv);
-				goto out_suspend;
-			}
+			if (r)
+				goto out_fpriv;
 
 			r = radeon_bo_reserve(rdev->ring_tmp_bo.bo, false);
-			if (r) {
-				radeon_vm_fini(rdev, vm);
-				kfree(fpriv);
-				goto out_suspend;
-			}
+			if (r)
+				goto out_vm_fini;
 
 			/* map the ib pool buffer read only into
 			 * virtual address space */
 			vm->ib_bo_va = radeon_vm_bo_add(rdev, vm,
 							rdev->ring_tmp_bo.bo);
+			if (!vm->ib_bo_va) {
+				r = -ENOMEM;
+				goto out_vm_fini;
+			}
+
 			r = radeon_vm_bo_set_addr(rdev, vm->ib_bo_va,
 						  RADEON_VA_IB_OFFSET,
 						  RADEON_VM_PAGE_READABLE |
 						  RADEON_VM_PAGE_SNOOPED);
-			if (r) {
-				radeon_vm_fini(rdev, vm);
-				kfree(fpriv);
-				goto out_suspend;
-			}
+			if (r)
+				goto out_vm_fini;
 		}
 		file_priv->driver_priv = fpriv;
 	}
 
+out_vm_fini:
+	if (r)
+		radeon_vm_fini(rdev, vm);
+out_fpriv:
+	if (r)
+		kfree(fpriv);
 out_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
2.25.1

