Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F296572F87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiGMHry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiGMHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:47:41 -0400
X-Greylist: delayed 354 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 00:47:38 PDT
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9742E5DCA;
        Wed, 13 Jul 2022 00:47:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1119AC0148;
        Wed, 13 Jul 2022 09:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1657698101; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=AXW6ucclvG8v7lCgqRCuvPr3MYxlLFUnjfAzrDFhFPs=;
        b=McbiX6Adha43SOs8rsKC9vXhimZPUfBHphqypb3FHBmPN4kqxbCyhNDeNgiAyl5iqoDlnp
        /zLqQJ5DvthY3JxEdqpwYOpKwttTOQ45Xs5WoSau8uMptwEdly2QudIaYKfBepMF6Db2kS
        5vL8KO/mnI92Zb9n+z/NcEFx2FGacGfBXeMp80q5NpDD1y0i5EUg6yB+6Sqhoo0E8ZGjZp
        Lb/ddMvdit6C/bVa/2h0PzuBiYv3Wr8mko4evinI0zFOAUFcxRyN9OwFD7UHJ8OX/kpbsV
        JhEo7u0ZHWDe97oOmx1PdwSfgXrTH4Y0qn0m+sAKfqK7wn/V0o5YwVdBqlNmUA==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 1/6] arm64: dts: imx8mm-kontron: Adjust board and SoM model strings
Date:   Wed, 13 Jul 2022 09:41:12 +0200
Message-Id: <20220713074118.14733-2-frieder@fris.de>
In-Reply-To: <20220713074118.14733-1-frieder@fris.de>
References: <20220713074118.14733-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The official naming includes "SL" (SoM-Line) or "BL" (Board-Line).
The legacy identifiers are kept in brackets and are still used in
file names and compatible strings.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts    | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index 23be1ec538ba..cb8102bb8db5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -8,7 +8,7 @@
 #include "imx8mm-kontron-n801x-som.dtsi"
 
 / {
-	model = "Kontron i.MX8MM N801X S";
+	model = "Kontron BL i.MX8MM (N801X)";
 	compatible = "kontron,imx8mm-n801x-s", "kontron,imx8mm-n801x-som", "fsl,imx8mm";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 8f90eb02550d..b6d90d646a5f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -6,7 +6,7 @@
 #include "imx8mm.dtsi"
 
 / {
-	model = "Kontron i.MX8MM N801X SoM";
+	model = "Kontron SL i.MX8MM (N801X)";
 	compatible = "kontron,imx8mm-n801x-som", "fsl,imx8mm";
 
 	memory@40000000 {
-- 
2.37.0

