Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1069C5866AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiHAJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiHAJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:04:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F7BC88
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:04:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A12A461042;
        Mon,  1 Aug 2022 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659344648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ufcgXpQ6ybK/SPE8JBhX0/tzYq3JeEcmqGEvwEj3Wbs=;
        b=NrWiK+eHH/xE6yIutJ0WewBsw3hnx7fInFhG4AO1CeQ+LU3/AEJHZG6tSOWJn+NJJCplrZ
        4zvR6sxkgkO/z+jFZ2Ve+6suH8GJYH5WKz7iNY6eordjM4WQqSTGdTnNRbIwaRhkhACwbE
        D3La02fmwdBhw+EXaZaIvpk5flbAWZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659344648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ufcgXpQ6ybK/SPE8JBhX0/tzYq3JeEcmqGEvwEj3Wbs=;
        b=lIueUhJ5ah0BE+ySH9NwPOEtE/GTf3/oE8iJf/g0sYnQNCoBqRUFryw4XvHl9A21iipsV+
        yiw5ZWzPxtk9CsCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93ED613A72;
        Mon,  1 Aug 2022 09:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g8QJJAiX52LEPAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Aug 2022 09:04:08 +0000
Date:   Mon, 1 Aug 2022 11:04:03 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for v6.0
Message-ID: <YueXA90ePDFY7mKf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

pls pull what is probably the most boring branch this merge window.

Thx.

---

The following changes since commit 018ab4fabddd94f1c96f3b59e180691b9e88d5d8:

  netfs: fix up netfs_inode_init() docbook comment (2022-06-14 10:36:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v6.0_rc1

for you to fetch changes up to 9de76f41ea2188f2784f48352f9278819d249afc:

  x86/mm: Refer to the intended config STRICT_DEVMEM in a comment (2022-07-07 09:51:36 -0700)

----------------------------------------------------------------
- A single CONFIG_ symbol correction in a comment

----------------------------------------------------------------
Lukas Bulwahn (1):
      x86/mm: Refer to the intended config STRICT_DEVMEM in a comment

 arch/x86/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
