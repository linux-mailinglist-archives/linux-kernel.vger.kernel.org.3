Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1CE50E21A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbiDYNqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242236AbiDYNqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:46:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A457A496AC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:43:09 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g9so13448611pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DmA69wy+os8Hg80rILXTGEh+ZOJNCDfLDcCt0b5+p1w=;
        b=A3dgZxk6LvpH6SgaqTEtJlZ6k7P9KEh1Zsm46HjVAW6uX+dnHPKmUnJmlvbGHPK2VL
         UravFU5ztBa4vJ5UOXc0l4PGH1ZXoh1GUPmmQdkmtZAfseUMOqbVKF+u+BSpDQqwkmC9
         bYq9OuANb2IjhlNGswBXhDEnxvs/1zDpop4bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DmA69wy+os8Hg80rILXTGEh+ZOJNCDfLDcCt0b5+p1w=;
        b=2w14C2ipCRpfluiMDI7TbEUMzsep7Vnv6dZrl9ZhWAhzPYeBqdxj+VGsm7086cheO2
         pU/gpZ7Tizy8zTXZpvHOPI8557/54mibu8+u+Jyp0y3DwcmrNsZWXFYW+ODgshDZj2x1
         B6LMEU+RSiwLLqvD3xbyQh6N07N1ZfPQ/X8Z485DasB86Jf4dFemOeCWfNRS+khcVeAX
         1i0cIjtI9Lq1tNX4hGwEJwiT7W0TqdiftjQ/rRu3yiOE2foCKlcqCQHoztJj2tbtoIws
         +9r+aNGPMq9Ap6UWP7Bu8YhRj3MolCisAHlS0pCa1fkpbIYYVgmBpH4bAR/OQKwknzsP
         59Mw==
X-Gm-Message-State: AOAM533G1DAI2gTd82Z7z7exUyzBf0yhzq0jlApX2JT2WuVCR/EZOXft
        +ErNfFVlUc6hlDxxRF6x9Wy6Hw==
X-Google-Smtp-Source: ABdhPJwu2usPT+J7QDQaQyOF7WJsbtg197teEbqT6xJHKdpgL3T3CJ8lcy8fotxs4x862/bLH+ISoA==
X-Received: by 2002:a05:6a00:1a49:b0:505:7ab3:e5c7 with SMTP id h9-20020a056a001a4900b005057ab3e5c7mr19050422pfv.62.1650894187656;
        Mon, 25 Apr 2022 06:43:07 -0700 (PDT)
Received: from localhost.localdomain ([183.83.137.38])
        by smtp.gmail.com with ESMTPSA id c9-20020a63a409000000b0039912d50806sm9810089pgf.87.2022.04.25.06.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:43:07 -0700 (PDT)
From:   Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v3 3/3] arm64: dts: imx8mp: Add Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit.
Date:   Mon, 25 Apr 2022 19:12:24 +0530
Message-Id: <20220425134224.368908-3-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425134224.368908-1-abbaraju.manojsai@amarulasolutions.com>
References: <20220418144907.327511-2-abbaraju.manojsai@amarulasolutions.com>
 <20220425134224.368908-1-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Genaral features:
- LCD 7" C.Touch
- microSD slot
- Ethernet 1Gb
- Wifi/BT
- 2x LVDS Full HD interfaces
- 3x USB 2.0
- 1x USB 3.0
- HDMI Out
- Plus PCIe
- MIPI CSI
- 2x CAN
- Audio Out

i.Core MX8M Plus is an EDIMM SoM based on NXP i.MX8M Plus from Engicam.

i.Core MX8M Plus needs to mount on top of this Evaluation board for
creating complete i.Core MX8M Plus EDIMM2.2 Starter Kit.

Add support for it.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
  - shorten the patch subject naming .
  - updated the dts addition to Makefile as per alphabetical order .
  - removed the always-on  property of usb1 Node .
  - arranged the nodes as per alphabetical order .
  - updated the pincontrol nodes as per alphabetical order .

Changes for v2:
  - corrected the naming convetion of nodes as per existing
    sources and bindings.
  - added the iomux to the end as per nxp convention.
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx8mp-icore-mx8mp-edimm2.2.dts | 175 ++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 851e6faf8c05..05e62541e1ed 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dahlia.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
new file mode 100644
index 000000000000..70a701a624a6
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 NXP
+ * Copyright (c) 2019 Engicam srl
+ * Copyright (c) 2020 Amarula Solutons(India)
+ */
+
+/dts-v1/;
+
+#include "imx8mp.dtsi"
+#include "imx8mp-icore-mx8mp.dtsi"
+#include <dt-bindings/usb/pd.h>
+
+/ {
+	model = "Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit";
+	compatible = "engicam,icore-mx8mp-edimm2.2", "engicam,icore-mx8mp",
+		     "fsl,imx8mp";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	reg_usb1_vbus: regulator-usb1 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb1>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb1_host_vbus";
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VSD_3V3";
+	};
+};
+
+/* Ethernet */
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@7 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			micrel,led-mode = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+/* console */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* SDCARD */
+&usdhc2 {
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	pinctrl-names = "default" ;
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x3
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x3
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x91
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x91
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x91
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x91
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x91
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x1f
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x1f
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x1f
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x1f
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x1f
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
+			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07				0x19
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x49
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x49
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140
+			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140
+			MX8MP_IOMUXC_SD1_STROBE__UART3_DCE_CTS	0x140
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
+		>;
+	};
+
+	pinctrl_reg_usb1: regusb1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x19
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
+		>;
+	};
+};
-- 
2.25.1

