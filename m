Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BB5498265
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiAXOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:30:48 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:42238 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239911AbiAXOaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:30:03 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220124143001epoutp03396676bcfe9b8ff848edc36f9175cd6b~NO0PPu_Np1227112271epoutp03t
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:30:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220124143001epoutp03396676bcfe9b8ff848edc36f9175cd6b~NO0PPu_Np1227112271epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034601;
        bh=4t0dpFbAd8+PfzI86eFoncjg1YGIBLxaBaFZx8viB0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUyJFm2QzDMISbjVy8AKxS6DUi1mDI2K3J7ZIvu48V1ozNc22e91M3Old6U1BeMJX
         z5DGVEcSb/f952fCJkypUDXEo0UzpCiggs4CbmXsR+L329k/YwV+loMjfeaYR/BkS2
         U08DI7R5TVWGtrRP+6Us/1Sv006mcizql03dziBw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220124143000epcas5p29a3a1e0b1d4927e9dcbb4168e49a9b8a~NO0OkGCJE0974109741epcas5p2L;
        Mon, 24 Jan 2022 14:30:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JjC795rYPz4x9Pt; Mon, 24 Jan
        2022 14:29:57 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.6D.46822.886BEE16; Mon, 24 Jan 2022 23:24:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220124142957epcas5p27ab08d4eb02fe53a03e2b36ab1d913f8~NO0LMvNJj0974109741epcas5p2F;
        Mon, 24 Jan 2022 14:29:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220124142957epsmtrp2782d2168105d274197cf49c13f963ab4~NO0LLs8vm1656816568epsmtrp2S;
        Mon, 24 Jan 2022 14:29:57 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-98-61eeb688f922
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.BB.08738.4E7BEE16; Mon, 24 Jan 2022 23:29:57 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142952epsmtip1b8f3324a4fcdb52fe4cd83b4f467a6f3~NO0HDYPDp1678916789epsmtip19;
        Mon, 24 Jan 2022 14:29:52 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Arjun K V <arjun.kv@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>
