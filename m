Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32C54806D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhL1Gse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:48:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40684 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhL1Gsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:48:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26169B80DB5;
        Tue, 28 Dec 2021 06:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D17C36AEB;
        Tue, 28 Dec 2021 06:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640674108;
        bh=VNmoFKw8R9K2OcmjmelDhRhySWO6Ih0fBU/Aljv4crs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4P7PIVKeH9DRPDMaJHzgL9388gzhi6Jpx/12ZZaWUMeUmu0fZt7eygIyKX8iFEEp
         5V7Qm2P/0tUCPOllQQS5zGIKo1i9xBMYcEo0LwM4nRrc1GBp4jY0IknZCs8CW+b8aC
         +BWs1+cfSPC5J8+q7mLjVFtOZiazn965xbGrsrVnPhcbVr1Oo0pjsKAzECkfHZU1vW
         5oE6//VIWrFOJ7unJPtQolyyGtYFSHR++InYTtZ7ns6hf2rxEtLmmIRGM3fv3SKrIk
         WiGlzw3OZn26f4CGIp4O4kCTDg4moVXZYWKHXEQKA4j1miHCHincoRMHWP25QglKsk
         Oqsjqp5no8Bdg==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 8/8] sched: mips: Remove unused TASK_SIZE_OF
Date:   Tue, 28 Dec 2021 14:47:29 +0800
Message-Id: <20211228064730.2882351-9-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228064730.2882351-1-guoren@kernel.org>
References: <20211228064730.2882351-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux sched, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/processor.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 4bb24579d12e..8871fc5b0baa 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -61,9 +61,6 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
 #define STACK_TOP_MAX	TASK_SIZE64
 
-#define TASK_SIZE_OF(tsk)						\
-	(test_tsk_thread_flag(tsk, TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
-
 #define TASK_IS_32BIT_ADDR test_thread_flag(TIF_32BIT_ADDR)
 
 #endif
-- 
2.25.1

