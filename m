Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164695472FF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiFKIrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiFKIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:47:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6045F67
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 01:47:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LKry66MlRz1K96X;
        Sat, 11 Jun 2022 16:45:34 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 11 Jun
 2022 16:47:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <aarcange@redhat.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <neilb@suse.de>, <apopple@nvidia.com>,
        <david@redhat.com>, <surenb@google.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/7] A few cleanup patches for khugepaged
Date:   Sat, 11 Jun 2022 16:47:24 +0800
Message-ID: <20220611084731.55155-1-linmiaohe@huawei.com>
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
This series contains a few cleaup patches to remove unneeded return
value, use helper macro, fix typos and so on. More details can be
found in the respective changelogs. Thanks!

Miaohe Lin (7):
  mm/khugepaged: remove unneeded shmem_huge_enabled() check
  mm/khugepaged: stop swapping in page when VM_FAULT_RETRY occurs
  mm/khugepaged: trivial typo and codestyle cleanup
  mm/khugepaged: minor cleanup for collapse_file
  mm/khugepaged: use helper macro __ATTR_RW
  mm/khugepaged: remove unneeded return value of
    khugepaged_add_pte_mapped_thp()
  mm/khugepaged: try to free transhuge swapcache when possible

 include/linux/swap.h |  5 +++
 mm/khugepaged.c      | 85 +++++++++++++++++++-------------------------
 mm/swap.h            |  5 ---
 3 files changed, 41 insertions(+), 54 deletions(-)

-- 
2.23.0

