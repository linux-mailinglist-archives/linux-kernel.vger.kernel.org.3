Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72A7531CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiEWTUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiEWTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:20:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D9E14B2D9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:55:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DBB521A9F;
        Mon, 23 May 2022 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653332112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L9I5H3awiOqVXcOOt7CeWyZc5oWhRQGJioYprnf5VZY=;
        b=tIdO8j4ZCXiqk+JXD1cVg5fnpzTvORn6aDp2pXRGmw3zwi/diBdIFSgl/2bOvsDAESv/mc
        jmq1V2N+nZKy+qbOEbQv/hK9CaE7AxcOXS6VpoOIpjFbd+fVVk0iw1+pzXXuR49Y6aeSZ7
        I9CBIjnKwidLEHu0m82SZwjD1zAoHGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653332112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L9I5H3awiOqVXcOOt7CeWyZc5oWhRQGJioYprnf5VZY=;
        b=kClP+8gt+bxbCrZYimlkS5FSSPEBbr11LM+T66hvMuEwES/2RnH0vW3hV6E4x+uNjK8BEH
        pZSo3IZVBAUVUuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20CC4139F5;
        Mon, 23 May 2022 18:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iqj5B5DYi2JiaQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 18:55:12 +0000
Date:   Mon, 23 May 2022 20:55:07 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/platform for 5.19
Message-ID: <YovYi8NM7s7xRvpy@zn.tnic>
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

please pull the x86/platform lineup for 5.19.

Thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.19_rc1

for you to fetch changes up to 327c348988c6f0bacd7abd29c151f37bdf1e2a02:

  x86/platform/uv: Log gap hole end size (2022-04-07 17:25:15 +0200)

----------------------------------------------------------------
- A couple of changes enabling SGI UV5 support

----------------------------------------------------------------
Mike Travis (3):
      x86/platform/uv: Update NMI Handler for UV5
      x86/platform/uv: Update TSC sync state for UV5
      x86/platform/uv: Log gap hole end size

 arch/x86/kernel/apic/x2apic_uv_x.c | 16 +++++++++++++---
 arch/x86/platform/uv/uv_nmi.c      | 21 +++++++++++----------
 2 files changed, 24 insertions(+), 13 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
