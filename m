Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A455285D7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbiEPNst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240731AbiEPNsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:48:21 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECD139149;
        Mon, 16 May 2022 06:48:19 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MGCMz-1o4dJR24Pf-00FESy;
 Mon, 16 May 2022 15:47:51 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
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
        Stefan Agner <stefan@agner.ch>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH v2 00/24] ARM: dts: imx7-colibri: device tree improvements
Date:   Mon, 16 May 2022 15:47:10 +0200
Message-Id: <20220516134734.493065-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u3p4QYBrJIcPxKDVCWF2zgjBva5I01FDyxt+TVltHm5GD/cIGUd
 xynr4EPaKTsNv+hB6SP838uZrwKxeUo7s9UAygZC7++LdfEaIZDQ6YMDjctSBXAigsNe1Qx
 N684YimYjb+f2GRRKo+936TZ++RtCy6bMwF8vWiporJL6Tg7TZQHEjEeApbPhunfywbEXKC
 ZmN1yWrd9g+d+fmRW/eVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VdckVgwfshQ=:ajcHLGaJHuesGRXoMHgVkM
 XsO6Q9oil98Jj9jv1rDySk7R6BTXp35Mpr0093yE/NwTev8G37XkFwGOpJpTjWTDjvFwg88lp
 eTh/ne8PLkFZHpoXaRJuHJm4FRps8Nn2osvR0JbybNVCn5vpwRowNXh1TaBAj4i3Uge+U8YCB
 dzd+kQhLCQmffNI/lSbDVe68OvZxyKYUGD0SS9MlPpNFEJb++JGDbgsyMgeMZXqRh5NqjeKTl
 8hidOBhuLSojVvGF3+hm60KGqTvOcBikMUBvqZaeXioSTglB76qSCLkaDrMh8YmKox6EbN/qF
 WlITLmnbZG/kiQ9IHzlmm8bFOoLmOq0NkDwafY0JHiQ066XwRLuBClfgDMIaNSOtZSZCPvf5z
 fFO9HQdBkrbRJOO5uEoR+u9cc0YEQvfeUITx0zzWRug8W1imAmQ7BE7QPBeIuv5fQRDx+Cj0c
 gU2x7Tg/CXjr/UyCd/qcvCWTCrBF9c5H5US5AfljyyN9qNG4+9abfH0TcxgKYoyjKqvH9LrK1
 1+m9p5IBXc2I4IKpAdYJ311emXUofA/oXI+MZzqhmmUh+0MGZZOajevT56o9EnE30cikAZoPB
 FN7L/79b15OjLCDbs0otyQi0grdTKj8UttJ0vtQ9cJQEWa1TP8i8YS4VAV/2kK6aDjm8QR40G
 Hfn5HP5YVT0UNzFkyhwSs05BxRuXEeeWIBOqpA39pJCbBhw+Rn3ktP4L8bHh7hbWAbCE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This is a general update of the Colibri iMX7 device tree files.

The Toradex Colibri family is composed of a SoM that can be plugged on
various carrier boards, with carrier boards allowing multiple optional
accessories (e.g. display, camera, ...).

The device tree sources are structured into a SoM dtsi and a carrier dts
which then includes the SoM dtsi. The SoM dtsi defines and enables the
functionality self-contained on the SoM and prepares for the
functionality provided by the carrier HW or accessories so that the
carrier dts then can enable or amend nodes provided. Accessories are
enabled in overlays depending on HW configuration.

Please find the following colibri-imx7 device trees improvements:

- Display/Touch Functionality Overhaul
Rename display interface to match other modules to make it easier to
use device tree overlays.
The parallel RGB interface (lcdif) and all related stuff turn on in a
device tree overlay. Keep them disabled in the main devicetree.
As these subsystems are provided by module and not a part of boards,
move their definitions into the module-level devicetree.
Disable ad7879 touchscreen which turns on in a devic tree overlay.
Remains it disabled in the main devicetree.
The Toradex 7" Capacitive and 10" LVDS touch screens are Atmel MXT
peripherals available on the I2C bus for touchscreen events. Add
atmel_mxt_ts node to the module-level device tree. Also, provide pinmux
configuration for the INT/RST inputs from SODIMM pins 106/107 for most
carrier boards or an external touchscreen adapter inputs configured to
SODIMM pins 28/30.

- Ethernet Improvements
Add the MDIO bus with the respective PHY.
Add Ethernet aliases which is required to properly pass MAC address
from bootloader.
Add delay for on-module phy supply.

