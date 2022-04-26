Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CED50EE64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbiDZCCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241697AbiDZCCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:02:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B771B8AE7A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:59:01 -0700 (PDT)
Received: from kwepemi100020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KnQ5v1kBJzQjBn;
        Tue, 26 Apr 2022 09:58:43 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100020.china.huawei.com (7.221.188.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 09:58:59 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 09:58:58 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <guoren@kernel.org>, <mhiramat@kernel.org>, <palmer@dabbelt.com>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <jszhang@kernel.org>,
        <peterz@infradead.org>, <liaochang1@huawei.com>, <me@packi.ch>,
        <penberg@kernel.org>, <lihuafei1@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] riscv: ftrace: Fix the comments about the number of ftrace instruction
Date:   Tue, 26 Apr 2022 09:57:50 +0800
Message-ID: <20220426015751.88582-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DYNAMIC_FTRACE is enabled, we put four instructions in front of the
function for ftrace use, not five.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/riscv/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4716f4cdc038..63f457650fa4 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -73,7 +73,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 }
 
 /*
- * Put 5 instructions with 16 bytes at the front of function within
+ * Put 4 instructions with 16 bytes at the front of function within
  * patchable function entry nops' area.
  *
  * 0: REG_S  ra, -SZREG(sp)
-- 
2.17.1

