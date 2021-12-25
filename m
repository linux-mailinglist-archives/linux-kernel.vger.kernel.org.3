Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A533147F1EC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 05:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhLYEzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 23:55:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57884 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhLYEzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 23:55:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A700760C72;
        Sat, 25 Dec 2021 04:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E70C36AE9;
        Sat, 25 Dec 2021 04:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640408120;
        bh=/ayHgJ9Axaat4L3UafkBublWKpTSwuiZsiIJQA7SVTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byeyQgL088RHuUcoteZf8L1ftXXDT+rEgYXOYcA9ZD/xnPU8llyVA9Spx4jNnhKV9
         1j8/b4N4OF5K4MEyDLo4JZrgpgZwCrpCEHf77O5Jt+WgsbQTdRNXrGoWkMdvjwGkS7
         dFf1Q3J4KF8IiCwFlI/tcbUh84kmgSYJcJ8msqLGSwxvsxUXFPExXhLibL0k3780Ws
         9zclAaC1i7ObWRlUadIJl6kQ1V7zUHfbCJ9XnPg/nvmr8Q/ySuM44PsGyR+9KogkJC
         VKJlXkHVlsr39N16scz8vn+zGoeoUF+EpVZN5q3Ch9IfsH/Gtll2/mOjQG84wHdppU
         GLFFv7zo6QtxA==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 6/8] sched: parisc: Remove unused TASK_SIZE_OF
Date:   Sat, 25 Dec 2021 12:54:28 +0800
Message-Id: <20211225045430.2868608-7-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211225045430.2868608-1-guoren@kernel.org>
References: <20211225045430.2868608-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux sched, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/include/asm/processor.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index b669f4b9040b..d9c8dc76ee6a 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -23,8 +23,7 @@
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
-#define TASK_SIZE_OF(tsk)       ((tsk)->thread.task_size)
-#define TASK_SIZE	        TASK_SIZE_OF(current)
+#define TASK_SIZE               (current->thread.task_size)
 #define TASK_UNMAPPED_BASE      (current->thread.map_base)
 
 #define DEFAULT_TASK_SIZE32	(0xFFF00000UL)
-- 
2.25.1

