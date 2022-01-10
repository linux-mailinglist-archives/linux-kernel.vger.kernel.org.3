Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24AA4896FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbiAJLIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:08:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41150 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbiAJLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:07:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C2C261F393;
        Mon, 10 Jan 2022 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641812872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jZuELbu08OfY41gObPEz8xEE1M01ktEm+EkQwySqewM=;
        b=WjaoSCWRUZdZH7YrHxPyTJmQ7a7t1y+2Ga00BF63QEiswAQOFB/g+jXXX+5ALBLbKg7JGk
        glfXMpVFehGgiGljWfByV97JQLqwjQzJdYGYU2wSU/nZyQY5fLprV4MY2orx0C0NmMF6vv
        vf2EQ/RsELmHZk10bAMOV3Zh1/ar9Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641812872;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jZuELbu08OfY41gObPEz8xEE1M01ktEm+EkQwySqewM=;
        b=PA+7rv9vPjWgGev4gseCNYKbsC40Y6zCoe6Exqz03t0Qd9HYFQNPQbhzpc3AGWjrIziwLc
        n2XWHuLoKtqNDEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADB7513A98;
        Mon, 10 Jan 2022 11:07:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YuAcKYgT3GHdZQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 11:07:52 +0000
Date:   Mon, 10 Jan 2022 12:08:00 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for v5.17
Message-ID: <YdwTkIqIyOtdWN/c@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the garden variety of x86/cleanups for 5.17.

Thx.

---

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.17_rc1

for you to fetch changes up to 0be4838f018c10d7f138a213c006d345db35ef5b:

  x86/events/amd/iommu: Remove redundant assignment to variable shift (2021-12-28 21:30:05 +0100)

----------------------------------------------------------------
- The mandatory set of random minor cleanups all over tip

----------------------------------------------------------------
Colin Ian King (1):
      x86/events/amd/iommu: Remove redundant assignment to variable shift

Kees Cook (2):
      x86/uaccess: Move variable into switch case statement
      x86/boot/string: Add missing function prototypes

Shaokun Zhang (1):
      x86/fpu: Remove duplicate copy_fpstate_to_sigframe() prototype

 arch/x86/boot/string.h            | 3 +++
 arch/x86/events/amd/iommu.c       | 2 +-
 arch/x86/include/asm/fpu/signal.h | 3 ---
 arch/x86/include/asm/uaccess.h    | 5 +++--
 4 files changed, 7 insertions(+), 6 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
