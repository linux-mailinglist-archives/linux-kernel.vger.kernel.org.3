Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561C5589BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiHDMlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiHDMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:41:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2D20BC1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:41:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j4-20020a05600c1c0400b003a4f287418bso2281734wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3HxUVd+J6b5e1RKtCKXwJ8ESvmvi4D20YD7+DqzvWU=;
        b=HJTyUv1WKqKebL/DNvtHmPk3fYTtFvz875MYeMaAM+l2l4vUlU27tNkvTYq7DlX6zw
         pGgy1CXh9F3K8C/BJdrxlBSCglCSNJsy1CdEXlaqmfYYRpxvYhdN1VicSVpLEaEzCL8W
         l56Kije2H6CXzLubY4fGtxCJSrMyTEaoiqjfKgjP/PWuJK9zJF+Maq5fEuCeYKrYwddF
         ITCooxgHlMffdj3FcXSVUnoCW3lS7lTegahajS3VFkuaeekphwrR75Dbm2SG8h0xuBWQ
         GdKc9EpsEk+EJTfyw6/UYGBmI64aYxMWUXkCWNNvW3v5U0s/dp2VPCPDwDNxy7ebFJkb
         BijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3HxUVd+J6b5e1RKtCKXwJ8ESvmvi4D20YD7+DqzvWU=;
        b=VDJihqMhpoJpePU9bUqlCytls49OI0wbVKMos4+M8Pw6aoMRemddfsJtQU4PeIqJ7i
         TNBnNGoUOGUWUPQ2U6UvW4/qa+DCo+VF7kVduJi/Lp1cC8ugARklERNsPuh34Q9te4ZC
         usM4F8djEoV7zdxMBfpkWyHAg0Qlm31aElm95fBczB/rj+LfvCFxi6cRiL5Fz3m7ZMll
         a7oQOaEs8tCo9UYs1Tacj/2EifUOttOXenAt2BDQEqNoP08A5jO/RWcI6BYOxH0SvIrl
         YNPjELfT+g8t3R4o8/0hfTRU55qeTDmo2Q2maWVF8opqLpJLSoZfb6fhW/AJDh0MAfq2
         +/sg==
X-Gm-Message-State: ACgBeo2iF98W9d6b2YMiWPXtbzWti/JcQUbaOxtMX9+fJSXjUMPBdZXo
        uF2iQ5Tlwh8xXFHFwBAimjyuj6tT5XbXEA==
X-Google-Smtp-Source: AA6agR74g5MncM7UBdkaMxZQWPbCGzHfQwwj0TKETK+1yjqjndLClzMo8tRpYPqRwDSchOAmj2793g==
X-Received: by 2002:a05:600c:15d6:b0:3a4:f9f8:eba3 with SMTP id v22-20020a05600c15d600b003a4f9f8eba3mr5240837wmf.33.1659616866540;
        Thu, 04 Aug 2022 05:41:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ab4f:2a3a:99f1:7c84])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b003a31ca9dfb6sm2230766wmq.32.2022.08.04.05.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 05:41:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: updates for v6.0-rc1
Date:   Thu,  4 Aug 2022 14:41:03 +0200
Message-Id: <20220804124103.1088581-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the updates for this merge window from the GPIO subsystem. We have
more lines removed than added thanks to dropping of a driver for a platform
that's no longer supported. Otherwise the changes are pretty straightforward.
We have support for some new models, various improvements to existing drivers,
some tweaks to the core library code and DT bindings updates. Details are in
the signed tag.

Please pull!
Bartosz Golaszewski

The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.0-rc1

for you to fetch changes up to c4f0d16daa6d1c5d862d063379c03310387095d5:

  dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles (2022-07-28 15:49:49 +0200)

----------------------------------------------------------------
gpio: updates for v6.0-rc1

- remove gpio-vr41xx driver as the only platform using it got dropped too
- add support for suspend/resume to gpio-davinci
- improvements to the GPIO character device code
- add support for disabling bias for in-kernel users (up until now
  only user-space could set it)
