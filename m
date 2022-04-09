Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E254FA1E1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiDIDEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiDIDEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:04:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238EE33A2C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 20:02:16 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kb0D86BggzBs6n;
        Sat,  9 Apr 2022 10:58:00 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 11:02:14 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/vmscan: remove obsolete comment in get_scan_count
Date:   Sat, 9 Apr 2022 11:02:45 +0800
Message-ID: <20220409030245.61211-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Since commit 1431d4d11abb ("mm: base LRU balancing on an explicit cost
model"), the relative value of each set of LRU lists is based on cost
model instead of rotated/scanned ratio. Cleanup the relevant comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c77d5052f230..c43008114fb4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2663,9 +2663,7 @@ enum scan_balance {
 
 /*
  * Determine how aggressively the anon and file LRU lists should be
- * scanned.  The relative value of each set of LRU lists is determined
- * by looking at the fraction of the pages scanned we did rotate back
- * onto the active list instead of evict.
+ * scanned.
  *
  * nr[0] = anon inactive pages to scan; nr[1] = anon active pages to scan
  * nr[2] = file inactive pages to scan; nr[3] = file active pages to scan
-- 
2.23.0

