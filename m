Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9034E5452
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244807AbiCWOi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiCWOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:38:24 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581BB7CDE8;
        Wed, 23 Mar 2022 07:36:55 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LoFXL-1nzUEQ0faz-00gIo9;
 Wed, 23 Mar 2022 15:36:23 +0100
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
        Lucas Stach <l.stach@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: imx8mp: add uart2 dma
Date:   Wed, 23 Mar 2022 15:35:58 +0100
Message-Id: <20220323143600.170778-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220323143600.170778-1-marcel@ziswiler.com>
References: <20220323143600.170778-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tpy4ELi7yKdnJqj8UyQgIaGpLdRudskye4olL0wi2aVulfOllhs
 4OxcRB1k6J7vP85M4a/iF7JcDhQquvq2T+cR1V3fUhjeUmbxmziCB1ozZZVU4u4p646PDV0
 oKnvRpLmEoyXJxVi1bjE8t5h84aKerMLMeA1fGgdLWa/lPMVy8aNODjCGXlj5SlT999XZn0
 BH1XQkGUAV0q/nH7oTCnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LC54BvORPAI=:3ZqPQ9WD2xJ1YNcTSY5vzM
 U80K4VQAKpxTifsXlXqVQPdDh55R6p2zW4ytPAaLBh278dRjgk3b3zSUvi0+vE+LZuX+4Ci5J
 dYN5iGsIVheDzvr/ANDKoHsrbikxISn3wNTjsss0rVxMGH6Ynk9/ubbRgkWZ2wQNSO/DBJwoi
 YocsdqOfzEhD0F8s0Rph1CNsQHVtk45XiMMbPj99m0mHTatgwpJk2fYqHXEeqMHiUf7uBKP/r
 T39k+g66KkTJi9BtA/lxxicQfDDa81qQA2UMJXkhTkIEtlEPYeUpHRLy2JePMeyfX/BQC80MW
 1XbpMTEVGnQdxNUC/XV75GpabideKx7cJh8FGfXuLOAF/VKveI4koDyEKu/4fxwhyAbmEStmO
 ALrdf6hmGGj0UwSo6N09MsO8QHtZdYzhgz/3ICOzvEFX+KpkbkFouKZ5ojX6TuhjFVS6P3k6y
 jmt6AoL9j3KmtrpnOlF8eRGbgJORnxO7R1+53pfENLWpLtFl6sUm0Kn88sxKw+lqTn1THS98p
 IQ2gTotdH3eoqfH5g1NAMnVIMQNNphiTxJ55YH8gCNKgKeF+TIO0oyUNoy9av9OjYYyCb2u0s
 7PsBeffA9nWeCIBnr2OUAWTIsOKm0t7APkR+AfmSLVgmhWCN9DieG38jnO1jO1JuNgNQc04k0
 QZraj5xkD9B/VJ6p2eR7kh9j1Os4f5wL8FupHBR2AqbAylOQo/J52mBFxrxExO1VcxR8=
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

Changes in v2:
- Add Laurent's reviewed-by tag.

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
2.34.1

