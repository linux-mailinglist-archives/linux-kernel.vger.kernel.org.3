Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3A463996
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245444AbhK3PRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:17:14 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:60762 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244259AbhK3PIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:08:17 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3QVx1rNVz9vpQQ
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kC-bSb3-JV9i for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 09:04:57 -0600 (CST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3QVw6lNpz9vpQS
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:04:56 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3QVw6lNpz9vpQS
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3QVw6lNpz9vpQS
Received: by mail-pg1-f199.google.com with SMTP id s2-20020a632142000000b0032173c0daf1so10389958pgm.16
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jkm3SRjlEMuj/OoI/keUI8sb3jpLnQn0wJDEn5YUqIA=;
        b=d+j0Y9bABjd3Q6pxla8ql2DGsgWbafWr4RzOLv5wUlwTydWGasWbCtKgQVgYEpxRze
         ZkOrFvwRyXqFs8SlIFQG02ZNIfmkVuQsPajnCwkD50d56H3GKZE+xYzBsQEfILfRbBLn
         M9O0IVxdg/4py2IrGbEO77kF/AESMA2YYEQ6iiDl/QW3qOf6qQ5Zh2YRZUyz4inrdOcD
         Xf9iNrX4dtooqBoBTrizwztrwu6mVF7qxrhOZxv+vGGBaKMKJ6X0FfldRPNmnTtIhDPD
         g+71UnqUrZpQwgcqkLG3EIKckBhZAa0GEiYKtlYWGLV6UA/Jnr5ZTkSdyxgiY+YXVLA/
         q5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jkm3SRjlEMuj/OoI/keUI8sb3jpLnQn0wJDEn5YUqIA=;
        b=nvbR1H6umEiXN+eIUPqJn4zyelGp3SPGu/YMpGanFXDGBVOUVJkQSkvr1rC3941T9u
         1bGiUw0yny5ZTX98E5RwHcAOcP2auSQFBf3c4UQtnmEsK4SMTIH2nyocbavXYwIOTHI9
         3rHVzsvGlONz1uyIqywG9vDXFavqIZMPO6KfHRGYKI/sDJLlln5uZLHx/NGgGsKs5v9Q
         MQ/KzpvdUucsQshZrTnf5W8+IYwICSQC38dHA/bkIGH7U7zHFbiH2sfUTHfPj8WVM7xl
         nFOjxxzPF4kkD8II8NFrSumLyWcgyly7ThSGMznm37Gc/WY6VA2NfspWPsaBc0bh0Z1D
         X/Hw==
X-Gm-Message-State: AOAM533x5reeIgkLoJJleM+Ykt8QzQ65jJqZXuvmEIQhvM5zipKHG8Gi
        KHdv+/WlZ+dtK76HBznl0LpkH/Y+3X0FzcvzBp22h0am6diK7UvCuBpenbrbp6R7TIb5nv4vYf9
        1YjnIvI120CX+gacP3uosfY8NJlK7
X-Received: by 2002:a17:903:2292:b0:141:e76d:1b16 with SMTP id b18-20020a170903229200b00141e76d1b16mr66792823plh.21.1638284696195;
        Tue, 30 Nov 2021 07:04:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8GWn6nizJsszaZRStEl3f7YTD0lEXqp9tlfH0fC2cLbTGzG/x+jCHUyEelCV+t398xQYrMQ==
X-Received: by 2002:a17:903:2292:b0:141:e76d:1b16 with SMTP id b18-20020a170903229200b00141e76d1b16mr66792771plh.21.1638284695794;
        Tue, 30 Nov 2021 07:04:55 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id y28sm23124794pfa.208.2021.11.30.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:04:55 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon/radeon_kms: Fix a NULL pointer dereference in radeon_driver_open_kms()
Date:   Tue, 30 Nov 2021 23:04:49 +0800
Message-Id: <20211130150449.166144-1-zhou1615@umn.edu>
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
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 482fb0ae6cb5..ead015c055fb 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -688,6 +688,13 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			 * virtual address space */
 			vm->ib_bo_va = radeon_vm_bo_add(rdev, vm,
 							rdev->ring_tmp_bo.bo);
+			if (!vm->ib_bo_va) {
+				r = -ENOMEM;
+				radeon_vm_fini(rdev, vm);
+				kfree(fpriv);
+				goto out_suspend;
+			}
+
 			r = radeon_vm_bo_set_addr(rdev, vm->ib_bo_va,
 						  RADEON_VA_IB_OFFSET,
 						  RADEON_VM_PAGE_READABLE |
-- 
2.25.1

