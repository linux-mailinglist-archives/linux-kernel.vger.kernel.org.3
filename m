Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C547A0BC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 14:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhLSNzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 08:55:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52138 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhLSNzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 08:55:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9FABF218ED;
        Sun, 19 Dec 2021 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639922140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7cqYdkVsOhr9ryCTL+eH+l4+vyqhXTF3ELAuoW5J6QE=;
        b=iHZtmRwVNgBzlMVaVPT54Q9PfmR9lN9zVy22r3r3gynQUKbiV9cMD25sIH/Sl+QTgpsBiB
        bBjj19eqkm2YUI1U1oENdxPy7QgfmU+eiyzxK+tWR/B9y+XPPaxQM48NwCIfZR9RO+BsUK
        n0p+vMhBT2QG1Kl/hHDcMv0QWuiAxbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639922140;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7cqYdkVsOhr9ryCTL+eH+l4+vyqhXTF3ELAuoW5J6QE=;
        b=K95H6S3gEZm0K0pdtV4TTXNGT5rrB4VnHm3iC/dq/VfteqDEpl8SzLwyoYP7k8u0XMayVS
        sKruqKkP8XKc77BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89084133FE;
        Sun, 19 Dec 2021 13:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iRvrH9w5v2EFRQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 19 Dec 2021 13:55:40 +0000
Date:   Sun, 19 Dec 2021 14:55:47 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v5.16-rc6
Message-ID: <Yb8542TP03zYwspz@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

aaand the next one: a single urgent timers fix for 5.16.

Please pull,
thx.

---

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.16_rc6

for you to fetch changes up to 4e8c11b6b3f0b6a283e898344f154641eda94266:

  timekeeping: Really make sure wall_to_monotonic isn't positive (2021-12-17 23:06:22 +0100)

----------------------------------------------------------------
- Make sure the CLOCK_REALTIME to CLOCK_MONOTONIC offset is never positive

----------------------------------------------------------------
Yu Liao (1):
      timekeeping: Really make sure wall_to_monotonic isn't positive

 kernel/time/timekeeping.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
