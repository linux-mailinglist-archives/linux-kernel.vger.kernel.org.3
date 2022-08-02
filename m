Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1958848A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiHBWtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiHBWtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:49:09 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEAB12601;
        Tue,  2 Aug 2022 15:49:07 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id l9so1131956ilq.1;
        Tue, 02 Aug 2022 15:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=83SX3G3GXScUYiAxDWt7vHUCfZO9exjn5F+MrxCqXB0=;
        b=A9o35uGTLnMzQCwOjlqycO5+PuYGot88hp7jeeXSV4zY7QYUbsn1XazCJMzIROHg6u
         kz3hJWEVtD8DcamG1L4yVce+mbY1W59ZXUVv39QThi2mSJOjVYjsDf7PCCZjh8NjHem3
         lSzuoJF62ucnl6KrGG28ydconvXaNm3QDe5MPb+2xUIpsM6BhdmGvaXSdk0XWlHPkHqp
         H1Tk+e2r3JNPKndJAlLPyeVsfrofCn/k8VfxHj7oEN6Kz34KpE2Omif3i27Hfgdkc7TW
         DDaP8nM55u1tRGdwpD3eJofZqAqBg4bECTnnw9xoBj6Qq6uM+HnMx3093k4JtANuxr/v
         JT1A==
X-Gm-Message-State: AJIora+eQb32TYOaetNd4ivCSe7yPjj2nrKnzs92tD3gLFYkDetAMJxO
        rYAoSF4a36Pv5j3kJBGmsbfHlEbhZw==
X-Google-Smtp-Source: AGRyM1tcIDuzJmhK5hGOex8hzt3p8cJfjNwGSaF0J1HNeYaw8ouAbZkwsJkT7mopfWRTTSkqv+pEcA==
X-Received: by 2002:a92:ca06:0:b0:2dc:fc55:83b7 with SMTP id j6-20020a92ca06000000b002dcfc5583b7mr9400085ils.139.1659480546531;
        Tue, 02 Aug 2022 15:49:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a15-20020a027a0f000000b0032e3b0933c6sm6973353jac.162.2022.08.02.15.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 15:49:05 -0700 (PDT)
Received: (nullmailer pid 799223 invoked by uid 1000);
        Tue, 02 Aug 2022 22:49:04 -0000
Date:   Tue, 2 Aug 2022 16:49:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.0
Message-ID: <20220802224904.GA796923-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates.

Rob


