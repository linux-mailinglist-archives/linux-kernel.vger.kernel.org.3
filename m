Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C450D0FB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiDXKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiDXKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:06:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5F1174430
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:03:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33CAE210EA;
        Sun, 24 Apr 2022 10:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650794592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9LLD+iTz0yZM84SOfGGfYeIkDQx1NxGJm4CTFo6b/Ws=;
        b=VUWAriDdhCJUg7IHwEEFYdNPBB+hJ24YgoiAbvEugNcVB5nnnosjERpWnnVdVdUvHPo6pv
        KkzNJmWlspCdXYWyltN6cD6ChjIKRS/EG50dpcmT6G1Mrerc4j0mqhVcELUdpIGwGTvjjm
        Q5txyIpalVT6AZ0GLNS2urKfIOXyPMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650794592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9LLD+iTz0yZM84SOfGGfYeIkDQx1NxGJm4CTFo6b/Ws=;
        b=Zw2uqeGNqOINnYnKpnX65z4mWLZSgTVk9Ntr6QdeReqsKdyzdRiF26ThfM6CXuNT4820mU
        v8JXSoO5arz3njCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2201F13AE0;
        Sun, 24 Apr 2022 10:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id diJHCGAgZWK2KAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 24 Apr 2022 10:03:12 +0000
Date:   Sun, 24 Apr 2022 12:03:12 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for 5.18-rc4
Message-ID: <YmUgYLZF8ptmhyj/@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two urgent fixes to the perf side of things, for 5.18.

Thx.

---

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.18_rc4

for you to fetch changes up to 528c9f1daf20da14d3e7348dc4b1d7c55743ee64:

  perf/x86/cstate: Add SAPPHIRERAPIDS_X CPU support (2022-04-19 21:15:42 +0200)

----------------------------------------------------------------
- Add Sapphire Rapids CPU support

- Fix a perf vmalloc-ed buffer mapping error (PERF_USE_VMALLOC in use)

----------------------------------------------------------------
Zhang Rui (1):
      perf/x86/cstate: Add SAPPHIRERAPIDS_X CPU support

Zhipeng Xie (1):
      perf/core: Fix perf_mmap fail when CONFIG_PERF_USE_VMALLOC enabled

 arch/x86/events/intel/cstate.c | 7 ++++---
 kernel/events/core.c           | 2 +-
 kernel/events/internal.h       | 5 +++++
 kernel/events/ring_buffer.c    | 5 -----
 4 files changed, 10 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
