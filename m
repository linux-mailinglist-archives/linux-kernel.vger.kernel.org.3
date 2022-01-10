Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D541E489634
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbiAJKTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:19:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243876AbiAJKTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:19:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 444C121135;
        Mon, 10 Jan 2022 10:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641809982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+LCDWjMEypMIcQ17dTOOXlNuaUdA9I/4trNEFTuG+vM=;
        b=lD5Dj1bevCdaaJkHYtxqyekh/3THahxBhFdLcZSNXxJ8K3gHvHTnUUEBQ16p4C12EWOkJY
        8ryf6AtEohCPmiUEkFqDhldCiNGJFIa4nfyjHfJiV8c0Bzg1sboIjjvMRzs7ssHfPOTxsA
        GQR5IrOBoksMHSSdt2G+TnOUCx8Y+Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641809982;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+LCDWjMEypMIcQ17dTOOXlNuaUdA9I/4trNEFTuG+vM=;
        b=egVx6WM3loz8AGOLjQIXXKSxkyOVWzedy2jzxx1kprVlmDPlx7dBFWU5FgaaTFZei0GiVe
        HRjnGezmgMXpYOBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2986E13CCB;
        Mon, 10 Jan 2022 10:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aneXCT4I3GEPSwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 10:19:42 +0000
Date:   Mon, 10 Jan 2022 11:19:45 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/paravirt for v5.17
Message-ID: <YdwIQXX4xbfkeOT7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86/paravirt fix for 5.17.

Thx.

---

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v5.17_rc1

for you to fetch changes up to 6da5175dbe1c2f02f1301b6d987e3ce24742bfd4:

  x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV (2021-11-30 13:50:26 -0800)

----------------------------------------------------------------
- Define the INTERRUPT_RETURN macro only when CONFIG_XEN_PV is enabled
as it is its only user

----------------------------------------------------------------
Kirill A. Shutemov (1):
      x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV

 arch/x86/include/asm/irqflags.h | 7 +++++--
 arch/x86/include/asm/paravirt.h | 5 -----
 2 files changed, 5 insertions(+), 7 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
