Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD958CE2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbiHHTAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiHHTAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:00:00 -0400
X-Greylist: delayed 468 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 11:59:58 PDT
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54C261834C;
        Mon,  8 Aug 2022 11:59:58 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 3EA5C409F8; Mon,  8 Aug 2022 19:12:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 3EA5C409F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1659978736;
        bh=KCx0IvLfZfun9tgRq6MimD6dvHCdYmSX9rsZgPoZ8JQ=;
        h=Date:From:To:Cc:Subject:From;
        b=dP+GnXWlOOorguuSoB2v5TwJXPk5G8hW1h4X0wne3NwexQB61mY9BdVvPv8GB4txW
         HPPNQahRZnlQRD6jmaHYXK9nC7Tj7y6qlaOQzeEQzKQ8cTpWiqQ0Eha9Ae/fmzuuxS
         mYnxTbp6tcpKFYJcNkfRVneKqw433skwR4pkM+R0=
Date:   Mon, 8 Aug 2022 19:12:16 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Abel Vesa <abel.vesa@nxp.com>,
        Bing Fan <tombinfan@tencent.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Jean Delvare <jdelvare@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Luo Xueqin <luoxueqin@kylinos.cn>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Sander Vanheule <sander@svanheule.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        William Dean <williamsukatube@gmail.com>
Subject: [GIT PULL REQUEST] watchdog - v5.20 release cycle.
Message-ID: <20220808171216.GA19810@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Please pull following watchdog changes for the v5.20 release cycle.

This series contains:
* add RTL9310 support
* sp805_wdt: add arm cmsdk apb wdt support
* Remove #ifdef guards for PM related functions for several watchdog device drivers
* pm8916_wdt reboot improvements
* Several other fixes and improvements

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.20-rc1

for you to fetch changes up to 2d27e52841092e5831dd41f313028c668d816eb0:

  watchdog: armada_37xx_wdt: check the return value of devm_ioremap() in armada_37xx_wdt_probe() (2022-07-23 14:26:42 +0200)

----------------------------------------------------------------
linux-watchdog 5.20-rc1 tag

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: watchdog: Add fsl,scu-wdt yaml file

Bing Fan (1):
      watchdog: sp805_wdt: add arm cmsdk apb wdt support

Jason Wang (2):
      watchdog: Fix comment typo
      watchdog: dw_wdt: Fix comment typo

Jean Delvare (1):
      watchdog: sp5100_tco: Fix a memory leak of EFCH MMIO resource

Jiasheng Jiang (1):
      watchdog: f71808e_wdt: Add check for platform_driver_register

Luca Ceresoli (1):
      watchdog: max77620: update Luca Ceresoli's e-mail address

Luo Xueqin (1):
      watchdog:Fix typo in comment

Paul Cercueil (8):
      watchdog: bcm7038_wdt: Remove #ifdef guards for PM related functions
      watchdog: dw_wdt: Remove #ifdef guards for PM related functions
      watchdog: mtk_wdt: Remove #ifdef guards for PM related functions
      watchdog: s3c2410_wdt: Remove #ifdef guards for PM related functions
      watchdog: sama5d4_wdt: Remove #ifdef guards for PM related functions
      watchdog: st_lpc_wdt: Remove #ifdef guards for PM related functions
      watchdog: tegra_wdt: Remove #ifdef guards for PM related functions
      watchdog: wdat_wdt: Remove #ifdef guards for PM related functions

Rob Herring (1):
      dt-bindings: watchdog: faraday: Fix typo in example 'timeout-sec' property

Rohit Agarwal (1):
      dt-bindings: watchdog: Add binding for Qcom SDX65

Sander Vanheule (2):
      dt-bindings: watchdog: realtek,otto-wdt: add RTL9310
      watchdog: realtek-otto: add RTL9310 support

Stephan Gerhold (3):
      watchdog: pm8916_wdt: Avoid read of write-only PET register
      watchdog: pm8916_wdt: Report reboot reason
      watchdog: pm8916_wdt: Handle watchdog enabled by bootloader

William Dean (1):
      watchdog: armada_37xx_wdt: check the return value of devm_ioremap() in armada_37xx_wdt_probe()

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 15 --------
 .../bindings/watchdog/faraday,ftwdt010.yaml        |  2 +-
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |  1 +
 .../bindings/watchdog/realtek,otto-wdt.yaml        |  1 +
 drivers/watchdog/armada_37xx_wdt.c                 |  2 ++
 drivers/watchdog/bcm7038_wdt.c                     |  8 ++---
 drivers/watchdog/booke_wdt.c                       |  2 +-
 drivers/watchdog/dw_wdt.c                          |  8 ++---
 drivers/watchdog/f71808e_wdt.c                     |  4 ++-
 drivers/watchdog/max77620_wdt.c                    |  4 +--
 drivers/watchdog/mtk_wdt.c                         | 10 ++----
 drivers/watchdog/pc87413_wdt.c                     |  2 +-
 drivers/watchdog/pm8916_wdt.c                      | 41 +++++++++++++++++++---
 drivers/watchdog/realtek_otto_wdt.c                |  1 +
 drivers/watchdog/s3c2410_wdt.c                     |  9 ++---
 drivers/watchdog/sama5d4_wdt.c                     |  8 ++---
 drivers/watchdog/sp5100_tco.c                      |  1 +
 drivers/watchdog/sp805_wdt.c                       |  5 +++
 drivers/watchdog/st_lpc_wdt.c                      |  9 ++---
 drivers/watchdog/tegra_wdt.c                       | 14 +++-----
 drivers/watchdog/wdat_wdt.c                        |  7 ++--
 21 files changed, 81 insertions(+), 73 deletions(-)
----------------------------------------------------------------

Kind regards,
Wim.

