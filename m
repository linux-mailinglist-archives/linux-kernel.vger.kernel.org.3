Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB984A35CB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 11:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiA3Kqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 05:46:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42330 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiA3Kqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 05:46:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 020391F386;
        Sun, 30 Jan 2022 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643539608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wTV7TG4QCr8Vwc7uHTFLJLUTShWzA9ro4Or5vnw1T1s=;
        b=snUra/HKP+RG9ek9JoZA3T8pW/s2a0N8ecJzB2kBV28xtG8rQIXYbROuCBP06Qo00o/hLq
        smHf+bnYy+yYuCGn88oBUTDhA+B9pTA+g0AZHIGaDB2Rlq/k7Kt0gMEAgsS2wJhfXtW24f
        23Aa1ztOiY8+Z5ufadpKN5KkzTVgHhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643539608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wTV7TG4QCr8Vwc7uHTFLJLUTShWzA9ro4Or5vnw1T1s=;
        b=xsZ2WlII+HhXKf2iG0DGJNL3NbbWIijK8SciEJY7TevtmMl3m6Jqx+f1a6Byq6kJcuAF/Q
        L4NTkosyCUs6SCAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC80413638;
        Sun, 30 Jan 2022 10:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xhx0NZds9mFgZwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 30 Jan 2022 10:46:47 +0000
Date:   Sun, 30 Jan 2022 11:46:41 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.17-rc2
Message-ID: <YfZskTVEDx8AAtYh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull x86/urgent for 5.17.

Thx.

---

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc2

for you to fetch changes up to e464121f2d40eabc7d11823fb26db807ce945df4:

  x86/cpu: Add Xeon Icelake-D to list of CPUs that support PPIN (2022-01-25 18:40:30 +0100)

----------------------------------------------------------------
- Add another Intel CPU model to the list of CPUs supporting the
processor inventory unique number

- Allow writing to MCE thresholding sysfs files again - a previous
change had accidentally disabled it and no one noticed. Goes to show how
much is this stuff used

----------------------------------------------------------------
Tony Luck (1):
      x86/cpu: Add Xeon Icelake-D to list of CPUs that support PPIN

Yazen Ghannam (1):
      x86/MCE/AMD: Allow thresholding interface updates after init

 arch/x86/kernel/cpu/mce/amd.c   | 2 +-
 arch/x86/kernel/cpu/mce/intel.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
