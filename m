Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93EC50B610
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447066AbiDVLX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446980AbiDVLX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD61A5370D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36C6161F70
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8530EC385A0;
        Fri, 22 Apr 2022 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650626433;
        bh=9Sd6/TvQzzVy1ERUK6rhOB3GoS30+dBUMp4Rfn4p7HE=;
        h=Date:From:To:Cc:Subject:From;
        b=jTE6pbwP5boihtOpGuZIBtTlDSESNCzDhybTMWgAdnUAhofPIkO47/TPU9ypRE94s
         DpjXZQafRNNpNcorEYShVn0nExtcxotUxxPsYpfaaHLRWrAXY/nA6CnyY5mQUF8Auz
         5RnNx/ZwIKa6wFPIRYFXixZnj9QvUzHdBJXwY6x9pVTOLNeSgy/l/v6OvHsYaF3xlw
         +eUiuncH2SNBz8ev+GedARLkTViRkkBBKRlIeQ/MItEcSGVrdhRRUU5sEemuhDVfqw
         /EGFWIfrCe+I+cOHAKK7lEhGaMPDkX5ePTJminfw+VcuHcnfMOd4D9e91rcGaULuj+
         pWLmylYpM8XHw==
Date:   Fri, 22 Apr 2022 12:20:29 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc4
Message-ID: <20220422112028.GA9901@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc4. There's no real pattern to them, but
the main one fixes our pmd_leaf() definition to resolve a NULL dereference
on the migration path.

Cheers,

Will

--->8

The following changes since commit d02b4dd84e1a90f7f1444d027c0289bf355b0d5a:

  perf/imx_ddr: Fix undefined behavior due to shift overflowing the constant (2022-04-08 14:17:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 23bc8f69f0eceecbb87c3801d2e48827d2dca92b:

  arm64: mm: fix p?d_leaf() (2022-04-22 11:28:36 +0100)

----------------------------------------------------------------
arm64 fixes for -rc4

- Fix PMU event validation in the absence of any event counters

- Fix allmodconfig build using clang in conjunction with binutils

- Fix definitions of pXd_leaf() to handle PROT_NONE entries

- More typo fixes

----------------------------------------------------------------
Ken Kurematsu (1):
      arm64: fix typos in comments

Muchun Song (1):
      arm64: mm: fix p?d_leaf()

Nathan Chancellor (1):
      arm64: Improve HAVE_DYNAMIC_FTRACE_WITH_REGS selection for clang

Rob Herring (1):
      arm_pmu: Validate single/group leader events

 arch/arm64/Kconfig               | 15 ++++++++++++---
 arch/arm64/include/asm/pgtable.h |  4 ++--
 drivers/perf/arm_pmu.c           | 10 ++++------
 3 files changed, 18 insertions(+), 11 deletions(-)
