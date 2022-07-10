Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1D656CEA9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGJLG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 07:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 07:06:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D6113DD7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 04:06:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E275C1FF83;
        Sun, 10 Jul 2022 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657451185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tEAnRYDq9c6Pe2ZXR7RJbZV23XMwRvoN92HZUUapzXw=;
        b=cB4XpvgLyElW5Wxfu33/m9H34swYJr32dBhk9nitLgVxQIM6OjEWbOmEAj5ReifG44xkei
        QqLVAhK6Lgu6b7ePNNO3R4f/vIecOLZ1DVhYu+KKAgJoyjVx4x+4Z608QQpKOisuBqIurn
        4gi/2JaXVF5DeaE/nhblnS9py2kVuDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657451185;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tEAnRYDq9c6Pe2ZXR7RJbZV23XMwRvoN92HZUUapzXw=;
        b=ujkBZlOh394plcDZVkHQlK+GLor2FV1pq3icra/ZmyOBgRRde3TZm2K4lwuKKqjU2h3oVG
        FhWR3UXPLWdo3GDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4F1A132FD;
        Sun, 10 Jul 2022 11:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5YvtM7GyymKbKgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 10 Jul 2022 11:06:25 +0000
Date:   Sun, 10 Jul 2022 13:06:21 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v5.19-rc6
Message-ID: <YsqyrdTDvDSEfdDf@zn.tnic>
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

please pull a bunch of urgent IRQ fixes for 5.19.

Thx.

---

The following changes since commit e35e5b6f695d241ffb1d223207da58a1fbcdff4b:

  Merge tag 'xsa-5.19-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip (2022-07-05 09:18:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.19_rc6

for you to fetch changes up to 80f2a248a2f92c07873128808359756f72a0438b:

  Merge tag 'irqchip-fixes-5.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent (2022-07-06 18:31:59 +0200)

----------------------------------------------------------------
IRQ urgent fixes by way of Marc Zygnier:

 - Gracefully handle failure to request MMIO resources in the GICv3 driver

 - Make a static key static in the Apple AIC driver

 - Fix the Xilinx intc driver dependency on OF_ADDRESS

----------------------------------------------------------------
Jamie Iles (1):
      irqchip/xilinx: Add explicit dependency on OF_ADDRESS

Robin Murphy (1):
      irqchip/gicv3: Handle resource request failure consistently

Thomas Gleixner (1):
      Merge tag 'irqchip-fixes-5.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Wei Yongjun (1):
      irqchip/apple-aic: Make symbol 'use_fast_ipi' static

 drivers/irqchip/Kconfig         |  2 +-
 drivers/irqchip/irq-apple-aic.c |  2 +-
 drivers/irqchip/irq-gic-v3.c    | 41 +++++++++++++++++++++++++++++++----------
 3 files changed, 33 insertions(+), 12 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
