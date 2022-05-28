Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE70536BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 11:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiE1JfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiE1Jey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 05:34:54 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101D389A
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:34:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2fee010f509so68365147b3.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=76RlC7gX8E6A8ItfLnra2HD/OQxgZ8IAdc0BjwuGpSY=;
        b=eavNOBxEb4iltDEGTtGijDia+qY08IU2T1/ruK+TejWrES1+Fwwd1FfQ2jlN9zs6l6
         D1pxAWH0NrxC2PNpUZMbxaqFGJ8E+l+qcCOwiNIlrl4cj1m1udkX+FPzoUWzb9jt7Rko
         3JbyRkGq3SzzW0Qyj81Bn9c1UlZKXImvm6xxLnP1Cbfk7uah2YEKJeP+sHK9IEO4bNKl
         pipaACcpVEvJFqFAnQW2BqS4RUrBhcQP6huc43oYxDr8Tt1PvXx/2H+AdY06h1cASVpj
         WmeMUXI6j1XHklsBSqc45kNP4IKkBp41FeQxbybYn79hu1y+wzDwbnL0YFmnwaSqnb46
         EQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=76RlC7gX8E6A8ItfLnra2HD/OQxgZ8IAdc0BjwuGpSY=;
        b=0OActGQ+6BSvmT8cuPOco50jdYwSmYqgAAk2+rczBsbZdGNN/N2sBxPrnT7JhaLgSO
         EqTA9yufQy/FX68pYZrXhCJAX7dssS4PG8Lo6lipOrArShok7hYl7QOp07UGmIXA1LHB
         U7YdziTQyiuFqgA4+GoH7ayMmbW0pCHq24lyPHJSsu9gXeq0oA3HHPzbq5gxu8rXCOoE
         E+hg8KAL1uShKcYK3iV8IaMC5xy3rrSq/88pwngbm2tDgiWPHkrPFXqFOmVjEmBIFPQR
         Nybt80a3GP6JzM+NYdZMv5IzTzoqKZWEF45yV3W/7kKPsXr4yRh0zCqWqi17mWni5BFp
         bfWw==
X-Gm-Message-State: AOAM53084vNVWsKP0gS9DsxwsZdQq7c/OIOv9RE8hdk3PKWnZQHHeaY9
        EfrbrlNeReLsO2bcbTRYtfshZTOcVho3lRdFIAATDQ==
X-Google-Smtp-Source: ABdhPJwDnf0DXk3Bphhz7F3OXQCia/xH4lPhjumLc3RvkIW6K6rEXfQ7S02zadLaHGJUTjYm5iZwym164/wbgaih7T8=
X-Received: by 2002:a81:7157:0:b0:300:5b38:4fd0 with SMTP id
 m84-20020a817157000000b003005b384fd0mr16176012ywc.437.1653730491332; Sat, 28
 May 2022 02:34:51 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 May 2022 11:34:40 +0200
Message-ID: <CACRpkdYvRzWUzySWR-VNo87_Kg0M_d7cKcyHruPW9fMTeet9XA@mail.gmail.com>
Subject: [GIT PULL] bulk pin control changes for v5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

these are the bulk changes for v5.19 pin control. It's pretty big
this time. Mostly due to (nice) Renesas refactorings.

I include a pulled immutable branch from Marc Z for immutable irqchips
that already came in thru GPIO.

I had to merge in v5.18-rc5 as described in the merge commit, depending
on the STM32 non-trivial fixed landed in RC5 that the new functionality
was building on. Other merges come from the usual trusted contributors
such as Andy Shevchenko and Geert Uytterhoeven.

Details in the signed tag.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a=
:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.19-1

for you to fetch changes up to 83969805cc716a7dc6b296c3fb1bc7e5cd7ca321:

  pinctrl: apple: Use a raw spinlock for the regmap (2022-05-25 09:37:44 +0=
200)

----------------------------------------------------------------
Pin control bulk changes for the v5.19 series:

Core changes:

- New helpers from Andy such as for_each_gpiochip_node() affecting both
  GPIO and pin control, improving a bunch of drivers in the process.

