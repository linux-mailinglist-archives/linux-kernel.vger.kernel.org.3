Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13961489729
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbiAJLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:16:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41688 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244532AbiAJLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:16:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 60D151F395;
        Mon, 10 Jan 2022 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641813391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PkG0S8Obfn4LZ8Nij0a2iJKd0/TlcnmRiNdvI8v+zc8=;
        b=vbXNAmy2SjVCR43y0X6sodkroBAv8DRiex4zBa1P5JtQvTrKK8tJwQE8licsRscwjtCLX0
        BiLRZq/EvQ4u9ntNhchd5sdRxsV4ucM79zb/1ZV+tNufSn5oPbLIO19SuWjz/C4Z29T5QA
        2U8K0Y0QsvXrErGTKygn1FAqZnpO5/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641813391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PkG0S8Obfn4LZ8Nij0a2iJKd0/TlcnmRiNdvI8v+zc8=;
        b=LrY0qiNx0li7nfrJ9AOSuE8oIfqaeoNzcJQWjjEJkLMKzjCoDVln4sSE3hmv2P3SV9W3M5
        2GK+5OZjI3kzKUBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AEE313D2A;
        Mon, 10 Jan 2022 11:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HAysEI8V3GFSawAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 11:16:31 +0000
Date:   Mon, 10 Jan 2022 12:16:39 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v5.17
Message-ID: <YdwVl0H54fmUIux0@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two x86/cpu updates for 5.17.

Thx.

---

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.17_rc1

for you to fetch changes up to 244122b4d2e5221e6abd6e21d6a58170104db781:

  x86/lib: Add fast-short-rep-movs check to copy_user_enhanced_fast_string() (2021-12-29 13:46:02 +0100)

----------------------------------------------------------------
- Enable the short string copies for CPUs which support them, in
copy_user_enhanced_fast_string()

- Avoid writing MSR_CSTAR on Intel due to TDX guests raising a #VE trap

----------------------------------------------------------------
Andi Kleen (1):
      x86/cpu: Don't write CSTAR MSR on Intel CPUs

Tony Luck (1):
      x86/lib: Add fast-short-rep-movs check to copy_user_enhanced_fast_string()

 arch/x86/kernel/cpu/common.c | 15 +++++++++++++--
 arch/x86/lib/copy_user_64.S  |  4 ++--
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
