Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919544B3B57
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiBMMll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:41:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiBMMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:41:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C58F5B3C1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:41:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB6811F384;
        Sun, 13 Feb 2022 12:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644756091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HaO+0d4Pdodo97yyUDuHWuvwFSSOuyipWPmoQCN6pqg=;
        b=C59h/uQFoWSN/ChlaUjGh94ZwS0bkuW8uKlOPGkFnQCrQP7LISPWYpRKSAtaZSd4wM2Ys6
        efg2LsYRrAx64I54r6kZYINMU+bSlk1bg++UnMYeC/uO3S8N1Bo7WiVQePDKWTXhvjXLdI
        rhJZiSva6OOOiioSq5GRdK5YgrwmSxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644756091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HaO+0d4Pdodo97yyUDuHWuvwFSSOuyipWPmoQCN6pqg=;
        b=2aBiLtGnGXG59FeMFUGUIrYmcgjaCFcNcz0JTGcMVV48psksFlwUI6HFY0qubhPkXI6g2+
        TBY9/ubfTial1PDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE8EA1331A;
        Sun, 13 Feb 2022 12:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S1f0MXv8CGLVQQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 13 Feb 2022 12:41:31 +0000
Date:   Sun, 13 Feb 2022 13:41:37 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for 5.17-rc4
Message-ID: <Ygj8gS3RoDHJ065K@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent objtool fix for 5.17.

Thx.

---

The following changes since commit 82880283d7fcd0a1d20964a56d6d1a5cc0df0713:

  objtool: Fix truncated string warning (2022-01-24 10:09:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.17_rc4

for you to fetch changes up to bfb1a7c91fb7758273b4a8d735313d9cc388b502:

  x86/bug: Merge annotate_reachable() into _BUG_FLAGS() asm (2022-02-02 14:41:04 -0800)

----------------------------------------------------------------
- Fix a case where objtool would mistakenly warn about instructions being unreachable

----------------------------------------------------------------
Nick Desaulniers (1):
      x86/bug: Merge annotate_reachable() into _BUG_FLAGS() asm

 arch/x86/include/asm/bug.h | 20 +++++++++++---------
 include/linux/compiler.h   | 21 +++++----------------
 2 files changed, 16 insertions(+), 25 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
