Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8A5AD742
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiIEQVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiIEQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:21:30 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA4B5AC61
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:21:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 95491580230;
        Mon,  5 Sep 2022 12:21:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 05 Sep 2022 12:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1662394884; x=1662398484; bh=jPjDs/nQydsuWc7+zdDVn5uW0GkDc/+2RNe
        DCYWA06w=; b=Qphw9wDlxkhAQXBemSjB/3oLF2NRdmS87Z3z8ajxxPS7ltzSMXB
        xE+1XGjrVNuU+L5o6S1jcPJG2o7uUKqygfyuL3cx6AIPsWWXN2pKGW6ZN4YoDjM3
        OxQsL0oWBE//I2gflWKOuIdIUml1q3E/D53rEEw4ST58M2gKIMy5vF819+7M0raq
        76K6KMQ4bcB4G360WMqP158xQyM08FSTGRXcE+wn9sCG6nauK4Z4M09wNgOqnI78
        ESMjuRuTXVOgwI5x+PICcsEtJ4NsP2WDbe242GG/jgcuNs2DtC9eLmECvuWcnVVA
        bejYDgw4SfFSsn/FmHSxYbaveV3XKTC2anw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1662394884; x=
        1662398484; bh=jPjDs/nQydsuWc7+zdDVn5uW0GkDc/+2RNeDCYWA06w=; b=w
        lxB6DbFg30LASx6TCeUQHhDHKY7WJW50xfqFU4ew63URpbGOzsiZt8UuLD8AnB5J
        baOy72lhYI/5Cc+gkavNl7zxPBBVYl4Pw5HkPqEvW4UGoBVfFQZ8TgV0J6Fc84V+
        DVfWTBck645CARtiDfFSRyMRk8LwRgdZwSs+77JxwNO3MuGgx2SfggwkGFKD80wo
        gYnE+JpHBQN4eTZXkSC6OcBJJ0cNtOY8WXhX7t2DdC5YDSa6cxC7PDQ3KjD077bN
        7kXefintstc3jwEDlJqgtRFHV0CyuREM3ZEEkUrgIhCGIsVRRvyL4quz/j/CqBrw
        4+2TmWOMapQs7g541G7og==
X-ME-Sender: <xms:BCIWY6UHRoBfNn1vXUPn2TVjaQDPa7-vC3B4ynFdGil4Qo4Qwiymgw>
    <xme:BCIWY2mbwfJ82POusnyjPNSZbiZrWNQwoTDrenE8Ddh4SEw-T8UtNew2nAm-u0W8j
    xF5eV535lCHOm_htKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeliedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeelteelgefhvdejuefgieetkeehteevgfdvkeeiffdujefghedugeefjeeutdfg
    geenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlihhnrghrohdrohhrghdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:BCIWY-bZO5gKIi_jfsabVCY5CucPaIczao_Ef-TYDGZ2w3X25LBZDw>
    <xmx:BCIWYxXXKzBm_Er6Ri0ND399lAaKSDdye-3WsNF-GawfGeFxhjS5IA>
    <xmx:BCIWY0k2h5-RyIlsWgwVqLd25emtMcE0i7rGkAfpbVSrME1nd85UKw>
    <xmx:BCIWYwvQnKwlXo_GgIxioamiWpqEs1Y6zbFMjcqQz5wHpgs6VhN9FA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0169EB60083; Mon,  5 Sep 2022 12:21:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <d518e7f7-ea7a-4bff-aa8c-7786bed62d69@www.fastmail.com>
Date:   Mon, 05 Sep 2022 18:21:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes for 6.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.0-rc4

for you to fetch changes up to 12f09234bde51810b3f7412b2b5c84af4c07cfb1:

  Merge tag 'renesas-fixes-for-v6.0-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes (2022-09-02 12:05:28 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.0

These are the expected fixes for the SoC tree. I have let the
patches pile up a little too long, so this is bigger than I
would have liked.

 - Minor build fixes for Broadcom STB and NXP i.MX8M SoCs as well\
   as TEE firmware

 - Updates to the MAINTAINERS file for the PolarFire SoC

 - Minor DT fixes for Renesas White Hawk and Arm Versatile and
   Juno platforms

 - A fix for a missing dependnecy in the NXP DPIO driver

 - Broadcom BCA fixes to the newly added devicetree files

 - Multiple fixes for Microchip AT91 based SoCs, dealing with
   self-refresh timings and regulator settings in DT

 - Several DT fixes for NXP i.MX platforms, dealing with incorrect
   GPIO settings, extraneous nodes, and a wrong clock setting.

----------------------------------------------------------------
Alexander Stein (1):
      arm64: dts: imx8mq-tqma8mq: Remove superfluous interrupt-names

Andrejs Cainikovs (2):
      arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
      arm64: dts: imx8mm-verdin: use level interrupt for mcp251xfd

Arnd Bergmann (9):
      Merge branch 'polarfire/fixes' into arm/fixes
      Merge tag 'imx-fixes-6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'versatile-dts-v6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator into arm/fixes
      Merge tag 'tee-fix-for-v6.0' of https://git.linaro.org/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'juno-fixes-6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'arm-soc/for-6.0/devicetree' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'arm-soc/for-6.0/drivers-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'at91-fixes-6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes
      Merge tag 'renesas-fixes-for-v6.0-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes

