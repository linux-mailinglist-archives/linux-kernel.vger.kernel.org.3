Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6734E667F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345472AbiCXP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbiCXP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:59:27 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA8ADD6C;
        Thu, 24 Mar 2022 08:57:41 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MCauF-1nPTk73LzX-009gNd;
 Thu, 24 Mar 2022 16:57:25 +0100
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
Subject: [PATCH v1 09/10] arm64: dts: imx8mm-verdin: note about disabled sd1 pull-ups
Date:   Thu, 24 Mar 2022 16:56:48 +0100
Message-Id: <20220324155649.285924-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:J0L8YMNV2NU16ziuUi4evV7m5GogN7KvqRKUdIp6eeQf5yCXUv3
 M+uVnYvHD+A9act5Wq8lV8KGcoH8GwC+Uso+SNMdWS6fuDGS5fNxvVQ3G0CpKa2SS28OKyc
 nq7IZNIxMuHIwOkxtLBVIl4NrgI3CzZ9N0E6edQ4sbrtZ8fIe4f4d4bkWHBQbfULFBTf+mi
 ++M2/0hwy/U+koagUdKqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ofsBzLGGVaY=:TFYqjvQV4bBu3TToWdb8WI
 34plTcYjChlVtsE2BUeIZnWs5sw+7vWXFLRta/aixoUNsHOvOJblfQ/XiSui26m3fKXgfuUDT
 wJBrCoOYsGlxTrHi9KY2Azrk8q5ixjRbsKYEvQx2LLpkEgcjpdjL1rz9t9RlGaN1hMZG6xGBp
 nTwgHi2SERPty02b3G5apXs58MbcKFbPrbJtWYeDKeuHeKOuQrvcmY4k/L5x2lxbfBqj5aQoT
 X43z66XaUpfIiPcy2ZRhZON4PNADRx7bkoousRxmMp5PO9EvrA7mxbSvSa/EIRZ0+39/c8omc
 alZoxWiWoGkIenuBQ5vuTfjD1iGqaP66fANjYwn7SGbg/dFO/Z7CC4ahB3rmsbm0K469VLEDv
 zbUt1S5uZLdT7UZUEi2jjS6ZbNeB7OG7/fSxibhRPYsXYo9aQkNepXZJUZG2bskUK5TQ9NRqH
 4qb07IARFA+/gzNK4wUQusXlfpG5a+r8jJj4bvepBGA+kVDUNkQmDHxg4Qc0Nerk1UCB3PcKv
 EdPHObu0JlGWnbL/cQaTzewjhz/MHXm0nwAPe5M2lHy5CzsoJLpPXzZ3lldPwVXpam+V+Mn1n
 QVS368gUUtsTSTZM5YLruezDttGxP7eD2IQfYaEg4mtdrO+sMqUQBKly6fpX+CSsV3CsTs1qj
 VRIV0miblYdJ13k0oYGld3rDY1G++H2blCJ7qdxRat63KtxhJrtKWkf0MfcRXuGEf8Qx33fsB
 KYYtuKvRESDrKdkm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add a note about us using discrete external on-module resistors
pulling-up to the on-module +V3.3_1.8_SD (LDO5) rail and explicitly
disabling the internal pull-ups due to ERR050080 [1]:

IO: Degradation of internal IO pullup/pulldown current capability for
IO’s continuously driven in a 3.3V operating mode

[1] https://www.nxp.com/webapp/Download?colCode=IMX8MM_0N87W

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 6e1c762fd2e7..97dd7a00d63b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -1179,6 +1179,10 @@ pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
 			<MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5		0x6>;	/* SODIMM 76 */
 	};
 
+	/*
+	 * Note: Due to ERR050080 we use discrete external on-module resistors pulling-up to the
+	 * on-module +V3.3_1.8_SD (LDO5) rail and explicitly disable the internal pull-ups here.
+	 */
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins =
 			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
-- 
2.34.1

