Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175EA48C309
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352835AbiALLXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352826AbiALLXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:23:17 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2D0C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:23:15 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id o3-20020a9d4043000000b0058f31f4312fso2187045oti.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=60EL324WyEuZs4mccO90HhL4iVRn8nkiECOzGDzVvxg=;
        b=Fh4o21sJ/RT+cktOJHkSZNL49PEnZDUgOCgNxlHV/a+27H41noFu2Jaf2NcfQJFinT
         g8G+yRM/N2CK4r+s/b1HxDTKBbVAJaZqIhvMYYpTOyOxRKLAmxG1gdcSQbaaG4xR5EEf
         A63Bl8VncMu/nuMj9+O4Ykch5ky1sGdX8JtYChvAQrSLY2pxshZTt9gDUxm0NMhVrCfZ
         cf4ewWetFvcbdhwYVhsKieJXUEgdWlOKHS8H0MokH/2yT4eP+TyZOdw1ZUbuebZA7mvh
         mfexZHecKkAGhWwXJ/VzXPM0AWBMpHENtX8u8LT2OE2CBNNyJu/mwYiwqS2itEOAC7XO
         kmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=60EL324WyEuZs4mccO90HhL4iVRn8nkiECOzGDzVvxg=;
        b=Z2ihFfnnEplFeTF4GuONA02bTIT/O/eFvgLnrR0Kld9bsCpLJ1Qjy58E9BzC5wae51
         VYheDIKEvgJisSV0rMPl0I73xzOrUpfLsd1FABD+4k1xhNBw7apECNFQlB/GJOWY0nZv
         MCouxDoLC6ku3ruAjhypKexCIdrCp+SZMviIybtbAJ11k2+GbMp2c5hHW4gXdcxX8lgv
         /CB9nHVX330Q+uhzCoar/plq38syIi6IFDjzPunNqUmT6+DpvD8o0zO5E/A65fd2EEKs
         V4uyu42MVR9kdRux+1gsRlMcXt9vJpwvy8wtdkLNANNtZ8xk8GMlkaw//LeDqvSrwPb7
         s+WA==
X-Gm-Message-State: AOAM5337zIWGhf9kxwPimDxiDLZ3tECE+k7iqd9pGgaPPQU1ZXsXGJF5
        biWxAF4tGKrrJDYVbUgtZAKGgaieZhI/kabtmDLpxD6rkjFZ0A==
X-Google-Smtp-Source: ABdhPJzzoahWplu1OXW8xhZUPJEK57rIiADDO8KcjrbazTmJVLpWJ+4Ez26XLyDT600ALM2BwSnCwBQZ2sAnBuBOCdQ=
X-Received: by 2002:a9d:465:: with SMTP id 92mr6092562otc.35.1641986595034;
 Wed, 12 Jan 2022 03:23:15 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jan 2022 12:23:03 +0100
Message-ID: <CACRpkdaVGwu=Bo5bxVQYZXD-k+x++SuOTApGoK2a_S-1M4Q+nQ@mail.gmail.com>
Subject: [GIT PULL] pin control changes for v5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this is the big pin control pull request for v5.17.

Notices:

- There will be conflicts! Kconfig and Makefile conflicts due to
  some RISC-V Starfive patches getting merged through the
  SoC tree while we were tidying up the Kconfig and Makefile
  (to avoid merge conflicts, heh) there is a resolution in linux-next
  which was discussed and reviewed to be correct.

- Some new code is added for lib/string_helpers.c by long time
  lib contributor Andy Schevchenko.

- A patch affecting some broadcom device trees was ripped
  out last minute and sent as a fix as its absence was causing
  regressions on the Raspberry Pi, I chose not to revert it from
  the devel tree as it seemed more messy than just letting git
  sort out the zero textual diff to your tree, this isn't the prettiest
  but, you know: it happens.

- The most interesting new driver is maybe the Intel "Thunder
  Bay" SoC. In difference from what one may think this is not
  some laptop x86 chip but actually an Arm64-based computer
  vision (AI) chip and successor (I guess) to the previous Keem
  Bay. The main SoC support for this chips is forthcoming.

Please pull it in and enjoy the conflicts!

Yours,
Linus Walleij

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6=
:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.17-1

for you to fetch changes up to 7442936633bd1906a2571116ae334b68c56c8a72:

  pinctrl: imx: fix assigning groups names (2022-01-02 07:33:51 +0100)

----------------------------------------------------------------
Pin control bulk changes for the v5.17 kernel cycle

Core changes:

