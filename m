Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD18550B26
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 16:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiFSOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFSOVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:21:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F13ABC8C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:21:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so3421870pjg.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxSyMDIE+M8LTJ/59DR+83z8FrdAj2WmQ9DtCi+Dp8c=;
        b=pWjB4O7I4x9jE9a/NB/amln9h2crE+YrLi/S4rt9RVJHAPV1g6adntco58HSbDD/u5
         dbZtxEjsT9iiVy/8KrDMJzG9Zdm2ErTz7OYhZJJxzo+0FU7Jbtm4tBMYPiVuy7ZkKE+K
         SwhU43zdOw6P4tM4l4PDpnJrlqIQu9RqVkLiC5WuucgMrbrJpQc0CtVlxUjDGJUk41we
         HLhp83/rANfThcYU9IyCkN4vsweyMfbECr9EpOy9MKyYWZs4ZQMB3XWLZrcqVoq6SiMx
         7LGQF8IWfNFehd7/DlsKiTOaNBpkhgVu0rAXIWGGUUqXdhJD/645eLcH7gQqtrSVV9Ac
         3reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxSyMDIE+M8LTJ/59DR+83z8FrdAj2WmQ9DtCi+Dp8c=;
        b=Un3/6Jd32gBh4rX1qOedGUuuFIO0IBvlE/YqVwoYROZI9z19UD6Ly5Y02fIClofoyV
         a0jRXv+ThPWrFo4E96d0Z8UJGpyn4iXW58UyjhuDc/ETVwExQ9Kmw9W+rSWQq9xotyh5
         90NPhSl0yxnsztbnv6mvjQ7Ako1Y1tMzYCyUkrwXx4b3pFSUSLpsFxH1cpcS7ESRwTZD
         A/SMKvaYfZs/3yp0xLtccjJ2UnTrQOfydjRkgXd2ds/4KfS6nKECxK3uQRg5LUEy4rKw
         XET4XjAnopzXAP76XfOcFiq2WpSU6pYJ091X0sCZzJQNseoQ4LsalT9ZfpwdJJqCXe5h
         cMRg==
X-Gm-Message-State: AJIora8u7L7R1hk97D3Jwq9MXuHBL/GvTID/NvNj//HlCAkaLnmPOQq1
        0H0wgdklXuNguBsnKC7soNM=
X-Google-Smtp-Source: AGRyM1v+hOHk3VVPIUjNR7IFZdqTuIK5M4ci6xG2mC7IXB3PBj0gFUNs3lnFfbVCZs4aC1GNLP5oFw==
X-Received: by 2002:a17:90b:1646:b0:1e3:15ef:2871 with SMTP id il6-20020a17090b164600b001e315ef2871mr32463990pjb.105.1655648459552;
        Sun, 19 Jun 2022 07:20:59 -0700 (PDT)
Received: from DESKTOP-IM4PCEA.localdomain ([49.207.215.19])
        by smtp.googlemail.com with ESMTPSA id f6-20020a170902684600b0015e8d4eb1f9sm4531325pln.67.2022.06.19.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 07:20:59 -0700 (PDT)
From:   Mintu Patel <mintupatel89@gmail.com>
To:     mintupatel89@gmail.com
Cc:     Chinmoy Ghosh <chinmoyghosh2001@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        Vimal Kumar <vimal.kumar32@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] rt_spin_lock: To list the correct owner of rt_spin_lock
Date:   Sun, 19 Jun 2022 19:50:38 +0530
Message-Id: <20220619142038.1274-1-mintupatel89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   rt_spin_lock is actually mutex on RT Kernel so it goes for contention
   for lock. Currently owners of rt_spin_lock are decided before actual
   acquiring of lock. This patch would depict the correct owner of
   rt_spin_lock. The patch would help in solving crashes and deadlock
   due to race condition of lock

acquiring rt_spin_lock        acquired the lock       released the lock
                    <-------->                <------->
                    contention period         Held period

Thread1                             Thread2
_try_to_take_rt_mutex+0x95c+0x74    enqueue_task_dl+0x8cc/0x8dc
rt_spin_lock_slowlock_locked+0xac+2 rt_mutex_setprio+0x28c/0x574
rt_spin_lock_slowlock+0x5c/0x90     task_blocks_rt_mutex+0x240/0x310
rt_spin_lock+0x58/0x5c              rt_spin_lock_slowlock_locked+0xac/0x2
driverA_acquire_lock+0x28/0x56      rt_spin_lock_slowlock+0x5c/0x90
				    rt_spin_lock+0x58/0x5c
                                    driverB_acquire_lock+0x48/0x6c

