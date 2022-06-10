Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5F546BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbiFJR0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiFJR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:26:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270132EC7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEE7CB83689
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF1BC3411C;
        Fri, 10 Jun 2022 17:26:18 +0000 (UTC)
Date:   Fri, 10 Jun 2022 18:26:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.19-rc2
Message-ID: <YqN+t6VQhpYv36Ll@arm.com>
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

Please pull the arm64 fixes below. Thanks.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 78cdaf3f4257ab10a6cec308ed774e7c7f7e5f72:

  arm64: Add kasan_hw_tags_enable() prototype to silence sparse (2022-06-10 18:04:05 +0100)

----------------------------------------------------------------
arm64 fixes for 5.19-rc2:

- SME save/restore for EFI fix - incorrect logic for detecting the need
  for saving/restoring the FFR state.

- SME fix for a CPU ID field value.

- Sysreg generation awk script fix (comparison operator).

- Some typos in documentation or comments and silence a sparse warning
  (missing prototype).

----------------------------------------------------------------
Alejandro Tafalla (1):
      arm64/sysreg: Fix typo in Enum element regex

Catalin Marinas (1):
      arm64: Add kasan_hw_tags_enable() prototype to silence sparse

Mark Brown (3):
      arm64/sme: Fix tests for 0b1111 value ID registers
      arm64/sme: Fix SVE/SME typo in ABI documentation
      arm64/sme: Fix EFI save/restore

Xiang wangx (1):
      arm64/fpsimd: Fix typo in comment

 Documentation/arm64/sme.rst     |  2 +-
 arch/arm64/include/asm/sysreg.h |  4 ++--
 arch/arm64/kernel/fpsimd.c      | 20 +++++++++++++++-----
 arch/arm64/kernel/mte.c         |  6 ++++++
 arch/arm64/tools/gen-sysreg.awk |  2 +-
 5 files changed, 25 insertions(+), 9 deletions(-)

-- 
Catalin
