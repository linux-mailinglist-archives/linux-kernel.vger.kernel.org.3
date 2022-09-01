Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C705A93CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiIAKCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiIAKCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:02:21 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF1017071;
        Thu,  1 Sep 2022 03:02:20 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MV6ct-1otOmR3avt-00YQm9;
 Thu, 01 Sep 2022 12:02:07 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] arm64: dts: verdin-imx8mm: introduce hdmi-connector
Date:   Thu,  1 Sep 2022 12:01:50 +0200
Message-Id: <20220901100151.1378709-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901100151.1378709-1-marcel@ziswiler.com>
References: <20220901100151.1378709-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LXOmTNdFKPJxuWZHGqYmHqJ1VtSMGz/vML/YNY05KiJW//e4MhF
 DeRx7Gvdt+tibbVuMiOuU3T4dIPcqxek/at5lRUgFRN0ZW6R0XqZPsNFEu1sYGqPLsNy7Ik
 XUEnoWfLDgeWpDFXrg8PatFpwq7HsmQCUQBbx8duAVbq3Rx/nLF6UAvV/u7jL5RQbNwbbGg
 3cU4nPOCbcMUqBLyRioyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qvCXlYxqcUs=:/v0MSBpll8TpqkOxtdyESx
 kgGxk4o7GtLCTR83v+r9K1SvS35Mw11ufdz/U/Ssq5T7fQ1DwUB46Uchl8Au5As+eihvKl+61
 X1nJOqreCec6YBdTmxTHv1LS5m6xkCRCbgDvJeRPfybjBk2cEm4K/xI9pmS+SvoG8Psq+IZzn
 Y5cEZICT2XvEU6roSKRnfzfGqs/ad1zzUPAQ6kHHYmmxaQbBgRZXz6ZHAoQW1+JoMxXNgsXbB
 jQAk7S/T467EKcguudi2oXxmsJpLZjYQsTAmrz1Uls9BUwyul2ji/hxDsSOvS3v8QIKKvlPpX
 2Pkuk6jEdU+BzCciiKI9QPd0aL22FL565bnXt9AybLiBV/MNllN76PbcDekI7KDotgBSe2z1H
 in3bw2MN2Uc1ZWDcHfCvjSXUZLmbqHKVYc25XRfiPPFYX4i5agP9BtLjnXh/G7/yEUH+VYUYD
 JOHZQG72zl3kTRjeT9ycZatKPGc16rbho1x5VjoL+QOuzQU4jNU9/XqFq12R3YlA+34jFbqkt
 WLQ2NV9Z/MtvlPyjQTynBXhsS2p3XkxYOFd9IroQk04NR3TpeQ4q0gb1lyWRdhtTGbgT1UjGm
 19JjuoshZjVA/5A4D43fRpzqUhnAhZ101FEIVPVbp3752s/oga/LN4sJsiuJlAAfaWeGOeiKi
 +Ru3kQfk6CuLonRFNzVnbJi+gE5E9njYRwYD3KemyUT7x03hoaZ+l0QbSRuVdmH6VnZNwYajq
 VzxlWfmrJb8LHRKMypFDviERCqE3qmi8QPYpjAFY3TNC+zkNkJGKjOyPvkc7VeG6p8DosZ/kX
 SBEzpmE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

The Lontium LT8912B driver needs a HDMI connector to be connected to
port 1. Introduce this connector to be enabled in a device tree overlay.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index ca1c087e7c29..ef105c0745eb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -53,6 +53,14 @@ key-wakeup {
 		};
 	};
 
+	hdmi_connector: hdmi-connector {
+		compatible = "hdmi-connector";
+		ddc-i2c-bus = <&i2c2>;
+		label = "hdmi";
+		type = "a";
+		status = "disabled";
+	};
+
 	panel_lvds: panel-lvds {
 		compatible = "panel-lvds";
 		backlight = <&backlight>;
-- 
2.36.1

