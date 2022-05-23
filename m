Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17CA531239
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiEWQJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbiEWQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:09:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058A163BDB
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:09:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98EFF21A64;
        Mon, 23 May 2022 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653322164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dEMTXQwCYIQB+I/XBMpNaBLKvwTPXpcNcx1N2ihQ4ew=;
        b=mV3xFRaN0z027T9GuqQ+a4GgKw+PSyAYlWJY+sL7tOmPBPPuZP2TSqLAmGa6SySabKC/24
        oUtbWK+BA/CrJdsPNnTVLarM13brEaeYPrbHedWA92Vu8DlP/EUOhzu8zZePLBxapV16UY
        D+qykR9bM2D9LtZkRxZ0wNJC5AOKjK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653322164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dEMTXQwCYIQB+I/XBMpNaBLKvwTPXpcNcx1N2ihQ4ew=;
        b=PjCR99+01pX+q6nE9KnjQr7nDzUakOotkqcRRuixLywZUJu9Rjl7jC/RQ6xNfY8gyYcVOa
        XxJwknRhprVlRRDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D7D8139F5;
        Mon, 23 May 2022 16:09:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OB6AIrSxi2LDKQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 16:09:24 +0000
Date:   Mon, 23 May 2022 18:09:20 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/fpu for 5.19
Message-ID: <YouxsHVKnPPiMckV@zn.tnic>
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

please pull a couple of x86/fpu fixes for 5.19.

Thx.

---

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.19_rc1

for you to fetch changes up to b91c0922bf1ed15b67a6faa404bc64e3ed532ec2:

  x86/fpu: Cleanup variable shadowing (2022-05-02 09:28:31 +0200)

----------------------------------------------------------------
- Add support for XSAVEC - the Compacted XSTATE saving variant - and
thus allow for guests to use this compacted XSTATE variant when the
hypervisor exports that support

- A variable shadowing cleanup

----------------------------------------------------------------
Thomas Gleixner (2):
      x86/fpu/xsave: Support XSAVEC in the kernel
      x86/fpu: Cleanup variable shadowing

 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/kernel/fpu/xstate.c       | 60 +++++++++++++++++++++++++-------------
 arch/x86/kernel/fpu/xstate.h       | 14 +++++----
 3 files changed, 49 insertions(+), 27 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
