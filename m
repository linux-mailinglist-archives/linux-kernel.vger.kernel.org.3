Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052274DCAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiCQQDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiCQQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:03:38 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C51B60BF;
        Thu, 17 Mar 2022 09:02:21 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LgrQ0-1nraKW1DEc-00oH85;
 Thu, 17 Mar 2022 17:01:42 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Schocher <hs@denx.de>, Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] arm64: dts: imx8mp: add uart2 dma
Date:   Thu, 17 Mar 2022 17:01:20 +0100
Message-Id: <20220317160122.341484-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220317160122.341484-1-marcel@ziswiler.com>
References: <20220317160122.341484-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q+leS7YkFEX3MBVnlLMUxSF+aTXKpd0eK/VPrEjelHQhvoi8+TP
 fRrYnVyHKzkB3iGSZ6BmeeWBd2G86Hnesv3vglBbzJ5v5rGmuH0LzMbXz1futkfrWsVKE+o
 u+Y2GTsIXAtnNJknZ8oWrdExNXET7vCCJsS6/aTAApv1qrsZvMliuC44co2zZrQUO/v+ZXA
 HVAEfU6eK7P3SfSRDzuHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D4AOwlPwUyk=:JwAVR/DqSMceIRWzflToqG
 pBO/QzR9I+jiHD2x7a/tm2NFjW/DO+wcGJpkR1CbpRYVje3aOrQmz2/LXBodlEgvBNqCe6w8x
 uogNtda1CykoqM9N8b6lyM2BAeAncjY6D77QnRuqUSma9wg9Pn4HadqHnxNqA0TZnQnsC47aM
 PMaDfpY8vdyrAc7siUm/XCZDTTRCLuf50iQDE1V3AtB4z+5fvy4xKvwdRSV/hfvnejqrKqkm3
 xK+02u8YR2QyzRuO+KELncsVcfVPkxItcSbX9zxyyU79y3W5vtqjutgpGW2UwmRHsUyfxzd3F
 gHpFjjL0K+iNd+G1VS38bsAf+KXMl6kPu7HZ7YTwIOUwsyXcHGMw5q3c4zg8O4nHIcINRPvIk
 WEfEb7diW4ef2baN2wc88X4W9b5GcCD3buNmw36X3E51CQdOTGNjtkYRjdT9Jq1Om1hYzgeYK
 t7+o5lMqNTdW6cbNsJOhY1haDH9kQNKeSQhKEJtRkmP+475EuN2ive7ykUS2Hb1ZYIwi0eE1J
 JGm7P1zJkQ8AUvHf0mImIgdefF+iffPH8vvJIQjojePYiU2vTSMVK1rvMG/WtjH0LVUzXWUPp
 9BIcZPFNBNkFNdDoQkbHChc2iNsbXVPputnfGvm1Of/7FdjYLAaEmasGiY0xETTGQuvWX/WZx
 D184hIxjzYHdJbXJKIW7eizRKsySca6oMhRvxvjGB6Dclz1JrLek50zG9TLpD4TFwBQY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add DMA properties to uart2 node.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3f8703f3ba5b..b6a020bac9c5 100644
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
2.33.1