- drop unused devm_gpio_free()
- fix a refcount issue in gpiolib OF
- use device match helpers where applicable
- add support for a new model to gpio-rockchip
- non-functional improvements in gpio-adp5588
- improve and simplify teardown in gpio-twl4030 and gpio-ucb1400
- modernize the gpio-74xx-mmio and gpio-adnp drivers
- coding style improvements in gpio-xilinx, gpio-104-idi-48
- support new model (pca9571) in gpio-pca9570
- convert the DT bindings to YAML for gpio-mvebu and update the document
- don't return error codes from remove() in gpio-brcmstb
- add a library for the intel 8255 PPI interface and use it in drivers
- reduce using magic numbers and improve code readability in several drivers
- convert DT bindings to YAML for gpio-tpic2810
- add new models to DT bindings for gpio-frl-imx
- Kconfig improvements
- other minor tweaks and improvements

----------------------------------------------------------------
Aakash Sen Sharma (1):
      gpio: 104-idi-48: unsigned to unsigned int cleanup

Andy Shevchenko (13):
      gpio: pch: Use dev_err_probe()
      gpio: pch: Change PCI device macros
      gpiolib: devres: Get rid of unused devm_gpio_free()
      gpio: adnp: use simple i2c probe function
      gpio: adnp: Make use of device properties
      gpio: adp5588: Switch from of headers to mod_devicetable.h
      gpio: adp5588: Do not use defined value for driver name and compatible
      gpio: adp5588: sort header inclusion alphabetically
      gpiolib: of: Use device_match_of_node() helper
      gpio: 74xx-mmio: Make use of device properties
      gpio: 74xx-mmio: Check MMIO_74XX_DIR_IN flag in mmio_74xx_dir_in()
      gpio: 74xx-mmio: use bits.h macros for all masks
      gpio: 74xx-mmio: Use bits instead of plain numbers for flags

Aparna M (1):
      dt-bindings: gpio: Convert TI TPIC2810 GPIO Controller bindings to YAML

Bartosz Golaszewski (1):
      Merge tag 'intel-gpio-v5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into TEST_MERGE

Chris Packham (3):
      dt-bindings: gpio: gpio-mvebu: convert txt binding to DT schema format
      dt-bindings: gpio: gpio-mvebu: deprecate armadaxp-gpio
      dt-bindings: gpio: gpio-mvebu: document offset and marvell,pwm-offset

Devarsh Thakkar (1):
      gpio: davinci: Add support for system suspend/resume PM

Geert Uytterhoeven (2):
      dt-bindings: gpio: renesas,rcar-gpio: R-Car V3U is R-Car Gen4
      gpio: GPIO_SAMA5D2_PIOBU should depend on ARCH_AT91

Jesse Taube (1):
      dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles

Jianqun Xu (1):
      gpio: rockchip: add support for rk3588

Kent Gibson (6):
      gpiolib: cdev: simplify linereq_free
      gpiolib: cdev: simplify parameter in call to hte_edge_setup
      gpiolib: cdev: replace if-else chains with switches
      gpiolib: cdev: simplify line event identification
      gpiolib: cdev: consolidate edge detector configuration flags
      gpiolib: cdev: compile out HTE unless CONFIG_HTE selected

Liang He (1):
      gpio: gpiolib-of: Fix refcount bugs in of_mm_gpiochip_add_data()

Lucas Stach (2):
      gpio: pca9570: Add DT bindings for NXP PCA9571
      gpio: pca9570: add pca9571 support

Nuno Sá (4):
      gpiolib: add support for bias pull disable
      gpiolib: of: support bias pull disable
      gpiolib: acpi: support bias pull disable
      dt-bindings: gpio: add pull-disable flag

Sebastian Reichel (1):
      dt-bindings: gpio: rockchip: add gpio-ranges

Shinyzenith (1):
      gpio: lp3943: unsigned to unsigned int cleanup

Shubhrajyoti Datta (1):
      gpio: xilinx: add missing blank line after declarations

Thomas Bogendoerfer (1):
      gpio: remove VR41XX related gpio driver

Uwe Kleine-König (5):
      gpio: twl4030: Drop platform teardown callback
      gpio: twl4030: Don't return an error after WARN in .remove
      gpio: ucb1400: Remove platform setup and teardown support
      gpio: brcmstb: Make .remove() obviously always return 0
      gpio: xgs-iproc: Drop if with an always false condition

