Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8A52C9F3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiESCzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiESCzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:55:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00FC6400
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:55:48 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L3ZG84ljBzhZ20
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:54:56 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 10:55:46 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     patchwork <patchwork@huawei.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Xiang Yang <xiangyang3@huawei.com>,
        Cui Gaosheng <cuigaosheng1@huawei.com>,
        Lu Jialin <lujialin4@huawei.com>,
        Yi Yang <yiyang13@huawei.com>,
        Gong Ruiqi <gongruiqi1@huawei.com>,
        Guo Zihua <guozihua@huawei.com>
Subject: [PATCH] samples: Remove redundant assignment for cn_test sample
Date:   Thu, 19 May 2022 10:54:14 +0800
Message-ID: <20220519025414.216662-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant assignment for m->len

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 samples/connector/cn_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/connector/cn_test.c b/samples/connector/cn_test.c
index 0958a171d048..42d6c9f33842 100644
--- a/samples/connector/cn_test.c
+++ b/samples/connector/cn_test.c
@@ -124,7 +124,6 @@ static void cn_test_timer_func(struct timer_list *unused)
 
 		memcpy(&m->id, &cn_test_id, sizeof(m->id));
 		m->seq = cn_test_timer_counter;
-		m->len = sizeof(data);
 
 		m->len =
 		    scnprintf(data, sizeof(data), "counter = %u",
-- 
2.36.0

