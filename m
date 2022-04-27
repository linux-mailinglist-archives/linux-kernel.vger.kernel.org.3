Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA31511196
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358338AbiD0Gub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358306AbiD0GuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:50:22 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528814C3D3;
        Tue, 26 Apr 2022 23:47:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R6l4AV057054;
        Wed, 27 Apr 2022 01:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651042024;
        bh=dQykCtMpHH5Vv76n/embx/A2LtvvgD5CCpEoLgLlfsY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jTYAsnQvZwQe7OFk7N3Y/dRYasnBYgqk9r0v/Rj5rGN9+Hvms2xwwrmBRrrPUOf2+
         hJuIsn/TmJmxQb7GyHJRN7G23CGSG0c5CnxzFLWqX+98r2ec/3M53yisJWWr3lM2+e
         1byd6nvEmd6hCEl6tLGYgP7Y0QOj4ISx/jhx7H40=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R6l4pU005963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 01:47:04 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 01:47:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 01:47:03 -0500
Received: from keerthy.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R6kjX9031550;
        Wed, 27 Apr 2022 01:47:00 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <krzysztof.kozlowski@linaro.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/4] arm64: dts: ti: j7200: Add VTM node
Date:   Wed, 27 Apr 2022 12:16:34 +0530
Message-ID: <20220427064635.24898-4-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427064635.24898-1-j-keerthy@ti.com>
References: <20220427064635.24898-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VTM stands for Voltage Thermal Management

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  9 ++++
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  | 47 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  2 +
 3 files changed, 58 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 1044ec6c4b0d..a53afc5c5dce 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -375,4 +375,13 @@
 			ti,loczrama = <1>;
 		};
 	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+			<0x00 0x42050000 0x00 0x350>,
+			<0x00 0x43000300 0x00 0x10>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
new file mode 100644
index 000000000000..e7e3a643a6f0
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	mcu_thermal: mcu-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 0>;
+
+		trips {
+			wkup_crit: wkup-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	mpu_thermal: mpu-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 1>;
+
+		trips {
+			mpu_crit: mpu-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main_thermal: main-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 2>;
+
+		trips {
+			c7x_crit: c7x-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
index b6da0454cc5b..2abc872ecec0 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
@@ -168,6 +168,8 @@
 				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3 */
 		};
 	};
+
+	#include "k3-j7200-thermal.dtsi"
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.17.1

