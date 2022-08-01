Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95F5866CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiHAJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiHAJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:21:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9362B244
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:21:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C041A4D7E8;
        Mon,  1 Aug 2022 09:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659345711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vMi2hwWheywtw/LrB/EOjWmZwezokhwWRzlfnemFXcg=;
        b=WoxVxVyGDa6+bhf6Ox2mu8PYeMrXwZP5Daeo5doNqXLWoWp8GEMXiMgzwg/5xtphY5GtDL
        0aZKXd9rLP4upuEw87UhBazub5kJ197r3lLjLpvw8nVP35aTHBaCpJ9Ybf1dW7/9dNUM6t
        vaGxadYghvYsaKgFMZDYpk9usdTL3pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659345711;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vMi2hwWheywtw/LrB/EOjWmZwezokhwWRzlfnemFXcg=;
        b=uzhm630MFuyMbigEWkDdMvRhePc2k+XEaYDDrHRZlsPaBAGQsgkqWwm46TIPUdPpSh3f+A
        ndx3uVkKy1QVCkDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B37EF13AAE;
        Mon,  1 Aug 2022 09:21:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HUDHKy+b52KpRgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Aug 2022 09:21:51 +0000
Date:   Mon, 1 Aug 2022 11:21:47 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/mm for v6.0
Message-ID: <YuebK2LYy6INgX5E@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the small x86/mm lineup for 6.0.

Thx.

---

The following changes since commit e19d11267f0e6c8aff2d15d2dfed12365b4c9184:

  x86/mm: Use PAGE_ALIGNED(x) instead of IS_ALIGNED(x, PAGE_SIZE) (2022-05-27 12:19:56 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v6.0_rc1

for you to fetch changes up to 8f1d56f64f8d6b80dea2d1978d10071132a695c5:

  x86/mm/tlb: Ignore f->new_tlb_gen when zero (2022-07-19 09:04:52 -0700)

----------------------------------------------------------------
- Rename a PKRU macro to make more sense when reading the code

- Update pkeys documentation

- Avoid reading contended mm's TLB generation var if not absolutely
necessary along with fixing a case where arch_tlbbatch_flush() doesn't
adhere to the generation scheme and thus violates the conditions for the
above avoidance.

----------------------------------------------------------------
Ira Weiny (2):
      Documentation/protection-keys: Clean up documentation for User Space pkeys
      x86/pkeys: Clarify PKRU_AD_KEY macro

Nadav Amit (2):
      x86/mm/tlb: Avoid reading mm_tlb_gen when possible
      x86/mm/tlb: Ignore f->new_tlb_gen when zero

 Documentation/core-api/protection-keys.rst | 44 ++++++++++++++----------------
 arch/x86/include/asm/tlbflush.h            |  1 +
 arch/x86/mm/pkeys.c                        | 15 ++++++----
 arch/x86/mm/tlb.c                          | 31 +++++++++++++++++++--
 4 files changed, 59 insertions(+), 32 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
