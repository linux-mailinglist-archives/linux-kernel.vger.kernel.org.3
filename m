Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637925310E2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiEWMaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiEWMaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:30:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB941638
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:30:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 541EC1F8BE;
        Mon, 23 May 2022 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653309001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zeoQmDvdi89CN/+vWG2sXWGpNwnIL48I9zGFnXkil0I=;
        b=1Zl6/8tM1CesRkhF4NMN2rkbMivOU3Upu5jhQQWChenNGhS/6X6kYSCN59T6OpeDudizTH
        azl5FXG/3moPcIFdETNJcBtdIx+3mhCLRaiLwDxMgNsNgGdx/wBe2gcKUV6qTU5t31cpIN
        TKqPQZ56aWse7+pdNS9sQUdYsEBelPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653309001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zeoQmDvdi89CN/+vWG2sXWGpNwnIL48I9zGFnXkil0I=;
        b=4KTBJPsmsOUji3JPLzMCYohZRQ8hiTmv5bwZEfd0Ma26xSqeLUEngDVG3hDV7fUcv5OVDu
        QySb4/7MPLufbnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 480E013AA5;
        Mon, 23 May 2022 12:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zAmKEUl+i2J7PAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 12:30:01 +0000
Date:   Mon, 23 May 2022 14:29:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for 5.19
Message-ID: <Yot+RKdiZMtQSGqT@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two x86/build changes for 5.19.

Thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.19_rc1

for you to fetch changes up to aeb84412037b89e06f45e382f044da6f200e12f8:

  x86/boot: Wrap literal addresses in absolute_pointer() (2022-05-19 12:47:30 +0200)

----------------------------------------------------------------
- Add a "make x86_debug.config" target which enables a bunch of useful
config debug options when trying to debug an issue

- A gcc12 build warnings fix

----------------------------------------------------------------
Dave Hansen (1):
      x86/configs: Add x86 debugging Kconfig fragment plus docs

Kees Cook (1):
      x86/boot: Wrap literal addresses in absolute_pointer()

 Documentation/process/maintainer-tip.rst | 14 +++++++++++++
 arch/x86/Makefile                        |  1 +
 arch/x86/boot/boot.h                     | 36 +++++++++++++++++++++-----------
 arch/x86/boot/main.c                     |  2 +-
 kernel/configs/x86_debug.config          | 18 ++++++++++++++++
 5 files changed, 58 insertions(+), 13 deletions(-)
 create mode 100644 kernel/configs/x86_debug.config

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
