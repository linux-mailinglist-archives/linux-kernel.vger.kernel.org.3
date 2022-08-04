Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92CB5899B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiHDJJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiHDJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:09:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265B42BB01;
        Thu,  4 Aug 2022 02:09:55 -0700 (PDT)
Date:   Thu, 04 Aug 2022 09:09:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659604192;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5znzIH5NljT5APUouLc8bxPp/gvEn0y7XTQtpyiiqQ=;
        b=2SJFfENmx5D4ZYYXB3E95KyJmI4wnwHQKg3ywA51+Y+EyJ7gHs9+QzKaQYlWehp+Pdy3O6
        Es/mOaXjQlRrGWh4JZ1sewlthCGS1D+dNEYHrVkQuK0vTcBYNliCRXWMfz2VyZp5nvnPWp
        mDha7JIylJS1dd/zSUkcvz2UMyqV0UgsBVmK4eMTMaG6qbH0bLZWfUxHnH8M8wdpxsyucz
        2DunSI/EXUT6avGgT92M09XCn5SSNrtwNpXQ3fboNM4o+8oT4emV/QF450quSIDKvhDHqh
        X+h7Jxgo4Ny0nFY/XKoMYQvVqrasjX0+seJCV+kb/vbCDnDV643J3FyA787etg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659604192;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5znzIH5NljT5APUouLc8bxPp/gvEn0y7XTQtpyiiqQ=;
        b=ck3OjAL8FdwSfV5LTs4CurCQRUOCbKXjrXpcgDClspWcNx+U45HqwXst50/LfHLKNrZwCi
        2DCKZPl0ou8TDgBg==
From:   "tip-bot2 for Slark Xiao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix ';;' typo
Cc:     Slark Xiao <slark_xiao@163.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220720091220.14200-1-slark_xiao@163.com>
References: <20220720091220.14200-1-slark_xiao@163.com>
MIME-Version: 1.0
Message-ID: <165960419118.15455.15553677582415200869.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     99643bab36b642be10bf09cd3285c37c9e5b597f
Gitweb:        https://git.kernel.org/tip/99643bab36b642be10bf09cd3285c37c9e5b597f
Author:        Slark Xiao <slark_xiao@163.com>
AuthorDate:    Wed, 20 Jul 2022 17:12:20 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Aug 2022 11:01:30 +02:00

perf/core: Fix ';;' typo

Remove double ';;'.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220720091220.14200-1-slark_xiao@163.com
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9d32d4..bd23f3e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4457,7 +4457,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 
 	*value = local64_read(&event->count);
 	if (enabled || running) {
-		u64 __enabled, __running, __now;;
+		u64 __enabled, __running, __now;
 
 		calc_timer_values(event, &__now, &__enabled, &__running);
 		if (enabled)
