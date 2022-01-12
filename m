Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B8548CCB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiALUAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:00:48 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45711 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350786AbiALUAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:00:31 -0500
Received: by mail-ot1-f50.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso3775574otf.12;
        Wed, 12 Jan 2022 12:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=i6m4B24tSbRK/8qImEGzU60jKt5ahQuGgs51mXg9iY0=;
        b=bqvMw2aT8bvbjjV7jEI37rVrxx6xToPuNU4zSmg9CbusuFTar2kF86vzuRuqQqvJJ3
         5s8ebnL+kewEVvKvbSTTtLqGum8jfg+9F5qp1/WzcD2DxL8wgXjr6cMqljLwIUhVyVFl
         /JpNJZ7LmhwcB8IQOYJcfDWopawKKvChaKzd4829B1LjLXW1vRix3QXf+HXgm5sxon3X
         pxeiHMGEA089D/70+qVDeML20CIKlMhSfujxKsaozigbT2D/cO8mgJEqpv+8GDJ6DTHM
         Hi8GuxOmEcBJ2GP913YirxxCCEG6kutoYUThSj6WWH7vbubq+pIfSP/9sLEmea92Vt7m
         HCdA==
X-Gm-Message-State: AOAM533bHqKEP5VK3Jq/e5JkeMV5x5+fbhh9xi11KQ3yguEjTemwbwGJ
        +G7IJG1vtvPZzLxTqwKbnA==
X-Google-Smtp-Source: ABdhPJzlIIgZVSzdW7qjnoANkqdZt95H6QTdYojQaszhV2CAz8VkDce6jp8sEfDHnhlBWTCBBpfymQ==
X-Received: by 2002:a05:6830:2806:: with SMTP id w6mr1001520otu.382.1642017629788;
        Wed, 12 Jan 2022 12:00:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k19sm161104oot.32.2022.01.12.12.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:00:28 -0800 (PST)
Received: (nullmailer pid 1378410 invoked by uid 1000);
        Wed, 12 Jan 2022 20:00:28 -0000
Date:   Wed, 12 Jan 2022 14:00:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.17
Message-ID: <Yd8zXGvAUrvyw+ki@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for v5.17.

The base below is a bit odd since I merged in 2 fixes that I never 
got around to sending for 5.16.

Rob


