Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36CC531683
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiEWUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiEWUIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:08:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A420D98095
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:08:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EC211F747;
        Mon, 23 May 2022 20:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653336518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OOF8GK8+cPJJKp35P84qL93vkICNT1JP7MKOwpjSWdo=;
        b=IzZbNZKSbYMa4aMkG9FeC+ah1xl4C65MYVzCDPYoqNUlQu56alHka14GGHsUlhVSgsY4pa
        2j9EPpG7u7Tp42y68At2wy82IvpX3w3JLSwgUn/2R2T6dizDkHOHHTBkWO1zdwz3W6UGQy
        dDpDc7vBirKLn1OH/XnRhGu/HBHPlA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653336518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OOF8GK8+cPJJKp35P84qL93vkICNT1JP7MKOwpjSWdo=;
        b=9tJiftCdKWR78xqvffsInbeUg1s/FjUzPMlWtxEJXNCGC5UtzI5G86H4+4r/24otq3AOsy
        2VnOhDvulrwS8zAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 229D013AA5;
        Mon, 23 May 2022 20:08:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WzhrCMbpi2IuAwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 20:08:38 +0000
Date:   Mon, 23 May 2022 22:08:33 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for 5.19
Message-ID: <YovpweaJTtzSBvQw@zn.tnic>
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

please pull the x86/misc tip bucket for 5.19.

Thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.19_rc1

for you to fetch changes up to 1ef64b1e89e6d4018da46e08ffc32779a31160c7:

  x86/mm: Cleanup the control_va_addr_alignment() __setup handler (2022-05-04 18:20:42 +0200)

----------------------------------------------------------------
- A gargen variety of fixes which don't fit any other tip bucket:
 - Remove function export
 - Correct asm constraint
 - Fix __setup handlers retval

----------------------------------------------------------------
Ammar Faizi (1):
      x86/delay: Fix the wrong asm constraint in delay_loop()

Muralidhara M K (1):
      x86/amd_nb: Unexport amd_cache_northbridges()

Randy Dunlap (2):
      x86: Fix return value of __setup handlers
      x86/mm: Cleanup the control_va_addr_alignment() __setup handler

 arch/x86/entry/vdso/vma.c     | 2 +-
 arch/x86/include/asm/amd_nb.h | 1 -
 arch/x86/kernel/amd_nb.c      | 7 +++----
 arch/x86/kernel/apic/apic.c   | 2 +-
 arch/x86/kernel/cpu/intel.c   | 2 +-
 arch/x86/kernel/sys_x86_64.c  | 7 ++-----
 arch/x86/lib/delay.c          | 4 ++--
 arch/x86/mm/pat/memtype.c     | 2 +-
 drivers/char/agp/amd64-agp.c  | 2 +-
 drivers/edac/amd64_edac.c     | 2 +-
 10 files changed, 13 insertions(+), 18 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
