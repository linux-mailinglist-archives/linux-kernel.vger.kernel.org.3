Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F754BB4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiBRJDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:03:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiBRJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:02:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7902B56235
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:02:12 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K0Qf65KW3zdZLy;
        Fri, 18 Feb 2022 17:01:02 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Feb
 2022 17:02:10 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 7/8] mm/memory-failure.c: remove obsolete comment in __soft_offline_page
Date:   Fri, 18 Feb 2022 17:01:17 +0800
Message-ID: <20220218090118.1105-8-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220218090118.1105-1-linmiaohe@huawei.com>
References: <20220218090118.1105-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit add05cecef80 ("mm: soft-offline: don't free target page in
successful page migration"), set_migratetype_isolate logic is removed.
Remove this obsolete comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 365384c41da1..6bd555f12972 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2171,10 +2171,6 @@ static int __soft_offline_page(struct page *page)
 		ret = invalidate_inode_page(page);
 	unlock_page(page);
 
-	/*
-	 * RED-PEN would be better to keep it isolated here, but we
-	 * would need to fix isolation locking first.
-	 */
 	if (ret) {
 		pr_info("soft_offline: %#lx: invalidated\n", pfn);
 		page_handle_poison(page, false, true);
-- 
2.23.0

