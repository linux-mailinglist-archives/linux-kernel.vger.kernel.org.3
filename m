Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2282C4895CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbiAJJ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:57:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39580 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiAJJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:56:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E343F210F8;
        Mon, 10 Jan 2022 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641808610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Peyc15H1SETBUtd+31GRO+DFq6eD7xJCJluuluBn8Eg=;
        b=leFsN63Lt32lIpzXXz8w+p04Hwb1cNFlYsFtaQiN1RizJz6xgdp7q3gi5SEDrInCJQSE6y
        EsYHYjcjph7Ph/lgU2nbpczxKsbQCeDzbkxheTmxEujLM+96YXKhmxkx1zLz1BWUvxQ+TU
        KPYdpWPKUhg975XETWrhennQ48/NlDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641808610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Peyc15H1SETBUtd+31GRO+DFq6eD7xJCJluuluBn8Eg=;
        b=1VqLoq6jM5wFTDBhwjqLTpuCS4sCSSnRlEVS8jHr84r+y4O1EuDFqc0YuQdcpxmajYx6os
        K+Lm8Ak4FAam8eCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBC5513CCB;
        Mon, 10 Jan 2022 09:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F/AOMOIC3GFHPgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 09:56:50 +0000
Date:   Mon, 10 Jan 2022 10:56:55 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/fpu for v5.17
Message-ID: <YdwC58lduSOILPmq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86/fpu update for 5.17.

Thx.

---

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.17_rc1

for you to fetch changes up to 0fe4ff885f8a50082d9dc241b657472894caba16:

  x86/fpu: Correct AVX512 state tracking (2021-11-16 17:19:41 +0100)

----------------------------------------------------------------
- Exclude AVX opmask registers use from AVX512 state tracking as they
don't contribute to frequency throttling

----------------------------------------------------------------
Noah Goldstein (1):
      x86/fpu: Correct AVX512 state tracking

 arch/x86/kernel/fpu/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
