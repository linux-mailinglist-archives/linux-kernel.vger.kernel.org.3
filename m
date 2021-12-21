Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057F947C465
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbhLURBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbhLURBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA615C061574;
        Tue, 21 Dec 2021 09:01:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FE53B817C6;
        Tue, 21 Dec 2021 17:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5408C36AE8;
        Tue, 21 Dec 2021 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640106066;
        bh=7d8LhHNqF8chXHYwnQCba3+BVf9M2vb5t0LpTpOXl3I=;
        h=From:To:Cc:Subject:Date:From;
        b=dEgydiYrKTv4MoEpX8HEQPqxS6hcDAYv3fewK7fRHlYo1CHlD/jbRbllFF0F8kZJR
         7Ol7HU29iOHWoMgGNtsqJUJCM5S4W0bgP/zIGIS5hDslGvSBAcnMkOveiGKJ3RC9in
         phVRHxd7jJND527OgA3JMqshWfpLFVLj3H6JoZQlMlYklclMYaZz0Kb7LD+CmhEWua
         uKrgpIgE7bEmoNRS3EL88iGk+rcBxqSBw196mkCKvdSsMMYIldXUa3jUAkYsmHra4o
         ZYOiY88ri24LqnBH+ncTH+nICWwBRbCrgyo/8AjbwLlOdXvXLXKKZdbHKtkvqkpvAZ
         +r/YN5cJ3971w==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 0/8] sched: Remove unused TASK_SIZE_OF
Date:   Wed, 22 Dec 2021 01:00:49 +0800
Message-Id: <20211221170057.2637763-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux, now. Delete in include/linux/sched.h
and arch's include/asm. This would confuse people who are
implementing the COMPAT feature for architecture.

Guo Ren (8):
  sched: Remove unused TASK_SIZE_OF
  sched: x86: Remove unused TASK_SIZE_OF
  sched: sparc: Remove unused TASK_SIZE_OF
  sched: powerpc: Remove unused TASK_SIZE_OF
  sched: s390: Remove unused TASK_SIZE_OF
  sched: parisc: Remove unused TASK_SIZE_OF
  sched: arm64: Remove unused TASK_SIZE_OF
  sched: mips: Remove unused TASK_SIZE_OF

 arch/arm64/include/asm/processor.h      | 2 --
 arch/mips/include/asm/processor.h       | 3 ---
 arch/parisc/include/asm/processor.h     | 3 +--
 arch/powerpc/include/asm/task_size_64.h | 6 ++----
 arch/s390/include/asm/processor.h       | 3 +--
 arch/sparc/include/asm/processor_64.h   | 3 ---
 arch/x86/include/asm/page_64_types.h    | 2 --
 include/linux/sched.h                   | 4 ----
 8 files changed, 4 insertions(+), 22 deletions(-)

-- 
2.25.1

