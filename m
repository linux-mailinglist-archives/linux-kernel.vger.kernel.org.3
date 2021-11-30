Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53060463A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhK3Pii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:38:38 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39896 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhK3Pih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:38:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3R9x51YZz9w839
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wSdGYaegOa3Q for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 09:35:17 -0600 (CST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3R9x2mcFz9w831
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:35:17 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3R9x2mcFz9w831
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3R9x2mcFz9w831
Received: by mail-pg1-f197.google.com with SMTP id z19-20020a630a53000000b002dc2f4542faso10443342pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3IJp0VzK2AW2AvxA2fBsTmPC0vUs1+BGahqUKKGay5Y=;
        b=evDsA2VcwrEZzgsvCUb8/IrAyMJOV5I95FUG+IhdDWMwmYhxxoexzNRJNhWT7uH7z3
         SrXZ7r2RNm733myu1qe0rsxSy4Hhpwd+RMP25wK2MhNUYRkUfDn4NILP/+2/XVnAO7mB
         knunNQRaRPf2qag/mOIcLkSCkSnayXTv7V9dHaqIiYwjlbrlqrKF75loKDz2bQZD398H
         B9KcQzQfeg3xS00hgBecp7939F3/KGbOpaKQfr7nIyXg+GmoGzKUnpNfq+eqTi2ZN2GI
         j/Wh+eBEkfJpFhdjeOA1VkLdnNOMm9GwUx6WpRQWUs21tJmdtEG4vEMb/oZCwDvc5Y6J
         Nl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IJp0VzK2AW2AvxA2fBsTmPC0vUs1+BGahqUKKGay5Y=;
        b=PJL3dugwdHaRoXwPBo3Vg0oS6IIL3gwUTWAEkUbIUtlXhgggEAMhbFnfTz3Ytnpi+Q
         SwUOqeeRSbLslTsRYt1++cAo7B0As2ZQd/RYxDuwc3JCg0iXK76mnNtmCk0NC0lsVAVM
         P2R7Wu+BUbe/LrWvNGBdRHeeP194PpB/LERx7ek8VjCO+WYqapu2ipjDi/frgFCq1aVl
         aoBIWKQxjiksYbFZ0Ytwz8rPRc6R6ViBY7aC5p+R0QNDr9cPPVd4WlLCvWlt7wzEiQrd
         h78I9XDuSiw6juiAcOPdoUIYVtewQP5IDNK89ZBRStggsdLb04bDys8Qc75EuMdl7WTZ
         9/jg==
X-Gm-Message-State: AOAM532HkJMqUsNwzrLkP7zm0N0t2nQeEtWxC5Nl1aVcBhe4JtV1XCB7
        fD3Oct1ZYYklIgNnp5EmpGLScgGIq7p/EC9j8gz2cOxDEUsg9ulM+RWUOvldtBcduh8p61FxGEr
        up+48o2FOuFMcJUCn0daU6EDOjNlD
X-Received: by 2002:a63:8641:: with SMTP id x62mr25727003pgd.232.1638286516483;
        Tue, 30 Nov 2021 07:35:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTuBUr122HvExMNui3ZqMfH0TaFipGe6J6kH9s7Fpe1UFJBElPyr3AWBuwDUnD/XH3A0AyuQ==
X-Received: by 2002:a63:8641:: with SMTP id x62mr25726988pgd.232.1638286516257;
        Tue, 30 Nov 2021 07:35:16 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id h5sm18025144pfi.46.2021.11.30.07.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:35:16 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/radeon/radeon_kms: Fix a NULL pointer dereference in  radeon_driver_open_kms()
Date:   Tue, 30 Nov 2021 23:33:59 +0800
Message-Id: <20211130153400.174047-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dc81cea8-f0f2-12c4-bb7b-a6e65dfe6f10@amd.com>
References: <dc81cea8-f0f2-12c4-bb7b-a6e65dfe6f10@amd.com>
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
Changes in v2:
  -  Improve the error handling into goto style

 drivers/gpu/drm/radeon/radeon_kms.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 482fb0ae6cb5..e49a9d160e52 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -649,6 +649,8 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 {
 	struct radeon_device *rdev = dev->dev_private;
 	int r;
+	struct radeon_fpriv *fpriv;
+	struct radeon_vm *vm;
 
 	file_priv->driver_priv = NULL;
 
@@ -660,8 +662,6 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	/* new gpu have virtual address space support */
 	if (rdev->family >= CHIP_CAYMAN) {
-		struct radeon_fpriv *fpriv;
-		struct radeon_vm *vm;
 
 		fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 		if (unlikely(!fpriv)) {
@@ -673,34 +673,38 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			vm = &fpriv->vm;
 			r = radeon_vm_init(rdev, vm);
 			if (r) {
-				kfree(fpriv);
-				goto out_suspend;
+				goto out_fpriv;
 			}
 
 			r = radeon_bo_reserve(rdev->ring_tmp_bo.bo, false);
 			if (r) {
-				radeon_vm_fini(rdev, vm);
-				kfree(fpriv);
-				goto out_suspend;
+				goto out_vm_fini;
 			}
 
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
 			if (r) {
-				radeon_vm_fini(rdev, vm);
-				kfree(fpriv);
-				goto out_suspend;
+				goto out_vm_fini;
 			}
 		}
 		file_priv->driver_priv = fpriv;
 	}
 
+out_vm_fini:
+	radeon_vm_fini(rdev, vm);
+out_fpriv:
+	kfree(fpriv);
 out_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
2.25.1

