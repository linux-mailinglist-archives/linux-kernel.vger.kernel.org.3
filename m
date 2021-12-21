Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AB247C484
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbhLURBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35756 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbhLURBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B191B817CC;
        Tue, 21 Dec 2021 17:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D3CC36AEA;
        Tue, 21 Dec 2021 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640106100;
        bh=yebEHrXO3xitrmPY1eiCj8/ZZmBcRpO1kVVqCIUFCmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVZs0brlicBeWTJT6gUoU+0VOX9gAZ1AaW+R7u29v8MChfsAAZ3n5+IwWbugSO6H+
         /Rjk+nONgaTYZyeF/JvoV0kLHWyupDaNTnHSRgDH3ds8LLKOZbR+MzQSPvgUQZ/xRg
         GAdVS+eSR9bBsQMgJJwgZuvSSRGLTZ8P0fa5gxa1k+3FRa1X7qSSVS3NSVmbZh6WTE
         BUUeBfzRDBVoUac59kIPNLbSU87LzcWMwQLutIw9I85D0mUa3CLqiw+/yI9QxFuQ5w
         g3ip6oo/gDqNGG9xSDLIG93lSBwga8tqITI+VYAtVYnCnY0RaQNRTaIAN9PWY2G2I/
         8+0EqwaqjbWaA==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 7/8] sched: arm64: Remove unused TASK_SIZE_OF
Date:   Wed, 22 Dec 2021 01:00:56 +0800
Message-Id: <20211221170057.2637763-8-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221170057.2637763-1-guoren@kernel.org>
References: <20211221170057.2637763-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux sched, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/arm64/include/asm/processor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 6f41b65f9962..d24dfb49237d 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -65,8 +65,6 @@
 #endif /* CONFIG_ARM64_64K_PAGES */
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
-#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
-				TASK_SIZE_32 : TASK_SIZE_64)
 #define DEFAULT_MAP_WINDOW	(test_thread_flag(TIF_32BIT) ? \
 				TASK_SIZE_32 : DEFAULT_MAP_WINDOW_64)
 #else
-- 
2.25.1

