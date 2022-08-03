Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C173588E48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbiHCOKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiHCOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:10:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F20430F57;
        Wed,  3 Aug 2022 07:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10894B82284;
        Wed,  3 Aug 2022 14:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C816C433D6;
        Wed,  3 Aug 2022 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659535801;
        bh=oheph6DspN5FjW1+XMyazQKH3hpZGP3YuVoSH2VIo6M=;
        h=Date:From:To:Cc:Subject:From;
        b=C5H2icqV1P2HCF0d8KVUy4UmaGocksDcnF8JLO7dOFKbik0PudHMKy2eUZ+hbTjc8
         rgOSoVN6UiUhR28j/dex1NyHmNiOhUmmfz1MYLXXRYX6Uj8LCog+X+v6Pu+DbXsx3i
         W7RW2Bh1O3eZj/za34iLdblr7xRdozP/ybW/Mokk=
Date:   Wed, 3 Aug 2022 16:09:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX update for 6.0-rc1
Message-ID: <YuqBtvFv1gaAkD+E@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-6.0-rc1

for you to fetch changes up to 58301e1c15db89c0edc6a122c8f6fb5af271954b:

  Documentation: samsung-s3c24xx: Add blank line after SPDX directive (2022-06-27 14:49:54 +0200)

----------------------------------------------------------------
SPDX changes for 6.0-rc1

Here is the set of SPDX comment updates for 6.0-rc1.

Nothing huge here, just a number of updated SPDX license tags and
cleanups based on the review of a number of common patterns in GPLv2
boilerplate text.  Also included in here are a few other minor updates,
2 USB files, and one Documentation file update to get the SPDX lines
correct.

All of these have been in the linux-next tree for a very long time.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bagas Sanjaya (1):
      Documentation: samsung-s3c24xx: Add blank line after SPDX directive

Christophe JAILLET (2):
      USB: Follow-up to SPDX identifiers addition - remove now useless comments
      USB: Follow-up to SPDX GPL-2.0+ identifiers addition - remove now useless comments

