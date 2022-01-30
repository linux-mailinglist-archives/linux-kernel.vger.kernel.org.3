Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB64A35D8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbiA3LFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:05:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60430 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbiA3LFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:05:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD2ED210EC;
        Sun, 30 Jan 2022 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643540707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OHhao62KLHhXtqWAwn27cKd/D9JLkg+9zShZGXM6hhU=;
        b=c/OqZe4wUm1lQ6pDGaQF/sHL644Zlu2LEZTXMh6OH2ehI1YA+SPJAhzj2q5+u2/tA1Wm49
        4JKFo8+xOBjgoJ3hESAzfUZoeDS2t6RP9/CCqSeFBy5PWwtimQREekbtorcN52rAxPllFj
        cg2MxDrIIFS0asq61LQW4CusynxO3RQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643540707;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OHhao62KLHhXtqWAwn27cKd/D9JLkg+9zShZGXM6hhU=;
        b=WNOdXm0+sb1FI8IwYUimWbRsNwiD/oVR0yB0Rs3zNGDOjfsl7IOnFwOe38xmBTESbt3aF4
        UjpzO0XlSCyAZ+Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1C9B13638;
        Sun, 30 Jan 2022 11:05:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o2YcJ+Nw9mFqbAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 30 Jan 2022 11:05:07 +0000
Date:   Sun, 30 Jan 2022 12:05:02 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.17-rc2
Message-ID: <YfZw3s6XOmj9rtq1@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent scheduler fix for 5.17.

Thx.

---

The following changes since commit 0e3872499de1a1230cef5221607d71aa09264bd5:

  kernel/sched: Remove dl_boosted flag comment (2022-01-18 12:10:00 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc2_p2

for you to fetch changes up to 809232619f5b15e31fb3563985e705454f32621f:

  sched/membarrier: Fix membarrier-rseq fence command missing from query bitmask (2022-01-25 22:30:25 +0100)

----------------------------------------------------------------
- Make sure the membarrier-rseq fence commands are part of the reported
set when querying membarrier(2) commands through MEMBARRIER_CMD_QUERY

----------------------------------------------------------------
Mathieu Desnoyers (1):
      sched/membarrier: Fix membarrier-rseq fence command missing from query bitmask

 kernel/sched/membarrier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
