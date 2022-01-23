Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF0E49710E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiAWLOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:14:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42478 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiAWLOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:14:01 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D97EA1F37D;
        Sun, 23 Jan 2022 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642936439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q4t4uG7r4Ecd6gWhom2jjFkOH6q13f1JmWr8STDghRw=;
        b=A55cTV0xSuJfFfjPbyqOjQWUYeaX2H006G4vWx2Cb4/wdkgma87pCVWnD6ZWbNrSw0bqys
        2XY+RO8uEKqdkya9bH0l0TvnoVKtXJLUSTuaWP7K4QN6kN6yollgVyNHgvFQIzVlZaZQ/v
        njFdj4TJbzgsMBSw0ZrfF2zeC4xTdyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642936439;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q4t4uG7r4Ecd6gWhom2jjFkOH6q13f1JmWr8STDghRw=;
        b=D//tAlqe2d51vBtZI82ArHJ2Q288PnR+XSGjW1Ko5QH4plX2q4f3BBPAukTn8m89YigmpL
        bSW8LHd9HPfmQjDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA7511333C;
        Sun, 23 Jan 2022 11:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0k8XLXc47WG0JQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 23 Jan 2022 11:13:59 +0000
Date:   Sun, 23 Jan 2022 12:13:58 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v5.17-rc2
Message-ID: <Ye04diH6Q/UtQ+Tg@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single irq/urgent fix for v5.17-rc2.

Thx.

---

The following changes since commit 1d1df41c5a33359a00e919d54eaebfb789711fdc:

  Merge tag 'f2fs-for-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2022-01-19 11:50:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.17_rc2

for you to fetch changes up to a0af3d1104f752b6d0dba71788e3fddd67c857a7:

  PCI/MSI: Prevent UAF in error path (2022-01-21 02:14:46 +0100)

----------------------------------------------------------------
- A single use-after-free fix in the PCI MSI irq domain allocation path

----------------------------------------------------------------
Thomas Gleixner (1):
      PCI/MSI: Prevent UAF in error path

 drivers/pci/msi/irqdomain.c | 4 ++--
 drivers/pci/msi/legacy.c    | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
