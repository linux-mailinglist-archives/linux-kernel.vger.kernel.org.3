Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9499F4D3974
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiCITFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiCITFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:05:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB12180B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:04:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 321E7B82365
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04029C340E8;
        Wed,  9 Mar 2022 19:04:20 +0000 (UTC)
Date:   Wed, 9 Mar 2022 19:04:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.17
Message-ID: <Yij6MY63Lhg0icIg@arm.com>
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

Please pull the arm64 fixes below. I expect another pull request today
or tomorrow with a small fix for building BHB with clang LTO enabled
(some include order messing up defines).

Thanks.

The following changes since commit 4f6de676d94ee8ddfc2e7e7cd935fc7cb2feff3a:

  arm64: Correct wrong label in macro __init_el2_gicv3 (2022-02-14 18:37:07 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to b859ebedd1e730bbda69142fca87af4e712649a1:

  arm64: kasan: fix include error in MTE functions (2022-03-09 15:27:21 +0000)

----------------------------------------------------------------
- Fix compilation of eBPF object files that indirectly include
  mte-kasan.h.

- Fix test for execute-only permissions with EPAN (Enhanced Privileged
  Access Never, ARMv8.7 feature).

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Ensure execute-only permissions are not allowed without EPAN

Paul Semel (1):
      arm64: kasan: fix include error in MTE functions

 arch/arm64/Kconfig                    |  3 ---
 arch/arm64/include/asm/mte-kasan.h    |  1 +
 arch/arm64/include/asm/pgtable-prot.h |  4 ++--
 arch/arm64/include/asm/pgtable.h      | 11 -----------
 arch/arm64/mm/mmap.c                  | 17 +++++++++++++++++
 5 files changed, 20 insertions(+), 16 deletions(-)

-- 
Catalin
