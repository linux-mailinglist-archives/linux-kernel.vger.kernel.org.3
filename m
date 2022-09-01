Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6A05A93CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiIAKCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiIAKCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:02:19 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0091D134880;
        Thu,  1 Sep 2022 03:02:17 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LdpDh-1pCPRQ3a0h-00j4Xv;
 Thu, 01 Sep 2022 12:02:04 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] arm64: dts: verdin-imx8mm: add lvds panel node
Date:   Thu,  1 Sep 2022 12:01:49 +0200
Message-Id: <20220901100151.1378709-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901100151.1378709-1-marcel@ziswiler.com>
References: <20220901100151.1378709-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VnJ1NtTLb2JU1Blx2e3SKtrQp3EdMQeViKJsWwf5rLUxEB1shvY
 vS064QvQGr55BCiteGpK48LHQqjnsIgT+riivzy3+97mTAsKNuZIzMPujfQKU7QEj3yJenl
 C6FoPqn57Dnl64+kmH2sgMqssAi+/InQUA3NZf2coWa0/S2ODlfzvkhgx4yzFJyGCLFvDG4
 3iXWk9b6/KFm+8mOgWdGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y7q2VLfuQ70=:7Oha8K3JZ7BotefxI7rMap
 iEwLgYETh8v2s4dy92xO/+HZBiC9IE3g/OJD93w5C8C9u1YdL/Hqj2w+Rp+5khecp6Pjmhecn
 qXek6xSL8+twy3g4qY4zHCwNBeWQld1dv5GSkamrTC4+WRS5LC38FL3Th4Zrg1htASAab5W3r
 6gesfIBrNmkkhqCBQfodZ/9wIllmmc8tassD5JsSc5AuGK9uIk0KV/ovGleB7bH1Nwiw7dzwf
 PL6vVZT3Ckrfk14O5DWP0L2+YK4kyn7GKkknOMDR8stK+UNQgXzl7wUPsGbsBzVYB/G7d/gYu
 fzmEYAovOb7MM5JshKsG/bHkfuUcxofPuWRVsan/H8s5Wp+MX9Ud3y+69U9cRE1ZKlRg7AzAT
 ZhcGDXS+6zKae83mTG4828xHzBPXT35MUFCUTktToSyOQ5sT/A2EcrQU/B+0UTG3mbcakjVYL
 tf27ELOIxL1jZeyAgCCqBhFL9DfNLBqzV+WG7FThd94arjy1n0qVgivpl+ilclpVD2TwQZGB0
 ZR+Gr961q8x1JDDOpsXcWvsxaEFOtaTe+Fbd9rQF3QNPSfpSQjL7r3101jDO1ttV9iqDz921c
 e86ZipHISmIjmssg5L1YWxCHHlYpf04Kb5IjvnLq4OGl61MNb0/6ZScCFqTsnUUqISx8vKyuu
 xA8wyN09vwqOo+l/lAgCgA0EvsSNIV1VEl/r+wTpfgZMpktry4IlnnWBHZE9iE/PmJo0ra0DY
 uJGEWB9GOLbj81itonLs2bD8HaSfw0i3qGk0mWfpIAE3pOV128NH4jIbVvE+082LPSxBirdkR
 ZNZlfoc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add an LVDS panel node to be extended by a device tree overlay.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index f5a2dade24a1..ca1c087e7c29 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -53,6 +53,13 @@ key-wakeup {
 		};
 	};
 
+	panel_lvds: panel-lvds {
+		compatible = "panel-lvds";
+		backlight = <&backlight>;
+		data-mapping = "vesa-24";
+		status = "disabled";
+	};
+
 	/* Carrier Board Supplies */
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
-- 
2.36.1

