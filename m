Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD5595CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiHPNGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiHPNGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:06:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5042608
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:06:20 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6WXz1YJhzlW9k;
        Tue, 16 Aug 2022 21:03:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 16 Aug
 2022 21:06:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/6] A few fixup patches for hugetlb
Date:   Tue, 16 Aug 2022 21:05:47 +0800
Message-ID: <20220816130553.31406-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
This series contains a few fixup patches to fix incorrect update of
max_huge_pages, fix WARN_ON(!kobj) in sysfs_create_group() and so on.
More details can be found in the respective changelogs.
Thanks!

Miaohe Lin (6):
  mm/hugetlb: fix incorrect update of max_huge_pages
  mm/hugetlb: fix WARN_ON(!kobj) in sysfs_create_group()
  mm/hugetlb: fix missing call to restore_reserve_on_error()
  mm: hugetlb_vmemmap: add missing smp_wmb() before set_pte_at()
  mm/hugetlb: fix sysfs group leak in hugetlb_unregister_node()
  mm/hugetlb: make detecting shared pte more reliable

 mm/hugetlb.c         | 46 +++++++++++++++++++++++++++-----------------
 mm/hugetlb_vmemmap.c |  5 +++++
 2 files changed, 33 insertions(+), 18 deletions(-)

-- 
2.23.0