- Pulled in Marc Zyngiers work to make IRQ chips immutable, and started
  to apply fixups on top.

New drivers:

- New driver for Marvell MVEBU 98DX2530.

- New driver for Mediatek MT8195.

- Support Qualcomm PMX65 and PM6125.

- New driver for Qualcomm SC7280 LPASS pin control.

- New driver for Rockchip RK3588.

- New driver for NXP Freescale i.MXRT1170.

- New driver for Mediatek MT6795 Helio X10.

Improvements:

- Several Aspeed G6 cleanups and non-critical fixes.

- Thorought refactoring of some of the ever improving Renesas drivers.

- Clean up Mediatek MT8192 bindings a bit.

- PWM output and clock monitoring in the Ocelot LAN966x driver.

- Thorough refactoring and cleanup of the Ralink drivers such as
  RT2880, RT3883, RT305X, MT7620, MT7621, MT7628 splitting these into prope=
r
  sub-drivers.

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: pinctrl: Convert i.MX7D to json-schema

Andy Shevchenko (30):
      gpiolib: Introduce for_each_gpiochip_node() loop helper
      gpiolib: Introduce gpiochip_node_count() helper
      pinctrl: stm32: Replace custom code by gpiochip_node_count() call
      pinctrl: stm32: Switch to use for_each_gpiochip_node() helper
      pinctrl: renesas: rza1: Replace custom code by gpiochip_node_count() =
call
      pinctrl: renesas: rza1: Switch to use for_each_gpiochip_node() helper
      pinctrl: npcm7xx: Switch to use for_each_gpiochip_node() helper
      pinctrl: samsung: Drop redundant node parameter in
samsung_banks_of_node_get()
      pinctrl: samsung: Switch to use for_each_gpiochip_node() helper
      gpiolib: Introduce a helper to get first GPIO controller node
      pinctrl: armada-37xx: Switch to use fwnode instead of of_node
      pinctrl: armada-37xx: Reuse GPIO fwnode in armada_37xx_irqchip_regist=
er()
      pinctrl: meson: Rename REG_* to MESON_REG_*
      pinctrl: meson: Enable COMPILE_TEST
      pinctrl: meson: Replace custom code by gpiochip_node_count() call
      Merge branch 'irq/gpio-immutable' of
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
intel/pinctrl
      pinctrl: nomadik: Setup parent device and get rid of unnecessary
of_node assignment
      pinctrl: equilibrium: Switch to use fwnode instead of of_node
      pinctrl: microchip-sgpio: Switch to use fwnode instead of of_node
      pinctrl: broxton: Add module alias for Intel Apollo Lake
      pinctrl: stm32: Unshadow np variable in stm32_pctl_probe()
      Documentation: gpio: Fix IRQ mask and unmask examples
      Documentation: gpio: Advertise irqd_to_hwirq() helper in the examples
      pinctrl: baytrail: make irq_chip immutable
      pinctrl: cherryview: make irq_chip immutable
      pinctrl: lynxpoint: make irq_chip immutable
      pinctrl: cherryview: Use GPIO chip pointer in chv_gpio_irq_mask_unmas=
k()
      pinctrl: intel: make irq_chip immutable
      pinctrl: intel: Drop unused irqchip member in struct intel_pinctrl
      pinctrl: intel: Fix kernel doc format, i.e. add return sections

AngeloGioacchino Del Regno (2):
      dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl bindings
      pinctrl: mediatek: Add pinctrl driver for MT6795 Helio X10

Ar=C4=B1n=C3=A7 =C3=9CNAL (14):
      pinctrl: ralink: rename MT7628(an) functions to MT76X8
      pinctrl: ralink: rename pinctrl-rt2880 to pinctrl-ralink
      pinctrl: ralink: rename pinmux functions to pinctrl
      pinctrl: ralink: rename pinctrl-rt288x to pinctrl-rt2880
      pinctrl: ralink: rename variable names for functions on MT7620 and MT=
7621
      pinctrl: ralink: rename driver names to subdrivers
      pinctrl: ralink: add new compatible strings for each pinctrl subdrive=
r
      MAINTAINERS: add Ralink pinctrl driver
      mips: dts: ralink: mt7621: use the new compatible string for
