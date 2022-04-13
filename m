Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99B04FEDF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiDMD6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiDMD6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:58:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3EF13DD1;
        Tue, 12 Apr 2022 20:56:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E8CD5C0219;
        Tue, 12 Apr 2022 23:56:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Apr 2022 23:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649822179; x=1649908579; bh=Fp
        hEGeu2TKs5vrPfK6f45SzuLyN0QBXdvH1zTwhivJo=; b=baW0b+RpuNN2H2Vxi1
        MMXpw+XcqM1AgkazBgfVkZRH9ktKe+N5FE7XeC6QmyQS0I9WEq5xm+UIw0dbU1nL
        da4P7mBqCmCFgXxz6lVDcVSLJ17t3cW/wIl2ReOP64hrMPl8EjkcRy6Yef+fGBwg
        o49/Oj0vHLzv9T5h3DtK28MbjHY3q9gHOge2SJPQLhZEUb2ciaTCY2wUlXFBNKYR
        XZopA10DQyLLVnXTCtOuXbxyRpdq282+/7coM0Vsd9my9O4CnS+avvv2wjXiu1Pc
        w8dtxapyWRAeVb7fJI4+mb6pTDUEnoJqiAnMqe8T4w3YI6g+VC/9yYqjmNJiiprT
        qD5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649822179; x=1649908579; bh=FphEGeu2TKs5vrPfK6f45SzuLyN0QBXdvH1
        zTwhivJo=; b=OrzQU1+t/IQ4ke5pVMjODv71ZUVAmqgKqvBNR+Wt1JA0fU24j49
        yZozH6FvFa0IX4nIQKZD/s7yt0Fh7D0ABvslJqHZ2f6/a8lZbE/nRzPOa2URBueW
        AbdDuH1oENdc/zlhuws4OtDWlCbPtJX+XUHvsyDhD8+rHSIMQPJvfu2rr2vY1Oak
        POzstT2lQ4Il+mQLZl7F9Oo/dKbX2IZe4YkNu/0+E/0leHiE0b/Af0+PkkXIPJdY
        Uhw3rslX5XIqHf7FqD5IaZHaOVSFugi0XmzJPlOF40I4G2Nu+Hz7jyPa05Y9lMak
        epjGoGaxdpUKTHIc8SaxQSD14aeS9xEZ8cw==
X-ME-Sender: <xms:40lWYpJDiSXEt7WysQlbDDjtq6Z9QH5QH2U9gKeY5_Ta3kwg0nG97A>
    <xme:40lWYlINtXwSFJvfkh3hiH5lCrJuT8nC0wpHERITiVETyrQ7WtlQrWukyM7RnY11K
    mi4eVg15vJbGK3HkA>
X-ME-Received: <xmr:40lWYhuwBh4ZVKbztHIbH6_LASuoA5rcFNqCG1D9FQA3anuiBTShkx31Np1pJmfrOVZrurq8NNZuaMcu6iNGUXTeN0WU0UaoQXwc6_dez1wRNZOKLM4fevJ-l4eLqCppN3Hz_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:40lWYqap2NKEUJt1dX3UELB7Trah-pG9ux2Vz8irTslCNIHBUcdgmA>
    <xmx:40lWYgYk9wPIb_NThFm3tZy2SVRbuksyPOoOtaN7yBJHr1VG8havkw>
    <xmx:40lWYuBWBqXiegJXWpjZnBT7PYHgreZVp6OApiNdnV9-2z3tgJvEfw>
    <xmx:40lWYlOx9qPtDW69LBwZttykHQoYNAmQnh1wUrIQtqiPo8TDwhUbGQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 23:56:18 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: pinenote: Add USB and TCPC
Date:   Tue, 12 Apr 2022 22:56:14 -0500
Message-Id: <20220413035614.31045-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413035614.31045-1-samuel@sholland.org>
References: <20220413035614.31045-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PineNote has a USB Type-C port connected to the first USB 2.0 OTG PHY
and XHCI controller via a Willsemi WUSB3801 Type-C port controller.
Add support for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../boot/dts/rockchip/rk3566-pinenote.dtsi    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index adc0e7d39fb3..e01668e6e5f9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -466,6 +466,39 @@ led@1 {
 			default-brightness = <0>;
 		};
 	};
+
+	wusb3801: tcpc@60 {
+		compatible = "willsemi,wusb3801";
+		reg = <0x60>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&tcpc_int_l>;
+		pinctrl-names = "default";
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			vbus-supply = <&otg_switch>;
+			power-role = "dual";
+			try-power-role = "sink";
+			data-role = "dual";
+			typec-power-opmode = "default";
+			pd-disable;
+
+			ports {
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+
+				port@0 {
+					reg = <0x0>;
+
+					typec_hs_usb2phy0: endpoint {
+						remote-endpoint = <&usb2phy0_typec_hs>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &i2c5 {
@@ -572,6 +605,12 @@ wifi_enable_h: wifi-enable-h {
 		};
 	};
 
+	tcpc {
+		tcpc_int_l: tcpc-int-l {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	vcc-wl {
 		vcc_wl_pin: vcc-wl-pin {
 			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -659,3 +698,22 @@ bluetooth {
 &uart2 {
 	status = "okay";
 };
+
+&usb_host0_xhci {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	status = "okay";
+
+	port {
+		usb2phy0_typec_hs: endpoint {
+			remote-endpoint = <&typec_hs_usb2phy0>;
+		};
+	};
+};
-- 
2.35.1

