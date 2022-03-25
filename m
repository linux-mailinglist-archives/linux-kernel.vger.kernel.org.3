Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3631A4E71B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352850AbiCYK6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbiCYK6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:58:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538BABD8AD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:56:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a1so10327955wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=4QlVs+8EqAZojMLB7VNBpSke8rhbob8YdqjuKcn712o=;
        b=F3zPdR16gpg8AoNKCU01Hi+GsQ/4iPKHX5sJQLOnT++TW4qNYzzX4GrufxcGDChJ6S
         KddQofNSpedojvwvAzbpAv8Bgv+mWXeagJNghHutBW2wjhP819sI2EHlIxTHLaotwN7Q
         Y10z/nhTkEVZT6pT+VwZLwofQE1JINsCGjx3R/2Orak2MWBmnb0bCWc8X4T7lensyMMx
         klMGF23sbsvnOVXRcwRsO+ouYNBGnI6Q5CUoFgkuiPV91+DFAX2GMccjGy4Zm1N8VJwS
         esr12WekYD0Yuguy5GYZrm4MmluKAH7YYOyYgrgGeVUMRTRg75jFVklC1ONeo3N230z1
         aq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=4QlVs+8EqAZojMLB7VNBpSke8rhbob8YdqjuKcn712o=;
        b=wdT5rdcLus4/KsDJLUnsLPcF/m0dtI6FdCymAEmC6dpo6cIozIqevCE0EbSCISqidz
         joJp9nID3+/1YBL7mcvyRkR010T0XWxrX5X1UJyVmGn5ssjyRVj0cix8++xpVm4aHoZu
         lpy7cv9hWyogD361d1lLBbyZnXbFhI4ladoeoqjJ+6MFJTctTGl3FCMBVxGLLaMSyr4y
         GNwaLG7tkPBDuhZBQksCSor3/GmrY2fw9KOMiEL/wljVGdmdzaOik3V6sWGa1o0vhkEt
         XcAjrumBmUYvQjxxdRbkX61KG0NP47u9r52jfi7h6iqvmMirWaGIN1quELxaO7ElYGZA
         p+6w==
X-Gm-Message-State: AOAM531p9ImiNj0qALiGxUJfWTJuaTOQf2s6aFvs8rk5E0Xpq8jF4gHm
        IqA1tf4AHzpKMroD7uGSgVxg6vBLY979Aw==
X-Google-Smtp-Source: ABdhPJw8672PSO4ZmgS2KZwftaeQ1mouSsEqx0B3dc4kGcQWPPaBqnAq0gCsBlA2lvvnvYHQf/ItXQ==
X-Received: by 2002:adf:b60b:0:b0:205:9cf1:20fd with SMTP id f11-20020adfb60b000000b002059cf120fdmr4686089wre.253.1648205795659;
        Fri, 25 Mar 2022 03:56:35 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm4787651wrg.62.2022.03.25.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 03:56:35 -0700 (PDT)
Date:   Fri, 25 Mar 2022 10:56:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.18
Message-ID: <Yj2f4VTOBd597Vm7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.18

for you to fetch changes up to d99460ed5cdcc28feba6b992630b04650e410902:

  dt-bindings: mfd: syscon: Add microchip,lan966x-cpu-syscon compatible (2022-03-23 14:52:02 +0000)

