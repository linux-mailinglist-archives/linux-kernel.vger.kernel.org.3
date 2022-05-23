Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A36531401
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiEWP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiEWP27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:28:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE115EDE4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:28:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C23821B51;
        Mon, 23 May 2022 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653319734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x+/1oXehIhqc8cKRJ9ERRgv2SHTK6AyPOx5K6vAtt8g=;
        b=tmnRGdyREpebEZPDsD7YbvQ+wESmrCgriPVJGCvgU+0EHke1YjUCYdbgzC6IFtnBKVV3zv
        Xmn9TEGDxHgoGP4+aawqSYYQZ59kGX3mn1nppL9boxOFppzVSoGNDPKtchmIs884LYxrck
        trldFTraZnTDHJge2IdZmKZMVYZCsXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653319734;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x+/1oXehIhqc8cKRJ9ERRgv2SHTK6AyPOx5K6vAtt8g=;
        b=jPP7N9WALt7GqRLsttOYdzV2ovTFKmxZ/FN2x7RUoLRLnAiA/NgIft8qhgoeLA83Nujabe
        Jjm5sgmb2DHC4LCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0119413AA5;
        Mon, 23 May 2022 15:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +kk9ADaoi2J9FwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 15:28:54 +0000
Date:   Mon, 23 May 2022 17:28:49 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core for 5.19
Message-ID: <YouoMW6jtD3BRavh@zn.tnic>
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

please pull a set of x86/core fixes for 5.19.

Thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.19_rc1

for you to fetch changes up to 69505e3d9a39a988aaed9b58aa6b3482238f6516:

  bug: Use normal relative pointers in 'struct bug_entry' (2022-05-19 23:46:10 +0200)

----------------------------------------------------------------
- Remove all the code around GS switching on 32-bit now that it is not
needed anymore

- Other misc improvements

----------------------------------------------------------------
Brian Gerst (4):
      x86/32: Simplify ELF_CORE_COPY_REGS
      ELF: Remove elf_core_copy_kernel_regs()
      x86/32: Remove lazy GS macros
      x86/asm: Merge load_gs_index()

Josh Poimboeuf (1):
      bug: Use normal relative pointers in 'struct bug_entry'

Thomas Gleixner (1):
      x86/nmi: Make register_nmi_handler() more robust

 arch/arm64/include/asm/asm-bug.h           |  4 ++--
 arch/powerpc/include/asm/bug.h             | 14 ++++++++------
 arch/powerpc/kernel/fadump.c               |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c |  2 +-
 arch/riscv/include/asm/bug.h               |  4 ++--
 arch/s390/include/asm/bug.h                |  5 +++--
 arch/x86/include/asm/bug.h                 |  2 +-
 arch/x86/include/asm/elf.h                 | 15 ++-------------
 arch/x86/include/asm/mmu_context.h         |  2 +-
 arch/x86/include/asm/nmi.h                 |  1 +
 arch/x86/include/asm/segment.h             | 12 ------------
 arch/x86/include/asm/special_insns.h       |  7 ++++---
 arch/x86/kernel/nmi.c                      | 12 ++++++++----
 arch/x86/kernel/process.c                  |  5 +----
 arch/x86/kernel/process_32.c               | 11 ++++-------
 arch/x86/kernel/ptrace.c                   |  6 +++---
 arch/x86/kernel/signal.c                   |  8 +++++---
 arch/x86/kernel/vm86_32.c                  |  4 ++--
 arch/x86/lib/insn-eval.c                   |  5 +++--
 arch/x86/math-emu/get_address.c            |  2 +-
 include/linux/elfcore.h                    |  9 ---------
 kernel/kexec_core.c                        |  2 +-
 lib/bug.c                                  | 15 +++++++--------
 23 files changed, 61 insertions(+), 88 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
