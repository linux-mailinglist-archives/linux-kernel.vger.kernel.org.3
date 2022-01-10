Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC8489676
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbiAJKgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:36:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44638 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243947AbiAJKgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:36:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3979421108;
        Mon, 10 Jan 2022 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641810962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nTASo9AY+DlcPpNbnwIT+oXRLyh10NUDC3Vey37ge+s=;
        b=Rb/F14cjd3MOz2FVTP3Ft6Lwa7GA1zxY8aaiOsGOQTE3WlDqIM7lzKOby+q6bFADA9BLCD
        jew9r/RhybXKKT6EN22Tl8MGFQI3DobNBzB+3/5YvvB8nl7C9ygpFIoWXYOfitIWLeKUqn
        uwT/Q5cr5Dnl8UzBQBm3fjzKpc8wMDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641810962;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nTASo9AY+DlcPpNbnwIT+oXRLyh10NUDC3Vey37ge+s=;
        b=HrM8pqxB6wDylhV6dPEh4ZsAYqY985qB9NfBui7TuuePw7LYNc8je3ctP3TrkUlKyT7/nN
        /rdn/WpRboPGusAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21BB713CCB;
        Mon, 10 Jan 2022 10:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HFmmBhIM3GG9UwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 10:36:02 +0000
Date:   Mon, 10 Jan 2022 11:36:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v5.17
Message-ID: <YdwMGuBeYMVjL4rB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86/cache cleanup for 5.17.

Thx.

---

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.17_rc1

for you to fetch changes up to df0114f1f8711dbf481324c44cf5a8349130b913:

  x86/resctrl: Remove redundant assignment to variable chunks (2021-12-09 09:57:16 -0800)

----------------------------------------------------------------
- A minor code cleanup removing a redundant assignment

----------------------------------------------------------------
Colin Ian King (1):
      x86/resctrl: Remove redundant assignment to variable chunks

 arch/x86/kernel/cpu/resctrl/monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
