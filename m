Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD14FAD79
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiDJKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiDJKwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:52:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DCCB71
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:50:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 13882210E3;
        Sun, 10 Apr 2022 10:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649587809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VRfHxrwnwrYylk6U6GGxnItg+KZ+RukzcsLi2NYVXeg=;
        b=qMniKbuRlFAjI6Bv6+WzRuQ7ZB0LKnwjXn9bA9b/PDy9dH5sbK0fYDsp+jUc+NE7t+Rfxf
        56cuyeSv3OPBgn0xP5m+mO5KWwA99dfZ96DpZpxU83G8uEpfFPsNo+v2faPtxD8etnMDMj
        lkdZSdIs8Z6XkpyoeFmfnSUVjAp4K14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649587809;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VRfHxrwnwrYylk6U6GGxnItg+KZ+RukzcsLi2NYVXeg=;
        b=JwGyWXpnyK+/NGlKte1vSpaORY4+RB6EnIa52oDt1NSpycGcuQeDm1en8IVTlC3QAk2ogR
        p3IFs5d0z+fXgBDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07A6D13A91;
        Sun, 10 Apr 2022 10:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5nauAWG2UmI+IwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 10 Apr 2022 10:50:09 +0000
Date:   Sun, 10 Apr 2022 12:50:07 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v5.18-rc2
Message-ID: <YlK2X+uJ8C4H+N8p@zn.tnic>
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

please pull a bunch of urgent locking fixes for 5.18-rc2.

Thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.18_rc2

for you to fetch changes up to 273ba85b5e8b971ed28eb5c17e1638543be9237d:

  Revert "mm/page_alloc: mark pagesets as __maybe_unused" (2022-04-05 09:59:39 +0200)

----------------------------------------------------------------
- Allow the compiler to optimize away unused percpu accesses and change
the local_lock_* macros back to inline functions

- A couple of fixes to static call insn patching

----------------------------------------------------------------
Christophe Leroy (3):
      static_call: Don't make __static_call_return0 static
      static_call: Properly initialise DEFINE_STATIC_CALL_RET0()
      static_call: Remove __DEFINE_STATIC_CALL macro

Peter Zijlstra (1):
      x86,static_call: Fix __static_call_return0 for i386

Sebastian Andrzej Siewior (3):
      x86/percpu: Remove volatile from arch_raw_cpu_ptr().
      Revert "locking/local_lock: Make the empty local_lock_*() function a macro."
      Revert "mm/page_alloc: mark pagesets as __maybe_unused"

 arch/powerpc/include/asm/static_call.h |   1 +
 arch/x86/include/asm/percpu.h          |   6 +-
 arch/x86/include/asm/static_call.h     |   2 +
 arch/x86/kernel/static_call.c          |   5 +-
 include/linux/local_lock_internal.h    |   6 +-
 include/linux/static_call.h            |  48 +--
 kernel/Makefile                        |   3 +-
 kernel/static_call.c                   | 541 --------------------------------
 kernel/static_call_inline.c            | 543 +++++++++++++++++++++++++++++++++
 mm/page_alloc.c                        |   2 +-
 10 files changed, 585 insertions(+), 572 deletions(-)
 create mode 100644 kernel/static_call_inline.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
