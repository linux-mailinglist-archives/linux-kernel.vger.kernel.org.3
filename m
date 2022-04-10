Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982EA4FADAF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbiDJLjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 07:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiDJLjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 07:39:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE563BE6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 04:37:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58F9321112;
        Sun, 10 Apr 2022 11:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649590662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Hkv8m3K+VW4WmELJevvyDNlJTqaxAXuRTw2IgJ1x10=;
        b=X4Nja/ZzLFL8ztw9SOW0Z0rDG63dBdFvJRzhfXjBOxG6I53ZDJ7bP2DHOvFFjuWzJEG8Od
        rsbOzWHkEbfgIdFh3Y40Zv1XSUsvSuT5sNmSz7RRGDh9odfx9y8518Clt5AZW74VepoM2R
        iIh1z3MR5UMFThoDACnSqrOXfGIOBmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649590662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Hkv8m3K+VW4WmELJevvyDNlJTqaxAXuRTw2IgJ1x10=;
        b=FnLZiOtAR6Z+lY3oHReb37stdvIuLdclAzCehOODMn2Jduxn6MSt/8MmP9rUdEhzFgMVOR
        bN6ZGj7spki9PVAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BF6913314;
        Sun, 10 Apr 2022 11:37:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aeSCEobBUmIuLAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 10 Apr 2022 11:37:42 +0000
Date:   Sun, 10 Apr 2022 13:37:45 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.18-rc2
Message-ID: <YlLBiR9CNt5SchiE@zn.tnic>
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

please pull a couple of urgent x86 fixes for 5.18-rc2.

Thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.18_rc2

for you to fetch changes up to 59b18a1e65b7a2134814106d0860010e10babe18:

  x86/msi: Fix msi message data shadow struct (2022-04-07 15:19:32 +0200)

----------------------------------------------------------------
- Fix the MSI message data struct definition

- Use local labels in the exception table macros to avoid symbol
conflicts with clang LTO builds

- A couple of fixes to objtool checking of the relatively newly added
SLS and IBT code

- Rename a local var in the WARN* macro machinery to prevent shadowing

----------------------------------------------------------------
Dave Hansen (1):
      x86/mm/tlb: Revert retpoline avoidance approach

Nick Desaulniers (1):
      x86/extable: Prefer local labels in .set directives

Peter Zijlstra (3):
      objtool: Fix IBT tail-call detection
      objtool: Fix SLS validation for kcov tail-call replacement
      x86,bpf: Avoid IBT objtool warning

Reto Buerki (1):
      x86/msi: Fix msi message data shadow struct

Vincent Mailhol (1):
      x86/bug: Prevent shadowing in __WARN_FLAGS

 arch/x86/include/asm/asm.h  | 20 ++++++++++----------
 arch/x86/include/asm/bug.h  |  4 ++--
 arch/x86/include/asm/msi.h  | 19 +++++++++++--------
 arch/x86/mm/tlb.c           | 37 +++++--------------------------------
 arch/x86/net/bpf_jit_comp.c |  1 +
 tools/objtool/check.c       | 30 +++++++++++++++++++++++++-----
 6 files changed, 54 insertions(+), 57 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
