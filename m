Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2141947F6AA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhLZLwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:52:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57170 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhLZLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:52:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10A7C210EC;
        Sun, 26 Dec 2021 11:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640519572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GtQmooac77LyCMVrNQtrY+32yrJUVlusAkswqsldD0c=;
        b=YOTejXh3kc2fmu3k1NqPMKQ0mE+SIMQzTa3wj9niVXUZZkYeouX/+ab2NVD6CdC1weXaIt
        E3LUtSSfux2MVlo+X6DOg6701sPlVEFu9f+OL0MArT2RX56sntupF2ig6wH6Des0yYvojj
        dHbZG+IXBl1SIuCyzTYwIoqh7FlYpQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640519572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GtQmooac77LyCMVrNQtrY+32yrJUVlusAkswqsldD0c=;
        b=cpRxB8q9x0bq0I2TXXrvsqouziIcOQ+7A3AZliYPny1UW5YxQzj0VQS74Gk1pXMt54Q/Jx
        v1+r03q4ylUv/sAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEC71134AD;
        Sun, 26 Dec 2021 11:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VSHAOJNXyGGqDQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 26 Dec 2021 11:52:51 +0000
Date:   Sun, 26 Dec 2021 12:52:59 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v5.16-rc7
Message-ID: <YchXJU2EiAFpWq4+@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two urgent objtool fixes for 5.16.

Thx.

---

The following changes since commit a7904a538933c525096ca2ccde1e60d0ee62c08e:

  Linux 5.16-rc6 (2021-12-19 14:14:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.16_rc7

for you to fetch changes up to dcce50e6cc4d86a63dc0a9a6ee7d4f948ccd53a1:

  compiler.h: Fix annotation macro misplacement with Clang (2021-12-21 15:09:46 -0800)

----------------------------------------------------------------
- Prevent clang from reordering the reachable annotation in an inline asm statement
without inputs

- Fix objtool builds on non-glibc systems due to undefined __always_inline

----------------------------------------------------------------
Ismael Luceno (1):
      uapi: Fix undefined __always_inline on non-glibc systems

Josh Poimboeuf (1):
      compiler.h: Fix annotation macro misplacement with Clang

 include/linux/compiler.h                     | 4 ++--
 include/linux/instrumentation.h              | 4 ++--
 include/uapi/linux/byteorder/big_endian.h    | 1 +
 include/uapi/linux/byteorder/little_endian.h | 1 +
 4 files changed, 6 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
