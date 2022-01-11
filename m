Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C470D48B159
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349715AbiAKPxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349706AbiAKPxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:53:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6216C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 07:53:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o3so33775725wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 07:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WCe3PWueBfoiBPs5+yHGhsz6wUccRD673id4rHWJuXk=;
        b=ec7lsS8QG/hQxr0Ge0hqBV4d4vvTHGlFIMYTfzmdVGhyGWbU8o9bLO03h4mffWVlQ7
         b/aH6vUHImyB0HOQLePpbr0RkP+h1yXb6O0QGIA90jefkroT8j/Yzo52PlEyVDSLoIHF
         ssMd2KadPson8R6Sc7yKoq+WcsUU8/9WLiKMZYnwdwHDYL8AXBMQ7i8t/Qlca3coNbvB
         Htw1cQEr0qH5U/+NYSn1JHq1NNHflbGcQAAWnAl//2g0nyXlGsVBVtmW78swTC2mfMvX
         CamE0bOWxYemymP8PTDhizVhmXNDT0pK3Leq70+yGjI0nGrdE7ysyryMsHMMC8swtj8G
         7KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WCe3PWueBfoiBPs5+yHGhsz6wUccRD673id4rHWJuXk=;
        b=FSmNSXd0QQUyYAo4hdSJ9JCFUx8fnBGsDzbIUEqGRBFePupwRS7IqV/rzPaXqlmGJ0
         nF/5yCjaix/wpr0+r+y9OAeNku4/Z2oi4YRPV7rU8X4TiWaarxWCpGUNTc8jeQK91ur6
         otVvwxmoMlHi8XuNC9Zqh4Gg1Bg38DsKzBmMBYXmIOgpMRFU/Ql5fR3i6C5WX3PIXgrz
         gBxTAMv359SrlIizPtMm1JB6gLMxEWy6zscj5wY2YJrTPhjX2Pghjh8NELy7Hk0Dis7P
         einJeBxpjDspofv79GiQ07eJXLHYbDjNiXxnkKrRencJnAuwKQG+9G0YmgODnLcXG/Fu
         DyOA==
X-Gm-Message-State: AOAM531daw27OWqRVQKNLQhV5XNHeOGEMdUD1V7XIDDMqFphFtq0ifri
        JUNdHTotQJ6EVIvxQ+3IxD82zU5yyK0L+g==
X-Google-Smtp-Source: ABdhPJzHEnxVhH4Iw1f74jiyID+/Rbjamp+gqyWN7LCxc/rP8UMUn/5BaVaSXyy/1/9slpOEE7qtxA==
X-Received: by 2002:a05:6000:1ac9:: with SMTP id i9mr4221846wry.531.1641916379170;
        Tue, 11 Jan 2022 07:52:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id u11sm2211629wmq.41.2022.01.11.07.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 07:52:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: updates for v5.17
Date:   Tue, 11 Jan 2022 16:52:55 +0100
Message-Id: <20220111155255.745428-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This is the main pull-request from the GPIO subsystem for the next release
cycle.

The gpio-sim module is back, this time without any changes to configfs. This
results in a less elegant user-space interface but I never got any follow-up on
the committable items and didn't want to delay this module for several more
months.

Other than that we have support for several new models and some support going
away. We started working on converting GPIO drivers to using fwnode exclusively
in order to limit references to OF symbols to gpiolib-of.c exclusively. We also
have regular tweaks and improvements all over the place.

The details are in the signed tag. Please pull!

Best Regards,
Bartosz Golaszewski

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v5.17

for you to fetch changes up to ffe31c9ed35d70069ee76d6b6d41ac86a17d7a07:

  gpio: rcar: Propagate errors from devm_request_irq() (2022-01-05 09:57:34 +0100)

----------------------------------------------------------------
gpio updates for v5.17

- new testing module: gpio-sim that is scheduled to replace gpio-mockup
- initial changes aiming at converting all GPIO drivers to using the fwnode
  interface and limiting any references to OF symbols to gpiolib-of.c
- add support for Tegra234 and Tegra241 to gpio-tegra186
- add support for new models (SSD201 and SSD202D) to gpio-msc313
- add basic support for interrupts to gpio-aggregator
- add support for AMDIF031 HID device to gpio-amdpt
- drop support for unused platforms in gpio-xlp
- cleanup leftovers from the removal of the legacy Samsung Exynos GPIO driver
- use raw spinlocks in gpio-aspeed and gpio-aspeed-sgpio to make PREEMPT_RT
  happy
- generalize the common 'ngpios' device property by reading it in the core
  gpiolib code so that we can remove duplicate reads from drivers
- allow line names from device properties to override names set by drivers
- code shrink in gpiod_add_lookup_table()
- add new model to the DT bindings for gpio-vf610
- convert DT bindings for tegra devices to YAML
- improvements to interrupt handling in gpio-rcar and gpio-rockchip
- updates to intel drivers from Andy (details in the merge commit)
- some minor tweaks, improvements and coding-style fixes all around the
  subsystem

----------------------------------------------------------------
Akhil R (2):
      dt-bindings: gpio: Add Tegra241 support
      gpio: tegra186: Add support for Tegra241