----------------------------------------------------------------
 - New Drivers
   - Add support for Maxim MAX77714 PMIC

 - Remove Drivers
   - Remove support for ST-Ericsson AB8500 DebugFS

 - New Device Support
   - Add support for Silergy SY7636A to Simple MFD I2C
   - Add support for MediaTek MT6366 PMIC to MT6358 IRQ
   - Add support for Charger to Intel PMIC CRC
   - Add support for Raptor Lake to Intel LPSS PCI

 - New Functionality
   - Add support for Reboot to Rockchip RK808

 - Fix-ups
   - Device Tree changes (inc. YAML conversion); silergy,sy7636a, maxim,max77843,
                                  google,cros-ec, maxim,max14577, maxim,max77802,
				  maxim,max77714, qcom,tcsr, qcom,spmi-pmic,
				  stericsson,ab8500, stericsson,db8500-prcmu,
				  samsung,exynos5433-lpass, mt6397, syscon, brcm,cru
   - Visible to menuconfig; simple-mfd-i2c
   - Clean-up or clarify code; max77686, intel_soc_pmic_crc
   - Improve error handling; mc13xxx-core, stmfx, asic3
   - Pass device information to child devices; iqs62x, intel-lpss-acpi
   - Individually identify IRQ domains; intel_soc_pmic_core
   - Remove superfluous code; dbx500-prcmu, exynos-lpass
   - Staticify and constify; arizona-i2c
   - Mark sometimes used data as __maybe_unused; atmel-flexcom
   - Account for different ACPI tables on AOSP/Windows platforms; arizona-spi
   - Use provided (platform) APIs; ab8500-core
   - Trivial (whitespace, spelling); rohm-bd9576

----------------------------------------------------------------
Alistair Francis (5):
      dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
      mfd: simple-mfd-i2c: Add a Kconfig name
      mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
      regulator: sy7636a: Remove requirement on sy7636a mfd
      hwmon: sy7636a: Add temperature driver for sy7636a

Andy Shevchenko (1):
      mfd: intel-lpss: Provide an SSP type to the driver

Charles Keepax (1):
      mfd: arizona: Add missing statics to the of_match_tables

Claudiu Beznea (1):
      mfd: atmel-flexcom: Fix compilation warning

Hans de Goede (5):
      mfd: intel_soc_pmic_crc: Sort cells by IRQ order
      mfd: intel_soc_pmic_crc: Add crystal_cove_charger cell to BYT cells
      mfd: intel_soc_pmic_crc: Set main IRQ domain bus token to DOMAIN_BUS_NEXUS
      mfd: arizona-spi: Split Windows ACPI init code into its own function
      mfd: arizona-spi: Add Android board ACPI table handling

Jarkko Nikula (1):
      mfd: intel-lpss: Add Intel Raptor Lake PCH-S PCI IDs

Jeff LaBundy (2):
      mfd: iqs62x: Provide device revision to sub-devices
      iio: temperature: iqs620at-temp: Add support for V3 silicon

Jiasheng Jiang (1):
      mfd: mc13xxx: Add check for mc13xxx_irq_request

Johnson Wang (2):
      mfd: Add support for the MediaTek MT6366 PMIC
      dt-bindings: mfd: Add compatible for the MediaTek MT6366 PMIC

Julia Lawall (2):
      mfd: sta2x11: Use GFP_KERNEL instead of GFP_ATOMIC
      mfd: bd9576: fix typos in comments

Krzysztof Kozlowski (19):
      dt-bindings: leds: maxim,max77693: Convert to dtschema
      dt-bindings: power: supply: maxim,max77693: Convert to dtschema
      regulator: dt-bindings: maxim,max77693: Convert to dtschema
      dt-bindings: mfd: maxim,max77693: Convert to dtschema
      dt-bindings: extcon: maxim,max77843: Add MAX77843 bindings
      regulator: dt-bindings: maxim,max77843: Add MAX77843 bindings
      dt-bindings: mfd: maxim,max77843: Add MAX77843 bindings
      MAINTAINERS: mfd: Cover MAX77843 by Maxim PMIC/MUIC for Exynos boards entry
      spi: dt-bindings: samsung: Convert to dtschema
      mfd: dt-bindings: google,cros-ec: Reference Samsung SPI bindings
      mfd: dt-bindings: google,cros-ec: Fix indentation in example
      spi: s3c64xx: Allow controller-data to be optional
      dt-bindings: power: supply: maxim,max14577: Convert to dtschema
      regulator: dt-bindings: maxim,max14577: Convert to dtschema
      dt-bindings: mfd: maxim,max14577: Convert to dtschema
      regulator: dt-bindings: maxim,max77802: Convert to dtschema
      dt-bindings: mfd: maxim,max77802: Convert to dtschema
      mfd: exynos-lpass: Drop unneeded syscon.h include
      dt-bindings: mfd: samsung,exynos5433-lpass: Convert to dtschema

