Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEBC51DC87
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443158AbiEFPvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiEFPvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:51:43 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674526D86D;
        Fri,  6 May 2022 08:48:00 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LvUd3-1nwB1t1moF-010brg;
 Fri, 06 May 2022 17:47:46 +0200
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
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 20/24] ARM: dts: imx7-colibri: remove leading zero from reg address
Date:   Fri,  6 May 2022 17:47:41 +0200
Message-Id: <20220506154741.297113-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r+HKnxhRpsInSg3nRXiugG23Sm6B9ONWuaxBCPuz+UDLtQpvVFA
 dx4kUurDF+VCEM0vykmCX9NdkNIebnA66QB+Vt0J7NofBZilonxWdYfi0n39/7iiT0VntQb
 1MSEjEyKPV1YYSUZh8a7N5MaSfC/blUJDetaH99vJkaCFQ1QG9Y4kOY77UD82KkhE3+dzMW
 JjAXLbntLIyD/Ul4Eg/CQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EKLp9383S7g=:egXWD78DDq/pcMTSdKGqG/
 DUe1VKZkEgd4iEQcFuoFZi+RWBWe8o/0Ncx2WXm3zx2LqXxCEXAbbPjpeIKCkW1E9nfwRbENg
 405wn8dqNFUkFZlOG6+hxnmiDvf5eq4Uy8RPB6o+CxR5LB+FEfpBJ1sLAOrl1A5WJySXIbXf/
 xdEtv8EHq5XcDa0tB1q/yQaG7ptBQtRUARi0EPb6Whli/gUCNVVq2Aa36tAuCktdApc7oESrC
 zLW6dFFxaczClsiALR+K1NJ9O8sU90uPaiM3Qz0c1q/Ep8Oh8mP9q/fJsnH1RvXbIuoHAs3JJ
 ErL/dbYD8tlgXje0gfMHk/C2gm2lda8HbU+cgbfv1XGqWnZm+71IOFB19zAfbeZ8weV/hPqYu
 eQYCr/XR8i8ad9+TJDpRdzi9edoK4K5e3sJLwqCt3MOCVO2kN/DnbYvZ4+4EcaI/LqfYBYdHl
 T+86MQKdJGtbbSHDjTt7zcNKuK0YSRtDcDcy+RosevzKc7mNXmg8Fw6IthfMGM8fMYkRpy41i
 HSw3EsJ0Pj8gHdtBQNo96WbotojzN7EgifOoWZJh+GeSTmjJNjqUQwUb4aBsxUdOLqAsQJ703
 sjY9bE8/u5/mOBub2XLyaL0LvHuH8IS15XbZxupMmq+rXO3L0gJKuozvqv3Y82lb8sePWQ7Bi
 SwzngtbGuOrk4XAZYpPv7Hi90CwjpPfoA4qwbLABf60qWxEfkBdj2pVuENt6VlyfghFc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Remove the unnecessary leading zero from the reg address.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 065d8f55f326..cbe4f072d4ef 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -398,7 +398,7 @@ codec: sgtl5000@a {
 		compatible = "fsl,sgtl5000";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sai1_mclk>;
-		reg = <0x0a>;
+		reg = <0xa>;
 		VDDA-supply = <&reg_module_3v3_avdd>;
 		VDDD-supply = <&reg_DCDC3>;
 		VDDIO-supply = <&reg_module_3v3>;
-- 
2.35.1

