Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B005008CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbiDNIyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbiDNIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:08 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4A03EA94;
        Thu, 14 Apr 2022 01:51:44 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MFc70-1njrxI0mQo-00H5x4;
 Thu, 14 Apr 2022 10:51:18 +0200
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
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH v1 00/14] ARM: dts: imx6ull-colibri: device tree improvements
Date:   Thu, 14 Apr 2022 10:50:52 +0200
Message-Id: <20220414085106.18621-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WE16+ZQJRmZcKEpcR+IBZAwg/kPIhDKQlWD6Xd3hAlZtkaA2iCg
 kS+XkflY2jpGPPUAZcVPQWdVu6Tp31Iai7cUNFkdhTVxMYaH4hQSXRj03aTjg8m0KMXSuhM
 hfK4B/ltMVbENFJarCyOvvGRe66cX2/KbJWx6XkmD3Vz4qNV5rll0FJn90Smlu5t0XRA79s
 b+59wn7Wv7bVmx8in66YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QmARRcSywKk=:L7Vr7YsBqbSfU+1H154dEH
 prT/y3sSEKljD8ZPC4e6bxTr3X2O6gnt2uolcTQ++CVP/DW5SGyO+zKnUPQ6jxbQuw690t6/M
 rVvpgrwgtHpRPTT280oC0kDrt5ZCQalcoTZ7QPwswDYYRsJw6uv1RmJEmsfQIyvMQuYC8NFjR
 F/MDi3XTt6sd23FmszeojmyXJ9OP5zw6Qt6MwYniTIgMFQNY7WBQ2sQFtkKyfDZCMMT5ygjCz
 m78lu8jM0RA2kU3ZeCcRK9PMoNeSn9Y7eOkx7PLe2lR6hgKNByY+lx6SGcwBvwIfO6PpBmp4g
 F+xHjb9gKmNZDGPg+/l7nGt8J2BdkCTUnFmK6862oct4j1Kowj5rieKRVWcuDYqoWDZGW/Lsu
 cAr1t9gdMAyJWlafzLTsdMYAwnj8z6ib3jAExdxtlR7Lp/xvf2XgLLCwvobBgQRkVcEvngHKp
 NHmsk6qGih2Pk0bxTY9U5rdTCinZBFPC5F9t2sUgR1GbCZisCnGyylFfFY+0S4rcVko7Cifug
 8GvKDb+3lRKViVojl/V8AUuLShycXI3/N8VDYxW/1v3nT6itrSK+4Dzaq5t/6se+fWLGf2PK3
 8M30zIXSjWI2cCfUKtBMdGdV6Nfq5kcBI8dIq2ScYuRQJCA4CZ3nd60/xP7cHOgro0uHBjlTh
 F1fSuyCl/iLp8z3+zRd4V2RGOkL0tsM799ybZz1Tg4FHrzdQZ7i3fBNjOWDgvmviIxS0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


Denys Drozdov (5):
  ARM: dts: imx6ull-colibri: add touchscreen device nodes
  ARM: dts: imx6ull-colibri: update device trees to support overlays
  dt-bindings: arm: fsl: add toradex,colibri-imx6ull
  ARM: dts: imx6ull-colibri: add support for toradex iris carrier boards
  ARM: dts: imx6ull-colibri: add support for toradex aster carrier
    boards

Marcel Ziswiler (3):
  ARM: dts: imx6ull-colibri: fix nand bch geometry
  ARM: dts: imx6ull-colibri: add/update some comments
  ARM: dts: imx6ull-colibri: move gpio-keys node to som dtsi

Max Krummenacher (2):
  ARM: dts: imx6ull-colibri: fix vqmmc regulator
  ARM: dts: imx6ull-colibri: change touch i2c parameters

Oleksandr Suvorov (1):
  ARM: dts: imx6ull-colibri: add gpio-line-names

Philippe Schenker (3):
  ARM: dts: imx6ull-colibri: use pull-down for adc pins
  ARM: dts: imx6ull-colibri: add phy-supply to fec
  ARM: dts: imx6ull-colibri: update usdhc1 pixmux and signaling

 .../devicetree/bindings/arm/fsl.yaml          |  23 +-
 arch/arm/boot/dts/Makefile                    |   9 +
 arch/arm/boot/dts/imx6ull-colibri-aster.dts   |  20 ++
 arch/arm/boot/dts/imx6ull-colibri-aster.dtsi  | 145 +++++++++++++
 .../boot/dts/imx6ull-colibri-emmc-aster.dts   |  17 ++
 .../boot/dts/imx6ull-colibri-emmc-iris-v2.dts |  17 ++
 .../boot/dts/imx6ull-colibri-emmc-iris.dts    |  17 ++
 .../dts/imx6ull-colibri-emmc-nonwifi.dtsi     |   8 +-
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts |   6 +-
 .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi |  63 +-----
 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts |  28 +++
 .../arm/boot/dts/imx6ull-colibri-iris-v2.dtsi |  27 +++
 arch/arm/boot/dts/imx6ull-colibri-iris.dts    |  20 ++
 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi   | 132 ++++++++++++
 .../arm/boot/dts/imx6ull-colibri-nonwifi.dtsi | 145 ++++++++++++-
 .../boot/dts/imx6ull-colibri-wifi-aster.dts   |  20 ++
 .../boot/dts/imx6ull-colibri-wifi-eval-v3.dts |   4 +-
 .../boot/dts/imx6ull-colibri-wifi-iris-v2.dts |  28 +++
 .../boot/dts/imx6ull-colibri-wifi-iris.dts    |  20 ++
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi   | 144 ++++++++++++-
 arch/arm/boot/dts/imx6ull-colibri.dtsi        | 198 ++++++++++++++----
 21 files changed, 964 insertions(+), 127 deletions(-)
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

