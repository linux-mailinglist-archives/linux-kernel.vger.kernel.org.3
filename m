Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682794F98D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbiDHPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbiDHPA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:00:26 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A1E11D79A;
        Fri,  8 Apr 2022 07:58:21 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MCauF-1nmUxM0KWJ-009gEH;
 Fri, 08 Apr 2022 16:57:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] arm64: dts: imx8mp: add uart2 dma
Date:   Fri,  8 Apr 2022 16:57:23 +0200
Message-Id: <20220408145725.812566-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408145725.812566-1-marcel@ziswiler.com>
References: <20220408145725.812566-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K6L21+1Nm2wMhqocUe21VUX0tpp3qtWqwyLhfe82OpXWHn2aUfz
 pS96SaD6rBpShDOPYLvqje+KAYe7dpaQ0ceKNjukjFQcyACDYJLjknB9ELTT3nEQN+QYDcx
 T41GHT5QU54sjImECQeDpVt/GFr9Oni1Qw8gqgShiBDD8Zy/YcsJAkIkZ1wkmXf+ZQWFuqD
 YXv3Wm27ycg/i8s/K/hNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X9V6ktcqoqY=:Sxw0xe4noNmcAqtpM3l48F
 pt73tC60nXqU8rj4JXVqHYUs3lJjZOgKDSZJcmqaiES/my7kpvNydp4otfUh9PUaDFCOHFm/y
 FA2HjMNcSwoGJzqDt8huaBXR294mKq1l8z+HBltZS06Oy3Q/D7PWZYZQcZpNXgIvkDrXLTQgA
 gOMGj0u9IM9LytaUVETHO8lF8mmu1Ynu1E5tGxTAAezvFKbq1MKU4+H+ExwVs20Qf8+FpsUZ1
 M8TX7HRjc/MGhEOzlooQmNIbzCAEjdWvziH59SqrDxylnD4DpOgsQtG9Rg9iXBLa7usqLgkfF
 kwefqhV+u3Dp0k5RWrw7g0k/mmHySXkllPF3rnF6FHbN31ANsv9X8bJdWCwoCzrktJ50LuPSY
 AigTRpygeN0zNWewN6KBhEXPMDwM8C/jwJel2YaQn/NvGZ86tcxknICk2FDSclpWsQn41NQ98
 rjoolN1PnrOeRPl0Mo9uqvfUwlg0rrdcAoyTFAsVlgQZfC/0vbVOMsmVaKJuFc3pxKoRC2+Pg
 1fAclqbG/dx7WzpwfAPwICzT929ipEW+tvUo5NFZKot3sibMU6vN1kACI8WLmsxwSLI7/cUsQ
 eDcyzaQkwEk7RxCgzcvhZ4grHZWR00ajAkupkGWBp8740hjvxJbO2omqd2xASPjgJHZ0mV00g
 Vnqn0Qngtkr4NTR50Yfw7Tyaao6p7qDPllr+UsFyPC91n/LHpA1x95dTPm6pCVOnLQtI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add DMA properties to uart2 node.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

(no changes since v2)

Changes in v2:
- Add Laurent's reviewed-by tag.

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 794d75173cf5..1390fa5458d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -617,6 +617,8 @@ uart2: serial@30890000 {
 				clocks = <&clk IMX8MP_CLK_UART2_ROOT>,
 					 <&clk IMX8MP_CLK_UART2_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
-- 
2.35.1

