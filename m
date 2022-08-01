Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04B8586865
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiHALqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiHALq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:46:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B0357E5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:46:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA3154DC25;
        Mon,  1 Aug 2022 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659354386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qNd2da+ped5af3bAA+RfV2DV9zxTIUEcxQB5O8P8qeM=;
        b=h/CWLyG/iPcxNauNxR6QHHabWWMotBeR84mb2GmU5s8XQvioptIx7yJYKOZvWIx/7CD0Tr
        sjyFqlggJoB6Kh3jCUA7WzRhGgUuVWr+Lnf9vZzmry03IDwR6pgarvljoK1gVFZxGU3PmN
        jjpPPTi5Hw1xMW4W5aRZ0r0Lp0zp0gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659354386;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qNd2da+ped5af3bAA+RfV2DV9zxTIUEcxQB5O8P8qeM=;
        b=3RN+s3RinkUnyXQoLoWpbkbrDNBAItSVhXiBdq4EuQPrTVR8mJam2vyu55qbz/JUPixNv3
        Rqo3ydS3pjK32WDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD81913AAE;
        Mon,  1 Aug 2022 11:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Rj9QKhK952KfCgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Aug 2022 11:46:26 +0000
Date:   Mon, 1 Aug 2022 13:46:22 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core for v6.0
Message-ID: <Yue9DqpfTtzdkCBr@zn.tnic>
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

please pull two x86/core fixes for 6.0.

Thx.

---

The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v6.0_rc1

for you to fetch changes up to a1a5482a2c6e38a3ebed32e571625c56a8cc41a6:

  x86/extable: Fix ex_handler_msr() print condition (2022-07-21 10:39:42 +0200)

----------------------------------------------------------------
- Have invalid MSR accesses warnings appear only once after a
pr_warn_once() change broke that

- Simplify {JMP,CALL}_NOSPEC and let the objtool retpoline patching
infra take care of them instead of having unreadable alternative macros
there

----------------------------------------------------------------
Peter Zijlstra (2):
      x86,nospec: Simplify {JMP,CALL}_NOSPEC
      x86/extable: Fix ex_handler_msr() print condition

 arch/x86/include/asm/nospec-branch.h | 24 ++++++++++++++++++------
 arch/x86/mm/extable.c                | 16 +++++++++-------
 include/linux/once_lite.h            | 20 ++++++++++++++++----
 3 files changed, 43 insertions(+), 17 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
