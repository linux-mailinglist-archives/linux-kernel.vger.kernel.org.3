Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75732516442
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346195AbiEALsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbiEALsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:48:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF4C65A2
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 04:44:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 640961F37D;
        Sun,  1 May 2022 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651405493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=afNNYwqmWBDBkPlU4Xy/YeS3eNp32m6V8OM3KvQw8Fg=;
        b=tcfYnEBHY5Zl98wmMvYWpK035MhvQcYQCtFSKL2YGXHu6hIt/G+rsuKD7Af24zQGl108MC
        ZN2Ue72f1Ypndmt8WhuIcBlhKVtdRfcXTdcCNfCGAe/qJkN8fNmSlrFvZTCm2miABeycYY
        dfYNehtomvfbAX2umTcA0WBG4KiOEBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651405493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=afNNYwqmWBDBkPlU4Xy/YeS3eNp32m6V8OM3KvQw8Fg=;
        b=7khoWshJaKoE5c+TG9omWmT29u3Z3FCPMaSeJVIpwx0jXglyrzQTdhR4IZR/I49qnKexKt
        sWRmFqvtmXCQGNDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59DCE13AE0;
        Sun,  1 May 2022 11:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0dDmFbVybmK1MAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 01 May 2022 11:44:53 +0000
Date:   Sun, 1 May 2022 13:44:50 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for 5.18
Message-ID: <Ym5ysk8Eo4p+0YnU@zn.tnic>
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

please pull a couple of urgent objtool fixes for 5.18.

Thx.

---

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.18_rc5

for you to fetch changes up to 4abff6d48dbcea8200c7ea35ba70c242d128ebf3:

  objtool: Fix code relocs vs weak symbols (2022-04-22 12:13:55 +0200)

----------------------------------------------------------------
- A bunch of objtool fixes to improve unwinding, sibling call detection,
fallthrough detection and relocation handling of weak symbols when the
toolchain strips section symbols

----------------------------------------------------------------
Josh Poimboeuf (4):
      x86/uaccess: Don't jump between functions
      objtool: Don't set 'jump_dest' for sibling calls
      objtool: Fix sibling call detection in alternatives
      objtool: Fix function fallthrough detection for vmlinux

Peter Zijlstra (2):
      objtool: Fix type of reloc::addend
      objtool: Fix code relocs vs weak symbols

 arch/x86/lib/copy_user_64.S             |  87 +++++++++------
 tools/objtool/check.c                   |  81 +++++++-------
 tools/objtool/elf.c                     | 189 ++++++++++++++++++++++++++++----
 tools/objtool/include/objtool/elf.h     |   4 +-
 tools/objtool/include/objtool/objtool.h |   2 +-
 tools/objtool/objtool.c                 |   1 -
 6 files changed, 265 insertions(+), 99 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
