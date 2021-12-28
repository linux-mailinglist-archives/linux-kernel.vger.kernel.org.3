Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B66D4806C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhL1Gr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:47:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57534 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhL1Grw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:47:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7271660AB8;
        Tue, 28 Dec 2021 06:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95101C36AEE;
        Tue, 28 Dec 2021 06:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640674071;
        bh=uPB7J7h9eg9SMZZo4XkkjoKoeN0EchgiiAHbdDTiKAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMbdfyeU0s5yO/32w9ESSYret/UcZzPh4hb3s7i0EvJif93cUDh6t1WMXYTYLTotY
         wXcJC16VrXNPW9iWapcm7ief8sawblI0e4v3ru+HV3g/HCGSXttTFcdy79J6I83UYd
         z6/+Zd+Gp+RwduQBFlSIdZHMw71nWu2diezGkoiU2xQgBPc7Ksd4hqGtwjeAYdbP+n
         NXbKUNb5JgENHMSeXdnchCUcInvZNY+XNsHL1753qgrYhGjUJRShN4pcHnWc0zxvQR
         58HOaocTHFa1udEdnNkzarjo3mwCKjaFZvkkvN569+TTw1A2vsGKIf5q62Bp4eU09K
         iQl7xaSyiCPTg==
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
Subject: [PATCH V3 2/8] sched: x86: Remove unused TASK_SIZE_OF
Date:   Tue, 28 Dec 2021 14:47:23 +0800
Message-Id: <20211228064730.2882351-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228064730.2882351-1-guoren@kernel.org>
References: <20211228064730.2882351-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/page_64_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index e9e2c3ba5923..6191cf417c31 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -74,8 +74,6 @@
 					IA32_PAGE_OFFSET : DEFAULT_MAP_WINDOW)
 #define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
 					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
-#define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_ADDR32)) ? \
-					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
 
 #define STACK_TOP		TASK_SIZE_LOW
 #define STACK_TOP_MAX		TASK_SIZE_MAX
-- 
2.25.1

