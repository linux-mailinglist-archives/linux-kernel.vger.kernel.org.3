Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4977584DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiG2JF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiG2JFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:05:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123FB13E32;
        Fri, 29 Jul 2022 02:05:23 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LvM5N30FJz9t1S;
        Fri, 29 Jul 2022 17:04:08 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 17:05:15 +0800
Received: from huawei.com (10.174.176.191) by dggpemm500018.china.huawei.com
 (7.185.36.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 17:05:14 +0800
From:   l00581214 <liutie4@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hewenliang4@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH] audit: Modifying indentation issue.
Date:   Fri, 29 Jul 2022 17:05:13 +0800
Message-ID: <20220729090513.1467-1-liutie4@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.191]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tie Liu <liutie4@huawei.com>

Modifying indentation issue in audit_rate_check().

Signed-off-by: Tie Liu <liutie4@huawei.com>
---
 kernel/audit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 7690c29d4..deeede166 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -324,7 +324,8 @@ static inline int audit_rate_check(void)
 	unsigned long		elapsed;
 	int			retval	   = 0;
 
-	if (!audit_rate_limit) return 1;
+	if (!audit_rate_limit)
+		return 1;
 
 	spin_lock_irqsave(&lock, flags);
 	if (++messages < audit_rate_limit) {
-- 
2.27.0

