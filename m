Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FDC46199B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378655AbhK2OkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:40:05 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:59015 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379111AbhK2OiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:38:00 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J2nYG6sthz9sSp;
        Mon, 29 Nov 2021 15:19:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AKs2oUfo_INm; Mon, 29 Nov 2021 15:19:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J2nY40mKdz9sT5;
        Mon, 29 Nov 2021 15:19:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 085FA8B7B3;
        Mon, 29 Nov 2021 15:19:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id otA_zolaSl1s; Mon, 29 Nov 2021 15:19:35 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AE69B8B7B5;
        Mon, 29 Nov 2021 15:19:35 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1ATEJSCW959562
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 15:19:28 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1ATEJSqT959561;
        Mon, 29 Nov 2021 15:19:28 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: [PATCH v3 04/10] powerpc/mm: Remove asm/slice.h
Date:   Mon, 29 Nov 2021 15:19:18 +0100
Message-Id: <3f8ab2b28aff947a9b6d362d51ee5a89d97f0707.1638195388.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638195388.git.christophe.leroy@csgroup.eu>
References: <cover.1638195388.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638195562; l=4276; s=20211009; h=from:subject:message-id; bh=2aRzeye83rSinbLEp9frmuS7EvQlzWonE9gD0u0UBvo=; b=UkwvEq/8L/ZbFBrZC979woP0jpFtIbO0yQo+yH5IrNWW3ONnAYx3mNZtwBVI+YiBRv3K9MikhyTl bB1p/DG1DuBoemB6Iup99wWRSVYjrj7o93+Zt7wzo9r33UrUbLpZ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move necessary stuff in asm/book3s/64/slice.h and
remove asm/slice.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/64/hash.h     |  3 ++
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  1 +
 arch/powerpc/include/asm/book3s/64/slice.h    | 18 +++++++++
 arch/powerpc/include/asm/page.h               |  1 -
 arch/powerpc/include/asm/slice.h              | 37 -------------------
 5 files changed, 22 insertions(+), 38 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/slice.h

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 97f2fc217a49..fab032f552f3 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -100,6 +100,9 @@
  * hash table CPUs.
  */
 #ifdef CONFIG_PPC_64S_HASH_MMU
+#ifdef CONFIG_HUGETLB_PAGE
+#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#endif
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 3004f3323144..b4b2ca111f75 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -18,6 +18,7 @@
  * complete pgtable.h but only a portion of it.
  */
 #include <asm/book3s/64/pgtable.h>
+#include <asm/book3s/64/slice.h>
 #include <asm/task_size_64.h>
 #include <asm/cpu_has_feature.h>
 
diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index f0d3194ba41b..5b0f7105bc8b 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_SLICE_H
 #define _ASM_POWERPC_BOOK3S_64_SLICE_H
 
+#ifndef __ASSEMBLY__
+
 #define SLICE_LOW_SHIFT		28
 #define SLICE_LOW_TOP		(0x100000000ul)
 #define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
@@ -13,4 +15,20 @@
 
 #define SLB_ADDR_LIMIT_DEFAULT	DEFAULT_MAP_WINDOW_USER64
 
+struct mm_struct;
+
+unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
+				      unsigned long flags, unsigned int psize,
+				      int topdown);
+
+unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr);
+
+void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
+			   unsigned long len, unsigned int psize);
+
+void slice_init_new_context_exec(struct mm_struct *mm);
+void slice_setup_new_exec(void);
+
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_POWERPC_BOOK3S_64_SLICE_H */
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 254687258f42..62e0c6f12869 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -329,6 +329,5 @@ static inline unsigned long kaslr_offset(void)
 
 #include <asm-generic/memory_model.h>
 #endif /* __ASSEMBLY__ */
-#include <asm/slice.h>
 
 #endif /* _ASM_POWERPC_PAGE_H */
diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
deleted file mode 100644
index b15141f2bd76..000000000000
--- a/arch/powerpc/include/asm/slice.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_SLICE_H
-#define _ASM_POWERPC_SLICE_H
-
-#ifdef CONFIG_PPC_BOOK3S_64
-#include <asm/book3s/64/slice.h>
-#endif
-
-#ifndef __ASSEMBLY__
-
-struct mm_struct;
-
-#ifdef CONFIG_PPC_64S_HASH_MMU
-
-#ifdef CONFIG_HUGETLB_PAGE
-#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
-#endif
-#define HAVE_ARCH_UNMAPPED_AREA
-#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
-
-unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
-				      unsigned long flags, unsigned int psize,
-				      int topdown);
-
-unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr);
-
-void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
-			   unsigned long len, unsigned int psize);
-
-void slice_init_new_context_exec(struct mm_struct *mm);
-void slice_setup_new_exec(void);
-
-#endif /* CONFIG_PPC_64S_HASH_MMU */
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* _ASM_POWERPC_SLICE_H */
-- 
2.33.1

