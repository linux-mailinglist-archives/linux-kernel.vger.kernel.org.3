Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917F04FADA8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 13:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbiDJLcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 07:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiDJLcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 07:32:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D763CFF0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 04:29:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15A181F37E;
        Sun, 10 Apr 2022 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649590196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pBIT8vw1LI1YI8dUIX9KBclL0vwj1TDfqum0psBMYFY=;
        b=OcLfGyOW1ufhItB5seE4mt7/ayGxtVQkmVWCB4IRqM14emVCOnLBvi069Ru5YqDMJEwKQB
        AkO4gRz5S35LUY5OQ3CB0aNr3fmCO07fxtYCGxWqPyUKbFbrx8x5Qgu4Z3liWaXsLQ665X
        j9JeI4VU/3VV2lupdZibl+S6RaQmUek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649590196;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pBIT8vw1LI1YI8dUIX9KBclL0vwj1TDfqum0psBMYFY=;
        b=CdsPk99FgsqDiPbmSiOcqT0IuDiWj3+U2FHx/Mngw+XRgnmVe2Emx5I4U5OpEKNtpa29Nt
        HYzixAIukXg8m4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0292413314;
        Sun, 10 Apr 2022 11:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wZ6TO7O/UmKoKgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 10 Apr 2022 11:29:55 +0000
Date:   Sun, 10 Apr 2022 13:29:55 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.18-rc2
Message-ID: <YlK/syONzEUgRsgV@zn.tnic>
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

somewhat more urgent perf fixes for 5.18-rc2 but that's normal, I guess,
considering we're still early in the cycle.

Please pull,
thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.18_rc2

for you to fetch changes up to e19cd0b6fa5938c51d7b928010d584f0de93913a:

  perf/core: Always set cpuctx cgrp when enable cgroup event (2022-04-05 09:59:45 +0200)

----------------------------------------------------------------
- A couple of fixes to cgroup-related handling of perf events

- A couple of fixes to event encoding on Sapphire Rapids

- Pass event caps of inherited events so that perf doesn't fail wrongly at fork()

- Add support for a new Raptor Lake CPU

----------------------------------------------------------------
Chengming Zhou (4):
      perf/core: Don't pass task around when ctx sched in
      perf/core: Use perf_cgroup_info->active to check if cgroup is active
      perf/core: Fix perf_cgroup_switch()
      perf/core: Always set cpuctx cgrp when enable cgroup event

Kan Liang (6):
      perf/x86: Add Intel Raptor Lake support
      perf/x86/cstate: Add Raptor Lake support
      perf/x86/msr: Add Raptor Lake CPU support
      perf/x86/uncore: Add Raptor Lake uncore support
      perf/x86/intel: Don't extend the pseudo-encoding to GP counters
      perf/x86/intel: Update the FRONTEND MSR mask on Sapphire Rapids

Namhyung Kim (1):
      perf/core: Inherit event_caps

 arch/x86/events/intel/core.c       |   9 +-
 arch/x86/events/intel/cstate.c     |  22 ++--
 arch/x86/events/intel/uncore.c     |   1 +
 arch/x86/events/intel/uncore_snb.c |  20 ++++
 arch/x86/events/msr.c              |   1 +
 arch/x86/include/asm/perf_event.h  |   5 +
 kernel/events/core.c               | 212 ++++++++++---------------------------
 7 files changed, 101 insertions(+), 169 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
