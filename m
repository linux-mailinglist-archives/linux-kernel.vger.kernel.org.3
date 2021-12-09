Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CE346E88F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbhLIMkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:40:24 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:51435 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLIMkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639053409; x=1670589409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NPSr8y9FiBwwCRhocTr1U6r53NqUFSQijAlVpjpNkZ0=;
  b=Gp5x5Oj0RVFo4Cvx9NhAg2LdZ8oxbrAYwcn+m4tvq4Nw060cDVF9D+Gs
   RoPDBrxnKYoJV+qw53tupijVKN9I3Bs0Cd5VyXBOhfT7eUrc/kCQSzDL0
   2pHZfaiEgzE1yWqxbApk/jrusPdM6kdVi3Pag9swWDxQ/zuT8P4Xmlzwp
   NMvLy0zNcVfj8G0TwEqsSTmGqF6QOfNn4qZ2qEUXZBRCbCyekK9hiFW/n
   84TRV359Z/r4ZD6PGOlWeteC6lTC/gYTrhLoDZNqv39B4M58slgaNtook
   Jj8IwRFyQOcIl+MjkHVdvx5hrKKysOTnUD60nHi7S600fsiWIdWSfyG8O
   w==;
IronPort-SDR: loKFcqvZlr1yj3YZrmUxr4w86zrkb6HtAD0/tfP7J/1QR0Un++csPCPkVCDfWzVgkgjUuQIJ+u
 2eQ3A5EOg72fzk9SnTUUy1xC0wj41sM1nwBvysIDDF6cUybyn4ZBCSQ9W0qB8wWRE9MjFrzjMQ
 GZpGBonf+dJnc5ZM2e8kwybyc47YPJajG5cOnMkklpZYpFUYG+HeFaCR6sHYQf3De1nB+wrRSG
 GoscwhcQU4esydViRinslpIeen0JUvR1VNS5+X4qEsyUA+HB7eswz20+BksV6b7Yk8ajucExjb
 rt959Bt0jXeioMi42FTk04x6
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="154857927"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 05:36:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 05:36:49 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 05:36:47 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: sama7g5ek: Add QSPI0 node
Date:   Thu, 9 Dec 2021 14:36:43 +0200
Message-ID: <20211209123643.341892-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209123643.341892-1-tudor.ambarus@microchip.com>
References: <20211209123643.341892-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QSPI0 comunicates with a MX66LM1G45G SPI NOR flash.
Enable the controller and describe the flash.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 73 ++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 0e1975c6812e..ccf9e224da78 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -13,6 +13,7 @@
 #include "sama7g5.dtsi"
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/at91.h>
 
 / {
 	model = "Microchip SAMA7G5-EK";
@@ -134,6 +135,59 @@ &cpu0 {
 	cpu-supply = <&vddcpu>;
 };
 
+&qspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		m25p,fast-read;
+
+		at91bootstrap@0 {
+			label = "ospi: at91bootstrap";
+			reg = <0x0 0x40000>;
+		};
+
+		bootloader@40000 {
+			label = "ospi: bootloader";
+			reg = <0x40000 0xc0000>;
+		};
+
+		bootloaderenvred@100000 {
+			label = "ospi: bootloader env redundant";
+			reg = <0x100000 0x40000>;
+		};
+
+		bootloaderenv@140000 {
+			label = "ospi: bootloader env";
+			reg = <0x140000 0x40000>;
+		};
+
+		dtb@180000 {
+			label = "ospi: device tree";
+			reg = <0x180000 0x80000>;
+		};
+
+		kernel@200000 {
+			label = "ospi: kernel";
+			reg = <0x200000 0x600000>;
+		};
+
+		rootfs@800000 {
+			label = "ospi: rootfs";
+			reg = <0x800000 0x7800000>;
+		};
+
+	};
+};
+
 &dma0 {
 	status = "okay";
 };
@@ -555,6 +609,25 @@ pinctrl_mikrobus1_spi: mikrobus1_spi {
 		bias-disable;
 	};
 
+	pinctrl_qspi: qspi {
+		pinmux = <PIN_PB12__QSPI0_IO0>,
+			 <PIN_PB11__QSPI0_IO1>,
+			 <PIN_PB10__QSPI0_IO2>,
+			 <PIN_PB9__QSPI0_IO3>,
+			 <PIN_PB16__QSPI0_IO4>,
+			 <PIN_PB17__QSPI0_IO5>,
+			 <PIN_PB18__QSPI0_IO6>,
+			 <PIN_PB19__QSPI0_IO7>,
+			 <PIN_PB13__QSPI0_CS>,
+			 <PIN_PB14__QSPI0_SCK>,
+			 <PIN_PB15__QSPI0_SCKN>,
+			 <PIN_PB20__QSPI0_DQS>,
+			 <PIN_PB21__QSPI0_INT>;
+		bias-disable;
+		slew-rate = <0>;
+		atmel,drive-strength = <ATMEL_PIO_DRVSTR_HI>;
+	};
+
 	pinctrl_sdmmc0_default: sdmmc0_default {
 		cmd_data {
 			pinmux = <PIN_PA1__SDMMC0_CMD>,
-- 
2.25.1

