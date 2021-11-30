Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB0C463ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbhK3QBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:01:23 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:45690 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhK3QBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:01:23 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3RhC5DMjz9vsr2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LsO_Bto9rJqO for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 09:58:03 -0600 (CST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3RhC3699z9vsr4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:58:03 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3RhC3699z9vsr4
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3RhC3699z9vsr4
Received: by mail-pj1-f72.google.com with SMTP id mn13-20020a17090b188d00b001a64f277c1eso11736244pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bTXkxPkhvwkgKe3CfQ7oKNFqLLxsibJM72YviuHICJY=;
        b=JXLhE+gLz8807ShPZSZBtudJocl+w6stUALlj11N7rM24NN8HXfOXGqMUBWF6f9IYK
         4tmgYEOcRw/QvKTRyOwZfpfmnqzsmA/hrkVGyp6sbzvGR8IJz7Eae2Db2itgWd2hJh6k
         FT1Vps8hTXW4OuK7IkVnGNU0EFN25oMFBeZjJitk2c1IzzpIMqSUG5KjCLIMngKJB51T
         HcFCQRDcSgoh8/UcsiseRNjQjbruj0ErYBwux3J8lLI8E7l6flcIPzCSVOLUG4dkdZht
         E9+2I7o3/hGSbZgptPnE/cbwb19FsDWZBKItWc6DAfFm7RLgXAx61vNw3OOnvPFJ+uBV
         iYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTXkxPkhvwkgKe3CfQ7oKNFqLLxsibJM72YviuHICJY=;
        b=rcq8lQLXYI02QgNKCgLdEfTUxIq+rH1qzJ/SMoCc0AyNvTtKqfAnYitr2r7j1dvB74
         +YpLSkl5VCEWWwU2rTTry/CcA3ylHgG3HnQwepTGGz+FF4JY0Q4b8sI/7V6wSKB/J6oL
         iICc60OoC1GThDdOdUii7L4Af+2949iz4c+XYeyHycR/lUDUIHQrmw2wltjm5yPoBUsX
         Ku4lduYMMLVRG0cc84HQQ2Dp6aPzRM1EwMHgE7p3jASCsQSRG6sPXWUWPQTjMK4rDDfz
         L8fN2OMwtRtPFsDl9jAqn9IRNvwrmZ16EFiCurpjRtymH+bHo9ttrfZ+3krCFgWaK+gn
         f7pQ==
X-Gm-Message-State: AOAM533dwIuk2OpFOOWciCcwFV/sviBhNctinruLx12OPM86nxKPxM3j
        gCc6boN+WI5bYsdrEv05sXCteGdPDS1SSBwyoN2dXTYh/IG9rBmLbi9k1ii0dFeZ92e1CH4PhAX
        A7TSfHGjjkrfWsnT5ibuGmbUMaTJc
X-Received: by 2002:a63:155d:: with SMTP id 29mr21857pgv.302.1638287882663;
        Tue, 30 Nov 2021 07:58:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIaxwNEDzH7cmq7l7LiRaYXMObjxXyqF8evR41ZnOQZpK9G2rDCI1/FqCk8Jv+9cm2uvYXJw==
X-Received: by 2002:a63:155d:: with SMTP id 29mr21828pgv.302.1638287882411;
        Tue, 30 Nov 2021 07:58:02 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id h13sm15230838pgg.16.2021.11.30.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:58:02 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/radeon/radeon_kms: Fix a NULL pointer dereference in  radeon_driver_open_kms()
Date:   Tue, 30 Nov 2021 23:57:19 +0800
Message-Id: <20211130155720.178214-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f776cb6f-d599-a543-9177-dac7d08cf7d4@amd.com>
References: <f776cb6f-d599-a543-9177-dac7d08cf7d4@amd.com>
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
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
Changes in v3:
  -  Fix the bug that good case will also be freed
  -  Improve code style

Changes in v2:
  -  Improve the error handling into goto style

 drivers/gpu/drm/radeon/radeon_kms.c | 35 ++++++++++++++++-------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 482fb0ae6cb5..439f4d1fdd65 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -648,6 +648,8 @@ void radeon_driver_lastclose_kms(struct drm_device *dev)
 int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 {
 	struct radeon_device *rdev = dev->dev_private;
+	struct radeon_fpriv *fpriv;
+	struct radeon_vm *vm;
 	int r;
 
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

