Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BDD58A8C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiHEJZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHEJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:24:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16AD78207
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:24:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q30so2527163wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=VEq7mY8SXDcgt+q8zzjn66k86M5gNc1Rl+m8lRzuBRI=;
        b=fH4QbCooRH6orhWIX2fqDznXE4IRkKDpJ3mFEIF3knlXEGAo6tqpsP2BWvA+DTAy5x
         LjmF9jAHVb8nQFZ3ZT+e+V0kHg2v4/IIFUg1eSZLOvmDWHGZn6rt2lXVBql5EK/nd/+Q
         cGOCQkBkvn9I6luHO8pXgDBu5FFWhrLIKjRjCHdtlGgfgBLO8vJRdofTCPtRHdQrsxc1
         +3YhQIHlUoODIgP4wbe30iuNsMIRyiz7u4NEkKSDitnXeoavkHHiIaHTa5Et6XaAU9f6
         CMtyYBj2Q5CL3gBrSWqBBtZs1CjTiTT/QXCQmJ3bHoA5PcDGsZ0VxX0+7D9HW50Y7dHt
         BJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VEq7mY8SXDcgt+q8zzjn66k86M5gNc1Rl+m8lRzuBRI=;
        b=QDEzCV2+n7zRYe6x7YK1LQBSJcFgeZUXGz5OhIiYzoD3kwdq8+1Uv8Fk5uH3sDR/tA
         Q1cR8+GDD4Oko4rmsBM+7JPEXp4xWMZXMR4Vcvn/95IBr7zwZvFskHEQ32PCOpczL9oK
         NA1lRNhQp852ChDWxJ/VxYpH52ogKfjsahfqrpMNz3opYMJOSatKvUXZyPn02F1FWazD
         r/KdKtUyC8NnGT5U7EZyxeBA3ei9mK7dCISBXHpHELQ1BdJ+lSUba682n+xeHxP4xm/m
         CzoVl4nCFXoHElRF+gNzxKqmPGCZmVnOens00EHI/nyethtKHapUO146cA8VBkKzwY1r
         XX6g==
X-Gm-Message-State: ACgBeo2CV2V8krvuLQw5zdQAPM2LjWaCduuiBCqFQtroxZl6zX5mtuy4
        TF2NJ6PyzEs7VYqreAxvo6jF6g==
X-Google-Smtp-Source: AA6agR4wGK15SPdw4gwjGrMzaYOuXSQL5U6BWuvLD0K3M0MsWyARsDYgiwq7qGKT39SkcDj8K9B/dg==
X-Received: by 2002:a5d:5957:0:b0:220:6004:18c2 with SMTP id e23-20020a5d5957000000b00220600418c2mr3734865wri.568.1659691496101;
        Fri, 05 Aug 2022 02:24:56 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a38606385esm18067029wms.3.2022.08.05.02.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 02:24:55 -0700 (PDT)
Date:   Fri, 5 Aug 2022 10:24:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.20
Message-ID: <Yuzh5cwYc6TLQcWD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.20

