Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A1B5310AF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiEWLQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiEWLQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:16:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC4F1CB0C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:16:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 47E651F8FD;
        Mon, 23 May 2022 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653304584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=osNSrIPXY09fGkSFVEOSIUevjz9NOSj6xAWdAdPTl+Q=;
        b=LCwXhryHeLWH5pqsLjhIwE8bmmzZql0XGhEhI1Ez10CThISanv1CBaYDLNTxdAJFt6qpZB
        e/Vgb7juQz2LOLyVN/orvXPxCRDv9COOU8XwWAXtYuftMCs5dLVA8l7yLj2CYv+/ipVcKb
        2+a06/m+sEIk1Du0kVUzJMr7m8WVKzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653304584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=osNSrIPXY09fGkSFVEOSIUevjz9NOSj6xAWdAdPTl+Q=;
        b=pDxJaHInSsSGG2Cl4An+E7pFFkrNUH6qSUA/bSyBcoNnppFkmvxmWU4NyE+zXLQNaeympf
        59MXEGWY7k6wdxAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C24D139F5;
        Mon, 23 May 2022 11:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dz6cDghti2KMGgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 11:16:24 +0000
Date:   Mon, 23 May 2022 13:16:20 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for 5.19
Message-ID: <YottBBImBRUl5LQS@zn.tnic>
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

please pull a couple of RAS updates for 5.19.

Thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.19_rc1

for you to fetch changes up to fa619f5156cf1ee3773edc6d756be262c9ef35de:

  x86/mce: Add messages for panic errors in AMD's MCE grading (2022-04-25 12:40:48 +0200)

----------------------------------------------------------------
- Simplification of the AMD MCE error severity grading logic along with
supplying critical panic MCEs with accompanying error messages for more
human-friendly diagnostics.

- Misc fixes

----------------------------------------------------------------
Ammar Faizi (1):
      x86/MCE/AMD: Fix memory leak when threshold_create_bank() fails

Carlos Bilbao (2):
      x86/mce: Simplify AMD severity grading logic
      x86/mce: Add messages for panic errors in AMD's MCE grading

Smita Koralahalli (1):
      x86/mce: Avoid unnecessary padding in struct mce_bank

 arch/x86/kernel/cpu/mce/amd.c      |  32 ++++++-----
 arch/x86/kernel/cpu/mce/core.c     |   4 +-
 arch/x86/kernel/cpu/mce/severity.c | 110 +++++++++++++++----------------------
 3 files changed, 67 insertions(+), 79 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
