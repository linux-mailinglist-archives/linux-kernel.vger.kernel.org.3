Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05B64D6D88
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 09:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiCLIYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 03:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiCLIYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:24:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A805F4E8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:23:45 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KFwkd6nfzzBrJs;
        Sat, 12 Mar 2022 16:21:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 12 Mar
 2022 16:23:43 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: shmem: use helper macro __ATTR_RW
Date:   Sat, 12 Mar 2022 16:22:52 +0800
Message-ID: <20220312082252.55586-1-linmiaohe@huawei.com>
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

Use helper macro __ATTR_RW to define shmem_enabled_attr to make code more
clear.  Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/shmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 659bd599d731..01fd227b6947 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3967,8 +3967,7 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
 	return count;
 }
 
-struct kobj_attribute shmem_enabled_attr =
-	__ATTR(shmem_enabled, 0644, shmem_enabled_show, shmem_enabled_store);
+struct kobj_attribute shmem_enabled_attr = __ATTR_RW(shmem_enabled);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
 
 #else /* !CONFIG_SHMEM */
-- 
2.23.0

