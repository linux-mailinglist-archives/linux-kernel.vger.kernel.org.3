Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10084E2B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349783AbiCUPEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349779AbiCUPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:04:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09696330
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:03:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D387210EE;
        Mon, 21 Mar 2022 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647874992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dZ3Vqe4rk9TNnaytN/665kqUhocAr1o5r4AjlzpBppY=;
        b=jdxfHRCSjEchHb7zG9byaA6tCIbANIel3ZydXLtsmUOm+85tvkqOOYRa/P9v4oqq5631TZ
        BdrjVMhIdrfmqN1UISOJN8A3uPFnW5B20KoPjdCe6kZtJ6HQ6K2kb6D6fWjziz0JoFq+WB
        T1vlq5864BDPSq7GPMlLFb34Ee4Qt/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647874992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dZ3Vqe4rk9TNnaytN/665kqUhocAr1o5r4AjlzpBppY=;
        b=ElMyMfMchloE1QH0HG0s83xQ6X6ATkz7LfOlmGRRApbEYpctomIvb+vI+LAa3DGz3qyY15
        1Uk7Y7J0bDEmsfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9052C13419;
        Mon, 21 Mar 2022 15:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NeQxI7CTOGITCQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 21 Mar 2022 15:03:12 +0000
Date:   Mon, 21 Mar 2022 16:03:07 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?utf-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cc for 5.18
Message-ID: <YjiTq6esjAKwvvZt@zn.tnic>
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

please pull some common confidential computing preparatory glue which
will be shared by SEV/SNP and TDX in the future.

Thx.

---

The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507:

  Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cc_for_v5.18_rc1

for you to fetch changes up to 1e8c5971c249893ac33ca983c32bafcf5d50c727:

  x86/mm/cpa: Generalize __set_memory_enc_pgtable() (2022-02-23 19:14:29 +0100)

----------------------------------------------------------------
- Add shared confidential computing code which will be used by both
vendors instead of proliferating home-grown solutions for technologies
which are pretty similar

----------------------------------------------------------------
Brijesh Singh (1):
      x86/mm/cpa: Generalize __set_memory_enc_pgtable()

Kirill A. Shutemov (3):
      x86/cc: Move arch/x86/{kernel/cc_platform.c => coco/core.c}
      x86/coco: Explicitly declare type of confidential computing platform
      x86/coco: Add API to handle encryption mask

 arch/x86/Kbuild                                |  2 +
 arch/x86/coco/Makefile                         |  6 +++
 arch/x86/{kernel/cc_platform.c => coco/core.c} | 56 +++++++++++++++-----
 arch/x86/include/asm/coco.h                    | 32 ++++++++++++
 arch/x86/include/asm/pgtable.h                 | 13 ++---
 arch/x86/include/asm/set_memory.h              |  1 -
 arch/x86/include/asm/x86_init.h                | 16 ++++++
 arch/x86/kernel/Makefile                       |  5 --
 arch/x86/kernel/cpu/mshyperv.c                 |  6 +++
 arch/x86/kernel/x86_init.c                     | 16 +++++-
 arch/x86/mm/mem_encrypt_amd.c                  | 72 ++++++++++++++++++--------
 arch/x86/mm/mem_encrypt_identity.c             | 12 +++--
 arch/x86/mm/pat/set_memory.c                   | 25 +++++----
 13 files changed, 199 insertions(+), 63 deletions(-)
 create mode 100644 arch/x86/coco/Makefile
 rename arch/x86/{kernel/cc_platform.c => coco/core.c} (73%)
 create mode 100644 arch/x86/include/asm/coco.h


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