MT7621 pinctrl
      dt-bindings: pinctrl: rt2880: fix binding name, pin groups and functi=
ons
      dt-bindings: pinctrl: add binding for Ralink MT7620 pinctrl
      dt-bindings: pinctrl: add binding for Ralink MT7621 pinctrl
      dt-bindings: pinctrl: add binding for Ralink RT305X pinctrl
      dt-bindings: pinctrl: add binding for Ralink RT3883 pinctrl

Bhupesh Sharma (2):
      dt-bindings: qcom,pdc: Add compatible for SM8150
      pinctrl: qcom: sm8150: Specify PDC map

Biju Das (2):
      dt-bindings: pinctrl: renesas: Document RZ/G2UL pinctrl
      pinctrl: renesas: rzg2l: Add RZ/G2UL support

Caleb Connolly (3):
      pinctrl/rockchip: support deferring other gpio params
      pinctrl/rockchip: support setting input-enable param
      gpio/rockchip: handle deferring input-enable pinconfs

Chris Packham (2):
      dt-bindings: pinctrl: mvebu: Document bindings for AC5
      pinctrl: mvebu: pinctrl driver for 98DX2530 SoC

Fabien Dessenne (3):
      pinctrl: stm32: improve bank clocks management
      pinctrl: stm32: improve debugfs information of pinconf-pins entry
      pinctrl: stm32: prevent the use of the secure protected pins

Fabien Parent (1):
      pinctrl: mediatek: mt8195: enable driver on mtk platforms

Geert Uytterhoeven (59):
      pinctrl: renesas: Simplify multiplication/shift logic
      pinctrl: renesas: checker: Rework drive and bias pin iteration
      pinctrl: renesas: r8a77990: Add RPC pins, groups, and functions
      pinctrl: renesas: r8a77995: Add QSPI and RPC pins, groups, and functi=
ons
      pinctrl: renesas: Remove unneeded #include <linux/init.h>
      pinctrl: renesas: rzg2l: Restore pin config order
      pinctrl: renesas: r8a779a0: Fix GPIO function on I2C-capable pins
      pinctrl: renesas: r8a779f0: Fix GPIO function on I2C-capable pins
      pinctrl: renesas: r8a77470: Use fixed-width description for IPSR regs
      pinctrl: renesas: Add shorthand for reserved register fields
      pinctrl: renesas: rmobile: Mark unused PORTCR bits reserved
      pinctrl: renesas: emev2: Use shorthands for reserved fields
      pinctrl: renesas: r8a77470: Use shorthands for reserved fields
      pinctrl: renesas: r8a7778: Use shorthands for reserved fields
      pinctrl: renesas: r8a7779: Use shorthands for reserved fields
      pinctrl: renesas: r8a7790: Use shorthands for reserved fields
      pinctrl: renesas: r8a7791: Use shorthands for reserved fields
      pinctrl: renesas: r8a7792: Use shorthands for reserved fields
      pinctrl: renesas: r8a7794: Use shorthands for reserved fields
      pinctrl: renesas: r8a77950: Use shorthands for reserved fields
      pinctrl: renesas: r8a77951: Use shorthands for reserved fields
      pinctrl: renesas: r8a7796: Use shorthands for reserved fields
      pinctrl: renesas: r8a77965: Use shorthands for reserved fields
      pinctrl: renesas: r8a77970: Use shorthands for reserved fields
      pinctrl: renesas: r8a77980: Use shorthands for reserved fields
      pinctrl: renesas: r8a77990: Use shorthands for reserved fields
      pinctrl: renesas: r8a77995: Use shorthands for reserved fields
      pinctrl: renesas: r8a779a0: Use shorthands for reserved fields
      pinctrl: renesas: r8a779f0: Use shorthands for reserved fields
      pinctrl: renesas: sh7734: Use shorthands for reserved fields
      pinctrl: renesas: r8a73a4: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a7740: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a77470: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a7779: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a7792: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a77950: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a77951: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a77965: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a7796: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a77970: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a77980: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a77990: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a77995: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a779a0: Optimize fixed-width reserved fields
      pinctrl: renesas: r8a779f0: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7203: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7264: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7269: Optimize fixed-width reserved fields
      pinctrl: renesas: sh73a0: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7720: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7722: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7723: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7724: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7734: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7757: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7785: Optimize fixed-width reserved fields
      pinctrl: renesas: sh7786: Optimize fixed-width reserved fields
      pinctrl: renesas: checker: Add reserved field checks
      pinctrl: starfive: Make the irqchip immutable