- New standard enumerator and corresponding device tree bindings
  for output impedance pin configuration. (Implemented and used
  in the Renesas rzg2l driver.)

- Cleanup of Kconfig and Makefile to be somewhat orderly and
  alphabetic.

New drivers:

- Samsung Exynos 7885 pin controller.

- Ocelot LAN966x pin controller.

- Qualcomm SDX65 pin controller.

- Qualcomm SM8450 pin controller.

- Qualcomm PM8019, PM8226 and PM2250 pin controllers.

- NXP/Freescale i.MXRT1050 pin controller.

- Intel Thunder Bay pin controller.

Enhancements:

- Introduction of the string library helper function
  "kasprintf_strarray()" and subsequent use in Rockchip, ST and
  Armada pin control drivers, as well as the GPIO mockup driver.

- The Ocelot pin controller has been extensively rewritten to
  use regmap and other modern kernel infrastructure.

- The Microchip SGPIO driver has been converted to use regmap.

- The SPEAr driver had been converted to use regmap.

- Substantial cleanups and janitorial on the Apple pin control
  driver that was merged for v5.16.

- Janitorial to remove of_node assignments in the GPIO portions
  that anyway get this handled in the GPIO core.

- Minor cleanups and improvements in several pin controllers.

----------------------------------------------------------------
Andy Shevchenko (23):
      lib/string_helpers: Introduce kasprintf_strarray()
      lib/string_helpers: Introduce managed variant of kasprintf_strarray()
      pinctrl/rockchip: Drop wrong kernel doc annotation
      pinctrl/rockchip: Use temporary variable for struct device
      pinctrl/rockchip: Make use of the devm_platform_get_and_ioremap_resou=
rce()
      pinctrl/rockchip: Convert to use dev_err_probe()
      pinctrl/rockchip: Switch to use devm_kasprintf_strarray()
      pinctrl: armada-37xx: Fix function name in the kernel doc
      pinctrl: armada-37xx: Use temporary variable for struct device
      pinctrl: armada-37xx: Make use of the devm_platform_ioremap_resource(=
)
      pinctrl: armada-37xx: Convert to use dev_err_probe()
      pinctrl: armada-37xx: Switch to use devm_kasprintf_strarray()
      pinctrl: st: Drop wrong kernel doc annotations
      pinctrl: st: Use temporary variable for struct device
      pinctrl: st: Make use of the devm_platform_ioremap_resource_byname()
      pinctrl: st: Convert to use dev_err_probe()
      pinctrl: st: Switch to use devm_kasprintf_strarray()
      pinctrl: zynqmp: Unify pin naming
      gpio: mockup: Switch to use kasprintf_strarray()
      pinctrl: cherryview: Use temporary variable for struct device
      pinctrl: Sort Kconfig and Makefile entries alphabetically
      pinctrl: Get rid of duplicate of_node assignment in the drivers
      pinctrl: Propagate firmware node from a parent device

Colin Foster (4):
      pinctrl: ocelot: combine get resource and ioremap into single call
      pinctrl: ocelot: update pinctrl to automatic base address
      pinctrl: ocelot: convert pinctrl to regmap
      pinctrl: microchip-sgpio: update to support regmap

Dan Carpenter (2):
      pinctrl: mediatek: uninitialized variable in mtk_pctrl_show_one_pin()
      pinctrl: mediatek: add a check for error in mtk_pinconf_bias_get_rsel=
()

David Virag (2):
      dt-bindings: pinctrl: samsung: Document Exynos7885
      pinctrl: samsung: Add Exynos7885 SoC specific data

Dominik Kobinski (1):
      dt-bindings: pinctrl: qcom: pmic-gpio: Document pm8226 compatible

Geert Uytterhoeven (3):
      pinctrl: renesas: rza1: Fix kerneldoc function names
      pinctrl: renesas: Remove unneeded locking around sh_pfc_read() calls
      pinctrl: renesas: r8a779a0: Align comments

Giulio Benetti (1):
      pinctrl: freescale: Add i.MXRT1050 pinctrl driver support

Hans Verkuil (2):
      pinctrl-bcm2835: don't call pinctrl_gpio_direction()
      pinctrl-sunxi: don't call pinctrl_gpio_direction()

Hans de Goede (3):
      pinctrl: baytrail: Set IRQCHIP_SET_TYPE_MASKED flag on the irqchip
      pinctrl: cherryview: Don't use selection 0 to mark an interrupt
line as unused
      pinctrl: cherryview: Do not allow the same interrupt line to be
used by 2 pins

