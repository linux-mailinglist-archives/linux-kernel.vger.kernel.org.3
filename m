Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930225928FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiHOFJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiHOFJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:09:03 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6515A35;
        Sun, 14 Aug 2022 22:08:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AAA5832004AE;
        Mon, 15 Aug 2022 01:08:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 01:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660540124; x=1660626524; bh=Xg
        67cpVoKilHiV6W9sCyOWTKHbC+N6ZsdgHn/O7Wskg=; b=D89ga/moFrPMej9AGC
        pD8F2k45vtUqUXuICHINrAJlkZAqAEZY+3/GRHCG0gGmlXRAFOXYDAfXhcUrg0Kw
        5ebxBEnDTi65focBN2C380jvod+5WPVqZ6ZEOkR6z3EhxEmo0fylqWM3cJY/3bkC
        aS5hPiP2YXcMLqJRSfluHkOgFZOlZvE5/qLzZ/PYj4cYllAIyuXeoyZAV8Xb+IO1
        hP13wDQwjMG0lKRxtE/CqVhYkRHoA2sPwpr4ezN+eKY3WtuLrOlQ2qNJMDaBvVMx
        MdOiMyBYBWi+86Mdt/5FYgqrA007Nwa6+qtZIWZfeqMgLNvlAAS3OFvmw3+l/hPZ
        1R/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660540124; x=1660626524; bh=Xg67cpVoKilHi
        V6W9sCyOWTKHbC+N6ZsdgHn/O7Wskg=; b=ifIQL5okeajhNQ+a3b5osSpXdoxJe
        PGb2qdjW3WSMVD98q607suhXOBSTI5yFcuqzWRG+Ie+GE2eUegt4TITjwhuZsWQF
        ARs5FcDAMboaZGAHk/0z0bgd1Cw/PzkdIr161hjTp7G3Zdqji7JCanIdJ2wtVbI+
        Zr+pZcY+EJeKqnnBuuJocEkh5ekwgC/aW+eOYuiH/Ks7Z0L2T5+whEOBkZNtgJ1E
        BKToj6y1slatpEQWCcfZ8KINCethySfaELTZKCPCRCu0l9EbFlZyZ2+ahAQ8eIFc
        /q0k4YFHq2F7Gfrp2MJFQRYN+g1+YSoq/c328wXOPuWbW4oU7visAY9Iw==
X-ME-Sender: <xms:3NT5Yp-bztfOLiNQ785lhtPmrDcpqzizxShBGhj4Y09SdeuC2dhbXg>
    <xme:3NT5Yts4UyNGT0XEPUWBwWfWMN7x11UA18XzzAtM_Wdvl8sWBKNdXgRumN5C8lwa7
    N1AiY0bzLCrIEk5UA>
X-ME-Received: <xmr:3NT5YnBPyBpBq3Qsvl7_r23YHmE6hjCU5ZGlhAxd0v_jZBfoVEcvtoBi1Z1hCF4JOmItJoNzrmWCuIGYwRV4-v2eXCyib__7YoH8g1I_3Ye1lbYlpnrExxXI3TmRX8pyQqHAbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:3NT5Ytfey_5LNiD51dPnMJ2b4PcrYmZ8QId53two-FXE-iUwBB84Aw>
    <xmx:3NT5YuPPesPnvzGVljQub_6c4GwxnAHoFatTdppk5Oo7t_4MOOaQfQ>
    <xmx:3NT5YvkRO5LoTgtNM6AduJGFyK18mrbsuQC07mwbBOfEQZ8I3SbYOw>
    <xmx:3NT5YvEgEXsx5ONQkzZYQtmut_PGDQSTSFaTD5WPRRydtxEHDjMqfw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 01:08:43 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 09/12] riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
Date:   Mon, 15 Aug 2022 00:08:12 -0500
Message-Id: <20220815050815.22340-10-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815050815.22340-1-samuel@sholland.org>
References: <20220815050815.22340-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MangoPi MQ Pro is a tiny SBC with a layout compatible to the
Raspberry Pi Zero. It includes the Allwinner D1 SoC, 512M or 1G of DDR3,
and an RTL8723DS-based WiFi/Bluetooth module.

The board also exposes GPIO Port E via a connector on the end of the
board, which can support either a camera or an RMII Ethernet PHY. The
additional regulators supply that connector.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun20i-d1-mangopi-mq-pro.dts    | 128 ++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts

diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
index 300ada20c735..bcc304175753 100644
--- a/arch/riscv/boot/dts/allwinner/Makefile
+++ b/arch/riscv/boot/dts/allwinner/Makefile
@@ -3,4 +3,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-480p.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-720p.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-dock.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-mangopi-mq-pro.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-nezha.dtb
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
new file mode 100644
index 000000000000..61a26d3db521
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "sun20i-d1.dtsi"
+#include "sun20i-d1-common-regulators.dtsi"
+
+/ {
+	model = "MangoPi MQ Pro";
+	compatible = "widora,mangopi-mq-pro", "allwinner,sun20i-d1";
+
+	aliases {
+		ethernet0 = &rtl8723ds;
+		mmc0 = &mmc0;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_avdd2v8: avdd2v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd2v8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_vcc_3v3>;
+	};
+
+	reg_dvdd: dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "dvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&reg_vcc_3v3>;
+	};
+
+	reg_vdd_cpu: vdd-cpu {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpu";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&reg_vcc>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 17 GPIO_ACTIVE_LOW>; /* PG17 */
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpu>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
+	disable-wp;
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mmc1 {
+	bus-width = <4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	rtl8723ds: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pe-supply = <&reg_avdd2v8>;
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pb8_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart1 {
+	uart-has-rtscts;
+	pinctrl-0 = <&uart1_pg6_pins>, <&uart1_pg8_rts_cts_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723ds-bt";
+		device-wake-gpios = <&pio 6 18 GPIO_ACTIVE_HIGH>; /* PG18 */
+		enable-gpios = <&pio 6 15 GPIO_ACTIVE_HIGH>; /* PG15 */
+		host-wake-gpios = <&pio 6 14 GPIO_ACTIVE_HIGH>; /* PG14 */
+	};
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_vbus-supply = <&reg_vcc>;
+	status = "okay";
+};
-- 
2.35.1

