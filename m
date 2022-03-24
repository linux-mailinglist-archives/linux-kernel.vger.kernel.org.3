Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23E4E6880
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352571AbiCXSSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbiCXSSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:18:36 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC080B716E;
        Thu, 24 Mar 2022 11:17:03 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id e4so5735534oif.2;
        Thu, 24 Mar 2022 11:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=drvPmJX1BduBMatL4dKJkIPi9wsdLfQPaUnoWgO7SPw=;
        b=JuLYcag9OsZXody2haBc6DjsqyO/IlCWi3w3rlCUTDD9DDjY3XxvI6iUbulU5oU84M
         erYil36d0oRagbhLy8fzQ22lMhelbifc7QBt83YIa/nOmYwa52JfHBjWREZpKt6uIbJS
         xbRTR+wsVRhIEQy0LYVwnBtR7l7/TGDhaaa34gibsk5rz29KChfQUSwyUY+Vs4R+pHxM
         vW6MC1UU/SSRDIgtKTxzkAnOy4BJAfiXBbRX6K4P9WIWnl+y1hARFoBuyRqpMvosTOqM
         h3UGuakzfSEJgzHAjj6OAa7UDkfSnpU6gL2+AQhYbcMa/y3rdT0mgs4x7+mkOteYUb2H
         jXYw==
X-Gm-Message-State: AOAM532pJvfoJbOYTBtJo4rGFHhK081+huqORsMMRVlxovgzaj0ujyxa
        10Zc72emgrUE0rp9IwYt+1y13esvjA==
X-Google-Smtp-Source: ABdhPJxFr6aJxrlfG6n/cN8SiQ12j7XyQ1EscKm8XM9QZq152RfjgwZ0SPtRNw//gyJfefPZB8R/kw==
X-Received: by 2002:a05:6808:1808:b0:2da:91c:5f9a with SMTP id bh8-20020a056808180800b002da091c5f9amr3391069oib.235.1648145822753;
        Thu, 24 Mar 2022 11:17:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 15-20020aca110f000000b002da58c4ec52sm1709865oir.6.2022.03.24.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:17:02 -0700 (PDT)
Received: (nullmailer pid 2330071 invoked by uid 1000);
        Thu, 24 Mar 2022 18:17:01 -0000
Date:   Thu, 24 Mar 2022 13:17:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v5.18
Message-ID: <Yjy1narVcf4pTiDG@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Please pull DT updates for v5.18.

Rob


