Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20C4D74C1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiCMK7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiCMK5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:57:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39107A9B0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 03:55:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97F1E1F37C;
        Sun, 13 Mar 2022 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647168874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dsdOLamVCrDQ+i2qmydIbziqRMdo4K/wHMoINOLAh9k=;
        b=s3LjuHbfulUjnC1SUHu+PzTi+Bzo/6htuat5jVnZm+aG3h/z40Za8cvRibPPmuxjc/lVIQ
        NZtf/6B9KVG5INC1O4Wp6+BVHDvAdASk6k2x16bvc4TnA8Y9xGDtAb/qa1t0keP5Sa0Ftt
        05K2fwG0nIxdy0mk1cOpE0AhYjjCihk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647168874;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dsdOLamVCrDQ+i2qmydIbziqRMdo4K/wHMoINOLAh9k=;
        b=zffBM9qEyh0v5Uvfng/1feOUrNyR/GzpvKBWJjLrP2llisVqEymCiovlbaRXgdPS1llub/
        3orbNTkb1NRedIBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84D1B13AF7;
        Sun, 13 Mar 2022 10:54:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aQOnH2rNLWLxGgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 13 Mar 2022 10:54:34 +0000
Date:   Sun, 13 Mar 2022 11:54:39 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 5.17{,-rc8}
Message-ID: <Yi3Nb6Z9rFNKzEIu@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple more urgent x86 fixes for the next kernel tag,
whatever it might be. :)

Thx.

---

The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc8

for you to fetch changes up to 08999b2489b4c9b939d7483dbd03702ee4576d96:

  x86/sgx: Free backing memory after faulting the enclave page (2022-03-11 10:31:06 -0800)

----------------------------------------------------------------
- Free shmem backing storage for SGX enclave pages when those are
swapped back into EPC memory

- Prevent do_int3() from being kprobed, to avoid recursion

- Remap setup_data and setup_indirect structures properly when accessing
their members

- Correct the alternatives patching order for modules too

----------------------------------------------------------------
Jarkko Sakkinen (1):
      x86/sgx: Free backing memory after faulting the enclave page

Li Huafei (1):
      x86/traps: Mark do_int3() NOKPROBE_SYMBOL

Peter Zijlstra (1):
      x86/module: Fix the paravirt vs alternative order

Ross Philipson (2):
      x86/boot: Fix memremap of setup_indirect structures
      x86/boot: Add setup_indirect support in early_memremap_is_setup_data()

 arch/x86/kernel/cpu/sgx/encl.c | 57 ++++++++++++++++++++++++++-----
 arch/x86/kernel/e820.c         | 41 ++++++++++++++++------
 arch/x86/kernel/kdebugfs.c     | 37 +++++++++++++++-----
 arch/x86/kernel/ksysfs.c       | 77 +++++++++++++++++++++++++++++++++---------
 arch/x86/kernel/module.c       | 13 ++++---
 arch/x86/kernel/setup.c        | 34 +++++++++++++++----
 arch/x86/kernel/traps.c        |  1 +
 arch/x86/mm/ioremap.c          | 57 +++++++++++++++++++++++++++----
 8 files changed, 254 insertions(+), 63 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
