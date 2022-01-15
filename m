Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A4448F660
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 11:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiAOKX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 05:23:57 -0500
Received: from www.linux-watchdog.org ([185.87.125.42]:45348 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiAOKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 05:23:56 -0500
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id B1329409DF; Sat, 15 Jan 2022 09:55:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org B1329409DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1642236922;
        bh=EhF7XCT8OITSpJzSm8nvd+ttt5yypWkqJKw0oK/bOcc=;
        h=Date:From:To:Cc:Subject:From;
        b=BZ1d5Z3Tqyg3Nq6VLxpLIuDu0D6fKmdveU5QcClkTQhRjvvtFnob4pnyfY1TjRF1u
         0jm08JSN2xxXtlYaDjd5rljlVU/y/THQMauq+Hw5T2ctwDZonvYaZx7uZBiCs3wCQe
         Ge3pGUcZ1+6NKCQO1FdO/tdPeIt7mEO2ixuoB350=
Date:   Sat, 15 Jan 2022 09:55:22 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        AaeonIot <sophiehu@aaeon.com.tw>,
        Andrej Picej <andrej.picej@norik.com>,
        Artem Lapkin <email2tema@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Palmer <daniel@0x0f.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Luca Weiss <luca.weiss@fairphone.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Sander Vanheule <sander@svanheule.net>,
        Sven Peter <sven@svenpeter.dev>,
        Tzung-Bi Shih <tzungbi@google.com>, Yunus Bas <y.bas@phytec.de>
Subject: [GIT PULL REQUEST] watchdog - v5.17 Merge window
Message-ID: <20220115085522.GA30865@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v5.17 release cycle.

This series contains:
* Addition of the following new devices:
  - Watchdog Timer driver for RZ/G2L
  - Realtek Otto watchdog timer
  - Apple SoC watchdog driver
  - Fintek F81966
* Removal of BCM63XX_WDT after support for this SOC was added to BCM7038_WDT
* Improvements of the BCM7038_WDT and s3c2410_wdt code
* several other fixes and improvements

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2:

  Linux 5.16-rc7 (2021-12-26 13:17:17 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.17-rc1

for you to fetch changes up to ffd264bd152cbf88fcf5ced04d3d380c77020231:

  watchdog: msc313e: Check if the WDT was running at boot (2022-01-05 10:38:51 +0100)

----------------------------------------------------------------
linux-watchdog 5.17-rc1 tag

----------------------------------------------------------------
AaeonIot (1):
      watchdog: f71808e_wdt: Add F81966 support

Andrej Picej (1):
      watchdog: da9063: Add hard dependency on I2C

Artem Lapkin (1):
      watchdog: meson_gxbb_wdt: remove stop_on_reboot

Biju Das (2):
      dt-bindings: watchdog: renesas,wdt: Add support for RZ/G2L
      watchdog: Add Watchdog Timer driver for RZ/G2L

Changcheng Deng (1):
      watchdog: davinci: Use div64_ul instead of do_div

Daniel Palmer (1):
      watchdog: msc313e: Check if the WDT was running at boot

Florian Fainelli (6):
      dt-bindings: watchdog: Add BCM6345 compatible to BCM7038 binding
      watchdog: bcm7038_wdt: Support platform data configuration
      watchdog: Allow building BCM7038_WDT for BCM63XX
      watchdog: bcm7038_wdt: Add platform device id for bcm63xx-wdt
      MIPS: BCM63XX: Provide platform data to watchdog device
      watchdog: Remove BCM63XX_WDT

Jacky Bai (1):
      dt-bindings: watchdog: imx7ulp-wdt: Add imx8ulp compatible string

Kevin Hilman (1):
      watchdog: Kconfig: enable MTK watchdog

Lad Prabhakar (1):
      watchdog: s3c2410: Use platform_get_irq() to get the interrupt

Luca Ceresoli (1):
      watchdog: Kconfig: fix help text indentation

Luca Weiss (1):
      dt-bindings: watchdog: Add SM6350 and SM8250 compatible

Rafał Miłecki (1):
      dt-bindings: watchdog: convert Broadcom's WDT to the json-schema

Rob Herring (1):
      dt-bindings: watchdog: atmel: Add missing 'interrupts' property

Sam Protsenko (13):
      dt-bindings: watchdog: Require samsung,syscon-phandle for Exynos7
      dt-bindings: watchdog: Document Exynos850 watchdog bindings
      watchdog: s3c2410: Fail probe if can't find valid timeout
      watchdog: s3c2410: Let kernel kick watchdog
      watchdog: s3c2410: Make reset disable register optional
      watchdog: s3c2410: Extract disable and mask code into separate functions
      watchdog: s3c2410: Implement a way to invert mask reg value
      watchdog: s3c2410: Add support for WDT counter enable register
      watchdog: s3c2410: Cleanup PMU related code
      watchdog: s3c2410: Support separate source clock
      watchdog: s3c2410: Remove superfluous err label
      watchdog: s3c2410: Add Exynos850 support
      watchdog: s3c2410: Fix getting the optional clock

Sander Vanheule (2):
      dt-bindings: watchdog: Realtek Otto WDT binding
      watchdog: Add Realtek Otto watchdog timer

Sven Peter (1):
      watchdog: Add Apple SoC watchdog driver

Tzung-Bi Shih (1):
      watchdog: mtk_wdt: use platform_get_irq_optional

Yunus Bas (1):
      watchdog: da9063: use atomic safe i2c transfer in reset handler

 .../bindings/watchdog/atmel,sama5d4-wdt.yaml       |   3 +
 .../bindings/watchdog/brcm,bcm7038-wdt.txt         |  19 -
 .../bindings/watchdog/brcm,bcm7038-wdt.yaml        |  43 +++
 .../bindings/watchdog/fsl-imx7ulp-wdt.yaml         |   7 +-
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |   2 +
 .../bindings/watchdog/realtek,otto-wdt.yaml        |  91 +++++
 .../devicetree/bindings/watchdog/renesas,wdt.yaml  |  75 +++-
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  |  48 ++-
 MAINTAINERS                                        |   7 +
 arch/mips/bcm63xx/dev-wdt.c                        |   8 +
 drivers/watchdog/Kconfig                           |  98 ++++--
 drivers/watchdog/Makefile                          |   4 +-
 drivers/watchdog/apple_wdt.c                       | 226 ++++++++++++
 drivers/watchdog/bcm63xx_wdt.c                     | 317 -----------------
 drivers/watchdog/bcm7038_wdt.c                     |  15 +-
 drivers/watchdog/da9063_wdt.c                      |  12 +-
 drivers/watchdog/davinci_wdt.c                     |   2 +-
 drivers/watchdog/f71808e_wdt.c                     |  10 +-
 drivers/watchdog/meson_gxbb_wdt.c                  |   1 -
 drivers/watchdog/msc313e_wdt.c                     |   4 +
 drivers/watchdog/mtk_wdt.c                         |   2 +-
 drivers/watchdog/realtek_otto_wdt.c                | 384 +++++++++++++++++++++
 drivers/watchdog/rzg2l_wdt.c                       | 263 ++++++++++++++
 drivers/watchdog/s3c2410_wdt.c                     | 338 +++++++++++++-----
 include/linux/platform_data/bcm7038_wdt.h          |   8 +
 25 files changed, 1495 insertions(+), 492 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
 create mode 100644 drivers/watchdog/apple_wdt.c
 delete mode 100644 drivers/watchdog/bcm63xx_wdt.c
 create mode 100644 drivers/watchdog/realtek_otto_wdt.c
 create mode 100644 drivers/watchdog/rzg2l_wdt.c
 create mode 100644 include/linux/platform_data/bcm7038_wdt.h
----------------------------------------------------------------

Kind regards,
Wim.

