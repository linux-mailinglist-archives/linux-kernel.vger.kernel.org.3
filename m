Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB24A465B3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhLBAsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354668AbhLBArF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83512C061759;
        Wed,  1 Dec 2021 16:43:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1679CE207F;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C31C58321;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=rwVqvi1IWwEdfk1wEd0A2iHdrVb4tYgODH0yAL0CndA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKuivoJ83rkIOGZ+wf+xcRRTUiTV6XpgQfuEXpQjYdoT6LRqMVTF2CKJ7II/1fo7S
         Byd7CaK7uvVjI2XYZDCTqXeIMuBxTW3+j7RLkpZJx+DUtOHBp/h3A7Kqa8XjhYFssd
         Np1GeY2GQ1kM7z2UdzPhiAh+aw49sPhgYIGDHJV14D0h4xcGyMEcLJHC79i2TowN3w
         tvwjr2bQlTdGPKobfEjP/xstK1UJRCGRDf/xpeqlOVejX66bP7DiVm8PWVDLxKjMM1
         pkI0Eox7yphWZM8h6krHiggcO8M5ZNm7YO4yGXnj0NVX1AI9A28nUS1an3liuBoH/1
         6qDJqUMP013dA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5778C5C12AB; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Li Zhijian <zhijianx.li@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/17] scftorture: Remove unused SCFTORTOUT
Date:   Wed,  1 Dec 2021 16:43:28 -0800
Message-Id: <20211202004337.3130175-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhijian <zhijianx.li@intel.com>

There are no longer any users of SCFTORTOUT(), so this commit removes it.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 9cff573b7eb4f..a0df767897a1d 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -38,9 +38,6 @@
 #define SCFTORT_STRING "scftorture"
 #define SCFTORT_FLAG SCFTORT_STRING ": "
 
-#define SCFTORTOUT(s, x...) \
-	pr_alert(SCFTORT_FLAG s, ## x)
-
 #define VERBOSE_SCFTORTOUT(s, x...) \
 	do { if (verbose) pr_alert(SCFTORT_FLAG s "\n", ## x); } while (0)
 
-- 
2.31.1.189.g2e36527f23