Thomas Gleixner (25):
      netfilter: xtables: Bring SPDX identifier back
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_8.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_30.RULE (part 1)
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_30.RULE (part 2)
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_56.RULE (part 1)
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_56.RULE (part 2)
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_133.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_147.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_149.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_152.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_160.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_168.RULE (part 1)
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_168.RULE (part 2)
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_179.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_292.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_298.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_318.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_319.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_320.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_385.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_390.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_391.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_398.RULE
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_406.RULE
      x86/crypto: Remove stray comment terminator

 Documentation/arm/samsung-s3c24xx/cpufreq.rst      |  3 ++-
 Documentation/driver-api/vfio-mediated-device.rst  |  4 +---
 arch/arm/boot/bootp/bootp.lds                      |  5 +----
 arch/arm/boot/dts/am33xx.dtsi                      |  5 +----
 arch/arm/boot/dts/am3517.dtsi                      |  5 +----
 arch/arm/boot/dts/am4372.dtsi                      |  5 +----
 arch/arm/boot/dts/artpec6-devboard.dts             |  9 ++------
 arch/arm/boot/dts/bcm11351.dtsi                    | 14 ++-----------
 arch/arm/boot/dts/bcm21664-garnet.dts              | 14 ++-----------
 arch/arm/boot/dts/bcm21664.dtsi                    | 14 ++-----------
 arch/arm/boot/dts/bcm28155-ap.dts                  | 14 ++-----------
 arch/arm/boot/dts/dm814x.dtsi                      |  6 +-----
 arch/arm/boot/dts/dm816x.dtsi                      |  6 +-----
 arch/arm/boot/dts/dra62x.dtsi                      |  6 +-----
 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi         |  5 +----
 arch/arm/boot/dts/dra7-iva-thermal.dtsi            |  5 +----
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi          | 10 +--------
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi          | 10 +--------
 arch/arm/boot/dts/imx23-pinfunc.h                  |  8 +-------
 arch/arm/boot/dts/imx28-pinfunc.h                  |  8 +-------
 arch/arm/boot/dts/imx6q-gk802.dts                  |  9 ++------
 arch/arm/boot/dts/mxs-pinfunc.h                    |  8 +-------
 arch/arm/boot/dts/omap2.dtsi                       |  5 +----
 arch/arm/boot/dts/omap2420.dtsi                    |  5 +----
 arch/arm/boot/dts/omap2430.dtsi                    |  5 +----
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi           |  5 +----
 arch/arm/boot/dts/omap3.dtsi                       |  5 +----
 arch/arm/boot/dts/omap34xx.dtsi                    |  5 +----
 arch/arm/boot/dts/omap36xx.dtsi                    |  5 +----
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi           |  5 +----
 arch/arm/boot/dts/omap443x.dtsi                    |  5 +----
 arch/arm/boot/dts/omap4460.dtsi                    |  5 +----
 arch/arm/boot/dts/omap5-core-thermal.dtsi          |  5 +----
 arch/arm/boot/dts/omap5-gpu-thermal.dtsi           |  5 +----
 arch/arm/boot/dts/orion5x-lacie-d2-network.dts     |  5 +----
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |  9 ++------
 .../boot/dts/orion5x-maxtor-shared-storage-2.dts   |  5 +----
 arch/arm/boot/dts/orion5x-mv88f5181.dtsi           |  9 ++------
 arch/arm/boot/dts/orion5x-mv88f5182.dtsi           |  9 ++------
 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts      |  9 ++------
 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts        |  9 ++------
 arch/arm/boot/dts/orion5x.dtsi                     |  9 ++------
 arch/arm/include/asm/hardware/cache-aurora-l2.h    |  5 +----
 arch/arm/include/asm/hardware/cache-feroceon-l2.h  |  6 +-----
 arch/arm/include/asm/hardware/cache-tauros2.h      |  5 +----
 arch/arm/include/debug/brcmstb.S                   | 14 ++-----------
 arch/arm/mach-bcm/Makefile                         |  9 +-------
 arch/arm/mach-bcm/bcm63xx.c                        | 14 ++-----------
 arch/arm/mach-bcm/bcm_cygnus.c                     | 14 ++-----------
 arch/arm/mach-bcm/bcm_hr2.c                        | 14 ++-----------
 arch/arm/mach-bcm/bcm_kona_smc.c                   | 14 ++-----------
 arch/arm/mach-bcm/bcm_kona_smc.h                   | 14 ++-----------
 arch/arm/mach-bcm/bcm_nsp.c                        | 14 ++-----------
 arch/arm/mach-bcm/board_bcm21664.c                 | 14 ++-----------
 arch/arm/mach-bcm/board_bcm23550.c                 | 14 ++-----------
 arch/arm/mach-bcm/board_bcm281xx.c                 | 14 ++-----------
 arch/arm/mach-bcm/brcmstb.c                        | 14 ++-----------
 arch/arm/mach-bcm/kona_l2_cache.c                  | 14 ++-----------
 arch/arm/mach-bcm/kona_l2_cache.h                  | 14 ++-----------
 arch/arm/mach-bcm/platsmp-brcmstb.c                | 10 +--------
 arch/arm/mach-davinci/board-da830-evm.c            |  6 ++----
 arch/arm/mach-davinci/board-da850-evm.c            |  6 ++----
 arch/arm/mach-davinci/board-dm355-evm.c            |  6 ++----
 arch/arm/mach-davinci/board-dm355-leopard.c        |  5 +----
 arch/arm/mach-davinci/board-dm365-evm.c            | 11 +---------
 arch/arm/mach-davinci/board-dm644x-evm.c           |  6 ++----
 arch/arm/mach-davinci/board-dm646x-evm.c           |  7 +------
 arch/arm/mach-davinci/board-mityomapl138.c         |  5 +----
 arch/arm/mach-davinci/board-neuros-osd2.c          |  5 +----
 arch/arm/mach-davinci/board-omapl138-hawk.c        |  5 +----
 arch/arm/mach-davinci/common.c                     |  6 ++----
 arch/arm/mach-davinci/common.h                     |  6 ++----
 arch/arm/mach-davinci/cpuidle.h                    |  5 +----
 arch/arm/mach-davinci/cputype.h                    |  6 ++----
 arch/arm/mach-davinci/da830.c                      |  6 ++----
 arch/arm/mach-davinci/da850.c                      |  6 ++----
 arch/arm/mach-davinci/da8xx.h                      |  6 ++----
 arch/arm/mach-davinci/davinci.h                    | 10 +--------
 arch/arm/mach-davinci/dm355.c                      |  6 ++----
 arch/arm/mach-davinci/dm365.c                      | 10 +--------
 arch/arm/mach-davinci/dm644x.c                     |  6 ++----
 arch/arm/mach-davinci/dm646x.c                     |  6 ++----
 arch/arm/mach-davinci/hardware.h                   |  6 ++----
 arch/arm/mach-davinci/mux.c                        |  6 ++----
 arch/arm/mach-davinci/mux.h                        |  6 ++----
 arch/arm/mach-davinci/pm.h                         | 10 +--------
 arch/arm/mach-davinci/pm_domain.c                  |  5 +----
 arch/arm/mach-davinci/serial.h                     |  6 ++----
 arch/arm/mach-dove/bridge-regs.h                   |  9 ++------
 arch/arm/mach-dove/cm-a510.c                       |  5 +----
 arch/arm/mach-dove/common.c                        |  5 +----
 arch/arm/mach-dove/common.h                        |  5 +----
 arch/arm/mach-dove/dove-db-setup.c                 |  5 +----
 arch/arm/mach-dove/dove.h                          |  9 ++------
 arch/arm/mach-dove/irq.c                           |  5 +----
 arch/arm/mach-dove/irqs.h                          |  9 ++------
 arch/arm/mach-dove/mpp.c                           |  5 +----
 arch/arm/mach-dove/pcie.c                          |  5 +----
 arch/arm/mach-dove/pm.h                            |  6 +-----
 arch/arm/mach-lpc18xx/board-dt.c                   |  5 +----
 arch/arm/mach-lpc32xx/pm.c                         |  6 ++----
 arch/arm/mach-lpc32xx/suspend.S                    |  6 ++----
 arch/arm/mach-mv78xx0/bridge-regs.h                |  6 +-----
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c          |  5 +----
 arch/arm/mach-mv78xx0/common.c                     |  5 +----
 arch/arm/mach-mv78xx0/common.h                     |  5 +----
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c           |  5 +----
 arch/arm/mach-mv78xx0/irq.c                        |  5 +----
 arch/arm/mach-mv78xx0/irqs.h                       |  9 ++------
 arch/arm/mach-mv78xx0/mpp.c                        |  5 +----
 arch/arm/mach-mv78xx0/mpp.h                        |  6 +-----
 arch/arm/mach-mv78xx0/mv78xx0.h                    |  5 +----
 arch/arm/mach-mv78xx0/pcie.c                       |  5 +----
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c         |  5 +----
 arch/arm/mach-mvebu/armada-370-xp.h                |  5 +----
 arch/arm/mach-mvebu/board-v7.c                     |  5 +----
 arch/arm/mach-mvebu/coherency.c                    |  5 +----
 arch/arm/mach-mvebu/coherency.h                    |  6 +-----
 arch/arm/mach-mvebu/coherency_ll.S                 |  5 +----
 arch/arm/mach-mvebu/common.h                       |  5 +----
 arch/arm/mach-mvebu/cpu-reset.c                    |  5 +----
 arch/arm/mach-mvebu/dove.c                         |  5 +----
 arch/arm/mach-mvebu/headsmp-a9.S                   |  5 +----
 arch/arm/mach-mvebu/headsmp.S                      |  5 +----
 arch/arm/mach-mvebu/kirkwood.c                     |  5 +----
 arch/arm/mach-mvebu/kirkwood.h                     |  5 +----
 arch/arm/mach-mvebu/mvebu-soc-id.c                 |  5 +----
 arch/arm/mach-mvebu/mvebu-soc-id.h                 |  5 +----
 arch/arm/mach-mvebu/platsmp-a9.c                   |  5 +----
 arch/arm/mach-mvebu/platsmp.c                      |  5 +----
 arch/arm/mach-mvebu/pm-board.c                     |  5 +----
 arch/arm/mach-mvebu/pm.c                           |  5 +----
 arch/arm/mach-mvebu/pmsu.c                         |  5 +----
 arch/arm/mach-mvebu/pmsu.h                         |  5 +----
 arch/arm/mach-mvebu/pmsu_ll.S                      |  5 +----
 arch/arm/mach-mvebu/system-controller.c            |  5 +----
 arch/arm/mach-omap1/board-sx1.h                    |  9 +-------
 arch/arm/mach-omap1/gpio15xx.c                     | 10 +--------
 arch/arm/mach-omap1/gpio16xx.c                     | 10 +--------
 arch/arm/mach-omap1/gpio7xx.c                      | 10 +--------
 arch/arm/mach-omap1/mtd-xip.h                      |  6 ++----
 arch/arm/mach-omap1/pm_bus.c                       |  6 +-----
 arch/arm/mach-omap1/timer.c                        | 10 +--------
 arch/arm/mach-omap2/am33xx.h                       | 10 +--------
 arch/arm/mach-omap2/clockdomains33xx_data.c        | 10 +--------
 arch/arm/mach-omap2/clockdomains81xx_data.c        | 10 +--------
 arch/arm/mach-omap2/cm-regbits-33xx.h              | 10 +--------
 arch/arm/mach-omap2/cm33xx.c                       | 10 +--------
 arch/arm/mach-omap2/cm33xx.h                       | 10 +--------
 arch/arm/mach-omap2/cm81xx.h                       | 10 +--------
 arch/arm/mach-omap2/display.c                      | 10 +--------
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         | 11 +---------
 arch/arm/mach-omap2/omap_opp_data.h                | 10 +--------
 arch/arm/mach-omap2/opp3xxx_data.c                 | 10 +--------
 arch/arm/mach-omap2/opp4xxx_data.c                 | 10 +--------
 arch/arm/mach-omap2/powerdomains33xx_data.c        | 10 +--------
 arch/arm/mach-omap2/prcm43xx.h                     |  5 +----
 arch/arm/mach-omap2/prm-regbits-33xx.h             | 10 +--------
 arch/arm/mach-omap2/prm33xx.c                      | 10 +--------
 arch/arm/mach-omap2/prm33xx.h                      | 10 +--------
 arch/arm/mach-omap2/ti81xx.h                       | 10 +--------
 arch/arm/mach-omap2/vc.c                           |  6 +-----
 arch/arm/mach-orion5x/board-d2net.c                |  5 +----
 arch/arm/mach-orion5x/board-dt.c                   |  5 +----
 arch/arm/mach-orion5x/board-rd88f5182.c            |  5 +----
 arch/arm/mach-orion5x/bridge-regs.h                |  9 ++------
 arch/arm/mach-orion5x/common.c                     |  5 +----
 arch/arm/mach-orion5x/db88f5281-setup.c            |  5 +----
 arch/arm/mach-orion5x/irq.c                        |  5 +----
 arch/arm/mach-orion5x/irqs.h                       |  5 +----
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |  5 +----
 arch/arm/mach-orion5x/ls_hgl-setup.c               |  5 +----
 arch/arm/mach-orion5x/mpp.c                        |  5 +----
 arch/arm/mach-orion5x/net2big-setup.c              |  6 +-----
 arch/arm/mach-orion5x/orion5x.h                    |  5 +----
 arch/arm/mach-orion5x/pci.c                        |  5 +----
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |  5 +----
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |  5 +----
 arch/arm/mach-orion5x/rd88f5182-setup.c            |  5 +----
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c       |  5 +----
 arch/arm/mach-orion5x/ts78xx-setup.c               |  5 +----
 arch/arm/mach-orion5x/wnr854t-setup.c              |  9 ++------
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |  9 ++------
 arch/arm/mach-pxa/eseries.c                        |  7 +------
 arch/arm/mach-pxa/standby.S                        |  6 ++----
 arch/arm/mach-spear/generic.h                      |  5 +----
 arch/arm/mach-spear/misc_regs.h                    |  5 +----
 arch/arm/mach-spear/pl080.c                        |  5 +----
 arch/arm/mach-spear/pl080.h                        |  5 +----
 arch/arm/mach-spear/restart.c                      |  5 +----
 arch/arm/mach-spear/spear.h                        |  5 +----
 arch/arm/mach-spear/spear1310.c                    |  5 +----
 arch/arm/mach-spear/spear1340.c                    |  5 +----
 arch/arm/mach-spear/spear13xx.c                    |  5 +----
 arch/arm/mach-spear/spear300.c                     |  5 +----
 arch/arm/mach-spear/spear310.c                     |  5 +----
 arch/arm/mach-spear/spear320.c                     |  5 +----
 arch/arm/mach-spear/spear3xx.c                     |  5 +----
 arch/arm/mach-spear/spear6xx.c                     |  5 +----
 arch/arm/mach-spear/time.c                         |  5 +----
 arch/arm/mach-versatile/spc.c                      | 10 +--------
 arch/arm/mm/cache-feroceon-l2.c                    |  5 +----
 arch/arm/mm/cache-tauros2.c                        |  5 +----
 arch/arm64/boot/dts/mediatek/mt6755.dtsi           |  9 +-------
 arch/arm64/boot/dts/mediatek/mt6795.dtsi           |  9 +-------
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  9 +-------
 arch/powerpc/kernel/kgdb.c                         |  5 +----
 arch/sparc/vdso/vdso2c.c                           |  2 +-
 arch/x86/crypto/crc32-pclmul_asm.S                 | 24 +---------------------
 arch/x86/entry/vdso/vdso2c.c                       |  2 +-
 drivers/bluetooth/btmrvl_debugfs.c                 | 15 +-------------
 drivers/bluetooth/btmrvl_drv.h                     | 16 +--------------
 drivers/bluetooth/btmrvl_main.c                    | 15 +-------------
 drivers/bluetooth/btmrvl_sdio.c                    | 15 +-------------
 drivers/bluetooth/btmrvl_sdio.h                    | 16 +--------------
 drivers/bus/mvebu-mbus.c                           |  5 +----
 drivers/bus/omap_l3_noc.c                          | 10 +--------
 drivers/bus/omap_l3_noc.h                          | 10 +--------
 drivers/bus/sunxi-rsb.c                            |  6 +-----
 drivers/bus/tegra-gmi.c                            |  5 +----
 drivers/bus/ts-nbus.c                              |  5 +----
 drivers/char/hw_random/iproc-rng200.c              |  9 +-------
 drivers/clk/axs10x/i2s_pll_clock.c                 |  5 +----
 drivers/clk/axs10x/pll_clock.c                     |  5 +----
 drivers/clk/bcm/clk-bcm21664.c                     | 10 +--------
 drivers/clk/bcm/clk-bcm281xx.c                     | 10 +--------
 drivers/clk/bcm/clk-bcm63xx.c                      | 14 ++-----------
 drivers/clk/bcm/clk-cygnus.c                       | 14 ++-----------
 drivers/clk/bcm/clk-hr2.c                          | 14 ++-----------
 drivers/clk/bcm/clk-iproc-armpll.c                 | 14 ++-----------
 drivers/clk/bcm/clk-iproc-asiu.c                   | 14 ++-----------
 drivers/clk/bcm/clk-iproc-pll.c                    | 14 ++-----------
 drivers/clk/bcm/clk-iproc.h                        | 14 ++-----------
 drivers/clk/bcm/clk-kona-setup.c                   | 10 +--------
 drivers/clk/bcm/clk-kona.c                         | 10 +--------
 drivers/clk/bcm/clk-kona.h                         | 10 +--------
 drivers/clk/bcm/clk-ns2.c                          | 14 ++-----------
 drivers/clk/bcm/clk-nsp.c                          | 14 ++-----------
 drivers/clk/clk-hsdk-pll.c                         |  5 +----
 drivers/clk/clk-moxart.c                           |  5 +----
 drivers/clk/keystone/sci-clk.c                     | 10 +--------
 drivers/clk/mmp/clk-apbc.c                         |  5 +----
 drivers/clk/mmp/clk-apmu.c                         |  5 +----
 drivers/clk/mmp/clk-frac.c                         |  5 +----
 drivers/clk/mmp/clk-gate.c                         |  5 +----
 drivers/clk/mmp/clk-mix.c                          |  5 +----
 drivers/clk/mmp/clk-mmp2.c                         |  5 +----
 drivers/clk/mmp/clk-of-mmp2.c                      |  5 +----
 drivers/clk/mmp/clk-of-pxa168.c                    |  5 +----
 drivers/clk/mmp/clk-of-pxa1928.c                   |  5 +----
 drivers/clk/mmp/clk-of-pxa910.c                    |  5 +----
 drivers/clk/mmp/clk-pxa168.c                       |  5 +----
 drivers/clk/mmp/clk-pxa910.c                       |  5 +----
 drivers/clk/nxp/clk-lpc18xx-ccu.c                  |  5 +----
 drivers/clk/nxp/clk-lpc18xx-cgu.c                  |  5 +----
 drivers/clk/nxp/clk-lpc18xx-creg.c                 |  5 +----
 drivers/clk/spear/clk-aux-synth.c                  |  5 +----
 drivers/clk/spear/clk-frac-synth.c                 |  5 +----
 drivers/clk/spear/clk-gpt-synth.c                  |  5 +----
 drivers/clk/spear/clk-vco-pll.c                    |  5 +----
 drivers/clk/spear/clk.c                            |  5 +----
 drivers/clk/spear/clk.h                            |  5 +----
 drivers/clk/spear/spear1310_clock.c                |  5 +----
 drivers/clk/spear/spear1340_clock.c                |  5 +----
 drivers/clk/spear/spear3xx_clock.c                 |  5 +----
 drivers/clk/spear/spear6xx_clock.c                 |  5 +----
 drivers/clk/ti/adpll.c                             | 11 +---------
 drivers/clk/ti/apll.c                              | 10 +--------
 drivers/clk/ti/autoidle.c                          | 10 +--------
 drivers/clk/ti/clk-2xxx.c                          | 10 +--------
 drivers/clk/ti/clk-33xx.c                          | 10 +--------
 drivers/clk/ti/clk-3xxx.c                          | 10 +--------
 drivers/clk/ti/clk-43xx.c                          | 10 +--------
 drivers/clk/ti/clk-816x.c                          | 11 +---------
 drivers/clk/ti/clk-dra7-atl.c                      | 10 +--------
 drivers/clk/ti/clk.c                               | 10 +--------
 drivers/clk/ti/clkctrl.c                           | 10 +--------
 drivers/clk/ti/clkt_dflt.c                         | 10 +--------
 drivers/clk/ti/clock.h                             | 10 +--------
 drivers/clk/ti/clockdomain.c                       | 10 +--------
 drivers/clk/ti/composite.c                         | 10 +--------
 drivers/clk/ti/divider.c                           | 10 +--------
 drivers/clk/ti/dpll.c                              | 10 +--------
 drivers/clk/ti/fapll.c                             | 11 +---------
 drivers/clk/ti/fixed-factor.c                      | 10 +--------
 drivers/clk/ti/gate.c                              | 10 +--------
 drivers/clk/ti/interface.c                         | 10 +--------
 drivers/clk/ti/mux.c                               | 10 +--------
 drivers/cpufreq/mvebu-cpufreq.c                    |  5 +----
 drivers/cpufreq/scpi-cpufreq.c                     | 10 +--------
 drivers/cpuidle/cpuidle-at91.c                     |  5 +----
 drivers/cpuidle/cpuidle-kirkwood.c                 |  5 +----
 drivers/dma/bcm-sba-raid.c                         | 14 ++-----------
 drivers/dma/bestcomm/ata.c                         |  7 +------
 drivers/dma/bestcomm/bestcomm.c                    |  7 +------
 drivers/dma/bestcomm/fec.c                         |  7 +------
 drivers/dma/bestcomm/sram.c                        |  7 +------
 drivers/dma/moxart-dma.c                           |  5 +----
 drivers/dma/ppc4xx/adma.h                          |  5 +----
 drivers/dma/ppc4xx/dma.h                           |  5 +----
 drivers/dma/ppc4xx/xor.h                           |  5 +----
 drivers/dma/ti/edma.c                              | 10 +--------
 drivers/edac/edac_pci.c                            |  7 ++-----
 drivers/edac/fsl_ddr_edac.c                        |  6 ++----
 drivers/edac/fsl_ddr_edac.h                        |  7 ++-----
 drivers/edac/mpc85xx_edac.h                        |  7 ++-----
 drivers/gpio/gpio-bcm-kona.c                       | 10 +--------
 drivers/gpio/gpio-brcmstb.c                        | 14 ++-----------
 drivers/gpio/gpio-lp873x.c                         | 10 +--------
 drivers/gpio/gpio-lp87565.c                        | 10 +--------
 drivers/gpio/gpio-mpc8xxx.c                        |  5 +----
 drivers/gpio/gpio-mvebu.c                          |  5 +----
 drivers/gpio/gpio-pisosr.c                         | 10 +--------
 drivers/gpio/gpio-spear-spics.c                    |  5 +----
 drivers/gpio/gpio-tpic2810.c                       | 10 +--------
 drivers/gpio/gpio-ts4800.c                         |  5 +----
 drivers/i2c/busses/i2c-bcm-iproc.c                 | 14 ++-----------
 drivers/i2c/busses/i2c-bcm-kona.c                  | 14 ++-----------
 drivers/i2c/busses/i2c-brcmstb.c                   | 14 ++-----------
 drivers/input/keyboard/bcm-keypad.c                | 14 ++-----------
 drivers/input/misc/gpio_decoder.c                  | 10 +--------
 drivers/input/misc/palmas-pwrbutton.c              | 10 +--------
 drivers/input/misc/tps65218-pwrbutton.c            | 10 +--------
 drivers/input/touchscreen/bcm_iproc_tsc.c          |  9 +-------
 drivers/irqchip/irq-keystone.c                     | 10 +--------
 drivers/mailbox/bcm-flexrm-mailbox.c               | 14 ++-----------
 drivers/media/i2c/adv7343_regs.h                   | 10 +--------
 drivers/media/i2c/adv7393_regs.h                   | 10 +--------
 drivers/media/platform/ti/davinci/vpif.h           | 11 +---------
 drivers/media/platform/ti/davinci/vpif_display.h   | 10 +--------
 drivers/memory/ti-emif-sram-pm.S                   | 10 +--------
 drivers/mfd/lp873x.c                               | 10 +--------
 drivers/mfd/tps65086.c                             | 10 +--------
 drivers/mfd/tps65217.c                             | 10 +--------
 drivers/mfd/tps65218.c                             | 10 +--------
 drivers/mfd/tps65912-core.c                        | 10 +--------
 drivers/mfd/tps65912-i2c.c                         | 10 +--------
 drivers/mfd/tps65912-spi.c                         | 10 +--------
 drivers/misc/sram-exec.c                           | 10 +--------
 drivers/mmc/host/sdhci-bcm-kona.c                  | 14 ++-----------
 drivers/mmc/host/sdhci-iproc.c                     | 14 ++-----------
 drivers/net/can/ti_hecc.c                          | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/common.h         | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/cphy.h           | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/cpl5_cmd.h       | 12 +----------
 drivers/net/ethernet/chelsio/cxgb/elmer0.h         | 12 +----------
 drivers/net/ethernet/chelsio/cxgb/espi.c           | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/espi.h           | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/gmac.h           | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/mv88x201x.c      | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/pm3393.c         | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/regs.h           | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/sge.c            | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/sge.h            | 11 +---------
 drivers/net/ethernet/chelsio/cxgb/subr.c           | 11 +---------
 .../net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h  | 12 +----------
 drivers/net/ethernet/cisco/enic/cq_desc.h          | 15 +-------------
 drivers/net/ethernet/cisco/enic/cq_enet_desc.h     | 15 +-------------
 drivers/net/ethernet/cisco/enic/enic.h             | 15 +-------------
 drivers/net/ethernet/cisco/enic/enic_api.c         | 19 ++---------------
 drivers/net/ethernet/cisco/enic/enic_api.h         | 19 ++---------------
 drivers/net/ethernet/cisco/enic/enic_dev.c         | 19 ++---------------
 drivers/net/ethernet/cisco/enic/enic_dev.h         | 19 ++---------------
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     | 19 ++---------------
 drivers/net/ethernet/cisco/enic/enic_pp.c          | 19 ++---------------
 drivers/net/ethernet/cisco/enic/enic_pp.h          | 19 ++---------------
 drivers/net/ethernet/cisco/enic/enic_res.c         | 15 +-------------
 drivers/net/ethernet/cisco/enic/enic_res.h         | 15 +-------------
 drivers/net/ethernet/cisco/enic/rq_enet_desc.h     | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_cq.c          | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_cq.h          | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_dev.c         | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_dev.h         | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h      | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_enet.h        | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_intr.c        | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_intr.h        | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_nic.h         | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_resource.h    | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_rq.c          | 16 +--------------
 drivers/net/ethernet/cisco/enic/vnic_rq.h          | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_rss.h         | 14 +------------
 drivers/net/ethernet/cisco/enic/vnic_stats.h       | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_vic.c         | 19 ++---------------
 drivers/net/ethernet/cisco/enic/vnic_vic.h         | 19 ++---------------
 drivers/net/ethernet/cisco/enic/vnic_wq.c          | 15 +-------------
 drivers/net/ethernet/cisco/enic/vnic_wq.h          | 15 +-------------
 drivers/net/ethernet/cisco/enic/wq_enet_desc.h     | 15 +-------------
 drivers/net/wireless/marvell/mwifiex/11ac.c        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/11ac.h        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/11h.c         | 14 +------------
 drivers/net/wireless/marvell/mwifiex/11n.c         | 14 +------------
 drivers/net/wireless/marvell/mwifiex/11n.h         | 14 +------------
 drivers/net/wireless/marvell/mwifiex/11n_aggr.c    | 14 +------------
 drivers/net/wireless/marvell/mwifiex/11n_aggr.h    | 14 +------------
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   | 14 +------------
 .../net/wireless/marvell/mwifiex/11n_rxreorder.h   | 14 +------------
 drivers/net/wireless/marvell/mwifiex/Makefile      | 13 +-----------
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    | 14 +------------
 drivers/net/wireless/marvell/mwifiex/cfg80211.h    | 14 +------------
 drivers/net/wireless/marvell/mwifiex/cfp.c         | 14 +------------
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      | 14 +------------
 drivers/net/wireless/marvell/mwifiex/debugfs.c     | 14 +------------
 drivers/net/wireless/marvell/mwifiex/decl.h        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/ethtool.c     | 14 +------------
 drivers/net/wireless/marvell/mwifiex/fw.h          | 14 +------------
 drivers/net/wireless/marvell/mwifiex/ie.c          | 14 +------------
 drivers/net/wireless/marvell/mwifiex/init.c        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/ioctl.h       | 14 +------------
 drivers/net/wireless/marvell/mwifiex/join.c        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/main.c        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/main.h        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/pcie.c        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/pcie.h        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/pcie_quirks.c | 18 ++--------------
 drivers/net/wireless/marvell/mwifiex/pcie_quirks.h | 18 ++--------------
 drivers/net/wireless/marvell/mwifiex/scan.c        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/sdio.c        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/sdio.h        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     | 14 +------------
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 14 +------------
 drivers/net/wireless/marvell/mwifiex/sta_event.c   | 14 +------------
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   | 14 +------------
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      | 14 +------------
 drivers/net/wireless/marvell/mwifiex/sta_tx.c      | 14 +------------
 drivers/net/wireless/marvell/mwifiex/txrx.c        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c     | 14 +------------
 drivers/net/wireless/marvell/mwifiex/uap_event.c   | 14 +------------
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c    | 14 +------------
 drivers/net/wireless/marvell/mwifiex/usb.c         | 14 +------------
 drivers/net/wireless/marvell/mwifiex/usb.h         | 14 +------------
 drivers/net/wireless/marvell/mwifiex/util.c        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/util.h        | 14 +------------
 drivers/net/wireless/marvell/mwifiex/wmm.c         | 14 +------------
 drivers/net/wireless/marvell/mwifiex/wmm.h         | 14 +------------
 drivers/nvmem/bcm-ocotp.c                          | 14 ++-----------
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c         | 14 ++-----------
 drivers/phy/broadcom/phy-bcm-ns2-pcie.c            | 14 ++-----------
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c          | 14 ++-----------
 drivers/phy/motorola/phy-cpcap-usb.c               | 10 +--------
 drivers/phy/ti/phy-dm816x-usb.c                    | 11 +---------
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c             | 14 ++-----------
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c           | 14 ++-----------
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c              | 10 +--------
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c             | 14 ++-----------
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c              | 10 +--------
 drivers/pinctrl/pinctrl-as3722.c                   | 15 +-------------
 drivers/pinctrl/pinctrl-palmas.c                   | 15 +-------------
 drivers/pinctrl/pinctrl-utils.c                    | 15 +-------------
 drivers/pinctrl/pinctrl-utils.h                    | 15 +-------------
 drivers/power/reset/brcm-kona-reset.c              | 14 ++-----------
 drivers/power/reset/brcmstb-reboot.c               | 14 ++-----------
 drivers/power/supply/cpcap-battery.c               | 10 +--------
 drivers/ptp/ptp_dte.c                              | 14 ++-----------
 drivers/pwm/pwm-bcm-iproc.c                        | 14 ++-----------
 drivers/pwm/pwm-bcm-kona.c                         | 14 ++-----------
 drivers/regulator/cpcap-regulator.c                | 10 +--------
 drivers/regulator/isl6271a-regulator.c             | 10 +--------
 drivers/regulator/lp873x-regulator.c               | 10 +--------
 drivers/regulator/max8973-regulator.c              | 15 +-------------
 drivers/regulator/ti-abb-regulator.c               | 10 +--------
 drivers/regulator/tps51632-regulator.c             | 15 +-------------
 drivers/regulator/tps62360-regulator.c             | 15 +-------------
 drivers/regulator/tps65023-regulator.c             | 10 +--------
 drivers/regulator/tps6507x-regulator.c             | 10 +--------
 drivers/regulator/tps65086-regulator.c             | 10 +--------
 drivers/regulator/tps65217-regulator.c             | 10 +--------
 drivers/regulator/tps65218-regulator.c             | 10 +--------
 drivers/regulator/tps65912-regulator.c             | 10 +--------
 drivers/reset/reset-ti-sci.c                       | 10 +--------
 drivers/reset/reset-ti-syscon.c                    | 10 +--------
 drivers/scsi/fnic/cq_desc.h                        | 14 +------------
 drivers/scsi/fnic/cq_enet_desc.h                   | 14 +------------
 drivers/scsi/fnic/cq_exch_desc.h                   | 14 +------------
 drivers/scsi/fnic/fcpio.h                          | 14 +------------
 drivers/scsi/fnic/fnic.h                           | 14 +------------
 drivers/scsi/fnic/fnic_attrs.c                     | 14 +------------
 drivers/scsi/fnic/fnic_debugfs.c                   | 18 ++--------------
 drivers/scsi/fnic/fnic_fcs.c                       | 14 +------------
 drivers/scsi/fnic/fnic_fip.h                       | 14 +------------
 drivers/scsi/fnic/fnic_io.h                        | 14 +------------
 drivers/scsi/fnic/fnic_isr.c                       | 15 +-------------
 drivers/scsi/fnic/fnic_main.c                      | 15 +-------------
 drivers/scsi/fnic/fnic_res.c                       | 14 +------------
 drivers/scsi/fnic/fnic_res.h                       | 14 +------------
 drivers/scsi/fnic/fnic_scsi.c                      | 14 +------------
 drivers/scsi/fnic/fnic_stats.h                     | 18 ++--------------
 drivers/scsi/fnic/fnic_trace.c                     | 18 ++--------------
 drivers/scsi/fnic/fnic_trace.h                     | 18 ++--------------
 drivers/scsi/fnic/rq_enet_desc.h                   | 14 +------------
 drivers/scsi/fnic/vnic_cq.c                        | 14 +------------
 drivers/scsi/fnic/vnic_cq.h                        | 14 +------------
 drivers/scsi/fnic/vnic_cq_copy.h                   | 14 +------------
 drivers/scsi/fnic/vnic_dev.c                       | 14 +------------
 drivers/scsi/fnic/vnic_dev.h                       | 14 +------------
 drivers/scsi/fnic/vnic_devcmd.h                    | 14 +------------
 drivers/scsi/fnic/vnic_intr.c                      | 14 +------------
 drivers/scsi/fnic/vnic_intr.h                      | 14 +------------
 drivers/scsi/fnic/vnic_nic.h                       | 14 +------------
 drivers/scsi/fnic/vnic_resource.h                  | 14 +------------
 drivers/scsi/fnic/vnic_rq.c                        | 15 +-------------
 drivers/scsi/fnic/vnic_rq.h                        | 14 +------------
 drivers/scsi/fnic/vnic_scsi.h                      | 14 +------------
 drivers/scsi/fnic/vnic_stats.h                     | 14 +------------
 drivers/scsi/fnic/vnic_wq.c                        | 14 +------------
 drivers/scsi/fnic/vnic_wq.h                        | 14 +------------
 drivers/scsi/fnic/vnic_wq_copy.c                   | 15 +-------------
 drivers/scsi/fnic/vnic_wq_copy.h                   | 14 +------------
 drivers/scsi/fnic/wq_enet_desc.h                   | 14 +------------
 drivers/scsi/snic/cq_desc.h                        | 18 ++--------------
 drivers/scsi/snic/cq_enet_desc.h                   | 18 ++--------------
 drivers/scsi/snic/snic.h                           | 18 ++--------------
 drivers/scsi/snic/snic_attrs.c                     | 18 ++--------------
 drivers/scsi/snic/snic_ctl.c                       | 18 ++--------------
 drivers/scsi/snic/snic_debugfs.c                   | 18 ++--------------
 drivers/scsi/snic/snic_disc.c                      | 18 ++--------------
 drivers/scsi/snic/snic_disc.h                      | 18 ++--------------
 drivers/scsi/snic/snic_fwint.h                     | 18 ++--------------
 drivers/scsi/snic/snic_io.c                        | 18 ++--------------
 drivers/scsi/snic/snic_io.h                        | 18 ++--------------
 drivers/scsi/snic/snic_isr.c                       | 18 ++--------------
 drivers/scsi/snic/snic_main.c                      | 18 ++--------------
 drivers/scsi/snic/snic_res.c                       | 18 ++--------------
 drivers/scsi/snic/snic_res.h                       | 18 ++--------------
 drivers/scsi/snic/snic_scsi.c                      | 18 ++--------------
 drivers/scsi/snic/snic_stats.h                     | 18 ++--------------
 drivers/scsi/snic/snic_trc.c                       | 18 ++--------------
 drivers/scsi/snic/snic_trc.h                       | 18 ++--------------
 drivers/scsi/snic/vnic_cq.c                        | 18 ++--------------
 drivers/scsi/snic/vnic_cq.h                        | 18 ++--------------
 drivers/scsi/snic/vnic_cq_fw.h                     | 18 ++--------------
 drivers/scsi/snic/vnic_dev.c                       | 18 ++--------------
 drivers/scsi/snic/vnic_dev.h                       | 18 ++--------------
 drivers/scsi/snic/vnic_devcmd.h                    | 18 ++--------------
 drivers/scsi/snic/vnic_intr.c                      | 18 ++--------------
 drivers/scsi/snic/vnic_intr.h                      | 18 ++--------------
 drivers/scsi/snic/vnic_resource.h                  | 18 ++--------------
 drivers/scsi/snic/vnic_snic.h                      | 18 ++--------------
 drivers/scsi/snic/vnic_stats.h                     | 18 ++--------------
 drivers/scsi/snic/vnic_wq.c                        | 18 ++--------------
 drivers/scsi/snic/vnic_wq.h                        | 18 ++--------------
 drivers/scsi/snic/wq_enet_desc.h                   | 18 ++--------------
 drivers/soc/ti/knav_dma.c                          | 10 +--------
 drivers/thermal/hisi_thermal.c                     | 10 +--------
 drivers/uio/uio_pruss.c                            | 10 +--------
 drivers/video/backlight/tps65217_bl.c              | 10 +--------
 include/dt-bindings/clock/bcm21664.h               | 10 +--------
 include/dt-bindings/clock/bcm281xx.h               | 10 +--------
 include/dt-bindings/clock/ti-dra7-atl.h            | 10 +--------
 include/dt-bindings/pinctrl/hisi.h                 | 10 +--------
 include/dt-bindings/pinctrl/keystone.h             | 10 +--------
 include/dt-bindings/power/mt6797-power.h           |  9 +-------
 include/linux/clk/ti.h                             | 10 +--------
 include/linux/input/elan-i2c-ids.h                 |  5 +----
 include/linux/mfd/lp873x.h                         | 10 +--------
 include/linux/mfd/tps65086.h                       | 10 +--------
 include/linux/mfd/tps65217.h                       | 10 +--------
 include/linux/mfd/tps65218.h                       | 10 +--------
 include/linux/mfd/tps65912.h                       | 10 +--------
 include/linux/platform_data/davinci_asp.h          | 10 +--------
 include/linux/platform_data/gpio-davinci.h         | 10 +--------
 include/linux/platform_data/uio_dmem_genirq.h      | 10 +--------
 include/linux/platform_data/uio_pruss.h            | 10 +--------
 include/linux/platform_data/usb-omap.h             | 16 +--------------
 include/linux/pm_wakeirq.h                         | 14 ++-----------
 include/linux/reset/bcm63xx_pmb.h                  | 10 +--------
 include/linux/soc/ti/knav_dma.h                    | 10 +--------
 include/linux/soc/ti/knav_qmss.h                   | 10 +--------
 include/linux/soc/ti/ti-msgmgr.h                   | 10 +--------
 include/linux/sram.h                               | 14 ++-----------
 include/linux/sunrpc/bc_xprt.h                     | 17 +--------------
 include/linux/ti-emif-sram.h                       | 10 +--------
 include/linux/usb/audio-v2.h                       |  3 ---
 include/linux/usb/audio.h                          |  3 ---
 include/linux/usb/c67x00.h                         | 15 --------------
 include/linux/usb/cdc-wdm.h                        |  4 ----
 include/linux/usb/cdc.h                            |  4 ----
 include/linux/usb/composite.h                      | 14 -------------
 include/linux/usb/ehci_def.h                       | 14 -------------
 include/linux/usb/ehci_pdriver.h                   | 14 -------------
 include/linux/usb/g_hid.h                          | 14 -------------
 include/linux/usb/gadget.h                         |  2 --
 include/linux/usb/hcd.h                            | 14 -------------
 include/linux/usb/input.h                          |  4 ----
 include/linux/usb/isp1301.h                        | 10 ---------
 include/linux/usb/m66592.h                         | 14 -------------
 include/linux/usb/musb-ux500.h                     | 10 ---------
 include/linux/usb/net2280.h                        | 14 -------------
 include/linux/usb/of.h                             |  2 --
 include/linux/usb/ohci_pdriver.h                   | 14 -------------
 include/linux/usb/otg-fsm.h                        | 17 ++-------------
 include/linux/usb/phy_companion.h                  | 10 ---------
 include/linux/usb/r8a66597.h                       | 14 -------------
 include/linux/usb/rndis_host.h                     | 14 -------------
 include/linux/usb/serial.h                         |  5 -----
 include/linux/usb/storage.h                        |  2 --
 include/linux/usb/tegra_usb_phy.h                  | 10 ---------
 include/linux/usb/ulpi.h                           |  4 ----
 include/linux/usb/usb338x.h                        | 11 ----------
 include/linux/usb/usbnet.h                         | 14 -------------
 include/linux/usb/xhci-dbgp.h                      |  4 ----
 include/linux/wkup_m3_ipc.h                        | 10 +--------
 include/media/i2c/adv7343.h                        | 10 +--------
 include/media/i2c/adv7393.h                        | 10 +--------
 include/media/i2c/ov2659.h                         | 14 +------------
 include/uapi/linux/netfilter/xt_IDLETIMER.h        | 17 +--------------
 net/hsr/hsr_debugfs.c                              | 10 +--------
 net/sunrpc/backchannel_rqst.c                      | 16 +--------------
 net/sunrpc/sunrpc.h                                | 16 +--------------
 samples/v4l/v4l2-pci-skeleton.c                    | 14 +------------
 scripts/gcc-plugins/latent_entropy_plugin.c        |  2 +-
 scripts/gcc-plugins/stackleak_plugin.c             |  2 +-
 scripts/gcc-plugins/structleak_plugin.c            |  2 +-
 sound/soc/bcm/cygnus-pcm.c                         | 14 ++-----------
 sound/soc/bcm/cygnus-ssp.c                         | 14 ++-----------
 sound/soc/bcm/cygnus-ssp.h                         | 14 ++-----------
 tools/power/cpupower/debug/i386/dump_psb.c         |  6 ++----
 617 files changed, 732 insertions(+), 5619 deletions(-)
