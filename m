Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3522E4A35E2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345648AbiA3LP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:15:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60956 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbiA3LP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:15:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A51A221114;
        Sun, 30 Jan 2022 11:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643541356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J9lhn0uS+BJFxrOTNGJE/YbFczg9NMC5ATdYqM2tm5E=;
        b=PYWT79vAgKhxK5G6iB2T/FIchLyagWpMfXySUf6z6QBj+DVRlP7hKYsNJ4VCkuJCOwmykk
        +S5Dr1JFvf21EQlGkmdWX3OyTkr2N/W0Rc9ROuicjredPC8JQFsgQFpSFgMod1Hv/wJfnl
        okInFBIg+kTRQhOSIXYRcd9s9MgshN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643541356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J9lhn0uS+BJFxrOTNGJE/YbFczg9NMC5ATdYqM2tm5E=;
        b=ZufE4OHF+8mr8fyzkT4SBv6RIh1QsgW8Iv/LAPZpQlQAi8tgF0T0HzT7N1bnJIXPXOsXud
        Ff40W0dGi1E4gHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8972F13638;
        Sun, 30 Jan 2022 11:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A3odIWxz9mF1bwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 30 Jan 2022 11:15:56 +0000
Date:   Sun, 30 Jan 2022 12:15:52 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.17-rc2
Message-ID: <YfZzaI5/7OCaFBoh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two urgent perf fixes for v5.17.

Thx.

---

The following changes since commit 8c16dc047b5dd8f7b3bf4584fa75733ea0dde7dc:

  x86/perf: Avoid warning for Arch LBR without XSAVE (2022-01-18 12:09:49 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc2_p2

for you to fetch changes up to c5de60cd622a2607c043ba65e25a6e9998a369f9:

  perf/core: Fix cgroup event list management (2022-01-26 15:06:06 +0100)

----------------------------------------------------------------
- Prevent accesses to the per-CPU cgroup context list from another CPU
except the one it belongs to, to avoid list corruption

- Make sure parent events are always woken up to avoid indefinite hangs
in the traced workload

----------------------------------------------------------------
James Clark (1):
      perf: Always wake the parent event

Namhyung Kim (1):
      perf/core: Fix cgroup event list management

 kernel/events/core.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
