Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5E4493CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355624AbiASPP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:15:56 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59027 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355621AbiASPPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:15:45 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220119151544epoutp04c9e9522f9b46c79b602f0c3e88c91848~LtNuZ14gr2655226552epoutp04H
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:15:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220119151544epoutp04c9e9522f9b46c79b602f0c3e88c91848~LtNuZ14gr2655226552epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642605344;
        bh=Y9U2X/4/kMY7LCBXSZ8TBeXvQaKbS0YdDH3XB1h6Ymg=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=VlGtkoBh1V5Jxe+MMw2g8+Z+mtPejHDCrGxAnHRBptvtFpCHNNUKAsK0reWUQMlGa
         1qqYtkTch2Kbv8MBMTySIejyEEEFV6B00STdiAj2IRJylqqBZ4AXJ3RAPyQNS4Atyb
         FanK8snWaKh9wcITBp+uAsM7p1so7I5+enK86EPQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220119151543epcas5p41bb8fabf62ece39520599b6f457647e5~LtNt9jNYp1697616976epcas5p4D;
        Wed, 19 Jan 2022 15:15:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jf8NC0MKlz4x9Pw; Wed, 19 Jan
        2022 15:15:39 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.7D.46822.49A28E16; Thu, 20 Jan 2022 00:13:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220119151538epcas5p39fa4c82d53aae7c3bb3b4fd603bf0aa1~LtNpDssIz1017410174epcas5p3O;
        Wed, 19 Jan 2022 15:15:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220119151538epsmtrp29424016ea1c19a25be91ccd814d63569~LtNpAHCSp0562005620epsmtrp2X;
        Wed, 19 Jan 2022 15:15:38 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-f6-61e82a94559b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.ED.29871.A1B28E16; Thu, 20 Jan 2022 00:15:38 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220119151531epsmtip218669dc59019afb2bab9a8509c467de0~LtNiUmT6d1475114751epsmtip2O;
        Wed, 19 Jan 2022 15:15:31 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Henrik Grimler'" <henrik@grimler.se>,
        <semen.protsenko@linaro.org>, <virag.david003@gmail.com>,
        <martin.juecker@gmail.com>, <cw00.choi@samsung.com>,
        <m.szyprowski@samsung.com>, <krzysztof.kozlowski@canonical.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
