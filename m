Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94624F98CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiDHPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiDHPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:00:17 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7580119278;
        Fri,  8 Apr 2022 07:58:12 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MulRf-1nvKg00Qkt-00rqfV;
 Fri, 08 Apr 2022 16:57:43 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Schocher <hs@denx.de>, Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: prepare and add verdin imx8m plus support
Date:   Fri,  8 Apr 2022 16:57:22 +0200
Message-Id: <20220408145725.812566-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GJ100Ph/AlprSBXidRKIqO1jfuHULfMHeRBA0Ew1BMxe1b7sLhP
 J9M0IUo7z1E/SnM/Iq33Rp0JFUe43NRJbFmaP28hlCTOZ6HdcaoUNuVNnKRDNQr4dgk5jYI
 BKEmzGGXKSCfVAHp7NMueA95MlGqcpRuYpnr/+pYNOHF82mgHzRb1eKDAiktt3Z8U5OfD6j
 2nGcQS9Otnk5O6K/E5QWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hoWg9qK/Oig=:bS5wZd0Iz2F3WVYFmwIH8I
 iGiNEFTb4VO3+2ROW892M7PkInACe0dfjY8ryxi14CpRn/mm7jYuDLTYNcdQXvxBwY2wSn3C2
 fE+84VFqeJQL3hmvXB4spFXDnxvXO+ljDzQnmzWXNTVWe3g1e1H1rjOJ8XssfRRnVaz1c4int
 7Eziv+xTqlbcgkRGlJNCNGJkPVQGxiBSE5DnZIDn8EAU8DQ9c2YmPN1Yf46OBOyr2ote1nm8b
 BE1KyLVSu+uKE4GTkeO4voWOcM72puCKR+AHvO8k2O1whFRtwhHYdj8oIORL54RjRyxO6bbPw
 w1BpZl42oQBr8C/KQzAEZwZz5ZaekSsxZMKbZ3VoQmWMc9mkWiviT8vvXZSAsZ+8VvAD6frW5
 jmL+ni/CMtuea6fEDCFWQu2Deje0lWZCM47bDrrqCKnothFDxoDK6fbCdSftHbqExCmukRdGc
 4mhNLTuA8qlEZnbU7eD+gwVvODl3EnN4wnc8CTzG/OxLBKztd9BEz1hSBwk9DZ03BXRGzYTk+
 uLAOiv5A7siG8+7NK2GLmMtaqekDTa2TgvrB/YNceyyHfSNe3ANt4iHXO0G4xvI/t+PQ2IuUu
 99qTJTijFhLU9mazemTQhs842NxRxRHm0lTnOl3ShdN6xzxiqKRJu+4Ngg6HpdVjFnU1v3oTi
 ZOo8idlhqejXw7oGI9vThSqYytmJcHOrGW1VyJQiqjgUQ3NuK1t1bM+TguyySCid/424=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


Add DMA properties to uart2 node of the base i.MX 8M Plus device tree,
add toradex,verdin-imx8mp et al. to dt-bindings and finally, add
initial support for Verdin iMX8M Plus.

Changes in v3:
- Add missing audio codec todo on development board as well.
- Actually define scl/sda-gpios for Verdin I2C_2_DSI aka i2c2. Also
  pointed out by Laurent. Thanks!
- Update PMIC LDO4 and I2C level shifter enablement comment.
- Fix USDHC2_VSELECT sleep pinctrl value and add a comment.
- Add comment about lowering frequency on Verdin I2C_2_DSI as suggested
  by Laurent.
- Re-based on top of Shawn's latest for-next based on 5.18-rc1.

Changes in v2:
- Add Laurent's reviewed-by tag.
- Add Krzysztof's reviewed-by tag.
- Fix capitalisation of verdin in comments as reported by Laurent.
- Add/modify todo comments as suggested by Laurent.
- Add Laurent's reviewed- and tested-by tags.

Marcel Ziswiler (3):
  arm64: dts: imx8mp: add uart2 dma
  dt-bindings: arm: fsl: add toradex,verdin-imx8mp et al.
  arm64: dts: freescale: add initial support for verdin imx8m plus

 .../devicetree/bindings/arm/fsl.yaml          |   21 +
 arch/arm64/boot/dts/freescale/Makefile        |    4 +
 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  129 ++
 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi |   46 +
 .../imx8mp-verdin-nonwifi-dahlia.dts          |   18 +
 .../freescale/imx8mp-verdin-nonwifi-dev.dts   |   18 +
 .../dts/freescale/imx8mp-verdin-nonwifi.dtsi  |   54 +
 .../freescale/imx8mp-verdin-wifi-dahlia.dts   |   18 +
 .../dts/freescale/imx8mp-verdin-wifi-dev.dts  |   18 +
 .../dts/freescale/imx8mp-verdin-wifi.dtsi     |   82 +
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 1380 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |    2 +
 12 files changed, 1790 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi

-- 
2.35.1

