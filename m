Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789CC53CE1B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbiFCReI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiFCReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77852B17
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38FFD61AA3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 17:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342AAC385A9;
        Fri,  3 Jun 2022 17:34:03 +0000 (UTC)
Date:   Fri, 3 Jun 2022 18:33:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] arm64 fixes for 5.19-rc1
Message-ID: <YppGB+DX5lGjlBEq@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Most of issues addressed were
introduced during this merging window. Thanks.

The following changes since commit 0616ea3f1b93a99264d84f3d002ae117f6526b62:

  Merge branch 'for-next/esr-elx-64-bit' into for-next/core (2022-05-20 18:51:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 78c09c0f4df89fabdcfb3e5e53d3196cf67f64ef:

  kselftest/arm64: signal: Skip SVE signal test if not enough VLs supported (2022-06-02 20:29:17 +0100)

----------------------------------------------------------------
arm64 fixes for 5.19-rc1:

- Initialise jump labels before setup_machine_fdt(), needed by commit
  f5bda35fba61 ("random: use static branch for crng_ready()").

- Sparse warnings: missing prototype, incorrect __user annotation.

- Skip SVE kselftest if not sufficient vector lengths supported.

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Remove the __user annotation for the restore_za_context() argument

Chengming Zhou (1):
      ftrace/fgraph: fix increased missing-prototypes warnings

Cristian Marussi (1):
      kselftest/arm64: signal: Skip SVE signal test if not enough VLs supported

Stephen Boyd (1):
      arm64: Initialize jump labels before setup_machine_fdt()

Xiang wangx (1):
      arm64: hibernate: Fix syntax errors in comments

 arch/arm64/kernel/hibernate.c                                      | 2 +-
 arch/arm64/kernel/setup.c                                          | 7 ++++---
 arch/arm64/kernel/signal.c                                         | 2 +-
 kernel/trace/fgraph.c                                              | 2 ++
 .../arm64/signal/testcases/fake_sigreturn_sve_change_vl.c          | 2 ++
 5 files changed, 10 insertions(+), 5 deletions(-)

-- 
Catalin
