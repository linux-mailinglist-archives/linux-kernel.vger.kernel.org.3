Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E989C4AAF1A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiBFL5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiBFL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:57:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175E9C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 03:57:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B2B731F386;
        Sun,  6 Feb 2022 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644148658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lXWmmTdhvW3m3FoSvMNy7hJzOUL/JeKwiFt5MfL4S4E=;
        b=lDtTqd7W7qMCbopO3F/iV4K/5DaQq6et3HsDDiwQTjdN6Qx3GFmUqa+qFLDuFAp1n8bkec
        GtGpkkYVivmWueEMRbp3s8HFdwKy9L2YQgC8XlJPMUFTbNygYOfX0Cnht1tec1Iddzzsdr
        jyHu6fnBuigktCtLk3p5eTTzhQnGWGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644148658;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lXWmmTdhvW3m3FoSvMNy7hJzOUL/JeKwiFt5MfL4S4E=;
        b=E89r91XHkvISjcRXWXr8fdaFFZWZOkXoyXfDzjuCQHesnf/vxxHVjaZCaa1fTAflvNd3K9
        zdg5Gtd3sewLJ8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B19A13A47;
        Sun,  6 Feb 2022 11:57:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UdunJLK3/2HbLAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 06 Feb 2022 11:57:38 +0000
Date:   Sun, 6 Feb 2022 12:57:36 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v5.17-rc3
Message-ID: <Yf+3sIvPPnPkv5Jg@zn.tnic>
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

please pull a single urgent IRQ fix for 5.17.

Thx.

---

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.17_rc3

for you to fetch changes up to dd7f5a11ac5a6f733f422dc22b4d145d3260304e:

  PCI/MSI: Remove bogus warning in pci_irq_get_affinity() (2022-02-04 09:54:20 +0100)

----------------------------------------------------------------
- Remove a bogus warning introduced by the recent PCI MSI irq affinity
overhaul

----------------------------------------------------------------
Thomas Gleixner (1):
      PCI/MSI: Remove bogus warning in pci_irq_get_affinity()

 drivers/pci/msi/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
