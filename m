Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6553168A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiEWUUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiEWUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:20:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C0BCEA3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:20:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 96F871F747;
        Mon, 23 May 2022 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653337204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XJCNExi0Kdr0ah2fgcly/f0TPgzz4ig+wetVhpC6XPw=;
        b=v1HQWTpsWnatXa6J8QZwOeVGjXslQk55RZjF+kVdYiy/6ND4mFsN2jUHSgVlm/Yd82uLL9
        Lky4u51sYyDIgev6UL7yblzbnC0+vHa02YITHA0d0oCYcelvFOQr8o4CNKQEMw8N4AzbAv
        cH4B4TjgxdGGRbBjb4lZAe4NEMLEXbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653337204;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XJCNExi0Kdr0ah2fgcly/f0TPgzz4ig+wetVhpC6XPw=;
        b=sUeFxIubwXtKDF31HEZ+y79SiMTEIl8ISgqCSyB7+AXpYISM1AHFSmEWq31Kmm2y7FHnoZ
        VNlDlJdfDL52pwBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A6A4139F5;
        Mon, 23 May 2022 20:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id davJIXTsi2LfBgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 20:20:04 +0000
Date:   Mon, 23 May 2022 22:20:04 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/vdso for 5.19
Message-ID: <YovsdAxZsUWxGVl4@zn.tnic>
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

phew, this is the last one:

please pull a single x86/vdso change for 5.19.

Thx.

---

The following changes since commit c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a:

  Linux 5.18-rc6 (2022-05-08 13:54:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vdso_for_v5.19_rc1

for you to fetch changes up to bf00745e7791fe2ba7941aeead8528075a158bbe:

  x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE (2022-05-11 20:39:31 +0200)

----------------------------------------------------------------
- Get rid of CONFIG_LEGACY_VSYSCALL_EMULATE as nothing should be using it anymore

----------------------------------------------------------------
Andy Lutomirski (1):
      x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE

 arch/x86/Kconfig                      | 18 +++---------------
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 2 files changed, 4 insertions(+), 16 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
