Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92EF496385
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379312AbiAURAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:00:13 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57436 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382019AbiAUQ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:59:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 78920CE2420
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 16:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5AAC340E1;
        Fri, 21 Jan 2022 16:59:53 +0000 (UTC)
Date:   Fri, 21 Jan 2022 16:59:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.17-rc1
Message-ID: <YermhR/kQO+dg7P/@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates below, some fixes that turned up during
the merging window. Thanks.

The following changes since commit 945409a6ef442cfe5f2f14e5626d4306d53100f0:

  Merge branches 'for-next/misc', 'for-next/cache-ops-dzp', 'for-next/stacktrace', 'for-next/xor-neon', 'for-next/kasan', 'for-next/armv8_7-fp', 'for-next/atomics', 'for-next/bti', 'for-next/sve', 'for-next/kselftest' and 'for-next/kcsan', remote-tracking branch 'arm64/for-next/perf' into for-next/core (2022-01-05 18:14:32 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to bb425a7598479fa0f171ec806033c440f218b0ce:

  arm64: mm: apply __ro_after_init to memory_limit (2022-01-20 09:15:16 +0000)

----------------------------------------------------------------
arm64 fixes/cleanups:

- Add brackets to the io_stop_wc macro.

- Avoid -Warray-bounds warning with the LSE atomics inline asm.

- Apply __ro_after_init to memory_limit.

----------------------------------------------------------------
Kees Cook (1):
      arm64: atomics: lse: Dereference matching size

Peng Fan (1):
      arm64: mm: apply __ro_after_init to memory_limit

Xiongfeng Wang (1):
      asm-generic: Add missing brackets for io_stop_wc macro

 arch/arm64/include/asm/atomic_lse.h | 2 +-
 arch/arm64/include/asm/cmpxchg.h    | 2 +-
 arch/arm64/mm/init.c                | 2 +-
 include/asm-generic/barrier.h       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
Catalin
