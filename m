Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596F052D6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiESPCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbiESPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F60E7300
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F10561A1D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B7FC34115;
        Thu, 19 May 2022 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652972390;
        bh=ddzGRm7JX3F67ItyMSLyaPVv+VW8YYPPatfE5jt1lwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGW14lSJ+N+tG9A9NVIiasj2JjC8Z2PFG4apjpQYXU/tSllX3zGzJyhPI8aG6hQKW
         7ONS1b0d4OvETduAEJqpkXg2kdN2M+0jBMgsEpGirVDm2pZKZohFweWyu4WOltqsQ/
         63m8FTSSlF9VOhoHAKZylv231m0cTFPt+1mkcWSA2C60BZR1doI96Yz3S1xiMwEu8b
         jfZo9e4Iu0MEX/Flsd6es4tOnaz0EF2YMIcabxaH+8IQhGrdufYE4D44h+hEQxubuj
         l4bBJX9p7TITq76BtcrjPl09CdN4XGOCCb3F8ocogidfe7Gx1gpfFf2r9+pfPNDmze
         wdKmgPqlQzhsw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 21/21] MAINTAINERS: Add Paul as context tracking maintainer
Date:   Thu, 19 May 2022 16:58:23 +0200
Message-Id: <20220519145823.618983-22-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519145823.618983-1-frederic@kernel.org>
References: <20220519145823.618983-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 MAINTAINERS               |  1 +
 kernel/context_tracking.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..f49d9e6790d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4976,6 +4976,7 @@ F:	include/linux/console*
 
 CONTEXT TRACKING
 M:	Frederic Weisbecker <frederic@kernel.org>
+M:	"Paul E. McKenney" <paulmck@kernel.org>
 S:	Maintained
 F:	kernel/context_tracking.c
 F:	include/linux/context_tracking*
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 05723ba8bbf0..c7f17c4976be 100644
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