Hector Martin (2):
      pinctrl: apple: Make it work as a module
      pinctrl: apple: Use a raw spinlock for the regmap

Jae Hyun Yoo (3):
      pinctrl: pinctrl-aspeed-g6: remove FWQSPID group in pinctrl
      dt-bindings: pinctrl: aspeed-g6: remove FWQSPID group
      dt-bindings: pinctrl: aspeed-g6: add FWQSPI function/group

Jesse Taube (2):
      dt-bindings: pinctrl: add i.MXRT1170 pinctrl Documentation
      pinctrl: freescale: Add i.MXRT1170 pinctrl driver support

Jianqun Xu (1):
      pinctrl/rockchip: add rk3588 support

Johan Jonker (1):
      dt-bindings: pinctrl: add rockchip,rk3036-pinctrl compatible string

Johnny Huang (1):
      pinctrl: pinctrl-aspeed-g6: add FWQSPI function-group

Krzysztof Kozlowski (9):
      pinctrl: max77620: drop unneeded MODULE_ALIAS
      pinctrl: mvebu: Fix irq_of_parse_and_map() return value
      pinctrl: tegra: tegra194: drop unused pin groups
      pinctrl: nuvoton: Fix irq_of_parse_and_map() return value
      dt-bindings: pinctrl: qcom,pmic-gpio: document PM8150L and PMM8155AU
      dt-bindings: pinctrl: qcom,pmic-gpio: fix matching pin config
      dt-bindings: pinctrl: qcom,pmic-gpio: describe gpio-line-names
      dt-bindings: pinctrl: qcom,pmic-gpio: add 'input-disable'
      dt-bindings: pinctrl: qcom,pmic-gpio: add 'gpio-reserved-ranges'

Lad Prabhakar (1):
      pinctrl: renesas: Select PINCTRL_RZG2L if ARCH_RZG2L is enabled

Linus Walleij (8):
      pinctrl: nomadik: Add new MC2 config
      Merge tag 'renesas-pinctrl-for-v5.19-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'v5.18-rc5' into devel
      Merge tag 'intel-gpio-v5.19-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel
into devel
      pinctrl: stm32: Fix up errorpath after merge
      Merge branch 'irq/gpio-immutable' of
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
devel
      Merge tag 'renesas-pinctrl-for-v5.19-tag2' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'intel-pinctrl-v5.19-2' of
gitolite.kernel.org:pub/scm/linux/kernel/git/pinctrl/intel into devel

Lv Ruyi (1):
      pinctrl: thunderbay: Use devm_platform_ioremap_resource()

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

Marijn Suijten (2):
      dt-bindings: pinctrl: qcom-pmic-gpio: Add pm6125 compatible
      pinctrl: qcom: spmi-gpio: Add pm6125 compatible

Michael Walle (6):
      dt-bindings: pinctrl: convert ocelot-pinctrl to YAML format
      pinctrl: ocelot: add pwm output option for LAN966x
      pinctrl: ocelot: add clock monitor option for LAN966x
      dt-bindings: pinctrl: ocelot: add reset property
      pinctrl: ocelot: add optional shared reset
      pinctrl: microchip-sgpio: make irq_chip immutable

N=C3=ADcolas F. R. A. Prado (4):
      dt-bindings: pinctrl: mt8192: Add wrapping node for pin configuration=
s
      dt-bindings: pinctrl: mt8192: Add mediatek,drive-strength-adv propert=
y
      dt-bindings: pinctrl: mt8192: Add mediatek,pull-up-adv property
      dt-bindings: pinctrl: mt8192: Add gpio-line-names property

Paul Cercueil (1):
      pinctrl: ingenic: Garbage-collect code paths for SoCs disabled by con=
fig

