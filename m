Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A81A55A876
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiFYJ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiFYJ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:28:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567CDB860
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:28:22 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LVTCX58nbzkWZ3;
        Sat, 25 Jun 2022 17:27:04 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 25 Jun
 2022 17:28:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <zokeefe@google.com>, <aarcange@redhat.com>,
        <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 3/7] mm/khugepaged: trivial typo and codestyle cleanup
Date:   Sat, 25 Jun 2022 17:28:12 +0800
Message-ID: <20220625092816.4856-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220625092816.4856-1-linmiaohe@huawei.com>
References: <20220625092816.4856-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Fix some typos and tweak the code to meet codestyle. No functional
change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c6fc4eb8d77b..a36d9746c321 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -260,7 +260,7 @@ static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
 	unsigned long max_ptes_none;
 
 	err = kstrtoul(buf, 10, &max_ptes_none);
-	if (err || max_ptes_none > HPAGE_PMD_NR-1)
+	if (err || max_ptes_none > HPAGE_PMD_NR - 1)
 		return -EINVAL;
 
 	khugepaged_max_ptes_none = max_ptes_none;
@@ -286,7 +286,7 @@ static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
 	unsigned long max_ptes_swap;
 
 	err  = kstrtoul(buf, 10, &max_ptes_swap);
-	if (err || max_ptes_swap > HPAGE_PMD_NR-1)
+	if (err || max_ptes_swap > HPAGE_PMD_NR - 1)
 		return -EINVAL;
 
 	khugepaged_max_ptes_swap = max_ptes_swap;
@@ -313,7 +313,7 @@ static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
 	unsigned long max_ptes_shared;
 
 	err  = kstrtoul(buf, 10, &max_ptes_shared);
-	if (err || max_ptes_shared > HPAGE_PMD_NR-1)
+	if (err || max_ptes_shared > HPAGE_PMD_NR - 1)
 		return -EINVAL;
 
 	khugepaged_max_ptes_shared = max_ptes_shared;
@@ -560,7 +560,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	int none_or_zero = 0, shared = 0, result = 0, referenced = 0;
 	bool writable = false;
 
-	for (_pte = pte; _pte < pte+HPAGE_PMD_NR;
+	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
 		if (pte_none(pteval) || (pte_present(pteval) &&
@@ -1183,7 +1183,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 
 	memset(khugepaged_node_load, 0, sizeof(khugepaged_node_load));
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
-	for (_address = address, _pte = pte; _pte < pte+HPAGE_PMD_NR;
+	for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, _address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
 		if (is_swap_pte(pteval)) {
@@ -1273,7 +1273,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		/*
 		 * Check if the page has any GUP (or other external) pins.
 		 *
-		 * Here the check is racy it may see totmal_mapcount > refcount
+		 * Here the check is racy it may see total_mapcount > refcount
 		 * in some cases.
 		 * For example, one process with one forked child process.
 		 * The parent has the PMD split due to MADV_DONTNEED, then
@@ -1524,7 +1524,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * mmap_write_lock(mm) as PMD-mapping is likely to be split
 		 * later.
 		 *
-		 * Not that vma->anon_vma check is racy: it can be set up after
+		 * Note that vma->anon_vma check is racy: it can be set up after
 		 * the check but before we took mmap_lock by the fault path.
 		 * But page lock would prevent establishing any new ptes of the
 		 * page, so we are safe.
-- 
2.23.0

