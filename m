Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9155851644D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 14:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346761AbiEAMD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 08:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiEAMD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 08:03:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242B3A5C2
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 05:00:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BDBE1F381;
        Sun,  1 May 2022 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651406401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lNz5IXxXcYlZTmGO3DgkWPcaex/L3iRTYIdpycamsJs=;
        b=safl9peKZWA8YL9hjzM65XDO2SNqilqBMLfX5YBKDIn7DZYHSKRQrkIuzcqB9f/PcN+Ums
        F18Ps39vpRbdAa25Y+4hWvmeUHLQOa5gHozWQYrxPPLlo9EJ2qD0pJ+cdbeXLwX3HMZF8v
        9GDD4zO5Kk8n0Z9BQjjwxH9lgeaKqqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651406401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lNz5IXxXcYlZTmGO3DgkWPcaex/L3iRTYIdpycamsJs=;
        b=fY/6ee+KlAGmnljZaCJ67F2b5+6ikVEFvd7uj/hUKNx/ELVBu29wJhsjUTA+NQzX+AfaH2
        eEZtsTzCvGxlKODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBA0813AE0;
        Sun,  1 May 2022 12:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sGIYOUB2bmKENAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 01 May 2022 12:00:00 +0000
Date:   Sun, 1 May 2022 13:59:58 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 5.18
Message-ID: <Ym52PqI9BCAfDZuX@zn.tnic>
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

please pull a biggish bunch of urgent x86 fixes for 5.18.

Thx.

---

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.18_rc5

for you to fetch changes up to 7e0815b3e09986d2fe651199363e135b9358132a:

  x86/pci/xen: Disable PCI/MSI[-X] masking for XEN_HVM guests (2022-04-29 14:37:39 +0200)

----------------------------------------------------------------
- A fix to disable PCI/MSI[-X] masking for XEN_HVM guests as that is
solely controlled by the hypervisor

- A build fix to make the function prototype (__warn()) as visible as
the definition itself

- A bunch of objtool annotation fixes which have accumulated over time

- An ORC unwinder fix to handle bad input gracefully

- Well, we thought the microcode gets loaded in time in order to restore
the microcode-emulated MSRs but we thought wrong. So there's a fix for
that to have the ordering done properly

- Add new Intel model numbers

- A spelling fix

----------------------------------------------------------------
Borislav Petkov (1):
      x86/cpu: Load microcode during restore_processor_state()

Dmitry Monakhov (1):
      x86/unwind/orc: Recheck address range after stack info was updated

Josh Poimboeuf (8):
      MAINTAINERS: Add x86 unwinding entry
      objtool: Enable unreachable warnings for CLANG LTO
      x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline
      x86/retpoline: Add ANNOTATE_NOENDBR for retpolines
      x86/uaccess: Add ENDBR to __put_user_nocheck*()
      x86/xen: Add ANNOTATE_NOENDBR to startup_xen()
      objtool: Print data address for "!ENDBR" data warnings
      objtool: Use offstr() to print address of missing ENDBR

Nur Hussein (1):
      x86/Kconfig: fix the spelling of 'becoming' in X86_KERNEL_IBT config

Peter Zijlstra (4):
      lib/strn*,objtool: Enforce user_access_begin() rules
      x86,xen,objtool: Add UNWIND hint
      x86,objtool: Mark cpu_startup_entry() __noreturn
      x86,objtool: Explicitly mark idtentry_body()s tail REACHABLE

Shida Zhang (1):
      bug: Have __warn() prototype defined unconditionally

Thomas Gleixner (1):
      x86/pci/xen: Disable PCI/MSI[-X] masking for XEN_HVM guests

Tony Luck (1):
      x86/cpu: Add new Alderlake and Raptorlake CPU model numbers

 MAINTAINERS                          |  9 +++++++++
 arch/x86/Kconfig                     |  2 +-
 arch/x86/entry/entry_64.S            |  3 +++
 arch/x86/include/asm/intel-family.h  |  3 +++
 arch/x86/include/asm/microcode.h     |  2 ++
 arch/x86/include/asm/static_call.h   |  1 +
 arch/x86/kernel/cpu/microcode/core.c |  6 +++---
 arch/x86/kernel/unwind_orc.c         |  8 ++++----
 arch/x86/lib/putuser.S               |  4 ++++
 arch/x86/lib/retpoline.S             |  2 +-
 arch/x86/pci/xen.c                   |  6 +++++-
 arch/x86/platform/pvh/head.S         |  1 +
 arch/x86/power/cpu.c                 | 10 +++++++++-
 arch/x86/xen/xen-head.S              |  1 +
 include/asm-generic/bug.h            | 11 ++++++-----
 include/linux/cpu.h                  |  2 +-
 lib/strncpy_from_user.c              |  2 +-
 lib/strnlen_user.c                   |  2 +-
 scripts/Makefile.build               |  2 +-
 scripts/link-vmlinux.sh              |  2 +-
 tools/objtool/check.c                | 13 +++++--------
 21 files changed, 63 insertions(+), 29 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
