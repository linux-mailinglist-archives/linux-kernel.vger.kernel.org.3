Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20300468AAA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhLEMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 07:02:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59292 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhLEMCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 07:02:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6FAA51FDF2;
        Sun,  5 Dec 2021 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638705564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4mVn+p1DGZrHmdCbAYhctqxt2bfP+TBB9qxj7HfMeAQ=;
        b=vhhT+aYQUDG5D0+6yBFEBuanqlvwZA0FKfMCh8LvxHL8SO1If3BEStW3LssFklNOOLMh2C
        lfcWDtXewXyNhyPH0dj8E40ty9gnFTYDEncewksQKT41PurPxpbXvL1gp0X3tZdlvQ5LSS
        QiFDLHOHZbXlheUNFKe+af6VCbD5Sp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638705564;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4mVn+p1DGZrHmdCbAYhctqxt2bfP+TBB9qxj7HfMeAQ=;
        b=25zkLskPo/QkXAClIpl2PlC2dsfeQtldjr4uKmDlyVgZeY4H7l1TZCOgtx17jnbAEorpcc
        3kfzVOqxDphS2ZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D70C13466;
        Sun,  5 Dec 2021 11:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id euFlEZyprGGzYwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 05 Dec 2021 11:59:24 +0000
Date:   Sun, 5 Dec 2021 12:59:26 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v5.16-rc4
Message-ID: <YaypnuP+OlCi41w7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent timers fix for 5.16.

Thx.

---

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.16_rc4

for you to fetch changes up to 53e87e3cdc155f20c3417b689df8d2ac88d79576:

  timers/nohz: Last resort update jiffies on nohz_full IRQ entry (2021-12-02 15:07:22 +0100)

----------------------------------------------------------------
- Prevent a tick storm when a dedicated timekeeper CPU in nohz_full
mode runs for prolonged periods with interrupts disabled and ends up
programming the next tick in the past, leading to that storm

----------------------------------------------------------------
Frederic Weisbecker (1):
      timers/nohz: Last resort update jiffies on nohz_full IRQ entry

 kernel/softirq.c         | 3 ++-
 kernel/time/tick-sched.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
