Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615E65A93D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiIAKCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiIAKC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:02:27 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA44F138588;
        Thu,  1 Sep 2022 03:02:26 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M2bMR-1pLne83i0j-00sKCn;
 Thu, 01 Sep 2022 12:02:10 +0200
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
Subject: [PATCH v1 4/4] arm64: dts: imx8mm-verdin: extend pmic voltages
Date:   Thu,  1 Sep 2022 12:01:51 +0200
Message-Id: <20220901100151.1378709-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901100151.1378709-1-marcel@ziswiler.com>
References: <20220901100151.1378709-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ck71v7fRyPLBiFThJtJididV1+76UsfTyHqUsC/9z2lYVhLX1Ps
 naMbE+vSKyKWmYdh3BC/17/qzX2JbzmITGQX9EBQWOkrf2/MNTAt/EuTLt4pnDdK5uvZ5s6
 Pj5gkFp7OroJfVSp8QuwwTAI/GScvh6xzDVvP5cDNUvf+9Rhmdq6a5wWWDBjVM2mANhpiMJ
 qWqccT3TwpFZn2TWfmbtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VFyxj7Xo8xA=:6EPKEFePkeGBB6/DSPJ3e8
 hNpXOMZh7Vcj0hO3QjJZTwmKBbpzh7UE0bBXyC/duR2IG9xameSAO67inzOSS5zea4YDyLfCM
 9zete9kgi6XOryLtEzsvwHMREQOtYI7nWMz503SMDaVPIOnEVk61lSVcmJi2ogIqJ8DhJvFBn
 dEvGiMr4vtEEu82KKEAu95ncwgV+JMp3Wrx7gEgYqK31jDlvAvMR2aZUulXlBAZgGM8IHQvKm
 foN8ftiiOhcvCL91SfEF5yru5MuA5Az//0Ja36+Uj90aQ8yem5LMSgdfuuKOr9T6HJyR+FjXQ
 6psVfj1aceLJ2zKqMAvp42DNKkVdtDOYZia+5mVIJfvteXRV8KJFaobWjgXD+FJzsVMInJUOS
 7+IyZMibBjzQSM7vPiF7TgOEpn0+tDsyJ/O1r0vQ5PYyOnxLbacTLb/Oq4MvimnAEVX+yeFi0
 MBXSHH4FTvawRYoOi9qhEkb5EkJSNZHhNfSIuxjd1Gd/NHPsnwbFsPzFShcpQ7sxGozEhtjz6
 4nCqmx8VIl78ndlflFxWIgwZ3WCJn23mpesEHzm4ztoEXgdldMszv8TZ987VKFeRCG7FUfDqc
 PQ7uNxJqwCMxOdOmZcZufFGzw6p2MOXSqIR1+62baFnS5dhAzp9qnHx9fsu7PZDfF0dyXJ4LV
 //89vExYQLOO4jC1RsK/quJr8AadAEZPAlpuPOqrf+stc3wmkATvkyX+Sx7zvBYcZ4q1Dvaii
 ZRuIybdeudqOaTinioZszismRLajDe0vAklKxGRwcsUBgQo1frOCa/thaKxIazUtD2ZiPUJCi
 h2m3t8H
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Currently, we limited the voltages from the PMIC very strictly. This
causes an issue with one Toradex SKU that uses a consumer-grade chip
that is capable of going up to 1.8GHz at 1.00V.

Extend the ranges to min/max values of the SoC operating ranges (table
10) in the datasheet. Detailed explanation as follows:

BUCK2:
  - As already described above, the SKU with the consumer-grade chip
    needs a voltage of at least 1.00V. 1.05V is chosen now as this is
    listed as the maximum. Both industrial and consumer-grade chips have
    an absolute maximum rating of 1.15V which makes it still safe to put
    1.05V
  - Lower the regulator-min value to the smallest value allowed from the
    Quad-A53, 1.2GHz version of the SoC

BUCK3:
  - This regulator is used for SoC input voltages VDD_GPU, VDD_VPU and
    VDD_DRAM.
  - Use the smallest value of these three inputs as the regulator-min
  - Use the largest value of these three inputs as the regulator-max

LDO2:
  - This LDO is used for VDD_SNVS_0P8 SoC input voltage. As this has a
    single nominal input voltage just put this in the middle of 0.8V.

Fixes: commit 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index ef105c0745eb..2eb72a607139 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -382,8 +382,8 @@ reg_vdd_arm: BUCK2 {
 				nxp,dvs-standby-voltage = <850000>;
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-max-microvolt = <950000>;
-				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1050000>;
+				regulator-min-microvolt = <805000>;
 				regulator-name = "On-module +VDD_ARM (BUCK2)";
 				regulator-ramp-delay = <3125>;
 			};
@@ -391,8 +391,8 @@ reg_vdd_arm: BUCK2 {
 			reg_vdd_dram: BUCK3 {
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-max-microvolt = <950000>;
-				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <805000>;
 				regulator-name = "On-module +VDD_GPU_VPU_DDR (BUCK3)";
 			};
 
@@ -431,7 +431,7 @@ reg_nvcc_snvs: LDO1 {
 			reg_vdd_snvs: LDO2 {
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-max-microvolt = <900000>;
+				regulator-max-microvolt = <800000>;
 				regulator-min-microvolt = <800000>;
 				regulator-name = "On-module +V0.8_SNVS (LDO2)";
 			};
-- 
2.36.1

