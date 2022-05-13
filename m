Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94A85267AD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382586AbiEMQym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376866AbiEMQyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:54:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78195677D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CA07B80D3E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8104C34100;
        Fri, 13 May 2022 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652460760;
        bh=9+uLG6DacTmT7ZHwIV8mCWTe/BIRO1BxcapPZy6v4h0=;
        h=Date:From:To:Cc:Subject:From;
        b=mI+7RmCYSuJY3Mph3/sGxsm9laPe+0mCazl4YiIgEh3EkFQLpIKYqF29IBeAMFtup
         UGAyZP8Bip0kWab+Kk3nQhYvLhyBsFZZLo8XRs/GR/h0L2JEFhNa8eR3iwTor8AMdp
         7DQx+DXF0xLbKVs/NEoBC8/gBlhOEkYE1VZIO1LKn61gSqglRwBow+F3WsJ9hTA9Dx
         IiX6Xd3+5/tCzvFuegNRcy9ttSNbcw7PSAsfEJ/EUy+kYFUakFWogTV5PM0h32Hoda
         nvEary/1E08u4yZ4Pr73OkfChbCqjY09WiHNwqaev9/zzwl4M9DTuydb1z9kBsHSdu
         hVBA9H65vDi7A==
Date:   Fri, 13 May 2022 17:52:35 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc7
Message-ID: <20220513165233.GA32168@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these three arm64 fixes for -rc7. The summary is in the tag
but it's all pretty straightforward.

Thanks,

Will

--->8

The following changes since commit c35fe2a68f29a0bda15ae994154cacaae5f69791:

  elf: Fix the arm64 MTE ELF segment name and value (2022-04-28 11:37:06 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 51f559d66527e238f9a5f82027bff499784d4eac:

  arm64: Enable repeat tlbi workaround on KRYO4XX gold CPUs (2022-05-12 13:15:38 +0100)

----------------------------------------------------------------
arm64 fixes for -rc7

- TLB invalidation workaround for Qualcomm Kryo-4xx "gold" CPUs

- Fix broken dependency in the vDSO Makefile

- Fix pointer authentication overrides in ISAR2 ID register

----------------------------------------------------------------
Joey Gouly (1):
      arm64: vdso: fix makefile dependency on vdso.so

Kristina Martsenko (1):
      arm64: cpufeature: remove duplicate ID_AA64ISAR2_EL1 entry

Shreyas K K (1):
      arm64: Enable repeat tlbi workaround on KRYO4XX gold CPUs

 Documentation/arm64/silicon-errata.rst | 3 +++
 arch/arm64/kernel/Makefile             | 4 ++++
 arch/arm64/kernel/cpu_errata.c         | 2 ++
 arch/arm64/kernel/cpufeature.c         | 3 +--
 arch/arm64/kernel/vdso/Makefile        | 3 ---
 arch/arm64/kernel/vdso32/Makefile      | 3 ---
 6 files changed, 10 insertions(+), 8 deletions(-)
