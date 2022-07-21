Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A036457D49E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiGUUG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiGUUFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:53 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8564F7AB1A;
        Thu, 21 Jul 2022 13:05:49 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mir4C-1nbyCk03Qy-00etle;
 Thu, 21 Jul 2022 22:00:26 +0200
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
Subject: [PATCH v1 10/12] arm64: dts: imx8mp-verdin: don't use multiple blank lines
Date:   Thu, 21 Jul 2022 21:59:33 +0200
Message-Id: <20220721195936.1082422-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Czf5f8ffpxK+ND0g2hRjSPO0OKZUjDgEGrCZ5cPNzYROctAOXPQ
 ixrOPoxMw1txGEcNJpXxUYGLcVGqWC5sHtYcPCyKqi/eQj3NYMBVezG8bWyrLWoRN5l0Y3H
 LrwJb9APHggYNZdvIkh18bB1TIbP30pSOnI89pHJu3ZQvquwmw+hWf/moezYtub28lnFPyf
 AD+7/z0/ZoO8WJJgN0y7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sFh0LhjIr2E=:ZpnDyWtzchxZIZZcrKt3T+
 ShwybPCvXiiwaA64GGgFnMfqoHVc+fhDX9XpP8aZdqVudkioVijf2Zeip5/S+ML7WsxiH4XxL
 bd8tZWKvZ2gYlKMCxapw1sBApl0+AlYyQRJ2mEOX4eV0Sz/wiphxL9gorACvN2EsNbtHPhyPu
 NkVqPAnXVlVaKmIlJBCVMjP/zqR2m65UecnHyESFaYbHks29mIRqqNbQmf6CYJ35P5bErwrpU
 eApQVg8ymkSnOqqTDUtnA375lG24v/QsRyB+gX0g5jQzsSBgJBbOqAz+E9cxRDd+ZvTXcV5cd
 wN0XO7jxrqrjlOyaFWN2hXPyNd0C4nHMXgM5khqhCszI9FuGg1/LMIhQN4bWy7M8FLh1Wq+hG
 nHPaPl64ik7JPuv3/obwwptwkUFI1WTTJ4o9vAfx/4oUmLRur3fecf5ddh3sryWwcJ0d0quzk
 PzYZvFbn4lj++01+HhgYgLlXDxS0bHEUqVv4cBbNtMKLartQYPyOBwVsDaPc/E3NGAPDUwSZs
 tCeLHPju4Fl52F7Bx7LW7C+TeX8nT3ILziL9dFQTGkbLcl/6Dnoj24eSix1GJ99sGh0y13t3T
 4PaKaJAqgd4+2lgNX+ilhDms1wr3jBlWO1DbxuI9Dyg4MlovM0YOmlwsrb+xHiw9E7wt+Orzl
 WHELF601m1h+X+MV4pEAEWGWkmWvPmhDwD6I79/DYiY7xm7vT0qZ8ZTWNSL+faC4GLbti5NwT
 SGlGeOvw5ITouo/O5CD9zKM1SBYOPtqmvbueedlqauxO6YjXEyQjYzI97vM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid the following checkpatch warning:

arch/arm/boot/dts/imx8mp-verdin.dtsi:281: check: Please don't use
 multiple blank lines

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index c5987bdbb383..f062fdbb2719 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -286,7 +286,6 @@ &flexcan1 {
 	status = "disabled";
 };
 
-
 /* Verdin CAN_2 */
 &flexcan2 {
 	pinctrl-names = "default";
-- 
2.35.1