Andy Shevchenko (12):
      gpiolib: acpi: Remove never used devm_acpi_dev_remove_driver_gpios()
      gpiolib: acpi: shrink devm_acpi_dev_add_driver_gpios()
      gpiolib: acpi: Unify debug and other messages format
      gpio: dwapb: clarify usage of the register file version
      gpio: Get rid of duplicate of_node assignment in the drivers
      gpio: Setup parent device and get rid of unnecessary of_node assignment
      gpio: Propagate firmware node from a parent device
      gpio: Remove unused local OF node pointers
      gpio: brcmstb: Use local variable to access OF node
      gpio: regmap: Switch to use fwnode instead of of_node
      gpiolib: acpi: make fwnode take precedence in struct gpio_chip
      gpio: dwapb: Switch to use fwnode instead of of_node

Bartosz Golaszewski (12):
      gpiolib: improve coding style for local variables
      gpiolib: check the 'ngpios' property in core gpiolib code
      gpiolib: provide gpiod_remove_hogs()
      gpiolib: allow to specify the firmware node in struct gpio_chip
      gpiolib: of: make fwnode take precedence in struct gpio_chip
      gpio: sim: new testing module
      selftests: gpio: provide a helper for reading chip info
      selftests: gpio: add a helper for reading GPIO line names
      selftests: gpio: add test cases for gpio-sim
      selftests: gpio: gpio-sim: remove bashisms
      selftests: gpio: gpio-sim: avoid forking test twice
      Merge tag 'intel-gpio-v5.17-1' of gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-next

Bjorn Helgaas (5):
      gpio: pch: Use .driver_data instead of checking Device IDs again
      gpio: pch: Cache &pdev->dev to reduce repetition
      gpio: ml-ioh: Cache &pdev->dev to reduce repetition
      gpio: ml-ioh: Use BIT() to match gpio-pch.c
      gpio: ml-ioh: Change whitespace to match gpio-pch.c

Christophe JAILLET (1):
      gpio: max3191x: Use bitmap_free() to free bitmap

Daniel Palmer (4):
      dt-bindings: gpio: msc313: Add compatible for ssd20xd
      dt-bindings: gpio: msc313: Add offsets for ssd20xd
      gpio: msc313: Code clean ups
      gpio: msc313: Add support for SSD201 and SSD202D

Geert Uytterhoeven (3):
      dt-bindings: gpio: sifive,gpio: Group interrupt tuples
      gpiolib: Let gpiod_add_lookup_table() call gpiod_add_lookup_tables()
      gpio: aggregator: Add interrupt support

Hans de Goede (1):
      gpiolib: acpi: Do not set the IRQ type if the IRQ is already in use

Hsu Yuchang (1):
      gpio: amdpt: add new device ID and 24-pin support

Iwona Winiarska (2):
      gpio: aspeed: Convert aspeed_gpio.lock to raw_spinlock
      gpio: aspeed-sgpio: Convert aspeed_sgpio.lock to raw_spinlock

Jacky Bai (1):
      dt-bindings: gpio: gpio-vf610: Add imx8ulp compatible string

Jason Wang (2):
      gpio: sch: fix typo in a comment
      gpio: sta2x11: fix typo in a comment

John Keeping (1):
      gpio: rockchip: lock GPIOs used as interrupts

Krzysztof Kozlowski (1):
      dt-bindings: gpio: samsung: drop unused bindings

Lad Prabhakar (3):
      gpio: ts5500: Use platform_get_irq() to get the interrupt
      gpio: rcar: Use platform_get_irq() to get the interrupt
      gpio: rcar: Propagate errors from devm_request_irq()

Peter Rosin (1):
      gpiolib: allow line names from device props to override driver names

Prathamesh Shete (2):
      dt-bindings: gpio: Add Tegra234 support
      gpio: tegra186: Add support for Tegra234

Rob Herring (2):
      gpio: xlp: Remove Netlogic XLP variants
      gpio: xlp: Fix build errors from Netlogic XLP removal

Thierry Reding (2):
      dt-bindings: gpio: tegra: Convert to json-schema
      dt-bindings: gpio: tegra186: Convert to json-schema

Tom Rix (1):
      gpio: sim: fix uninitialized ret variable

