Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A300C50E5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbiDYQ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243495AbiDYQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:43 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B611F95A;
        Mon, 25 Apr 2022 09:24:39 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MUYKb-1nIJRE0KXL-00RGvb;
 Mon, 25 Apr 2022 18:24:07 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH v2 00/14] ARM: dts: imx6ull-colibri: device tree improvements
Date:   Mon, 25 Apr 2022 18:23:42 +0200
Message-Id: <20220425162356.176665-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eGf8AHf/y2rPOEx6ITKWN/Lm8bjRyQ2/CVBjXTubcBaZawF+ST7
 hPw8ZPIXlneemNmGEKTjRNGozzuZKjnFii5+A25nEhNgMbY0WEuntlyy1jl+8THdiE5freG
 ZZRWIW/jkiYMOZ1BHlDp2NITsmjjJ7sPu8LFxRYSE85/PyL8b/E6nsekhFvkPXRCaYHItDc
 bEi1hvKn7pMldbbbS4E+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O2pXqmF82Xk=:iWjizIX+np9V8CmtU7EnpO
 DBOu43A1mvZHRETSlOgdH+6nHOpn3Pl40OWDXFkCGrX0DuZMAMItQzE8nRHHlQZvmdgEiJJty
 jsfCaiBVoP/kEifcovRJcwVp+1cybJoXeOkql4zlyDnQAkqLMrM8UgVF7alEH06+CmuO8VMVL
 kxeeDoRqJf8p+1RO6dOL+2C9tl06qx+ow80hvJL5DeNJypxGQcvIjYk7O4a4jpwB3sZObAV17
 oIdWaf5QSiN1XizI6MEO8WvyfNnwkzmYE4wHMVOzhzg0rzVPAIE5ZYfmgzeIeEuQx4qz0sBOc
 9YPcvLYsIzj++9qOspiykodDUyP5lTmTP2PHk6DR++QMhbR4H4Qr39oFqWmTVvq2qkcssckge
 eq6MF8cNRBzqMZnRtbGR6PYIKOiJoaCdr+BPokGQzbi/W8gcXu2W7GCL9k87qa3UI70ZaTVyJ
 RajFtbIIU8TL74IpXsmNW3NcGeNGKz9ZfS2bw+QjDE/SMC/ifBLzdQXgLRYA0ulqdiN+j0YUx
 XDkeuDgTyoV9LMuvTvlr9WOtYCNiHRZmf01cI124HWWps3+oDZZr87SF1xPXqavRHl3l6GoRm
 O/x4K/FEKb+NJs/P7UBs3b2V4uGi5kjOsm2GN0OZV6dcpDCil2d4/T52F0Ljp3Wto+rSLQQi9
 XVg65mNqrr9A7o3mncRlU7ysFM0M9VaBwNOEZ/4a06Bsss9+YUkN5TQOc440SwsqqKmw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This is a general update of the Colibri iMX6ULL device tree files.

The Toradex Colibri family is composed of a SoM that can be plugged on
various carrier boards, with carrier boards allowing multiple optional
accessories (e.g. display, camera, ...).

The device tree sources are structured into a SoM dtsi and a carrier dts
which then includes the SoM dtsi. The SoM dtsi defines and enables the
functionality self-contained on the SoM and prepares for the
functionality provided by the carrier HW or accessories so that the
carrier dts then can enable or amend nodes provided. Accessories are
enabled in overlays depending on HW configuration.

Please find the following colibri-imx6ull device trees improvements:

- MMC/SD
The original Colibri specification only defined 3.3 volt TTL signaling
and relied on external on-carrier pull-ups for the SD_DATA[0..3] lines.
The latest carrier boards like Iris V2 on the other hand are now UHS-I
compliant by leaving such external on-carrier pull-ups away relying on
module- or even SoC-level ones which pull up to resp. signaling voltage.
In such cases, the carrier board-level device tree may explicitly delete
the no-1-8-v property to enable full UHS-I support.
Also, fix SD/MMC regulator for the carrier boards using UHS-I modes.

