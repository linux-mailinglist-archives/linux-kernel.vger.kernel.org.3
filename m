Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D9356CE87
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 12:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGJKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 06:19:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ADCDF62
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 03:19:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BA8B1FE25;
        Sun, 10 Jul 2022 10:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657448346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9elos7vJtR/xFlEIjFrioFxIi9AoQZ1tt+FVTKRmUoY=;
        b=mQrm2gYsBlfEd629FUdc5Gu52aFDoZ9HSvO5nyA/5zR37k3wTOc5yIHc/0hYfLziLlY+7p
        0cHbLC3xwZchEv/OMwuk2pCRtqrkEX5vIj7qZVeoFXW/TonNYl0ZM+BrWTkdGe+vqYsNmf
        5A6qeLRGMYJjT3r4GqqB+lJOb/NKqyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657448346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9elos7vJtR/xFlEIjFrioFxIi9AoQZ1tt+FVTKRmUoY=;
        b=J2DsACW6wS0jx+OGhxRqllJATPUUIj1LZ+fg+9acfmeX8LUY2MXkYDIWDHd3w4msdxkgHQ
        DzQtITERSMkIZBBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23DBC132FD;
        Sun, 10 Jul 2022 10:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o629CJqnymL0HAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 10 Jul 2022 10:19:06 +0000
Date:   Sun, 10 Jul 2022 12:19:00 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.19-rc6
Message-ID: <YsqnlPzrnQThDLil@zn.tnic>
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

please pull a couple of urgent x86 fixes for 5.19.

Thx.

---

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19_rc6

for you to fetch changes up to cb8a4beac39b90cd60abbf9fd639a3357274e469:

  x86/boot: Fix the setup data types max limit (2022-07-10 11:17:40 +0200)

----------------------------------------------------------------
- Prepare for and clear .brk early in order to address XenPV guests
failures where the hypervisor verifies page tables and uninitialized
data in that range leads to bogus failures in those checks

- Add any potential setup_data entries supplied at boot to the identity
pagetable mappings to prevent kexec kernel boot failures. Usually, this
is not a problem for the normal kernel as those mappings are part of
the initially mapped 2M pages but if kexec gets to allocate the second
kernel somewhere else, those setup_data entries need to be mapped there
too.

- Fix objtool not to discard text references from the __tracepoints
section so that ENDBR validation still works

- Correct the setup_data types limit as it is user-visible, before 5.19
releases

----------------------------------------------------------------
Borislav Petkov (1):
      x86/boot: Fix the setup data types max limit

Juergen Gross (3):
      x86/xen: Use clear_bss() for Xen PV guests
      x86: Clear .brk area at early boot
      x86: Fix .brk attribute in linker script

Michael Roth (1):
      x86/compressed/64: Add identity mappings for setup_data entries

Peter Zijlstra (1):
      x86/ibt, objtool: Don't discard text references from tracepoint section

 arch/x86/boot/compressed/ident_map_64.c | 13 +++++++++++++
 arch/x86/include/asm/setup.h            |  3 +++
 arch/x86/include/uapi/asm/bootparam.h   |  2 +-
 arch/x86/kernel/head64.c                |  4 +++-
 arch/x86/kernel/vmlinux.lds.S           |  2 +-
 arch/x86/xen/enlighten_pv.c             |  8 ++++++--
 arch/x86/xen/xen-head.S                 | 10 +---------
 tools/objtool/check.c                   |  3 +--
 8 files changed, 29 insertions(+), 16 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
