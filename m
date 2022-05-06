Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222C51D901
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392551AbiEFN2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392489AbiEFN2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:28:33 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB1A6972F;
        Fri,  6 May 2022 06:24:50 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MCszN-1nePN31ygF-009kFE;
 Fri, 06 May 2022 15:24:26 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH v3 00/13] ARM: dts: imx6ull-colibri: device tree improvements
Date:   Fri,  6 May 2022 15:24:03 +0200
Message-Id: <20220506132416.273965-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4LbxChUdf4uqviwBn03YFCgkv7u66I0UG3NY+rztR+OJd8FhEzx
 AKNcOF555MPNjmlhIbnZhURXWjOlzY0tp5+usx8oY3QGa+5oB3CbgohmW+KWLA0tNdGkKpW
 Tcsq8evuFkTZWxPexpLC+abWk/ownxRpq8KwgFbLOCLlqAcvqRweEY5Ljj/XS/yDjr+8ZSr
 SsBEf3k+vSM0Bn1SH2dBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oZJyg5xR51U=:JdnZtXeUXhmaKTGkc9DoMk
 g34zH9pQi0d72INFGgUNye3Xb6nawQYJAy8q9uzGS3f2cRZkPyhaf1cZywO+VuZOeAruHlTOm
 rbSe/wT3lLCrSbLnBZhoSxj+/cOS5P6prH3ZLTt7ZURLZIh6FLz873jN04fPuyIcY/J6EVQxv
 01R7tFW2457lHhk7E9ctGoIPygNb7sXTpo1xmcIJj7XTe9v9Iaf2LXFvBnKY6ayLpH+SPrCV0
 Ht5BbXEYgrVdAU/Kh5LO/Ygcek4AtjQwxkyMbunBBovPlTzPHdkW+xdAYgbQQ2YWg9VgrK8vq
 7DrhMyAarkrdqPiA/ErnuPUSkCQAUqLgWbFkWEBixVwBUy01oA7EkS/q8jmq+xXl1JkN08zfY
 Citfu+B4ViIAoeoAvxyjXsdwNvvK2qcyPKAuSiBGWlqTKF9YedyQo35tMhWHxGtL7fvC5OLsr
 iP89ReiVzzSbjQuFs6bCWemPmFC9Q2Jk/aX1cQczdcvWFINmlDUknb/L+42gtTISJISy0x/VZ
 Pl1BEUw0Lo8BHGCG10zQp/j68L75rPf9uB6PTSy+8MHM2Rd5hSwuP0kHiDEZbk0dU17XAxeqV
 QjjQhy3S08mtJdDN6E2eLUWwccUnB7237d6vsbqD1A+3rfbdBC5B0JxFyT7R53AxGYK/bPEnT
 bRtsfAvr1b/ThUgPMunYVEdNuPgAE9ZiMs9wW6F0rfgPcm5EquIGpdlxM+ljk20ORdAE=
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

Changes in v3:
- Fixed reset GPIO polarity in-line with the following upstream commit:
  feedaacdadfc ("Input: atmel_mxt_ts - fix up inverted RESET handler")
- Fixed comment using more common SODIMM followed by number naming.
- Replaced underscores by dashes in GPIO hog node names.
- Added more LVDS specific GPIO hogs in-line with other modules.
- Re-based on top of Shawn's imx/dt branch.
- Dropped [PATCH v2 08/14] dt-bindings: arm: fsl: add
  toradex,colibri-imx6ull which already got applied by Shawn. Thanks!

Changes in v2:
- Fixed pinctrl node names as suggested by Shawn.
- Fix alphabetical node order as suggested by Shawn.
- Dropped [PATCH v1 02/14] ARM: dts: imx6ull-colibri: fix vqmmc
  regulator which already got applied by Shawn. Thanks!
- New commit with pinctrl node name improvements as suggested by Shawn.

Denys Drozdov (4):
  ARM: dts: imx6ull-colibri: add touchscreen device nodes
  ARM: dts: imx6ull-colibri: update device trees to support overlays
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

 arch/arm/boot/dts/Makefile                    |   9 +
 arch/arm/boot/dts/imx6ull-colibri-aster.dts   |  20 ++
 arch/arm/boot/dts/imx6ull-colibri-aster.dtsi  | 145 +++++++++
 .../boot/dts/imx6ull-colibri-emmc-aster.dts   |  17 ++
 .../boot/dts/imx6ull-colibri-emmc-iris-v2.dts |  17 ++
 .../boot/dts/imx6ull-colibri-emmc-iris.dts    |  17 ++
 .../dts/imx6ull-colibri-emmc-nonwifi.dtsi     |   8 +-
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts |   6 +-
 .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi |  63 +---
 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts |  65 ++++
 .../arm/boot/dts/imx6ull-colibri-iris-v2.dtsi |  27 ++
 arch/arm/boot/dts/imx6ull-colibri-iris.dts    |  20 ++
 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi   | 132 ++++++++
 .../arm/boot/dts/imx6ull-colibri-nonwifi.dtsi | 145 ++++++++-
 .../boot/dts/imx6ull-colibri-wifi-aster.dts   |  20 ++
 .../boot/dts/imx6ull-colibri-wifi-eval-v3.dts |   4 +-
 .../boot/dts/imx6ull-colibri-wifi-iris-v2.dts |  65 ++++
 .../boot/dts/imx6ull-colibri-wifi-iris.dts    |  20 ++
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi   | 144 ++++++++-
 arch/arm/boot/dts/imx6ull-colibri.dtsi        | 285 ++++++++++++------
 20 files changed, 1065 insertions(+), 164 deletions(-)
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