- USB Device/Host Switching
Add usb dual-role switching using extcon.

- MMC/SD
The original Colibri specification only defined 3.3 volt TTL signaling
and relied on external on-carrier pull-ups for the SD_DATA[0..3] lines.
The latest carrier boards like Iris V2 on the other hand are now UHS-I
compliant by leaving such external on-carrier pull-ups away relying on
module- or even SoC-level ones which pull up to resp. signaling voltage.
In such cases, the carrier board-level device tree may explicitly delete
the no-1-8-v property to enable full UHS-I support.
Also, fix SD/MMC regulator for the carrier boards using UHS-I modes.

- Add Iris and Iris V2 Carrier Board Device Trees
Add support for Toradex Iris carrier boards.

Changes in v2:
- Add Krzysztof's acked-by. Thanks!
- Revert change on arch/arm/boot/dts/imx6dl-colibri-iris.dts which
  slipped into this patch set by error.
- Re-based on top of Shawn's for-next.

Marcel Ziswiler (18):
  ARM: dts: imx7-colibri: overhaul display/touch functionality
  ARM: dts: imx7-colibri: add mdio phy node
  ARM: dts: imx7-colibri: move aliases, chosen, extcon and gpio-keys
  ARM: dts: imx7-colibri: move regulators
  ARM: dts: imx7-colibri: clean-up usdhc1 and add sleep config
  ARM: dts: imx7-colibri: move rtc node
  ARM: dts: imx7d-colibri-emmc: add cpu1 supply
  ARM: dts: imx7-colibri-eval-v3: correct can controller comment
  ARM: dts: imx7-colibri: disable adc2
  ARM: dts: imx7-colibri-aster: add ssp aka spi cs aka ss pins
  ARM: dts: imx7-colibri: add clarifying comments
  ARM: dts: imx7-colibri: alphabetical re-order
  ARM: dts: imx7-colibri: clean-up device enabling/disabling
  ARM: dts: imx7-colibri: remove leading zero from reg address
  ARM: dts: imx7-colibri: set regulator-name properties
  ARM: dts: imx7-colibri: clean-up iomuxc pinctrl group naming
  dt-bindings: arm: fsl: add toradex,colibri-imx7s/d/d-emmc-iris/-v2
  ARM: dts: imx7-colibri: add support for Toradex Iris carrier boards

Max Krummenacher (1):
  ARM: dts: imx7-colibri: add ethernet aliases

Oleksandr Suvorov (3):
  ARM: dts: imx7-colibri: improve licensing and compatible strings
  ARM: dts: imx7-colibri: improve wake-up with gpio key
  ARM: dts: imx7-colibri: add delay for on-module phy supply

Philippe Schenker (1):
  ARM: dts: imx7-colibri: add usb dual-role switching using extcon

Stefan Agner (1):
  ARM: dts: imx7-colibri: set lcdif clock source to video pll

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm/boot/dts/Makefile                    |   6 +
 arch/arm/boot/dts/imx7-colibri-aster.dtsi     | 142 +--
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi   | 156 +---
 arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi   | 112 +++
 arch/arm/boot/dts/imx7-colibri-iris.dtsi      | 108 +++
 arch/arm/boot/dts/imx7-colibri.dtsi           | 830 +++++++++++-------
 arch/arm/boot/dts/imx7d-colibri-aster.dts     |  30 +-
 .../arm/boot/dts/imx7d-colibri-emmc-aster.dts |  10 +-
 .../boot/dts/imx7d-colibri-emmc-eval-v3.dts   |  10 +-
 .../boot/dts/imx7d-colibri-emmc-iris-v2.dts   |  21 +
 arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts |  21 +
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi     |  17 +-
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts   |  45 +-
 arch/arm/boot/dts/imx7d-colibri-iris-v2.dts   |  83 ++
 arch/arm/boot/dts/imx7d-colibri-iris.dts      |  56 ++
 arch/arm/boot/dts/imx7d-colibri.dtsi          |  13 +-
 arch/arm/boot/dts/imx7s-colibri-aster.dts     |  27 +-
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts   |  43 +-
 arch/arm/boot/dts/imx7s-colibri-iris-v2.dts   |  78 ++
 arch/arm/boot/dts/imx7s-colibri-iris.dts      |  51 ++
 arch/arm/boot/dts/imx7s-colibri.dtsi          |   5 +-
 22 files changed, 1291 insertions(+), 579 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi
 create mode 100644 arch/arm/boot/dts/imx7-colibri-iris.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-iris.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-iris.dts

-- 
2.35.1

