Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849DB53967B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347147AbiEaSq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347131AbiEaSqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:46:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46484EA9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:46:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f4so13610627pgf.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=OwYJ4pBOQLbB/cSHxIhZR3MCaTENQYo0mU/241HZsbE=;
        b=XHjHsQMMEMOC+xK1ZGwsGp362qbI8UmzzG95Fex8KQYkIrtvcZaa4jOk0YbZuhR8zJ
         lG//8e22xsAB/hZedSwkaMTxWU7xcFJVEfMrTchLDFxt+ndEYbzl7ziVtBkRqnEGFoQg
         8bWKhSzZhbsYuyv5eghX/7z5aBZ45TiCFLZUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=OwYJ4pBOQLbB/cSHxIhZR3MCaTENQYo0mU/241HZsbE=;
        b=SGOmPfgS91zXlHmrWpwjx1KB48bke3gwcEJfRmAjSYhyuLgwfAnkXxtLJjuyRQXRmX
         0FMMUndrLoXfdJWiNSJkQy89rx8RSV3RLfYZQcq39t1U1qBcjW/2NVVbGyPSbDf0nt7r
         1xCh1ODhszO94aHCZP4fB4PI3TDb7VKP90lkkrDHMBbyBbaS4qbpaz48F7IaaWEal4Y8
         x6cM7zPIf0PI3Kt5gpYC1QcDfIR3L7+CfixbNW88Vg7DUyJ/Otr/OtvrkaxC1zhq4mQE
         zxJCR2KZQfpCeBjFWzS1l7Zg41DbjeFRaYukY6Y6YyDgMesoTy40IhJQBVuODYExfzxE
         qQTw==
X-Gm-Message-State: AOAM53250ZdvUe7YVDh4RBLy/XHV2QmIpz+Ip+FkE/Xhr8kwsTKZ7amK
        zVUBLRywZL8NUEcAnAi98g51kw==
X-Google-Smtp-Source: ABdhPJxq9IIv8UERmd21vNpXp547aJhItQFQ3sWg58qEwVTB36G9VbpH8z3kIpC6lW8/1m3P6AZXfA==
X-Received: by 2002:a63:18a:0:b0:3fb:d004:73e2 with SMTP id 132-20020a63018a000000b003fbd00473e2mr15487878pgb.461.1654022782668;
        Tue, 31 May 2022 11:46:22 -0700 (PDT)
Received: from linuxpc-ThinkServer-TS140.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm11358272pll.145.2022.05.31.11.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:46:22 -0700 (PDT)
From:   Anand Gore <anand.gore@broadcom.com>
To:     Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, florian.fainelli@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ARM64: dts: add dts files for bcmbca SoC bcm6858
Date:   Tue, 31 May 2022 11:46:13 -0700
Message-Id: <20220531114551.v2.1.I66ae43da75911b704f02a759f70d66bc7e542885@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531184615.2836433-1-anand.gore@broadcom.com>
References: <20220531184615.2836433-1-anand.gore@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006ef90b05e05330d9"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006ef90b05e05330d9
Content-Transfer-Encoding: 8bit

Add dts for ARMv8 based broadband SoC BCM6858.
bcm6858.dtsi is the SoC description dts header
and bcm96858.dts is a simple dts file for Broadcom
BCM96858 Reference board that only enables the UART port.

Signed-off-by: Anand Gore <anand.gore@broadcom.com>

---

Changes in v2:
- Fix psci and GIC entries in dts

 arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   3 +-
 .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     | 121 ++++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm96858.dts     |  30 +++++
 3 files changed, 153 insertions(+), 1 deletion(-)
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
index 000000000000..ff8d9a728d8d
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
@@ -0,0 +1,121 @@
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
+	};
+
+	axi@81000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0x81000000 0x0 0x8000>;
+
+		gic: interrupt-controller@1000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x0 0x1000 0x0 0x1000>, /* GICD */
+				<0x0 0x2000 0x0 0x2000>, /* GICC */
+				<0x0 0x4000 0x0 0x2000>, /* GICH */
+				<0x0 0x6000 0x0 0x2000>; /* GICV */
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+					IRQ_TYPE_LEVEL_HIGH)>;
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


--0000000000006ef90b05e05330d9
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
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMxgfAffVYTct3wWmMAs2MHAmOjxYDSy7HHcIaRg
QUgEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDUzMTE4NDYy
M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQB/m8PInDagVrXCNe2+iOdklWeRupqJewHdDRcVRSUD7mkSWuhObAs+nolj
2Xa8SSvYCRVI1WE6FctsLtPHp2xsDBm7KBzFvAPqH4s1loDNZdO3EDfPzRmDq616V0JWK3CiCbMn
eYTHe0O7qi+2G8bUgVdLcRPdKfXTkf7cr0CKPWnMwssevlXmljPhcRDd5BmHPKm+kaEat5z9wiHX
ko5vaL9cKiSu8qGJJU24ys3rXslIfD22RFlxrwXVGjSzrzwNp4/uunzRp0OyOKCzTmJFL2Z4ssSy
Yg7bsBqbTvrNpC/b5X9s8klomG/9uopV8zjHv2no7IQCsGlfIPb0yB6c
--0000000000006ef90b05e05330d9--