In-Reply-To: <20220118185746.299832-4-henrik@grimler.se>
Subject: RE: [PATCH v4 3/3] ARM: dts: Add support for Samsung Chagall WiFi
Date:   Wed, 19 Jan 2022 20:45:29 +0530
Message-ID: <000401d80d47$6a01c690$3e0553b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDnPv58MNOYwF2DI0AP7VdeKhvTNAH1PxjfAZHgnBWuL9WvAA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmpu4UrReJBheapS2uf3nOajH/yDlW
        i7dLdjFabHz7g8li0+NrrBaXd81hs5hxfh+Txdojd9ktzvybymLRuvcIu8XzPqDY8fePGS02
        f//L6MDrMauhl81j56y77B5Hr9xj9di0qpPN4861PWwem5fUe/y/s5bdo2/LKkaPz5vkAjij
        sm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgO5WUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRn
        /Ny3haXg1VLGirZPbcwNjGcbGbsYOTkkBEwkTlx7xNLFyMUhJLCbUWLV/C4o5xOjxI0Xixgh
        nG+MEudXbwByOMBaLq32gIjvZZRYfus5M4TzklHi3qVOZpC5bAK6EjsWt7GBJEQENjBLPLzc
        DraQU8BC4sytySwgtrCAl8TtlWvB4iwCqhJfZrxnArF5BSwl/j2EiPMKCEqcnPkErJ5ZQF5i
        +9s5zBCHK0j8fLqMFcQWEXCSWPTlNjNEjbjEy6NH2EEWSwjc4JCYOaOTFaLBReL6pBssELaw
        xKvjW9ghbCmJz+/2skG8li3Rs8sYIlwjsXTeMahye4kDV+awgJQwC2hKrN+lD7GKT6L39xMm
        iE5eiY42IYhqVYnmd1ehOqUlJnZ3Qx3gITHz9jFoWO1klDhzqol9AqPCLCRfzkLy5Swk38xC
        2LyAkWUVo2RqQXFuemqxaYFRXmo5PMqT83M3MYITtpbXDsaHDz7oHWJk4mA8xCjBwawkwitV
        /yxRiDclsbIqtSg/vqg0J7X4EKMpMOgnMkuJJucDc0ZeSbyhiaWBiZmZmYmlsZmhkjjv6fQN
        iUIC6YklqdmpqQWpRTB9TBycUg1M7dNVbLcXeASzyFtn2Ls/sbu7RHLtgh6TiafqIg9mX5fc
        u3XFCXHPjze67zw+8/rqHfPrWfarzvAW1l+Mk9ZfO793q0XvhsqWZ4v2hi5SC6260j1xrT2/
        etxvVe2eXr1CRekLrE8zJ3zP6T39cI7mde6PFzNDGtarsD/L/fI6p5X3BfMk52t/rkpoTxDN
        37PbOf2l64JTT1/MZb+XkZVpmR2/XN4mu3DRti3HCp0VZ54KmqP8vnnBwlu1ZvKXJJzMz6wN
        3P47KdZe656AZbTN5Yei5z882Zca+aZN7uynZ8zJoVZLjjlU1D/huPJRO3Dm/bya953CbdVc
        Bc1pfJaL53J1TWUPdg/+tHJqTNR5JZbijERDLeai4kQAv9DQxWEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvK6U9otEg1V/DC2uf3nOajH/yDlW
        i7dLdjFabHz7g8li0+NrrBaXd81hs5hxfh+Txdojd9ktzvybymLRuvcIu8XzPqDY8fePGS02
        f//L6MDrMauhl81j56y77B5Hr9xj9di0qpPN4861PWwem5fUe/y/s5bdo2/LKkaPz5vkAjij
        uGxSUnMyy1KL9O0SuDJ+7tvCUvBqKWNF26c25gbGs42MXYwcHBICJhKXVnt0MXJxCAnsZpS4
        sO4fWxcjJ1BcWuL6xgnsELawxMp/z9khip4zSrSfvMUEkmAT0JXYsbiNDSQhIrCHWaLr9BxW
        iKqtjBKze3vA2jkFLCTO3JrMAmILC3hJ3F65lhHEZhFQlfgy4z3YJF4BS4l/DyHivAKCEidn
        PmEBOY9ZQE+ibSNYmFlAXmL72znMEBcpSPx8uowVxBYRcJJY9OU2M0SNuMTLo0fYJzAKzUIy
        aRbCpFlIJs1C0rGAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwbGpp7mDcvuqD
        3iFGJg7GQ4wSHMxKIrxS9c8ShXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2a
        WpBaBJNl4uCUamCaPDVD5d1pgXmh633iuyyjfaribRnWHCiUYjmTEclg7qWgUrt00d55Ld//
        cr+86NrrdjWOJXBBQHDIhumXuc8pqsuHGrr6uKqq7VzA9ntTXrxK/IOrq+Y/epClZs66eObt
        pOQvKTN/7pl7pXDPXKkKvcBbLzhKmVJ4lbUWRZ3Xy9l8/J6KfV7DrghT+UuaO+RFM1mv/S1w
        6X3V03LDbfmBVyH6q1a/em268ev8L2rz3k42s3Tb5mDnE5O1W9PJWCjoTMdzfYaDZqoTtuqp
        XD536aat/DqRuCpmadFjrQ3WrobaEmsCTmm6O/Au0taS0Xfl16w89/nwwV3lrKLs8uzFpfUu
        RuHNd/K7MqMtlFiKMxINtZiLihMBOck+eDwDAAA=
X-CMS-MailID: 20220119151538epcas5p39fa4c82d53aae7c3bb3b4fd603bf0aa1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118185822epcas5p1b40759c9fc7356663bcfb7d66f21d4e1
References: <20220118185746.299832-1-henrik@grimler.se>
        <CGME20220118185822epcas5p1b40759c9fc7356663bcfb7d66f21d4e1@epcas5p1.samsung.com>
        <20220118185746.299832-4-henrik@grimler.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henrik,

