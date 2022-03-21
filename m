Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63354E2C42
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350245AbiCUPaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245438AbiCUPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:30:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC9514092
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:29:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D4241F37C;
        Mon, 21 Mar 2022 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647876549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/rYzA4F05NnBtirVbysQqWssve7+ei7ba99NsegrvlY=;
        b=VhMzx0RgXi+XtTh9ya5VQlFzjQ1nIGh0bcEK4xDnWmgFg099BXKccRcB09MASbPMjo472v
        pUNVyww9sQyzdkXMIhZuGsSA7Q/hvLIZs+JGek+O45WUXlMvTng1bwOxISh6IBC3B4g2ik
        ONsujs4Xfcgot0UPIDuTp+WZoBJdDUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647876549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/rYzA4F05NnBtirVbysQqWssve7+ei7ba99NsegrvlY=;
        b=cvBQ4sbY29/tFcRhNb09lAi6PZ3eEZ+uS1zTFUDWYUumMoDyubeZYENxH2cn7J//Jb9+IK
        dGgCMcyH55cuA/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A0F9133B6;
        Mon, 21 Mar 2022 15:29:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yao0CsWZOGLFFAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 21 Mar 2022 15:29:09 +0000
Date:   Mon, 21 Mar 2022 16:29:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for 5.18
Message-ID: <YjiZxoLpBIUTEK3q@zn.tnic>
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

please pull the boring round of cleanups this time around.

Thx.

---

The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507:

  Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.18_rc1

for you to fetch changes up to d4c9df20a37d128f6acb3c6286db7e694554a51b:

  x86/nmi: Remove the 'strange power saving mode' hint from unknown NMI handler (2022-03-16 11:02:41 +0100)

----------------------------------------------------------------
- Remove a misleading message and an unused function

----------------------------------------------------------------
Christoph Hellwig (1):
      x86/pat: Remove the unused set_pages_array_wt() function

Jiri Kosina (1):
      x86/nmi: Remove the 'strange power saving mode' hint from unknown NMI handler

 arch/x86/include/asm/set_memory.h | 1 -
 arch/x86/kernel/nmi.c             | 1 -
 arch/x86/mm/pat/set_memory.c      | 6 ------
 3 files changed, 8 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