Qianggui Song (1):
      pinctrl: meson: fix unused variable warning

Rob Herring (2):
      dt-bindings: pinctrl: aspeed: Drop referenced nodes in examples
      dt-bindings: pinctrl: qcom: Drop 'maxItems' on 'wakeup-parent'

Rohit Agarwal (2):
      dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx65 support
      pinctrl: qcom-pmic-gpio: Add support for pmx65

Sebastian Reichel (3):
      dt-bindings: pinctrl: rockchip: add rk3588
      pinctrl/rockchip: add error handling for pull/drive register getters
      dt-bindings: pinctrl: rockchip: increase max amount of device functio=
ns

Srinivasa Rao Mandadapu (7):
      dt-bindings: pinctrl: qcom: Update lpass lpi file name to SoC specifi=
c
      dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi pinctrl bindings
      pinctrl: qcom: Update macro name to LPI specific
      pinctrl: qcom: Update lpi pin group custiom functions with
framework generic functions
      pinctrl: qcom: Extract chip specific LPASS LPI code
      pinctrl: qcom: Add SC7280 lpass pin configuration
      pinctrl: qcom: Update clock voting as optional

Stefan Wahren (2):
      gpiolib: of: Introduce hook for missing gpio-ranges
      pinctrl: bcm2835: implement hook for missing gpio-ranges

Wolfram Sang (2):
      pinctrl: renesas: Allow up to 10 fields for drive_regs
      pinctrl: renesas: r8a77990: Add drive-strength

Yang Yingliang (2):
      pinctrl: renesas: core: Fix possible null-ptr-deref in
sh_pfc_map_resources()
      pinctrl: renesas: rzn1: Fix possible null-ptr-deref in
sh_pfc_map_resources()

