Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9A4FE115
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351428AbiDLMw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355036AbiDLMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:48:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5558BBE0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:14:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c12-20020a17090a020c00b001cba1ebb20cso2058546pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WlhLvKY3zT5Zwc6BjY2DR6KFEYpYVNQay5CCAj2cOs4=;
        b=BFpKjK/Z/j7bELQYt2NhSukAKBLKCs3yubgOqHCgYAHf3RJ0ZyQoGpcNF2bzkqPHxT
         u/GnYtHYti4wn2Xh6Z8LHH8qRHwsNttAT3XuXDUG0WL7cW/enRV4PL3h8aerBy0sCdVr
         BN+UNgyBiiomhnx6JJcKGH62tQMzn7iV5spUUhdix5wODL2qJPF92lzeqXtReGIyU+Kf
         r+qnLRYkTmkgKQn6PkXDo1PKZSSJcnXloYRfGez2iOV7dqNYxs7yuI7yZCRHjb7+xN+V
         SJTZbgPSRHgB9GbMGNvTymodgyzAhWqgWE5l7ZgZ6/UNkSjxPpW3E44iB2sFf0Zgs1mA
         eLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WlhLvKY3zT5Zwc6BjY2DR6KFEYpYVNQay5CCAj2cOs4=;
        b=G3D3A19cADnU/vlFsltJSZpvdyClJyO3rKk14ujJdCu7BpBJqjkTuLGqNrgNFVaguE
         7KXNcHBKfXoAoZB8u35mmESolHSNAqVxmdEs/6RYJaugcV2TjPLa84wqDYWb/wtDc0/e
         Ckmvg7V87PyPRGcSk0eW/c5k8ZMH2Y4azewmZxwX8SqxsmxNX89/2MGgmKYMoTB5OOC/
         L+xCwwjLBayg/AxDY3tNVSeM6BfmT+ENiqPpdu2bLJmGM1knBwpo8FLlzblOcc+x/teE
         QP0yKs5XIYBKzRzLiwegTrPSXdouvcNpVm7R8uISk8qNSOjY9KqE3PtO4C1+a4WKNqk2
         zdPA==
X-Gm-Message-State: AOAM531QGPCvTxWsAvWygarKW8oEwhG3AbHxqIKFb9nBrn+YSb8SiOPY
        iPHCFclJzLRxhSfjrqqHaFSu9D903qg=
X-Google-Smtp-Source: ABdhPJx2pR6VS4BxQjB8Dl4fdWoxC6QU+VQHL/7oBEeqbc24hcPLhKeunYV0tH5CkL27f7vVqY+rOA==
X-Received: by 2002:a17:902:ce0f:b0:156:5a4:926c with SMTP id k15-20020a170902ce0f00b0015605a4926cmr36849036plg.3.1649765693665;
        Tue, 12 Apr 2022 05:14:53 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm40248445pfh.174.2022.04.12.05.14.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:14:53 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH V5 0/7] x86/entry: Clean up entry code
Date:   Tue, 12 Apr 2022 20:15:34 +0800
Message-Id: <20220412121541.4595-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

This patchset moves the stack-switch code to the place where
error_entry() return, unravels error_entry() from XENpv and makes
entry_INT80_compat() uses idtentry macro.

This patchset is highly related to XENpv, because it does the extra
cleanup to convert SWAPGS to swapgs after major cleanup is done.

The patches are the 5th version to pick patches from the patchset
https://lore.kernel.org/lkml/20211126101209.8613-1-jiangshanlai@gmail.com/
which converts ASM code to C code.  These patches are prepared for that
purpose.  But this patchset has it own value: it simplifies the stack
switch, avoids leaving the old stack inside a function call, and
separates XENpv code with native code without adding new code.

Peter said in V3:
>	So AFAICT these patches are indeed correct.
>
>	I'd love for some of the other x86 people to also look at this,
>	but a tentative ACK on this.

[V4]: https://lore.kernel.org/lkml/20220318143016.124387-1-jiangshanlai@gmail.com/
[V3]: https://lore.kernel.org/lkml/20220315073949.7541-1-jiangshanlai@gmail.com/
[V2]: https://lore.kernel.org/lkml/20220303035434.20471-1-jiangshanlai@gmail.com/
[V1]: https://lore.kernel.org/lkml/20211208110833.65366-1-jiangshanlai@gmail.com/

Changed from V4:
	Update changelog largely of patch 1 and patch 2
	Update changelog slightly of other patches
	Unbreak the line of fixup_bad_iret() in patch1

	Add Reviewed-by from Juergen Gross <jgross@suse.com> in patch 6
	since he gave the Reviewed-by in one of the squashed patches.

Changed from V3:
	Only reorder the int80 thing as the last patch to make patches
	ordering more natural. (Both orders are correct)

Other interactions in V3:
	Peter raised several questions and I think I answered them and I
	don't think the code need to be updated unless I missed some
	points. (Except reordering the patches)

	Josh asked to remove UNWIND_HINT_REGS in patch5, but I think
	UNWIND_HINT_REGS is old code before this patchset and I don't
	want to do a cleanup that is not relate to preparing converting
	ASM code C code in this patchset.  He also asked to remove
	ENCODE_FRAME_POINTER in xenpv case, and I think it just
	complicates the code for just optimizing out a single assignment
	to %rbp.  I would not always stick to these reasons of mine,
	but I just keep the code unchanged since he hasn't emphasized it
	again nor other people has requested it.

Changed from V2:
	Make the patch of folding int80 thing as the first patch
	Add more changelog in "Switch the stack after error_entry() returns"

Changed from V1
	Squash cleanup patches converting SWAPGS to swapgs into one patch

	Use my official email address (Ant Group).  The work is backed
	by my company and I was incorrectly misunderstood that
	XXX@linux.alibaba.com is the only portal for opensource work
	in the corporate group.


Lai Jiangshan (7):
  x86/traps: Move pt_regs only in fixup_bad_iret()
  x86/entry: Switch the stack after error_entry() returns
  x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
  x86/entry: Move cld to the start of idtentry macro
  x86/entry: Don't call error_entry() for XENPV
  x86/entry: Convert SWAPGS to swapgs and remove the definition of
    SWAPGS
  x86/entry: Use idtentry macro for entry_INT80_compat

 arch/x86/entry/entry_64.S        |  61 +++++++++++++-----
 arch/x86/entry/entry_64_compat.S | 105 +------------------------------
 arch/x86/include/asm/idtentry.h  |  47 ++++++++++++++
 arch/x86/include/asm/irqflags.h  |   8 ---
 arch/x86/include/asm/proto.h     |   4 --
 arch/x86/include/asm/traps.h     |   2 +-
 arch/x86/kernel/traps.c          |  18 ++----
 7 files changed, 100 insertions(+), 145 deletions(-)

-- 
2.19.1.6.gb485710b