Herve Codina (3):
      pinctrl: spear: spear: Convert to regmap
      pinctrl: spear: plgpio: Convert to regmap
      pinctrl: spear: plgpio: Introduce regmap phandle

Jesse Taube (1):
      dt-bindings: pinctrl: add i.MXRT1050 pinctrl binding doc

Joey Gouly (11):
      pinctrl: apple: fix some formatting issues
      pinctrl: apple: add missing comma
      pinctrl: apple: use C style comment
      pinctrl: apple: add missing bits.h header
      pinctrl: apple: handle regmap_read errors
      pinctrl: apple: make apple_gpio_get_direction more readable
      pinctrl: apple: give error label a specific name
      pinctrl: apple: remove gpio-controller check
      pinctrl: apple: don't set gpio_chip.of_node
      pinctrl: apple: use modulo rather than bitwise and
      pinctrl: apple: return an error if pinmux is missing in the DT

John Keeping (1):
      pinctrl/rockchip: fix gpio device creation

Julian Braha (1):
      pinctrl: aspeed: fix unmet dependencies on MFD_SYSCON for PINCTRL_ASP=
EED

Kavyasree Kotagiri (2):
      dt-bindings: pinctrl: ocelot: add lan966x SoC support
      pinctrl: ocelot: Extend support for lan966x

Konrad Dybcio (2):
      dt-bindings: pinctrl: qcom,pmic-gpio: Add compatible for PM8019
      pinctrl: qcom-pmic-gpio: Add support for pm8019

Kunihiko Hayashi (1):
      dt-bindings: pinctrl: uniphier: Add child node definitions to
describe pin mux and configuration

Lad Prabhakar (9):
      dt-bindings: pincfg-node: Add "output-impedance-ohms" property
      pinctrl: pinconf-generic: Add support for
"output-impedance-ohms" to be extracted from DT files
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add
output-impedance-ohms property
      pinctrl: renesas: rzg2l: Rename RZG2L_SINGLE_PIN_GET_PORT macro
      pinctrl: renesas: rzg2l: Add helper functions to read/write pin confi=
g
      pinctrl: renesas: rzg2l: Add support to get/set pin config for
GPIO port pins
      pinctrl: renesas: rzg2l: Rename PIN_CFG_* macros to match HW manual
      pinctrl: renesas: rzg2l: Add support to get/set drive-strength
and output-impedance-ohms
      pinctrl: samsung: Use platform_get_irq_optional() to get the interrup=
t

Lakshmi Sowjanya D (2):
      dt-bindings: pinctrl: Add bindings for Intel Thunderbay pinctrl drive=
r
      pinctrl: Add Intel Thunder Bay pinctrl driver

Linus Walleij (8):
      Merge tag 'intel-pinctrl-v5.17-2' of
gitolite.kernel.org:pub/scm/linux/kernel/git/pinctrl/intel into devel
      Merge tag 'v5.16-rc2' into devel
      Revert "dt-bindings: pinctrl: qcom: Add SDX65 pinctrl bindings"
      Merge tag 'renesas-pinctrl-for-v5.17-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      pinctrl: bcm2835: Silence uninit warning
      Merge tag 'intel-pinctrl-v5.17-3' of
gitolite.kernel.org:pub/scm/linux/kernel/git/pinctrl/intel into devel
      Merge tag 'renesas-pinctrl-for-v5.17-tag2' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'samsung-pinctrl-5.17' of
https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung into
devel

Loic Poulain (2):
      pinctrl: spmi-gpio: Add support for PM2250
      dt-bindings: qcom,pmic-gpio: Add pm2250 compatible string

Phil Elwell (1):
      ARM: dts: gpio-ranges property is now required

Prasad Sodagudi (1):
      pinctrl: qcom: Add egpio feature support

Rafa=C5=82 Mi=C5=82ecki (9):
      dt-bindings: pinctrl: convert controller description to the json-sche=
ma
      dt-bindings: pinctrl: use pinctrl.yaml
      pinctrl: imx: prepare for making "group_names" in "function_desc" con=
st
      pinctrl: keembay: comment process of building functions a bit
      pinctrl: keembay: rework loops looking for groups names
      pinctrl: add one more "const" for generic function groups
      pinctrl: imx: fix allocation result check
      pinctrl: bcm: ns: use generic groups & functions helpers
      pinctrl: imx: fix assigning groups names

Rajendra Nayak (1):
      pinctrl: qcom: sc7280: Add egpio support

Tinghan Shen (1):
      dt-bindings: pinctrl: mt8195: add wrapping node of pin configurations

