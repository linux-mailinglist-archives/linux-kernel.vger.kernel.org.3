Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2114E2317
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbiCUJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbiCUJQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:16:16 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5EC34643
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:14:51 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f1f2:313b:fe05:3e70])
        by baptiste.telenet-ops.be with bizsmtp
        id 8xEo2700F0qZUsV01xEopp; Mon, 21 Mar 2022 10:14:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nWE7k-005nvc-F8; Mon, 21 Mar 2022 10:14:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nWE7k-00Ewuz-3D; Mon, 21 Mar 2022 10:14:48 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v5.18
Date:   Mon, 21 Mar 2022 10:14:43 +0100
Message-Id: <20220321091443.3563010-1-geert@linux-m68k.org>
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

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.18-tag1

for you to fetch changes up to 0d52a01a266ba21840c7cb02e1de39c503759dda:

  m68k: defconfig: Disable fbdev on Sun3/3x (2022-02-28 12:00:16 +0100)

----------------------------------------------------------------
m68k updates for v5.18

  - Fix frame buffers backed by deferred I/O,
  - Defconfig updates,
  - Minor fixes and improvements.

----------------------------------------------------------------
Geert Uytterhoeven (3):
      m68k: mm: Remove check for VM_IO to fix deferred I/O
      m68k: defconfig: Update defconfigs for v5.17-rc3
      m68k: defconfig: Disable fbdev on Sun3/3x

Laurent Vivier (1):
      m68k: Add asm/config.h

 arch/m68k/amiga/config.c             |  1 +
 arch/m68k/apollo/config.c            |  1 +
 arch/m68k/atari/config.c             |  1 +
 arch/m68k/bvme6000/config.c          |  1 +
 arch/m68k/configs/amiga_defconfig    |  6 ++----
 arch/m68k/configs/apollo_defconfig   |  6 ++----
 arch/m68k/configs/atari_defconfig    |  5 +----
 arch/m68k/configs/bvme6000_defconfig |  5 +----
 arch/m68k/configs/hp300_defconfig    |  6 ++----
 arch/m68k/configs/mac_defconfig      |  5 +----
 arch/m68k/configs/multi_defconfig    |  6 ++----
 arch/m68k/configs/mvme147_defconfig  |  5 +----
 arch/m68k/configs/mvme16x_defconfig  |  5 +----
 arch/m68k/configs/q40_defconfig      |  5 +----
 arch/m68k/configs/sun3_defconfig     |  8 +-------
 arch/m68k/configs/sun3x_defconfig    |  8 +-------
 arch/m68k/hp300/config.c             |  1 +
 arch/m68k/include/asm/config.h       | 33 +++++++++++++++++++++++++++++++++
 arch/m68k/kernel/setup_mm.c          | 23 +----------------------
 arch/m68k/mac/config.c               |  1 +
 arch/m68k/mm/fault.c                 |  2 --
 arch/m68k/mvme147/config.c           |  1 +
 arch/m68k/mvme16x/config.c           |  1 +
 arch/m68k/q40/config.c               |  1 +
 24 files changed, 59 insertions(+), 78 deletions(-)
 create mode 100644 arch/m68k/include/asm/config.h

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
