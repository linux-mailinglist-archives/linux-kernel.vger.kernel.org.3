Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB95432DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242041AbiFHOms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242082AbiFHOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:42:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592181B9F9B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE09CB827F0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9E2C385A5;
        Wed,  8 Jun 2022 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654699317;
        bh=2CBAllI1hzeZcnfVP9eQWZJba0Jxs5p3K1LdbrCyRPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3sl6dyKIs1uyuJUT5VLXMVBt8f2dwlCdodC1ae8/F06cmGg1XkiDGsQSXIU5RQDy
         9yJWtpDL3Q8lzvp2HgfER9OO5tmNCQEF3kVGpz0o67q61z4r17uZyI1NqtXv5jMEjn
         9Oo4zg9FYHvU1HMbm44WNmdnENwSWO3NMO5GMeUCsoYKkjESBNAwhdv33Cl8n71EbF
         LVI1n3DpKrVO3Xuu9Vk2zpbRzCU4RtOaA7qQWYFERMprjREFhugvnQt8S14bDN2VIK
         aDLjaCpmrRqavEKb62QCBGsbxdnsXC3sP8e9cYLMkm106ml7ks82N2RsOXrRK7M+pj
         D5gUGUvcCfAIg==
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
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 20/20] MAINTAINERS: Add Paul as context tracking maintainer
Date:   Wed,  8 Jun 2022 16:40:37 +0200
Message-Id: <20220608144037.1765000-21-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608144037.1765000-1-frederic@kernel.org>
References: <20220608144037.1765000-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index d50bc66f2b1c..4c5655c612e3 100644
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

