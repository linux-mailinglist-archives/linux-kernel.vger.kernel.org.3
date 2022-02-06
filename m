Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0A74AAF30
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 13:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiBFMa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 07:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiBFMa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 07:30:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB84C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 04:30:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EFFA4210F2;
        Sun,  6 Feb 2022 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644150626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DdXbcUlO8dEKpMd7aRB8Y1ledJg85QBjnscE3ibSTHk=;
        b=jB9M0B/JkKUHxnBG9zSPaYrEZg5ICmvI5uBgjZYKMw34JBzprb1+wA3qp1oc77wklGJoGy
        lTZVAJenv1nD0VIS/H+AT322pf1ceGg3rKN72pBFwDHLUv+JFE1x9wt0xnP7F6KqTRehuG
        E6b7b3ZAHtlpsLBaEC1LnPk7MJgXkSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644150626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DdXbcUlO8dEKpMd7aRB8Y1ledJg85QBjnscE3ibSTHk=;
        b=n2SVszmmr9U46KhOh5KJl8Bp2TpndBW8hkyVXMs5k2e6yIsxLuaUhlKpXsIwuOmwuEXfm0
        zsOaYJLm3PnkmPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4D4413A47;
        Sun,  6 Feb 2022 12:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O19iM2K//2F0NQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 06 Feb 2022 12:30:26 +0000
Date:   Sun, 6 Feb 2022 13:30:20 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.17-rc3
Message-ID: <Yf+/XCkzFQ5s3IHN@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of urgent perf fixes for 5.17.

Thx.

---

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc3

for you to fetch changes up to 1d9093457b243061a9bba23543c38726e864a643:

  perf/x86/intel/pt: Fix crash with stop filters in single-range mode (2022-02-02 13:11:40 +0100)

----------------------------------------------------------------
perf/urgent contains 3 fixups:

 - Intel/PT: filters could crash the kernel

 - Intel: default disable the PMU for SMM, some new-ish EFI firmware has
   started using CPL3 and the PMU CPL filters don't discriminate against
   SMM, meaning that CPL3 (userspace only) events now also count EFI/SMM
   cycles.

 - Fixup for perf_event_attr::sig_data

(Peter Zijlstra)

----------------------------------------------------------------
Marco Elver (3):
      perf: Copy perf_event_attr::sig_data on modification
      selftests/perf_events: Test modification of perf_event_attr::sig_data
      perf: uapi: Document perf_event_attr::sig_data truncation on 32 bit architectures

Peter Zijlstra (1):
      x86/perf: Default set FREEZE_ON_SMI for all

Tristan Hume (1):
      perf/x86/intel/pt: Fix crash with stop filters in single-range mode

 arch/x86/events/intel/core.c                          | 13 +++++++++++++
 arch/x86/events/intel/pt.c                            |  5 +++--
 include/uapi/linux/perf_event.h                       |  2 ++
 kernel/events/core.c                                  | 16 ++++++++++++++++
 tools/testing/selftests/perf_events/sigtrap_threads.c | 17 +++++++++--------
 5 files changed, 43 insertions(+), 10 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
