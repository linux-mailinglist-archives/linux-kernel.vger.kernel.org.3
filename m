Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF153ACD7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiFAScd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiFAScb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:32:31 -0400
X-Greylist: delayed 507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 11:32:28 PDT
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5E1A3E0C9;
        Wed,  1 Jun 2022 11:32:27 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id D6328409E9; Wed,  1 Jun 2022 18:47:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org D6328409E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1654102072;
        bh=1vj6WJ6ARQ0Bom7Std6lVrJRnQykJGc1MrnHVqM+yFA=;
        h=Date:From:To:Cc:Subject:From;
        b=pa7tCHB5OBLid/FC29WciT4Cn3OCbTNUa/LAyZ3ApITy7+xE5iVGQZpHDBLJEUurB
         QkHdpsRqq9qdIm6ToL9jQokvUEff6zfGqbHEnITNMdFS9fqntkSEHvrsPQSIdBaBKL
         7Z+e/91u6ZcWVap3T3FrwbaymuOWmsWpKdpUwdvM=
Date:   Wed, 1 Jun 2022 18:47:51 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrej Picej <andrej.picej@norik.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        David Heidelberg <david@ixit.cz>,
        Eliav Farber <farbere@amazon.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>,
        Miaoqian Lin <linmq006@gmail.com>, Peng Fan <peng.fan@nxp.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Primoz Fiser <primoz.fiser@norik.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Runyang Chen <runyang.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Xiantao Hu <xt.hu@cqplus1.com>
Subject: [GIT PULL REQUEST] watchdog - v5.19 Merge window
Message-ID: <20220601164751.GA15198@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull the watchdog changes for the v5.19 release cycle.

This series contains:
* Add MediaTek MT8186 support
* Add Mediatek MT7986 reset-controller support
* Add i.MX93 support
* Add watchdog driver for Sunplus SP7021
* Add SC8180X and SC8280XP compatibles
* Add Renesas RZ/N1 Watchdog driver and support for RZ/N1
* rzg2l_wdt improvements and fixes
* Several other improvements and fixes

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.19-rc1

for you to fetch changes up to 5d24df3d690809952528e7a19a43d84bc5b99d44:

  watchdog: ts4800_wdt: Fix refcount leak in ts4800_wdt_probe (2022-05-21 10:09:31 +0200)

----------------------------------------------------------------
linux-watchdog 5.19-rc1 tag

----------------------------------------------------------------
Andre Przywara (2):
      dt-bindings: watchdog: sunxi: fix F1C100s compatible
      dt-bindings: watchdog: sunxi: clarify clock support

Andrej Picej (1):
      dt-bindings: watchdog: da9062: add watchdog timeout mode

Biju Das (8):
      watchdog: rzg2l_wdt: Fix 32bit overflow issue
      watchdog: rzg2l_wdt: Fix Runtime PM usage
      watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'
      watchdog: rzg2l_wdt: Fix reset control imbalance
      watchdog: rzg2l_wdt: Add error check for reset_control_deassert
      watchdog: rzg2l_wdt: Use force reset for WDT reset
      watchdog: rzg2l_wdt: Add set_timeout callback
      dt-bindings: watchdog: renesas,wdt: Document RZ/G2UL SoC

Bjorn Andersson (1):
      dt-bindings: watchdog: Add SC8180X and SC8280XP compatibles

Corentin Labbe (1):
      dt-bindings: watchdog: convert faraday,ftwdt010 to yaml

David Heidelberg (1):
      dt-bindings: watchdog: improve QCOM compatible parsing for modern chips

Eliav Farber (1):
      watchdog: sp805: disable watchdog on remove

Geert Uytterhoeven (1):
      dt-bindings: watchdog: renesas,wdt: R-Car V3U is R-Car Gen4

Jan Kiszka (1):
      watchdog: rti_wdt: Fix calculation and evaluation of preset heartbeat

Jean-Jacques Hiblot (1):
      dt-bindings: watchdog: renesas,wdt: Add support for RZ/N1

Kunihiko Hayashi (1):
      dt-bindings: watchdog: uniphier: Use unevaluatedProperties

