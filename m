Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0995530CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiEWJWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiEWJWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:22:09 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB5F220F8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:22:06 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:4593:272c:6293:e2cc])
        by andre.telenet-ops.be with bizsmtp
        id a9N4270052jQL2A019N4o9; Mon, 23 May 2022 11:22:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nt4GJ-001KLT-L4; Mon, 23 May 2022 11:22:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nt4GI-003jSU-Ob; Mon, 23 May 2022 11:22:02 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v5.19
Date:   Mon, 23 May 2022 11:22:00 +0200
Message-Id: <20220523092200.889682-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.19-tag1

for you to fetch changes up to 30b5e6ef4a32ea4985b99200e06d6660a69f9246:

  m68k: atari: Make Atari ROM port I/O write macros return void (2022-05-22 12:24:14 +0200)

----------------------------------------------------------------
m68k updates for v5.19

  - Introduce virtual m68k machine based on Android Goldfish devices,
  - Defconfig updates,
  - Minor fixes and improvements.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (3):
      m68k: defconfig: Update defconfigs for v5.18-rc1
      m68k: math-emu: Fix dependencies of math emulation support
      m68k: atari: Make Atari ROM port I/O write macros return void

Julia Lawall (1):
      m68k: math-emu: Fix typos in comments

Laurent Vivier (4):
      tty: goldfish: Introduce gf_ioread32()/gf_iowrite32()
      rtc: goldfish: Use gf_ioread32()/gf_iowrite32()
      clocksource/drivers: Add a goldfish-timer clocksource
      m68k: Introduce a virtual m68k machine

Michael Schmitz (1):
      m68k: Wire up syscall_trace_enter/leave for m68k

 arch/m68k/Kbuild                           |   1 +
 arch/m68k/Kconfig.cpu                      |   2 +-
 arch/m68k/Kconfig.machine                  |  17 ++++
 arch/m68k/configs/amiga_defconfig          |   5 +-
 arch/m68k/configs/apollo_defconfig         |   5 +-
 arch/m68k/configs/atari_defconfig          |   5 +-
 arch/m68k/configs/bvme6000_defconfig       |   5 +-
 arch/m68k/configs/hp300_defconfig          |   5 +-
 arch/m68k/configs/mac_defconfig            |   5 +-
 arch/m68k/configs/multi_defconfig          |   5 +-
 arch/m68k/configs/mvme147_defconfig        |   5 +-
 arch/m68k/configs/mvme16x_defconfig        |   5 +-
 arch/m68k/configs/q40_defconfig            |   5 +-
 arch/m68k/configs/sun3_defconfig           |   5 +-
 arch/m68k/configs/sun3x_defconfig          |   5 +-
 arch/m68k/configs/virt_defconfig           |  68 +++++++++++++
 arch/m68k/include/asm/config.h             |   2 +
 arch/m68k/include/asm/io.h                 |   3 +
 arch/m68k/include/asm/irq.h                |   3 +-
 arch/m68k/include/asm/pgtable_mm.h         |   7 ++
 arch/m68k/include/asm/raw_io.h             |   6 +-
 arch/m68k/include/asm/setup.h              |  44 ++++++--
 arch/m68k/include/asm/virt.h               |  25 +++++
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  18 ++++
 arch/m68k/include/uapi/asm/bootinfo.h      |   1 +
 arch/m68k/kernel/Makefile                  |   1 +
 arch/m68k/kernel/entry.S                   |   4 +-
 arch/m68k/kernel/head.S                    |  31 ++++++
 arch/m68k/kernel/ptrace.c                  |   7 --
 arch/m68k/kernel/setup_mm.c                |   7 ++
 arch/m68k/math-emu/fp_arith.c              |   2 +-
 arch/m68k/mm/kmap.c                        |  21 ++--
 arch/m68k/virt/Makefile                    |   6 ++
 arch/m68k/virt/config.c                    | 130 ++++++++++++++++++++++++
 arch/m68k/virt/ints.c                      | 155 +++++++++++++++++++++++++++++
 arch/m68k/virt/platform.c                  |  72 ++++++++++++++
 drivers/clocksource/Kconfig                |   7 ++
 drivers/clocksource/Makefile               |   1 +
 drivers/clocksource/timer-goldfish.c       | 153 ++++++++++++++++++++++++++++
 drivers/rtc/rtc-goldfish.c                 |  44 ++++----
 drivers/tty/goldfish.c                     |  20 ++--
 include/clocksource/timer-goldfish.h       |  31 ++++++
 include/linux/goldfish.h                   |  15 ++-
 43 files changed, 844 insertions(+), 120 deletions(-)
 create mode 100644 arch/m68k/configs/virt_defconfig
 create mode 100644 arch/m68k/include/asm/virt.h
 create mode 100644 arch/m68k/include/uapi/asm/bootinfo-virt.h
 create mode 100644 arch/m68k/virt/Makefile
 create mode 100644 arch/m68k/virt/config.c
 create mode 100644 arch/m68k/virt/ints.c
 create mode 100644 arch/m68k/virt/platform.c
 create mode 100644 drivers/clocksource/timer-goldfish.c
 create mode 100644 include/clocksource/timer-goldfish.h

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