Lee Jones (2):
      Merge branches 'ib-mfd-hwmon-regulator-5.18', 'ib-mfd-iio-5.18', 'ib-mfd-led-power-regulator-5.18', 'ib-mfd-mediatek-mt6366-5.18', 'ib-mfd-rtc-watchdog-5.18' and 'ib-mfd-spi-dt-5.18' into ibs-for-mfd-merged
      hwmon: sy7636a: Fix trivial 'underline too short' warning

Linus Walleij (2):
      mfd: ab8500: Rewrite bindings in YAML
      mfd: ab8500: Drop debugfs module

Luca Ceresoli (8):
      rtc: max77686: Convert comments to kernel-doc format
      rtc: max77686: Rename day-of-month defines
      rtc: max77686: Remove unused code to read in 12-hour mode
      dt-bindings: mfd: Add Maxim MAX77714 PMIC
      mfd: max77714: Add driver for Maxim MAX77714 PMIC
      watchdog: max77620: Add support for the max77714 variant
      watchdog: max77620: Add comment to clarify set_timeout procedure
      rtc: max77686: Add MAX77714 support

Luca Weiss (2):
      dt-bindings: mfd: qcom,tcsr: Document msm8953 compatible
      mfd: qcom-spmi-pmic: Add pm8953 compatible

Lukas Bulwahn (2):
      mfd: db8500-prcmu: Remove dead code for a non-existing config
      MAINTAINERS: Rectify entry for ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS

Miaoqian Lin (1):
      mfd: asic3: Add missing iounmap() on error asic3_mfd_probe

Michael Walle (1):
      dt-bindings: mfd: syscon: Add microchip,lan966x-cpu-syscon compatible

Minghao Chi (CGEL ZTE) (1):
      mfd: Use platform_get_irq() to get the interrupt

Peter Geis (1):
      mfd: rk808: Add reboot support to rk808.c

Rafał Miłecki (1):
      dt-bindings: mfd: brcm,cru: Rename pinctrl node

Rob Herring (1):
      dt-bindings: Add compatibles for undocumented trivial syscons

Uwe Kleine-König (1):
      mfd: stmfx: Improve error message triggered by regulator fault in .remove()