zhaoxiao (1):
      pinctrl: berlin: bg4ct: Use devm_platform_*ioremap_resource() APIs

 .../bindings/interrupt-controller/qcom,pdc.txt     |    1 +
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |   81 +-
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |    4 +-
 .../bindings/pinctrl/fsl,imx7d-pinctrl.txt         |   87 -
 .../bindings/pinctrl/fsl,imx7d-pinctrl.yaml        |  113 ++
 .../devicetree/bindings/pinctrl/fsl,imxrt1170.yaml |   77 +
 .../bindings/pinctrl/marvell,ac5-pinctrl.yaml      |   72 +
 .../bindings/pinctrl/mediatek,pinctrl-mt6795.yaml  |  224 +++
 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt       |   42 -
 .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml      |  116 ++
 .../bindings/pinctrl/pinctrl-mt8192.yaml           |  155 +-
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |  287 +++-
 .../bindings/pinctrl/qcom,qcm2290-pinctrl.yaml     |    3 +-
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     |  115 ++
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      |    3 +-
 .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml      |    3 +-
 ...trl.yaml =3D> qcom,sm8250-lpass-lpi-pinctrl.yaml} |    2 +-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      |    3 +-
 .../bindings/pinctrl/qcom,tlmm-common.yaml         |    1 -
 .../bindings/pinctrl/ralink,mt7620-pinctrl.yaml    |   91 ++
 ...2880-pinmux.yaml =3D> ralink,mt7621-pinctrl.yaml} |   27 +-
 .../bindings/pinctrl/ralink,rt2880-pinctrl.yaml    |   68 +
 .../bindings/pinctrl/ralink,rt305x-pinctrl.yaml    |   92 ++
 .../bindings/pinctrl/ralink,rt3883-pinctrl.yaml    |   71 +
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    |    5 +-
 .../bindings/pinctrl/rockchip,pinctrl.yaml         |    4 +-
 Documentation/driver-api/gpio/driver.rst           |  181 ++-
 MAINTAINERS                                        |    7 +
 arch/mips/boot/dts/ralink/mt7621.dtsi              |    2 +-
 drivers/gpio/TODO                                  |   19 +
 drivers/gpio/gpio-pl061.c                          |   32 +-
 drivers/gpio/gpio-rockchip.c                       |   29 +-
 drivers/gpio/gpio-tegra186.c                       |   32 +-
 drivers/gpio/gpiolib-of.c                          |    5 +
 drivers/gpio/gpiolib.c                             |   13 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c         |   17 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   18 +
 drivers/pinctrl/berlin/berlin-bg4ct.c              |    3 +-
 drivers/pinctrl/freescale/Kconfig                  |    7 +
 drivers/pinctrl/freescale/Makefile                 |    1 +
 drivers/pinctrl/freescale/pinctrl-imxrt1170.c      |  349 ++++
 drivers/pinctrl/intel/pinctrl-baytrail.c           |   42 +-
 drivers/pinctrl/intel/pinctrl-broxton.c            |    1 +
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   66 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   45 +-
 drivers/pinctrl/intel/pinctrl-intel.h              |    2 -
 drivers/pinctrl/intel/pinctrl-lynxpoint.c          |   26 +-
 drivers/pinctrl/mediatek/Kconfig                   |    8 +
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6795.c          |  623 +++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6795.h      | 1698 ++++++++++++++++=
++++
 drivers/pinctrl/meson/Kconfig                      |    2 +-
 drivers/pinctrl/meson/pinctrl-meson-s4.c           |    3 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |   52 +-
 drivers/pinctrl/meson/pinctrl-meson.h              |   28 +-
 drivers/pinctrl/mvebu/Kconfig                      |    4 +
 drivers/pinctrl/mvebu/Makefile                     |    1 +
 drivers/pinctrl/mvebu/pinctrl-ac5.c                |  261 +++
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |   36 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c   |    7 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |    2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |  142 +-
 drivers/pinctrl/pinctrl-amd.c                      |   11 +-
 drivers/pinctrl/pinctrl-apple-gpio.c               |   31 +-
 drivers/pinctrl/pinctrl-equilibrium.c              |   11 +-
 drivers/pinctrl/pinctrl-equilibrium.h              |   10 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |  118 +-
 drivers/pinctrl/pinctrl-max77620.c                 |    1 -
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |   16 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |   22 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  532 +++++-
 drivers/pinctrl/pinctrl-rockchip.h                 |  177 +-
 drivers/pinctrl/pinctrl-starfive.c                 |   11 +-
 drivers/pinctrl/pinctrl-thunderbay.c               |    7 +-
 drivers/pinctrl/qcom/Kconfig                       |   19 +
 drivers/pinctrl/qcom/Makefile                      |    2 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |  309 +---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h           |   86 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   53 +-
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c    |  167 ++
 drivers/pinctrl/qcom/pinctrl-sm8150.c              |   22 +
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c    |  163 ++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    2 +
 drivers/pinctrl/ralink/Kconfig                     |   28 +-
 drivers/pinctrl/ralink/Makefile                    |    4 +-
 drivers/pinctrl/ralink/pinctrl-mt7620.c            |  302 ++--
 drivers/pinctrl/ralink/pinctrl-mt7621.c            |   76 +-
 drivers/pinctrl/ralink/pinctrl-ralink.c            |  349 ++++
 .../pinctrl/ralink/{pinmux.h =3D> pinctrl-ralink.h}  |   16 +-
 drivers/pinctrl/ralink/pinctrl-rt2880.c            |  381 +----
 drivers/pinctrl/ralink/pinctrl-rt288x.c            |   60 -
 drivers/pinctrl/ralink/pinctrl-rt305x.c            |   66 +-
 drivers/pinctrl/ralink/pinctrl-rt3883.c            |   50 +-
 drivers/pinctrl/renesas/Kconfig                    |    7 +-
 drivers/pinctrl/renesas/core.c                     |  117 +-
 drivers/pinctrl/renesas/gpio.c                     |    1 -
 drivers/pinctrl/renesas/pfc-emev2.c                |   60 +-
 drivers/pinctrl/renesas/pfc-r8a73a4.c              |   58 +-
 drivers/pinctrl/renesas/pfc-r8a7740.c              |   74 +-
 drivers/pinctrl/renesas/pfc-r8a77470.c             |  176 +-
 drivers/pinctrl/renesas/pfc-r8a7778.c              |   98 +-
 drivers/pinctrl/renesas/pfc-r8a7779.c              |   82 +-
 drivers/pinctrl/renesas/pfc-r8a7790.c              |  110 +-
 drivers/pinctrl/renesas/pfc-r8a7791.c              |  111 +-
 drivers/pinctrl/renesas/pfc-r8a7792.c              |  231 +--
 drivers/pinctrl/renesas/pfc-r8a7794.c              |   97 +-
 drivers/pinctrl/renesas/pfc-r8a77950.c             |  170 +-
 drivers/pinctrl/renesas/pfc-r8a77951.c             |  169 +-
 drivers/pinctrl/renesas/pfc-r8a7796.c              |  166 +-
 drivers/pinctrl/renesas/pfc-r8a77965.c             |  166 +-
 drivers/pinctrl/renesas/pfc-r8a77970.c             |  136 +-
 drivers/pinctrl/renesas/pfc-r8a77980.c             |  107 +-
 drivers/pinctrl/renesas/pfc-r8a77990.c             |  252 +--
 drivers/pinctrl/renesas/pfc-r8a77995.c             |  229 +--
 drivers/pinctrl/renesas/pfc-r8a779a0.c             |  246 ++-
 drivers/pinctrl/renesas/pfc-r8a779f0.c             |  121 +-
 drivers/pinctrl/renesas/pfc-sh7203.c               |   53 +-
 drivers/pinctrl/renesas/pfc-sh7264.c               |  104 +-
 drivers/pinctrl/renesas/pfc-sh7269.c               |   82 +-
 drivers/pinctrl/renesas/pfc-sh73a0.c               |   87 +-
 drivers/pinctrl/renesas/pfc-sh7720.c               |   57 +-
 drivers/pinctrl/renesas/pfc-sh7722.c               |  203 +--
 drivers/pinctrl/renesas/pfc-sh7723.c               |   71 +-
 drivers/pinctrl/renesas/pfc-sh7724.c               |    8 +-
 drivers/pinctrl/renesas/pfc-sh7734.c               |  116 +-
 drivers/pinctrl/renesas/pfc-sh7757.c               |   96 +-
 drivers/pinctrl/renesas/pfc-sh7785.c               |   61 +-
 drivers/pinctrl/renesas/pfc-sh7786.c               |   22 +-
 drivers/pinctrl/renesas/pfc-shx3.c                 |    1 -
 drivers/pinctrl/renesas/pinctrl-rza1.c             |   47 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |  200 ++-
 drivers/pinctrl/renesas/pinctrl-rzn1.c             |   10 +-
 drivers/pinctrl/renesas/pinctrl.c                  |    1 -
 drivers/pinctrl/renesas/sh_pfc.h                   |   24 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |    8 +-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c          |    2 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |    4 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   30 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  274 ++--
 drivers/pinctrl/stm32/pinctrl-stm32.h              |   15 +-
 drivers/pinctrl/stm32/pinctrl-stm32mp135.c         |    3 +-
 drivers/pinctrl/stm32/pinctrl-stm32mp157.c         |    2 +-
 drivers/pinctrl/tegra/pinctrl-tegra194.c           |    9 -
 include/dt-bindings/pinctrl/mt6795-pinfunc.h       |  908 +++++++++++
 include/linux/gpio/driver.h                        |   56 +-
 include/linux/irq.h                                |    2 +
 kernel/irq/debugfs.c                               |    1 +
 148 files changed, 9612 insertions(+), 4545 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170=
.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yam=
l
 rename Documentation/devicetree/bindings/pinctrl/{qcom,lpass-lpi-pinctrl.y=
aml
=3D> qcom,sm8250-lpass-lpi-pinctrl.yaml} (97%)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{ralink,rt2880-pinmux.yam=
l
=3D> ralink,mt7621-pinctrl.yaml} (63%)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imxrt1170.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6795.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6795.h
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-ac5.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
 create mode 100644 drivers/pinctrl/ralink/pinctrl-ralink.c
 rename drivers/pinctrl/ralink/{pinmux.h =3D> pinctrl-ralink.h} (75%)
 delete mode 100644 drivers/pinctrl/ralink/pinctrl-rt288x.c
 create mode 100644 include/dt-bindings/pinctrl/mt6795-pinfunc.h
