Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F43595E84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiHPOpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiHPOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:45:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B027659F8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:45:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB201B8164C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34822C433C1;
        Tue, 16 Aug 2022 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660661141;
        bh=Dc46nvI7EwJy/kvhclteZuNgBKFJbzV5dPeUJlkZNn8=;
        h=From:To:Cc:Subject:Date:From;
        b=Hjchqn3C3ks50PFB38h5dBPfZpdEy9Jd3QDCHbD8KeESJNpY8Yep9fxET5+CiYLmT
         WGWKDn7xca7X5mZXVwwYUfHiMPVS3/qgioB4ZERykysfmmuJgLD8PtcvzntqzO7sv6
         ZVsx3Yuv+WWEUq029451xFbPoexbl9yWrjyNhf1uapQIePCE4X3BcL43eyCgLblmRG
         AG3Z/n0E8u2rTlPsKVSrRjPy7ykZSbdLLmIcjmq/y9Ur//jbp4beMIQAkEzVkBL6tr
         RyNqsnKIQuLsMPpm1bphp9r2GA5s+afelo18+r1TOYrUMQ/lIdvr/U3wE6K0hyeFgu
         8k/7MMWE1kDzA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] NIOS2: fixes for v6.0
Date:   Tue, 16 Aug 2022 09:45:39 -0500
Message-Id: <20220816144539.371752-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these fixes for NIOS2 for v6.0.

Thanks,

Dinh

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_v6.0

for you to fetch changes up to fd0c153daad135d0ec1a53c5dbe6936a724d6ae1:

  nios2: add force_successful_syscall_return() (2022-08-15 11:25:32 -0500)

----------------------------------------------------------------
NIOS2 fixes for v6.0
- Security fixes from Al Viro

----------------------------------------------------------------
Al Viro (6):
      nios2: page fault et.al. are *not* restartable syscalls...
      nios2: don't leave NULLs in sys_call_table[]
      nios2: traced syscall does need to check the syscall number
      nios2: fix syscall restart checks
      nios2: restarts apply only to the first sigframe we build...
      nios2: add force_successful_syscall_return()

 arch/nios2/include/asm/entry.h    |  3 ++-
 arch/nios2/include/asm/ptrace.h   |  2 ++
 arch/nios2/kernel/entry.S         | 22 +++++++++++++++-------
 arch/nios2/kernel/signal.c        |  3 ++-
 arch/nios2/kernel/syscall_table.c |  1 +
 5 files changed, 22 insertions(+), 9 deletions(-)
