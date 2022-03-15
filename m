Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1404C4D965D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346002AbiCOIcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345937AbiCOIcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01CF4C41F;
        Tue, 15 Mar 2022 01:30:57 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:30:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rhBDEPMliXhAL8AF/RSs7wOZyFRx06mUvqmt8tarwXU=;
        b=nkaHgOSHfB1skLi+872FhqlmxIGCbEhoRZoYnD2VZuRJ5m476i7XAyDyTQiPySdRkwmRfq
        4I2nEZO9wVYdHGRQBkJ8oAykGai2UbEhw209huUlvcJbEBS0mQkB5C0XeODjMh7GwFiCmh
        4/1YaTC5rKqsp02a7ZMWX2Wp424jl6NPacIAMIdRoXt7N11xtEy2691R5H1i9AQhTr+BWE
        un6QzuMARIW82cV5USozJ+a3HxtnWzxXbUlah0GpMU/pTnyNbRLjGTH4lVRxipM4LPaS6I
        h7dM1gU+YUL4O2hLGbgSYsjW6WREEtRbP0cKZw2C5u3haqKR84mwPaAwXSqRhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rhBDEPMliXhAL8AF/RSs7wOZyFRx06mUvqmt8tarwXU=;
        b=6lBrWOleZZQ6qouQtm9kVlLvcpA26lRn5Z23xxa1F7pNXeZFlrL1H/+2ABgdULrAgEBSRQ
        3MktHtUkQs88ofBQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Reorganize, clean up and optimize
 kernel/sched/fair.c dependencies
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733305548.16921.12780434654364941164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c4ad6fcb67c42d65481c85733c8009c8afdfdf4e
Gitweb:        https://git.kernel.org/tip/c4ad6fcb67c42d65481c85733c8009c8afdfdf4e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 22 Feb 2022 13:50:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:33 +01:00

sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies

Use all generic headers from kernel/sched/sched.h that are required
for it to build.

Sort the sections alphabetically.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/fair.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7391c92..89d21fd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -20,6 +20,35 @@
  *  Adaptive scheduling granularity, math enhancements by Peter Zijlstra
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
+#include <linux/energy_model.h>
+#include <linux/mmap_lock.h>
+#include <linux/hugetlb_inline.h>
+#include <linux/jiffies.h>
+#include <linux/mm_api.h>
+#include <linux/highmem.h>
+#include <linux/spinlock_api.h>
+#include <linux/cpumask_api.h>
+#include <linux/lockdep_api.h>
+#include <linux/softirq.h>
+#include <linux/refcount_api.h>
+#include <linux/topology.h>
+#include <linux/sched/clock.h>
+#include <linux/sched/cond_resched.h>
+#include <linux/sched/cputime.h>
+#include <linux/sched/isolation.h>
+
+#include <linux/cpuidle.h>
+#include <linux/interrupt.h>
+#include <linux/mempolicy.h>
+#include <linux/mutex_api.h>
+#include <linux/profile.h>
+#include <linux/psi.h>
+#include <linux/ratelimit.h>
+
+#include <asm/switch_to.h>
+
+#include <linux/sched/cond_resched.h>
+
 #include "sched.h"
 #include "stats.h"
 #include "autogroup.h"
