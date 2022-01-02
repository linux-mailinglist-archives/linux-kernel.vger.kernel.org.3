Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D4F482AAB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 10:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiABJeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 04:34:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47570 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiABJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 04:34:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F198D210FC;
        Sun,  2 Jan 2022 09:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641116040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=za9Nb3pV9k7x3EBgdsgdMzdnzl28mguREcJHM4y0Npg=;
        b=hee0rKy9OxyMXGnCqJDkXvXede+C07akqihe3Y2XvVml4+f1jVhzKu2P8wxagLHoJ1pV4S
        sb/ga/iKnprTtqojs8fJO8P0lhyWVew8NkfrrO/t3PgHpYj/VhQAN/ur7+ke7sGZbNpOw5
        FDUS4EHffo2qidqYjwHq9/R9Hx6iyOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641116040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=za9Nb3pV9k7x3EBgdsgdMzdnzl28mguREcJHM4y0Npg=;
        b=I8PosESHV0y5VPI2VF7QGJZv9nrDs72UBSROKb6BaKcwII1TBn9b0a3ESwisuT3ZWGYVIw
        aVvuhh2Itc31i4CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1BF01361C;
        Sun,  2 Jan 2022 09:34:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OrjUMohx0WEmYwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 02 Jan 2022 09:34:00 +0000
Date:   Sun, 2 Jan 2022 10:34:03 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 5.16
Message-ID: <YdFxi7TVYP61uA4f@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86/urgent fix for 5.16.

Thx.

---

The following changes since commit fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2:

  Linux 5.16-rc7 (2021-12-26 13:17:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc8

for you to fetch changes up to d6f12f83989bb356ac6880a954f62c7667e35066:

  x86/build: Use the proper name CONFIG_FW_LOADER (2021-12-29 22:20:38 +0100)

----------------------------------------------------------------
- Use the proper CONFIG symbol in a preprocessor check.

----------------------------------------------------------------
Lukas Bulwahn (1):
      x86/build: Use the proper name CONFIG_FW_LOADER

 arch/x86/tools/relocs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
