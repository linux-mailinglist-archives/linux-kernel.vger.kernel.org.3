Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5F5928FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiHOFJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbiHOFJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:09:04 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6076D15FD7;
        Sun, 14 Aug 2022 22:08:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 75A8732007CF;
        Mon, 15 Aug 2022 01:08:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 01:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660540126; x=1660626526; bh=Mp
        2QT1wJDeGU551ZuBsU28NUPyZSf6ZYCWPSZNp282o=; b=uEcpch5MyKTknvh30/
        yO3rchgzbTdkSZiRT8QOvfHYiBHqUJSiD0i85VwTJYoC7/2Od3MO1GcIgpzCbCmc
        +aLnoBcnKB4BmmG6GCFGfgoy0ZrGU///nIh/i0xDKddcAgSNqtZd4toVPY8rGAYu
        Zq2ehLjdkoFQuK6OfxxcFpF+BBJsK/GEiNXQdEygRhOtbw2/M1G3lbYexk4y5FWP
        EP8t/eSDV2sDfSguVkxks6WpRIXz0Ci5OPW3IW6SAQC3SxzzJ2ZSzthj8cqnsuC0
        nw/CD2t+ivznlohFK/D2w32DWOKTKhCnjPkR7QSpXl1kUBEAeA8GPOpRiULyY+cV
        BCqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660540126; x=1660626526; bh=Mp2QT1wJDeGU5
        51ZuBsU28NUPyZSf6ZYCWPSZNp282o=; b=B84LOjpT9frYbqDLt+ScHv8PASpWZ
        ecChgDtNOKGpL3G0cloJSgUxkIcVPW89IPlrBcJAHFUwE6llDyZOlQQIYYAMAA1t
        QYp7BkZN7oIrwGAeCTlcoGVFbNlhrUmY/gSbZdZOxoZ1w0WuMqi8Xcxs2cvcbA5Y
        qN+FFMdI4zfQZMT5xSk5IkxWEztPbwppCGhSmpT6HVEN53ODuhGTzIRJoltctmNB
        jpRe5aPnxYgN8OzEgdReJL5oFOf2IoZjzXP5h6BhD6J5MesZkgaCEooESQ2PxttX
        +70XYOg1jIVaspS96TPxydFjPYsKNyZ0aIhOiAY3mDYkwqy5Jk71QPzZQ==
X-ME-Sender: <xms:3tT5Yg0zE2Hd2KrDzDWlTdaVuJqKQvupp5DZ3i4d0XVhmxVbl__cnw>
    <xme:3tT5YrGG_DIiDdXd1M57VkVwqa79AiVbcvF-TDndjyhw3xUzZymR93pw6n7C9tJow
    8vwGn5KQyzgMlhOiQ>
X-ME-Received: <xmr:3tT5Yo63FDcS_YGKXARPErMZbUjYdinJQ5ahwMfMCTj-Wl9HKgD-b1P6JuCjwIEZp2qu2WM1MxZVItrdFDsci_7aAX0ebRlJHA1IalwaoBfMhfp_9cCj9wQUAaaOj7M575MXIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:3tT5Yp0nh7CWJNcLhV7XXxN6lflZ8Gw9SKkV_1OnfhViQgMUDzcALQ>
    <xmx:3tT5YjGwIn4gFcytlwbYwUd_8iocDvIKMSJeS4F28-jLSYnP6fziKA>
    <xmx:3tT5Yi-nI0uzNh819ORYbKJA8r8y1d1ZqVRuO5LyT4-3m8TYHIrp8Q>
    <xmx:3tT5Yr-wyRJRNiYgldXvZoN9OpvtLZgDe4lJfm3RpwGwwy5t7xSawQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 01:08:46 -0400 (EDT)
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
Subject: [PATCH 10/12] riscv: dts: allwinner: Add Dongshan Nezha STU devicetree
Date:   Mon, 15 Aug 2022 00:08:13 -0500
Message-Id: <20220815050815.22340-11-samuel@sholland.org>
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

The 100ask Dongshan Nezha STU is a system-on-module that can be used
standalone or with a carrier board. The SoM provides gigabit Ethernet,
HDMI, a USB peripheral port, and WiFi/Bluetooth via an RTL8723DS chip.

The "DIY" carrier board exposes almost every pin from the D1 SoC to 0.1"
headers, but contains no digital circuitry, so it does not have its own
devicetree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/boot/dts/allwinner/Makefile        |   1 +
 .../sun20i-d1-dongshan-nezha-stu.dts          | 114 ++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts

diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
index bcc304175753..530ef8adb8b0 100644
--- a/arch/riscv/boot/dts/allwinner/Makefile
+++ b/arch/riscv/boot/dts/allwinner/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-dongshan-nezha-stu.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-480p.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-720p.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-dock.dtb
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts
new file mode 100644
index 000000000000..c3d06dfaa7c3
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+#include "sun20i-d1.dtsi"
+#include "sun20i-d1-common-regulators.dtsi"
+
+/ {
+	model = "Dongshan Nezha STU";
+	compatible = "100ask,dongshan-nezha-stu", "allwinner,sun20i-d1";
+
+	aliases {
+		ethernet0 = &emac;
+		mmc0 = &mmc0;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 2 1 GPIO_ACTIVE_HIGH>; /* PC1 */
+		};
+	};
+
+	reg_usbvbus: usbvbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbvbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
+		enable-active-high;
+		vin-supply = <&reg_vcc>;
+	};
+
+	/*
+	 * This regulator is PWM-controlled, but the PWM controller is not
+	 * yet supported, so fix the regulator to its default voltage.
+	 */
+	reg_vdd_cpu: vdd-cpu {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpu";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&reg_vcc>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpu>;
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-0 = <&rgmii_pe_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii-id";
+	phy-supply = <&reg_vcc_3v3>;
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&mmc0 {
+	broken-cd;
+	bus-width = <4>;
+	disable-wp;
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pb8_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 3 21 GPIO_ACTIVE_HIGH>; /* PD21 */
+	usb0_vbus_det-gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
+	usb0_vbus-supply = <&reg_usbvbus>;
+	status = "okay";
+};
-- 
2.35.1

