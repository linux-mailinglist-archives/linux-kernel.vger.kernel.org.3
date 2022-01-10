Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444594896F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbiAJLE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:04:57 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47414 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbiAJLE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:04:56 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0955521127;
        Mon, 10 Jan 2022 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641812695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4S7c0FKwsET0W+q3yfTL2dN8Zp2p8wCdYWNs8YkmYiI=;
        b=ftSRycgP5an1NZ1ggTAwiGqpgR1NJVsIXIKWu69+2KJ/3aw3JJ8F0gbJOeWBnzhCFJHYsg
        UzPhSHCBcEizycXTZWyYSFdBNL70k4nmaAqUUoztB1R4d7sbYA9WqGY6MolNsaWhnvc8ql
        WJzwH3sFfr/pZsvDx2Ypv8kyaK/Vhm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641812695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4S7c0FKwsET0W+q3yfTL2dN8Zp2p8wCdYWNs8YkmYiI=;
        b=3o16tLX12yGJ6T32JpXNvVfZqAAZfv//hBP0mRu7633ewor8BNYCTnY0MVy71I3DI742bm
        ngMI4TXbAO4vKCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6CEF13A98;
        Mon, 10 Jan 2022 11:04:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UjvGNtYS3GGMYwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 11:04:54 +0000
Date:   Mon, 10 Jan 2022 12:05:02 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for v5.17
Message-ID: <YdwS3jGM29IWz5vq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the pile which we cannot find the proper topic for so we
stick it in x86/misc, for 5.17.

Thx.

---

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.17_rc1

for you to fetch changes up to 4d5cff69fbddbbefef2903faa48263cc5d3ca382:

  x86/mtrr: Remove the mtrr_bp_init() stub (2021-12-22 19:50:26 +0100)

----------------------------------------------------------------
- Add support for decoding instructions which do MMIO accesses in order
to use it in SEV and TDX guests

- An include fix and reorg to allow for removing set_fs in UML later

----------------------------------------------------------------
Christoph Hellwig (1):
      x86/mtrr: Remove the mtrr_bp_init() stub

Kirill A. Shutemov (4):
      x86/insn-eval: Handle insn_get_opcode() failure
      x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
      x86/insn-eval: Introduce insn_decode_mmio()
      x86/sev-es: Use insn_decode_mmio() for MMIO implementation

 arch/x86/include/asm/insn-eval.h |  13 +++
 arch/x86/include/asm/mtrr.h      |   8 +-
 arch/x86/kernel/setup.c          |   7 +-
 arch/x86/kernel/sev.c            | 172 ++++++++++-----------------------------
 arch/x86/kvm/mmu/spte.c          |   1 +
 arch/x86/lib/insn-eval.c         | 109 ++++++++++++++++++++++++-
 6 files changed, 169 insertions(+), 141 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
