Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1788E587BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiHBLxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBLxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:53:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D7313AD;
        Tue,  2 Aug 2022 04:53:08 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LxtbP0rvVzlVyT;
        Tue,  2 Aug 2022 19:50:25 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 19:53:06 +0800
Received: from huawei.com (10.174.176.191) by dggpemm500018.china.huawei.com
 (7.185.36.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 2 Aug
 2022 19:53:06 +0800
From:   Tie Liu <liutie4@huawei.com>
To:     <tglx@linutronix.de>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hewenliang4@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH] posix-timers: Resolve some coding specification issues about spaces
Date:   Tue, 2 Aug 2022 19:53:05 +0800
Message-ID: <20220802115305.1103-1-liutie4@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.191]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some spaces were not used in accordance with current
encoding specifications, so I tried to modify them.

Signed-off-by: Liu Tie <liutie4@huawei.com>
---
 kernel/time/posix-timers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 5dead8930..ea9b24ee4 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -428,7 +428,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 	return ret;
 }
 
-static struct pid *good_sigevent(sigevent_t * event)
+static struct pid *good_sigevent(sigevent_t *event)
 {
 	struct pid *pid = task_tgid(current);
 	struct task_struct *rtn;
@@ -452,7 +452,7 @@ static struct pid *good_sigevent(sigevent_t * event)
 	}
 }
 
-static struct k_itimer * alloc_posix_timer(void)
+static struct k_itimer *alloc_posix_timer(void)
 {
 	struct k_itimer *tmr;
 	tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
@@ -1106,7 +1106,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	return error;
 }
 
-int do_clock_adjtime(const clockid_t which_clock, struct __kernel_timex * ktx)
+int do_clock_adjtime(const clockid_t which_clock, struct __kernel_timex *ktx)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 
-- 
2.27.0