Vamsi Krishna Lanka (3):
      dt-bindings: pinctrl: qcom: Add SDX65 pinctrl bindings
      pinctrl: qcom: Add SDX65 pincontrol driver
      dt-bindings: pinctrl: qcom: Add SDX65 pinctrl bindings

Vinod Koul (2):
      dt-bindings: pinctrl: qcom: Add SM8450 pinctrl bindings
      pinctrl: qcom: Add SM8450 pinctrl driver

Wei Yongjun (1):
      pinctrl: samsung: Make symbol 'exynos7885_pin_ctrl' static

kernel test robot (1):
      pinctrl: apple-gpio: fix flexible_array.cocci warnings

 .../bindings/pinctrl/actions,s500-pinctrl.yaml     |    3 +
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml       |    1 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    3 +
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |    3 +
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |    3 +
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |    3 +
 .../bindings/pinctrl/brcm,bcm6318-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/brcm,bcm63268-pinctrl.yaml    |    3 +
 .../bindings/pinctrl/brcm,bcm6328-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/brcm,bcm6358-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/brcm,bcm6362-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/brcm,bcm6368-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/brcm,ns-pinmux.yaml           |    3 +-
 .../bindings/pinctrl/canaan,k210-fpioa.yaml        |    7 +-
 .../bindings/pinctrl/cirrus,lochnagar.yaml         |    3 +
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml |    3 +
 .../bindings/pinctrl/fsl,imx8mm-pinctrl.yaml       |    3 +
 .../bindings/pinctrl/fsl,imx8mn-pinctrl.yaml       |    3 +
 .../bindings/pinctrl/fsl,imx8mp-pinctrl.yaml       |    3 +
 .../bindings/pinctrl/fsl,imx8mq-pinctrl.yaml       |    3 +
 .../bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml      |    3 +
 .../devicetree/bindings/pinctrl/fsl,imxrt1050.yaml |   79 +
 .../bindings/pinctrl/ingenic,pinctrl.yaml          |    8 +-
 .../devicetree/bindings/pinctrl/intel,lgm-io.yaml  |    3 +
 .../bindings/pinctrl/intel,pinctrl-thunderbay.yaml |  119 ++
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  |    3 +
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  |    3 +
 .../bindings/pinctrl/mediatek,mt6797-pinctrl.yaml  |    3 +
 .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml  |    3 +
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  |    3 +
 .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml  |    3 +
 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt       |    3 +-
 .../devicetree/bindings/pinctrl/pincfg-node.yaml   |    3 +
 .../bindings/pinctrl/pinctrl-bindings.txt          |   41 +-
 .../bindings/pinctrl/pinctrl-mt8192.yaml           |    3 +
 .../bindings/pinctrl/pinctrl-mt8195.yaml           |  341 ++--
 .../devicetree/bindings/pinctrl/pinctrl.yaml       |   45 +
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   |    3 +
 .../bindings/pinctrl/qcom,mdm9607-pinctrl.yaml     |    1 +
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |    3 +
 .../bindings/pinctrl/qcom,qcm2290-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      |    3 +
 .../bindings/pinctrl/qcom,sc8180x-pinctrl.yaml     |    1 +
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       |    3 +
 .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml       |  191 +++
 .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml      |    3 +
 .../bindings/pinctrl/qcom,sm6125-pinctrl.yaml      |    1 +
 .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml      |    1 +
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      |    3 +
 .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml      |    1 +
 .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml      |  143 ++
 .../bindings/pinctrl/qcom,tlmm-common.yaml         |    3 +
 .../bindings/pinctrl/ralink,rt2880-pinmux.yaml     |    3 +
 .../devicetree/bindings/pinctrl/renesas,pfc.yaml   |    3 +
 .../bindings/pinctrl/renesas,rza1-ports.yaml       |    3 +
 .../bindings/pinctrl/renesas,rza2-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    |    5 +
 .../bindings/pinctrl/renesas,rzn1-pinctrl.yaml     |    3 +
 .../bindings/pinctrl/rockchip,pinctrl.yaml         |    3 +
 .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
 .../pinctrl/socionext,uniphier-pinctrl.yaml        |   44 +-
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |    3 +
 .../bindings/pinctrl/toshiba,visconti-pinctrl.yaml |    5 +-
 .../bindings/pinctrl/xlnx,zynq-pinctrl.yaml        |    3 +
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml      |    3 +
 MAINTAINERS                                        |    5 +
 arch/arm/boot/dts/bcm2711.dtsi                     |    2 +
 arch/arm/boot/dts/bcm283x.dtsi                     |    2 +
 drivers/gpio/gpio-mockup.c                         |   23 +-
 drivers/pinctrl/Kconfig                            |  450 +++---
 drivers/pinctrl/Makefile                           |   46 +-
 drivers/pinctrl/actions/pinctrl-owl.c              |    1 -
 drivers/pinctrl/aspeed/Kconfig                     |    2 +-
 drivers/pinctrl/bcm/Kconfig                        |    2 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   15 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |    1 -
 drivers/pinctrl/bcm/pinctrl-ns.c                   |  163 +-
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c             |    1 -
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c         |    3 -
 drivers/pinctrl/cirrus/pinctrl-madera-core.c       |    5 +-
 drivers/pinctrl/freescale/Kconfig                  |    7 +
 drivers/pinctrl/freescale/Makefile                 |    1 +
 drivers/pinctrl/freescale/pinctrl-imx.c            |   17 +-
 drivers/pinctrl/freescale/pinctrl-imxrt1050.c      |  349 ++++
 drivers/pinctrl/intel/pinctrl-baytrail.c           |    2 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |  130 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c           |    7 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c   |    2 +
 drivers/pinctrl/mediatek/pinctrl-paris.c           |    7 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |   85 +-
 drivers/pinctrl/pinconf-generic.c                  |    2 +
 drivers/pinctrl/pinctrl-amd.c                      |    3 -
 drivers/pinctrl/pinctrl-apple-gpio.c               |  105 +-
 drivers/pinctrl/pinctrl-as3722.c                   |   13 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |    1 -
 drivers/pinctrl/pinctrl-at91.c                     |    1 -
 drivers/pinctrl/pinctrl-da9062.c                   |    6 +-
 drivers/pinctrl/pinctrl-digicolor.c                |    5 +-
 drivers/pinctrl/pinctrl-keembay.c                  |   87 +-
 drivers/pinctrl/pinctrl-max77620.c                 |   11 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |    1 -
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |   45 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |  486 +++++-
 drivers/pinctrl/pinctrl-oxnas.c                    |    1 -
 drivers/pinctrl/pinctrl-pic32.c                    |    2 +-
 drivers/pinctrl/pinctrl-rk805.c                    |   12 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  161 +-
 drivers/pinctrl/pinctrl-st.c                       |  116 +-
 drivers/pinctrl/pinctrl-stmfx.c                    |    1 -
 drivers/pinctrl/pinctrl-sx150x.c                   |    3 -
 drivers/pinctrl/pinctrl-thunderbay.c               | 1322 +++++++++++++++
 drivers/pinctrl/pinctrl-xway.c                     |    1 -
 drivers/pinctrl/pinctrl-zynqmp.c                   |   10 +-
 drivers/pinctrl/pinmux.c                           |    2 +-
 drivers/pinctrl/pinmux.h                           |    4 +-
 drivers/pinctrl/qcom/Kconfig                       |   18 +
 drivers/pinctrl/qcom/Makefile                      |    2 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   16 +-
 drivers/pinctrl/qcom/pinctrl-msm.h                 |   10 +
 drivers/pinctrl/qcom/pinctrl-sc7280.c              |   75 +-
 drivers/pinctrl/qcom/pinctrl-sdx65.c               |  967 +++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8450.c              | 1689 ++++++++++++++++=
++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    2 +
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           |    1 -
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c            |    1 -
 drivers/pinctrl/renesas/pfc-r8a779a0.c             |    4 +-
 drivers/pinctrl/renesas/pinctrl-rza1.c             |    6 +-
 drivers/pinctrl/renesas/pinctrl-rza2.c             |    1 -
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |  310 ++--
 drivers/pinctrl/renesas/pinctrl.c                  |    9 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     |   81 +
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   11 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    1 +
 drivers/pinctrl/spear/pinctrl-plgpio.c             |  149 +-
 drivers/pinctrl/spear/pinctrl-spear.c              |   10 +-
 drivers/pinctrl/spear/pinctrl-spear.h              |   12 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |    8 +-
 drivers/pinctrl/vt8500/pinctrl-wmt.c               |    1 -
 include/linux/pinctrl/pinconf-generic.h            |    3 +
 include/linux/string_helpers.h                     |    4 +
 lib/string_helpers.c                               |   64 +
 144 files changed, 7124 insertions(+), 1242 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050=
.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imxrt1050.c
 create mode 100644 drivers/pinctrl/pinctrl-thunderbay.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdx65.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8450.c
