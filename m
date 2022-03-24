Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFC24E6682
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351536AbiCXQAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351472AbiCXP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:58:58 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EACAC910;
        Thu, 24 Mar 2022 08:57:26 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MQuoF-1nkOEz2Jfj-00NzkD;
 Thu, 24 Mar 2022 16:57:11 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/10] arm64: dts: imx8mm-verdin: only dashes in node names
Date:   Thu, 24 Mar 2022 16:56:43 +0100
Message-Id: <20220324155649.285924-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RbidkmHjssLyiM/TmEFPTSPIEZ5Q27hipqEGEfiEfERcgejaXyl
 0Jig1ilNC0XalGChofdhOBcm3yW3wc5MTrGgXj2Ow/49Ab0+VTxtkRaEybSgiMlYEAJncEQ
 ub0kQylDPH9s6+uM/iwOW6TaOLxxvoHiqgUVEuWKZngwuWZcboeGvfmUrvMr6Krmvwvtngn
 NghxGt+ebXD/Mma/EOQnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6UleY+X6sik=:rXdLEn43KdRa3YoPVR8rqr
 bk7Jfffue9WFIGFC5dJWd6GXJzlVYW12aSyqNBab9Q23hu95ipLqCBcPVCEv1Q1tTcpm5m2lj
 G7jeTWTlO4RXP/ZeBmLXHiExNArJpPCUzTHTuzWIP9lT698KBYp2grAqJ3I1AJvwl+xCv5wd7
 G6CVuDNIYMbhpzVvg1/OAcVruANMX7tX7p0LZWCp3voZ/BVcXJgF5ioCdjq7gE21aJi0jEWqi
 MZv1li367rR/+ra55ZQyS74GyiF6L3Z9ifMhQt9Jofe6CTwS9hcweMdwR8K9s1h1s1WG8ruSO
 PUfJCxRIkmk+9qKKLpsybLk1HCKKlPP5i6jgH87KngGv/J87JRWUdqIneAyTNQoVCM7sTy5xN
 XaId7GtvbrWkZOnyo3FC8D4rID2wMIWWYA8Cyt8WxpzJYlHzad72ueYaMWVpewDg4QTF1FD9F
 fsrBGnYJiZucb9GPvobVJ+nVW2mynTDfVqRo/9wujjpIECSzNVXv5GKwGJ10b/b/KgIMitvEe
 3iptiUft/4X3+4W2iEk6F3Qa8BqT8foLRyToX0EavwSIwTBJrejv7yiAfmy+uJsqHJk7M9pnV
 XrI5QjSg6K7agVROSOq39gPbRErC2qmM0ngObg/zozpjig6LdKJ75B/9ZX2OlnTO56NSRzKrd
 vLNNg7WlTG2Pg5PW8nHMb/UnO1TS/ApVuEcIp/Ha+EMF4lXV4OBptUzZwVFIfq3NNMOU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Make sure we only have dashes rather than underscores in node names by
renaming ctrl_sleep_moci-hog to ctrl-sleep-moci-hog.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index de811be435d0..599b620ae04d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -306,7 +306,7 @@ &gpio5 {
 			  "SODIMM_151",
 			  "SODIMM_153";
 
-	ctrl_sleep_moci-hog {
+	ctrl-sleep-moci-hog {
 		gpio-hog;
 		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
 		gpios = <1 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

