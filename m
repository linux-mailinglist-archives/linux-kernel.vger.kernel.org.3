Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB19953667A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354291AbiE0ROL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354227AbiE0ROE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:14:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721F14085A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:14:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so4663441plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=X3znYXsVI9HAVFGXDomTI6Wq9swbCwGgOA1KDdbL2zw=;
        b=Q+eDk7mKDYTW2hp6AYhjaLu53AxXxKqc58x6kACpopoPDmSPhotF/mymc8NcGdn+M1
         dtc+3ta+IMBfnmzKia+H+xJKE4BSX+a+pCg59WRaGqAsSC4jGGLvVB8wsCSST0xeXoSX
         fsyPmlAb06TL1Cs8ei6I1eshTE2AUhegkh758=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=X3znYXsVI9HAVFGXDomTI6Wq9swbCwGgOA1KDdbL2zw=;
        b=i0HeDXzVP8GJeBw7j6LwRcYjZgFNo4/k9vXtyAn0gefEnfPy07E2eIX3GE1LL7B2J1
         Rtx46+Ahzm77i23VDY1w+FPJ6IV4qp7a6kMZNIop/M3AXjzHB0yxk9c72aRdi/SVZWGE
         RT9xOvDpa4pC3At/n+/WAcU43nRg+KstX0sL2YNImcdD6etP6vH/FS0JZUPVSaSgPol5
         jVBLoL564cUjDxkcJL50Z6TNVQmV3vqBNJaJjd4w2HgpXtStiUndC+qbHjM2bnlUXN7w
         AV8DTv2F+eJBk7lWtsPpLMKGRFBPhRSwa253AD3dBMUZlLdcZ0xqafIEdqynvt7AUDSQ
         K2Vg==
X-Gm-Message-State: AOAM532kgTmbYo0dK0yQZXc0tpPtppK1sK7hQuKgg9GHqgaIAZw61Csb
        ZK7q0UEgpI42wCkCz5iuFCRfsw==
X-Google-Smtp-Source: ABdhPJxx3aYQ+XtnwVt16UuoLJ8fK0vRgb+7iEBXKKNwV3LDJ6Jpgk4S7al5UWtYZJ4/7hcAq1pW7Q==
X-Received: by 2002:a17:90b:3510:b0:1e0:b82:7558 with SMTP id ls16-20020a17090b351000b001e00b827558mr9403791pjb.21.1653671642614;
        Fri, 27 May 2022 10:14:02 -0700 (PDT)
Received: from linuxpc-ThinkServer-TS140.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u135-20020a62798d000000b0050dc762815csm3828901pfc.54.2022.05.27.10.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 10:14:02 -0700 (PDT)
From:   Anand Gore <anand.gore@broadcom.com>
To:     Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     dan.beygelman@broadcom.com, samyon.furman@broadcom.com,
        florian.fainelli@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, Anand Gore <anand.gore@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM64: dts: add dts files for bcmbca SoC bcm6858
Date:   Fri, 27 May 2022 10:13:54 -0700
Message-Id: <20220527101336.1.I66ae43da75911b704f02a759f70d66bc7e542885@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527171356.2461297-1-anand.gore@broadcom.com>
References: <20220527171356.2461297-1-anand.gore@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000dac33305e0016e97"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000dac33305e0016e97
Content-Transfer-Encoding: 8bit

Add dts for ARMv8 based broadband SoC BCM6858.
bcm6858.dtsi is the SoC description dts header
and bcm96858.dts is a simple dts file for Broadcom
BCM96858 Reference board that only enables the UART port.

Signed-off-by: Anand Gore <anand.gore@broadcom.com>

---

 arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   3 +-
 .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     | 120 ++++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm96858.dts     |  30 +++++
 3 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
index d5f89245336c..7d98b0787b8c 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCMBCA) += bcm963158.dtb
+dtb-$(CONFIG_ARCH_BCMBCA) += bcm963158.dtb \
+				bcm96858.dtb
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
new file mode 100644
index 000000000000..664b8f399d69
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "brcm,bcm6858", "brcm,bcmbca";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		B53_0: cpu@0 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_1: cpu@1 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_2: cpu@2 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_3: cpu@3 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu: pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&B53_0>, <&B53_1>,
+			<&B53_2>, <&B53_3>;
+	};
+
+	clocks: clocks {
+		periph_clk:periph-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+		cpu_off = <1>;
+		cpu_on = <2>;
+	};
+
+	axi@81000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0x81000000 0x0 0x4000>;
+
+		gic: interrupt-controller@1000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0x1000 0x0 0x1000>,
+				<0x0 0x2000 0x0 0x2000>;
+		};
+	};
+
+	bus@ff800000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0xff800000 0x0 0x62000>;
+
+		uart0: serial@640 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x0 0x640 0x0 0x18>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&periph_clk>;
+			clock-names = "refclk";
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
new file mode 100644
index 000000000000..0cbf582f5d54
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+/dts-v1/;
+
+#include "bcm6858.dtsi"
+
+/ {
+	model = "Broadcom BCM96858 Reference Board";
+	compatible = "brcm,bcm96858", "brcm,bcm6858", "brcm,bcmbca";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x08000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.25.1


--000000000000dac33305e0016e97
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
dD3eNkKBkknQBWvFfBHcITIVdVccQg5YcIwowkVZhhA3NG0BXGI4l/3o+wjrl2BGO/t969dabQ5x
/SxGBTK8Vyn6NG7U0Lrjb0VtnrFXgEdxFvJuEQIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdhbmFuZC5nb3JlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUH4HXhI4xxNPqnv0yfNL6is0cLFYwDQYJ
KoZIhvcNAQELBQADggEBAAU15tMIqa2yrLdoPoNXMk6scL+6XJK/EVe0Lq0Uyq0SV8wpFV09ujno
nLmSFYTz1RjmiKr1eu/pwyTImqMUj1JAXZ2zgE0rFS5SvchJsSlB8Nv3WeTaf5Lha5ZmRTaB0U/E
eo7SFjA240UWLCGqXM69XCc5PHk6mWLNTsyDTgK2kLUKP1RVFswACNsI284fxiwA0qSCu2WnOEKE
LiytE/NBFgzVtBcryeBtcMnhZgMo0PQYRl4O+58O1O703CD1jiO4/ikP+hUTdxWQiiWAzpE89YCH
S0Pc2d2yC8RWARAiArr1jXHWA4+snG+TS3A1YVSPRZpboS5AXMutIIQ5YZQxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxzcZR0ocq9f8sVOu8wDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGKvZ/WhflkVMQuw4wGVVE/I5IE8tlYAeN9FzxMZ
hxwGMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDUyNzE3MTQw
MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQBqedKQC8bUM8doI0jL+ZdJ9K6i/V5ey/AhoLhLQfylJGK3FXbE0BVdbcsI
gpX18XGmW1Rz45WjxaaDEUnXa+VN9UyAk3IHLygERxHRqf9rVZoWLDCMbBAQY0WQ43bckD0rk65p
8kD+cLJxK0k1AmG7Lhp7wZ8NdZoH6JmdJ8BM5kMYkszQpCJpQteR1/MdSz5tMfzU1NZGfHl9PE5B
p9w5yUcgyOKMPLtpxzajxFkJ6tbNhIMDZxZUg0pPTr4Jo8/mGB2k3/1mGXfRcLqzk4AZj8tAJKVJ
FztgyUTfvyoCke+kBNqWJ3ZmOaM3I2IkWOO3shPPqeKyqwP+WnWYywcd
--000000000000dac33305e0016e97--
