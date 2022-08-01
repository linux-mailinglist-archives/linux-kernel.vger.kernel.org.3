Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F42586B38
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiHAMrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiHAMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:47:02 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7C10FF3
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:38:29 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id 2CeS280064C55Sk06CeSqv; Mon, 01 Aug 2022 14:38:26 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oIUgj-005kjs-RQ; Mon, 01 Aug 2022 14:38:25 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oIUgj-008Vk2-B6; Mon, 01 Aug 2022 14:38:25 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v5.20
Date:   Mon,  1 Aug 2022 14:38:21 +0200
Message-Id: <20220801123821.2028594-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.20-tag1

for you to fetch changes up to b508128bb0d1e243beb56cca5d819bcbb5c269b1:

  m68k: defconfig: Update defconfigs for v5.19-rc1 (2022-07-12 10:48:21 +0200)

----------------------------------------------------------------
m68k updates for v5.20

  - Use RNG seed from bootinfo block on virt platform,
  - Defconfig updates,
  - Minor fixes and improvements.

Thanks for pulling!

----------------------------------------------------------------
Amadeusz Sławiński (1):
      m68k: bitops: Change __fls to return and accept unsigned long

Geert Uytterhoeven (3):
      m68k: mac: Remove forward declaration for mac_nmi_handler()
      m68k: Add common forward declaration for show_registers()
      m68k: defconfig: Update defconfigs for v5.19-rc1

Jason A. Donenfeld (1):
      m68k: virt: Use RNG seed from bootinfo block

Jiang Jian (1):
      m68k: q40: Align '*' in comments

Juerg Haefliger (3):
      m68k: Kconfig.cpu: Fix indentation and add endif comments
      m68k: Kconfig.debug: Replace single quotes
      m68k: Kconfig.machine: Add endif comment

Laurent Vivier (1):
      m68k: virt: Kconfig minor fixes

Xiang wangx (1):
      m68k: mac: Fix typos in comments

XueBing Chen (1):
      m68k: sun3: Use __func__ to get function's name in an output message

Yang Yingliang (1):
      m68k: virt: Fix missing platform_device_unregister() on error in virt_platform_init()

 arch/m68k/Kconfig.cpu                      |  7 ++--
 arch/m68k/Kconfig.debug                    |  6 ++--
 arch/m68k/Kconfig.machine                  |  5 +--
 arch/m68k/configs/amiga_defconfig          | 14 +++-----
 arch/m68k/configs/apollo_defconfig         | 14 +++-----
 arch/m68k/configs/atari_defconfig          | 14 +++-----
 arch/m68k/configs/bvme6000_defconfig       | 14 +++-----
 arch/m68k/configs/hp300_defconfig          | 14 +++-----
 arch/m68k/configs/mac_defconfig            | 14 +++-----
 arch/m68k/configs/multi_defconfig          | 14 +++-----
 arch/m68k/configs/mvme147_defconfig        | 14 +++-----
 arch/m68k/configs/mvme16x_defconfig        | 14 +++-----
 arch/m68k/configs/q40_defconfig            | 14 +++-----
 arch/m68k/configs/sun3_defconfig           | 14 +++-----
 arch/m68k/configs/sun3x_defconfig          | 14 +++-----
 arch/m68k/include/asm/bitops.h             |  2 +-
 arch/m68k/include/asm/processor.h          |  1 +
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  8 +++++
 arch/m68k/kernel/traps.c                   |  1 +
 arch/m68k/mac/iop.c                        |  4 +--
 arch/m68k/mac/macints.c                    | 35 +++++++++---------
 arch/m68k/q40/q40ints.c                    |  2 +-
 arch/m68k/sun3/mmu_emu.c                   | 11 +++---
 arch/m68k/virt/config.c                    | 11 ++++++
 arch/m68k/virt/ints.c                      |  3 +-
 arch/m68k/virt/platform.c                  | 58 +++++++++++++++++-------------
 26 files changed, 149 insertions(+), 173 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