- FEC
Provide a proper phy-supply for the FEC, actually switched by the 50 Mhz
RMII interface clock using a regulator-fixed-clock that is now properly
stated. The reference commit for such regulator can be found at commit
8959e5324485 ("regulator: fixed: add possibility to enable by clock").

- I2C
Switched on 22 kOhm pull-ups and lower the I2C frequency to 40 kHz to
get more reliable communication.

- Atmel Touchscreen
The Toradex 7" Capacitive and 10" LVDS touch screens are Atmel MXT
peripherals available on the I2C bus for touchscreen events. Add
atmel_mxt_ts node to the module-level device tree. Also, provide pinmux
configuration for the INT/RST inputs from SODIMM pins 106/107 for most
carrier boards or an external touchscreen adapter inputs configured to
SODIMM pins 28/30.

Changes in v2:
- Fixed pinctrl node names as suggested by Shawn.
- Fixed long line as pointed out by Rob's bot.
- Added V3 to Colibri Evaluation Board as done elsewhere.
- Fix alphabetical node order as suggested by Shawn.
- Dropped [PATCH v1 02/14] ARM: dts: imx6ull-colibri: fix vqmmc
  regulator which already got applied by Shawn. Thanks!
- New commit with pinctrl node name improvements as suggested by Shawn.

Denys Drozdov (5):
  ARM: dts: imx6ull-colibri: add touchscreen device nodes
  ARM: dts: imx6ull-colibri: update device trees to support overlays
  dt-bindings: arm: fsl: add toradex,colibri-imx6ull
  ARM: dts: imx6ull-colibri: add support for toradex iris carrier boards
  ARM: dts: imx6ull-colibri: add support for toradex aster carrier
    boards

Marcel Ziswiler (4):
  ARM: dts: imx6ull-colibri: fix nand bch geometry
  ARM: dts: imx6ull-colibri: add/update some comments
  ARM: dts: imx6ull-colibri: move gpio-keys node to som dtsi
  ARM: dts: imx6ull-colibri: improve pinctrl node names

Max Krummenacher (1):
  ARM: dts: imx6ull-colibri: change touch i2c parameters

Oleksandr Suvorov (1):
  ARM: dts: imx6ull-colibri: add gpio-line-names

Philippe Schenker (3):
  ARM: dts: imx6ull-colibri: use pull-down for adc pins
  ARM: dts: imx6ull-colibri: add phy-supply to fec
  ARM: dts: imx6ull-colibri: update usdhc1 pixmux and signaling

 .../devicetree/bindings/arm/fsl.yaml          |  25 +-
 arch/arm/boot/dts/Makefile                    |   9 +
 arch/arm/boot/dts/imx6ull-colibri-aster.dts   |  20 ++
 arch/arm/boot/dts/imx6ull-colibri-aster.dtsi  | 145 +++++++++
 .../boot/dts/imx6ull-colibri-emmc-aster.dts   |  17 ++
 .../boot/dts/imx6ull-colibri-emmc-iris-v2.dts |  17 ++
 .../boot/dts/imx6ull-colibri-emmc-iris.dts    |  17 ++
 .../dts/imx6ull-colibri-emmc-nonwifi.dtsi     |   8 +-
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts |   6 +-
 .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi |  63 +---
 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts |  28 ++
 .../arm/boot/dts/imx6ull-colibri-iris-v2.dtsi |  27 ++
 arch/arm/boot/dts/imx6ull-colibri-iris.dts    |  20 ++
 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi   | 132 ++++++++
 .../arm/boot/dts/imx6ull-colibri-nonwifi.dtsi | 145 ++++++++-
 .../boot/dts/imx6ull-colibri-wifi-aster.dts   |  20 ++
 .../boot/dts/imx6ull-colibri-wifi-eval-v3.dts |   4 +-
 .../boot/dts/imx6ull-colibri-wifi-iris-v2.dts |  28 ++
 .../boot/dts/imx6ull-colibri-wifi-iris.dts    |  20 ++
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi   | 144 ++++++++-
 arch/arm/boot/dts/imx6ull-colibri.dtsi        | 285 ++++++++++++------
 21 files changed, 1008 insertions(+), 172 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-aster.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-aster.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts

-- 
2.35.1

