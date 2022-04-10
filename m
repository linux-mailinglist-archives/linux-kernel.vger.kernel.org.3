Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855C34FAD4C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiDJKkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiDJKj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:39:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E37C2F00C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:37:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1293821112;
        Sun, 10 Apr 2022 10:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649587065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=o06aH5Wwm/wBPkhKlY5uWIbR23iz0C2sKU3U9zZmu9A=;
        b=swEx90bQ6B4wcKPwLHWTN+5yQ7469Xl9vvpzi6sFaDPcp8jkH5mw+3357AWi9IREzTjFiC
        d/C/zp0phP1g7EO3pD3TET2zrkzTS1vnvS3QY13yDiI01BbhpBZQI8f5XaEr54zgoCGaq5
        tyRtUZ8T99G+HKCAwFn+xgoEBchXhSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649587065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=o06aH5Wwm/wBPkhKlY5uWIbR23iz0C2sKU3U9zZmu9A=;
        b=+S4niASwVrD8PZD9jAgjAISlUUtI0FDf2HPBmkxrKgp1Xaq0uxUxi2D/nwz+9sS3U/qewA
        nhCuuvx9IPjplZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 057A913A91;
        Sun, 10 Apr 2022 10:37:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z4hTAXmzUmJ8IAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 10 Apr 2022 10:37:45 +0000
Date:   Sun, 10 Apr 2022 12:37:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.18-rc2
Message-ID: <YlKzdjk+VtarQ5pr@zn.tnic>
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

please pull a couple of urgent scheduler fixes for 5.18-rc2.

Thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.18_rc2

for you to fetch changes up to 0a70045ed8516dfcff4b5728557e1ef3fd017c53:

  entry: Fix compile error in dynamic_irqentry_exit_cond_resched() (2022-04-05 09:59:36 +0200)

----------------------------------------------------------------
- Use the correct static key checking primitive on the IRQ exit path

- Two fixes for the new forceidle balancer

----------------------------------------------------------------
Peter Zijlstra (1):
      sched/core: Fix forceidle balancing

Sebastian Andrzej Siewior (1):
      sched: Teach the forced-newidle balancer about CPU affinity limitation.

Sven Schnelle (1):
      entry: Fix compile error in dynamic_irqentry_exit_cond_resched()

 kernel/entry/common.c |  2 +-
 kernel/sched/core.c   | 16 +++++++++++-----
 kernel/sched/idle.c   |  1 -
 kernel/sched/sched.h  |  6 ------
 4 files changed, 12 insertions(+), 13 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
