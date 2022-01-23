Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A174970FB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 11:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiAWKox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 05:44:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50882 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiAWKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 05:44:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18D582170C;
        Sun, 23 Jan 2022 10:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642934690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XCSVlbQjDiXuPDZ+JjB48QyIV0g5I68mmeOJYtpfW4Y=;
        b=a+P15UtOVquT3crBR9KvesNaEOLmZNFMmHDkSWZYkQ83ZUKSkZMDiaMzTi8AQcYsgR7cEj
        vMHNhcxeDNk3U1H3OwI9M3Dmn3rldnX3sRAB29acxBv/nZ9dy3K6bBQRxi8MAano5Y07ye
        baeqmvf6BKtMHlZ3k/uLnUgxhwXfmOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642934690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XCSVlbQjDiXuPDZ+JjB48QyIV0g5I68mmeOJYtpfW4Y=;
        b=CwPmfyp429obyJ7PFd/+LsfCyywPkBm9ZNf9qgPLrbQGRzK4X1QtPGaHckhEeK+/wHwPdL
        938IRmOqIIN9JRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 008E41344B;
        Sun, 23 Jan 2022 10:44:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JwhiOqEx7WGPHQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 23 Jan 2022 10:44:49 +0000
Date:   Sun, 23 Jan 2022 11:44:44 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.17-rc2
Message-ID: <Ye0xnC7imdiQC9m3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull perf/urgent for v5.17-rc2.

Thx.

---

The following changes since commit fb3b0673b7d5b477ed104949450cd511337ba3c6:

  Merge tag 'mailbox-v5.17' of git://git.linaro.org/landing-teams/working/fujitsu/integration (2022-01-13 11:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc2

for you to fetch changes up to 8c16dc047b5dd8f7b3bf4584fa75733ea0dde7dc:

  x86/perf: Avoid warning for Arch LBR without XSAVE (2022-01-18 12:09:49 +0100)

----------------------------------------------------------------
- Add support for accessing the general purpose counters on Alder Lake via MMIO

- Add new LBR format v7 support which is v5 modulo TSX

- Fix counter enumeration on Alder Lake hybrids

- Overhaul how context time updates are done and get rid of
perf_event::shadow_ctx_time.

- The usual amount of fixes: event mask correction, supported event
types reporting, etc.

----------------------------------------------------------------
Andi Kleen (1):
      x86/perf: Avoid warning for Arch LBR without XSAVE

Kan Liang (2):
      perf/x86/intel: Add a quirk for the calculation of the number of counters on Alder Lake
      perf/x86/intel/uncore: Add IMC uncore support for ADL

Peter Zijlstra (1):
      perf: Fix perf_event_read_local() time

Peter Zijlstra (Intel) (2):
      perf/x86/intel/lbr: Support LBR format V7
      perf/x86/intel/lbr: Add static_branch for LBR INFO flags

Stephane Eranian (1):
      perf/x86/rapl: fix AMD event handling

Zhengjun Xing (1):
      perf/x86/intel/uncore: Fix CAS_COUNT_WRITE issue for ICX

 arch/x86/events/intel/core.c             |  15 ++
 arch/x86/events/intel/lbr.c              | 168 ++++++++++++---------
 arch/x86/events/intel/uncore.c           |   2 +-
 arch/x86/events/intel/uncore.h           |   3 +-
 arch/x86/events/intel/uncore_discovery.c |   4 +-
 arch/x86/events/intel/uncore_discovery.h |   2 +
 arch/x86/events/intel/uncore_snb.c       | 214 ++++++++++++++++++++++++++-
 arch/x86/events/intel/uncore_snbep.c     |   2 +-
 arch/x86/events/perf_event.h             |  10 +-
 arch/x86/events/rapl.c                   |   9 +-
 include/linux/perf_event.h               |  15 +-
 kernel/events/core.c                     | 246 ++++++++++++++++++-------------
 12 files changed, 501 insertions(+), 189 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
