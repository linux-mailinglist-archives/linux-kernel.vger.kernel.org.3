Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191A651DC1F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442962AbiEFPdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442907AbiEFPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:33:00 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651FA6D39E;
        Fri,  6 May 2022 08:29:17 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1ML9Vm-1nW1091bRi-00IFJS;
 Fri, 06 May 2022 17:29:03 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 14/24] ARM: dts: imx7-colibri-eval-v3: correct can controller comment
Date:   Fri,  6 May 2022 17:27:59 +0200
Message-Id: <20220506152809.295409-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HjVpzv18CqPVJ4aMjIVVHHK3h48UGA9kXxLReZwKTQoX6WbZnsK
 3mJVFQOR7300Rx1BHUsgvEwKQmC/SL8/mZZrE+om+hsu9jrRNLx1x1Zlcm3lwP9x8aKkTpR
 P0WWNkGW+uj2PwwFKyAB59pMVqpkAzakWgInQCeq9yKeWkEOppREUArR0PginUg7IQ/Nd9s
 9yz1Zr8JtlkZLVLpAoUeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xufg7RiBuno=:ePETjlbIGCO4yiZRz6HZrN
 QpGXCyn0jAM2pYF874g+XNO68eF/YCs1OBZFRKpByrmibvBZ/8eyYJt8XZEUQUFk1AzTY6UQN
 h16zR8T0isA3dXA4kxbg7P6R1ypbWAaW737cTXvgE/M3ShA6SqhiqEnQthiSXQDHKW/Xncb3F
 H0Cc2zVh+g1b28beaYJXsFsyx4rjWT2K3Tj798+yXx1VNFYa+KOTNLVPIRJ3q+TgYjMxQ2uZo
 0jj/e9pX2k/FvHJlya92hmw63AsEIXrrMXWmjYgl5KV9qen055ohtZ/XutMajiUrgACbgsLkQ
 bwMgmWDKe/xIY3QMnJn7WSl8k/j4zlH+2S/PAn3EOhNiI/xKWXG53tseKnPhUqjDIuPnp9pRN
 DI9zCh9pc1BDSNXyT22TXdIrGoBpweiCY7YOoLYZL2w8MnKlwcI2i1XXIusKCkDm6ZgL7dbvx
 L7bS0GKNeTJWJYPUvfpou/N0IYOMiv0LmYaHrULmUPjHFNGXMat319iWaTfLHangXSwu5TEFf
 qNAT0pb6j4Yp12XfQXFhWjUzH92xWJlVOUhidAsbkgQ5RzrOQ6iCkPRhkDFZ19h4YkfuDfxYU
 yChr885wghguSAXBuzyarMiROI+1vth7e6f5uFDHnQ6FZZCYlZapyCUBnexGuF7RC/FgKdKJQ
 WxZSAZdYmsl+qWe0I4yocSeFcyaDqzN1hIIWzOzVM679zRs05b+L3FCBmCXRYXoe0//JQKS/k
 kA/7xaKtFMbczu9+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Correct CAN controller comment. It is a MCP2515 rather than a mpc258x.

Fixes: 66d59b678a87 ("ARM: dts: imx7-colibri: add MCP2515 CAN controller")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index e3aac56aece8..069f56272546 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -4,7 +4,7 @@
  */
 
 / {
-	/* fixed crystal dedicated to mpc258x */
+	/* Fixed crystal dedicated to MCP2515. */
 	clk16m: clk16m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.35.1

