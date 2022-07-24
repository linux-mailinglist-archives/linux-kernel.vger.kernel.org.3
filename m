Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B080B57F441
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiGXJF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 05:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGXJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 05:05:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9448F5AF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 02:05:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BACC343E3;
        Sun, 24 Jul 2022 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658653554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=icWguinNdv2tLZI7utBPPQIv3Li+zlifa1Q6cdj52oI=;
        b=JcrITGjQRAuLXq8eIzLmafNw2wbD/9NDSn+zmTBOxxNEkNnrflc5xJ6sknfcKkZbeFgazV
        /hWEW8IFDcmoabRbp+MVNdIDeWhAWfveEpYRQF4sV0YMNwqpWmF247EVG1Niulf71YGjYp
        b0C+KKyIxB8rW0dgqd4X1vAN4mNKlwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658653554;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=icWguinNdv2tLZI7utBPPQIv3Li+zlifa1Q6cdj52oI=;
        b=/IlngSDlAdjkBtZRxxPW7moMKu6qyajdm9PHrQLpUo9wAeaHmcmjLSUKNNTG3LGB9/X9mT
        lK0ke4f7IbCCVGDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 689C713A8D;
        Sun, 24 Jul 2022 09:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7AThGHIL3WIQRwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 24 Jul 2022 09:05:54 +0000
Date:   Sun, 24 Jul 2022 11:05:49 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.19-rc8
Message-ID: <Yt0LbbTNZyrM0pVw@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple more retbleed fallout fixes.

It looks like their urgency is decreasing so it seems like we've managed
to catch whatever snafus the limited -rc testing has exposed. Maybe
we're getting ready... :)

Thx.

---

The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19_rc8

for you to fetch changes up to b648ab487f31bc4c38941bc770ea97fe394304bb:

  x86/speculation: Make all RETbleed mitigations 64-bit only (2022-07-23 18:45:11 +0200)

----------------------------------------------------------------
- Make retbleed mitigations 64-bit only (32-bit will need a bit more
work if even needed, at all).

- Prevent return thunks patching of the LKDTM modules as it is not needed there

- Avoid writing the SPEC_CTRL MSR on every kernel entry on eIBRS parts

- Enhance error output of apply_returns() when it fails to patch a return thunk

- A sparse fix to the sev-guest module

- Protect EFI fw calls by issuing an IBPB on AMD

----------------------------------------------------------------
Ben Hutchings (1):
      x86/speculation: Make all RETbleed mitigations 64-bit only

Josh Poimboeuf (1):
      lkdtm: Disable return thunks in rodata.c

Kees Cook (1):
      x86/alternative: Report missing return thunk details

Pawan Gupta (1):
      x86/bugs: Warn when "ibrs" mitigation is selected on Enhanced IBRS parts

Peter Zijlstra (1):
      x86/amd: Use IBPB for firmware calls

Tom Lendacky (1):
      virt: sev-guest: Pass the appropriate argument type to iounmap()

 arch/x86/Kconfig                        |  8 ++++----
 arch/x86/Makefile                       |  1 +
 arch/x86/include/asm/cpufeatures.h      |  1 +
 arch/x86/include/asm/nospec-branch.h    |  2 ++
 arch/x86/kernel/alternative.c           |  4 +++-
 arch/x86/kernel/cpu/bugs.c              | 14 +++++++++++++-
 drivers/misc/lkdtm/Makefile             |  9 ++++++---
 drivers/virt/coco/sev-guest/sev-guest.c |  9 ++++++---
 8 files changed, 36 insertions(+), 12 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
