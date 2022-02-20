Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8E4BCE6E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 13:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbiBTMWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 07:22:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiBTMWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:22:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5993BBE2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 04:22:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 500981F384;
        Sun, 20 Feb 2022 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645359734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WHh5bhUmbAtH0FtEZ+18Ex0QzFzQh85hJHXiLLwjy6k=;
        b=NyPRKBasTyLm4SbcV3Uf9s8Bkr24O//8v7NIjmjG2c7DlBSjJ5IO8T0PwEmaLpOq6wZrue
        EkW3rzNPiGwKpgmASWQuUeJqPtk5XMKxEnMgW0l+brzm5M/EHDo9XtfZlOw0iCs9+4sMta
        5esOeFylkczCi1JSX7fbr67Vp0v5jQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645359734;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WHh5bhUmbAtH0FtEZ+18Ex0QzFzQh85hJHXiLLwjy6k=;
        b=8Ypr47QFKg/oaUyqx1stbRddiumq/Ye0/Ea00LWlCiEpqlOrTz3JgghFVaCGGEzo02uIq/
        srHMZC5dXpuRX6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 339CF13398;
        Sun, 20 Feb 2022 12:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5PQNDHYyEmIHJwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 20 Feb 2022 12:22:14 +0000
Date:   Sun, 20 Feb 2022 13:22:17 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 5.17
Message-ID: <YhIyee8tl5YatX36@zn.tnic>
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

please pull two urgent x86 fixes for 5.17.

Thx.

---

The following changes since commit 8795359e35bc33bf86b6d0765aa7f37431db3b9c:

  x86/sgx: Silence softlockup detection when releasing large enclaves (2022-02-10 15:58:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc5

for you to fetch changes up to 44cad52cc14ae10062f142ec16ede489bccf4469:

  x86/ptrace: Fix xfpregs_set()'s incorrect xmm clearing (2022-02-18 11:23:21 +0100)

----------------------------------------------------------------
- Fix the ptrace regset xfpregs_set() callback to behave according to the ABI

- Handle poisoned pages properly in the SGX reclaimer code

----------------------------------------------------------------
Andy Lutomirski (1):
      x86/ptrace: Fix xfpregs_set()'s incorrect xmm clearing

Reinette Chatre (1):
      x86/sgx: Fix missing poison handling in reclaimer

 arch/x86/kernel/cpu/sgx/main.c | 10 +---------
 arch/x86/kernel/fpu/regset.c   |  9 ++++-----
 arch/x86/kernel/ptrace.c       |  4 ++--
 3 files changed, 7 insertions(+), 16 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