The following changes since commit 0b9431c8221cfe73d06f6b9cd37b813fa52be8ce:

  dt-bindings: display: arm,malidp: remove bogus RQOS property (2022-06-10 12:32:05 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.0

for you to fetch changes up to 7e7a24c3c6c98abc4425abd1dbf2a71b42dfafcf:

  dt-bindings: mtd: microchip,mchp48l640: use spi-peripheral-props.yaml (2022-08-02 11:08:27 -0600)

----------------------------------------------------------------
Devicetree updates for v6.0:

Bindings:
- Add spi-peripheral-props.yaml references to various SPI device
  bindings

- Convert qcom,pm8916-wdt, ds1307, Qualcomm BAM DMA, is31fl319x,
  skyworks,aat1290, Rockchip EMAC, gpio-ir-receiver, ahci-ceva, Arm CCN
  PMU, rda,8810pl-intc, sil,sii9022, ps2-gpio, and arm-firmware-suite
  bindings to DT schema format

- New bindings for Arm virtual platforms display, Qualcomm IMEM memory
  region, Samsung S5PV210 ChipID, EM Microelectronic EM3027 RTC, and
  arm,cortex-a78ae

- Add vendor prefixes for asrock, bytedance, hxt, ingrasys, inventec,
  quanta, and densitron

- Add missing MSI and IOMMU properties to host-generic-pci

- Remove bindings for removed EFM32 platform

- Remove old chosen.txt binding (replaced by schema)

- Treewide add missing type information for properties

- Treewide fixing of typos and its vs. it's in bindings. Its all good
  now.

- Drop unnecessary quoting in power related schemas

- Several LED binding updates which didn't get picked up

- Move various bindings to proper directories

DT core code:
- Convert unittest GPIO related tests to use fwnode

- Check ima-kexec-buffer against memory bounds

- Print reserved-memory allocation/reservation failures as errors

- Cleanup early_init_dt_reserve_memory_arch()

- Simplify of_overlay_fdt_apply() tail

----------------------------------------------------------------
Andy Shevchenko (2):
      of: unittest: Switch to use fwnode instead of of_node
      of: unittest: make unittest_gpio_remove() consistent with unittest_gpio_probe()

Chanho Park (1):
      dt-bindings: arm: cpus: add cortex-a78ae compatible

Clément Léger (1):
      of: constify of_property_check_flags() prop argument

Danilo Krummrich (2):
      dt-bindings: ps2-gpio: convert binding to json-schema
      dt-bindings: ps2-gpio: document bus signals open drain

Deming Wang (1):
      of: Drop duplicate 'the' in of_find_last_cache_level kerneldoc

Geert Uytterhoeven (3):
      dt-bindings: display: bridge: sil,sii9022: Convert to json-schema
      of: overlay: Move devicetree_corrupt() check up
      of: overlay: Simplify of_overlay_fdt_apply() tail

Jason A. Donenfeld (1):
      dt-bindings: chosen: remove old .txt binding

Johan Jonker (1):
      dt-bindings: net: convert emac_rockchip.txt to YAML

Krzysztof Kozlowski (19):
      dt-bindings: vendor-prefixes: document several vendors for Aspeed BMC boards
      dt-bindings: sram: qcom,ocmem: cleanup example coding style
      dt-bindings: sram: qcom,imem: add IMEM memory region
      dt-bindings: connector: usb: align example indentation to four-space
      dt-bindings: hwinfo: group Chip ID-like devices
      dt-bindings: hwinfo: samsung,s5pv210-chipid: add S5PV210 ChipID
      dt-bindings: bus: qcom,ssc-block-bus: rework arrays and drop redundant minItems
      dt-bindings: leds: lp50xx: correct reg/unit addresses in example
      dt-bindings: leds: fix indentation in examples
      dt-bindings: leds: skyworks,aat1290: convert to dtschema
      dt-bindings: power: reset: qcom,pon: use absolute path to other schema
      dt-bindings: watchdog: qcom,pm8916-wdt: convert to dtschema
      dt-bindings: display: use spi-peripheral-props.yaml
      dt-bindings: eeprom: at25: use spi-peripheral-props.yaml
      dt-bindings: eeprom: microchip,93lc46b: move to eeprom directory
      dt-bindings: power: drop quotes when not needed
      dt-bindings: power: reset: drop quotes when not needed
      dt-bindings: power: supply: drop quotes when not needed
      dt-bindings: mtd: microchip,mchp48l640: use spi-peripheral-props.yaml

Kuldeep Singh (1):
      dt-bindings: dma: Convert Qualcomm BAM DMA binding to json format

Liang He (1):
      of: device: Fix missing of_node_put() in of_dma_set_restricted_buffer

Marek Vasut (1):
      dt-bindings: vendor-prefixes: add Densitron

Marijn Suijten (1):
      dt-bindings: leds: qcom-lpg: Add compatible for PM660L LPG block

Michael Walle (1):
      dt-bindings: nfc: nxp,nci: drop Charles Gorand's mail

Paul Cercueil (1):
      docs: dt: writing-bindings: Update URL to DT schemas

Peter Collingbourne (1):
      of/fdt: Clean up early_init_dt_reserve_memory_arch()

Piyush Mehta (1):
      dt-bindings: ata: ahci-ceva: convert to yaml

Randy Dunlap (1):
      devicetree/bindings: correct possessive "its" typos

Rob Herring (15):
      dt-bindings: display: Add Arm virtual platforms display
      dt-bindings: perf: Convert Arm CCN to DT schema
      dt-bindings: vexpress-sysreg: Add deprecated GPIO provider properties
      dt-bindings: vexpress-sysreg: Allow for no child nodes
      media: dt-bindings: rc: Allow 'ir-receiver' node names
      media: dt-bindings: Convert gpio-ir-receiver to DT schema
      Merge branch 'dt/linus' into dt/next
      dt-bindings: watchdog: faraday: Fix typo in example 'timeout-sec' property
      dt-bindings: arm: nvidia,tegra20-pmc: Move fixed string property names under 'properties'
      dt-bindings: mtd/partitions: Convert arm-firmware-suite to DT schema
      dt-bindings: PCI: fsl,imx6q-pcie: Add missing type for 'reset-gpio-active-high'
      dt-bindings: panel: raydium,rm67191: Add missing type to 'video-mode'
      dt-bindings: power: supply: charger-manager: Add missing type for 'cm-battery-stat'
      dt-bindings: iio/dac: adi,ad5766: Add missing type to 'output-range-microvolts'
      dt-bindings: PCI: host-generic-pci: Allow IOMMU and MSI properties

Slark Xiao (1):
      dt-bindings: Fix typo in comment

Stanislav Jakubek (1):
      dt-bindings: interrupt-controller: Convert rda,8810pl-intc to YAML

Thierry Reding (2):
      dt-bindings: rtc: ds1307: Convert to json-schema
      dt-bindings: rtc: Add EM Microelectronic EM3027 bindings

Vaibhav Jain (1):
      of: check previous kernel's ima-kexec-buffer against memory bounds

Vincent Knecht (2):
      dt-bindings: leds: Convert is31fl319x to dtschema
      dt-bindings: leds: is31fl319x: Document variants specificities

Vincent Whitchurch (1):
      of: reserved-memory: Print allocation/reservation failures as error

Wolfram Sang (2):
      dt-bindings: hwmon: move ibm,p8-occ bindings to proper folder
      dt-bindings: efm32: remove bindings for deleted platform

Xu Qiang (1):
      of/fdt: declared return type does not match actual return type

 Documentation/devicetree/bindings/arm/cpus.yaml    |   1 +
 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |   2 +-
 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     |   2 +-
 .../devicetree/bindings/arm/vexpress-sysreg.yaml   |  10 +-
 .../devicetree/bindings/ata/ahci-ceva.txt          |  63 ------
 .../devicetree/bindings/ata/ceva,ahci-1v84.yaml    | 189 ++++++++++++++++++
 .../bindings/bus/qcom,ssc-block-bus.yaml           |  25 +--
 Documentation/devicetree/bindings/chosen.txt       | 137 -------------
 .../devicetree/bindings/clock/efm32-clock.txt      |  11 -
 .../devicetree/bindings/clock/st/st,flexgen.txt    |   2 +-
 .../devicetree/bindings/clock/ti/davinci/pll.txt   |   2 +-
 .../devicetree/bindings/clock/ti/dra7-atl.txt      |   2 +-
 .../bindings/connector/usb-connector.yaml          | 152 +++++++-------
 .../devicetree/bindings/display/arm,pl11x.yaml     |  15 +-
 .../devicetree/bindings/display/bridge/sii902x.txt |  78 --------
 .../bindings/display/bridge/sil,sii9022.yaml       | 131 ++++++++++++
 .../bindings/display/panel/arm,rtsm-display.yaml   |  27 +++
 .../bindings/display/panel/lg,lg4573.yaml          |   2 +-
 .../bindings/display/panel/raydium,rm67191.yaml    |   1 +
 .../bindings/display/sitronix,st7735r.yaml         |   1 +
 .../bindings/display/solomon,ssd1307fb.yaml        |   7 +-
 .../devicetree/bindings/dma/qcom,bam-dma.yaml      | 100 ++++++++++
 .../devicetree/bindings/dma/qcom_bam_dma.txt       |  52 -----
 Documentation/devicetree/bindings/eeprom/at25.yaml |   5 +-
 .../microchip,93lc46b.yaml}                        |  11 +-
 .../devicetree/bindings/fpga/fpga-region.txt       |   2 +-
 .../devicetree/bindings/gpio/gpio-pisosr.txt       |   2 +-
 .../samsung,exynos-chipid.yaml}                    |   2 +-
 .../bindings/hwinfo/samsung,s5pv210-chipid.yaml    |  30 +++
 .../k3-socinfo.yaml => hwinfo/ti,k3-socinfo.yaml}  |   2 +-
 .../devicetree/bindings/hwmon/adt7475.yaml         |   2 +-
 .../bindings/{i2c => hwmon}/ibm,p8-occ-hwmon.txt   |   0
 .../devicetree/bindings/i2c/i2c-efm32.txt          |  33 ---
 .../devicetree/bindings/iio/dac/adi,ad5766.yaml    |   2 +
 .../bindings/input/touchscreen/ektf2127.txt        |   2 +-
 .../interrupt-controller/rda,8810pl-intc.txt       |  61 ------
 .../interrupt-controller/rda,8810pl-intc.yaml      |  43 ++++
 .../devicetree/bindings/leds/issi,is31fl319x.yaml  | 193 ++++++++++++++++++
 .../devicetree/bindings/leds/leds-aat1290.txt      |  77 -------
 .../devicetree/bindings/leds/leds-is31fl319x.txt   |  61 ------
 .../devicetree/bindings/leds/leds-lp50xx.yaml      | 104 +++++-----
 .../devicetree/bindings/leds/leds-lp55xx.yaml      | 222 ++++++++++-----------
 .../bindings/leds/leds-pwm-multicolor.yaml         |  36 ++--
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |   1 +
 .../devicetree/bindings/leds/skyworks,aat1290.yaml |  95 +++++++++
 .../devicetree/bindings/media/gpio-ir-receiver.txt |  20 --
 .../bindings/media/gpio-ir-receiver.yaml           |  40 ++++
 Documentation/devicetree/bindings/media/rc.yaml    |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71815-pmic.yaml |   2 +-
 .../devicetree/bindings/mips/lantiq/rcu.txt        |   2 +-
 .../bindings/mtd/microchip,mchp48l640.yaml         |   7 +-
 .../mtd/partitions/arm,arm-firmware-suite.txt      |  17 --
 .../mtd/partitions/arm,arm-firmware-suite.yaml     |  28 +++
 .../devicetree/bindings/net/altera_tse.txt         |   2 +-
 Documentation/devicetree/bindings/net/cpsw.txt     |   2 +-
 .../devicetree/bindings/net/emac_rockchip.txt      |  52 -----
 .../devicetree/bindings/net/nfc/nxp,nci.yaml       |   1 -
 .../devicetree/bindings/net/qcom-emac.txt          |   2 +-
 .../devicetree/bindings/net/rockchip,emac.yaml     | 115 +++++++++++
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   1 +
 .../devicetree/bindings/pci/host-generic-pci.yaml  |   3 +
 .../devicetree/bindings/perf/arm,ccn.yaml          |  40 ++++
 Documentation/devicetree/bindings/perf/arm-ccn.txt |  23 ---
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml    |   2 +-
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |   2 +-
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |   2 +-
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |   2 +-
 .../bindings/power/amlogic,meson-ee-pwrc.yaml      |   6 +-
 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |   4 +-
 .../bindings/power/apple,pmgr-pwrstate.yaml        |   2 +-
 .../bindings/power/brcm,bcm63xx-power.yaml         |   4 +-
 .../devicetree/bindings/power/renesas,apmu.yaml    |   4 +-
 .../bindings/power/renesas,rcar-sysc.yaml          |   4 +-
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |   8 +-
 .../bindings/power/reset/regulator-poweroff.yaml   |   2 +-
 .../bindings/power/reset/xlnx,zynqmp-power.yaml    |   2 +-
 .../power/supply/active-semi,act8945a-charger.yaml |   4 +-
 .../devicetree/bindings/power/supply/bq2415x.yaml  |   4 +-
 .../devicetree/bindings/power/supply/bq24190.yaml  |   4 +-
 .../devicetree/bindings/power/supply/bq24257.yaml  |   4 +-
 .../devicetree/bindings/power/supply/bq24735.yaml  |   4 +-
 .../devicetree/bindings/power/supply/bq2515x.yaml  |   4 +-
 .../devicetree/bindings/power/supply/bq256xx.yaml  |   4 +-
 .../devicetree/bindings/power/supply/bq25890.yaml  |   4 +-
 .../devicetree/bindings/power/supply/bq25980.yaml  |   4 +-
 .../devicetree/bindings/power/supply/bq27xxx.yaml  |   4 +-
 .../bindings/power/supply/charger-manager.yaml     |   1 +
 .../bindings/power/supply/cpcap-battery.yaml       |   4 +-
 .../bindings/power/supply/cpcap-charger.yaml       |   4 +-
 .../bindings/power/supply/dlg,da9150-charger.yaml  |   4 +-
 .../power/supply/dlg,da9150-fuel-gauge.yaml        |   4 +-
 .../bindings/power/supply/ingenic,battery.yaml     |   4 +-
 .../devicetree/bindings/power/supply/isp1704.yaml  |   4 +-
 .../bindings/power/supply/lego,ev3-battery.yaml    |   4 +-
 .../bindings/power/supply/lltc,lt3651-charger.yaml |   4 +-
 .../bindings/power/supply/lltc,ltc294x.yaml        |   4 +-
 .../bindings/power/supply/ltc4162-l.yaml           |   4 +-
 .../bindings/power/supply/maxim,ds2760.yaml        |   4 +-
 .../bindings/power/supply/maxim,max14656.yaml      |   4 +-
 .../bindings/power/supply/maxim,max17040.yaml      |   4 +-
 .../bindings/power/supply/maxim,max17042.yaml      |   4 +-
 .../bindings/power/supply/maxim,max8903.yaml       |   4 +-
 .../bindings/power/supply/nokia,n900-battery.yaml  |   4 +-
 .../bindings/power/supply/olpc-battery.yaml        |   4 +-
 .../bindings/power/supply/power-supply.yaml        |   4 +-
 .../power/supply/richtek,rt5033-battery.yaml       |   4 +-
 .../bindings/power/supply/richtek,rt9455.yaml      |   4 +-
 .../bindings/power/supply/sc2731-charger.yaml      |   4 +-
 .../bindings/power/supply/sc27xx-fg.yaml           |   4 +-
 .../power/supply/stericsson,ab8500-btemp.yaml      |   4 +-
 .../power/supply/stericsson,ab8500-chargalg.yaml   |   4 +-
 .../power/supply/stericsson,ab8500-charger.yaml    |   4 +-
 .../power/supply/stericsson,ab8500-fg.yaml         |   4 +-
 .../power/supply/summit,smb347-charger.yaml        |   4 +-
 .../bindings/power/supply/tps65090-charger.yaml    |   4 +-
 .../bindings/power/supply/tps65217-charger.yaml    |   4 +-
 .../bindings/power/supply/twl4030-charger.yaml     |   4 +-
 .../supply/x-powers,axp20x-ac-power-supply.yaml    |   4 +-
 .../x-powers,axp20x-battery-power-supply.yaml      |   4 +-
 .../supply/x-powers,axp20x-usb-power-supply.yaml   |   4 +-
 .../devicetree/bindings/powerpc/fsl/cpus.txt       |   2 +-
 .../devicetree/bindings/powerpc/fsl/mpc5200.txt    |   2 +-
 .../devicetree/bindings/powerpc/opal/power-mgt.txt |   2 +-
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |   2 +-
 .../devicetree/bindings/rtc/rtc-ds1307.txt         |  52 -----
 .../devicetree/bindings/rtc/rtc-ds1307.yaml        | 102 ++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   2 +
 .../devicetree/bindings/serial/efm32-uart.txt      |  20 --
 .../devicetree/bindings/serio/ps2-gpio.txt         |  23 ---
 .../devicetree/bindings/serio/ps2-gpio.yaml        |  64 ++++++
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |   2 +-
 Documentation/devicetree/bindings/sound/da9055.txt |   2 +-
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |   4 +-
 .../devicetree/bindings/spi/efm32-spi.txt          |  39 ----
 .../devicetree/bindings/sram/qcom,imem.yaml        |  75 +++++++
 .../devicetree/bindings/sram/qcom,ocmem.yaml       |  10 +-
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      |   2 +-
 .../bindings/thermal/nvidia,tegra124-soctherm.txt  |   2 +-
 .../devicetree/bindings/thermal/rcar-thermal.yaml  |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |  18 +-
 .../bindings/watchdog/faraday,ftwdt010.yaml        |   2 +-
 .../bindings/watchdog/qcom,pm8916-wdt.txt          |  28 ---
 .../bindings/watchdog/qcom,pm8916-wdt.yaml         |  51 +++++
 .../devicetree/bindings/writing-bindings.rst       |   2 +-
 MAINTAINERS                                        |   4 +-
 drivers/of/base.c                                  |   2 +-
 drivers/of/device.c                                |   5 +-
 drivers/of/fdt.c                                   |  19 +-
 drivers/of/kexec.c                                 |  17 ++
 drivers/of/of_reserved_mem.c                       |   3 +-
 drivers/of/overlay.c                               |  20 +-
 drivers/of/unittest.c                              |  17 +-
 include/dt-bindings/clock/efm32-cmu.h              |  43 ----
 include/linux/of.h                                 |   5 +-
 154 files changed, 1846 insertions(+), 1373 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
 delete mode 100644 Documentation/devicetree/bindings/chosen.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/efm32-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/sii902x.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/arm,rtsm-display.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
 rename Documentation/devicetree/bindings/{misc/eeprom-93xx46.yaml => eeprom/microchip,93lc46b.yaml} (89%)
 rename Documentation/devicetree/bindings/{soc/samsung/exynos-chipid.yaml => hwinfo/samsung,exynos-chipid.yaml} (92%)
 create mode 100644 Documentation/devicetree/bindings/hwinfo/samsung,s5pv210-chipid.yaml
 rename Documentation/devicetree/bindings/{soc/ti/k3-socinfo.yaml => hwinfo/ti,k3-socinfo.yaml} (92%)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/ibm,p8-occ-hwmon.txt (100%)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-efm32.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-aat1290.txt
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-is31fl319x.txt
 create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/gpio-ir-receiver.txt
 create mode 100644 Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/emac_rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/net/rockchip,emac.yaml
 create mode 100644 Documentation/devicetree/bindings/perf/arm,ccn.yaml
 delete mode 100644 Documentation/devicetree/bindings/perf/arm-ccn.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/efm32-uart.txt
 delete mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/efm32-spi.txt
 create mode 100644 Documentation/devicetree/bindings/sram/qcom,imem.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml
 delete mode 100644 include/dt-bindings/clock/efm32-cmu.h
