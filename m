Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CD451DC24
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442950AbiEFPeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442959AbiEFPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:33:10 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6406D4DC;
        Fri,  6 May 2022 08:29:24 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MDhMp-1ndKip2Dnb-00An2N;
 Fri, 06 May 2022 17:29:08 +0200
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
Subject: [PATCH v1 16/24] ARM: dts: imx7-colibri-aster: add ssp aka spi cs aka ss pins
Date:   Fri,  6 May 2022 17:28:01 +0200
Message-Id: <20220506152809.295409-17-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nKqrTlnfyoophG4uqmO0F2g5aXMs/Js2LGRBUXnKXeCXMAKtzq8
 mamz0+Ayc0+Aef/a6lvIGEZgGGz7mU+ITzn78a9nRoxhuSRVdxvFoDLNjvK1ehR4zZVOcIS
 NIkVTf/4I8lQbHbjes6dJtmgjZM/k7b/CBEu19BXjdPU87dJzS2KWzTYiMN0NsqCKFyFCrU
 aSluKyaoJwiEybdthze2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KiCqJKnr4q4=:SrQmKfmYytYdWHT5H/0jEl
 83O3ynn8vXvgId4fC+d1fmftMcg4VlO3TR6sRIumtgqtBsNQjWMaUTQc0ov4CqgUn2ZOETkL6
 WvZhx8suLNDXEGNDe2366Eg+xBHF8d24EKJuDueJjqNbcjv3XkSYUDQu8Wl3pzXKN6jMst9eG
 I0BfkhkKOMCiEMZiedLn9OhMmoOCM6l4Fg9mILwiofnVYH/AV8i8xQZKoqgpPWInxHU416yz6
 +5M8BQPSiYzLruCXZl0KMA7ndUq8+ctf5QQe/v7ndec6AZDRA51FSA5WeiI8odbQiCs/ge7wn
 gbHOuAW39OfnxLPEmhwF5qVg/JYWqwKCuX0Ph+atLQanXyhFZg3pvTCKXjfhA3Zbijo/dXULN
 feGXPE8pUJ6Bi9JI3qafqH05EZj/nOrBjdZ1TbgvwUIyzH21RRV7zibIrsbIO6NA0weiCf+oe
 NXrU2nXRqkrogyHte450ntUDQ2C1fJszv7pWYbNqcH5uK09XLl2V89Fo1ei0Vk/csDKZzzoL/
 ymvQG2mwIhPvt6BZr0ZuJFKJefRJ/fprLYTaQstuhZfR0qILo79pBjImvIZaujRcHXmrdTncc
 ABSBkYr26NDtE3m+iLsyi/iMsHjERxFe2G4XOs4jsotq9GCJMDNpMr9Pa0pn1BBFCuS5nyVL8
 FpbpyRlqkcT7toiQXGiTAQ6BiMx+SzQA4lL3K3NWQcPcPjo3O9EUYcMxHRPogmPjhkRzxFgtz
 LbPvNijsX+Yvo/Km
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