YueHaibing (1):
      mfd: db8500-prcmu: Remove unused inline function

 .../devicetree/bindings/extcon/maxim,max77843.yaml |   40 +
 .../devicetree/bindings/leds/maxim,max77693.yaml   |  105 +
 Documentation/devicetree/bindings/mfd/ab8500.txt   |  282 ---
 .../devicetree/bindings/mfd/brcm,cru.yaml          |    4 +-
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |   31 +-
 Documentation/devicetree/bindings/mfd/max14577.txt |  147 --
 Documentation/devicetree/bindings/mfd/max77693.txt |  194 --
 Documentation/devicetree/bindings/mfd/max77802.txt |   25 -
 .../devicetree/bindings/mfd/maxim,max14577.yaml    |  195 ++
 .../devicetree/bindings/mfd/maxim,max77693.yaml    |  143 ++
 .../devicetree/bindings/mfd/maxim,max77714.yaml    |   68 +
 .../devicetree/bindings/mfd/maxim,max77802.yaml    |  194 ++
 .../devicetree/bindings/mfd/maxim,max77843.yaml    |  144 ++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |    2 +-
 .../devicetree/bindings/mfd/qcom,spmi-pmic.txt     |    1 +
 .../devicetree/bindings/mfd/qcom,tcsr.txt          |    1 +
 .../bindings/mfd/samsung,exynos5433-lpass.txt      |   72 -
 .../bindings/mfd/samsung,exynos5433-lpass.yaml     |  117 ++
 .../devicetree/bindings/mfd/silergy,sy7636a.yaml   |   82 +
 .../devicetree/bindings/mfd/stericsson,ab8500.yaml |  500 +++++
 .../bindings/mfd/stericsson,db8500-prcmu.yaml      |    1 +
 Documentation/devicetree/bindings/mfd/syscon.yaml  |    5 +
 .../bindings/power/supply/maxim,max14577.yaml      |   84 +
 .../bindings/power/supply/maxim,max77693.yaml      |   70 +
 .../devicetree/bindings/regulator/max77802.txt     |  111 --
 .../bindings/regulator/maxim,max14577.yaml         |   78 +
 .../bindings/regulator/maxim,max77693.yaml         |   60 +
 .../bindings/regulator/maxim,max77802.yaml         |   85 +
 .../bindings/regulator/maxim,max77843.yaml         |   65 +
 .../bindings/soc/samsung/exynos-usi.yaml           |    2 +-
 .../bindings/spi/samsung,spi-peripheral-props.yaml |   33 +
 .../devicetree/bindings/spi/samsung,spi.yaml       |  187 ++
 .../bindings/spi/spi-peripheral-props.yaml         |    1 +
 .../devicetree/bindings/spi/spi-samsung.txt        |  122 --
 Documentation/hwmon/index.rst                      |    1 +
 Documentation/hwmon/sy7636a-hwmon.rst              |   26 +
 MAINTAINERS                                        |   20 +-
 drivers/hwmon/Kconfig                              |    9 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/sy7636a-hwmon.c                      |  106 +
 drivers/iio/temperature/iqs620at-temp.c            |    4 +-
 drivers/mfd/Kconfig                                |   24 +-
 drivers/mfd/Makefile                               |    2 +-
 drivers/mfd/ab8500-core.c                          |   32 +-
 drivers/mfd/ab8500-debugfs.c                       | 2096 --------------------
 drivers/mfd/arizona-i2c.c                          |    2 +-
 drivers/mfd/arizona-spi.c                          |   87 +-
 drivers/mfd/asic3.c                                |   10 +-
 drivers/mfd/atmel-flexcom.c                        |    2 +-
 drivers/mfd/exynos-lpass.c                         |    1 -
 drivers/mfd/intel-lpss-acpi.c                      |   41 +-
 drivers/mfd/intel-lpss-pci.c                       |   15 +
 drivers/mfd/intel_soc_pmic_core.c                  |    4 +
 drivers/mfd/intel_soc_pmic_crc.c                   |   35 +-
 drivers/mfd/iqs62x.c                               |    6 +-
 drivers/mfd/max77686.c                             |    2 +-
 drivers/mfd/max77714.c                             |  152 ++
 drivers/mfd/mc13xxx-core.c                         |    4 +-
 drivers/mfd/mt6358-irq.c                           |    1 +
 drivers/mfd/rk808.c                                |   44 +
 drivers/mfd/rohm-bd9576.c                          |    2 +-
 drivers/mfd/simple-mfd-i2c.c                       |   11 +
 drivers/mfd/sta2x11-mfd.c                          |    2 +-
 drivers/mfd/stmfx.c                                |   17 +-
 drivers/regulator/Kconfig                          |    1 -
 drivers/regulator/sy7636a-regulator.c              |    7 +-
 drivers/rtc/Kconfig                                |    2 +-
 drivers/rtc/rtc-max77686.c                         |   75 +-
 drivers/spi/spi-s3c64xx.c                          |   14 +-
 drivers/watchdog/Kconfig                           |    2 +-
 drivers/watchdog/max77620_wdt.c                    |   85 +-
 include/linux/mfd/dbx500-prcmu.h                   |   22 -
 include/linux/mfd/iqs62x.h                         |    7 +
 include/linux/mfd/max77686-private.h               |    4 +-
 include/linux/mfd/max77714.h                       |   60 +
 include/linux/mfd/mt6358/registers.h               |    7 +
 include/linux/mfd/mt6397/core.h                    |    1 +
 include/linux/mfd/rk808.h                          |    1 +
 include/linux/mfd/sy7636a.h                        |   34 +
 79 files changed, 3085 insertions(+), 3247 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/ab8500.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77693.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77802.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77843.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
 create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c
 delete mode 100644 drivers/mfd/ab8500-debugfs.c
 create mode 100644 drivers/mfd/max77714.c
 create mode 100644 include/linux/mfd/max77714.h
 create mode 100644 include/linux/mfd/sy7636a.h

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