Yang Yingliang (1):
      gpio: sim: add missing fwnode_handle_put() in gpio_sim_probe()

 Documentation/admin-guide/gpio/gpio-sim.rst        |  134 ++
 .../devicetree/bindings/gpio/gpio-samsung.txt      |   41 -
 .../devicetree/bindings/gpio/gpio-vf610.yaml       |    3 +
 .../bindings/gpio/mstar,msc313-gpio.yaml           |    4 +-
 .../bindings/gpio/nvidia,tegra186-gpio.txt         |  165 --
 .../bindings/gpio/nvidia,tegra186-gpio.yaml        |  214 +++
 .../bindings/gpio/nvidia,tegra20-gpio.txt          |   40 -
 .../bindings/gpio/nvidia,tegra20-gpio.yaml         |  110 ++
 .../devicetree/bindings/gpio/sifive,gpio.yaml      |    3 +-
 drivers/gpio/Kconfig                               |   18 +-
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-adnp.c                           |    1 -
 drivers/gpio/gpio-aggregator.c                     |   11 +-
 drivers/gpio/gpio-amdpt.c                          |   12 +-
 drivers/gpio/gpio-arizona.c                        |    5 +-
 drivers/gpio/gpio-aspeed-sgpio.c                   |   32 +-
 drivers/gpio/gpio-aspeed.c                         |   52 +-
 drivers/gpio/gpio-bcm-kona.c                       |    2 +-
 drivers/gpio/gpio-bd71828.c                        |    1 -
 drivers/gpio/gpio-brcmstb.c                        |    3 +-
 drivers/gpio/gpio-creg-snps.c                      |    2 +-
 drivers/gpio/gpio-davinci.c                        |    1 -
 drivers/gpio/gpio-dwapb.c                          |   15 +-
 drivers/gpio/gpio-eic-sprd.c                       |    1 -
 drivers/gpio/gpio-em.c                             |    1 -
 drivers/gpio/gpio-ge.c                             |    1 -
 drivers/gpio/gpio-grgpio.c                         |    1 -
 drivers/gpio/gpio-gw-pld.c                         |    2 -
 drivers/gpio/gpio-lpc32xx.c                        |    2 +-
 drivers/gpio/gpio-max3191x.c                       |    2 +-
 drivers/gpio/gpio-ml-ioh.c                         |   52 +-
 drivers/gpio/gpio-msc313.c                         |  266 +++-
 drivers/gpio/gpio-mt7621.c                         |    6 +-
 drivers/gpio/gpio-mvebu.c                          |    1 -
 drivers/gpio/gpio-omap.c                           |    3 -
 drivers/gpio/gpio-palmas.c                         |    4 +-
 drivers/gpio/gpio-pch.c                            |   42 +-
 drivers/gpio/gpio-pmic-eic-sprd.c                  |    1 -
 drivers/gpio/gpio-pxa.c                            |    8 +-
 drivers/gpio/gpio-raspberrypi-exp.c                |    1 -
 drivers/gpio/gpio-rcar.c                           |   16 +-
 drivers/gpio/gpio-rda.c                            |    3 -
 drivers/gpio/gpio-regmap.c                         |    6 +-
 drivers/gpio/gpio-rockchip.c                       |   21 +-
 drivers/gpio/gpio-sama5d2-piobu.c                  |    1 -
 drivers/gpio/gpio-sch.c                            |    2 +-
 drivers/gpio/gpio-sim.c                            | 1592 ++++++++++++++++++++
 drivers/gpio/gpio-sprd.c                           |    1 -
 drivers/gpio/gpio-sta2x11.c                        |    2 +-
 drivers/gpio/gpio-stmpe.c                          |    1 -
 drivers/gpio/gpio-tc3589x.c                        |    1 -
 drivers/gpio/gpio-tegra186.c                       |  129 +-
 drivers/gpio/gpio-tps65218.c                       |    3 -
 drivers/gpio/gpio-tps6586x.c                       |    5 +-
 drivers/gpio/gpio-tps65910.c                       |    6 +-
 drivers/gpio/gpio-ts5500.c                         |   11 +-
 drivers/gpio/gpio-twl6040.c                        |    5 +-
 drivers/gpio/gpio-vf610.c                          |    1 -
 drivers/gpio/gpio-wm831x.c                         |    5 +-
 drivers/gpio/gpio-xlp.c                            |  147 +-
 drivers/gpio/gpiolib-acpi.c                        |   54 +-
 drivers/gpio/gpiolib-of.c                          |    3 +
 drivers/gpio/gpiolib.c                             |   73 +-
 include/dt-bindings/gpio/msc313-gpio.h             |   71 +
 include/dt-bindings/gpio/tegra234-gpio.h           |   63 +
 include/dt-bindings/gpio/tegra241-gpio.h           |   42 +
 include/linux/gpio/consumer.h                      |    2 -
 include/linux/gpio/driver.h                        |    2 +
 include/linux/gpio/machine.h                       |    2 +
 tools/testing/selftests/gpio/.gitignore            |    2 +
 tools/testing/selftests/gpio/Makefile              |    4 +-
 tools/testing/selftests/gpio/config                |    1 +
 tools/testing/selftests/gpio/gpio-chip-info.c      |   57 +
 tools/testing/selftests/gpio/gpio-line-name.c      |   55 +
 tools/testing/selftests/gpio/gpio-sim.sh           |  396 +++++
 75 files changed, 3415 insertions(+), 634 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/gpio-sim.rst
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-samsung.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/nvidia,tegra20-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/nvidia,tegra20-gpio.yaml
 create mode 100644 drivers/gpio/gpio-sim.c
 create mode 100644 include/dt-bindings/gpio/tegra234-gpio.h
 create mode 100644 include/dt-bindings/gpio/tegra241-gpio.h
 create mode 100644 tools/testing/selftests/gpio/gpio-chip-info.c
 create mode 100644 tools/testing/selftests/gpio/gpio-line-name.c
 create mode 100755 tools/testing/selftests/gpio/gpio-sim.sh
