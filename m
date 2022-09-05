Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8D5AC8B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiIECJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiIECJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:09:32 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D9FF110E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 19:09:30 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 162BB1E80D74;
        Mon,  5 Sep 2022 10:08:36 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HiXgdR0GdOS1; Mon,  5 Sep 2022 10:08:33 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 876B51E80D59;
        Mon,  5 Sep 2022 10:08:33 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] mm: Remove unnecessary '0' values from err
Date:   Mon,  5 Sep 2022 10:09:18 +0800
Message-Id: <20220905020918.3552-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First execute the kstrtoul function and assign a value to err.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e070b8593b37..be7a2c4081fc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3714,7 +3714,7 @@ static ssize_t demote_store(struct kobject *kobj,
 	unsigned long nr_available;
 	nodemask_t nodes_allowed, *n_mask;
 	struct hstate *h;
-	int err = 0;
+	int err;
 	int nid;
 
 	err = kstrtoul(buf, 10, &nr_demote);
-- 
2.18.2

