Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328414D877B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbiCNOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiCNOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:55:08 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CA3377F5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 07:53:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 17so20172261lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9bIfkplOutFYaWeLdLUALKRF5qrlW7wQAPZL71jBcPM=;
        b=F0c0KaG6f5abypfTP/M0sYlybmoG0dxaeEL3Y1aA8Z7mNuKO9gw/sK9nVcqbjCt6ry
         a/bTET5mPjHIpN14Y96QHg7kwCn3Ngt2FiswaiCDhXJ/SFDbuxwvzPCY4gMmPQptG9Yi
         Z2y+nS1WWB8CH0YwImUEEishrw0ImTWmorxmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9bIfkplOutFYaWeLdLUALKRF5qrlW7wQAPZL71jBcPM=;
        b=JXjW7g6Hy5jZSgnbaLHtw3oNThoT1hVpuWqYQrD/FjDMGf3kYbNKehuyZj7uUZuOEb
         oxmF94MAr11/i9NCR4iAJPbFwZri7PeHZw5p4F7rwTTfdal5noM75Uv4auAmFsuuoBZv
         coubwqhWPRsfFIjwzXB2I6gDL2B0e+UOIcOYCucDhB9Y+M0yuBT05H0X1SDztlOKkD+W
         Om+1im7IiQN7isw674ReE/5c44IaGIdBcGpTFEh5wf08GY8vxJsH97Az9MOiAFBZZLt5
         jvs3i6wdFIYQH2Q6kiEFubqXTX5zNv99cogRok7KRZ+3fqpIcydVFx/0vIrq7COyBbKO
         GCJA==
X-Gm-Message-State: AOAM530TYxrcKKPN1V7mCcALbvoVmFv2auiSVeEB51D0KQms/m0QPVU8
        nn5t6tsvlwCaJJshDnJoi+ppOiqBccwX1vZB
X-Google-Smtp-Source: ABdhPJxRHtElFuGgGiqrBSA6oPEoayRvTcBBGIOq8V0G+ogEe/+BhnBpskGHN29Nwnu2vtXTQSFKQA==
X-Received: by 2002:a2e:b617:0:b0:247:e9bb:2228 with SMTP id r23-20020a2eb617000000b00247e9bb2228mr14761338ljn.129.1647269626945;
        Mon, 14 Mar 2022 07:53:46 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05651c0b8b00b00247feb5841bsm4020168ljb.86.2022.03.14.07.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 07:53:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Cai Huoqing <caihuoqing@baidu.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] linux/kthread.h: remove unused macros
Date:   Mon, 14 Mar 2022 15:53:42 +0100
Message-Id: <20220314145343.494694-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since these macros were introduced in commit b56c0d8937e6
("kthread: implement kthread_worker"), there has been precisely one
user (commit 4d115420707a, "NVMe: Async IO queue deletion"), and that
user went away in 2016 with db3cbfff5bcc ("NVMe: IO queue deletion
re-write").

Apart from being unused, these macros are also awkward to use (which
may contribute to them not being used): Having a way to statically (or
on-stack) allocating the storage for the struct kthread_worker itself
doesn't help much, since obviously one needs to have some code for
actually _spawning_ the worker thread, which must have error
checking. And these days we have the kthread_create_worker() interface
which both allocates the struct kthread_worker and spawns the kthread.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/kthread.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 3df4ea04716f..de5d75bafd66 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -141,12 +141,6 @@ struct kthread_delayed_work {
 	struct timer_list timer;
 };
 
-#define KTHREAD_WORKER_INIT(worker)	{				\
-	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
-	.work_list = LIST_HEAD_INIT((worker).work_list),		\
-	.delayed_work_list = LIST_HEAD_INIT((worker).delayed_work_list),\
-	}
-
 #define KTHREAD_WORK_INIT(work, fn)	{				\
 	.node = LIST_HEAD_INIT((work).node),				\
 	.func = (fn),							\
@@ -158,9 +152,6 @@ struct kthread_delayed_work {
 				     TIMER_IRQSAFE),			\
 	}
 
-#define DEFINE_KTHREAD_WORKER(worker)					\
-	struct kthread_worker worker = KTHREAD_WORKER_INIT(worker)
-
 #define DEFINE_KTHREAD_WORK(work, fn)					\
 	struct kthread_work work = KTHREAD_WORK_INIT(work, fn)
 
@@ -168,19 +159,6 @@ struct kthread_delayed_work {
 	struct kthread_delayed_work dwork =				\
 		KTHREAD_DELAYED_WORK_INIT(dwork, fn)
 
-/*
- * kthread_worker.lock needs its own lockdep class key when defined on
- * stack with lockdep enabled.  Use the following macros in such cases.
- */
-#ifdef CONFIG_LOCKDEP
-# define KTHREAD_WORKER_INIT_ONSTACK(worker)				\
-	({ kthread_init_worker(&worker); worker; })
-# define DEFINE_KTHREAD_WORKER_ONSTACK(worker)				\
-	struct kthread_worker worker = KTHREAD_WORKER_INIT_ONSTACK(worker)
-#else
-# define DEFINE_KTHREAD_WORKER_ONSTACK(worker) DEFINE_KTHREAD_WORKER(worker)
-#endif
-
 extern void __kthread_init_worker(struct kthread_worker *worker,
 			const char *name, struct lock_class_key *key);
 
-- 
2.31.1