As per above call traces sample, Thread1 acquired the rt_spin_lock and
went to critical section on the other hand Thread2 kept trying to acquire
the same rt_spin_lock held by Thread1 ie contention period is too high.
Finally Thread2 entered to dl queue due to high held time of the lock by
Thread1. The below patch would help us to know the correct owner of
rt_spin_lock and point us the driver's critical section. Respective
driver need to be debugged for longer held period of lock.

   ex: cat /sys/kernel/debug/tracing/trace

   kworker/u13:0-150   [003] .....11   202.761025: rt_spinlock_acquire:
Process: kworker/u13:0 is acquiring lock: &kbdev->hwaccess_lock
   kworker/u13:0-150   [003] .....11   202.761039: rt_spinlock_acquired:
Process: kworker/u13:0 has acquired lock: &kbdev->hwaccess_lock
   kworker/u13:0-150   [003] .....11   202.761042: rt_spinlock_released:
Process: kworker/u13:0 has released lock: &kbdev->hwaccess_lock

Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
---
 include/trace/events/lock.h | 59 +++++++++++++++++++++++++++++++++++++
 kernel/locking/rtmutex.c    | 10 +++++++
 2 files changed, 69 insertions(+)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index d7512129a324..c250a83ed995 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -35,6 +35,65 @@ TRACE_EVENT(lock_acquire,
 		  (__entry->flags & 2) ? "read " : "",
 		  __get_str(name))
 );
+TRACE_EVENT(rt_spinlock_acquire,
+
+	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
+
+	TP_ARGS(lock, pname),
+
+	TP_STRUCT__entry(
+		__string(name, lock->name)
+		__string(process_name, pname->comm)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, lock->name);
+		__assign_str(process_name, pname->comm);
+	),
+
+	TP_printk("Process: %s is acquiring lock: %s",  __get_str(process_name),
+		__get_str(name))
+);
+
+TRACE_EVENT(rt_spinlock_acquired,
+
+	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
+
+	TP_ARGS(lock, pname),
+
+	TP_STRUCT__entry(
+		__string(name, lock->name)
+		__string(process_name, pname->comm)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, lock->name);
+		__assign_str(process_name, pname->comm);
+	),
+
+	TP_printk("Process: %s has acquired lock: %s", __get_str(process_name),
+		__get_str(name))
+);
+
+TRACE_EVENT(rt_spinlock_released,
+
+	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
+
+	TP_ARGS(lock, pname),
+
+	TP_STRUCT__entry(
+		__string(name, lock->name)
+		__string(process_name, pname->comm)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, lock->name);
+		__assign_str(process_name, pname->comm);
+	),
+
+	TP_printk("Process: %s has released lock: %s", __get_str(process_name),
+		__get_str(name))
+);
 
 DECLARE_EVENT_CLASS(lock,
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 602eb7821a1b..f7cba05fbe74 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -26,6 +26,7 @@
 #include <linux/timer.h>
 #include <linux/ww_mutex.h>
 #include <linux/blkdev.h>
+#include <trace/events/lock.h>
 
 #include "rtmutex_common.h"
 
@@ -1144,7 +1145,13 @@ void __lockfunc rt_spin_lock(spinlock_t *lock)
 	rcu_read_lock();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+#ifdef CONFIG_RT_SPIN_LOCK_TRACING
+	trace_rt_spinlock_acquire(&lock->dep_map, current);
+#endif
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+#ifdef CONFIG_RT_SPIN_LOCK_TRACING
+	trace_rt_spinlock_acquired(&lock->dep_map, current);
+#endif
 }
 EXPORT_SYMBOL(rt_spin_lock);
 
@@ -1169,6 +1176,9 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 {
 	/* NOTE: we always pass in '1' for nested, for simplicity */
 	spin_release(&lock->dep_map, 1, _RET_IP_);
+#ifdef CONFIG_RT_SPIN_LOCK_TRACING
+	trace_rt_spinlock_released(&lock->dep_map, current);
+#endif
 	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
 	migrate_enable();
 	rcu_read_unlock();
-- 
2.25.1

