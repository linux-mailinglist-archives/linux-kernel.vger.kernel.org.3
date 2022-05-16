Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD805285EC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbiEPNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243989AbiEPNuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:50:00 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6185039159;
        Mon, 16 May 2022 06:49:02 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M7IS8-1ndzew0dgE-00wzGX;
 Mon, 16 May 2022 15:48:48 +0200
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
Subject: [PATCH v2 14/24] ARM: dts: imx7-colibri-eval-v3: correct can controller comment
Date:   Mon, 16 May 2022 15:47:24 +0200
Message-Id: <20220516134734.493065-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:P4e6qvQslx7pVS0Qs8hQ9quZzDy3Tei43dyFK/9Jm1jOBrKg4q/
 klY/gsz4l82GNkm4N0xp8Mpp+8SFLprdBFjrdBqlgdDaPCf80rdwrLmKZh60+cF85dxbWWJ
 fnrFhrLPXjrGQuIVW63DB0eQSgcBI8K0deNRg0Tal7TNnTWkf3Wso5ksutZ/BU9SAdbt4xT
 QAlXv6KT5dRSkxB6RLjQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s4+VPOFXeeQ=:cgocLZpI4cEgfhoNGuZWZl
 pdmicKXwZm+hfJsTZa6mxkbslE+gnjWxtgflLhGsvfNMjkgmzmFKdaPYHylOwss4+7vV8czQP
 q5N8FNRAlj9WnBib6dX6Kn4xb+tp5vDXde0SGJnCiQxvjzVTfgHcgQj8FvxlS90fwaGxI5DXc
 dsFF81NYtWucF2WCqsmI2B4Ai5YzRqc5k4oEOFKb8/8L89Y3xXaQqYA2QS0HsFB7JvMnqDLnU
 gll5bfxV325P5U873BkPUQ5SoF5luZqVGGy3IDo+XGIHvZYCVQm+wz062VqO0bYGI3akvxtcl
 LOwsQs9gWWEmoyqeDpyVSSoH+AxXDJPAL1xI/nUT8ZrLVuwxcSfZwfvc/+egz4TkaY2LaAjaF
 2j51nJAVT7l0pYC+gAg3SWPn7DI1AHxC++dinl+ZdJG0xYYcZPMF11YVDhYT1ZkfnfSYpd1/l
 lHPV3llQgQ+LHETgofXxJkn772iJ+IC/r/jY2e51iFbv2tbT4F32QlJ8c3oK2iLBnr1cXOrSJ
 6ZXqvZ+H6RcCb5TloI8ItsU7CuWPkWqGyrYa1fZX16yeoc6Eo1WSdxkDEwp6oQRQO22TCpeHC
 7ItQWYVARVK1swrzQO7ZRyTj5eC7nf2h/xlV3w/VAqM0kJQmemYwYVCbT7DtoA32flZccD48p
 3zA0TBqpoH02QukFLWz5ivQe4A8jG8gdb35M43jA6nMAcpuYINP6kMH7913L8/GuMcco=
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

(no changes since v1)

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

