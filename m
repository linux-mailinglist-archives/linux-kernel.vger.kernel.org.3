Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315454D9655
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346074AbiCOIcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345972AbiCOIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBDF4C796;
        Tue, 15 Mar 2022 01:31:03 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:31:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aKWaJYMTc/623myU+KURQzqwjMOmiEsuzUmT54Gvioc=;
        b=UqFA6GVss1bnglhw7gwHHDrQkKyEItlK0FHHLm5dLO7OEhPlrE1jnQz3j+Ur6y61bPVeCD
        oaBnyuoMJHJzWF5VaHj6L/SQeBOlp7162dTBQ0L7ELGgW3zV068w/I+rk2/Ya6GPWYDN0D
        0z7pl+45SjqmPvtt6fqIZP2MzqDzND5O5W8zaXOZerJrezVOQeaF4gKp02LgHQ2R4CVoso
        8EM2lSwiJgdH14KfWPIH/EsTqh1jOBbMTbgGS9G58iPE5FJiNGrEWJI1mcPspX/Z5xO4YG
        DDRW8MrLayk5wnREz3xlC6lg4wIxiQUiuPaKyiCJrB8N8MfdzfvjTVrFK9IoSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aKWaJYMTc/623myU+KURQzqwjMOmiEsuzUmT54Gvioc=;
        b=F6aYsZ0h/l24KD+VM5ILrTmTT184q/MkIFUB0MGo350uq4qCIx8c3gVbmU9JY5FhMY3rN2
        cougYwyBR86K3wBA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Make the <linux/sched/deadline.h>
 header build standalone
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733306097.16921.10533397616716314087.tip-bot2@tip-bot2>
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

Commit-ID:     fbed5664b73830dcb1a19af4f7f1f1b424f54609
Gitweb:        https://git.kernel.org/tip/fbed5664b73830dcb1a19af4f7f1f1b424f54609
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 22 Feb 2022 13:28:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:33 +01:00

sched/headers: Make the <linux/sched/deadline.h> header build standalone

This header depends on various scheduler definitions.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/sched/deadline.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 1aff00b..7c83d4d 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -6,6 +6,8 @@
  * NORMAL/BATCH tasks.
  */
 
+#include <linux/sched.h>
+
 #define MAX_DL_PRIO		0
 
 static inline int dl_prio(int prio)
