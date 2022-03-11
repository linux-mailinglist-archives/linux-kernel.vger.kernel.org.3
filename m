Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9296F4D63F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349697AbiCKOmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349728AbiCKOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:42:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF071AAA74;
        Fri, 11 Mar 2022 06:40:51 -0800 (PST)
Date:   Fri, 11 Mar 2022 14:40:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647009636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bq7jXPjH2+/y4/vaCcgbMOclnKGE2wW5g01S7r6BW64=;
        b=ayjuyhu/VpJ3TZcdP6LIwIrI+AFqGWtt5B8FHcm5hxm7DqQLdWVUOTgD1tT1J1nUV1acFU
        8PQiWmkoLXeCYR+wpyL0uLPjxp3ThUsayLTIc5C1ZSzAP17QvpQ4ucbRfkViL0NVd2a883
        MKEhjwNxRTLfznmTgTEwVGHvmOoK2DtRTO+9ljW4qJKZgrhp/pgx4aSZwPHZQEMPwOYrZ0
        0zFvHLtNXaJoUTvNO4wvIwj2HpwQS0Auo3HEzHDYsx3W8Gs3aYnA/YKuP+rOmx8UawEJLf
        DzrCsiOkJ2HUMgacd1peX6TfZ+F/JSundqYa6OdjyRvagqND+RGABmuO0tcQVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647009636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bq7jXPjH2+/y4/vaCcgbMOclnKGE2wW5g01S7r6BW64=;
        b=vmwBhKQOPIpnC4o7GxW8wQbqR1f50jt2THhRkRE5YAzboNcTXgQ+mcsKGoN2N/K698ZBuA
        pT4Bh1ujiwktn5BQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/preempt: Tell about PREEMPT_DYNAMIC on kernel headers
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220217111240.GA742892@lothringen>
References: <20220217111240.GA742892@lothringen>
MIME-Version: 1.0
Message-ID: <164700963517.16921.5629732002889775470.tip-bot2@tip-bot2>
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

Commit-ID:     a0a7e453b502cbbf7ff372f907a4e27a2ebf5445
Gitweb:        https://git.kernel.org/tip/a0a7e453b502cbbf7ff372f907a4e27a2ebf5445
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 17 Feb 2022 12:12:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Mar 2022 15:36:35 +01:00

sched/preempt: Tell about PREEMPT_DYNAMIC on kernel headers

Displaying "PREEMPT" on kernel headers when CONFIG_PREEMPT_DYNAMIC=y
can be misleading for anybody involved in remote debugging because it
is then not guaranteed that there is an actual preemption behaviour. It
depends on default Kconfig or boot defined choices.

Therefore, tell about PREEMPT_DYNAMIC on static kernel headers and leave
the search for the actual preemption behaviour to browsing dmesg.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220217111240.GA742892@lothringen
---
 init/Makefile       |  3 ++-
 scripts/mkcompile_h | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/init/Makefile b/init/Makefile
index 06326e3..d82623d 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -31,7 +31,8 @@ quiet_cmd_compile.h = CHK     $@
       cmd_compile.h = \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
 	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"	\
-	"$(CONFIG_PREEMPT_RT)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
+	"$(CONFIG_PREEMPT_DYNAMIC)" "$(CONFIG_PREEMPT_RT)" \
+	"$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
 
 include/generated/compile.h: FORCE
 	$(call cmd,compile.h)
diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index 6a2a04d..ca40a52 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -5,9 +5,10 @@ TARGET=$1
 ARCH=$2
 SMP=$3
 PREEMPT=$4
-PREEMPT_RT=$5
-CC_VERSION="$6"
-LD=$7
+PREEMPT_DYNAMIC=$5
+PREEMPT_RT=$6
+CC_VERSION="$7"
+LD=$8
 
 # Do not expand names
 set -f
@@ -41,8 +42,14 @@ fi
 UTS_VERSION="#$VERSION"
 CONFIG_FLAGS=""
 if [ -n "$SMP" ] ; then CONFIG_FLAGS="SMP"; fi
-if [ -n "$PREEMPT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"; fi
-if [ -n "$PREEMPT_RT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT"; fi
+
+if [ -n "$PREEMPT_RT" ] ; then
+	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT"
+elif [ -n "$PREEMPT_DYNAMIC" ] ; then
+	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_DYNAMIC"
+elif [ -n "$PREEMPT" ] ; then
+	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"
+fi
 
 # Truncate to maximum length
 UTS_LEN=64
