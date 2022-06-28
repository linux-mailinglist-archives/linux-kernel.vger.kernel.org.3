Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6BF55E45A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbiF1NTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346359AbiF1NSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:18:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3640B33346
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3539B818E3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DEAC3411D;
        Tue, 28 Jun 2022 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422269;
        bh=jont00EkaQ2+5Y9NzfJgPCfThQpaLppjy0y/oXyUHb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ue7h68O2gI6OCbGwe25IQNtt8crYoif6VG2KgoyZVu/gukz73eMXY3VchUb9zqfPQ
         ZREOLVbk4M/OsDGa3P20TW+zjJPlkIvvNLF/kLX+3nqVNd/4CFnmW2tfpEADNRJ2Od
         ePsPMnRgjofdMORVJCblSPsFj6jj8ZlznrXvUcvl1GIIqXhtLO12h0n3HuHXhLNjJW
         8zSjt2LqZy+uhtGujueB108+h4HURvMAFC6V7um0Kx73EURicDj4yDj7nFLX4ovP6r
         R48uMQmjIZlSLW2/etdBi7Z4UAGrkxmmy1gmZbIt5LEbrIHORzBL3tThvWkBmgainp
         rmMW6vN7hRQ5g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marco Elver <elver@google.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 19/20] MAINTAINERS: Add Paul as context tracking maintainer
Date:   Tue, 28 Jun 2022 15:16:18 +0200
Message-Id: <20220628131619.2109651-20-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628131619.2109651-1-frederic@kernel.org>
References: <20220628131619.2109651-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 MAINTAINERS               |  1 +
 kernel/context_tracking.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf9842d9233..4e38d7533cbe 100644
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
index ca78ff27dc53..77978e372377 100644
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
2.25.1

