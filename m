Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402D847C474
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbhLURBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbhLURBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE323C06173F;
        Tue, 21 Dec 2021 09:01:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EC81B811EF;
        Tue, 21 Dec 2021 17:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78D7C36AE9;
        Tue, 21 Dec 2021 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640106076;
        bh=hn3veBBJZYE9nGCcPpANoBu5axxXjoY0y6QW+W/U4eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWfUvlW0RDAG6Ozg92WgcggGzUxYXEmU7ssB7PoDXcyO8Fg6738JJ45CZmqBYm1b/
         DQXSTRlGz4EMqO2yWos31vB4R3NHHgLDS12AKWvT6zJ1kI6Nkb22e8wSDqePts4Unk
         Z4fXAth9bv2bYajqEIbdq3tqQdFw6kL7QvetvboWvL3YQ0tvwI77hsbIE1CsW2rKAX
         t1yn46OfMf54pm80ItEiXxIPNchdgiq7FILgGEKd4DTsl8f1NgpIcHkf2OIp9NjcvN
         FmjW7DG0y24jHMb2lsRVgE+RYZuvL1HU46BxKpRXFZH95UkpjyY44yWTODhfsSKdMH
         YIf0ZH22SRELg==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/8] sched: x86: Remove unused TASK_SIZE_OF
Date:   Wed, 22 Dec 2021 01:00:51 +0800
Message-Id: <20211221170057.2637763-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221170057.2637763-1-guoren@kernel.org>
References: <20211221170057.2637763-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
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

