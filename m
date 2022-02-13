Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BE54B3B4D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiBMMY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:24:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiBMMYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:24:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009975D65A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:24:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA707210EE;
        Sun, 13 Feb 2022 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644755088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7rVE6HildLEjfpZmMdS6CttJgsbl6vn8KlMfUd2rBgo=;
        b=ZfL4SF2AxC9DifM5I/lOkbUWNJavN/5oma2xFugW0uVjujsfTerOyL8Hs78LPfpQsH+3cU
        ckPgjwRtY0L7gEQVEJXuZpgVGTDAT13a2gGQfeM2ArsZIFv19kaf4RaKwdZFzYaiJZhpi9
        o/oz+Di9h9fFsCAGxN0I5Ch/eQ020h4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644755088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7rVE6HildLEjfpZmMdS6CttJgsbl6vn8KlMfUd2rBgo=;
        b=ZPdvLeRPLe43RyvbgzQlgsfXvD3RGtskV7WRQqMso84u3anZ9rDsv09iHcnZ1jPG8LbIeZ
        Pvc4mv8M0TYMnOAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9038D13521;
        Sun, 13 Feb 2022 12:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id coqaIpD4CGLWPQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 13 Feb 2022 12:24:48 +0000
Date:   Sun, 13 Feb 2022 13:24:54 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 5.17-rc4
Message-ID: <Ygj4lhj6KwGZk5yI@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86/urgent fix for 5.17.

Thx.

---

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc4

for you to fetch changes up to 8795359e35bc33bf86b6d0765aa7f37431db3b9c:

  x86/sgx: Silence softlockup detection when releasing large enclaves (2022-02-10 15:58:14 -0800)

----------------------------------------------------------------
- Prevent softlockups when tearing down large SGX enclaves

----------------------------------------------------------------
Reinette Chatre (1):
      x86/sgx: Silence softlockup detection when releasing large enclaves

 arch/x86/kernel/cpu/sgx/encl.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