Subject: [PATCH v5 14/16] arm64: dts: fsd: Add initial device tree support
Date:   Mon, 24 Jan 2022 19:46:42 +0530
Message-Id: <20220124141644.71052-15-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfVBUVRjGOXfv3v1oFu+sNJzWQFrGGCA+Fna3g8OaTgzdoYahhJyRHLqx
        t10G2N12lwymAoESFEJAhyBZFEoLMFhYCCEEgbCRBC2ENEMJyVRYCKTiy22Xq/Xf8z7n97xn
        znvO4XPEXYSEn6IzM0YdnSYlhHh7v79fUEG7nQ5tHHka9c6dx9EtSzuBTn/ViaP1skEe6mtt
        46G5U0UA1QwMc5F19h8MHV07jaGWqTEu+rNogosm7+1BP3UeJ9CnI+cwdHF8kUC1bQ94qOpy
        Bxd91D3AQ/0zB7nI0lEN0MMxK46mxtcI9MvM19ydnlSjpRFQqytlgKrKKSaolvpCgrox9i1B
        tX6eTY1+n8ulPrHVA+phbjWPWmzxjhPuTY3UMrSaMfowumS9OkWnUUlf3p30YpJCGSoLkkWg
        56U+OjqdUUmjXokLik5Jc55W6vMunZbhtOJok0kasiPSqM8wMz5avcmskjIGdZpBbgg20emm
        DJ0mWMeYt8tCQ8MUTvDNVO3yDz08Q00PeG/WMY/lgIVycAgI+JCUw+mGPPwQEPLFZBeA14ea
        eGyxAODJH8cwtlgEsKuth3gcmb02w3VpMdkJ4HpVAgvlY3Dm2OUNiCAD4a8VNsylPcho+POB
        go1OHHIBhyWD6zzXwmYyBuY5juIujZPbYEnP/Y2uIlIF7bU1PHa3rbChuZfj0gKnbzn510Yj
        SN7mw+nSO06I7yyiYNPcXpbfDO9dsD3KSuCivZtgkVRY1BnO2u/DLyyDOKtfgL2jx3EXwiH9
        YVNniMvmkO6wePU2xiZFsOBjMUtvg3n2q4+SW2Dp4cNcVlNwemWcy47hCIC1TTfBEeBV9X/X
        EwDUg6cYgyldw5gUhjAds/+/m0rWp7eAjVccENMBJm/NB/cBjA/6AORzpB6iLLWdFovUdGYW
        Y9QnGTPSGFMfUDgnVsqRPJmsd34DnTlJJo8IlSuVSnlEuFIm9RQNaZppMamhzUwqwxgY4+Mc
        xhdIcjB5ZdmF2u2V6Hqqv4ewYlfrQo2bWmBTmKdDhM1Xqq8RmflDpoubvDiFez48NphdPhno
        luybEuA7MPPgTO6m8q2jS298GRhP/Xb3nbLcwu7VHdaqGFLjvlLn/laL4JLNL/E10HAKc/hy
        p4avFltXP0hUeT0bH1tReTOaFOnudJfujKKa/MKvRE5oG7Z4GRZ+ryt5Ylh18Ixj2SF5bsR7
        xHTDYPtG+UxX4d3Y+bcFyy/Jiy0TCfFhpWLvz+Lm3U7kh2TGrJbEnPM9e0C29N3rU3MJQSX9
        wsTsV+uXsjrmSM8VjuTs4N/WPxxr85cUsft2udXhAWXWiH3VSittP981qr2/e78UN2lpWQDH
        aKL/BdkT4ehOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnO7T7e8SDeYsZrI48P4gi8WDedvY
        LJav3MVi8XfSMXaLQ5u3slu8X9bDaDH/yDlWi41vfzBZTPmznMli0+NrrBYfe+6xWjx8FW5x
        edccNosZ5/cxWZy6/pnNYtHWL+wWsy7sYLVo3XuE3eLwm3ZWi3k75jJa/Lu2kcXi8fU/bBa3
        36xjdRD3WDNvDaPH71+TGD1mNfSyeWxa1cnmcefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/P
        m+QCuKK4bFJSczLLUov07RK4Mn6e2c9eMH8/Y8Xb/x+YGhg/TWbsYuTkkBAwkXh78w0riC0k
        sINR4t8eEYi4tMT1jRPYIWxhiZX/ngPZXEA1TUwSG1t/soEk2AS0Je5O38IEYosIeEi0/bvH
        DFLELNDBKrF71XtmkISwgJdE8/8pLCA2i4CqRP/+12DbeAVsJd4tmg+1QV5i9YYDYPWcQPF5
        C78BDeUA2mYjce63ygRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYLjSEtr
        B+OeVR/0DjEycTAeYpTgYFYS4a1KeZcoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0
        xJLU7NTUgtQimCwTB6dUAxOvSKGe0Nfzh6/vsA5dY/NozconS+f2l1nOfH3qxrt9vju0Zpnm
        t98LrF+fvPZxMrvIlQimOdEh6qtPld6U+/JwxcPf3OWxf2bLn92r9U/tk33ptUNzPFfJ3eRc
        bReZuetXdXpyxYxoy67S3+3FFd9vca+KDI/1Vt4Y2ejX6vT9UukHkwkp0fvasqRUwl/+7b56
        /ZDaG1OB8gDRmMmH0uWO3jyUW3KdYZGf9ReHa++Nda4GCMRP/yoz78mLzasvyeyQnPVndmJA
        zqPvS57zLmZhfd9remSWR53DMdYpc9LeX104dW3leh7ZzktXPqwyrcx29GoQ6W9bLH5c+L2i
        Cn9sQ/e64yK8Z75oHJiQ8zNMiaU4I9FQi7moOBEA10Ay0RIDAAA=
