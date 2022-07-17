Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0BC5774F8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiGQHbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 03:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGQHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 03:31:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65AB1902B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:31:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62D2C1FA26;
        Sun, 17 Jul 2022 07:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658043103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MLT/NPpfyGi4ykjzNNg+1YVCt7/83+XF1WH7XmFshGo=;
        b=tf8iHXmorI84P3LP77H5ewTXgksbCRRlhj7q5jHPfX0Ew0Wf68eE/CgES/zeDk2UQoKBUI
        q02/5hrV5Z4cXiAPYL9G9MN1J+r3Qe+GARUIiVU5TjffBkkfj4D47CtHKtZp7fzKyeT1+R
        qNuDli5G0gpwVe4SFCkTh/6LSXXlZP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658043103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MLT/NPpfyGi4ykjzNNg+1YVCt7/83+XF1WH7XmFshGo=;
        b=7n9NUq9Qm7lTI1MF9V/v1htLDSr6X6gnimbnUohfPG2Ju/z5MrW7dJ0vNydqvrNB4AYbm6
        dL7GgVxdkIhPMkDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F0B713A89;
        Sun, 17 Jul 2022 07:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a2C7Et+602IwcgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 17 Jul 2022 07:31:43 +0000
Date:   Sun, 17 Jul 2022 09:31:39 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 5.19-rc7
Message-ID: <YtO62/Za76bfGqIm@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of urgent x86 fixes for 5.19.

Thx.

---

The following changes since commit b047602d579b4fb028128a525f056bbdc890e7f0:

  Merge tag 'trace-v5.19-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2022-07-12 16:17:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19_rc7

for you to fetch changes up to bcf163150cd37348a0cb59e95c916a83a9344b0e:

  x86/bugs: Remove apostrophe typo (2022-07-16 11:39:23 +0200)

----------------------------------------------------------------
- Improve the check whether the kernel supports WP mappings so that it
can accomodate a XenPV guest due to how the latter is setting up the PAT
machinery

Now that the retbleed nightmare is public, here's the first round of
fallout fixes:

- Fix a build failure on 32-bit due to missing include

- Remove an untraining point in espfix64 return path

- other small cleanups

----------------------------------------------------------------
Alexandre Chartre (1):
      x86/entry: Remove UNTRAIN_RET from native_irq_return_ldt

Jiapeng Chong (1):
      x86/bugs: Mark retbleed_strings static

Jiri Slaby (1):
      x86/asm/32: Fix ANNOTATE_UNRET_SAFE use on 32-bit

Juergen Gross (1):
      x86/pat: Fix x86_has_pat_wp()

Kim Phillips (1):
      x86/bugs: Remove apostrophe typo

Peter Zijlstra (1):
      um: Add missing apply_returns()

 arch/um/kernel/um_arch.c   |  4 ++++
 arch/x86/entry/entry_64.S  |  1 -
 arch/x86/kernel/cpu/bugs.c |  4 ++--
 arch/x86/kernel/head_32.S  |  1 +
 arch/x86/mm/init.c         | 14 ++++++++++++--
 5 files changed, 19 insertions(+), 5 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
