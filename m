Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAA9489520
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbiAJJXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242821AbiAJJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:23:09 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCDAC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:23:08 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:642b:90c3:525f:9b61])
        by laurent.telenet-ops.be with bizsmtp
        id gxP52600Z582urF01xP5sv; Mon, 10 Jan 2022 10:23:06 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n6qtN-008ym3-FR; Mon, 10 Jan 2022 10:23:05 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n6qtM-0083tD-Oe; Mon, 10 Jan 2022 10:23:04 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v5.17
Date:   Mon, 10 Jan 2022 10:23:03 +0100
Message-Id: <20220110092303.1921532-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.17-tag1

for you to fetch changes up to 1a0ae068bf6b6f4233b1f31bf48bcbc47b111ef2:

  m68k: defconfig: Update defconfigs for v5.16-rc1 (2021-12-13 14:48:13 +0100)

----------------------------------------------------------------
m68k updates for v5.17

  - Enable memtest functionality,
  - Defconfig updates.

----------------------------------------------------------------
Finn Thain (1):
      m68k: Enable memtest functionality

Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v5.16-rc1

 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/m68k/Kconfig                               |  1 +
 arch/m68k/configs/amiga_defconfig               |  2 --
 arch/m68k/configs/apollo_defconfig              |  2 --
 arch/m68k/configs/atari_defconfig               |  2 --
 arch/m68k/configs/bvme6000_defconfig            |  2 --
 arch/m68k/configs/hp300_defconfig               |  2 --
 arch/m68k/configs/mac_defconfig                 |  2 --
 arch/m68k/configs/multi_defconfig               |  2 --
 arch/m68k/configs/mvme147_defconfig             |  2 --
 arch/m68k/configs/mvme16x_defconfig             |  2 --
 arch/m68k/configs/q40_defconfig                 |  2 --
 arch/m68k/configs/sun3_defconfig                |  2 --
 arch/m68k/configs/sun3x_defconfig               |  2 --
 arch/m68k/kernel/setup_mm.c                     | 15 ++++++---------
 arch/m68k/mm/motorola.c                         |  2 ++
 16 files changed, 10 insertions(+), 34 deletions(-)

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
