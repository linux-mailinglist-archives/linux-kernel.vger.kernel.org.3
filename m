Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889084DCAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiCQQD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbiCQQDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:03:54 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312E2213512;
        Thu, 17 Mar 2022 09:02:37 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LcRZg-1nw0Ax2u7a-00jrHl;
 Thu, 17 Mar 2022 17:01:38 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Schocher <hs@denx.de>, Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] arm64: prepare and add verdin imx8m plus support
Date:   Thu, 17 Mar 2022 17:01:19 +0100
Message-Id: <20220317160122.341484-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ED0sbp66FL+AzkN4iNlevzTuTV0BQ+7P79CubS7HDAtFLugskPG
 rRdkCZ4wT9vLKJnUwIra+so9iRa6qiuiCSiWWVu9DKtUbZVrFfp1v8gs70Zm+pohlgYyuRB
 /0LR+8brodVK0k6c12JeOjXRaIK3qVGAYTWdUyYaE8WKvdF6DPPkXAYazBGqtjA/jXKPkNQ
 aSx6BwG3d1+LWhazmGNZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j6Lf8KfJmM4=:gij8r25bka3DF2+u65BHnl
 QXHwC8hlm/Qq4KefG9oFOKbe6jBMDn95/ZjjrbVnet0PiuxZykGpcxaFb6z0imPGObbPaWXM8
 MXPQuwhzYusqYEgJABnrVcVc7q5w0EfY5FX5KPD6jL9E9JwSJCJCGmZsjZFt0iZxyewDzMiIz
 Gs76WBcQGbqEOumkJm2QLQKyEzYj2vgt+UO6L6UED6iBQ8mAhF5zhMKbh8YE2SaA3zEvWUwLA
 uJeqbbB6xa/sH6ZdeZqYf/D4lmzOATIsvjNupzhDFzGwL2KqIgIsm3q30AGDgwyC65XKxrDA/
 A91Yd0kvKYxFH4mUFT5K8CBJYchXJNa87Kk9PzMpXDceTVPanZg7LMT5tbolgOJ9L5baWw1LK
 AUVTFPH1xfkg5CyC/QCa5Ykw8LNGU6YK9/vbC/JcQv/WXWoBW6sE/BGL7OM/91FDqIH4VLNyh
 RLGlRNPI9Ag1eeKRxr7oYrlMZZl15sXmeZ+hxH+mjCdvvPebZqjZKaeItDoBqSyRTDn00TOyJ
 75/zT9ZDcYpUaU4Bgfch9dPbA1Eej0iKDbW6OLNbdN0xvd3pT/RX/BwCxstxq14zWPhdVqg5J
 HC/2D0BTGSfCIx7XVSJgFuomcVpbApnsjSOExiOj18OxmMY4XdzbynsomssZsURgZRaTrHnb0
 mYSrXne7CBX4h6AQfHlomN6FMCrEhjueMjsoGAqF/lRI2UW2bQStJGHfoKg7NX/CQVsY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


Add DMA properties to uart2 node of the base i.MX 8M Plus device tree,
add toradex,verdin-imx8mp et al. to dt-bindings and finally, add
initial support for Verdin iMX8M Plus.


Marcel Ziswiler (3):
  arm64: dts: imx8mp: add uart2 dma
  dt-bindings: arm: fsl: add toradex,verdin-imx8mp et al.
  arm64: dts: freescale: add initial support for verdin imx8m plus

 .../devicetree/bindings/arm/fsl.yaml          |   21 +
 arch/arm64/boot/dts/freescale/Makefile        |    4 +
 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  125 ++
 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi |   44 +
 .../imx8mp-verdin-nonwifi-dahlia.dts          |   18 +
 .../freescale/imx8mp-verdin-nonwifi-dev.dts   |   18 +
 .../dts/freescale/imx8mp-verdin-nonwifi.dtsi  |   54 +
 .../freescale/imx8mp-verdin-wifi-dahlia.dts   |   18 +
 .../dts/freescale/imx8mp-verdin-wifi-dev.dts  |   18 +
 .../dts/freescale/imx8mp-verdin-wifi.dtsi     |   82 +
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 1373 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |    2 +
 12 files changed, 1777 insertions(+)
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
2.33.1

