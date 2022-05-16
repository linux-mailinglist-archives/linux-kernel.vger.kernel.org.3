Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A0B5285F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbiEPNur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiEPNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:50:07 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0119F3B280;
        Mon, 16 May 2022 06:49:09 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MTAx6-1oHVLN0eJi-00S6UP;
 Mon, 16 May 2022 15:48:55 +0200
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
Subject: [PATCH v2 16/24] ARM: dts: imx7-colibri-aster: add ssp aka spi cs aka ss pins
Date:   Mon, 16 May 2022 15:47:26 +0200
Message-Id: <20220516134734.493065-17-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QK7WzCsXyZdHOHmT34mhC9fW3aW39xdObJh1k8i/5c4hOgjpUfW
 tQ2yar+vS8NADTdUo7F1rqyruo5CuXxKlkLvmjsPHyAkGsgm4cj1YT9qIGLxju8NpR8Ivis
 dFF65N7wT/viURxUX2R8ARWak7ytZlWWmRjTQAjlH36fv3mdfk5jbbwoqSvjLrLE157SdnV
 jkxLvydAhwKhdXUN7OBYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I60MfpkClAo=:d7pSxpTvgKw6OFRrvsMX67
 NfAcorH8YPBGVpHWOqCBvi4cBpX4ETafgOGHSnEET23WZYNe9nCeSVhsEX7XEnJws3YmNVoHq
 LDcxKr/rRiMeptSm5WQTqaIDtoINqWzWSnIxJsoO8ifdHCde+reSn8g+hNjv44mHFRw/feiEF
 jmkhKOqLr/mzeaQSvXiDUw0iaNgQ7PRPB49D5XdK/8oFMhNPIlX76HfsEdW4x47ytY5wvD3PP
 ZV+fjZYX+XUL/F8zMZAlNPvKSNAd+4PE/EqSEBpGvwHb+oUmbLdIP/OSm8IiDdG6LXeAVfffy
 upm9BKtc6cX2QDy9auycHeZWPkRZqF4os9Db+v2DZZy9m17nd8Y9oLSi8lpyuglRPi4HO4FC6
 ln7pOBQqguqYPpAtfKzvJcwt0jHa2DGR/Z4Q4fkuSzCxAPKDH5Lrq2PFBKjbj215rj5aufMAE
 YTwigTilgeXgSdZEQ3z3462TJQhEsbIDzAXRuMedjX7Sbp3bEcRJ5gFM9SIIgbEvgTUdjDBRr
 7MV+kvaonGRUt5kqKKLZIzNkhFGjGUYNZAImnJEJA064QXZtesXOpgSXHwJ2RqEt0bhgkjipH
 2OKP8m5SC8Pvd8vTwoWFN0TxwN8GqnRjA85ASMKauI+l+hya9Yp/hRzO/ygoQF9u/0gem4Ozr
 DLEhGBmbuiIKmQlCPkKkppM/RDNej/02YqFON0tuXxD26tem2ApUePcPhy4WdVeY7XKoHaFIw
 x5DGaKozCzUD/Ago
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add Colibri SSP aka SPI chip select (CS) aka slave select (SS) pins as
either used on Arduino UNO compatible header X18 or Raspberry Pi
compatible header X20.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7-colibri-aster.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index a89c868ff3ed..117965705814 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -7,6 +7,16 @@ &adc1 {
 	status = "okay";
 };
 
+/* Colibri SSP */
+&ecspi3 {
+	cs-gpios = <
+		&gpio4 11 GPIO_ACTIVE_LOW /* SODIMM 86 / regular SSPFRM as UNO_SPI_CS or  */
+		&gpio4 23 GPIO_ACTIVE_LOW /* SODIMM 65 / already muxed pinctrl_gpio2 as SPI_CE0_N */
+		&gpio4 22 GPIO_ACTIVE_LOW /* SODIMM 85 / already muxed pinctrl_gpio2 as SPI_CE1_N */
+	>;
+	status = "okay";
+};
+
 &fec1 {
 	status = "okay";
 };
-- 
2.35.1

