Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4291747F1DA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 05:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhLYEyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 23:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhLYEyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 23:54:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A01DC061401;
        Fri, 24 Dec 2021 20:54:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1C25B80AEA;
        Sat, 25 Dec 2021 04:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F98C36AE9;
        Sat, 25 Dec 2021 04:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640408091;
        bh=G9+BUfbfli+fFvrXVVfvrmWFJpu5MjiXo507Oal3Bt8=;
        h=From:To:Cc:Subject:Date:From;
        b=YkAkjARgZSI77tGg5SS/eW84LcQsMnmxJXKtRnBn3C+HhYHzBTtnAN55uGhwb1Aiy
         RfUTJxyb8ffODA0hvpJy3jM+Gi2/GO2cTqjm9z1BWjanVrRikV7S9BF7IhuwAJN21U
         qlV0g9cYW+hxQzZxqex4poh25/7gNpmWvcriZoy5ELI9Qy7ny7+vfqvODLzUgRr0+K
         3Na/XcnfQ05N5Ug86oHkbjJvlo0vPNGyO1SqEsuHjrAH8AvSt3f+qr51geHq00JpuW
         Dscy/FyBKDXPFmaqHpf4oAF5FjiQxZW0cTnsX3zgThhQ4a5qTIcRJX3lpXN7c3ERoW
         ecDiiSTt//6Zg==
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
Subject: [PATCH V2 0/8] sched: Remove unused TASK_SIZE_OF
Date:   Sat, 25 Dec 2021 12:54:22 +0800
Message-Id: <20211225045430.2868608-1-guoren@kernel.org>
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

Changes in v2:
 - Add Arnd's comment in main patch
 - Optimize coding convention with Christophe's advise

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
 arch/powerpc/include/asm/task_size_64.h | 6 +-----
 arch/s390/include/asm/processor.h       | 3 +--
 arch/sparc/include/asm/processor_64.h   | 3 ---
 arch/x86/include/asm/page_64_types.h    | 2 --
 include/linux/sched.h                   | 4 ----
 8 files changed, 3 insertions(+), 23 deletions(-)

-- 
2.25.1

