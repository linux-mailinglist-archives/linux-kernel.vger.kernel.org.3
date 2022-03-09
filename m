Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2B4D3CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiCIWac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiCIWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:30:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD5120E8A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:29:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D008561A97
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E14C340EC;
        Wed,  9 Mar 2022 22:29:29 +0000 (UTC)
Date:   Wed, 9 Mar 2022 22:29:25 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 post-Spectre BHB fix for 5.17
Message-ID: <YikqRdJFLdl8b6HG@arm.com>
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

Please pull the arm64 fix below. It's based onto the arm64 Spectre BHB
branch that was merged yesterday.

Thanks.

The following changes since commit 58c9a5060cb7cd529d49c93954cdafe81c1d642a:

  arm64: proton-pack: Include unprivileged eBPF status in Spectre v2 mitigation reporting (2022-03-07 17:25:52 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 52c9f93a9c482251cb0d224faa602ba26d462be8:

  arm64: Do not include __READ_ONCE() block in assembly files (2022-03-09 21:56:50 +0000)

----------------------------------------------------------------
Fix kernel build with clang LTO after the inclusion of the Spectre BHB
arm64 mitigations.

----------------------------------------------------------------
Nathan Chancellor (1):
      arm64: Do not include __READ_ONCE() block in assembly files

 arch/arm64/include/asm/rwonce.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Catalin
