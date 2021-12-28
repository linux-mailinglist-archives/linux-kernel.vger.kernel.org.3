Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2904806D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhL1GsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbhL1GsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:48:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA1CC06173E;
        Mon, 27 Dec 2021 22:48:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B7E7B8111B;
        Tue, 28 Dec 2021 06:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14BCC36AEC;
        Tue, 28 Dec 2021 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640674095;
        bh=16Xsifca9wkKUTK9OpCC6J6+WJoRfyl6c8OE6ELYn1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0E07KS19qkH/0CCH5Z8kDC5HG2hLHXJ18r+ghFJA6w/xWOXVCuE6NWt3soxf+5vD
         DDKIXKXo16qlV8VF6keVcb5Bqtx0iRFpFa5NnSmr1+Or7NFatWIV+110jsZ4KMJZas
         TNLMO3O4o+jS97FOYgboHWDkbFzSDT0mt18CQk2+e3wa4TDVrd97JPB5sJiDxH34fR
         w6aB6sluGKhydx76A+3AEQjd5THrEKQIGLTPke3CdByKbG7s+4Wkd0YMeZc0darcto
         sCRTIhL9v660gGK5IPsu+sLR4NHJpG9q5ArXxeVsu1VFPexDOcllHxTFyVKJozjfOn
         NOizjMG6O+zjA==
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
Subject: [PATCH V3 6/8] sched: parisc: Remove unused TASK_SIZE_OF
Date:   Tue, 28 Dec 2021 14:47:27 +0800
Message-Id: <20211228064730.2882351-7-guoren@kernel.org>
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