The following changes since commit 75e895343d5a2fcbdf4cb3d31ab7492bd65925f0:

  Revert "kbuild: Enable DT schema checks for %.dtb targets" (2021-12-08 15:41:19 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.17

for you to fetch changes up to e623611b4d3f722b57ceeaf4368ac787837408e7:

  Merge branch 'dt/linus' into dt/next (2022-01-12 10:14:09 -0600)

----------------------------------------------------------------
Devicetree updates for v5.17:

Bindings:
- DT schema conversions for Samsung clocks, RNG bindings, Qcom Command
  DB and rmtfs, gpio-restart, i2c-mux-gpio, i2c-mux-pinctl, Tegra I2C
  and BPMP, pwm-vibrator, Arm DSU, and Cadence macb

- DT schema conversions for Broadcom platforms: interrupt controllers,
  STB GPIO, STB waketimer, STB reset, iProc MDIO mux, iProc PCIe,
  Cygnus PCIe PHY, PWM, USB BDC, BCM6328 LEDs, TMON, SYSTEMPORT, AMAC,
  Northstar 2 PCIe PHY, GENET, moca PHY, GISB arbiter, and SATA

- Add binding schemas for Tegra210 EMC table, TI DC-DC converters,

- Clean-ups of MDIO bus schemas to fix 'unevaluatedProperties' issues

- More fixes due to 'unevaluatedProperties' enabling

- Data type fixes and clean-ups of binding examples found in preparation
  to move to validating DTB files directly (instead of intermediate YAML
  representation.

- Vendor prefixes for T-Head Semiconductor, OnePlus, and Sunplus

- Add various new compatible strings

DT core:
- Silence a warning for overlapping reserved memory regions

- Reimplement unittest overlay tracking

- Fix stack frame size warning in unittest

- Clean-ups of early FDT scanning functions

- Fix handling of "linux,usable-memory-range" on EFI booted systems

- Add support for 'fail' status on CPU nodes

- Improve error message in of_phandle_iterator_next()

- kbuild: Disable duplicate unit-address warnings for disabled nodes

----------------------------------------------------------------
Baruch Siach (2):
      of: base: Fix phandle argument length mismatch error message
      of: base: Improve argument length mismatch error

Biju Das (1):
      dt-bindings: gpu: mali-bifrost: Document RZ/G2L support

David Heidelberg (8):
      dt-bindings: display: sync formats with simplefb.h
      dt-bindings: net: ethernet-controller: add 2.5G and 10G speeds
      dt-bindings: input: pwm-vibrator: Convert txt bindings to yaml
      dt-binding: soc: qcom: convert rmtfs documentation to yaml
      dt-binding: soc: qcom: convert Qualcomm Command DB documentation to yaml
      dt-bindings: msm: disp: remove bus from dpu bindings
      dt-bindings: crypto: convert Qualcomm PRNG to yaml
      dt-bindings: display: enable port jdi,lt070me05000

David Mosberger-Tang (1):
      Update trivial-devices.yaml with Sensirion,sht4x

Florian Fainelli (24):
      dt-bindings: PCI: brcmstb: compatible is required
      dt-bindings: net: brcm,unimac-mdio: reg-names is optional
      dt-bindings: net: brcm,unimac-mdio: Update maintainers for binding
      dt-bindings: net: Document moca PHY interface
      dt-bindings: net: Convert GENET binding to YAML
      dt-bindings: phy: Convert Northstar 2 PCIe PHY to YAML
      dt-bindings: net: Convert iProc MDIO mux to YAML
      dt-bindings: net: Convert AMAC to YAML
      dt-bindings: net: Convert SYSTEMPORT to YAML
      dt-bindings: phy: Convert Cygnus PCIe PHY to YAML
      dt-bindings: pci: Convert iProc PCIe to YAML
      dt-bindings: reset: Convert Broadcom STB reset to YAML
      dt-bindings: pwm: Convert BCM7038 PWM binding to YAML
      dt-bindings: rtc: Convert Broadcom STB waketimer to YAML
      dt-bindings: gpio: Convert Broadcom STB GPIO to YAML
      dt-binding: interrupt-controller: Convert BCM7038 L1 intc to YAML
      dt-bindings: interrupt-controller: Convert Broadcom STB L2 to YAML
      dt-bindings: rng: Convert iProc RNG200 to YAML
      dt-bindings: thermal: Convert Broadcom TMON to YAML
      dt-bindings: ata: Convert Broadcom SATA to YAML
      dt-bindings: bus: Convert GISB arbiter to YAML
      dt-bindings: usb: Convert BDC to YAML
      dt-bindings: interrupt-controller: Convert BCM7120 L2 to YAML
      dt-bindings: interrupt-controller: Merge BCM3380 with BCM7120

Frank Rowand (3):
      of: unittest: 64 bit dma address test requires arch support
      of: unittest: change references to obsolete overlay id
      of: unittest: re-implement overlay tracking

Geert Uytterhoeven (2):
      dt-bindings: dma: sifive,fu540-c000-pdma: Group interrupt tuples
      dt-bindings: net: cdns,macb: Convert to json-schema

Guo Ren (1):
      dt-bindings: vendor-prefixes: add T-Head Semiconductor

Jim Quinlan (1):
      of: unittest: fix warning on PowerPC frame size warning

Krzysztof Kozlowski (15):
      dt-bindings: hwmon: add TI DC-DC converters
      dt-bindings: rng: apm,x-gene-rng: convert APM RNG to dtschema
      dt-bindings: rng: atmel,at91-trng: convert Atmel TRNG to dtschema
      dt-bindings: rng: atmel,at91-trng: document sama7g5 TRNG
      dt-bindings: rng: ti,keystone-rng: convert TI Keystone RNG to dtschema
      dt-bindings: rng: nuvoton,npcm-rng: convert Nuvoton NPCM RNG to dtschema
      dt-bindings: rng: ti,omap-rom-rng: convert OMAP ROM RNG to dtschema
      dt-bindings: rng: st,rng: convert ST RNG to dtschema
      dt-bindings: rng: timeriomem_rng: convert TimerIO RNG to dtschema
      dt-bindings: clock: samsung: convert Exynos5433 to dtschema
      dt-bindings: clock: samsung: convert Exynos7 to dtschema
      dt-bindings: clock: samsung: extend Exynos7 bindings with UFS
      dt-bindings: clock: samsung: convert Exynos5260 to dtschema
      dt-bindings: clock: samsung: convert Exynos5410 to dtschema
      dt-bindings: clock: samsung: convert S5Pv210 to dtschema

Linus Walleij (1):
      dt-bindings: Add resets to the PL011 bindings

Matthias Schiffer (1):
      of: base: Skip CPU nodes with "fail"/"fail-..." status

Niklas Söderlund (2):
      dt-bindings: thermal: Fix definition of cooling-maps contribution property
      dt-bindings: i2c: maxim,max96712: Add bindings for Maxim Integrated MAX96712

Pingfan Liu (1):
      efi: apply memblock cap after memblock_add()

Qin Jian (1):
      dt-bindings: vendor-prefixes: Add Sunplus

Rafał Miłecki (1):
      dt-bindings: leds: convert BCM6328 controller to the json-schema

Rob Herring (31):
      dt-bindings: i2c: aspeed: Drop stray '#interrupt-cells'
      dt-bindings: watchdog: ti,rti-wdt: Fix assigned-clock-parents
      dt-bindings: watchdog: atmel: Add missing 'interrupts' property
      dt-bindings: usb: Add missing properties used in examples
      dt-bindings: memory-controllers: ti,gpmc: Drop incorrect unevaluatedProperties
      dt-bindings: PCI: Fix 'unevaluatedProperties' warnings
      dt-bindings: PCI: cdns-ep: Fix 'unevaluatedProperties' warnings
      dt-bindings: PCI: designware: Fix 'unevaluatedProperties' warnings
      of/fdt: Rework early_init_dt_scan_chosen() to call directly
      of/fdt: Rework early_init_dt_scan_root() to call directly
      of/fdt: Rework early_init_dt_scan_memory() to call directly
      dt-bindings: arm,cci-400: Drop the PL330 from example
      dt-bindings: display: st,stm32-dsi: Fix panel node name in example
      dt-bindings: display: novatek,nt36672a: Fix unevaluated properties warning
      dt-bindings: net: mdio: Allow any child node name
      dt-bindings: net: snps,dwmac: Enable burst length properties for more compatibles
      dt-bindings: net: Add missing properties used in examples
      dt-bindings: net: Cleanup MDIO node schemas
      dt-bindings: net: stm32-dwmac: Make each example a separate entry
      dt-bindings: i2c: st,stm32-i2c: Make each example a separate entry
      dt-bindings: PCI: snps,dw-pcie-ep: Drop conflicting 'max-functions' schema
      dt-bindings: net: wireless: mt76: Fix 8-bit property sizes
      dt-bindings: net: ti,dp83869: Drop value on boolean 'ti,max-output-impedance'
      dt-bindings: Drop required 'interrupt-parent'
      dt-bindings: clock: imx5: Drop clock consumer node from example
      dt-bindings: iio/magnetometer: yamaha,yas530: Fix invalid 'interrupts' in example
      dt-bindings: interrupt-controller: arm,gic-v3: Fix 'interrupts' cell size in example
      dt-bindings: power: maxim,max17040: Fix incorrect type for 'maxim,rcomp'
      dt-bindings: iio: adi,ltc2983: Fix 64-bit property sizes
      dt-bindings: net: mdio: Drop resets/reset-names child properties
      Merge branch 'dt/linus' into dt/next

Robin Murphy (3):
      dt-bindings: arm: Catch up with Cortex/Neoverse CPUs again
      dt-bindings: perf: Convert Arm DSU to schema
      dt-bindings: perf: Add compatible for Arm DSU-110

Sam Protsenko (1):
      dt-bindings: Only show unique unit address warning for enabled nodes

Stanislav Jakubek (2):
      dt-bindings: arm: ux500: Document missing compatibles
      dt-bindings: vendor-prefixes: add OnePlus

Stephen Boyd (1):
      of/fdt: Don't worry about non-memory region overlap for no-map

Thierry Reding (9):
      dt-bindings: arm: cpus: Add ARM Cortex-A78
      dt-bindings: Use correct vendor prefix for Asahi Kasei Corp.
      dt-bindings: arm: pmu: Document Denver and Carmel PMUs
      dt-bindings: i2c: tegra-bpmp: Convert to json-schema
      dt-bindings: i2c: tegra: Convert to json-schema
      dt-bindings: i2c: i2c-mux-pinctrl: Convert to json-schema
      dt-bindings: i2c: i2c-mux-gpio: Convert to json-schema
      dt-bindings: power: reset: gpio-restart: Convert to json-schema
      dt-bindings: memory: Document Tegra210 EMC table

Ulf Hansson (1):
      of: property: fw_devlink: Fixup behaviour when 'node_not_dev' is set

Yang Li (1):
      of: unittest: remove unneeded semicolon

Zhen Lei (1):
      of: fdt: Aggregate the processing of "linux,usable-memory-range"

 Documentation/devicetree/bindings/Makefile         |   4 +-
 .../devicetree/bindings/arm/arm,cci-400.yaml       |  10 -
 .../devicetree/bindings/arm/arm-dsu-pmu.txt        |  27 --
 Documentation/devicetree/bindings/arm/cpus.yaml    |   7 +
 Documentation/devicetree/bindings/arm/pmu.yaml     |   8 +
 Documentation/devicetree/bindings/arm/ux500.yaml   |  30 ++
 .../devicetree/bindings/ata/brcm,sata-brcm.txt     |  45 --
 .../devicetree/bindings/ata/brcm,sata-brcm.yaml    |  90 ++++
 .../devicetree/bindings/bus/brcm,gisb-arb.txt      |  34 --
 .../devicetree/bindings/bus/brcm,gisb-arb.yaml     |  66 +++
 .../devicetree/bindings/clock/exynos5260-clock.txt | 190 --------
 .../devicetree/bindings/clock/exynos5410-clock.txt |  50 --
 .../devicetree/bindings/clock/exynos5433-clock.txt | 507 --------------------
 .../devicetree/bindings/clock/exynos7-clock.txt    | 108 -----
 .../devicetree/bindings/clock/imx5-clock.yaml      |   9 +-
 .../bindings/clock/samsung,exynos5260-clock.yaml   | 382 +++++++++++++++
 .../bindings/clock/samsung,exynos5410-clock.yaml   |  66 +++
 .../bindings/clock/samsung,exynos5433-clock.yaml   | 524 +++++++++++++++++++++
 .../bindings/clock/samsung,exynos7-clock.yaml      | 272 +++++++++++
 .../bindings/clock/samsung,s5pv210-clock.txt       |  77 ---
 .../bindings/clock/samsung,s5pv210-clock.yaml      |  79 ++++
 .../devicetree/bindings/crypto/qcom,prng.txt       |  19 -
 .../devicetree/bindings/crypto/qcom,prng.yaml      |  43 ++
 .../bindings/display/msm/dpu-sdm845.yaml           |   5 +-
 .../bindings/display/panel/jdi,lt070me05000.yaml   |   2 +
 .../bindings/display/panel/novatek,nt36672a.yaml   |   4 +-
 .../bindings/display/simple-framebuffer.yaml       |  12 +
 .../devicetree/bindings/display/st,stm32-dsi.yaml  |   3 +-
 .../bindings/dma/sifive,fu540-c000-pdma.yaml       |   2 +-
 .../devicetree/bindings/gpio/brcm,brcmstb-gpio.txt |  83 ----
 .../bindings/gpio/brcm,brcmstb-gpio.yaml           | 104 ++++
 .../bindings/gpio/toshiba,gpio-visconti.yaml       |   1 -
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |  45 +-
 .../devicetree/bindings/i2c/aspeed,i2c.yaml        |   1 -
 .../devicetree/bindings/i2c/i2c-gate.yaml          |   2 +-
 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |  80 ----
 .../devicetree/bindings/i2c/i2c-mux-gpio.yaml      | 104 ++++
 .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    |  93 ----
 .../devicetree/bindings/i2c/i2c-mux-pinctrl.yaml   | 103 ++++
 .../bindings/i2c/nvidia,tegra186-bpmp-i2c.txt      |  42 --
 .../bindings/i2c/nvidia,tegra186-bpmp-i2c.yaml     |  45 ++
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt |  87 ----
 .../bindings/i2c/nvidia,tegra20-i2c.yaml           | 192 ++++++++
 .../devicetree/bindings/i2c/st,stm32-i2c.yaml      |   6 +
 .../bindings/iio/gyroscope/invensense,mpu3050.yaml |   2 +-
 .../bindings/iio/imu/invensense,mpu6050.yaml       |   2 +-
 .../bindings/iio/magnetometer/yamaha,yas530.yaml   |   2 +-
 .../bindings/iio/temperature/adi,ltc2983.yaml      |  22 +-
 .../devicetree/bindings/input/pwm-vibrator.txt     |  66 ---
 .../devicetree/bindings/input/pwm-vibrator.yaml    |  57 +++
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   3 +-
 .../interrupt-controller/brcm,bcm3380-l2-intc.txt  |  39 --
 .../interrupt-controller/brcm,bcm7038-l1-intc.txt  |  61 ---
 .../interrupt-controller/brcm,bcm7038-l1-intc.yaml |  91 ++++
 .../interrupt-controller/brcm,bcm7120-l2-intc.txt  |  88 ----
 .../interrupt-controller/brcm,bcm7120-l2-intc.yaml | 151 ++++++
 .../bindings/interrupt-controller/brcm,l2-intc.txt |  31 --
 .../interrupt-controller/brcm,l2-intc.yaml         |  72 +++
 .../devicetree/bindings/leds/leds-bcm6328.txt      | 319 -------------
 .../devicetree/bindings/leds/leds-bcm6328.yaml     | 404 ++++++++++++++++
 .../bindings/mailbox/ti,omap-mailbox.yaml          |   9 -
 .../bindings/media/i2c/maxim,max96712.yaml         | 111 +++++
 .../bindings/memory-controllers/ti,gpmc.yaml       |   5 +-
 .../devicetree/bindings/mfd/cirrus,madera.yaml     |   1 -
 .../devicetree/bindings/net/actions,owl-emac.yaml  |   4 +
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |  25 +-
 .../devicetree/bindings/net/brcm,amac.txt          |  30 --
 .../devicetree/bindings/net/brcm,amac.yaml         |  88 ++++
 .../bindings/net/brcm,bcm6368-mdio-mux.yaml        |  26 +-
 .../devicetree/bindings/net/brcm,bcmgenet.txt      | 125 -----
 .../devicetree/bindings/net/brcm,bcmgenet.yaml     | 145 ++++++
 .../bindings/net/brcm,mdio-mux-iproc.txt           |  62 ---
 .../bindings/net/brcm,mdio-mux-iproc.yaml          |  80 ++++
 .../devicetree/bindings/net/brcm,systemport.txt    |  38 --
 .../devicetree/bindings/net/brcm,systemport.yaml   |  86 ++++
 .../devicetree/bindings/net/brcm,unimac-mdio.yaml  |   3 +-
 .../devicetree/bindings/net/cdns,macb.yaml         | 159 +++++++
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |   6 +-
 .../devicetree/bindings/net/dsa/qca8k.yaml         |  23 +-
 .../bindings/net/ethernet-controller.yaml          |   5 +-
 Documentation/devicetree/bindings/net/fsl,fec.yaml |   3 +-
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |   2 +-
 .../bindings/net/intel,ixp4xx-ethernet.yaml        |   4 +-
 .../devicetree/bindings/net/lantiq,etop-xway.yaml  |   1 -
 .../devicetree/bindings/net/lantiq,xrx200-net.yaml |   1 -
 .../devicetree/bindings/net/litex,liteeth.yaml     |   1 +
 Documentation/devicetree/bindings/net/macb.txt     |  60 ---
 .../devicetree/bindings/net/mdio-mux.yaml          |   7 +-
 Documentation/devicetree/bindings/net/mdio.yaml    |   8 +-
 .../bindings/net/mediatek,star-emac.yaml           |   5 +-
 .../devicetree/bindings/net/qca,ar71xx.yaml        |  16 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |   6 +-
 .../bindings/net/socionext,uniphier-ave4.yaml      |   1 +
 .../devicetree/bindings/net/stm32-dwmac.yaml       |  10 +-
 .../devicetree/bindings/net/ti,davinci-mdio.yaml   |   7 +
 .../devicetree/bindings/net/ti,dp83869.yaml        |   2 +-
 .../bindings/net/toshiba,visconti-dwmac.yaml       |   2 +-
 .../bindings/net/wireless/mediatek,mt76.yaml       |   4 +-
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 133 ------
 .../devicetree/bindings/pci/brcm,iproc-pcie.yaml   | 184 ++++++++
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   1 +
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml |   1 -
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml      |   1 +
 .../bindings/pci/hisilicon,kirin-pcie.yaml         |  13 +
 .../bindings/pci/mediatek,mt7621-pcie.yaml         |   3 +
 .../bindings/pci/mediatek-pcie-gen3.yaml           |   4 +
 .../bindings/pci/microchip,pcie-host.yaml          |  18 +
 .../devicetree/bindings/pci/sifive,fu740-pcie.yaml |   5 +-
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml   |   6 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   2 +-
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |   2 +-
 .../devicetree/bindings/pci/ti,am65-pci-ep.yaml    |   2 -
 .../devicetree/bindings/pci/ti,am65-pci-host.yaml  |   4 +-
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |   2 +
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |   1 -
 .../devicetree/bindings/perf/arm,dsu-pmu.yaml      |  45 ++
 .../bindings/phy/brcm,cygnus-pcie-phy.txt          |  47 --
 .../bindings/phy/brcm,cygnus-pcie-phy.yaml         |  76 +++
 .../bindings/phy/brcm,mdio-mux-bus-pci.txt         |  27 --
 .../devicetree/bindings/phy/brcm,ns2-pcie-phy.yaml |  41 ++
 .../bindings/power/reset/gpio-restart.txt          |  54 ---
 .../bindings/power/reset/gpio-restart.yaml         |  86 ++++
 .../bindings/power/supply/maxim,max17040.yaml      |   4 +-
 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.txt   |  20 -
 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml  |  43 ++
 .../reserved-memory/nvidia,tegra210-emc-table.yaml |  31 ++
 .../bindings/reserved-memory/qcom,cmd-db.txt       |  37 --
 .../bindings/reserved-memory/qcom,cmd-db.yaml      |  46 ++
 .../bindings/reserved-memory/qcom,rmtfs-mem.txt    |  51 --
 .../bindings/reserved-memory/qcom,rmtfs-mem.yaml   |  53 +++
 .../bindings/reset/brcm,brcmstb-reset.txt          |  27 --
 .../bindings/reset/brcm,brcmstb-reset.yaml         |  48 ++
 Documentation/devicetree/bindings/rng/apm,rng.txt  |  17 -
 .../devicetree/bindings/rng/apm,x-gene-rng.yaml    |  47 ++
 .../devicetree/bindings/rng/atmel,at91-trng.yaml   |  51 ++
 .../devicetree/bindings/rng/atmel-trng.txt         |  16 -
 .../devicetree/bindings/rng/brcm,iproc-rng200.txt  |  16 -
 .../devicetree/bindings/rng/brcm,iproc-rng200.yaml |  30 ++
 .../devicetree/bindings/rng/ks-sa-rng.txt          |  21 -
 .../devicetree/bindings/rng/nuvoton,npcm-rng.txt   |  12 -
 .../devicetree/bindings/rng/nuvoton,npcm-rng.yaml  |  35 ++
 .../devicetree/bindings/rng/omap3_rom_rng.txt      |  27 --
 Documentation/devicetree/bindings/rng/st,rng.txt   |  15 -
 Documentation/devicetree/bindings/rng/st,rng.yaml  |  35 ++
 .../devicetree/bindings/rng/ti,keystone-rng.yaml   |  50 ++
 .../devicetree/bindings/rng/ti,omap-rom-rng.yaml   |  41 ++
 .../devicetree/bindings/rng/timeriomem_rng.txt     |  25 -
 .../devicetree/bindings/rng/timeriomem_rng.yaml    |  48 ++
 .../bindings/rtc/brcm,brcmstb-waketimer.txt        |  20 -
 .../bindings/rtc/brcm,brcmstb-waketimer.yaml       |  44 ++
 .../devicetree/bindings/serial/pl011.yaml          |   3 +
 .../devicetree/bindings/thermal/brcm,avs-tmon.txt  |  23 -
 .../devicetree/bindings/thermal/brcm,avs-tmon.yaml |  56 +++
 .../devicetree/bindings/thermal/thermal-zones.yaml |   9 +-
 .../devicetree/bindings/trivial-devices.yaml       |   9 +
 Documentation/devicetree/bindings/usb/brcm,bdc.txt |  29 --
 .../devicetree/bindings/usb/brcm,bdc.yaml          |  50 ++
 .../bindings/usb/intel,keembay-dwc3.yaml           |   3 +
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   6 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   6 +
 .../bindings/watchdog/atmel,sama5d4-wdt.yaml       |   3 +
 .../devicetree/bindings/watchdog/ti,rti-wdt.yaml   |   6 -
 MAINTAINERS                                        |  13 +-
 arch/mips/ralink/of.c                              |  19 +-
 arch/powerpc/kernel/prom.c                         |  27 +-
 arch/powerpc/mm/nohash/kaslr_booke.c               |   4 +-
 drivers/firmware/efi/efi-init.c                    |   5 +
 drivers/of/base.c                                  |  38 +-
 drivers/of/fdt.c                                   | 144 +++---
 drivers/of/property.c                              |  17 +-
 drivers/of/unittest.c                              | 175 ++++---
 include/linux/of_fdt.h                             |  11 +-
 172 files changed, 5189 insertions(+), 3379 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
 delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
 create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5260-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5433-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos7-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/qcom,prng.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom,prng.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/nvidia,tegra186-bpmp-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/nvidia,tegra186-bpmp-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.txt
 create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-bcm6328.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-bcm6328.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96712.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/brcm,amac.txt
 create mode 100644 Documentation/devicetree/bindings/net/brcm,amac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/brcm,bcmgenet.txt
 create mode 100644 Documentation/devicetree/bindings/net/brcm,bcmgenet.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
 create mode 100644 Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/brcm,systemport.txt
 create mode 100644 Documentation/devicetree/bindings/net/brcm,systemport.yaml
 create mode 100644 Documentation/devicetree/bindings/net/cdns,macb.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/macb.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/perf/arm,dsu-pmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,mdio-mux-bus-pci.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-pcie-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra210-emc-table.yaml
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/apm,rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/apm,x-gene-rng.yaml
 create mode 100644 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/atmel-trng.txt
 delete mode 100644 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt
 create mode 100644 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/ks-sa-rng.txt
 delete mode 100644 Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/omap3_rom_rng.txt
 delete mode 100644 Documentation/devicetree/bindings/rng/st,rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/st,rng.yaml
 create mode 100644 Documentation/devicetree/bindings/rng/ti,keystone-rng.yaml
 create mode 100644 Documentation/devicetree/bindings/rng/ti,omap-rom-rng.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/timeriomem_rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/timeriomem_rng.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.yaml
