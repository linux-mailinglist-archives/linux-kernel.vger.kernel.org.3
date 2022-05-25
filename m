Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46C753411D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiEYQMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiEYQM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:12:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FADB41ED
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:12:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t6so30803474wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ya1Azs3xFLp3ggoRc5h7sy3IbdJTdqFXyKE5Xbq07Qs=;
        b=Ed+yl2WOIDBZMeuNsz678N4rWnUqrqyxgQusS8pRtgMuVbusNS6nZwa6D18IhSSX6f
         0XemGbEsj1lVH39kAZqkHXlG7qOnlomMS61IOPeimCVm0yPVtnGbDWeVtQkmg1R+m9CO
         CYRiZ3YFswYuNUifjJa9oDQYqaRs9z8lBD9VMwCujP56BDl1M+NWhzuPS1lgq/cefVea
         4+Z4JwMywtRMoXEK7edS9hWweHiA78RtLyMSbS7lMppBUd/6u5yifbs4VioqBHwSFVDV
         foMNgL000+5RjvsYVj6skjAVvsJ8B8ZLhvjL81pzf/3lRjxwc1NZbk7EhsNddAFOF2Q7
         PmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ya1Azs3xFLp3ggoRc5h7sy3IbdJTdqFXyKE5Xbq07Qs=;
        b=GL7rvYYOVy2mwOWbQdSDp7NiZbarfJMbD7V3XyYlLT/o0qYYeQc3DT5aVIRkHxbmTN
         ILOX4wRXG3AH4F59NDnI0ooIdihGqhCZsEWjAFvquu9aclXNcFVJntabNUjFCqfjQPqQ
         zPbcKcvMqq14dTvpWLDm6TfshInWWeoOdPWJShJz90Dxc3dHo7akhE3TTr7ZhHssYZfZ
         rcz/rLV8rsLszydKU8JrkfVhvc2lCaAZLp8k1VahhQmT/9mjCByWToKWXFt6ur646woO
         a7/TaTb6xKy/aiInCVAIvnEMsc/wKQHAetenwk3xB08ULjx/W8LFVLsWSPmJkYEA7/13
         Bytw==
X-Gm-Message-State: AOAM533ZJUf+BetRrNu1uDaWNqswccYZVBrVL8dtqC5f4012JrzEK0gX
        yw3cfa6ZAx4VEN232r0meEGrpA==
X-Google-Smtp-Source: ABdhPJzb1R7irfsdjvo1OTbeYZdLeubci2zQNOY1FntJXEp4VEFz9l3dS3UHamEc1h7C+QDZz8vp7w==
X-Received: by 2002:adf:d1cf:0:b0:20f:d7f1:9b49 with SMTP id b15-20020adfd1cf000000b0020fd7f19b49mr13937264wrd.369.1653495144637;
        Wed, 25 May 2022 09:12:24 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fb4f:2824:ee44:5505])
        by smtp.gmail.com with ESMTPSA id i5-20020a05600c354500b00394351e35edsm2529297wmq.26.2022.05.25.09.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 09:12:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: updates for v5.19
Date:   Wed, 25 May 2022 18:12:20 +0200
Message-Id: <20220525161220.151201-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here's the main pull-request from the GPIO subsystem for this release cycle.
We have lots of small changes all over the place, but no huge reworks or new
drivers.

There are two merges here: one is the usual pull-request from Andy and the
other contains changes to the GPIO irqchip behavior from Marc Zyngier.

Details are in the signed tag. Please pull.

Best Regards,
Bartosz Golaszewski

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v5.19

for you to fetch changes up to 5a7cb9f3978d1fe8cfba798b4c9c054ce226e8fd:

  gpio: sifive: Make the irqchip immutable (2022-05-24 16:35:52 +0200)

----------------------------------------------------------------
gpio updates for v5.19

- use ioread()/iowrite() interfaces instead of raw inb()/outb() in drivers
- make irqchips immutable due to the new warning popping up when drivers try to
  modify the irqchip structures
- add new compatibles to dt-bindings for realtek-otto, renesas-rcar and pca95xx
- add support for new models to gpio-rcar, gpio-pca953x & gpio-realtek-otto
- allow parsing of GPIO hogs represented as children nodes of gpio-uniphier
- define a set of common GPIO consumer strings in dt-bindings
- shrink code in gpio-ml-ioh by using more devres interfaces
- pass arguments to devm_kcalloc() in correct order in gpio-sim
- add new helpers for iterating over GPIO firmware nodes and descriptors to
  gpiolib core and use it in several drivers
- drop unused syscon_regmap_lookup_by_compatible() function
- correct format specifiers and signedness of variables in GPIO ACPI
- drop unneeded error checks in gpio-ftgpio
- stop using the deprecated of_gpio.h header in gpio-zevio
- drop platform_data support in gpio-max732x
- simplify Kconfig dependencies in gpio-vf610
- use raw spinlocks where needed to make PREEMPT_RT happy
- fix return values in board files using gpio-pcf857x
- convert more drivers to using fwnode instead of of_node
- minor fixes and improvements in gpiolib core

