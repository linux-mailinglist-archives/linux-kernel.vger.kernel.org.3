Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA9552800
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347110AbiFTXNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347093AbiFTXMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991E222AD;
        Mon, 20 Jun 2022 16:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB0261518;
        Mon, 20 Jun 2022 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E59C341F3;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=HKXI7a3s5VE0aI0E/MR38X8xReaE4DBkd248vFw4EvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBOlQ47nuvENrFskbYVGWLjaQifuDIznW2DH8k24/T0/2Cu/TU/NdPQ5SouFRgUuH
         Fy9WNqi0hk2FMMLM+p1ckNaN2PkZrJuqbQc0zgeN0o+AjrTZg2AMWx1/HyBH0kRA+o
         GyxGvWld8sSWE1jcM5nMVd8FMsFv2fWGJ6EgcgZd3oo4vuHmEBkTg9O9f5RyKBkGaN
         pMMOZVkiMcGl2wuVnDY82vTZprdO5gOtgVo0U4zmmMfaviI1Y7ucHxYHQaeIzslA63
         5CqGVJ93+boJgz4iITTarQQac6gVEHqY+MKg7xrSFy3jtwMLGaCc7uP2B6W0DqV3Mp
         MrtjPJvvLbIXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 782B35C1363; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>, Phil Auld <pauld@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alex Belits <abelits@marvell.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 22/23] MAINTAINERS: Add Paul as context tracking maintainer
Date:   Mon, 20 Jun 2022 16:10:28 -0700
Message-Id: <20220620231029.3844583-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Since most of the bits have been imported from kernel/rcu/tree.c and
now that the context tracking code is tightly linked to RCU, add Paul
as a context tracking maintainer.

Also update the context tracking file header accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 MAINTAINERS               |  1 +
 kernel/context_tracking.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf9842d9233c..4e38d7533cbe9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5039,6 +5039,7 @@ F:	include/linux/console*
 
 CONTEXT TRACKING
 M:	Frederic Weisbecker <frederic@kernel.org>
+M:	"Paul E. McKenney" <paulmck@kernel.org>
 S:	Maintained
 F:	kernel/context_tracking.c
 F:	include/linux/context_tracking*
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index d373fad7c0cba..1da44803fd319 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -1,18 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Context tracking: Probe on high level context boundaries such as kernel
- * and userspace. This includes syscalls and exceptions entry/exit.
+ * Context tracking: Probe on high level context boundaries such as kernel,
+ * userspace, guest or idle.
  *
  * This is used by RCU to remove its dependency on the timer tick while a CPU
- * runs in userspace.
+ * runs in idle, userspace or guest mode.
  *
- *  Started by Frederic Weisbecker:
+ * User/guest tracking started by Frederic Weisbecker:
  *
- * Copyright (C) 2012 Red Hat, Inc., Frederic Weisbecker <fweisbec@redhat.com>
+ * Copyright (C) 2012 Red Hat, Inc., Frederic Weisbecker
  *
  * Many thanks to Gilad Ben-Yossef, Paul McKenney, Ingo Molnar, Andrew Morton,
  * Steven Rostedt, Peter Zijlstra for suggestions and improvements.
  *
+ * RCU extended quiescent state bits imported from kernel/rcu/tree.c
+ * where the relevant authorship may be found.
  */
 
 #include <linux/context_tracking.h>
-- 
2.31.1.189.g2e36527f23

