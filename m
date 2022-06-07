Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2641D5401C9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbiFGOvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiFGOvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:51:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04795BA56F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:51:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LHYBW2KdSzRn7m;
        Tue,  7 Jun 2022 22:48:19 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 7 Jun
 2022 22:51:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] MAINTAINERS: add myself as a memory-failure reviewer
Date:   Tue, 7 Jun 2022 22:51:35 +0800
Message-ID: <20220607145135.38670-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

I have been focusing on mm for the past two years. e.g. fixing bugs,
cleaning up the code and reviewing. I would like to help maintainers
and people working on memory-failure by reviewing their work.

Let me be Cc'd on patches related to memory-failure.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e4ad450bf3c..6430aebfe296 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9136,6 +9136,7 @@ F:	drivers/media/platform/st/sti/hva
 
 HWPOISON MEMORY FAILURE HANDLING
 M:	Naoya Horiguchi <naoya.horiguchi@nec.com>
+R:	Miaohe Lin <linmiaohe@huawei.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/hwpoison-inject.c
-- 
2.23.0

