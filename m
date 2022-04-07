Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF834F8004
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbiDGNGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbiDGNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:05:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4828C25C588
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:03:23 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KZ1l21ZWLz1HBdP;
        Thu,  7 Apr 2022 21:02:54 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 21:03:21 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <shy828301@gmail.com>, <mike.kravetz@oracle.com>,
        <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 0/3] A few fixup and cleanup patches for memory failure
Date:   Thu, 7 Apr 2022 21:03:49 +0800
Message-ID: <20220407130352.15618-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Hi everyone,
This series contains a patch to fix false-postive PageSwapCache test,
minor cleanup for HWPoisonHandlable and try to dissolve truncated
hugetlb page. More details can be found in the respective changelogs.
Thanks!

---
v1:
Rebase [1] on mainline.
Add new patch "mm/memory-failure.c: dissolve truncated hugetlb page"

[1]https://lore.kernel.org/linux-mm/0d5f2c97-992b-442c-9ecf-26ba363461aa@huawei.com/T/#m310e36806a1f614a4d1c7cc1d7a5e6e6e17f663d
---
Miaohe Lin (3):
  mm/memory-failure.c: avoid false-postive PageSwapCache test
  mm/memory-failure.c: minor cleanup for HWPoisonHandlable
  mm/memory-failure.c: dissolve truncated hugetlb page

 mm/memory-failure.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.23.0

