Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860C4530EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiEWMTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiEWMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:19:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D426108
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:19:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD9B91F8B2;
        Mon, 23 May 2022 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653308378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fGYYa6nRFGU3+ZJQjVuDwYC6gqTJ6sBjUL9f/vn56Zs=;
        b=E8dlksgugtse3ZUXnpBDbhV8cX1B7roDY0ROYBJpd6PiRF9EuB7lefUW8UwurycGT3Ovg+
        O0GZiqV5LspdY0+Jm07vNoMz/appucd2hDCjGQJl+QxIk/Ook9iBmg6yV4JHjLZ1EoVD8V
        57sdRM91N9W6rI/9JPP12xl4jjHl5QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653308378;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fGYYa6nRFGU3+ZJQjVuDwYC6gqTJ6sBjUL9f/vn56Zs=;
        b=xy+teTCn3NtuBZDBreAROojY8GyAOuayPzFk4Zw9pfTnh7G8eyJ2THl/MntJxgeRXV3jzK
        3ASvCmOU0uc47WBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A011913AA5;
        Mon, 23 May 2022 12:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H1MLJ9p7i2J/NwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 12:19:38 +0000
Date:   Mon, 23 May 2022 14:19:34 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/asm for 5.19
Message-ID: <Yot71lIAXOrrh390@zn.tnic>
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

please pull a set of x86/asm changes for 5.19.

Thx.

---

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v5.19_rc1

for you to fetch changes up to 036c07c0c3b8a57d5c96e1f2aab62da0056f8f21:

  x86/entry: Fix register corruption in compat syscall (2022-05-19 23:46:08 +0200)

----------------------------------------------------------------
- A bunch of changes towards streamlining low level asm helpers' calling
conventions so that former can be converted to C eventually

- Simplify PUSH_AND_CLEAR_REGS so that it can be used at the system call
entry paths instead of having opencoded, slightly different variants of it
everywhere

- Misc other fixes

----------------------------------------------------------------
Josh Poimboeuf (2):
      x86/mm: Simplify RESERVE_BRK()
      x86/entry: Fix register corruption in compat syscall

Lai Jiangshan (6):
      x86/traps: Use pt_regs directly in fixup_bad_iret()
      x86/entry: Switch the stack after error_entry() returns
      x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
      x86/entry: Move CLD to the start of the idtentry macro
      x86/entry: Don't call error_entry() for XENPV
      x86/entry: Convert SWAPGS to swapgs and remove the definition of SWAPGS

Linus Torvalds (1):
      x86/entry: Simplify entry_INT80_compat()

Peter Zijlstra (4):
      x86/entry: Use PUSH_AND_CLEAR_REGS for compat
      x86/entry: Remove skip_r11rcx
      linkage: Fix issue with missing symbol size
      objtool: Fix STACK_FRAME_NON_STANDARD reloc type

 arch/x86/entry/calling.h         |  19 +++----
 arch/x86/entry/entry_64.S        |  56 ++++++++++++++-------
 arch/x86/entry/entry_64_compat.S | 106 +++++----------------------------------
 arch/x86/include/asm/irqflags.h  |   8 ---
 arch/x86/include/asm/setup.h     |  30 ++++-------
 arch/x86/include/asm/traps.h     |   2 +-
 arch/x86/kernel/traps.c          |  19 +++----
 include/linux/linkage.h          |  15 +++---
 include/linux/objtool.h          |   4 +-
 tools/include/linux/objtool.h    |   4 +-
 10 files changed, 86 insertions(+), 177 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
