Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7517F4662ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357552AbhLBMAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:00:22 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47151 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357554AbhLBMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:00:12 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6B5965801C3;
        Thu,  2 Dec 2021 06:56:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 06:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FvePu4DfaAI5Y
        pELNve5G7W9fZNbhwwYhYrMJeaayx4=; b=KM9Tlfq7ZmpHTvPmaRA34UC0sPEDr
        vw2MhIE4MjaCdy8UYkIDSJbYG/a7g00m74637K1pxIE1U0hg6gkv055KxctnDaJY
        3CjmVh6p4DLC7K9XOBfHHMSSZxPEytaajWHSm6IEApeGtUSe0IuwBtBg6q0uVzVb
        TABaJ61R8V8VU4X7UdM7sPIhELt9p5lQwxPGc720frZD28hIqVAm109vAXN6WlSL
        9RmJtNcGUzCa23bijVIE5RO1vQaSUkbyHda+pMAEZkYk03Uujk8Seo7EoKtRyKb+
        S51DoDAyBB3uqYCf+RbV3LGYJjnnAwuo7gGHp1kB26YwUpGzyY6efghmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=FvePu4DfaAI5YpELNve5G7W9fZNbhwwYhYrMJeaayx4=; b=OcL96ON+
        2kK5nKID4pKY8sAR2jgd055cIdIfEfE50Jv23ZYgSf33eKMgAKzlfW2XdJIxTcxy
        4y/R+lSbf2NX4uC3o9mIcn/NSllVmoJUarNlaF9PZNJyvg7A8ierXHhpiTCcvZ1k
        GEUnPzwf8I9JBoAanlVyUp9Z1YXKsclv5hp17w4JkZRd5/SLV9GsT10fqjz2nRff
        bFSgNYfDXzLzVYxHeD/3D08t1Y4BmKy/2n8WGnATpPnLdXgQwAY7WXlAX4vX0QDe
        vbjzWCxGrzlzvs0B74PdZtt2W8bQUUJwY0Z7yYMHj9GuOeln6mMgVLBVjDC157sT
        eM1Q9zrR/5yUdA==
X-ME-Sender: <xms:gbSoYVY_ULyAdOTcAMS-Jz4Os2TigV2whre8e34ZE4yDrGlUhbji-A>
    <xme:gbSoYcZXUIaZOVKZNrtXZtHRENOc98ax5AdlraVs0iI1q8DeOrIoHZT_MrXfOUps3
    _RmE6q0e1HWU2oK_Dc>
X-ME-Received: <xmr:gbSoYX-b-fRFHYvk4LHntCZ0RrObWK6TvuB1IyKZlCmRZkErr8U1y9ip5_U1PFUbF2RB5AfQvdMyzqh_aiXLszz0EQ3c4KbgXBq7G0DfwfQns-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:gbSoYTq78k_wz74P_YUwEIa18MBW3YlnZsTvFhYYJd81HseoC4OlYg>
    <xmx:gbSoYQqYS0CWN0cveqIR7MQUUiuLVvvOGgy-oOUr1cFZT7J1ohZuSQ>
    <xmx:gbSoYZRU56AB5Hj0IBtF_PrWxGVAcnoSUhG0AvlCEltMmRyj_0-wTQ>
    <xmx:gbSoYbAZt0MRhZgp3ThTuzpiUsr-_lIde68L3OsSPTE_6L_FHPfukg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 06:56:43 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     benjamin.tissoires@redhat.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, dmitry.torokhov@gmail.com
Cc:     Ping.Cheng@wacom.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, alistair23@gmail.com,
        tatsunosuke.tobita@wacom.com, linux-input@vger.kernel.org,
        Jason.Gerecke@wacom.com, linux-kernel@vger.kernel.org,
        jikos@kernel.org, martin.chen@wacom.com,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v15 3/3] ARM: dts: imx7d: remarkable2: add wacom digitizer device
Date:   Thu,  2 Dec 2021 21:56:22 +1000
Message-Id: <20211202115622.40153-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202115622.40153-1-alistair@alistair23.me>
References: <20211202115622.40153-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 59 +++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 89cbf13097a4..a2a91bfdd98e 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -34,6 +34,19 @@ reg_brcm: regulator-brcm {
 		startup-delay-us = <150>;
 	};
 
+	reg_digitizer: regulator-digitizer {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_3V3_DIGITIZER";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pinctrl_digitizer_reg>;
+		pinctrl-1 = <&pinctrl_digitizer_reg>;
+		gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <100000>; /* 100 ms */
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -51,6 +64,26 @@ &clks {
 	assigned-clock-rates = <0>, <32768>;
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	wacom_digitizer: digitizer@9 {
+		compatible = "hid-over-i2c";
+		reg = <0x09>;
+		hid-descr-addr = <0x01>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wacom>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+		vdd-supply = <&reg_digitizer>;
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -117,6 +150,25 @@ &wdog1 {
 	fsl,ext-reset-output;
 };
 
+&iomuxc_lpsr {
+	pinctrl_digitizer_reg: digitizerreggrp {
+		fsl,pins = <
+			/* DIGITIZER_PWR_EN */
+			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x14
+		>;
+	};
+
+	pinctrl_wacom: wacomgrp {
+		fsl,pins = <
+			/*MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x00000014 FWE */
+			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x00000074 /* PDCTB */
+			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x00000034 /* WACOM INT */
+			/*MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x00000014 WACOM PWR ENABLE */
+			/*MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x00000074 WACOM RESET */
+		>;
+	};
+};
+
 &iomuxc {
 	pinctrl_brcm_reg: brcmreggrp {
 		fsl,pins = <
@@ -125,6 +177,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
+			MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.31.1

