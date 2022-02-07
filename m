Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9C4AC017
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388763AbiBGNuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387672AbiBGNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:38:02 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88650C0401D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:37:24 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JsnCD1VTwz1FD17;
        Mon,  7 Feb 2022 21:33:12 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 21:37:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/4] mm/memory_hotplug: remove obsolete comment of __add_pages
Date:   Mon, 7 Feb 2022 21:36:40 +0800
Message-ID: <20220207133643.23427-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220207133643.23427-1-linmiaohe@huawei.com>
References: <20220207133643.23427-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
memory to zones until online"), there is no need to pass in the zone.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory_hotplug.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a4f69d399929..cbc67c27e0dd 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -296,10 +296,7 @@ struct page *pfn_to_online_page(unsigned long pfn)
 EXPORT_SYMBOL_GPL(pfn_to_online_page);
 
 /*
- * Reasonably generic function for adding memory.  It is
- * expected that archs that support memory hotplug will
- * call this function after deciding the zone to which to
- * add the new pages.
+ * Reasonably generic function for adding memory.
  */
 int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 		struct mhp_params *params)
-- 
2.23.0

