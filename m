Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD151DBF6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442858AbiEFPcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442844AbiEFPcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:32 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E216D1B7;
        Fri,  6 May 2022 08:28:47 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mf0mU-1oKec41w30-00gUIs;
 Fri, 06 May 2022 17:28:34 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/24] ARM: dts: imx7-colibri: set lcdif clock source to video pll
Date:   Fri,  6 May 2022 17:27:48 +0200
Message-Id: <20220506152809.295409-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vSCZ5YgcOnht+rU+P/yp5XZyFPki1/TnBDAr4rZvvxjZug1loKm
 947oYNZNiwSoDJcvYgd81ounf2xpYhPf7Hr1kVVI9KvXVl8vFxHkWC7PZctVo3K2/O22zPV
 A1xHmesZSdkONkBslRYtqcoE4R0twLtP2EZuxDNX7by/07bZe6W5npUFCV5RPDjB4UGiN4D
 0ozs5iq03oamS8FRWiogA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lkBEgLpH6RM=:oRXdYnalGQzxW2RYQF7h0n
 yA+gxkED7KBqgnTWGcd9/YOD2Cw44R5i7VgOQZ+LwWNGypbhRPG4/Pc9NuUx9yxKGnwB3KceF
 5ROitGnengQD77e6uGgYnKSD27djktNgx6sBCayPY7wCVY7F6rvzSQYn7xNpZKzZTU1RWptpE
 Dywv8PZcLhh+P5gkxTEKxJiEZ4lIix068KirIz//j/McQkJWVhUtZtqCxz7ChMAQFojljLK4q
 fCPM+uFSt1nmhgdT0rSvp6cSNs/uM2vmkxz3fbGGx1i634c+VNH3FLpjzwm7pUvKHeYQthdur
 4/a4yDthk9QCcsSXd/XThV1EjkPBRSFAMO/IDQYz/VgNbTSWy5M1C/j2Sxu1Z9wbfJW3gXzaX
 zj26rYxthv7Apluuz0p5ijhaTX8Ae+LD0SsgHCKOxrA/eezf8qST8TeJLY7DIJRF5vFYJMQTi
 JW2+AmCWbPsVdJYvHHEMX8TnZKTxZc6K+Lli6NEiBWfE31rDBRSIk9x2eNu3cxCP50XFGzfti
 chtY85QTidK6OnxL2aBRXF9MOGXJefCJl2lXRc/jscBmK9KMRAsqe0RoaU2dudG4BURzAaW67
 gmGOFHy13v/INgCOXfp3SyAt6f0sGdZcI46HOxeu/MXA0N7Wd3CUrFSzoKJ39LOIl3CRArbXp
 2rxZBL3KU01c/xFbLyCe5EVp8N4UPLa9epOJZRsfOo9JTrgTV1OPWkFQOajFGlpDa/M4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Use the video PLL as clock source to assure proper pixel clock
generation.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 074ebb0f8001..3c1cfd766645 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -441,6 +441,8 @@ atmel_mxt_ts: touchscreen@4a {
 };
 
 &lcdif {
+	assigned-clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_VIDEO_POST_DIV>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat
 		     &pinctrl_lcdif_ctrl>;
-- 
2.35.1

