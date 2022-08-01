Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97B15868EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiHALyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiHALyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:54:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B93D5B8
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:50:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3E1566D06;
        Mon,  1 Aug 2022 11:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659354632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j2vlYIzw1z7eYxghzcCES9qKW7rI0I/r5Kp98c3NyCI=;
        b=PULHzQObWEebinSD7RXLXFjB9cCI51Eiw9dvcw+5kPJF81dgTGWD1SBzyPK9EjTl66drsw
        dfimcPXfeuaB3jQt/pkWhALjIjVG+U0X06gE4wABywjKxYwzn/VxSpDzqwqpWTlNikfZGG
        5nrJFCc51M2gQ1uQZ6QhDB60cp/9mT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659354632;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j2vlYIzw1z7eYxghzcCES9qKW7rI0I/r5Kp98c3NyCI=;
        b=RBgL8VfJRQhU4xXdZtWgAwjXwNzWZwL82sF559H/7HOZ4WAZYHxzuCtrjf2s8+I0NpOpjA
        g6bmAxRr3eE99tCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9756E13AAE;
        Mon,  1 Aug 2022 11:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iUnjJAi+52KTDAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Aug 2022 11:50:32 +0000
Date:   Mon, 1 Aug 2022 13:50:32 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for v6.0
Message-ID: <Yue+CFzVZusSJeZc@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

pls pull a couple of x86 build fixes for 6.0.

Thx.

---

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v6.0_rc1

for you to fetch changes up to 2d17bd24b0169d3fdbf003dfd55af600e9a30553:

  x86/purgatory: Omit use of bin2c (2022-07-25 10:32:32 +0200)

----------------------------------------------------------------
- Fix stack protector builds when cross compiling with Clang

- Other Kbuild improvements and fixes

----------------------------------------------------------------
Masahiro Yamada (3):
      x86/build: Remove unused OBJECT_FILES_NON_STANDARD_test_nx.o
      x86/purgatory: Hard-code obj-y in Makefile
      x86/purgatory: Omit use of bin2c

Nathan Chancellor (1):
      x86/Kconfig: Fix CONFIG_CC_HAS_SANE_STACKPROTECTOR when cross compiling with clang

 arch/x86/.gitignore                  |  2 --
 arch/x86/Kconfig                     |  5 ++---
 arch/x86/kernel/Makefile             |  2 --
 arch/x86/purgatory/Makefile          | 10 ++--------
 arch/x86/purgatory/kexec-purgatory.S | 14 ++++++++++++++
 scripts/remove-stale-files           |  2 ++
 6 files changed, 20 insertions(+), 15 deletions(-)
 create mode 100644 arch/x86/purgatory/kexec-purgatory.S

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