The following changes since commit f6eafa4022dd61e029205bea4d4147d26e69fef2:

  dt-bindings: phy: ti,tcan104x-can: Document mux-states property (2022-03-08 10:41:32 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.18

for you to fetch changes up to 6b49f3409a090c8e9d1f46ff2705c479b45a54d4:

  dt-bindings: kbuild: Make DT_SCHEMA_LINT a recursive variable (2022-03-23 18:10:00 -0500)

----------------------------------------------------------------
Devicetree updates for v5.18:

- Add Krzysztof Kozlowski as co-maintainer for DT bindings providing
  much needed help.

- DT schema validation now takes DTB files as input rather than
  intermediate YAML files. This decouples the validation from the source
  level syntax information. There's a bunch of schema fixes as a result
  of switching to DTB based validation which exposed some errors
  and incomplete schemas and examples.

- Kbuild improvements to explicitly warn users running 'make
  dt_binding_check' on missing yamllint

- Expand DT_SCHEMA_FILES kbuild variable to take just a partial filename
  or path instead of the full path to 1 file.

- Convert various bindings to schema format: mscc,vsc7514-switch,
  multiple GNSS bindings, ahci-platform, i2c-at91, multiple UFS
  bindings, cortina,gemini-sata-bridge, cortina,gemini-ethernet, Atmel
  SHA, Atmel TDES, Atmel AES, armv7m-systick, Samsung Exynos display
  subsystem, nuvoton,npcm7xx-timer, samsung,s3c2410-i2c, zynqmp_dma,
  msm/mdp4, rda,8810pl-uart

- New schemas for u-boot environment variable partition, TI clksel

- New compatible strings for Renesas RZ/V2L SoC

- Vendor prefixes for Xen, HPE, deprecated Synopsys, deprecated HiSilicon

- Add/fix schemas for QEMU Arm 'virt' machine

- Drop unused of_alias_get_alias_list() function

- Add a script to check DT unittest EXPECT message output. Pass messages
  also now print by default at PR_INFO level to help test automation.

----------------------------------------------------------------
Clément Léger (1):
      dt-bindings: net: mscc,vsc7514-switch: convert txt bindings to yaml

Corentin Labbe (2):
      dt-bindings: net: convert net/cortina,gemini-ethernet to yaml
      dt-bindings: convert ata/cortina,gemini-sata-bridge to yaml

David Heidelberg (2):
      dt-bindings: msm/mdp4: convert to yaml format
      dt-bindings: display: bridge: document Toshiba TC358768 cells and panel node

Dinh Nguyen (1):
      dt-bindings: net: can: fix dtbs warning

Fabrice Gasnier (1):
      dt-bindings: timer: armv7m-systick: convert to dtschema

Frank Rowand (2):
      of: unittest: print pass messages at PR_INFO level
      of: unittest: add program to process EXPECT messages

Frank Wunderlich (3):
      dt-bindings: ata: ahci-platform: Convert DT bindings to yaml
      dt-bindings: ata: ahci-platform: Add power-domains property
      dt-bindings: ata: ahci-platform: Add rk3568-dwc-ahci compatible

Geert Uytterhoeven (3):
      dt-bindings: timer: sifive,clint: Fix number of interrupts
      dt-bindings: timer: sifive,clint: Group interrupt tuples
      dt-bindings: firmware: arm,scpi: Add missing maxItems to mboxes/shmem

Jonathan Neuschäfer (1):
      dt-bindings: timer: nuvoton,npcm7xx-timer: Convert to YAML

Krzysztof Kozlowski (27):
      MAINTAINERS: dt-bindings: Add Krzysztof Kozlowski
      dt-bindings: i2c: samsung,s3c2410-i2c: convert to dtschema
      dt-bindings: vendor-prefixes: clarify HP prefix
      dt-bindings: phy: samsung,exynos-hdmi-phy: convert to dtschema
      dt-bindings: display: samsung,exynos5433-decon: convert to dtschema
      dt-bindings: display: samsung,exynos7-decon: convert to dtschema
      dt-bindings: display: samsung,exynos-hdmi-ddc: convert to dtschema
      dt-bindings: display: samsung,exynos-mixer: convert to dtschema
      dt-bindings: display: samsung,exynos-hdmi: convert to dtschema
      dt-bindings: display: samsung,exynos5433-mic: convert to dtschema
      dt-bindings: display: samsung,exynos-fimd: convert to dtschema
      dt-bindings: vendor-prefixes: add second HiSilicon prefix
      dt-bindings: vendor-prefixes: add second Synopsys prefix
      dt-bindings: usb: do not use deprecated synopsys prefix
      dt-bindings: writing-schema: Install from PyPI repository
      dt-bindings: example: Extend with typical case (int-array and disallowed prop)
      MAINTAINERS: dt-bindings: update Krzysztof Kozlowski's email
      dt-bindings: ufs: add common platform bindings
      dt-bindings: ufs: samsung,exynos-ufs: use common bindings
      dt-bindings: ufs: cdns,ufshc: convert to dtschema
      dt-bindings: ufs: drop unused/old ufs-qcom PHY bindings
      dt-bindings: ufs: qcom,ufs: convert to dtschema
      dt-bindings: ufs: hisilicon,ufs: convert to dtschema
      dt-bindings: ufs: mediatek,ufs: convert to dtschema
      dt-bindings: ufs: snps,tc-dwc-g210: convert to dtschema
      dt-bindings: gpio: pca95xx: drop useless consumer example
      dt-bindings: dmaengine: sifive,fu540-c000: include generic schema

Lad Prabhakar (5):
      dt-bindings: net: can: renesas,rcar-canfd: Document RZ/V2L SoC
      dt-bindings: i2c: renesas,riic: Document RZ/V2L SoC
      dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2L OSTM
      dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/V2L USBPHY Control bindings
      dt-bindings: usb: renesas,usbhs: Document RZ/V2L bindings

Linus Walleij (4):
      dt-bindings: gnss: Rewrite common bindings in YAML
      dt-bindings: gnss: Modify u-blox to use common bindings
      dt-bindings: gnss: Rewrite sirfstar binding in YAML
      dt-bindings: gnss: Add two more chips

Luca Weiss (1):
      dt-bindings: ufs: qcom: Add SM6350 compatible string

Michael Tretter (1):
      dt-bindings: dmaengine: zynqmp_dma: convert to yaml

Nathan Chancellor (1):
      dt-bindings: kbuild: Make DT_SCHEMA_LINT a recursive variable

Nick Hawkins (1):
      dt-bindings: vendor-prefixes: add HPE Prefix

Nicolas Ferre (1):
      dt-bindings: rng: atmel,at91-trng: update maintainers entry

Oleksii Moisieiev (1):
      dt-bindings: Add vendor prefix for Xen hypervisor

Oleksij Rempel (1):
      dt-bindings: net: ethernet-controller: document label property

Quentin Schulz (1):
      dt-bindings: ltk050h3146w: replace Heiko Stuebner by myself as maintainer

Rafał Miłecki (1):
      dt-bindings: nvmem: add U-Boot environment variables binding

Richard Zhu (2):
      dt-bindings: imx6q-pcie: Add iMX8MM PCIe compatible string
      dt-bindings: imx6q-pcie: Add iMX8MP PCIe compatible string

Rob Herring (22):
      dt-bindings: Improve phandle-array schemas
      dt-bindings: i2c: mpc: Make each example a separate entry
      dt-bindings: i2c: imx: Make each example a separate entry
      dt-bindings: nvmem: qcom,spmi-sdam: Drop child node schema
      dt-bindings: ingenic,i2c: Rework interrupts in example
      dt-bindings: i2c: stm32-i2c: Move st,syscfg-fmp definition to top level
      dt-bindings: net: ti,k3-am654-cpts: Fix assigned-clock-parents
      dt-bindings: watchdog: fsl-imx7ulp-wdt: Fix assigned-clock-parents
      dt-bindings: remoteproc: ti: Add mailbox provider nodes to example
      dt-bindings: arm,cci-400: Add interrupt controller to example
      ASoC: dt-bindings: Centralize the 'sound-dai' definition
      dt-bindings: Another pass removing cases of 'allOf' containing a '$ref'
      dt-bindings: kbuild: Support partial matches with DT_SCHEMA_FILES
      dt-bindings: arm: Allow 32-bit 'cpu-release-addr' values
      Merge branch 'dt/linus' into dt/next
      dt-bindings: kbuild: Print a warning if yamllint is not found
      dt-bindings: arm: Convert QEMU fw-cfg to DT schema
      dt-bindings: Add QEMU virt machine compatible
      dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
      dt-bindings: kbuild: Use DTB files for validation
      dt-bindings: virtio,mmio: Allow setting devices 'dma-coherent'
      Revert "of: base: Introduce of_alias_get_alias_list() to check alias IDs"

Robin Murphy (1):
      dt-bindings: reserved-memory: Add restricted-dma-pool constraints

Sergiu Moga (2):
      dt-bindings: i2c: convert i2c-at91 to json-schema
      dt-bindings: i2c: at91: Add SAMA7G5 compatible strings list

Stanislav Jakubek (2):
      dt-bindings: serial: Convert rda,8810pl-uart to YAML
      dt-bindings: trivial-devices: make comment indentation consistent

Thomas Bracht Laumann Jespersen (1):
      scripts/dtc: Call pkg-config POSIXly correct

Tom Rix (1):
      dt-bindings: clk: cleanup comments

Tony Lindgren (1):
      dt-bindings: clock: Add binding for TI clksel

Tudor Ambarus (3):
      dt-bindings: crypto: Convert Atmel AES to yaml
      dt-bindings: crypto: Convert Atmel TDES to yaml
      dt-bindings: crypto: Convert Atmel SHA to yaml

Zenghui Yu (1):
      dt-bindings: arm: Trivial typo fixes in cpu-capacity.txt

 Documentation/devicetree/bindings/Makefile         |  49 +--
 .../devicetree/bindings/arm/arm,cci-400.yaml       |   5 +
 .../devicetree/bindings/arm/cpu-capacity.txt       |   4 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |  12 +-
 Documentation/devicetree/bindings/arm/fw-cfg.txt   |  38 --
 .../devicetree/bindings/arm/idle-states.yaml       |  80 ++--
 .../devicetree/bindings/arm/linux,dummy-virt.yaml  |  20 +
 Documentation/devicetree/bindings/arm/pmu.yaml     |   2 +
 .../devicetree/bindings/ata/ahci-platform.txt      |  79 ----
 .../devicetree/bindings/ata/ahci-platform.yaml     | 189 ++++++++++
 .../bindings/ata/cortina,gemini-sata-bridge.txt    |  55 ---
 .../bindings/ata/cortina,gemini-sata-bridge.yaml   | 109 ++++++
 .../devicetree/bindings/ata/sata_highbank.yaml     |   3 +
 .../bindings/bus/allwinner,sun50i-a64-de2.yaml     |   5 +-
 .../devicetree/bindings/clock/ti/ti,clksel.yaml    |  51 +++
 .../bindings/connector/usb-connector.yaml          |   3 +-
 .../bindings/crypto/atmel,at91sam9g46-aes.yaml     |  66 ++++
 .../bindings/crypto/atmel,at91sam9g46-sha.yaml     |  60 +++
 .../bindings/crypto/atmel,at91sam9g46-tdes.yaml    |  64 ++++
 .../devicetree/bindings/crypto/atmel-crypto.txt    |  68 ----
 .../bindings/crypto/intel,ixp4xx-crypto.yaml       |  15 +-
 .../allwinner,sun4i-a10-display-engine.yaml        |   2 +
 .../bindings/display/brcm,bcm2711-hdmi.yaml        |   3 +-
 .../bindings/display/bridge/adi,adv7511.yaml       |   5 +-
 .../bindings/display/bridge/synopsys,dw-hdmi.yaml  |   5 +-
 .../bindings/display/bridge/toshiba,tc358768.yaml  |   7 +-
 .../bindings/display/exynos/exynos-mic.txt         |  51 ---
 .../bindings/display/exynos/exynos5433-decon.txt   |  60 ---
 .../bindings/display/exynos/exynos7-decon.txt      |  65 ----
 .../bindings/display/exynos/exynos_hdmi.txt        |  64 ----
 .../bindings/display/exynos/exynos_hdmiddc.txt     |  15 -
 .../bindings/display/exynos/exynos_hdmiphy.txt     |  15 -
 .../bindings/display/exynos/exynos_mixer.txt       |  26 --
 .../bindings/display/exynos/samsung-fimd.txt       | 107 ------
 .../bindings/display/mediatek/mediatek,hdmi.yaml   |   5 +-
 .../devicetree/bindings/display/msm/gpu.yaml       |   2 +
 .../devicetree/bindings/display/msm/mdp4.txt       | 114 ------
 .../devicetree/bindings/display/msm/mdp4.yaml      | 124 +++++++
 .../bindings/display/panel/display-timings.yaml    |   3 +-
 .../display/panel/leadtek,ltk050h3146w.yaml        |   2 +-
 .../devicetree/bindings/display/renesas,du.yaml    |  10 +-
 .../bindings/display/rockchip/rockchip-drm.yaml    |   2 +
 .../display/samsung/samsung,exynos-hdmi-ddc.yaml   |  42 +++
 .../display/samsung/samsung,exynos-hdmi.yaml       | 227 ++++++++++++
 .../display/samsung/samsung,exynos-mixer.yaml      | 143 ++++++++
 .../display/samsung/samsung,exynos5433-decon.yaml  | 148 ++++++++
 .../display/samsung/samsung,exynos5433-mic.yaml    |  95 +++++
 .../display/samsung/samsung,exynos7-decon.yaml     | 120 ++++++
 .../bindings/display/samsung/samsung,fimd.yaml     | 198 ++++++++++
 .../display/sprd/sprd,display-subsystem.yaml       |   2 +
 .../devicetree/bindings/display/ste,mcde.yaml      |   4 +-
 .../bindings/display/ti/ti,am65x-dss.yaml          |   3 +-
 .../devicetree/bindings/dma/dma-router.yaml        |   2 +
 .../bindings/dma/sifive,fu540-c000-pdma.yaml       |   8 +-
 .../devicetree/bindings/dma/st,stm32-dmamux.yaml   |   2 +-
 .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml   |  85 +++++
 .../devicetree/bindings/dma/xilinx/zynqmp_dma.txt  |  26 --
 .../bindings/dvfs/performance-domain.yaml          |   1 -
 .../devicetree/bindings/example-schema.yaml        |  14 +
 .../devicetree/bindings/firmware/arm,scmi.yaml     |   2 +-
 .../devicetree/bindings/firmware/arm,scpi.yaml     |   6 +-
 .../bindings/firmware/qemu,fw-cfg-mmio.yaml        |  54 +++
 .../devicetree/bindings/gnss/gnss-common.yaml      |  55 +++
 Documentation/devicetree/bindings/gnss/gnss.txt    |  37 --
 .../devicetree/bindings/gnss/sirfstar.txt          |  46 ---
 .../devicetree/bindings/gnss/sirfstar.yaml         |  76 ++++
 .../devicetree/bindings/gnss/u-blox,neo-6m.yaml    |  14 +-
 .../devicetree/bindings/gpio/gpio-pca95xx.yaml     |   8 -
 .../devicetree/bindings/i2c/atmel,at91sam-i2c.yaml | 146 ++++++++
 Documentation/devicetree/bindings/i2c/i2c-at91.txt |  82 -----
 Documentation/devicetree/bindings/i2c/i2c-imx.yaml |   7 +-
 Documentation/devicetree/bindings/i2c/i2c-mpc.yaml |   2 +
 .../devicetree/bindings/i2c/i2c-s3c2410.txt        |  58 ---
 .../devicetree/bindings/i2c/ingenic,i2c.yaml       |   4 +-
 .../devicetree/bindings/i2c/renesas,riic.yaml      |   2 +
 .../bindings/i2c/samsung,s3c2410-i2c.yaml          | 164 +++++++++
 .../devicetree/bindings/i2c/st,stm32-i2c.yaml      |  24 +-
 .../devicetree/bindings/input/adc-joystick.yaml    |   9 +-
 .../bindings/interconnect/qcom,rpmh.yaml           |   2 +
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   6 +-
 .../bindings/interrupt-controller/ti,sci-inta.yaml |   2 +
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |   6 +-
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   6 +
 .../bindings/leds/backlight/led-backlight.yaml     |   2 +
 .../bindings/leds/cznic,turris-omnia-leds.yaml     |   3 +-
 .../devicetree/bindings/leds/leds-lp50xx.yaml      |   3 +-
 .../media/allwinner,sun4i-a10-video-engine.yaml    |   4 +
 .../bindings/media/nxp,imx8mq-mipi-csi2.yaml       |  10 +-
 .../devicetree/bindings/media/ti,cal.yaml          |   4 +
 .../memory-controllers/mediatek,smi-larb.yaml      |   2 +-
 .../memory-controllers/samsung,exynos5422-dmc.yaml |   2 +
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |  12 +-
 .../bindings/mtd/rockchip,nand-controller.yaml     |   3 +-
 .../bindings/net/allwinner,sun4i-a10-emac.yaml     |   4 +
 .../devicetree/bindings/net/can/bosch,c_can.yaml   |   8 +-
 .../devicetree/bindings/net/can/bosch,m_can.yaml   |   1 +
 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |  12 +-
 .../bindings/net/can/renesas,rcar-canfd.yaml       |   1 +
 .../bindings/net/cortina,gemini-ethernet.txt       |  92 -----
 .../bindings/net/cortina,gemini-ethernet.yaml      | 137 +++++++
 .../devicetree/bindings/net/dsa/dsa-port.yaml      |   2 +
 .../bindings/net/ethernet-controller.yaml          |   4 +
 Documentation/devicetree/bindings/net/fsl,fec.yaml |   8 +-
 .../bindings/net/intel,ixp4xx-ethernet.yaml        |  15 +-
 .../devicetree/bindings/net/intel,ixp4xx-hss.yaml  |  33 +-
 .../bindings/net/mscc,vsc7514-switch.yaml          | 191 ++++++++++
 .../devicetree/bindings/net/mscc-ocelot.txt        |  83 -----
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |   4 +
 .../bindings/net/socionext,uniphier-ave4.yaml      |   4 +
 .../devicetree/bindings/net/stm32-dwmac.yaml       |   4 +
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    |   3 +-
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |   5 +
 .../devicetree/bindings/net/ti,k3-am654-cpts.yaml  |   6 -
 .../bindings/net/wireless/mediatek,mt76.yaml       |   4 +
 .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  |  28 --
 .../devicetree/bindings/nvmem/u-boot,env.yaml      |  62 ++++
 .../devicetree/bindings/opp/opp-v2-base.yaml       |   2 +
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   2 +
 .../devicetree/bindings/perf/arm,dsu-pmu.yaml      |   2 +
 .../devicetree/bindings/phy/intel,combo-phy.yaml   |   8 +
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |   3 +-
 .../bindings/phy/samsung,exynos-hdmi-phy.yaml      |  44 +++
 .../devicetree/bindings/phy/ti,omap-usb2.yaml      |   4 +
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |   2 +
 .../bindings/pinctrl/canaan,k210-fpioa.yaml        |   4 +
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  |   2 +
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |  10 +-
 .../devicetree/bindings/power/power-domain.yaml    |   4 +
 .../devicetree/bindings/power/renesas,apmu.yaml    |   2 +
 .../bindings/power/rockchip,power-controller.yaml  |   2 +
 .../bindings/power/supply/cw2015_battery.yaml      |   6 +-
 .../bindings/power/supply/power-supply.yaml        |   2 +
 .../bindings/power/supply/sbs,sbs-manager.yaml     |   4 +-
 .../devicetree/bindings/regulator/regulator.yaml   |   2 +
 .../bindings/regulator/st,stm32-booster.yaml       |   2 +-
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |   6 +
 .../bindings/remoteproc/st,stm32-rproc.yaml        |  33 +-
 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml       |  10 +
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml       |  13 +-
 .../bindings/remoteproc/ti,omap-remoteproc.yaml    |  19 +-
 .../bindings/reserved-memory/shared-dma-pool.yaml  |  10 +
 .../bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml  |   3 +-
 .../devicetree/bindings/rng/atmel,at91-trng.yaml   |   2 +-
 .../devicetree/bindings/serial/rda,8810pl-uart.txt |  17 -
 .../bindings/serial/rda,8810pl-uart.yaml           |  46 +++
 .../bindings/soc/samsung/exynos-usi.yaml           |   4 +
 .../devicetree/bindings/soc/ti/ti,pruss.yaml       |  15 +-
 .../bindings/sound/amlogic,gx-sound-card.yaml      |   4 +-
 .../bindings/sound/google,sc7180-trogdor.yaml      |   6 +-
 .../devicetree/bindings/sound/imx-audio-card.yaml  |   7 +-
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |  10 +-
 .../bindings/sound/samsung,aries-wm8994.yaml       |   3 +-
 .../bindings/sound/samsung,midas-audio.yaml        |   2 -
 .../devicetree/bindings/sound/samsung,odroid.yaml  |   9 +-
 .../devicetree/bindings/sound/sound-dai.yaml       |  20 +
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |  11 +-
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |  13 +-
 .../devicetree/bindings/spi/spi-controller.yaml    |   4 +-
 .../bindings/thermal/thermal-cooling-devices.yaml  |   6 +-
 .../devicetree/bindings/thermal/thermal-idle.yaml  |   8 +-
 .../bindings/timer/arm,armv7m-systick.txt          |  26 --
 .../bindings/timer/arm,armv7m-systick.yaml         |  54 +++
 .../bindings/timer/nuvoton,npcm7xx-timer.txt       |  21 --
 .../bindings/timer/nuvoton,npcm7xx-timer.yaml      |  46 +++
 .../devicetree/bindings/timer/renesas,ostm.yaml    |   2 +
 .../devicetree/bindings/timer/sifive,clint.yaml    |   9 +-
 .../devicetree/bindings/trivial-devices.yaml       |   8 +-
 .../devicetree/bindings/ufs/cdns,ufshc.txt         |  32 --
 .../devicetree/bindings/ufs/cdns,ufshc.yaml        |  68 ++++
 .../devicetree/bindings/ufs/hisilicon,ufs.yaml     |  90 +++++
 .../devicetree/bindings/ufs/mediatek,ufs.yaml      |  67 ++++
 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 244 ++++++++++++
 .../bindings/ufs/samsung,exynos-ufs.yaml           |  13 +-
 .../devicetree/bindings/ufs/snps,tc-dwc-g210.yaml  |  51 +++
 .../devicetree/bindings/ufs/tc-dwc-g210-pltfrm.txt |  26 --
 .../devicetree/bindings/ufs/ti,j721e-ufs.yaml      |   7 +-
 .../devicetree/bindings/ufs/ufs-common.yaml        |  82 +++++
 Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  42 ---
 .../devicetree/bindings/ufs/ufs-mediatek.txt       |  45 ---
 Documentation/devicetree/bindings/ufs/ufs-qcom.txt |  63 ----
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  90 -----
 .../devicetree/bindings/usb/dwc3-cavium.txt        |   2 +-
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |   2 +-
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |   5 +-
 .../devicetree/bindings/usb/st,stusb160x.yaml      |   4 +-
 .../devicetree/bindings/usb/ti,keystone-dwc3.yaml  |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |  12 +-
 Documentation/devicetree/bindings/virtio/mmio.yaml |   2 +
 .../bindings/watchdog/fsl-imx7ulp-wdt.yaml         |   8 +-
 .../devicetree/bindings/writing-schema.rst         |  28 +-
 Documentation/devicetree/of_unittest.rst           |  27 +-
 MAINTAINERS                                        |  10 +-
 drivers/of/base.c                                  |  54 ---
 drivers/of/unittest.c                              |   2 +-
 include/dt-bindings/clock/alphascale,asm9260.h     |   2 +-
 include/dt-bindings/clock/axis,artpec6-clkctrl.h   |   2 +-
 include/dt-bindings/clock/boston-clock.h           |   3 +-
 include/dt-bindings/clock/marvell,mmp2.h           |   4 +-
 include/dt-bindings/clock/marvell,pxa168.h         |   4 +-
 include/dt-bindings/clock/marvell,pxa910.h         |   4 +-
 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h  |   2 +-
 include/dt-bindings/clock/stm32fx-clock.h          |   4 +-
 include/dt-bindings/clock/stratix10-clock.h        |   2 +-
 include/linux/of.h                                 |  10 -
 scripts/Makefile.lib                               |  25 +-
 scripts/dtc/Makefile                               |  13 -
 scripts/dtc/of_unittest_expect                     | 408 +++++++++++++++++++++
 scripts/dtc/update-dtc-source.sh                   |   2 +-
 208 files changed, 4441 insertions(+), 2034 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/fw-cfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/linux,dummy-virt.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/atmel-crypto.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos-mic.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos5433-decon.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos7-decon.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmiddc.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmiphy.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_mixer.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt
 delete mode 100644 Documentation/devicetree/bindings/display/msm/mdp4.txt
 create mode 100644 Documentation/devicetree/bindings/display/msm/mdp4.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos-hdmi-ddc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos-hdmi.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos-mixer.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-decon.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml
 create mode 100644 Documentation/devicetree/bindings/gnss/gnss-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/gnss/gnss.txt
 delete mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-at91.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
 create mode 100644 Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
 create mode 100644 Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-hdmi-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/sound-dai.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,armv7m-systick.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,armv7m-systick.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/hisilicon,ufs.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/snps,tc-dwc-g210.yaml
 delete mode 100644 Documentation/devicetree/bindings/ufs/tc-dwc-g210-pltfrm.txt
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
 delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-mediatek.txt
 delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-qcom.txt
 delete mode 100644 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
 create mode 100755 scripts/dtc/of_unittest_expect