>-----Original Message-----
>From: Henrik Grimler [mailto:henrik@grimler.se]
>Sent: Wednesday, January 19, 2022 12:28 AM
>To: semen.protsenko@linaro.org; virag.david003@gmail.com;
>martin.juecker@gmail.com; cw00.choi@samsung.com;
>m.szyprowski@samsung.com; alim.akhtar@samsung.com;
>krzysztof.kozlowski@canonical.com; robh+dt@kernel.org;
>devicetree@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>~postmarketos/upstreaming@lists.sr.ht
>Cc: Henrik Grimler <henrik@grimler.se>
>Subject: [PATCH v4 3/3] ARM: dts: Add support for Samsung Chagall WiFi
>
>Chagall WiFi, with product name Samsung Galaxy Tab S 10.5", is based on
>Exynos 5420.  This device is one of several tablet models released in 2014
>based on Exynos 5420.
>
>The device tree added here contains support for:
>
>- UART
>- eMMC
>- SD card
>- USB
>
>CCI has been disabled in the hardware, enabling it would require (de-
>)soldering a resistor on the board.  Trying to boot with it enabled in
kernel
>makes the device hang when CCI is probed.
>Exynos5420-arndale-octa also has had CCI disabled due to issues, see commit
>25217fef3551 ("ARM: dts: disable CCI on exynos5420 based arndale-octa").
>
>Signed-off-by: Henrik Grimler <henrik@grimler.se>
>---
> arch/arm/boot/dts/Makefile                    |   1 +
> arch/arm/boot/dts/exynos5420-chagall-wifi.dts |  75 ++
> .../dts/exynos5420-galaxy-tab-common.dtsi     | 692 ++++++++++++++++++
> 3 files changed, 768 insertions(+)
> create mode 100644 arch/arm/boot/dts/exynos5420-chagall-wifi.dts
> create mode 100644 arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
>
>diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile index
>0de64f237cd8..088fcedb3212 100644
>--- a/arch/arm/boot/dts/Makefile
>+++ b/arch/arm/boot/dts/Makefile
>@@ -220,6 +220,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
> 	exynos5420-arndale-octa.dtb \
> 	exynos5420-peach-pit.dtb \
> 	exynos5420-smdk5420.dtb \
>+	exynos5420-chagall-wifi.dtb \
> 	exynos5422-odroidhc1.dtb \
> 	exynos5422-odroidxu3.dtb \
> 	exynos5422-odroidxu3-lite.dtb \
>diff --git a/arch/arm/boot/dts/exynos5420-chagall-wifi.dts
>b/arch/arm/boot/dts/exynos5420-chagall-wifi.dts
>new file mode 100644
>index 000000000000..1319344a2c74
>--- /dev/null
>+++ b/arch/arm/boot/dts/exynos5420-chagall-wifi.dts
>@@ -0,0 +1,75 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Samsung's Exynos5420 Chagall WiFi board device tree source
>+ *
>+ * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
>+ *		http://www.samsung.com
>+ * Copyright (c) 2022 Henrik Grimler
>+ */
>+
>+/dts-v1/;
>+#include "exynos5420-galaxy-tab-common.dtsi"
>+
>+/ {
>+	model = "Samsung Chagall WiFi based on Exynos5420";
>+	compatible = "samsung,chagall-wifi", "samsung,exynos5420", \
>+		     "samsung,exynos5";
>+};
>+
>+&ldo15_reg {
>+	/* Unused */
>+	regulator-name = "VDD_LDO15";
>+	regulator-min-microvolt = <3300000>;
>+	regulator-max-microvolt = <3300000>;
>+};
>+
>+&ldo17_reg {
>+	regulator-name = "VDD_IRLED_3V3";
>+	regulator-min-microvolt = <3300000>;
>+	regulator-max-microvolt = <3350000>;
>+	regulator-always-on;
>+	regulator-boot-on;
>+
>+	regulator-state-mem {
>+		regulator-off-in-suspend;
>+	};
>+};
>+
>+&ldo28_reg {
>+	/* Unused */
>+	regulator-name = "VDD_LDO28";
>+	regulator-min-microvolt = <3300000>;
>+	regulator-max-microvolt = <3300000>;
>+};
>+
>+&ldo29_reg {
>+	regulator-name = "VDD_TCON_1V8";
>+	regulator-min-microvolt = <1900000>;
>+	regulator-max-microvolt = <1900000>;
>+
>+	regulator-state-mem {
>+		regulator-off-in-suspend;
>+	};
>+};
>+
>+&ldo31_reg {
>+	regulator-name = "VDD_GRIP_1V8";
>+	regulator-min-microvolt = <1800000>;
>+	regulator-max-microvolt = <1800000>;
>+	regulator-always-on;
>+	regulator-boot-on;
>+
>+	regulator-state-mem {
>+		regulator-off-in-suspend;
>+	};
>+};
>+
>+&ldo32_reg {
>+	regulator-name = "VDD_TSP_1V8";
>+	regulator-min-microvolt = <1900000>;
>+	regulator-max-microvolt = <1900000>;
>+
>+	regulator-state-mem {
>+		regulator-off-in-suspend;
>+	};
>+};
>diff --git a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
>b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
>new file mode 100644
>index 000000000000..e4ed0fd153f4
>--- /dev/null
>+++ b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
>@@ -0,0 +1,692 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Base DT for Samsung's family of tablets based on Exynos5420.
>+ *
>+ * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
>+ *		http://www.samsung.com
>+ * Copyright (c) 2022 Henrik Grimler
>+ */
>+
>+/dts-v1/;
>+#include "exynos5420.dtsi"
>+#include "exynos5420-cpus.dtsi"
>+#include <dt-bindings/input/input.h>
>+#include <dt-bindings/gpio/gpio.h>
>+#include <dt-bindings/clock/samsung,s2mps11.h>
>+
>+/ {
>+	chassis-type = "tablet";
>+
>+	/*
>+	 * To successfully boot the mainline kernel with the stock
>+	 * bootloader (SBOOT), the tlb needs to be flushed after the
>+	 * page table pointer has been updated in
>__common_mmu_cache_on.
>+	 * The same hack is also needed to boot exynos4412-i9300 with
>+	 * stock bootloader, and probably other Samsung devices of
>+	 * similar age.  See
>+	 * https://lore.kernel.org/all/1355276466-18295-1-git-send-email-
>arve@android.com
>+	 * for more details.
>+	 */
>+
>+	chosen {
>+		stdout-path = "serial2:115200n8";
>+	};
>+
>+	memory@20000000 {
>+		device_type = "memory";
>+		reg = <0x20000000 0xc0000000>;
>+	};
>+
>+	firmware@2073000 {
>+		compatible = "samsung,secure-firmware";
>+		reg = <0x02073000 0x1000>;
>+	};
>+
>+	fixed-rate-clocks {
>+		oscclk {
>+			compatible = "samsung,exynos5420-oscclk";
>+			clock-frequency = <24000000>;
>+		};
>+	};
>+
>+	gpio-keys {
>+		compatible = "gpio-keys";
>+		pinctrl-names = "default";
>+
>+		key-power {
>+			debounce-interval = <10>;
>+			gpios = <&gpx2 2 GPIO_ACTIVE_LOW>;
>+			label = "Power";
>+			linux,code = <KEY_POWER>;
>+			wakeup-source;
>+		};
>+
>+		key-home {
>+			debounce-interval = <10>;
>+			gpios = <&gpx0 5 GPIO_ACTIVE_LOW>;
>+			label = "Home";
>+			linux,code = <KEY_HOME>;
>+			wakeup-source;
>+		};
>+
>+		key-volume-up {
>+			debounce-interval = <10>;
>+			gpios = <&gpx0 2 GPIO_ACTIVE_LOW>;
>+			label = "Volume Up";
>+			linux,code = <KEY_VOLUMEUP>;
>+		};
>+
>+		key-volume-down {
>+			debounce-interval = <10>;
>+			gpios = <&gpx0 3 GPIO_ACTIVE_LOW>;
>+			label = "Volume Down";
>+			linux,code = <KEY_VOLUMEDOWN>;
>+		};
>+	};
>+};
>+
>+&cci {
>+	/* CCI is disabled in hardware */
>+	status = "disabled";
>+};
>+
>+&cpu0 {
>+	cpu-supply = <&buck2_reg>;
>+};
>+
>+&cpu4 {
>+	cpu-supply = <&buck6_reg>;
>+};
>+
>+&gpu {
>+	status = "okay";
>+	mali-supply = <&buck4_reg>;
>+};
>+
>+&hsi2c_7 {
>+	status = "okay";
>+
>+	pmic@66 {
>+		compatible = "samsung,s2mps11-pmic";
>+		reg = <0x66>;
>+
>+		interrupt-parent = <&gpx3>;
>+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>+		pinctrl-names = "default";
>+		pinctrl-0 = <&s2mps11_irq>;
>+
>+		s2mps11_osc: clocks {
>+			compatible = "samsung,s2mps11-clk";
>+			#clock-cells = <1>;
>+			clock-output-names = "s2mps11_ap", "s2mps11_cp",
>+					     "s2mps11_bt";
>+		};
>+
>+		regulators {
>+			buck1_reg: BUCK1 {
>+				regulator-name = "VDD_MIF_1V1";
>+				regulator-min-microvolt = <700000>;
>+				regulator-max-microvolt = <1300000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			buck2_reg: BUCK2 {
>+				regulator-name = "VDD_ARM_1V0";
>+				regulator-min-microvolt = <800000>;
>+				regulator-max-microvolt = <1500000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			buck3_reg: BUCK3 {
>+				regulator-name = "VDD_INT_1V0";
>+				regulator-min-microvolt = <800000>;
>+				regulator-max-microvolt = <1400000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			buck4_reg: BUCK4 {
>+				regulator-name = "VDD_G3D_1V0";
>+				regulator-min-microvolt = <700000>;
>+				regulator-max-microvolt = <1400000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			buck5_reg: BUCK5 {
>+				regulator-name = "VDD_MEM_1V2";
>+				regulator-min-microvolt = <1200000>;
>+				regulator-max-microvolt = <1200000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+
>+			};
>+
>+			buck6_reg: BUCK6 {
>+				regulator-name = "VDD_KFC_1V0";
>+				regulator-min-microvolt = <800000>;
>+				regulator-max-microvolt = <1500000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			buck7_reg: BUCK7 {
>+				regulator-name = "VIN_LLDO_1V4";
>+				regulator-min-microvolt = <1200000>;
>+				regulator-max-microvolt = <1500000>;
>+				regulator-always-on;
>+			};
>+
>+			buck8_reg: BUCK8 {
>+				regulator-name = "VIN_MLDO_2V0";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <2100000>;
>+				regulator-always-on;
>+			};
>+
>+			buck9_reg: BUCK9 {
>+				regulator-name = "VIN_HLDO_3V5";
>+				regulator-min-microvolt = <3000000>;
>+				regulator-max-microvolt = <3500000>;
>+				regulator-always-on;
>+			};
>+
>+			buck10_reg: BUCK10 {
>+				regulator-name = "VDD_CAM_ISP_1V0";
>+				regulator-min-microvolt = <750000>;
>+				regulator-max-microvolt = <3550000>;
>+			};
>+
>+			ldo1_reg: LDO1 {
>+				regulator-name = "VDD_ALIVE_1.0V";
>+				regulator-min-microvolt = <1000000>;
>+				regulator-max-microvolt = <1000000>;
>+				regulator-always-on;
>+			};
>+
>+			ldo2_reg: LDO2 {
>+				regulator-name = "VDD_APIO_1V8";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-on-in-suspend;
>+				};
>+			};
>+
>+			ldo3_reg: LDO3 {
>+				regulator-name = "VDD_APIO_MMC01_1V8";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+				regulator-always-on;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo4_reg: LDO4 {
>+				regulator-name = "VDD_ADC_1V8";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-on-in-suspend;
>+				};
>+			};
>+
>+			ldo5_reg: LDO5 {
>+				/* Unused */
>+				regulator-name = "VDD_LDO5";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+			};
>+
>+			ldo6_reg: LDO6 {
>+				regulator-name = "VDD_MIPI_1V0";
>+				regulator-min-microvolt = <1000000>;
>+				regulator-max-microvolt = <1000000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo7_reg: LDO7 {
>+				regulator-name =
>"VDD_MIPI_PLL_ABB1_18V";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo8_reg: LDO8 {
>+				/* Unused */
>+				regulator-name = "VDD_LDO8";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+			};
>+
>+			ldo9_reg: LDO9 {
>+				regulator-name = "VDD_UOTG_3V0";
>+				regulator-min-microvolt = <3000000>;
>+				regulator-max-microvolt = <3000000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-on-in-suspend;
>+				};
>+			};
>+
>+			ldo10_reg: LDO10 {
>+				regulator-name = "VDDQ_PRE_1V8";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-on-in-suspend;
>+				};
>+			};
>+
>+			ldo11_reg: LDO11 {
>+				regulator-name = "VDD_HSIC_1V0";
>+				regulator-min-microvolt = <1000000>;
>+				regulator-max-microvolt = <1000000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-on-in-suspend;
>+				};
>+			};
>+
>+			ldo12_reg: LDO12 {
>+				regulator-name = "VDD_HSIC_1V8";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-on-in-suspend;
>+				};
>+			};
>+
>+			ldo13_reg: LDO13 {
>+				regulator-name = "VDD_APIO_MMC2_2V8";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <2800000>;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo14_reg: LDO14 {
>+				regulator-name = "VDD_MOTOR_3V0";
>+				regulator-min-microvolt = <3000000>;
>+				regulator-max-microvolt = <3000000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo15_reg: LDO15 {
>+				regulator-name = "VDD_LDO15";
>+				/*
>+				 * LDO15 varies between devices and is
>+				 * specified in the device dts
>+				 */
>+			};
>+
>+			ldo16_reg: LDO16 {
>+				regulator-name = "VDD_AP_2V8";
>+				regulator-min-microvolt = <2800000>;
>+				regulator-max-microvolt = <2800000>;
>+				regulator-always-on;
>+				regulator-boot-on;
>+
>+				regulator-state-mem {
>+					regulator-on-in-suspend;
>+				};
>+			};
>+
>+			ldo17_reg: LDO17 {
>+				regulator-name = "VDD_LDO17";
>+				/*
>+				 * LDO17 varies between devices and is
>+				 * specified in the device dts
>+				 */
>+			};
>+
>+			ldo18_reg: LDO18 {
>+				/* Unused */
>+				regulator-name = "VDD_LDO18";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+			};
>+
>+
Nit: remove extra line here
Not sure if you need to re-spin the patch or may be Krzysztof will fix this
will applying
Rest looks fine.
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


>+			ldo19_reg: LDO19 {
>+				regulator-name = "VDD_VTF_2V8";
>+				regulator-min-microvolt = <2800000>;
>+				regulator-max-microvolt = <2800000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo20_reg: LDO20 {
>+				regulator-name = "VDD_CAM1_CAM_1V8";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo21_reg: LDO21 {
>+				regulator-name = "VDD_CAM_IO_1V8";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo22_reg: LDO22 {
>+				regulator-name =
>"VDD_CAM0_S_CORE_1V1";
>+				regulator-min-microvolt = <1050000>;
>+				regulator-max-microvolt = <1200000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo23_reg: LDO23 {
>+				regulator-name = "VDD_MIFS_1V1";
>+				regulator-min-microvolt = <800000>;
>+				regulator-max-microvolt = <1100000>;
>+				regulator-always-on;
>+
>+				regulator-state-mem {
>+					regulator-on-in-suspend;
>+				};
>+			};
>+
>+			ldo24_reg: LDO24 {
>+				regulator-name = "VDD_TSP_3V3";
>+				regulator-min-microvolt = <3300000>;
>+				regulator-max-microvolt = <3300000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo25_reg: LDO25 {
>+				/* Unused */
>+				regulator-name = "VDD_LDO25";
>+				regulator-min-microvolt = <800000>;
>+				regulator-max-microvolt = <3950000>;
>+			};
>+
>+			ldo26_reg: LDO26 {
>+				regulator-name = "VDD_CAM0_AF_2V8";
>+				regulator-min-microvolt = <2800000>;
>+				regulator-max-microvolt = <2800000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo27_reg: LDO27 {
>+				regulator-name = "VDD_G3DS_1V0";
>+				regulator-min-microvolt = <800000>;
>+				regulator-max-microvolt = <1000000>;
>+				regulator-always-on;
>+
>+				regulator-state-mem {
>+					regulator-on-in-suspend;
>+				};
>+			};
>+
>+			ldo28_reg: LDO28 {
>+				regulator-name = "VDD_LDO28";
>+				/*
>+				 * LDO28 varies between devices and is
>+				 * specified in the device dts
>+				 */
>+			};
>+
>+			ldo29_reg: LDO29 {
>+				regulator-name = "VDD_LDO29";
>+				/*
>+				 * LDO29 varies between devices and is
>+				 * specified in the device dts
>+				 */
>+			};
>+
>+			ldo30_reg: LDO30 {
>+				regulator-name = "VDD_TOUCH_1V8";
>+				regulator-min-microvolt = <1900000>;
>+				regulator-max-microvolt = <1900000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo31_reg: LDO31 {
>+				regulator-name = "VDD_LDO31";
>+				/*
>+				 * LDO31 varies between devices and is
>+				 * specified in the device dts
>+				 */
>+			};
>+
>+			ldo32_reg: LDO32 {
>+				regulator-name = "VDD_LDO32";
>+				/*
>+				 * LDO32 varies between devices and is
>+				 * specified in the device dts
>+				 */
>+			};
>+
>+			ldo33_reg: LDO33 {
>+				regulator-name = "VDD_MHL_1V8";
>+				regulator-min-microvolt = <1800000>;
>+				regulator-max-microvolt = <1800000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo34_reg: LDO34 {
>+				regulator-name = "VDD_MHL_3V3";
>+				regulator-min-microvolt = <3300000>;
>+				regulator-max-microvolt = <3300000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo35_reg: LDO35 {
>+				regulator-name = "VDD_SIL_1V2";
>+				regulator-min-microvolt = <1200000>;
>+				regulator-max-microvolt = <1200000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+
>+			ldo36_reg: LDO36 {
>+				/* Unused */
>+				regulator-name = "VDD_LDO36";
>+				regulator-min-microvolt = <800000>;
>+				regulator-max-microvolt = <3950000>;
>+			};
>+
>+			ldo37_reg: LDO37 {
>+				/* Unused */
>+				regulator-name = "VDD_LDO37";
>+				regulator-min-microvolt = <800000>;
>+				regulator-max-microvolt = <3950000>;
>+			};
>+
>+			ldo38_reg: LDO38 {
>+				regulator-name = "VDD_KEY_LED_3V3";
>+				regulator-min-microvolt = <2500000>;
>+				regulator-max-microvolt = <3300000>;
>+
>+				regulator-state-mem {
>+					regulator-off-in-suspend;
>+				};
>+			};
>+		};
>+	};
>+};
>+
>+&mixer {
>+	status = "okay";
>+};
>+
>+/* Internal storage */
>+&mmc_0 {
>+	status = "okay";
>+	bus-width = <8>;
>+	cap-mmc-highspeed;
>+	card-detect-delay = <200>;
>+	mmc-hs200-1_8v;
>+	non-removable;
>+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
>+	pinctrl-names = "default";
>+	samsung,dw-mshc-ciu-div = <3>;
>+	samsung,dw-mshc-ddr-timing = <0 2>;
>+	samsung,dw-mshc-sdr-timing = <0 4>;
>+	vqmmc-supply = <&ldo3_reg>;
>+};
>+
>+/* External sdcard */
>+&mmc_2 {
>+	status = "okay";
>+	bus-width = <4>;
>+	cap-sd-highspeed;
>+	card-detect-delay = <200>;
>+	cd-gpios = <&gpx2 4 GPIO_ACTIVE_LOW>;
>+	pinctrl-0 = <&sd2_clk &sd2_cmd &mmc2_cd &sd2_bus1 &sd2_bus4>;
>+	pinctrl-names = "default";
>+	samsung,dw-mshc-ciu-div = <3>;
>+	samsung,dw-mshc-ddr-timing = <0 2>;
>+	samsung,dw-mshc-sdr-timing = <0 4>;
>+	sd-uhs-sdr50;
>+	vmmc-supply = <&ldo19_reg>;
>+	vqmmc-supply = <&ldo13_reg>;
>+};
>+
>+&pinctrl_0 {
>+	mmc2_cd: mmc2-cd-pins {
>+		samsung,pins = "gpx2-4";
>+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>+	};
>+
>+	s2mps11_irq: s2mps11-irq-pins {
>+		samsung,pins = "gpx3-0";
>+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
>+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
>+	};
>+};
>+
>+&rtc {
>+	status = "okay";
>+	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
>+	clock-names = "rtc", "rtc_src";
>+};
>+
>+&tmu_cpu0 {
>+	vtmu-supply = <&ldo10_reg>;
>+};
>+
>+&tmu_cpu1 {
>+	vtmu-supply = <&ldo10_reg>;
>+};
>+
>+&tmu_cpu2 {
>+	vtmu-supply = <&ldo10_reg>;
>+};
>+
>+&tmu_cpu3 {
>+	vtmu-supply = <&ldo10_reg>;
>+};
>+
>+&tmu_gpu {
>+	vtmu-supply = <&ldo10_reg>;
>+};
>+
>+&usbdrd_dwc3_0 {
>+	dr_mode = "peripheral";
>+};
>+
>+&usbdrd_dwc3_1 {
>+	dr_mode = "peripheral";
>+};
>+
>+&usbdrd3_0 {
>+	vdd33-supply = <&ldo9_reg>;
>+	vdd10-supply = <&ldo11_reg>;
>+};
>+
>+&usbdrd3_1 {
>+	vdd33-supply = <&ldo9_reg>;
>+	vdd10-supply = <&ldo11_reg>;
>+};
>--
>2.34.1


