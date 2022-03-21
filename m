Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FFA4E2462
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346358AbiCUKdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346327AbiCUKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:33:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDF3E9CA8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:32:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72ED0210EE;
        Mon, 21 Mar 2022 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647858736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7TCbfZxLsXKudc6AygnewzMHhmJo2+7VMHn9qrTP7uc=;
        b=uxQzY9BD8gOvA1kf1y1tPosa2qZZYMIIUUma95cLTOk4pKFtWNGfh6Ze4KDilBLPblslyA
        WG5zdVlW3wksG1AC1VI1+QJNPJ6Gfol4Tes6oSd8F341s7GYsBG0ZpbZ7WqYvpC2Eww3M+
        ClIoqP8T3RbqShAaOWllz9sGwNVZrvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647858736;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7TCbfZxLsXKudc6AygnewzMHhmJo2+7VMHn9qrTP7uc=;
        b=LtGv0WrphQgr8/E5dpwKxA9Wq7SFGoeHAseDGS5HK/xHquOmAU1ccTRr1FjDjH57UYANqy
        s6xcxH23ITNUTqBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6546F13AD5;
        Mon, 21 Mar 2022 10:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zsy1GDBUOGLcfAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 21 Mar 2022 10:32:16 +0000
Date:   Mon, 21 Mar 2022 11:32:17 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for 5.18
Message-ID: <YjhUMfbawBB5YZaC@zn.tnic>
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

please pull a single x86 build fix for 5.18.

Thx.

---

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.18_rc1

for you to fetch changes up to 4eda2bc3431ebe5c8361580877a4666d10ea28a7:

  x86/Kconfig: Select ARCH_SELECT_MEMORY_MODEL only if FLATMEM and SPARSEMEM are possible (2022-01-23 20:52:16 +0100)

----------------------------------------------------------------
- Correct Kconfig symbol visibility on x86

----------------------------------------------------------------
David Hildenbrand (1):
      x86/Kconfig: Select ARCH_SELECT_MEMORY_MODEL only if FLATMEM and SPARSEMEM are possible

 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