William Breathitt Gray (7):
      gpio: ws16c48: Implement and utilize register structures
      gpio: 104-idio-16: Implement and utilize register structures
      gpio: i8255: Introduce the Intel 8255 interface library module
      gpio: 104-dio-48e: Implement and utilize register structures
      gpio: 104-idi-48: Implement and utilize register structures
      gpio: gpio-mm: Implement and utilize register structures
      MAINTAINERS: Update Intel 8255 GPIO driver file list

 .../arm/marvell/ap80x-system-controller.txt        |   2 +-
 .../arm/marvell/cp110-system-controller.txt        |   2 +-
 .../devicetree/bindings/gpio/fsl-imx-gpio.yaml     |   2 +
 .../devicetree/bindings/gpio/gpio-mvebu.txt        |  93 ----
 .../devicetree/bindings/gpio/gpio-mvebu.yaml       | 146 ++++++
 .../devicetree/bindings/gpio/gpio-pca9570.yaml     |   1 +
 .../devicetree/bindings/gpio/gpio-tpic2810.txt     |  16 -
 .../devicetree/bindings/gpio/gpio-tpic2810.yaml    |  51 ++
 .../bindings/gpio/renesas,rcar-gpio.yaml           |   4 +-
 .../bindings/gpio/rockchip,gpio-bank.yaml          |   2 +
 Documentation/driver-api/driver-model/devres.rst   |   1 -
 MAINTAINERS                                        |   9 +-
 drivers/gpio/Kconfig                               |  22 +-
 drivers/gpio/Makefile                              |   2 +-
 drivers/gpio/gpio-104-dio-48e.c                    | 249 +++-------
 drivers/gpio/gpio-104-idi-48.c                     | 157 +++---
 drivers/gpio/gpio-104-idio-16.c                    |  60 ++-
 drivers/gpio/gpio-74xx-mmio.c                      |  19 +-
 drivers/gpio/gpio-adnp.c                           |  19 +-
 drivers/gpio/gpio-adp5588.c                        |  26 +-
 drivers/gpio/gpio-brcmstb.c                        |   9 +-
 drivers/gpio/gpio-davinci.c                        |  83 ++++
 drivers/gpio/gpio-gpio-mm.c                        | 202 ++------
 drivers/gpio/gpio-i8255.c                          | 287 +++++++++++
 drivers/gpio/gpio-i8255.h                          |  46 ++
 drivers/gpio/gpio-lp3943.c                         |  16 +-
 drivers/gpio/gpio-pca9570.c                        |   2 +
 drivers/gpio/gpio-pch.c                            |  43 +-
 drivers/gpio/gpio-rockchip.c                       |   3 +-
 drivers/gpio/gpio-twl4030.c                        |  18 +-
 drivers/gpio/gpio-ucb1400.c                        |  20 -
 drivers/gpio/gpio-vr41xx.c                         | 541 ---------------------
 drivers/gpio/gpio-ws16c48.c                        | 120 +++--
 drivers/gpio/gpio-xgs-iproc.c                      |   6 +-
 drivers/gpio/gpio-xilinx.c                         |   2 +
 drivers/gpio/gpiolib-acpi.c                        |   3 +
 drivers/gpio/gpiolib-cdev.c                        | 291 +++++------
 drivers/gpio/gpiolib-devres.c                      |  32 --
 drivers/gpio/gpiolib-of.c                          |  13 +-
 drivers/gpio/gpiolib.c                             |   8 +-
 drivers/mfd/ucb1400_core.c                         |   6 +-
 include/dt-bindings/gpio/gpio.h                    |   3 +
 include/linux/gpio.h                               |   6 -
 include/linux/gpio/machine.h                       |   1 +
 include/linux/mfd/twl.h                            |   2 -
 include/linux/of_gpio.h                            |   1 +
 include/linux/ucb1400.h                            |   2 -
 47 files changed, 1197 insertions(+), 1452 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-tpic2810.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-tpic2810.yaml
 create mode 100644 drivers/gpio/gpio-i8255.c
 create mode 100644 drivers/gpio/gpio-i8255.h
 delete mode 100644 drivers/gpio/gpio-vr41xx.c
