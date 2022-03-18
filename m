Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB414DE113
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbiCRSeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbiCRSeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE18125C89
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49EFB61B50
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B33C340E8;
        Fri, 18 Mar 2022 18:32:37 +0000 (UTC)
Date:   Fri, 18 Mar 2022 18:32:34 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] arm64-fixes for 5.17
Message-ID: <YjTQQvDwjwIYQ+Cx@arm.com>
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

Please pull the fixes below for 5.17 (nothing serious, compiler
warnings). Thanks.

The following changes since commit 09688c0166e76ce2fb85e86b9d99be8b0084cdf9:

  Linux 5.17-rc8 (2022-03-13 13:23:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 316e46f65a5497839857db08b6fbf60f568b165a:

  arm64: errata: avoid duplicate field initializer (2022-03-18 14:09:18 +0000)

----------------------------------------------------------------
Fix two compiler warnings introduced by recent commits: pointer
arithmetic and double initialisation of struct field.

----------------------------------------------------------------
Arnd Bergmann (2):
      arm64: fix clang warning about TRAMP_VALIAS
      arm64: errata: avoid duplicate field initializer

 arch/arm64/include/asm/vectors.h | 4 ++--
 arch/arm64/kernel/cpu_errata.c   | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Catalin
