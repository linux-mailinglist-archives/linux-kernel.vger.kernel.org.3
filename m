Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805F148AACC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbiAKJrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:47:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46704 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiAKJrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:47:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 230031F3B6;
        Tue, 11 Jan 2022 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641894461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NLD6NZqFqM0X4rZ356q3JN1PwL17Ja6GbAcT0BVf8IQ=;
        b=sGEQSBRRx75tC8+ELyHwV3zob9ajiviYT8wgh2ybvQ9JF9nmgbOU/gaghF2pFbsMzPUv+H
        ApsGITnalxhNhloS66bsPnRyQ74Ozwu6vyt0dpS5LQRUWs6CEedNKyMrg5jMdfy2N7JyR9
        4kAI3m6CNRHMbbRM5w4Q2Vcn77/bMeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641894461;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NLD6NZqFqM0X4rZ356q3JN1PwL17Ja6GbAcT0BVf8IQ=;
        b=l3MWyF8M31eFHJwTIFcrkCr+S9edGPQA5ipQhyx7NJkOcouFQ5mutGKM2akIfiaqUHhqOj
        Z0FZzaPKd8K3YpAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E37913638;
        Tue, 11 Jan 2022 09:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oiIDAj1S3WEuQwAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 11 Jan 2022 09:47:41 +0000
Date:   Tue, 11 Jan 2022 10:47:45 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for v5.17, part 2
Message-ID: <Yd1SQcvvuu1UPlEj@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

in the heat of the battle between me and the tip pull requests, I've
sent you the tip:x86/build branch without the two top-most commits from
Ingo (it appears I hadn't fast-forwarded my local branch, sorry about
that).

Therefore, here's a part 2 of x86/build for 5.17.

Please pull,
thx!

And while you do, I'll be at the blackboard, writing:

I will always fast-forward local branches before tagging and sending pull requests to Linus.
I will always fast-forward local branches before tagging and sending pull requests to Linus.
I will always fast-forward local branches before tagging and sending pull requests...

---

The following changes since commit 5fe392ff9d1f7254a1fbb3f72d9893088e4d23eb:

  x86/boot/compressed: Move CLANG_FLAGS to beginning of KBUILD_CFLAGS (2021-12-23 11:03:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.17_rc1-p2

for you to fetch changes up to b6aa86cff44cf099299d3a5e66348cb709cd7964:

  x86/kbuild: Enable CONFIG_KALLSYMS_ALL=y in the defconfigs (2022-01-08 22:55:29 +0100)

----------------------------------------------------------------
- Make x86 defconfigs more useful by enabling CONFIG_LOCALVERSION_AUTO
  and CONFIG_KALLSYMS_ALL

----------------------------------------------------------------
Ingo Molnar (2):
      x86/defconfig: Enable CONFIG_LOCALVERSION_AUTO=y in the defconfig
      x86/kbuild: Enable CONFIG_KALLSYMS_ALL=y in the defconfigs

 arch/x86/configs/i386_defconfig   | 2 +-
 arch/x86/configs/x86_64_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index e81885384f60..71124cf8630c 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
@@ -262,3 +261,4 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
+CONFIG_KALLSYMS_ALL=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index e8a7a0af2bda..92b1169ec90b 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
@@ -258,3 +257,4 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
+CONFIG_KALLSYMS_ALL=y


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