X-CMS-MailID: 20220124142957epcas5p27ab08d4eb02fe53a03e2b36ab1d913f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142957epcas5p27ab08d4eb02fe53a03e2b36ab1d913f8
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142957epcas5p27ab08d4eb02fe53a03e2b36ab1d913f8@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree support for "Full Self-Driving" (FSD) SoC
This SoC contain three clusters of four cortex-a72 CPUs and various
peripheral IPs.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Arjun K V <arjun.kv@samsung.com>
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
Signed-off-by: Shashank Prashar <s.prashar@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 MAINTAINERS                           |   8 +
 arch/arm64/Kconfig.platforms          |   6 +
 arch/arm64/boot/dts/Makefile          |   1 +
 arch/arm64/boot/dts/tesla/Makefile    |   3 +
 arch/arm64/boot/dts/tesla/fsd-evb.dts |  39 ++
 arch/arm64/boot/dts/tesla/fsd.dtsi    | 652 ++++++++++++++++++++++++++
 6 files changed, 709 insertions(+)
 create mode 100644 arch/arm64/boot/dts/tesla/Makefile
 create mode 100644 arch/arm64/boot/dts/tesla/fsd-evb.dts
 create mode 100644 arch/arm64/boot/dts/tesla/fsd.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 89f23af16451..d97d3a5d7f39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2753,6 +2753,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/tegra-cec.txt
 F:	drivers/media/cec/platform/tegra/
 
+ARM/TESLA FSD SoC SUPPORT
+M:	Alim Akhtar <alim.akhtar@samsung.com>
+M:	linux-fsd@tesla.com
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-samsung-soc@vger.kernel.org
+S:	Maintained
+F:	arch/arm64/boot/dts/tesla*
+
 ARM/TETON BGA MACHINE SUPPORT
 M:	"Mark F. Brown" <mark.brown314@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 7d5d58800170..739254493d6a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -268,6 +268,12 @@ config ARCH_TEGRA
 	help
 	  This enables support for the NVIDIA Tegra SoC family.
 
+config ARCH_TESLA_FSD
+	bool "ARMv8 based Tesla platform"
+	depends on ARCH_EXYNOS
+	help
+	  Support for ARMv8 based Tesla platforms.
+
 config ARCH_SPRD
 	bool "Spreadtrum SoC platform"
 	help
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 639e01a4d855..1ba04e31a438 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -27,6 +27,7 @@ subdir-y += rockchip
 subdir-y += socionext
 subdir-y += sprd
 subdir-y += synaptics
+subdir-y += tesla
 subdir-y += ti
 subdir-y += toshiba
 subdir-y += xilinx
