Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B325914F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiHLRgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiHLRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:35:40 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22517FE48;
        Fri, 12 Aug 2022 10:35:38 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1oMYZH-00FqKk-Oa; Fri, 12 Aug 2022 17:35:31 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 4/6] arm64: dts: imx8mp-venice-gw74xx: fix port/phy validation
Date:   Fri, 12 Aug 2022 10:35:24 -0700
Message-Id: <20220812173526.15537-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812173526.15537-1-tharvey@gateworks.com>
References: <20220812173526.15537-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 65ac79e18120 ("net: dsa: microchip: add the phylink
get_caps") the phy-mode must be set otherwise the switch driver will
assume "NA" mode and invalidate the port.

Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400
dts support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 6ab4896f708b..cb4cf293a7b7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -484,30 +484,35 @@ ports {
 			lan1: port@0 {
 				reg = <0>;
 				label = "lan1";
+				phy-mode = "internal";
 				local-mac-address = [00 00 00 00 00 00];
 			};
 
 			lan2: port@1 {
 				reg = <1>;
 				label = "lan2";
+				phy-mode = "internal";
 				local-mac-address = [00 00 00 00 00 00];
 			};
 
 			lan3: port@2 {
 				reg = <2>;
 				label = "lan3";
+				phy-mode = "internal";
 				local-mac-address = [00 00 00 00 00 00];
 			};
 
 			lan4: port@3 {
 				reg = <3>;
 				label = "lan4";
+				phy-mode = "internal";
 				local-mac-address = [00 00 00 00 00 00];
 			};
 
 			lan5: port@4 {
 				reg = <4>;
 				label = "lan5";
+				phy-mode = "internal";
 				local-mac-address = [00 00 00 00 00 00];
 			};
 
-- 
2.25.1