Lad Prabhakar (1):
      dt-bindings: watchdog: renesas,wdt: Document RZ/V2L SoC

Liu Xinpeng (4):
      watchdog: iTCO_wdt: Using existing macro define covers more scenarios
      watchdog: wdat_wdt: Using the existing function to check parameter timeout
      watchdog: wdat_wdt: Stop watchdog when rebooting the system
      watchdog: wdat_wdt: Stop watchdog when uninstalling module

Miaoqian Lin (2):
      watchdog: rti-wdt: Fix pm_runtime_get_sync() error checking
      watchdog: ts4800_wdt: Fix refcount leak in ts4800_wdt_probe

Peng Fan (1):
      dt-bindings: watchdog: imx7ulp-wdt: Add imx93 compatible string

Phil Edworthy (1):
      watchdog: Add Renesas RZ/N1 Watchdog driver

Primoz Fiser (2):
      dt-bindings: mfd: da9063: watchdog: add suspend disable option
      watchdog: da9063: optionally disable watchdog during suspend

Rafał Miłecki (1):
      watchdog: bcm7038_wdt: Support BCM6345 compatible string

Rex-BC Chen (1):
      dt-bindings: watchdog: Add compatible for MediaTek MT8186

Runyang Chen (2):
      dt-bindings: reset: mt8186: add reset-controller header file
      watchdog: mediatek: mt8186: add wdt support

Sam Shih (2):
      watchdog: mtk_wdt: mt7986: Add toprgu reset controller support
      dt-bindings: reset: mt7986: Add reset-controller header file

Xiantao Hu (2):
      dt-bindings: watchdog: Add watchdog yaml file for Sunplus SP7021
      watchdog: Add watchdog driver for Sunplus SP7021

 Documentation/devicetree/bindings/mfd/da9063.txt   |   9 +-
 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml |  24 +--
 .../devicetree/bindings/watchdog/da9062-wdt.txt    |   6 +
 .../bindings/watchdog/faraday,ftwdt010.txt         |  22 ---
 .../bindings/watchdog/faraday,ftwdt010.yaml        |  67 +++++++
 .../bindings/watchdog/fsl-imx7ulp-wdt.yaml         |   1 +
 .../devicetree/bindings/watchdog/mtk-wdt.txt       |   1 +
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |  39 ++--
 .../devicetree/bindings/watchdog/renesas,wdt.yaml  |  12 +-
 .../bindings/watchdog/socionext,uniphier-wdt.yaml  |   2 +-
 .../bindings/watchdog/sunplus,sp7021-wdt.yaml      |  47 +++++
 MAINTAINERS                                        |   7 +
 drivers/watchdog/Kconfig                           |  19 ++
 drivers/watchdog/Makefile                          |   2 +
 drivers/watchdog/bcm7038_wdt.c                     |   1 +
 drivers/watchdog/da9063_wdt.c                      |  36 ++++
 drivers/watchdog/iTCO_wdt.c                        |  20 +-
 drivers/watchdog/mtk_wdt.c                         |  12 ++
 drivers/watchdog/rti_wdt.c                         |  10 +-
 drivers/watchdog/rzg2l_wdt.c                       |  83 ++++----
 drivers/watchdog/rzn1_wdt.c                        | 203 +++++++++++++++++++
 drivers/watchdog/sp805_wdt.c                       |   1 +
 drivers/watchdog/sunplus_wdt.c                     | 220 +++++++++++++++++++++
 drivers/watchdog/ts4800_wdt.c                      |   5 +-
 drivers/watchdog/wdat_wdt.c                        |   6 +-
 include/dt-bindings/reset/mt7986-resets.h          |  55 ++++++
 include/dt-bindings/reset/mt8186-resets.h          |  36 ++++
 27 files changed, 831 insertions(+), 115 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
 create mode 100644 drivers/watchdog/rzn1_wdt.c
 create mode 100644 drivers/watchdog/sunplus_wdt.c
 create mode 100644 include/dt-bindings/reset/mt7986-resets.h
 create mode 100644 include/dt-bindings/reset/mt8186-resets.h
----------------------------------------------------------------

Kind regards,
Wim.

