Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28865A227F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbiHZH7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245738AbiHZH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:59:30 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E369ED41BE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=TCilS
        g6OYB4veW0eiualY6DwUFfKhAgP1bFkUga58AY=; b=BKmlB199FxjRmrxEH7M/0
        DlGIhbN3hNh0Ebv7xpHnRrE7mmIDbTMv03a6QYBQLd+3cWBVfLfWttEjIbi5vdjL
        1kgN60Fw2xpH+Zq7XFB85JbE37X+Fq3WtXO/v4lXKELjs0ibTMpRYVOgPTW39/6b
        zcbXkDcIbLAleAQ6iRRjnY=
Received: from localhost (unknown [49.235.41.28])
        by smtp2 (Coremail) with SMTP id GtxpCgAHzPzxfAhjty3rYA--.12030S2;
        Fri, 26 Aug 2022 15:57:38 +0800 (CST)
Date:   Fri, 26 Aug 2022 15:57:37 +0800
From:   Hui Su <suhui_kernel@163.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched: remove struct sg_lb_stats declaration
Message-ID: <Ywh88U1J9pSGOOMK@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: GtxpCgAHzPzxfAhjty3rYA--.12030S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrGr47urW5ur1xuFWxtF18Xwb_yoWxGFg_W3
        Z5Crn3Kw4vyr1Yv347G3yftry0qa48tF10k3WIy3yDAwsYqr9xJr95AFn3Ar9xWFsrGw4D
        trnxWF10gr1kKjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjkR67UUUUU==
X-Originating-IP: [49.235.41.28]
X-CM-SenderInfo: 5vxk3xhbnh20lho6il2tof0z/xtbBsg5pbV75gM9VNAAAsx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary struct sg_lb_stats declaration

Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
Signed-off-by: Hui Su <suhui_kernel@163.com>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c5b1ae..54bacf635362 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9050,9 +9050,6 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-
-struct sg_lb_stats;
-
 /*
  * task_running_on_cpu - return 1 if @p is running on @cpu.
  */
-- 
2.34.1

