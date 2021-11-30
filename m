Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ECF46325D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhK3LaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:30:13 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:55982 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbhK3LaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:30:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3KgH690wz9w6RJ
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1d8OI01hxZg9 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 05:26:51 -0600 (CST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3KgH45S1z9w6RG
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:26:51 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3KgH45S1z9w6RG
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3KgH45S1z9w6RG
Received: by mail-pl1-f197.google.com with SMTP id v23-20020a170902bf9700b001421d86afc4so8086061pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QROn8xzZY5bJQeJKBLAiXubvRrrPIxieLpkOUMaXcE=;
        b=hW6nGoGSxckS70Hoizh/DTWhmgdqH+fBhKMxpz15VCdZhqHT2SAS9uhDQNkz4wPgAZ
         12AgQnCi+Rs3Caq8v9un7bm6FUc1s124Id/h4afEKkF2EXjLDfx7D3dVTGUF2O+0gMTw
         3BJvFJOIUoa0yty2Gkt7NbgFEjyuOG5BJo3ZRnTWbUIBskhX6i+yqa5B4cHa4naZuqQg
         7tqTq/ztPRWVQLXBgLV4/CESiPlBiJoTfGTGWtHUKUGaVbvgOBNUVHxZv6MurZDEVhbZ
         hqolUaLtsd2AqHUwwyTw6vGIKwNAWVw3xRYcopOLx4W02PCKa6KqSte/xs3sqSYv5mXX
         N04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QROn8xzZY5bJQeJKBLAiXubvRrrPIxieLpkOUMaXcE=;
        b=noTTmAhl38BPX/ftULsmfAmKnfti/9ho0s1bDXNmRpscyDTkT5kt/5jLj8d2xamGkW
         s81UmY9pOQetQjzgNL8X9DqvbZsPgRycZcdaAcI2QOvykYQLVitxWQudUdHUpPZeP55N
         j8eiGUTNBazhyEJfcEBDjpcuifHGQF8ok4eo3gc7PwoPxJhsvJxGoiBHBN/JvatMbr2m
         /kxb5w3tWgDE300te39ZtabkFZIzizG7O+Mk1eqVmRbWYBA8R4pWpGPdMxwd5HeFRpF+
         zKa/S8Kn0IJrW3LqSQlsM4ovT0JiwuGZKCqO3VccLHhYB0kKDqwI7FmdsdM/U/N0rLmm
         MNhw==
X-Gm-Message-State: AOAM5325E8kvJEkKmW9NIRvUo+mN7OujQX/YeL3hq6a+3vMAZ5DhubPs
        Z8Y8t3yPoD/jTYD4rGqMsDmKW5Yn4m56AOaJAe7dKLjyRjXlUnpx93dRw8gKhuCxGDxaVHIzvbC
        QJu+Da0cExgWbxxgTfDDskL8BjDvp
X-Received: by 2002:a17:90b:3b81:: with SMTP id pc1mr5255291pjb.67.1638271610809;
        Tue, 30 Nov 2021 03:26:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWVJhRBFY+Fevp9s2G6MveEJWhzbOra69RrHQmmZrjviSt5HqStUqYwpwcdh4+JRC0nsIh0A==
X-Received: by 2002:a17:90b:3b81:: with SMTP id pc1mr5255269pjb.67.1638271610605;
        Tue, 30 Nov 2021 03:26:50 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id q2sm14594661pfj.62.2021.11.30.03.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:26:50 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Sierra <alex.sierra@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Fix a wild pointer dereference in svm_range_add()
Date:   Tue, 30 Nov 2021 19:26:44 +0800
Message-Id: <20211130112644.116604-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In svm_range_add(), the return value of svm_range_new() is assigned
to prange and &prange->insert_list is used in list_add(). There is a
a dereference of &prange->insert_list in list_add(), which could lead
to a wild pointer dereference on failure of vm_range_new() if
CONFIG_DEBUG_LIST is unset in .config file.

Fix this bug by adding a check of prange.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_AMDGPU=m, CONFIG_HSA_AMD=y, and
CONFIG_HSA_AMD_SVM=y show no new warnings, and our static analyzer no
longer warns about this code.

Fixes: 42de677f7999 ("drm/amdkfd: register svm range")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 58b89b53ebe6..e40c2211901d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2940,6 +2940,9 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	if (left) {
 		prange = svm_range_new(svms, last - left + 1, last);
+		if (!prange)
+			return -ENOMEM;
+
 		list_add(&prange->insert_list, insert_list);
 		list_add(&prange->update_list, update_list);
 	}
-- 
2.25.1

