Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3725286A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbiEPOLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244333AbiEPOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:11:38 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9900F117A;
        Mon, 16 May 2022 07:11:37 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LxQMu-1nnvbr0Qhe-016uMT;
 Mon, 16 May 2022 16:11:25 +0200
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
Subject: [PATCH v2 20/24] ARM: dts: imx7-colibri: remove leading zero from reg address
Date:   Mon, 16 May 2022 16:11:20 +0200
Message-Id: <20220516141120.494428-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8KHUJfCuEQy14gIVdhN+LCRvu4wH1PdJdpoC734Fkpi3U5ZAGnR
 Wb2uupt/9jTzIvlSJ1aG4Xa/Tax79gGHmh7ivakA5BkPJY2IPtnw0sCxmr+hfM9nLgq/6Ub
 h71xOJh29IdEBN5kuz4gOSblB41WuP6e8quDmDzSUUZnk9MMmiHgteFfTFc4Sy2jTPk2NYv
 e0MEcdTPFIgf2HyhGzVyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PtEiIZzTocE=:iaK2PpvvlAiQw4fP3vSoez
 KU0Rhrp7DIjiT6PhqfWRzFPE8rjxQqpCdS4oiiFll4UZS1OqqYyWHkYm40XLa8cg6WTOM6UF7
 4diC49kdgVuePhN0xHUIqu+e+MofkJ/3tzdzcJXbz/tjokNWDE7OqvBeCM+SIhsE9Wce8FJuR
 ouFjBG6HzjHAdV9C/gia+JPoY67rddhtk1Ad1HE7GLmn+M9CBOqykQwm2rg73G8oDrntqGDQl
 xgipFxrs8trLkf/T85qM/Uk4nHCrfT1bd7uWncqtGS3SNyyT4U3/C2GsVK0DUTOyAhXatsvCV
 q2ZwQOVwrg2N5dUxYrC7OQxwAYzTYqhSXPr6cpntX97MiW498LxKH8jipNr86uXHFRnxG5eTA
 TF2fqb47CDlFjM7Vb3yN78i0hsDFk4GZokpj/3uWG249oSWBghLL0E/0jy1XXzM8A/VVA6rZs
 Z76acMXiw329BKeavxhvj/Lu0RGsd1fEj+pkFyKjBLpe1hIFiEqZZDIFTlIMmNnuEgvOwJ0RU
 XDWTyaVym/P3MWn+sahyYD1WxuDSUIQVbH9zFk8ly/tSuGKuWjNJNKA0dXhwOinwcq1GOIJ9l
 /evKqlIZmUB+OtPGml+Uuou7yErRmwoROU8kqQewI6QmeWJowimnV073WWeUJ1oG1h4VdZbwx
 tdQmUuwzApBAzGpD3S59WIzugq60Rd2brveHEu8YlBbm3gc+ppgbuWXhZcc6z4J1ep2dnM+VF
 OuFrRsfZv7rD1bOq8fCjs4kboRQHablp9ix3ulFODmC/5YMbkMsnn2WTkcU=
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

(no changes since v1)

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