diff --git a/arch/arm64/boot/dts/tesla/Makefile b/arch/arm64/boot/dts/tesla/Makefile
new file mode 100644
index 000000000000..a1ee50e2fd06
--- /dev/null
+++ b/arch/arm64/boot/dts/tesla/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_TESLA_FSD) += \
+	fsd-evb.dtb
diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
new file mode 100644
index 000000000000..5af560c1b5e6
--- /dev/null
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Tesla FSD board device tree source
+ *
+ * Copyright (c) 2017-2021 Samsung Electronics Co., Ltd.
+ *		https://www.samsung.com
+ * Copyright (c) 2017-2021 Tesla, Inc.
+ *		https://www.tesla.com
+ */
+
+/dts-v1/;
+#include "fsd.dtsi"
+
+/ {
+	model = "Tesla Full Self-Driving (FSD) Evaluation board";
+	compatible = "tesla,fsd-evb", "tesla,fsd";
+
+	aliases {
+		serial0 = &serial_0;
+		serial1 = &serial_1;
+	};
+
+	chosen {
+		stdout-path = &serial_0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x2 0x00000000>;
+	};
+};
+
+&fin_pll {
+	clock-frequency = <24000000>;
+};
+
+&serial_0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
new file mode 100644
index 000000000000..25b480147541
--- /dev/null
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -0,0 +1,652 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tesla Full Self-Driving SoC device tree source
+ *
+ * Copyright (c) 2017-2022 Samsung Electronics Co., Ltd.
+ *		https://www.samsung.com
+ * Copyright (c) 2017-2022 Tesla, Inc.
+ *		https://www.tesla.com
+ */
+
+#include <dt-bindings/clock/fsd-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "tesla,fsd";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		i2c0 = &hsi2c_0;
+		i2c1 = &hsi2c_1;
+		i2c2 = &hsi2c_2;
+		i2c3 = &hsi2c_3;
+		i2c4 = &hsi2c_4;
+		i2c5 = &hsi2c_5;
+		i2c6 = &hsi2c_6;
+		i2c7 = &hsi2c_7;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpucl0_0>;
+				};
+				core1 {
+					cpu = <&cpucl0_1>;
+				};
+				core2 {
+					cpu = <&cpucl0_2>;
+				};
+				core3 {
+					cpu = <&cpucl0_3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpucl1_0>;
+				};
+				core1 {
+					cpu = <&cpucl1_1>;
+				};
+				core2 {
+					cpu = <&cpucl1_2>;
+				};
+				core3 {
+					cpu = <&cpucl1_3>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cpucl2_0>;
+				};
+				core1 {
+					cpu = <&cpucl2_1>;
+				};
+				core2 {
+					cpu = <&cpucl2_2>;
+				};
+				core3 {
+					cpu = <&cpucl2_3>;
+				};
+			};
+		};
+
+		/* Cluster 0 */
+		cpucl0_0: cpu@0 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x000>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		cpucl0_1: cpu@1 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x001>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		cpucl0_2: cpu@2 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x002>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		cpucl0_3: cpu@3 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x003>;
+				enable-method = "psci";
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		/* Cluster 1 */
+		cpucl1_0: cpu@100 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x100>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		cpucl1_1: cpu@101 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x101>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		cpucl1_2: cpu@102 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x102>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		cpucl1_3: cpu@103 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x103>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		/* Cluster 2 */
+		cpucl2_0: cpu@200 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x200>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		cpucl2_1: cpu@201 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x201>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		cpucl2_2: cpu@202 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x202>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		cpucl2_3: cpu@203 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x203>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP: cpu-sleep {
+				idle-state-name = "c2";
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <30>;
+				exit-latency-us = <75>;
+				min-residency-us = <300>;
+			};
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpucl0_0>, <&cpucl0_1>, <&cpucl0_2>,
+				     <&cpucl0_3>, <&cpucl1_0>, <&cpucl1_1>,
+				     <&cpucl1_2>, <&cpucl1_3>, <&cpucl2_0>,
+				     <&cpucl2_1>, <&cpucl2_2>, <&cpucl2_3>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	fin_pll: clock {
+		compatible = "fixed-clock";
+		clock-output-names = "fin_pll";
+		#clock-cells = <0>;
+	};
+
+	soc: soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0x0 0x0 0x18000000>;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		gic: interrupt-controller@10400000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg =	<0x0 0x10400000 0x0 0x10000>, /* GICD */
+				<0x0 0x10600000 0x0 0x200000>; /* GICR_RD+GICR_SGI */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		smmu_imem: iommu@10200000 {
+			compatible = "arm,mmu-500";
+			reg = <0x0 0x10200000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <7>;
+			interrupts = <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
+				     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
+				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
+				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
+				     /* Performance counter interrupts */
+				     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>, /* for FSYS1_0 */
+				     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>, /* for FSYS1_1 */
+				     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>, /* for IMEM_0  */
+				     /* Per context non-secure context interrupts, 0-3 interrupts */
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
+				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_1 */
+				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_2 */
+				     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_3 */
+		};
+
+		smmu_isp: iommu@12100000 {
+			compatible = "arm,mmu-500";
+			reg = <0x0 0x12100000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <11>;
+			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
+				     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
+				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
+				     /* Performance counter interrupts */
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_CSI   */
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_DP_0  */
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_DP_1  */
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_ISP_0 */
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_ISP_1 */
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_MFC_0 */
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_MFC_1 */
+				     /* Per context non-secure context interrupts, 0-7 interrupts */
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_1 */
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_2 */
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_3 */
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_4 */
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_5 */
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_6 */
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_7 */
+		};
+
+		smmu_peric: iommu@14900000 {
+			compatible = "arm,mmu-500";
+			reg = <0x0 0x14900000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <5>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
+				     /* Performance counter interrupts */
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>, /* for PERIC */
+				     /* Per context non-secure context interrupts, 0-1 interrupts */
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_1 */
+		};
+
+		smmu_fsys0: iommu@15450000 {
+			compatible = "arm,mmu-500";
+			reg = <0x0 0x15450000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <5>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
+				     /* Performance counter interrupts */
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>, /* for FSYS0   */
+				     /* Per context non-secure context interrupts, 0-1 interrupts */
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_1 */
+		};
+
+		clock_imem: clock-controller@10010000 {
+			compatible = "tesla,fsd-clock-imem";
+			reg = <0x0 0x10010000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				<&clock_cmu DOUT_CMU_IMEM_TCUCLK>,
+				<&clock_cmu DOUT_CMU_IMEM_ACLK>,
+				<&clock_cmu DOUT_CMU_IMEM_DMACLK>;
+			clock-names = "fin_pll",
+				"dout_cmu_imem_tcuclk",
+				"dout_cmu_imem_aclk",
+				"dout_cmu_imem_dmaclk";
+		};
+
+		clock_cmu: clock-controller@11c10000 {
+			compatible = "tesla,fsd-clock-cmu";
+			reg = <0x0 0x11c10000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>;
+			clock-names = "fin_pll";
+		};
+
+		clock_csi: clock-controller@12610000 {
+			compatible = "tesla,fsd-clock-cam_csi";
+			reg = <0x0 0x12610000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>;
+			clock-names = "fin_pll";
+		};
+
+		clock_mfc: clock-controller@12810000 {
+			compatible = "tesla,fsd-clock-mfc";
+			reg = <0x0 0x12810000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>;
+			clock-names = "fin_pll";
+		};
+
+		clock_peric: clock-controller@14010000 {
+			compatible = "tesla,fsd-clock-peric";
+			reg = <0x0 0x14010000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				<&clock_cmu DOUT_CMU_PLL_SHARED0_DIV4>,
+				<&clock_cmu DOUT_CMU_PERIC_SHARED1DIV36>,
+				<&clock_cmu DOUT_CMU_PERIC_SHARED0DIV3_TBUCLK>,
+				<&clock_cmu DOUT_CMU_PERIC_SHARED0DIV20>,
+				<&clock_cmu DOUT_CMU_PERIC_SHARED1DIV4_DMACLK>;
+			clock-names = "fin_pll",
+				"dout_cmu_pll_shared0_div4",
+				"dout_cmu_peric_shared1div36",
+				"dout_cmu_peric_shared0div3_tbuclk",
+				"dout_cmu_peric_shared0div20",
+				"dout_cmu_peric_shared1div4_dmaclk";
+		};
+
+		clock_fsys0: clock-controller@15010000 {
+			compatible = "tesla,fsd-clock-fsys0";
+			reg = <0x0 0x15010000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				<&clock_cmu DOUT_CMU_PLL_SHARED0_DIV6>,
+				<&clock_cmu DOUT_CMU_FSYS0_SHARED1DIV4>,
+				<&clock_cmu DOUT_CMU_FSYS0_SHARED0DIV4>;
+			clock-names = "fin_pll",
+				"dout_cmu_pll_shared0_div6",
+				"dout_cmu_fsys0_shared1div4",
+				"dout_cmu_fsys0_shared0div4";
+		};
+
+		clock_fsys1: clock-controller@16810000 {
+			compatible = "tesla,fsd-clock-fsys1";
+			reg = <0x0 0x16810000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				<&clock_cmu DOUT_CMU_FSYS1_SHARED0DIV8>,
+				<&clock_cmu DOUT_CMU_FSYS1_SHARED0DIV4>;
+			clock-names = "fin_pll",
+				"dout_cmu_fsys1_shared0div8",
+				"dout_cmu_fsys1_shared0div4";
+		};
+
+		mdma0: dma-controller@10100000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0x10100000 0x0 0x1000>;
+			interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&clock_imem IMEM_DMA0_IPCLKPORT_ACLK>;
+			clock-names = "apb_pclk";
+			iommus = <&smmu_imem 0x800 0x0>;
+		};
+
+		mdma1: dma-controller@10110000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0x10110000 0x0 0x1000>;
+			interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&clock_imem IMEM_DMA1_IPCLKPORT_ACLK>;
+			clock-names = "apb_pclk";
+			iommus = <&smmu_imem 0x801 0x0>;
+		};
+
+		pdma0: dma-controller@14280000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0x14280000 0x0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&clock_peric PERIC_DMA0_IPCLKPORT_ACLK>;
+			clock-names = "apb_pclk";
+			iommus = <&smmu_peric 0x2 0x0>;
+		};
+
+		pdma1: dma-controller@14290000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0x14290000 0x0 0x1000>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&clock_peric PERIC_DMA1_IPCLKPORT_ACLK>;
+			clock-names = "apb_pclk";
+			iommus = <&smmu_peric 0x1 0x0>;
+		};
+
+		serial_0: serial@14180000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x0 0x14180000 0x0 0x100>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 1>, <&pdma1 0>;
+			dma-names = "rx", "tx";
+			clocks = <&clock_peric PERIC_PCLK_UART0>,
+				 <&clock_peric PERIC_SCLK_UART0>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		serial_1: serial@14190000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x0 0x14190000 0x0 0x100>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 3>, <&pdma1 2>;
+			dma-names = "rx", "tx";
+			clocks = <&clock_peric PERIC_PCLK_UART1>,
+				 <&clock_peric PERIC_SCLK_UART1>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		pmu_system_controller: system-controller@11400000 {
+			compatible = "samsung,exynos7-pmu", "syscon";
+			reg = <0x0 0x11400000 0x0 0x5000>;
+		};
+
+		watchdog_0: watchdog@100a0000 {
+			compatible = "samsung,exynos7-wdt";
+			reg = <0x0 0x100a0000 0x0 0x100>;
+			interrupts = <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			clocks = <&fin_pll>;
+			clock-names = "watchdog";
+		};
+
+		watchdog_1: watchdog@100b0000 {
+			compatible = "samsung,exynos7-wdt";
+			reg = <0x0 0x100b0000 0x0 0x100>;
+			interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			clocks = <&fin_pll>;
+			clock-names = "watchdog";
+		};
+
+		watchdog_2: watchdog@100c0000 {
+			compatible = "samsung,exynos7-wdt";
+			reg = <0x0 0x100c0000 0x0 0x100>;
+			interrupts = <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			clocks = <&fin_pll>;
+			clock-names = "watchdog";
+		};
+
+		pwm_0: pwm@14100000 {
+			compatible = "samsung,exynos4210-pwm";
+			reg = <0x0 0x14100000 0x0 0x100>;
+			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
+			#pwm-cells = <3>;
+			clocks = <&clock_peric PERIC_PWM0_IPCLKPORT_I_PCLK_S0>;
+			clock-names = "timers";
+			status = "disabled";
+		};
+
+		pwm_1: pwm@14110000 {
+			compatible = "samsung,exynos4210-pwm";
+			reg = <0x0 0x14110000 0x0 0x100>;
+			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
+			#pwm-cells = <3>;
+			clocks = <&clock_peric PERIC_PWM1_IPCLKPORT_I_PCLK_S0>;
+			clock-names = "timers";
+			status = "disabled";
+		};
+
+		hsi2c_0: i2c@14200000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14200000 0x0 0x1000>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c0_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C0>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_1: i2c@14210000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14210000 0x0 0x1000>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c1_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C1>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_2: i2c@14220000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14220000 0x0 0x1000>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c2_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C2>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_3: i2c@14230000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14230000 0x0 0x1000>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c3_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C3>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_4: i2c@14240000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14240000 0x0 0x1000>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c4_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C4>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_5: i2c@14250000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14250000 0x0 0x1000>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c5_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C5>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_6: i2c@14260000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14260000 0x0 0x1000>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c6_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C6>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_7: i2c@14270000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14270000 0x0 0x1000>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c7_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C7>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+	};
+};
-- 
2.25.1

