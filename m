Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDE1530F98
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiEWMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiEWMHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:07:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E704722531
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:07:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C7921F8BE;
        Mon, 23 May 2022 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653307621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AZg9fjSVjMevE6ORFPCYPfeKG/A6rkhSaBplPKn1BKM=;
        b=Ykmc/1vl+NmimrTzr+kiTREuCMPZltfzdr844Wpat4PPalZYSpZuek35bqJ9ldWztCBOEw
        J5STYqsmtg5Cz9bE8Sr6Pk3H5n8yjrbR6p24mJSki+mZ8Ku72Ii4Sbcuq9KNjfpB7dWc12
        b51J50u20vgDhrLtvEV7QHx39nnBN4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653307621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AZg9fjSVjMevE6ORFPCYPfeKG/A6rkhSaBplPKn1BKM=;
        b=xUaP5gidQs3MRKzoyRaHctiiKKMZcZTLZA8J+fKR9YEgjH56EvPAG6Cr+QR3m8GwmC8wkB
        tuiz1C+NJX9+PRCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90421139F5;
        Mon, 23 May 2022 12:07:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yMouI+V4i2JiMQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 12:07:01 +0000
Date:   Mon, 23 May 2022 14:06:57 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for 5.19
Message-ID: <Yot44Yl5/6VFQtHI@zn.tnic>
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

please pull what is more a janitorial set of changes to x86/cpu.

Depending on the merge order, this one is causing some trivial merge
conflicts too, see below.

--

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.19_rc1

for you to fetch changes up to 2147c438fde135d6c145a96e373d9348e7076f7f:

  x86/speculation: Add missing prototype for unpriv_ebpf_notify() (2022-04-28 11:12:17 +0200)

----------------------------------------------------------------
- Remove a bunch of chicken bit options to turn off CPU features which
are not really needed anymore

- Misc fixes and cleanups

----------------------------------------------------------------
Borislav Petkov (6):
      x86/cpu: Allow feature bit names from /proc/cpuinfo in clearcpuid=
      x86/cpu: Remove "nosep"
      x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"
      x86/cpu: Remove "nosmep"
      x86/cpu: Remove "noexec"
      x86/cpu: Remove "noclflush"

Josh Poimboeuf (1):
      x86/speculation: Add missing prototype for unpriv_ebpf_notify()

Matthieu Baerts (1):
      x86/pm: Fix false positive kmemleak report in msr_build_context()

Ricardo Cañuelo (1):
      x86/speculation/srbds: Do not try to turn mitigation off when not supported

 Documentation/admin-guide/kernel-parameters.txt |  24 +++---
 Documentation/x86/cpuinfo.rst                   |   5 +-
 Documentation/x86/x86_64/boot-options.rst       |   9 ---
 arch/x86/Kconfig                                |  11 ---
 arch/x86/include/asm/cpufeature.h               |   7 +-
 arch/x86/include/asm/disabled-features.h        |   8 +-
 arch/x86/include/asm/proto.h                    |   1 -
 arch/x86/include/asm/smap.h                     |  24 ------
 arch/x86/include/asm/suspend_32.h               |   2 +-
 arch/x86/include/asm/suspend_64.h               |  12 ++-
 arch/x86/kernel/cpu/bugs.c                      |   7 ++
 arch/x86/kernel/cpu/common.c                    | 101 +++++++++++++-----------
 arch/x86/kernel/setup.c                         |  28 ++++++-
 arch/x86/mm/Makefile                            |   3 +-
 arch/x86/mm/init_64.c                           |   1 -
 arch/x86/mm/setup_nx.c                          |  62 ---------------
 include/linux/bpf.h                             |   2 +
 scripts/Makefile.build                          |   2 +-
 scripts/link-vmlinux.sh                         |   6 +-
 tools/arch/x86/include/asm/disabled-features.h  |   8 +-
 20 files changed, 120 insertions(+), 203 deletions(-)
 delete mode 100644 arch/x86/mm/setup_nx.c

---

Merge conflict resolution:

diff --cc arch/x86/include/asm/disabled-features.h
index b37de8268c9a,1ae0fab7d902..36369e76cc63
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@@ -85,8 -73,8 +79,8 @@@
  #define DISABLED_MASK5	0
  #define DISABLED_MASK6	0
  #define DISABLED_MASK7	(DISABLE_PTI)
 -#define DISABLED_MASK8	0
 +#define DISABLED_MASK8	(DISABLE_TDX_GUEST)
- #define DISABLED_MASK9	(DISABLE_SMAP|DISABLE_SGX)
+ #define DISABLED_MASK9	(DISABLE_SGX)
  #define DISABLED_MASK10	0
  #define DISABLED_MASK11	0
  #define DISABLED_MASK12	0
diff --cc arch/x86/kernel/cpu/common.c
index f0baf1b7522e,7dd7604cf46a..2e9142797c99
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@@ -1856,18 -1868,8 +1869,10 @@@ void identify_secondary_cpu(struct cpui
  	validate_apic_and_package_id(c);
  	x86_spec_ctrl_setup_ap();
  	update_srbds_msr();
 +
 +	tsx_ap_init();
  }
  
- static __init int setup_noclflush(char *arg)
- {
- 	setup_clear_cpu_cap(X86_FEATURE_CLFLUSH);
- 	setup_clear_cpu_cap(X86_FEATURE_CLFLUSHOPT);
- 	return 1;
- }
- __setup("noclflush", setup_noclflush);
- 
  void print_cpu_info(struct cpuinfo_x86 *c)
  {
  	const char *vendor = NULL;
diff --cc scripts/Makefile.build
index 33c1ed581522,7e7aa1d030a6..3911bfc21702
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@@ -231,9 -231,9 +231,9 @@@ objtool_args =								
  	$(if $(part-of-module), --module)				\
  	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
  	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
 -	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
 +	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)			\
  	$(if $(CONFIG_RETPOLINE), --retpoline)				\
- 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
+ 	--uaccess							\
  	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
  	$(if $(CONFIG_SLS), --sls)
  

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