Claudiu Beznea (8):
      ARM: configs: at91: remove CONFIG_MICROCHIP_PIT64B
      ARM: at91: pm: fix self-refresh for sama7g5
      ARM: at91: pm: fix DDR recalibration when resuming from backup and self-refresh
      ARM: dts: at91: sama5d27_wlsom1: specify proper regulator output ranges
      ARM: dts: at91: sama5d2_icp: specify proper regulator output ranges
      ARM: dts: at91: sama7g5ek: specify proper regulator output ranges
      ARM: dts: at91: sama5d27_wlsom1: don't keep ldo2 enabled all the time
      ARM: dts: at91: sama5d2_icp: don't keep vdd_other enabled all the time

Conor Dooley (2):
      MAINTAINERS: add PolarFire SoC dt bindings
      MAINTAINERS: add the Polarfire SoC's i2c driver

David Jander (1):
      ARM: dts: imx6qdl-vicut1.dtsi: Fix node name backlight_led

Geert Uytterhoeven (1):
      arm64: dts: renesas: r8a779g0: Fix HSCIF0 interrupt number

Jassi Brar (1):
      arm64: dts: juno: Add missing MHU secure-irq

Jens Wiklander (1):
      tee: fix compiler warning in tee_shm_register()

Julia Lawall (1):
      ARM: ixp4xx: fix typos in comments

Kuldeep Singh (3):
      ARM: dts: integratorap: Update spi node properties
      ARM: dts: realview: Update spi clock-names property
      ARM: dts: versatile: Update spi clock-names property

Liang He (1):
      soc: brcmstb: pm-arm: Fix refcount leak and __iomem leak bugs

Marcel Ziswiler (2):
      arm64: dts: freescale: verdin-imx8mm: fix atmel_mxt_ts reset polarity
      arm64: dts: freescale: verdin-imx8mp: fix atmel_mxt_ts reset polarity

Marco Felsch (3):
      Revert "soc: imx: imx8m-blk-ctrl: set power device name"
      ARM: dts: imx6qdl-kontron-samx6i: remove duplicated node
      ARM: dts: imx6qdl-kontron-samx6i: fix spi-flash compatible

Marek Vasut (3):
      arm64: dts: imx8mp: Adjust ECSPI1 pinmux on i.MX8M Plus DHCOM
      soc: imx: gpcv2: Assert reset before ungating clock
      arm64: dts: imx8mp: Fix I2C5 GPIO assignment on i.MX8M Plus DHCOM

Mathew McBride (1):
      soc: fsl: select FSL_GUTS driver for DPIO

Peng Fan (1):
      arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings

Philippe Schenker (1):
      arm64: dts: verdin-imx8mm: add otg2 pd to usbphy

Rob Herring (1):
      arm64: dts: arm: juno: Remove legacy Coresight 'slave-mode' property

Tim Harvey (1):
      arm64: dts: imx8mm-venice-gw7901: fix port/phy validation

Vladimir Oltean (1):
      arm64: dts: ls1028a-qds-65bb: don't use in-band autoneg for 2500base-x

William Zhang (9):
      ARM: dts: bcmbca: bcm63178: fix timer node cpu mask flag
      ARM: dts: bcmbca: bcm63178: clean up psci node
      ARM: dts: bcmbca: bcm63178: fix interrupt controller node
      ARM: dts: bcmbca: bcm63178: cosmetic change
      ARM: dts: bcmbca: bcm6846: fix timer node cpu mask flag
      ARM: dts: bcmbca: bcm6846: clean up psci node
      ARM: dts: bcmbca: bcm6846: fix interrupt controller node
      ARM: dts: bcmbca: bcm6878: fix timer node cpu mask flag
      ARM: dts: bcmbca: bcm6878: cosmetic change

 MAINTAINERS                                        | 10 +++++
 arch/arm/boot/dts/arm-realview-eb.dtsi             |  2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts          |  2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts          |  2 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi            |  2 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi        | 21 +++++----
 arch/arm/boot/dts/at91-sama5d2_icp.dts             | 21 +++++----
 arch/arm/boot/dts/at91-sama7g5ek.dts               | 18 ++++----
 arch/arm/boot/dts/bcm63178.dtsi                    | 20 +++++----
 arch/arm/boot/dts/bcm6846.dtsi                     | 18 ++++----
 arch/arm/boot/dts/bcm6878.dtsi                     |  9 ++--
 arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi      | 12 +-----
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi              |  2 +-
 arch/arm/boot/dts/integratorap-im-pd1.dts          |  4 +-
 arch/arm/boot/dts/versatile-ab.dts                 |  2 +-
 arch/arm/configs/at91_dt_defconfig                 |  1 -
 arch/arm/configs/sama7_defconfig                   |  1 -
 arch/arm/mach-at91/pm.c                            | 36 ++++++++++++++--
 arch/arm/mach-at91/pm_suspend.S                    | 24 ++++++++---
 arch/arm/mach-ixp4xx/ixp4xx-of.c                   |  2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  3 +-
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi          |  2 -
 .../boot/dts/freescale/fsl-ls1028a-qds-65bb.dts    |  1 -
 .../boot/dts/freescale/imx8mm-venice-gw7901.dts    |  4 ++
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi   | 11 ++---
 .../arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi | 14 +++---
 .../boot/dts/freescale/imx8mp-venice-gw74xx.dts    |  8 ++--
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi   |  4 +-
 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi  |  1 -
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi          |  2 +-
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                | 50 +++++++++++++++++-----
 drivers/soc/fsl/Kconfig                            |  1 +
 drivers/soc/imx/gpcv2.c                            |  5 ++-
 drivers/soc/imx/imx8m-blk-ctrl.c                   |  1 -
 drivers/tee/tee_shm.c                              |  1 +
 include/soc/at91/sama7-ddr.h                       |  8 ++++
 36 files changed, 202 insertions(+), 123 deletions(-)
