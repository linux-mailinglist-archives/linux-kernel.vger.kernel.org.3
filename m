Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC515333A0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiEXWoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiEXWoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:44:09 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DC5562DE;
        Tue, 24 May 2022 15:44:07 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id w130so23201844oig.0;
        Tue, 24 May 2022 15:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=gICizJUaDiQeZV+zsjLP+V4K5ZcQ43O6FUAnXkGMQg8=;
        b=TlqbN6N61pWIfbob1jZzASrD2i34w63UqD28KGaEjyyLk6SBd7orCqTmxDSzkiaiOA
         s1WL7M5Z/2P16D6wGgc6MkVHBzP5qiarg4kbGJQyQevREkkOinG+0QF6gn2qSHxZFiOg
         9gltWFiHqYQBZiwL6wkW1G6j432TH6KS3lFY4Uf5jkq4lzvdJxSBrbiN1HlOj4aj8nwV
         dwnikrESmGtNassGwYnUUPXzoSUCGAa9cC2BcvagtEMrfnQxj1qHtBTvIbWUPmxXK+Z4
         9N8iccuRNi3axtQfjToaiDt5eU3yrkwg3Toz2YpjwyRMvK38u42yoWnQ+iGweHF7TZI1
         mJfw==
X-Gm-Message-State: AOAM533FQRMSkUWd79JT82Ivbtb6vP+5jgGBiS1PA7l5RQhksXDMclN0
        HXBnjSvouLVIuzVaCXaAsA==
X-Google-Smtp-Source: ABdhPJxjHfFNez0NHPtcsLZvmOOeGvLLHo6KFv7FhxAoR3Cx7XKzeBInKqZD5Dbl9Nbe0uMQrV8EnQ==
X-Received: by 2002:aca:ea02:0:b0:326:b521:1fbd with SMTP id i2-20020acaea02000000b00326b5211fbdmr3493689oih.26.1653432246081;
        Tue, 24 May 2022 15:44:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l8-20020a056830238800b006060322125dsm5638535ots.45.2022.05.24.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 15:44:05 -0700 (PDT)
Received: (nullmailer pid 380560 invoked by uid 1000);
        Tue, 24 May 2022 22:44:04 -0000
Date:   Tue, 24 May 2022 17:44:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v5.19
Message-ID: <20220524224404.GA373873-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for v5.19.

Rob


