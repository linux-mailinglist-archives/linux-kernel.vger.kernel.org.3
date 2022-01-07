Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37BA48753C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346659AbiAGKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:09:22 -0500
Received: from m12-11.163.com ([220.181.12.11]:49580 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237222AbiAGKJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:09:21 -0500
X-Greylist: delayed 928 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jan 2022 05:09:21 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=cAJRB
        WLVXfOlDru6AkIoYBjDCDtk/jCLZ4RnYSQzyYI=; b=JlWRHNNu5a9MrbzrKXg5O
        RKhmInUlHQPydWNOy2JGIWTytNfL7reeDo+ESSRk6PdEvRrLK4kexIDY2bcgIZ0A
        wmZhxIZqqCpjGD+3Mxv+2ImdSvBJQXM288+qcfOGFADpIwS9FZXoM/M2BdwxUXtS
        sK4VpjSr0fV5IjHn6NFHsg=
Received: from localhost (unknown [49.235.41.28])
        by smtp7 (Coremail) with SMTP id C8CowAC33992DdhhTxahOw--.13964S2;
        Fri, 07 Jan 2022 17:52:55 +0800 (CST)
Date:   Fri, 7 Jan 2022 17:52:54 +0800
From:   Hui Su <suhui_kernel@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/sched: remove dl_boosted flag comment
Message-ID: <20220107095254.GA49258@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: C8CowAC33992DdhhTxahOw--.13964S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4DKFWkAry7uF47tFWfAFb_yoW3KFX_ua
        95Kr18Cw4xXrZ2va4IkF10qF1ag3W8tFnxZ3Wvgr9rXr4DAFs8GwnrGFWqyw1xG392yF9x
        W3Z5tF1kZwn8KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjkR67UUUUU==
X-Originating-IP: [49.235.41.28]
X-CM-SenderInfo: 5vxk3xhbnh20lho6il2tof0z/1tbiMxeBbVXl-wN9CwAAsy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since commit 2279f540ea7d ("sched/deadline: Fix priority
inheritance with multiple scheduling classes"), we should not
keep it here.

Signed-off-by: Hui Su <suhui_kernel@163.com>
---
 include/linux/sched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..64426351d424 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -610,10 +610,6 @@ struct sched_dl_entity {
 	 * task has to wait for a replenishment to be performed at the
 	 * next firing of dl_timer.
 	 *
-	 * @dl_boosted tells if we are boosted due to DI. If so we are
-	 * outside bandwidth enforcement mechanism (but only until we
-	 * exit the critical section);
-	 *
 	 * @dl_yielded tells if task gave up the CPU before consuming
 	 * all its available runtime during the last job.
 	 *
-- 
2.25.1

