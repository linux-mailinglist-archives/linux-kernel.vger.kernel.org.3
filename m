Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5950B503
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446576AbiDVKar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446553AbiDVKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:30:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E230554F85;
        Fri, 22 Apr 2022 03:27:47 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdLwJ1s4Z6sv7P6flJE71kfu/zcl+wkUS5qxgyZ4iy4=;
        b=ImOVTE/onIMRXCaUQWIzzBxl7nz1rDtqcW94ELjfgY0g/kH7IcS1EnUxY0XSUBUVKg9aVg
        8TF8Qg8S6noXR1nW3undCZXpTOe8gQcyxyTIejSG7lG8maEukVfzHpVmfII/oUhgcFWHtb
        musi2qrIiII/vUVBG+/QsDH6FNpl4MVR09a1qpyfE/EeGeUzIIpBEmYbb8cntwqe+jw3iV
        EFFPrIAXA6FBY5rWksUhGxSdPqxoI5f2riYRrPM8GQNXtSJUCQKRhxCvl4AajwEV8pg0Is
        I2lWPpNdjRqWRdugpw5KGUOmpM9/AWjknIJmdn3TiDR+FvD+gwStE5tJqXOYeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdLwJ1s4Z6sv7P6flJE71kfu/zcl+wkUS5qxgyZ4iy4=;
        b=AcEx5LxLnr7FLAk6brx0L2wHvqW0sjxZ8ipZ/C0DCj9SMNGzvvvEVd9ZR0yDKDDVJrIrsa
        EeA5iY/iPCICbsBw==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] MAINTAINERS: Add myself as scheduler topology reviewer
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220406141315.732473-2-vschneid@redhat.com>
References: <20220406141315.732473-2-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <165062326556.4207.11007025965816510116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c9ca1762b25310beff332f882e20d1cf39bfaae5
Gitweb:        https://git.kernel.org/tip/c9ca1762b25310beff332f882e20d1cf39bfaae5
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Wed, 06 Apr 2022 15:13:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:14:07 +02:00

MAINTAINERS: Add myself as scheduler topology reviewer

I've messed around the NUMA/debug bits of the scheduler toplogy in my
time at Arm, and even though I've changed ships I still intend to at the
very least review those bits.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220406141315.732473-2-vschneid@redhat.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d4..74b739a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17508,6 +17508,7 @@ R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
 R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
 R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
 R:	Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
+R:	Valentin Schneider <vschneid@redhat.com> (TOPOLOGY)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
