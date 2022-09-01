Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BBE5A8E63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiIAGjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiIAGjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:39:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D34F112ED6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:39:17 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MJBDR0wJMzHnbp;
        Thu,  1 Sep 2022 14:37:27 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 14:39:15 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <yuancan@huawei.com>
Subject: [PATCH] mm: remove extra empty line
Date:   Thu, 1 Sep 2022 06:37:25 +0000
Message-ID: <20220901063725.24220-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra empty line.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 mm/mmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6445fd386f04..2504f89d519f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2804,7 +2804,6 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		unsigned long, prot, unsigned long, pgoff, unsigned long, flags)
 {
-
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long populate = 0;
-- 
2.17.1

