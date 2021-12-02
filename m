Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB18465A96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354251AbhLBAW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354149AbhLBAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4B8C061748;
        Wed,  1 Dec 2021 16:19:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AE4FB82199;
        Thu,  2 Dec 2021 00:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAD3C53FCC;
        Thu,  2 Dec 2021 00:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404347;
        bh=MVGE7AB+O9btxcTp2REeyOO6iGU+ax0Ts0rM26H3Zi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkgYSeFwrGyXajiQBpVa/6oCyLvC4mpp5CXkw17xd/+vwy7hXXKxAAMKoxCeADP0B
         BtXIiMxGC/6L3U6bjxvc/wqjweMA+8gdjA1In0xfX46CkZP6m+7k0iZ0AUt6VLDZ20
         1By5rnUHRav8/h7qRXEYyn9pIp/X8AAruqAhE3isdrhYoAoy5PAGCuEV3HjX6L1+fc
         LPqm6eNyOX0H5B6UMPObT3PVleoBvePJm9m45SQMQEl0Pl189R2daeo/VOFO5mALre
         t7RjqKbQnyR/vAR5ISSqNzPI3hRKFCerKV5+HPHXSisynqjf6BC5hNtfN2IoWfGFB4
         TsRi2+fvZfe9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C548E5C1108; Wed,  1 Dec 2021 16:19:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/4] torture: Remove RCU_FAST_NO_HZ from rcu scenarios
Date:   Wed,  1 Dec 2021 16:19:02 -0800
Message-Id: <20211202001904.3126929-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001838.GA3126627@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001838.GA3126627@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the rcu scenarios that mentioning CONFIG_RCU_FAST_NO_HZ disable it.
But this Kconfig option is disabled by default, so this commit removes
the pointless "CONFIG_RCU_FAST_NO_HZ=n" lines from these scenarios.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE02 | 1 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE05 | 1 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE06 | 1 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE07 | 1 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE08 | 1 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE10 | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE02 b/tools/testing/selftests/rcutorture/configs/rcu/TREE02
index 65daee4fbf5a3..2871ee599891d 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE02
@@ -7,7 +7,6 @@ CONFIG_PREEMPT=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_TRACE=n
 CONFIG_RCU_FANOUT=3
 CONFIG_RCU_FANOUT_LEAF=3
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
index 4f95f8544f3f0..9f48c73709ec3 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
@@ -7,7 +7,6 @@ CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_TRACE=n
 CONFIG_HOTPLUG_CPU=y
 CONFIG_RCU_FANOUT=6
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE06 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
index bf4980d606b50..db27651de04b8 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
@@ -7,7 +7,6 @@ CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_TRACE=n
 CONFIG_RCU_FANOUT=6
 CONFIG_RCU_FANOUT_LEAF=6
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
index d7afb271a586d..2789b47e4ecd7 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
@@ -7,7 +7,6 @@ CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_TRACE=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_RCU_FANOUT=2
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08 b/tools/testing/selftests/rcutorture/configs/rcu/TREE08
index c810c5276a89f..8b561355b9ef2 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE08
@@ -7,7 +7,6 @@ CONFIG_PREEMPT=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_TRACE=n
 CONFIG_RCU_FANOUT=3
 CONFIG_RCU_FANOUT_LEAF=2
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index 7311f84a58765..4a00539bfdd71 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -7,7 +7,6 @@ CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_TRACE=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
-- 
2.31.1.189.g2e36527f23