The following changes since commit 5dc4630426511f641b7ac44fc550b8e21eafb237:

  dt-bindings: pci: apple,pcie: Drop max-link-speed from example (2022-05-04 17:18:27 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.19

for you to fetch changes up to d036d915b61f23b9e80d93f8a606eebf3bfab73f:

  of/irq: fix typo in comment (2022-05-23 16:37:01 -0500)

----------------------------------------------------------------
Devicetree updates for v5.19:

Bindings:
- Convert smsc,lan91c111, qcom,spi-qup, qcom,msm-uartdm, qcom,i2c-qup,
  qcom,gsbi, i2c-mt65xx, TI wkup_m3_ipc (and new props), qcom,smp2p, TI
  timer, Mediatek gnss, Mediatek topckgen, Mediatek apmixedsys, Mediatek
  infracfg, fsl,ls-extirq, fsl,layerscape-dcfg, QCom PMIC SPMI,
  rda,8810pl-timer, Xilinx zynqmp_ipi, uniphier-pcie, and Ilitek
  touchscreen controllers

- Convert various Arm Ltd peripheral IP bindings to schemas

- New bindings for Menlo board CPLD, DH electronics board CPLD,
  Qualcomm Geni based QUP I2C, Renesas RZ/G2UL OSTM, Broafcom BCM4751
  GNSS, MT6360 PMIC, ASIX USB Ethernet controllers, and Microchip/SMSC
  LAN95xx USB Ethernet controllers

- Add vendor prefix for Enclustra

- Add various compatible string additions

- Various example fixes and cleanups

- Remove unused hisilicon,hi6220-reset binding

- Treewide fix properties missing type definition

- Drop some empty and unreferenced .txt bindings

- Documentation improvements for writing schemas

DT driver core:
- Drop static IRQ resources for DT platform devices as IRQ setup is
  dynamic and drivers have all been converted to use platform_get_irq()
  and friends

- Rework memory allocations and frees for overlays

- Continue overlay notifier callbacks on successful calls and add
  unittests

- Handle 'interrupts-extended' in early DT IRQ setup

- Fix of_property_read_string() errors to match documentation

- Ignore disabled nodes in FDT API calls

----------------------------------------------------------------
Andre Przywara (12):
      dt-bindings: iommu: arm,smmu-v3: make PRI IRQ optional
      dt-bindings: arm: spe-pmu: convert to DT schema
      dt-bindings: arm: sp810: convert to DT schema
      dt-bindings: sound: add Arm PL041 AACI DT schema
      dt-bindings: serio: add Arm PL050 DT schema
      dt-bindings: arm: convert vexpress-sysregs to DT schema
      dt-bindings: arm: convert vexpress-config to DT schema
      dt-bindings: display: convert PL110/PL111 to DT schema
      dt-bindings: display: convert Arm HDLCD to DT schema
      dt-bindings: display: convert Arm Mali-DP to DT schema
      dt-bindings: display: convert Arm Komeda to DT schema
      of/fdt: Ignore disabled memory nodes

AngeloGioacchino Del Regno (1):
      dt-bindings: i2c: convert i2c-mt65xx to json-schema

Biju Das (2):
      dt-bindings: i2c: renesas,riic: Document RZ/G2UL SoC
      dt-bindings: timer: renesas: ostm: Document Renesas RZ/G2UL OSTM

Bryan O'Donoghue (1):
      dt-bindings: soc: qcom: smd-rpm: Fix missing MSM8936 compatible

Dave Gerlach (1):
      dt-bindings: wkup-m3-ipc: Add firmware-name property

David Collins (1):
      dt-bindings: spmi: spmi-pmic-arb: make interrupt properties as optional

David Heidelberg (3):
      dt-bindings: spmi: convert QCOM PMIC SPMI bindings to yaml
      dt-bindings: mailbox: qcom-ipcc: add missing compatible for SM8450
      dt-bindings: mailbox: qcom-ipcc: add missing properties into example

Drew Fustini (3):
      dt-bindings: soc: ti: wkup_m3_ipc: convert bindings to json-schema
      dt-bindings: wkup-m3-ipc: Add vtt toggle gpio pin property
      dt-bindings: wkup-m3-ipc: Add ti,set-io-isolation property

Frank Rowand (5):
      of: overlay: rename variables to be consistent
      of: overlay: rework overlay apply and remove kfree()s
      of: overlay: add entry to of_overlay_action_name[]
      of: overlay: unittest: add tests for overlay notifiers
      of: overlay: do not free changeset when of_overlay_apply returns error

Geert Uytterhoeven (1):
      dt-bindings: input: touchscreen: ilitek_ts_i2c: Absorb ili2xxx bindings

Gene Chen (2):
      dt-bindings: mfd: mediatek: Add bindings for MT6360 PMIC
      dt-bindings: mfd: Add bindings child nodes for the Mediatek MT6360

Julia Lawall (1):
      of/irq: fix typo in comment

Ken Kurematsu (1):
      dt-bindings: arm: fix typos in compatible

Krzysztof Kozlowski (18):
      dt-bindings: white-space cleanups
      dt-bindings: net: qcom,ipa: finish the qcom,smp2p example
      docs: dt: writing-bindings: describe typical cases
      docs: dt: writing-schema: mention coding style
      dt-bindings: qcom: update maintainers (drop Akash and Mukesh)
      spi: dt-bindings: qcom,spi-qup: convert to dtschema
      dt-bindings: serial: qcom,msm-uartdm: convert to dtschema
      dt-bindings: i2c: qcom,i2c-qup: convert to dtschema
      dt-bindings: qcom: qcom,gsbi: convert to dtschema
      dt-bindings: vendor-prefixes: add Enclustra
      dt-bindings: align SPI NOR node name with dtschema
      dt-bindings: power: renesas,rcar-sysc: drop useless consumer example
      dt-bindings: power: renesas,rcar-sysc: correct typo in path
      dt-bindings: soc: qcom,smp2p: convert to dtschema
      docs: dt: writing-schema: mention yamllint
      dt-bindings: timer: cdns,ttc: drop unneeded minItems
      dt-bindings: timer: samsung,exynos4210-mct: drop unneeded minItems
      dt-bindings: timer: samsung,exynos4210-mct: define strict clock order

Kuldeep Singh (1):
      dt-bindings: I2C: Add Qualcomm Geni based QUP I2C bindings

Kunihiko Hayashi (1):
      dt-bindings: PCI: uniphier: Convert uniphier-pcie.txt to json-schema

Lad Prabhakar (1):
      of/platform: Drop static setup of IRQ resource from DT core

Linus Walleij (2):
      dt-bindings: gnss: Rewrite Mediatek bindings in YAML
      dt-bindings: gnss: Add Broacom BCM4751 family bindings

Luca Weiss (2):
      dt-bindings: qcom,pdc: Add SM6350 compatible
      dt-bindings: thermal: tsens: Add SM6350 compatible

Marek Vasut (4):
      dt-bindings: trivial-devices: Document CPLD on DH electronics boards
      dt-bindings: trivial-devices: Document CPLD on Menlo boards
      dt-bindings: nvmem: snvs-lpgpr: Add i.MX8M compatible strings
      dt-bindings: rcc: Add optional external ethernet RX clock properties

Michael Walle (3):
      dt-bindings: fsl: convert fsl,layerscape-dcfg to YAML
      dt-bindings: interrupt-controller: fsl,ls-extirq: convert to YAML
      dt-bindings: fsl: convert fsl,layerscape-scfg to YAML

Nuno Sá (1):
      of: overlay: do not break notify on NOTIFY_{OK|STOP}

Oleksij Rempel (3):
      dt-bindings: net: add schema for ASIX USB Ethernet controllers
      dt-bindings: net: add schema for Microchip/SMSC LAN95xx USB Ethernet controllers
      dt-bindings: usb: ci-hdrc-usb2: fix node node for ethernet controller

Philipp Zabel (1):
      dt-bindings: reset: Drop the hisilicon,hi6220-reset binding

Rob Herring (7):
      Merge branch 'dt/linus' into dt/next
      dt-bindings: Drop empty and unreferenced binding .txt files
      dt-bindings: eeprom/at24: Add samsung,s524ad0xd1 compatible
      Revert "dt-bindings: rcc: Add optional external ethernet RX clock properties"
      Merge branch 'dt/linus' into dt/next
      Revert "dt-bindings: mailbox: qcom-ipcc: add missing properties into example"
      dt-bindings: Fix properties without any type

Rui Miguel Silva (1):
      dt-bindings: net: smsc,lan91c111 convert to schema

Samuel Holland (1):
      of/irq: Use interrupts-extended to find parent

Shubhrajyoti Datta (1):
      dt-bindings: mailbox: zynqmp_ipi: convert to yaml

Stanislav Jakubek (1):
      dt-bindings: timer: Convert rda,8810pl-timer to YAML

Stefano Stabellini (1):
      of: of_property_read_string return -ENODATA when !length

Tony Lindgren (2):
      dt-bindings: timer: Update TI timer to yaml
      dt-bindings: timer: Add compatible for am6 for TI timer-dm

Yassine Oudjana (3):
      dt-bindings: arm: mediatek: topckgen: Convert to DT schema
      dt-bindings: arm: mediatek: apmixedsys: Convert to DT schema
      dt-bindings: arm: mediatek: infracfg: Convert to DT schema

 .../devicetree/bindings/arm/bcm/brcm,bcm63138.txt  |   2 +-
 .../bindings/arm/freescale/fsl,layerscape-dcfg.txt |  19 --
 .../bindings/arm/freescale/fsl,layerscape-scfg.txt |  19 --
 .../hisilicon/controller/hip04-bootwrapper.yaml    |   5 +-
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  35 ---
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |  42 ---
 .../bindings/arm/mediatek/mediatek,infracfg.yaml   |  81 +++++
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |  35 ---
 Documentation/devicetree/bindings/arm/sp810.txt    |  46 ---
 Documentation/devicetree/bindings/arm/sp810.yaml   |  80 +++++
 Documentation/devicetree/bindings/arm/spe-pmu.txt  |  20 --
 .../devicetree/bindings/arm/vexpress-config.yaml   | 285 +++++++++++++++++
 .../devicetree/bindings/arm/vexpress-sysreg.txt    | 103 -------
 .../devicetree/bindings/arm/vexpress-sysreg.yaml   |  90 ++++++
 .../bindings/clock/mediatek,apmixedsys.yaml        |  61 ++++
 .../bindings/clock/mediatek,topckgen.yaml          |  61 ++++
 .../clock/samsung,exynos4412-isp-clock.yaml        |   1 -
 .../bindings/crypto/allwinner,sun8i-ce.yaml        |   1 -
 .../bindings/display/amlogic,meson-dw-hdmi.yaml    |   1 -
 .../devicetree/bindings/display/arm,hdlcd.txt      |  79 -----
 .../devicetree/bindings/display/arm,hdlcd.yaml     |  89 ++++++
 .../devicetree/bindings/display/arm,komeda.txt     |  78 -----
 .../devicetree/bindings/display/arm,komeda.yaml    | 130 ++++++++
 .../devicetree/bindings/display/arm,malidp.txt     |  68 -----
 .../devicetree/bindings/display/arm,malidp.yaml    | 124 ++++++++
 .../devicetree/bindings/display/arm,pl11x.txt      | 110 -------
 .../devicetree/bindings/display/arm,pl11x.yaml     | 183 +++++++++++
 .../display/bridge/google,cros-ec-anx7688.yaml     |   1 -
 .../devicetree/bindings/display/bridge/ps8640.yaml |   1 -
 .../bindings/display/bridge/toshiba,tc358768.yaml  |   1 +
 .../bindings/display/imx/nxp,imx8mq-dcss.yaml      |   1 -
 .../bindings/display/mediatek/mediatek,merge.yaml  |   1 -
 .../bindings/display/panel/ilitek,ili9341.yaml     |   1 -
 .../bindings/display/panel/orisetech,otm8009a.yaml |   1 -
 .../bindings/display/panel/panel-timing.yaml       |   5 +
 .../bindings/display/panel/raydium,rm67191.yaml    |   1 +
 .../bindings/display/panel/samsung,s6e8aa0.yaml    |   1 +
 .../display/sprd/sprd,display-subsystem.yaml       |   1 -
 .../devicetree/bindings/display/st,stm32-ltdc.yaml |   1 -
 .../devicetree/bindings/dma/st,stm32-dmamux.yaml   |   1 -
 .../devicetree/bindings/dma/st,stm32-mdma.yaml     |   1 -
 Documentation/devicetree/bindings/eeprom/at24.txt  |   1 -
 Documentation/devicetree/bindings/eeprom/at24.yaml |   4 +-
 .../devicetree/bindings/example-schema.yaml        |  14 +-
 .../devicetree/bindings/gnss/brcm,bcm4751.yaml     |  69 +++++
 .../devicetree/bindings/gnss/mediatek.txt          |  35 ---
 .../devicetree/bindings/gnss/mediatek.yaml         |  59 ++++
 .../bindings/gpio/fairchild,74hc595.yaml           |   1 +
 .../devicetree/bindings/gpu/samsung-rotator.yaml   |   1 -
 .../devicetree/bindings/hwmon/adt7475.yaml         |   1 -
 .../devicetree/bindings/i2c/i2c-gate.yaml          |   1 -
 .../devicetree/bindings/i2c/i2c-mt65xx.txt         |  53 ----
 .../devicetree/bindings/i2c/i2c-mt65xx.yaml        | 118 +++++++
 .../devicetree/bindings/i2c/i2c-mux-gpmux.yaml     |   1 -
 .../bindings/i2c/qcom,i2c-geni-qcom.yaml           | 100 ++++++
 .../devicetree/bindings/i2c/qcom,i2c-qup.txt       |  40 ---
 .../devicetree/bindings/i2c/qcom,i2c-qup.yaml      |  89 ++++++
 .../devicetree/bindings/i2c/renesas,riic.yaml      |   2 +
 .../bindings/i2c/samsung,s3c2410-i2c.yaml          |   2 +-
 .../devicetree/bindings/iio/adc/adi,ad7291.yaml    |   1 -
 .../devicetree/bindings/iio/dac/lltc,ltc1660.yaml  |   2 +-
 .../bindings/input/google,cros-ec-keyb.yaml        |   1 +
 .../devicetree/bindings/input/ilitek,ili2xxx.txt   |  27 --
 .../bindings/input/touchscreen/ilitek_ts_i2c.yaml  |   7 +-
 .../interrupt-controller/fsl,ls-extirq.txt         |  53 ----
 .../interrupt-controller/fsl,ls-extirq.yaml        | 118 +++++++
 .../bindings/interrupt-controller/qcom,pdc.txt     |   5 +-
 .../devicetree/bindings/iommu/arm,smmu-v3.yaml     |  16 +-
 .../devicetree/bindings/iommu/samsung,sysmmu.yaml  |   1 -
 .../bindings/leds/backlight/qcom-wled.yaml         |   2 +-
 .../devicetree/bindings/leds/leds-mt6360.yaml      |   2 +-
 .../bindings/mailbox/amlogic,meson-gxbb-mhu.yaml   |   1 -
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |   1 +
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 127 --------
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml  | 140 +++++++++
 .../devicetree/bindings/media/i2c/adv7604.yaml     |   3 +-
 .../devicetree/bindings/media/microchip,xisc.yaml  |   1 -
 .../devicetree/bindings/mfd/mediatek,mt6360.yaml   | 256 ++++++++++++++++
 .../devicetree/bindings/mfd/qcom,spmi-pmic.txt     |   2 +-
 Documentation/devicetree/bindings/mtd/common.txt   |   1 -
 .../bindings/mtd/hisilicon,fmc-spi-nor.txt         |   2 +-
 Documentation/devicetree/bindings/mux/reg-mux.yaml |   8 +-
 .../devicetree/bindings/net/asix,ax88178.yaml      |  68 +++++
 .../devicetree/bindings/net/cdns,macb.yaml         |   1 +
 .../devicetree/bindings/net/ingenic,mac.yaml       |   1 +
 .../devicetree/bindings/net/microchip,lan95xx.yaml |  63 ++++
 .../devicetree/bindings/net/qcom,ipa.yaml          |   7 +
 .../devicetree/bindings/net/smsc,lan91c111.yaml    |  61 ++++
 .../devicetree/bindings/net/smsc-lan91c111.txt     |  17 --
 .../devicetree/bindings/net/ti,davinci-mdio.yaml   |   1 +
 .../devicetree/bindings/net/ti,k3-am654-cpts.yaml  |   1 -
 .../bindings/net/wireless/qcom,ath11k.yaml         |   2 +-
 .../bindings/net/wireless/ti,wlcore.yaml           |   2 +
 .../devicetree/bindings/nvmem/snvs-lpgpr.yaml      |   4 +
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml   |   6 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   2 +
 .../bindings/pci/socionext,uniphier-pcie.yaml      |  96 ++++++
 .../devicetree/bindings/pci/uniphier-pcie.txt      |  82 -----
 .../devicetree/bindings/perf/spe-pmu.yaml          |  40 +++
 .../bindings/pinctrl/canaan,k210-fpioa.yaml        |   2 +
 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |   1 -
 .../devicetree/bindings/power/avs/qcom,cpr.yaml    |   1 +
 .../bindings/power/renesas,rcar-sysc.yaml          |  15 +-
 .../devicetree/bindings/power/supply/battery.yaml  |   7 +-
 .../bindings/power/supply/charger-manager.yaml     |   1 +
 .../bindings/power/supply/cw2015_battery.yaml      |   1 -
 .../bindings/power/supply/power-supply.yaml        |   1 -
 .../bindings/power/supply/ti,lp8727.yaml           |   1 -
 .../bindings/power/supply/tps65217-charger.yaml    |   2 +-
 .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |   2 +-
 .../regulator/socionext,uniphier-regulator.yaml    |   1 -
 .../bindings/regulator/st,stm32-vrefbuf.yaml       |   1 -
 .../bindings/reserved-memory/ramoops.yaml          |   1 -
 .../bindings/reset/hisilicon,hi6220-reset.txt      |  37 ---
 .../devicetree/bindings/reset/microchip,rst.yaml   |   1 -
 .../devicetree/bindings/rng/intel,ixp46x-rng.yaml  |   1 -
 .../devicetree/bindings/rng/st,stm32-rng.yaml      |   1 +
 Documentation/devicetree/bindings/rtc/rtc.txt      |   1 -
 Documentation/devicetree/bindings/serial/8250.yaml |   1 +
 .../devicetree/bindings/serial/qcom,msm-uartdm.txt |  81 -----
 .../bindings/serial/qcom,msm-uartdm.yaml           | 112 +++++++
 .../devicetree/bindings/serial/sprd-uart.yaml      |   2 +-
 .../devicetree/bindings/serio/arm,pl050.yaml       |  67 ++++
 .../bindings/soc/amlogic/amlogic,canvas.yaml       |   1 -
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml      |  68 +++++
 .../bindings/soc/fsl/fsl,layerscape-scfg.yaml      |  58 ++++
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml |   3 +-
 .../devicetree/bindings/soc/qcom/qcom,gsbi.txt     |  87 ------
 .../devicetree/bindings/soc/qcom/qcom,gsbi.yaml    | 132 ++++++++
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   1 +
 .../devicetree/bindings/soc/qcom/qcom,smp2p.txt    | 110 -------
 .../devicetree/bindings/soc/qcom/qcom,smp2p.yaml   | 145 +++++++++
 .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml    | 175 +++++++++++
 .../devicetree/bindings/soc/ti/wkup_m3_ipc.txt     |  57 ----
 .../devicetree/bindings/sound/adi,adau1372.yaml    |   1 -
 .../bindings/sound/amlogic,gx-sound-card.yaml      |   1 -
 .../devicetree/bindings/sound/arm,pl041.yaml       |  62 ++++
 .../bindings/sound/audio-graph-card2.yaml          |   3 +
 .../devicetree/bindings/sound/imx-audio-hdmi.yaml  |   3 +
 .../devicetree/bindings/sound/maxim,max98520.yaml  |   1 -
 .../devicetree/bindings/sound/mchp,spdifrx.yaml    |   2 +-
 .../devicetree/bindings/sound/mchp,spdiftx.yaml    |   2 +-
 .../bindings/sound/nvidia,tegra-audio-rt5640.yaml  |   1 -
 .../bindings/sound/samsung,aries-wm8994.yaml       |   1 -
 .../devicetree/bindings/sound/samsung,odroid.yaml  |   1 -
 .../devicetree/bindings/sound/tas2562.yaml         |   1 -
 .../devicetree/bindings/sound/tas2770.yaml         |   1 -
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |   1 -
 .../bindings/spi/amlogic,meson6-spifc.yaml         |   1 -
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |   3 +-
 .../devicetree/bindings/spi/qcom,spi-qup.txt       | 103 -------
 .../devicetree/bindings/spi/qcom,spi-qup.yaml      |  81 +++++
 .../devicetree/bindings/spi/renesas,hspi.yaml      |   1 -
 .../devicetree/bindings/spi/spi-davinci.txt        |   2 +-
 .../devicetree/bindings/spi/spi-pl022.yaml         |   2 +-
 .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  65 ----
 .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 117 +++++++
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 .../devicetree/bindings/timer/cdns,ttc.yaml        |   1 -
 .../devicetree/bindings/timer/rda,8810pl-timer.txt |  20 --
 .../bindings/timer/rda,8810pl-timer.yaml           |  47 +++
 .../devicetree/bindings/timer/renesas,ostm.yaml    |   2 +
 .../bindings/timer/samsung,exynos4210-mct.yaml     |   5 +-
 .../devicetree/bindings/timer/ti,timer-dm.yaml     | 152 +++++++++
 .../devicetree/bindings/timer/ti,timer.txt         |  44 ---
 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |   2 +-
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   4 +-
 .../bindings/usb/mediatek,mt6360-tcpc.yaml         |   5 +
 .../devicetree/bindings/usb/smsc,usb3503.yaml      |   3 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 .../devicetree/bindings/writing-bindings.rst       |  25 ++
 .../devicetree/bindings/writing-schema.rst         |   8 +
 Documentation/devicetree/overlay-notes.rst         |  30 +-
 MAINTAINERS                                        |   6 +-
 drivers/of/fdt.c                                   |   3 +
 drivers/of/irq.c                                   |  15 +-
 drivers/of/overlay.c                               | 339 ++++++++++-----------
 drivers/of/platform.c                              |  14 +-
 drivers/of/property.c                              |   5 +-
 drivers/of/unittest-data/Makefile                  |  10 +
 drivers/of/unittest-data/overlay_16.dts            |  15 +
 drivers/of/unittest-data/overlay_17.dts            |  15 +
 drivers/of/unittest-data/overlay_18.dts            |  15 +
 drivers/of/unittest-data/overlay_19.dts            |  15 +
 drivers/of/unittest-data/overlay_20.dts            |  15 +
 drivers/of/unittest.c                              | 201 ++++++++++++
 include/linux/of.h                                 |  16 +-
 188 files changed, 4364 insertions(+), 1997 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/sp810.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sp810.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-config.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/arm,hdlcd.txt
 create mode 100644 Documentation/devicetree/bindings/display/arm,hdlcd.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/arm,komeda.txt
 create mode 100644 Documentation/devicetree/bindings/display/arm,komeda.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/arm,malidp.txt
 create mode 100644 Documentation/devicetree/bindings/display/arm,malidp.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/arm,pl11x.txt
 create mode 100644 Documentation/devicetree/bindings/display/arm,pl11x.yaml
 delete mode 100644 Documentation/devicetree/bindings/eeprom/at24.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml
 delete mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/ilitek,ili2xxx.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/common.txt
 create mode 100644 Documentation/devicetree/bindings/net/asix,ax88178.yaml
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
 create mode 100644 Documentation/devicetree/bindings/net/smsc,lan91c111.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/smsc-lan91c111.txt
 create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/perf/spe-pmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc.txt
 delete mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
 create mode 100644 Documentation/devicetree/bindings/serio/arm,pl050.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
 create mode 100644 Documentation/devicetree/bindings/sound/arm,pl041.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
 delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
 create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/ti,timer-dm.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/ti,timer.txt
 create mode 100644 drivers/of/unittest-data/overlay_16.dts
 create mode 100644 drivers/of/unittest-data/overlay_17.dts
 create mode 100644 drivers/of/unittest-data/overlay_18.dts
 create mode 100644 drivers/of/unittest-data/overlay_19.dts
 create mode 100644 drivers/of/unittest-data/overlay_20.dts
