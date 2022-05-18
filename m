Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371AB52B7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiERKSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiERKSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:18:08 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 685F49D06A;
        Wed, 18 May 2022 03:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=q7y9U
        ErI2PocEDGVAu8nSItLWsdvHnnMxOp2rxgeIqk=; b=ChoR4JqbWuZqVu0CiIKc2
        SQr7N9uKwxZizzYwCBnodkyVX9pK+glB2idwqg4y1g+p4Kz7Y6M8xjK95GOnA7vC
        sbzLXebDiRPgGTFSmePWAoknqWsUVde8vCRfdC9RZ386PGkqcfZ2z550gIahqUZa
        OmEI3dc7Asg47SaxfgG5Q8=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.20])
        by smtp13 (Coremail) with SMTP id EcCowACXG6mlx4RimzKrDA--.63720S4;
        Wed, 18 May 2022 18:17:11 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v4 2/2] ARM: dts: bananapi-m2-ultra: Enable USB0_OTG and HOST support
Date:   Wed, 18 May 2022 18:17:06 +0800
Message-Id: <20220518101706.26869-3-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518101706.26869-1-qianfanguijin@163.com>
References: <20220518101706.26869-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowACXG6mlx4RimzKrDA--.63720S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFykWw4rAF1Uur48tr4UCFg_yoW8urWDp3
        sruFs5Cw1rGr4rJw1aqr4UCFy3Gwn5WryfCF1kCa4rJrnFva1kJrWIk3s5ZFZ0gryrCw4F
        yFZrArnrGr1qywUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRctxkUUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbCqR0F7V0Dfgie6QAAsD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

let USB0 work at OTG mode.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 28197bbcb1d5..b3421e67967d 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -122,6 +122,10 @@ &de {
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -164,6 +168,7 @@ axp22x: pmic@34 {
 		reg = <0x34>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en;
 	};
 };
 
@@ -199,6 +204,10 @@ &mmc2 {
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
@@ -216,6 +225,15 @@ &pio {
 	vcc-pe-supply = <&reg_eldo1>;
 	vcc-pf-supply = <&reg_dcdc1>;
 	vcc-pg-supply = <&reg_dldo1>;
+
+	/* USB0_DRVVBUS connected to both the PMIC.N_VBUSEN and PI13,
+	 * we chose PMIC.N_VBUSEN for control, so set the gpio as
+	 * input mode here.
+	 */
+	usb0_vbus_enable_gpio: usb0-vbus-enable-gpio {
+		pins = "PI13";
+		function = "gpio_in";
+	};
 };
 
 &reg_aldo2 {
@@ -298,6 +316,11 @@ &reg_dldo4 {
 	regulator-name = "vdd2v5-sata";
 };
 
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
 &reg_eldo3 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;
@@ -333,7 +356,23 @@ bluetooth {
 	};
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_vbus_enable_gpio>;
+
+	usb0_id_det-gpios = <&pio 8 4 GPIO_ACTIVE_HIGH>; /* PI4 */
+	usb0_vbus_det-gpios = <&pio 8 8 GPIO_ACTIVE_HIGH>; /* PI8 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_vcc5v0>;
 	usb2_vbus-supply = <&reg_vcc5v0>;
 	status = "okay";
-- 
2.25.1

