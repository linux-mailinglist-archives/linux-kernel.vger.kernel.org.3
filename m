Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636C746B603
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhLGIgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhLGIf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:35:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8615BC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 00:32:28 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v19so8907580plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 00:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfWsedxdFoV1274mxC0yfxwctidX1YkVFdQQhiVSYhg=;
        b=J259e89vWXSteoTpWUD3tOVP+lwQB9cYfrchw+Of5SHk61kx3Dh/TWK45Yr/YR16O6
         tiCyT26daiEPNza2IZ9GdpxdQAgmT0+V6Yr8gVRcsU+D+x7iZsUXmGvKAChoTW3v/O75
         YnMhM03/A7LHz/w/uskSiZo0o4vD2QPeaStJ4b8dDu4X46V6iK11Ipm29Guz3U6aTDmg
         5kqqZF2LJcjNAOXeW8n0Tn46svd7nlJm1oS7IJhrS+qN6yaEz4iEPBvOZOxDkGVoTh+j
         ZXuUVCOnTJEWL3ORFZY1jeLZpZkhKMmcdKmwFtEN7fJQSrirw/02+lyA36ZKPou7Pb5y
         l8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfWsedxdFoV1274mxC0yfxwctidX1YkVFdQQhiVSYhg=;
        b=gGQ1tdlJsLVBjFtrKTEjNx2HqnKr4VPW/lxE5t2hK1Jdi07YwLN67Oq9KiEXiRL4eO
         aDvV1UY7ZG97RfGm5wnOiGQzby5mfjXEA/+64L+XnDib8elfGWZ1HAOnoTUtowyv89cV
         ZMic2TmdtbI8qx8yNClhJGgSSEu3NasM47i8dmBede2/Lc74kee9UZaHT3KcD3vFdz69
         2CtVfYrhyvDl/NAE8Yr4LyArBnwooJH4x1/DMKV+zjn6uZVGHOko1ATrUd7x6q8FGQyw
         7fS1eIAzUqqxcOVsiOCStFGOL89sgepkBP5KtDgHYitLfv1f0DW8lclq7ieMTuododeL
         aEwg==
X-Gm-Message-State: AOAM530mIx7jgxgmN9Phz8VXDDBZPd7V0zm7KL32RBUDAnicH26TD2OS
        VxKkC6h3IeImZ5fxtxiR6qU=
X-Google-Smtp-Source: ABdhPJyzIeaBMTbqBIrWsFJHAe+pLEQodnIcHy0i8XhDdHScFvyACPumTIzYAPyGHpEFqpRe2aWNAg==
X-Received: by 2002:a17:90b:1b4a:: with SMTP id nv10mr4953972pjb.118.1638865948166;
        Tue, 07 Dec 2021 00:32:28 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o16sm16219765pfu.72.2021.12.07.00.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:32:27 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] mm:remove unneeded variable
Date:   Tue,  7 Dec 2021 08:32:22 +0000
Message-Id: <20211207083222.401594-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 mm/truncate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index cc83a3f7c1ad..41b8249b3b4a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -205,7 +205,6 @@ static void truncate_cleanup_page(struct page *page)
 static int
 invalidate_complete_page(struct address_space *mapping, struct page *page)
 {
-	int ret;
 
 	if (page->mapping != mapping)
 		return 0;
@@ -213,9 +212,7 @@ invalidate_complete_page(struct address_space *mapping, struct page *page)
 	if (page_has_private(page) && !try_to_release_page(page, 0))
 		return 0;
 
-	ret = remove_mapping(mapping, page);
-
-	return ret;
+	return remove_mapping(mapping, page);
 }
 
 int truncate_inode_page(struct address_space *mapping, struct page *page)
-- 
2.25.1