for you to fetch changes up to ae4ccaed3a063652ec5b81efec2ad57a4ee506e5:

  dt-bindings: mfd: stm32-timers: Move fixed string node names under 'properties' (2022-07-22 07:41:03 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Change maintainer email address
   - Use acpi_dev_for_each_child() helper to walk the ACPI list

 - New Device Support
   - Add support for BCM2711 RPiVid ASB to Broadcom BCM2835
   - Add support for MT8195 dual-core RISC-V MCU to Chrome OS Embedded Controller
   - Add support for Regulator, RTC and Keys to MediaTek MT6357 PMIC
   - Add support for GPIO to X-Powers AXP20x PMIC
   - Add support for MT6331 and MT6332 to MediaTek MT6357 PMIC
   - Add support for Intel Meteor Lake-P PCI to Intel LPSS PCI

 - New Functionality
   - Add support for non-ACPI platforms; lpc_ich

 - Fix-ups
   - Use platform data instead of hard-coded values; bcm2835-pm
   - Make use of BIT/GENMASK macros; intel_soc_pmic_bxtwc
   - Use dev_err_probe() helper; intel_soc_pmic_chtwc, intel_soc_pmic_bxtwc
   - Use provided generic APIs / helpers; lpc_ich
   - Clean-up .remove() return values; asic3, t7l66xb, tc6387xb, tc6393xb
   - Use correct formatting specifiers; syscon
   - Replace sprintf() with sysfs_emit(); intel_soc_pmic_bxtwc
   - Automatically detect and fill USB endpoint pointers; dln2
   - Use more appropriate dev/platform/spi resources APIs; intel_soc_pmic_bxtwc
   - Make use of pm_sleep_ptr(); intel_soc_pmic_chtwc, intel_soc_pmic_bxtwc
   - Improve error handling; intel_soc_pmic_bxtwc
   - Use core driver API to create groups; intel_soc_pmic_bxtwc
   - Kconfig fix-ups; MFD_SUN6I_PRCM
   - Admin: whitespace/email addresses/etc; max77714, db8500-prcmu, ipaq-micro,
			intel_soc_pmic_bxtwc
   - Remove duplicate/unused code/functionality; lpc_ich, twl-core, qcom-pm8008,
			intel_soc_pmic_bxtwc
   - DT fix-ups / conversions; da9063, ti,j721e-system-controller, st,stm32-timers,
			mt6397, qcom,tcsr, mps,mp2629, qcom-pm8xxx, fsl,imx8qxp-csr

 - Bug Fixes
   - Fix of_node reference leak; max77620

----------------------------------------------------------------
Andy Shevchenko (23):
      pinctrl: intel: Check against matching data instead of ACPI companion
      mfd: lpc_ich: Factor out lpc_ich_enable_spi_write()
      mfd: lpc_ich: Switch to generic p2sb_bar()
      i2c: i801: convert to use common P2SB accessor
      EDAC, pnd2: Use proper I/O accessors and address space annotation
      EDAC, pnd2: convert to use common P2SB accessor
      MAINTAINERS: Update Intel PMIC (MFD part) to Supported
      syscon: Use %pa to format the variable of resource_size_t type
      mfd: dln2: Automatically detect and fill endpoint pointers
      mfd: intel_soc_pmic_chtwc: Use dev_err_probe()
      mfd: intel_soc_pmic_chtwc: Switch from __maybe_unused to pm_sleep_ptr() etc
      mfd: intel-lpss: Add Intel Meteor Lake-P PCI IDs
      mfd: intel_soc_pmic_bxtwc: Don't shadow error codes in show()/store()
      mfd: intel_soc_pmic_bxtwc: Create sysfs attributes using core driver's facility
      mfd: intel_soc_pmic_bxtwc: Convert to use platform_get/set_drvdata()
      mfd: intel_soc_pmic_bxtwc: Use dev_err_probe()
      mfd: intel_soc_pmic_bxtwc: Extend use of temporary variable for struct device
      mfd: intel_soc_pmic_bxtwc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      mfd: intel_soc_pmic_bxtwc: Drop redundant ACPI_PTR()
      mfd: intel_soc_pmic_bxtwc: Use bits.h macros for all masks
      mfd: intel_soc_pmic_bxtwc: Use sysfs_emit() instead of sprintf()
      mfd: intel_soc_pmic_bxtwc: Drop unneeded casting
      mfd: intel_soc_pmic_bxtwc: Fix spelling in the comment

AngeloGioacchino Del Regno (3):
      dt-bindings: mfd: Add compatible for MT6331 PMIC
      dt-bindings: mfd: mt6397: Add compatibles for MT6331 RTC and keys
      mfd: mt6397: Add basic support for MT6331+MT6332 PMIC

Conor Dooley (1):
      dt-bindings: mfd: Convert da9063 to yaml

Fabien Parent (2):
      mfd: mt6397-core: Add MT6357 PMIC support
      mfd: mt6358-irq: Add MT6357 PMIC support

Henning Schild (4):
      watchdog: simatic-ipc-wdt: convert to use P2SB accessor
      leds: simatic-ipc-leds: Convert to use P2SB accessor
      platform/x86: simatic-ipc: drop custom P2SB bar code
      leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver

Jiang Jian (1):
      mfd: db8500-prcmu: Drop duplicated word "the" in the comments

Jonathan Yong (1):
      platform/x86/intel: Add Primary to Sideband (P2SB) bridge support

Krzysztof Kozlowski (2):
      dt-bindings: mfd: qcom,tcsr: Convert to dtschema
      dt-bindings: mfd: qcom,tcsr: Add qcom,tcsr-mdm9615

Lee Jones (5):
      Merge branches 'ib-mfd-acpi-for-rafael-5.20', 'ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20' and 'ib
-mfd-soc-bcm-5.20' into ibs-for-mfd-merged
      mfd: pm8008: Remove driver data structure pm8008_data
      MAINTAINERS: Use Lee Jones' kernel.org address for MFD submissions
      MAINTAINERS: Use Lee Jones' kernel.org address for Syscon submissions
      dt-bindings: mfd: syscon: Update Lee Jones' email address

Liu Ying (1):
      dt-bindings: mfd: Add i.MX8qm/qxp Control and Status Registers module binding

Luca Ceresoli (1):
      mfd: max77714: Update Luca Ceresoli's e-mail address

Lukas Bulwahn (1):
      MAINTAINERS: Fix file entry for MAX77693 DT

Miaoqian Lin (1):
      mfd: max77620: Fix refcount leak in max77620_initialise_fps

Nicolas Saenz Julienne (2):
      mfd: bcm2835-pm: Use 'reg-names' to get resources
      soc: bcm: bcm2835-power: Bypass power_on/off() calls

Rafael J. Wysocki (1):
      mfd: core: Use acpi_dev_for_each_child()

Rahul T R (1):
      dt-bindings: mfd: ti,j721e-system-controller: Add clock property

Rob Herring (2):
      dt-bindings: mfd: st,stm32-timers: Correct 'resets' property name
      dt-bindings: mfd: stm32-timers: Move fixed string node names under 'properties'

Samuel Holland (2):
      mfd: axp20x: Add AXP221/AXP223/AXP809 GPIO cells
      mfd: sun6i-prcm: Update Kconfig description

Saravanan Sekar (1):
      dt-bindings: mfd: Add mp2733 compatible

Satya Priya (1):
      dt-bindings: mfd: qcom-pm8xxx: Update the maintainers section

Stefan Wahren (4):
      mfd: bcm2835-pm: Add support for BCM2711
      soc: bcm: bcm2835-power: Refactor ASB control
      soc: bcm: bcm2835-power: Resolve ASB register macros
      soc: bcm: bcm2835-power: Add support for BCM2711's RPiVid ASB

Tan Jui Nee (1):
      mfd: lpc_ich: Add support for pinctrl in non-ACPI system

Tinghan Shen (1):
      mfd: cros_ec: Add SCP Core-1 as a new CrOS EC MCU

Uwe Kleine-König (6):
      mfd: asic3: Make asic3_gpio_remove() return void
      mfd: t7l66xb: Drop platform disable callback
      mfd: tc6387xb: Drop disable callback that is never called
      dt-bindings: mfd: stm32-timers: Document how to specify interrupts
      mfd: twl: Remove platform data support
      mfd: tc6393xb: Make disable callback return void

Zhang Jiaming (1):
      mfd: ipaq-micro: Fix spelling mistake of "receive{d}"

 Documentation/devicetree/bindings/mfd/da9063.txt   |  114 --
 .../devicetree/bindings/mfd/dlg,da9063.yaml        |  132 ++
 .../devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml   |  192 +++
 .../devicetree/bindings/mfd/mps,mp2629.yaml        |    4 +-
 Documentation/devicetree/bindings/mfd/mt6397.txt   |    8 +-
 .../devicetree/bindings/mfd/qcom,tcsr.txt          |   24 -
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   50 +
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |    2 +-
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |   28 +-
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   |   37 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |    2 +-
 .../bindings/mfd/ti,j721e-system-controller.yaml   |   12 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 MAINTAINERS                                        |    8 +-
 arch/arm/mach-pxa/eseries.c                        |    4 +-
 arch/arm/mach-pxa/tosa.c                           |    4 +-
 drivers/edac/Kconfig                               |    1 +
 drivers/edac/pnd2_edac.c                           |   62 +-
 drivers/i2c/busses/Kconfig                         |    1 +
 drivers/i2c/busses/i2c-i801.c                      |   39 +-
 drivers/leds/simple/Kconfig                        |    6 +-
 drivers/leds/simple/Makefile                       |    1 +
 drivers/leds/simple/simatic-ipc-leds-gpio.c        |  105 ++
 drivers/leds/simple/simatic-ipc-leds.c             |   80 +-
 drivers/mfd/Kconfig                                |    6 +-
 drivers/mfd/asic3.c                                |    9 +-
 drivers/mfd/axp20x.c                               |    9 +
 drivers/mfd/bcm2835-pm.c                           |   74 +-
 drivers/mfd/cros_ec_dev.c                          |    5 +
 drivers/mfd/db8500-prcmu.c                         |    2 +-
 drivers/mfd/dln2.c                                 |   17 +-
 drivers/mfd/intel-lpss-pci.c                       |   13 +
 drivers/mfd/intel_soc_pmic_bxtwc.c                 |  194 +--
 drivers/mfd/intel_soc_pmic_chtwc.c                 |   27 +-
 drivers/mfd/lpc_ich.c                              |  161 +-
 drivers/mfd/max77620.c                             |    2 +
 drivers/mfd/max77714.c                             |    4 +-
 drivers/mfd/mfd-core.c                             |   31 +-
 drivers/mfd/mt6358-irq.c                           |   24 +
 drivers/mfd/mt6397-core.c                          |   91 ++
 drivers/mfd/mt6397-irq.c                           |    9 +-
 drivers/mfd/qcom-pm8008.c                          |   53 +-
 drivers/mfd/syscon.c                               |    3 +-
 drivers/mfd/t7l66xb.c                              |    6 +-
 drivers/mfd/tc6393xb.c                             |    5 +-
 drivers/mfd/twl-core.c                             |  323 +---
 drivers/pinctrl/intel/pinctrl-intel.c              |   14 +-
 drivers/platform/x86/intel/Kconfig                 |   12 +
 drivers/platform/x86/intel/Makefile                |    2 +
 drivers/platform/x86/intel/p2sb.c                  |  133 ++
 drivers/platform/x86/simatic-ipc.c                 |   43 +-
 drivers/soc/bcm/bcm2835-power.c                    |   72 +-
 drivers/watchdog/Kconfig                           |    1 +
 drivers/watchdog/simatic-ipc-wdt.c                 |   15 +-
 include/linux/mfd/bcm2835-pm.h                     |    1 +
 include/linux/mfd/ipaq-micro.h                     |    4 +-
 include/linux/mfd/max77714.h                       |    2 +-
 include/linux/mfd/mt6331/core.h                    |   40 +
 include/linux/mfd/mt6331/registers.h               |  584 ++++++++
 include/linux/mfd/mt6332/core.h                    |   65 +
 include/linux/mfd/mt6332/registers.h               |  642 ++++++++
 include/linux/mfd/mt6357/core.h                    |  119 ++
 include/linux/mfd/mt6357/registers.h               | 1574 ++++++++++++++++++++
 include/linux/mfd/mt6397/core.h                    |    3 +
 include/linux/mfd/t7l66xb.h                        |    1 -
 include/linux/mfd/tc6387xb.h                       |    1 -
 include/linux/mfd/tc6393xb.h                       |    2 +-
 include/linux/mfd/twl.h                            |   55 -
 include/linux/platform_data/cros_ec_commands.h     |    2 +
 include/linux/platform_data/cros_ec_proto.h        |    1 +
 include/linux/platform_data/x86/p2sb.h             |   28 +
 include/linux/platform_data/x86/simatic-ipc-base.h |    2 -
 72 files changed, 4348 insertions(+), 1056 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/da9063.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
 create mode 100644 drivers/platform/x86/intel/p2sb.c
 create mode 100644 include/linux/mfd/mt6331/core.h
 create mode 100644 include/linux/mfd/mt6331/registers.h
 create mode 100644 include/linux/mfd/mt6332/core.h
 create mode 100644 include/linux/mfd/mt6332/registers.h
 create mode 100644 include/linux/mfd/mt6357/core.h
 create mode 100644 include/linux/mfd/mt6357/registers.h
 create mode 100644 include/linux/platform_data/x86/p2sb.h
 
-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
