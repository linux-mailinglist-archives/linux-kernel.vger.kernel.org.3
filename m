Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ECB498593
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbiAXQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:59:09 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:49314 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244049AbiAXQ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:59:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4JjGRD3bKQz9vKSm
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:59:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j_qZSIQ02XDh for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 10:59:04 -0600 (CST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4JjGRD1VGsz9vKTC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:59:04 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4JjGRD1VGsz9vKTC
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4JjGRD1VGsz9vKTC
Received: by mail-pg1-f197.google.com with SMTP id o20-20020a656a54000000b003441a994d60so10219397pgu.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBdR4mgm88fr12HVo/ewep9TPqR0vTSvkIZJUoqDnV8=;
        b=i9gwll8Lj0xIystAPGKZPE6qavOR9ipRhN3UOjJAZBL0zM3KdFOuYScCsxjIL5KW72
         mnmvOoi35XlwgkX90lC/GVK8Y5bsuSZXi65LxGsHvNcgieXe0Cnn0I9HugOK75K/Ap40
         +I3jYOQxsiMstiLOooqtHxjBlOXnOw9fzWuqctJCRUEyjHwCC6/nM2vn6wjoN1FuIqQO
         pFXTUxn6gXYd7rcEdP+irCKVGkHe78RM23O4Z9t6421BLl7GpcjJ9aofu/nNpRn5qdYF
         nQSbPgd/GcRvK/eWVUGTpW4vXI7zPkbqp3+BWwcEA2aGlBlOoKL4tX9E6RsEGIpdozLO
         jFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBdR4mgm88fr12HVo/ewep9TPqR0vTSvkIZJUoqDnV8=;
        b=Fmcr2Hlb3sL8CKgXmjjm0Uy0sh5VHYjC3orbsFayW5OGeVJ9COEoZ3ovfVA9usk5kQ
         uaADeuDKxCtKgjR4aXJ+PEjNcpXGc3hQNGcPHl3/2XVYu8fIiIEn1o764OiOOtyHcLVH
         QWkE5bsPmpxvPU6hIUDA0POpxcQgaiAbCGaC4Di5ZREUqdXNw1KH1HCwpW+ig2l5v3iV
         pXs87OwjgEA01sk+3xNoIWFRj6pNCuQDLcv5vWtCLM+92tbbaGzdV+WVFccYtetX6vKj
         446i+rZH1/+WpBdGwkfkkqR6CSOecJ0awNiIC9BNN8YNR23/ki+xego8F/h+B56zDxeQ
         1B3Q==
X-Gm-Message-State: AOAM533YSOt7wJfvOXEAelwD+1C5eDkLO1U0xaPsr17bxE0XET7wHP0u
        P0+i5YRMbeipaDa/1nZSETcfzGebGDa+3IR2ofI8QAFhI8L0aFxVjHqI7G60VskV13SlQJJdqk4
        ZqKB591keNW676hKaxgcufyYRMaUF
X-Received: by 2002:a17:902:a502:b0:149:c5a5:5329 with SMTP id s2-20020a170902a50200b00149c5a55329mr15059193plq.164.1643043543455;
        Mon, 24 Jan 2022 08:59:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx153Lwqmcm3ClgP1FVJyLtTuU1uOlM4S9H5l1vuihVakSp4Vk8HYPmRXyyQQ13l5bkmxsCkA==
X-Received: by 2002:a17:902:a502:b0:149:c5a5:5329 with SMTP id s2-20020a170902a50200b00149c5a55329mr15059179plq.164.1643043543198;
        Mon, 24 Jan 2022 08:59:03 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id c17sm17289913pfc.171.2022.01.24.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:59:02 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/acr: Fix undefined behavior in nvkm_acr_hsfw_load_bl()
Date:   Tue, 25 Jan 2022 00:58:55 +0800
Message-Id: <20220124165856.57022-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nvkm_acr_hsfw_load_bl(), the return value of kmalloc() is directly
passed to memcpy(), which could lead to undefined behavior on failure
of kmalloc().

Fix this bug by using kmemdup() instead of kmalloc()+memcpy().

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace "secure boot"")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
index 667fa016496e..a6ea89a5d51a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
@@ -142,11 +142,12 @@ nvkm_acr_hsfw_load_bl(struct nvkm_acr *acr, const char *name, int ver,
 
 	hsfw->imem_size = desc->code_size;
 	hsfw->imem_tag = desc->start_tag;
-	hsfw->imem = kmalloc(desc->code_size, GFP_KERNEL);
-	memcpy(hsfw->imem, data + desc->code_off, desc->code_size);
-
+	hsfw->imem = kmemdup(data + desc->code_off, desc->code_size, GFP_KERNEL);
 	nvkm_firmware_put(fw);
-	return 0;
+	if (!hsfw->imem)
+		return -ENOMEM;
+	else
+		return 0;
 }
 
 int
-- 
2.25.1

