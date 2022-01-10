Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5674D48965B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbiAJKan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:30:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42732 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiAJKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:30:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3689B21108;
        Mon, 10 Jan 2022 10:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641810639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=77L+gjQ4NobeEwnYjyPWAkLhsp5uQeDQyUT2GPoSEXI=;
        b=sKNRDyBazgeOluVV+IsxDKjqS8J35bLWiNhz0RxRcWs0XJ2vWqUHjMEjswpCZO1BKtpY5w
        /eZ9F1ZVDtRYAS6K/pEgpA+J3dEaGPqyRzt65UgD1AceFWH2TxCxinoe5lKcWZ/vKX6HX9
        MD0+wC+08hxUFAHqJiS2t2BxvJ1uY2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641810639;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=77L+gjQ4NobeEwnYjyPWAkLhsp5uQeDQyUT2GPoSEXI=;
        b=vY/3VX6jI8o/gCDtJoFeNRucfHO7zerWDctMbXYsNshpWlpVwXd3dqoDEsMLVjI+XrzuHC
        ziSrL0S2xRO0FpBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F01913CCB;
        Mon, 10 Jan 2022 10:30:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ux11Bs8K3GHEUAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 10:30:39 +0000
Date:   Mon, 10 Jan 2022 11:30:46 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v5.17
Message-ID: <YdwK1rME5ufAJdHG@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the accumulated pile of x86/sev generalizations and cleanups,
for 5.17.

Thx.

---

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.17_rc1

for you to fetch changes up to 20f07a044a76aebaaa0603038857229b5c460d69:

  x86/sev: Move common memory encryption code to mem_encrypt.c (2021-12-08 16:49:53 +0100)

----------------------------------------------------------------
- Share the SEV string unrolling logic with TDX as TDX guests need it too

- Cleanups and generalzation of code shared by SEV and TDX

----------------------------------------------------------------
Borislav Petkov (3):
      x86/sev: Get rid of excessive use of defines
      x86/head64: Carve out the guest encryption postprocessing into a helper
      x86/sev: Remove do_early_exception() forward declarations

Brijesh Singh (1):
      x86/sev: Shorten GHCB terminate macro names

Kirill A. Shutemov (1):
      x86/sev: Move common memory encryption code to mem_encrypt.c

Kuppuswamy Sathyanarayanan (2):
      x86/sev: Use CC_ATTR attribute to generalize string I/O unroll
      x86/sev: Rename mem_encrypt.c to mem_encrypt_amd.c

 arch/x86/Kconfig                  |  10 +-
 arch/x86/boot/compressed/sev.c    |   6 +-
 arch/x86/include/asm/io.h         |  20 +-
 arch/x86/include/asm/sev-common.h |  55 ++---
 arch/x86/kernel/cc_platform.c     |   8 +
 arch/x86/kernel/head64.c          |  60 +++---
 arch/x86/kernel/sev-shared.c      |   2 +-
 arch/x86/kernel/sev.c             |  11 +-
 arch/x86/mm/Makefile              |   7 +-
 arch/x86/mm/mem_encrypt.c         | 441 +-------------------------------------
 arch/x86/mm/mem_encrypt_amd.c     | 438 +++++++++++++++++++++++++++++++++++++
 include/linux/cc_platform.h       |  11 +
 12 files changed, 545 insertions(+), 524 deletions(-)
 create mode 100644 arch/x86/mm/mem_encrypt_amd.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
