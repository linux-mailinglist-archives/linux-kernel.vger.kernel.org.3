Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5C5867EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiHALJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiHALJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:09:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A232981D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:09:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 84CB26139E;
        Mon,  1 Aug 2022 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659352189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2shB7U6Q/MYA8WnDL90QgPArbXmCRWqvnX5rvvgfGEc=;
        b=nHaOrHWs10BISW1AV6i9BI2XdVY08PXGQ+18SbAsBgHP+Y7wUNH8dESdKT1DEZG29kQnip
        KUJPZtPswXO1ljo3TZpOYMs8LJp05uprpZ8R+kp5ZF8b6aOf6myc7OsFru+o5DCl/cnV0w
        mlVXUb0AH4W51Ve/ykD2QN/eQXzkjQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659352189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2shB7U6Q/MYA8WnDL90QgPArbXmCRWqvnX5rvvgfGEc=;
        b=0W8mfr6/76RjjvTB1AVw1mzE1uQno3EPIwLT3s9QkUn1W64OHx1aREMbCdkABBzj1MIh47
        XT+NZDIeYKSRajAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7982A13A72;
        Mon,  1 Aug 2022 11:09:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id knyjHX2052JEeAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Aug 2022 11:09:49 +0000
Date:   Mon, 1 Aug 2022 13:09:45 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/fpu for v6.0
Message-ID: <Yue0ecyVdbrK9TpY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull an idle improvement for AMX-capable CPUs, for 6.0.

Thx.

---

The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v6.0_rc1

for you to fetch changes up to 9f01129382774d98ec21526f13da26a0630ee3d8:

  intel_idle: Add a new flag to initialize the AMX state (2022-07-19 19:17:28 +0200)

----------------------------------------------------------------
- Add machinery to initialize AMX register state in order for CPUs to
be able to enter deeper low-power state

----------------------------------------------------------------
Chang S. Bae (2):
      x86/fpu: Add a helper to prepare AMX state for low-power CPU idle
      intel_idle: Add a new flag to initialize the AMX state

 arch/x86/include/asm/fpu/api.h       |  2 ++
 arch/x86/include/asm/special_insns.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c           | 14 ++++++++++++++
 drivers/idle/intel_idle.c            | 25 +++++++++++++++++++++++--
 4 files changed, 48 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