----------------------------------------------------------------
Alexander Shiyan (1):
      gpio: syscon: Remove usage of syscon_regmap_lookup_by_compatible

Andy Shevchenko (22):
      gpiolib: Get rid of redundant 'else'
      gpiolib: acpi: Convert type for pin to be unsigned
      gpiolib: Introduce for_each_gpiochip_node() loop helper
      gpiolib: Introduce gpiochip_node_count() helper
      pinctrl: stm32: Replace custom code by gpiochip_node_count() call
      pinctrl: stm32: Switch to use for_each_gpiochip_node() helper
      pinctrl: renesas: rza1: Replace custom code by gpiochip_node_count() call
      pinctrl: renesas: rza1: Switch to use for_each_gpiochip_node() helper
      pinctrl: npcm7xx: Switch to use for_each_gpiochip_node() helper
      gpiolib: Move error message out of a spinlock
      gpiolib: Embed iterator variable into for_each_gpio_desc_with_flag()
      gpiolib: Split out for_each_gpio_desc() macro
      gpiolib: Refactor gpiolib_dbg_show() with help of for_each_gpio_desc()
      gpiolib: Extract gpio_chip_get_value() wrapper
      pinctrl: samsung: Drop redundant node parameter in samsung_banks_of_node_get()
      pinctrl: samsung: Switch to use for_each_gpiochip_node() helper
      gpiolib: Introduce a helper to get first GPIO controller node
      pinctrl: armada-37xx: Switch to use fwnode instead of of_node
      pinctrl: armada-37xx: Reuse GPIO fwnode in armada_37xx_irqchip_register()
      pinctrl: meson: Rename REG_* to MESON_REG_*
      pinctrl: meson: Enable COMPILE_TEST
      pinctrl: meson: Replace custom code by gpiochip_node_count() call

Bartosz Golaszewski (2):
      Merge tag 'intel-gpio-v5.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-next
      Merge branch 'irq/gpio-immutable' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into gpio/for-next

Christophe JAILLET (1):
      gpio: sim: Use correct order for the parameters of devm_kcalloc()

Geert Uytterhoeven (7):
      dt-bindings: gpio: renesas,rcar-gpio: Add r8a779f0 support
      gpio: rcar: Add R-Car Gen4 support
      gpio: dwapb: Make the irqchip immutable
      gpio: pca953x: Make the irqchip immutable
      gpio: pcf857x: Make the irqchip immutable
      gpio: rcar: Make the irqchip immutable
      gpio: sifive: Make the irqchip immutable

Jon Hunter (1):
      gpio: max77620: Make the irqchip immutable

Justin Chen (2):
      gpio: pca953xx: Add support for pca6408
      dt-bindings: gpio: pca95xx: add entry for pca6408

Krzysztof Kozlowski (1):
      dt-bindings: gpio: add common consumer GPIO lines

Kunihiko Hayashi (1):
      dt-bindings: gpio: uniphier: Add hogs parsing

Linus Torvalds (1):
      gpiolib: acpi: use correct format characters

Linus Walleij (2):
      gpio: ixp4xx: Detect special machines by compatible
      irq/gpio: ixp4xx: Drop boardfile probe path

Marc Zyngier (10):
      gpio: Don't fiddle with irqchips marked as immutable
      gpio: Expose the gpiochip_irq_re[ql]res helpers
      gpio: Add helpers to ease the transition towards immutable irq_chip
      gpio: tegra186: Make the irqchip immutable
      gpio: pl061: Make the irqchip immutable
      pinctrl: apple-gpio: Make the irqchip immutable
      pinctrl: msmgpio: Make the irqchip immutable
      pinctrl: amd: Make the irqchip immutable
      gpio: Update TODO to mention immutable irq_chip structures
      Documentation: Update the recommended pattern for GPIO irqchips

Moses Christopher Bollavarapu (1):
      gpio: zevio: drop of_gpio.h header

Peng Fan (1):
      gpio: vf610: drop the SOC_VF610 dependency for GPIO_VF610

Sander Vanheule (6):
      dt-bindings: gpio: realtek-otto: Add rtl9300 compatible
      gpio: realtek-otto: Support reversed port layouts
      gpio: realtek-otto: Support per-cpu interrupts
      gpio: realtek-otto: Add RTL930x support
      dt-bindings: gpio: realtek-otto: Add rtl9310 compatible
      gpio: realtek-otto: Add RTL931x support

Schspa Shi (1):
      gpio: use raw spinlock for gpio chip shadowed data

Uwe Kleine-König (2):
      gpio: pcf857x: Make teardown callback return void
      gpio: max732x: Drop unused support for irq and setup code via platform data

Wan Jiabing (1):
      gpio: ftgpio: Remove unneeded ERROR check before clk_disable_unprepare

William Breathitt Gray (5):
      gpio: 104-dio-48e: Utilize iomap interface
      gpio: 104-idi-48: Utilize iomap interface
      gpio: 104-idio-16: Utilize iomap interface
      gpio: gpio-mm: Utilize iomap interface
      gpio: ws16c48: Utilize iomap interface

