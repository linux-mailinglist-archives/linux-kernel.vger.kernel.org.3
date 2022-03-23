Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C4D4E5458
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiCWOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244834AbiCWOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:38:40 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF47CDED;
        Wed, 23 Mar 2022 07:37:09 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MCsvF-1nNNRY0M3H-009k0t;
 Wed, 23 Mar 2022 15:36:19 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Schocher <hs@denx.de>, Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: prepare and add verdin imx8m plus support
Date:   Wed, 23 Mar 2022 15:35:57 +0100
Message-Id: <20220323143600.170778-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iEtxqVj8xjfL6O5vO62Lr0/Eq4Aq/QxThuA82yYd1v7mA5DjcZF
 Ui5YWdMxxYGtWyILjaWfsq5KMqDE2Q1077wMSCzEwxmxHu6vC3kwGmqg8G1hSU7N2ZyMg0M
 wNAMXCGyvb0eb0XDkrtkjJWq6V1aDZSOkCMX8bQqCsvOAXQYhsqQHL93OeVQ1+CICciLEeR
 2UYSFHgQlWInRZmfMHEjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AE5BLTl3aOg=:FF2iEfBRS7TXkxqtc9Sjve
 EozxWjSzJw5o5uLBD5aXntnPmp7xjHtX8npqFOyMV2ywB5s7GJAR3oSnHdYZo6UnLgQxXjoe+
 jwT/cSCPoiU3e1AdSR6kDPDoTdk8vjmnZDYqccxwC4SixPvDYPNEt7YcKbfIFhfj5qvWptMYc
 4dh8L2BvzP0YOrqhCYHhv7XfRcOeUCmes+8zRBRno4x1upnvfeeLc3Yt/Cd83RF/tb6KcwmfA
 fHiHnmw2k6dUDFnAnW1A6pq3XQ533ZeCxkN8AsiBuL7Puq5LsuUigqcIFBrvWKroxarbDEhrv
 /eSzFZJD3QePKA6iqI7zjD5V+BznVfIDPrTx2qQlcH5cpNt/JIwrZUJCJtCiDvAJFGJ/sK/ZS
 hyi4Ul9G37T4ZRj/sgCJbiOSIF7M30e2IDH5icggyrWVtwDgabDo7Yj3pSRET5AHt2Nwin5+m
 LfwXD7mW0qb/FqXUfitH5YodP0WNEINEmn9WIthWDHAs5+zlsS2XN7GVRoMOeaql3iUY067tZ
 Lf7saJh94HNDNxIPPtr4Y3+vgda+YSCH3wKaVWZoDBu8zUAxKm2KoeUz0ADA5FQLtgcyhgKFF
 aqzzR51lb8TPGSPHizIXzZKsWnpiJE0OtYp20SCthq68C3tUD1tFIbGHwMPc3PsPgCIdYRLMG
 BRQ5b5OepQlmHEiMyMlD1X4jwJKzvV+GS8jEco2M8YgSa6niJmfXuBr6KWs15DQ8f+bY=
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

Changes in v2:
- Add Laurent's reviewed-by tag.
- Add Krzysztof's reviewed-by tag.
- Fix capitatlisation of verdin in comments as reported by Laurent.
- Add/modify todo comments as suggested by Laurent.
- Add Laurent's reviewed- and tested-by tags.

Marcel Ziswiler (3):
  arm64: dts: imx8mp: add uart2 dma
  dt-bindings: arm: fsl: add toradex,verdin-imx8mp et al.
  arm64: dts: freescale: add initial support for verdin imx8m plus

 .../devicetree/bindings/arm/fsl.yaml          |   21 +
 arch/arm64/boot/dts/freescale/Makefile        |    4 +
 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  129 ++
 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi |   44 +
 .../imx8mp-verdin-nonwifi-dahlia.dts          |   18 +
 .../freescale/imx8mp-verdin-nonwifi-dev.dts   |   18 +
 .../dts/freescale/imx8mp-verdin-nonwifi.dtsi  |   54 +
 .../freescale/imx8mp-verdin-wifi-dahlia.dts   |   18 +
 .../dts/freescale/imx8mp-verdin-wifi-dev.dts  |   18 +
 .../dts/freescale/imx8mp-verdin-wifi.dtsi     |   82 +
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 1373 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |    2 +
 12 files changed, 1781 insertions(+)
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
2.34.1

