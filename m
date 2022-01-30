Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03A4A35E5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354537AbiA3LXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:23:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:32820 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbiA3LXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:23:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5D0F1210EB;
        Sun, 30 Jan 2022 11:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643541786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ccVJS9YZplsYEfpyaDlr7gvvQ4c9GcKLVegwcDeZexI=;
        b=gakPX7k8jT1Yvrbgsntxr7CkR8OzB+yvL+6o0u5ZRVAF2Vsp3LHYnj1ejlKwonNs5t9qhF
        FxVSOLBxng0RMkFnoXrKRQd6Gc0C6Ll6x+KBYGJOvyjo6oTSPx4TcLL0vhtcxMVvhzuO43
        CLt863h865rIHPlrBshARDU0vjh+9aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643541786;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ccVJS9YZplsYEfpyaDlr7gvvQ4c9GcKLVegwcDeZexI=;
        b=5bM9qJOrdiQ1ZA7VTCmHvEY1Lwx3lJ5MvRPqGvlJTwpZOC40QEK0OT95AJ/v3vz9S6AxUh
        sgwGtpD2qrjY+4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41BF713638;
        Sun, 30 Jan 2022 11:23:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kc6fDxp19mFVcQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 30 Jan 2022 11:23:06 +0000
Date:   Sun, 30 Jan 2022 12:23:05 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v5.17-rc2
Message-ID: <YfZ1GTDDVz5WzYOJ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull irq/urgent fixes courtesy of Marc Zyngier, for v5.17.

Thx.

---

The following changes since commit a0af3d1104f752b6d0dba71788e3fddd67c857a7:

  PCI/MSI: Prevent UAF in error path (2022-01-21 02:14:46 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.17_rc2_p2

for you to fetch changes up to 243d30803744155a54bfb8a844cc964945cfd9a1:

  Merge tag 'irqchip-fixes-5.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent (2022-01-29 21:03:20 +0100)

----------------------------------------------------------------
- Drop an unused private data field in the AIC driver

- Various fixes to the realtek-rtl driver

- Make the GICv3 ITS driver compile again in !SMP configurations

- Force reset of the GICv3 ITSs at probe time to avoid issues during kexec

- Yet another kfree/bitmap_free conversion

- Various DT updates (Renesas, SiFive)

(from Marc Zyngier)

----------------------------------------------------------------
Ard Biesheuvel (1):
      irqchip/gic-v3-its: Fix build for !SMP

Christophe JAILLET (1):
      irqchip/loongson-pch-ms: Use bitmap_free() to free bitmap

Geert Uytterhoeven (3):
      dt-bindings: irqchip: renesas-irqc: Add R-Car V3U support
      dt-bindings: interrupt-controller: sifive,plic: Fix number of interrupts
      dt-bindings: interrupt-controller: sifive,plic: Group interrupt tuples

Marc Zyngier (2):
      irqchip/apple-aic: Drop unused ipi_hwirq field
      irqchip/gic-v3-its: Reset each ITS's BASERn register before probe

Sander Vanheule (3):
      irqchip/realtek-rtl: Map control data to virq
      irqchip/realtek-rtl: Fix off-by-one in routing
      irqchip/realtek-rtl: Service all pending interrupts

Thomas Gleixner (1):
      Merge tag 'irqchip-fixes-5.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  12 +-
 drivers/irqchip/irq-apple-aic.c                    |   1 -
 drivers/irqchip/irq-gic-v3-its.c                   | 123 +++++++++++++++++----
 drivers/irqchip/irq-loongson-pch-msi.c             |   2 +-
 drivers/irqchip/irq-realtek-rtl.c                  |  18 ++-
 6 files changed, 121 insertions(+), 36 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
