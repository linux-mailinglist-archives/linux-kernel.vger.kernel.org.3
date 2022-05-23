Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA75531205
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiEWPEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbiEWPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:04:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312BF5BD2D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:04:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BAF6E219D7;
        Mon, 23 May 2022 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653318239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1mQVU5fewB7vBxald/XJiqlST+FKvUluab5kTFo9Wzw=;
        b=m8OfgMthq80GMFmazW/Bb27rpS9sBHhKdjdMSlOBOdkWvmOYV9UJkgph4tj/cRUk11AQ3o
        OUadiCA9kHPwBLF5gEUthWCIqQ8FxSrxrIhWsLjnuB+DKECp4f6425vRarMu8lb4S6oEXd
        OKFbZHQByyAy0JMEuQEbRVmeY1xzgEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653318239;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1mQVU5fewB7vBxald/XJiqlST+FKvUluab5kTFo9Wzw=;
        b=OCMogn2jd+iz4/FdtvR/p+nqDn8YbFT7UiCzkhB4ij5T0mJDBeiNDqcHYFqvtGB1peIUHT
        AQZCwDL8RMdWeSDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADF5E13AA5;
        Mon, 23 May 2022 15:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Sah0Kl+ii2LVCwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 15:03:59 +0000
Date:   Mon, 23 May 2022 17:03:55 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for 5.19
Message-ID: <YougA/80bebDPSkh@zn.tnic>
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

please pull the usual pile of x86 cleanups for 5.19.

Thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.19_rc1

for you to fetch changes up to d936411dc9caeb3edb992e39c33d4d1d81ca8c08:

  x86: Remove empty files (2022-05-20 12:29:26 +0200)

----------------------------------------------------------------
- Serious sanitization and cleanup of the whole APERF/MPERF and
frequency invariance code along with removing the need for unnecessary IPIs

- Finally remove a.out support

- The usual trivial cleanups and fixes all over x86

----------------------------------------------------------------
Borislav Petkov (2):
      x86: Remove a.out support
      x86: Remove empty files

Ira Weiny (2):
      x86/pkeys: Clean up arch_set_user_pkey_access() declaration
      x86/pkeys: Remove __arch_set_user_pkey_access() declaration

Jiapeng Chong (1):
      x86/process: Fix kernel-doc warning due to a changed function name

Thomas Gleixner (13):
      x86/aperfmperf: Dont wake idle CPUs in arch_freq_get_on_cpu()
      x86/smp: Move APERF/MPERF code where it belongs
      x86/aperfmperf: Separate AP/BP frequency invariance init
      x86/aperfmperf: Untangle Intel and AMD frequency invariance init
      x86/aperfmperf: Put frequency invariance aperf/mperf data into a struct
      x86/aperfmperf: Restructure arch_scale_freq_tick()
      x86/aperfmperf: Make parts of the frequency invariance code unconditional
      x86/aperfmperf: Store aperf/mperf data for cpu frequency reads
      x86/aperfmperf: Replace aperfmperf_get_khz()
      x86/aperfmperf: Replace arch_freq_get_on_cpu()
      x86/aperfmperf: Integrate the fallback code from show_cpuinfo()
      x86/aperfperf: Make it correct on 32bit and UP kernels
      x86/prctl: Remove pointless task argument

Xiao Yang (1):
      x86/speculation: Add missing srbds=off to the mitigations= help text

Yury Norov (2):
      x86: Replace cpumask_weight() with cpumask_empty() where appropriate
      x86/mm: Replace nodes_weight() with nodes_empty() where appropriate

 Documentation/admin-guide/kernel-parameters.txt |   1 +
 MAINTAINERS                                     |   1 -
 arch/x86/Kconfig                                |   7 -
 arch/x86/ia32/Makefile                          |   2 -
 arch/x86/ia32/ia32_aout.c                       | 325 ----------------
 arch/x86/include/asm/cpu.h                      |   2 +
 arch/x86/include/asm/fpu/api.h                  |   3 +-
 arch/x86/include/asm/fpu/internal.h             |   0
 arch/x86/include/asm/mmx.h                      |   0
 arch/x86/include/asm/pkeys.h                    |   8 -
 arch/x86/include/asm/proto.h                    |   3 +-
 arch/x86/include/asm/topology.h                 |  23 +-
 arch/x86/kernel/acpi/cppc.c                     |  29 +-
 arch/x86/kernel/cpu/aperfmperf.c                | 480 +++++++++++++++++++-----
 arch/x86/kernel/cpu/proc.c                      |  11 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c          |  14 +-
 arch/x86/kernel/fpu/xstate.c                    |   5 +-
 arch/x86/kernel/process.c                       |  11 +-
 arch/x86/kernel/process_32.c                    |   2 +-
 arch/x86/kernel/process_64.c                    |   4 +-
 arch/x86/kernel/smpboot.c                       | 358 +-----------------
 arch/x86/lib/mmx_32.c                           |   0
 arch/x86/mm/amdtopology.c                       |   2 +-
 arch/x86/mm/mmio-mod.c                          |   2 +-
 arch/x86/mm/numa_emulation.c                    |   4 +-
 arch/x86/platform/uv/uv_nmi.c                   |   2 +-
 fs/proc/cpuinfo.c                               |   6 +-
 include/linux/cpufreq.h                         |   1 -
 28 files changed, 441 insertions(+), 865 deletions(-)
 delete mode 100644 arch/x86/ia32/ia32_aout.c
 delete mode 100644 arch/x86/include/asm/fpu/internal.h
 delete mode 100644 arch/x86/include/asm/mmx.h
 delete mode 100644 arch/x86/lib/mmx_32.c
-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