Zheyu Ma (1):
      gpio: ml-ioh: Convert to use managed functions pcim* and devm_*

 .../bindings/gpio/gpio-consumer-common.yaml        |  64 ++++++++
 .../devicetree/bindings/gpio/gpio-pca95xx.yaml     |   1 +
 .../bindings/gpio/realtek,otto-gpio.yaml           |  34 +++-
 .../bindings/gpio/renesas,rcar-gpio.yaml           |   5 +
 .../bindings/gpio/socionext,uniphier-gpio.yaml     |  17 ++
 Documentation/driver-api/gpio/driver.rst           | 175 +++++++++++++++++----
 arch/arm/mach-davinci/board-da830-evm.c            |   3 +-
 arch/arm/mach-davinci/board-dm644x-evm.c           |   9 +-
 arch/arm/mach-davinci/board-dm646x-evm.c           |   4 +-
 drivers/gpio/Kconfig                               |   7 +-
 drivers/gpio/TODO                                  |  19 +++
 drivers/gpio/gpio-104-dio-48e.c                    |  63 ++++----
 drivers/gpio/gpio-104-idi-48.c                     |  27 ++--
 drivers/gpio/gpio-104-idio-16.c                    |  33 ++--
 drivers/gpio/gpio-amdpt.c                          |  10 +-
 drivers/gpio/gpio-brcmstb.c                        |  12 +-
 drivers/gpio/gpio-cadence.c                        |  12 +-
 drivers/gpio/gpio-dwapb.c                          |  74 +++++----
 drivers/gpio/gpio-ftgpio010.c                      |   8 +-
 drivers/gpio/gpio-gpio-mm.c                        |  43 ++---
 drivers/gpio/gpio-grgpio.c                         |  30 ++--
 drivers/gpio/gpio-hlwd.c                           |  18 +--
 drivers/gpio/gpio-idt3243x.c                       |  12 +-
 drivers/gpio/gpio-ixp4xx.c                         |  49 ++----
 drivers/gpio/gpio-loongson1.c                      |   8 +-
 drivers/gpio/gpio-max732x.c                        |  37 +----
 drivers/gpio/gpio-max77620.c                       |   9 +-
 drivers/gpio/gpio-menz127.c                        |   8 +-
 drivers/gpio/gpio-ml-ioh.c                         |  76 ++-------
 drivers/gpio/gpio-mlxbf2.c                         |  18 +--
 drivers/gpio/gpio-mmio.c                           |  22 +--
 drivers/gpio/gpio-pca953x.c                        |  37 +++--
 drivers/gpio/gpio-pcf857x.c                        |  49 +++---
 drivers/gpio/gpio-pl061.c                          |  32 ++--
 drivers/gpio/gpio-rcar.c                           |  38 +++--
 drivers/gpio/gpio-realtek-otto.c                   | 137 +++++++++++++++-
 drivers/gpio/gpio-sifive.c                         |  26 +--
 drivers/gpio/gpio-sim.c                            |   4 +-
 drivers/gpio/gpio-syscon.c                         |  49 +++---
 drivers/gpio/gpio-tb10x.c                          |   4 +-
 drivers/gpio/gpio-tegra186.c                       |  32 ++--
 drivers/gpio/gpio-ws16c48.c                        |  65 ++++----
 drivers/gpio/gpio-zevio.c                          |  25 +--
 drivers/gpio/gpiolib-acpi.c                        |  22 +--
 drivers/gpio/gpiolib-cdev.c                        |  66 ++++----
 drivers/gpio/gpiolib-of.c                          |   3 +-
 drivers/gpio/gpiolib-sysfs.c                       |   3 +-
 drivers/gpio/gpiolib.c                             |  88 +++++------
 drivers/gpio/gpiolib.h                             |  11 +-
 drivers/irqchip/irq-ixp4xx.c                       | 126 +--------------
 drivers/pinctrl/meson/Kconfig                      |   2 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |  52 +++---
 drivers/pinctrl/meson/pinctrl-meson.h              |  28 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |  34 ++--
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          | 150 ++++++++----------
 drivers/pinctrl/pinctrl-amd.c                      |  11 +-
 drivers/pinctrl/pinctrl-apple-gpio.c               |  29 ++--
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  53 ++++---
 drivers/pinctrl/renesas/pinctrl-rza1.c             |  47 ++----
 drivers/pinctrl/samsung/pinctrl-exynos.c           |   8 +-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c          |   2 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |   4 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |  30 ++--
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  80 +++++-----
 include/linux/gpio/consumer.h                      |   8 +-
 include/linux/gpio/driver.h                        |  46 +++++-
 include/linux/irq.h                                |   2 +
 include/linux/irqchip/irq-ixp4xx.h                 |  12 --
 include/linux/platform_data/max732x.h              |  12 --
 include/linux/platform_data/pcf857x.h              |   2 +-
 kernel/irq/debugfs.c                               |   1 +
 72 files changed, 1277 insertions(+), 1062 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
 delete mode 100644 include/linux/irqchip/irq-ixp4xx.h
