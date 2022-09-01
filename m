Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1365A9629
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiIAMBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiIAMBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:01:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F78A66A4A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:01:03 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJKKq2P0RzlWfm;
        Thu,  1 Sep 2022 19:57:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 20:01:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 00/10] A few cleanup patches for hugetlb
Date:   Thu, 1 Sep 2022 20:00:20 +0800
Message-ID: <20220901120030.63318-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Hi everyone,
This series contains a few cleanup patches to use helper functions to
simplify the codes, remove unneeded nid parameter and so on. More
details can be found in the respective changelogs.
Thanks!

---
v2:
  collect Reviewed-by tags per Muchun. Thanks!
  tweak the commit log in 3/10
  change to add a comment for SetHPageVmemmapOptimized() in 8/10
  make hugetlb depends on SYSFS || SYSCTL in 10/10
---
Miaohe Lin (10):
  hugetlb: make hugetlb_cma_check() static
  hugetlb: Use helper macro SZ_1K
  hugetlb: Use LIST_HEAD() to define a list head
  hugetlb: Use sizeof() to get the array size
  hugetlb: Use helper {huge_pte|pmd}_lock()
  hugetlb: pass NULL to kobj_to_hstate() if nid is unused
  hugetlb: kill hugetlbfs_pagecache_page()
  hugetlb: add comment for subtle SetHPageVmemmapOptimized()
  hugetlb: remove meaningless BUG_ON(huge_pte_none())
  hugetlb: make hugetlb depends on SYSFS  or SYSCTL

 fs/Kconfig              |  1 +
 include/linux/hugetlb.h |  4 ---
 mm/hugetlb.c            | 55 +++++++++++++++++------------------------
 3 files changed, 24 insertions(+), 36 deletions(-)

-- 
2.23.0

