Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698CA5274AC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiENX3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 19:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiENX2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 19:28:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4589819C05
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 16:28:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c9so11229940plh.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 16:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IVu6t+bqTMDNLaVDSPsQjfoCCoDDKTHoTVjhTL0Pva4=;
        b=DGN/UBt81EMLt9m0xlJ7MDsfN/UTd92MC6BvtB0UWgcsOhj7Y7NPmRcGrPagjF49eN
         erwnl/gHjZHZ0QGE0Lx6ozhCHEwKMtLJ/vhvekLQB0mKh9KyQPdgk4/k1HCgsBZPFNby
         U1UfAWD4MWI4pRw3bLDxa98+iHyxXz5plaJlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IVu6t+bqTMDNLaVDSPsQjfoCCoDDKTHoTVjhTL0Pva4=;
        b=cU/W0b1ZHSRSWWaPpFkwSiQlSmI+7yUj9BdrXuIX2PiMX6dl6dpit844Zy2c50P5hi
         qH1a5q15UTC5He5RsL/X2rJNZVGzWdWUjzdF5xmiEcNc0AwFY/7K3GOD09ldJqsxHFla
         nlzOOpa37o2E8Bx8lJW7zYe+aBXUCr0kcYoEvu1JREDxYGEBMo4Fp2cP1mGJUvCB3E0z
         b7PqqdwQ0S+V+0pi4vJharF8tHELO5koDrbO2q9MZJmU9UgshsY+YFJYNcucl+p8uXKV
         4MzsWuZx9VKNjAJ588CNmO7vxJtfYeTCWFJVFNmxzB1cSJ+C4/aswkber9vwX7Gb4Xa5
         6q8g==
X-Gm-Message-State: AOAM531iR+eBJrPZ3zes68f+yLH29OM4/dgRsZNux+byUSqLXF+xbUcJ
        7PAPff3qtAeQKfYEb8vCegN/cg==
X-Google-Smtp-Source: ABdhPJz2b5SJhj6uFkp+wWP7bRXaYoRfspb6GFr2rRMUE0+GPPbY5c5N8zV89xyT//jQ0EyhQDzdww==
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id l5-20020a170903120500b0015e8cbcfd2bmr11190155plh.99.1652570929705;
        Sat, 14 May 2022 16:28:49 -0700 (PDT)
Received: from T3500-3.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902d58900b0015e8d4eb2b8sm4165087plh.258.2022.05.14.16.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 16:28:49 -0700 (PDT)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, florian.fainelli@broadcom.com,
        joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com, philippe.reynes@softathome.com,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: add dts files for bcmbca soc 63158
Date:   Sat, 14 May 2022 16:27:58 -0700
Message-Id: <20220514232800.24653-4-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220514232800.24653-1-william.zhang@broadcom.com>
References: <20220514232800.24653-1-william.zhang@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000040662f05df0127e5"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000040662f05df0127e5

Add dts for ARMv8 based broadband SoC BCM63158. bcm63158.dtsi is the
SoC description dts header and bcm963158.dts is a simple dts file for
Broadcom BCM963158 Reference board that only enable the UART port.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

 arch/arm64/boot/dts/broadcom/Makefile         |   1 +
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   2 +
 .../boot/dts/broadcom/bcmbca/bcm63158.dtsi    | 128 ++++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm963158.dts    |  30 ++++
 4 files changed, 161 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 5082fcd1fea5..e8584d3b698f 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -9,5 +9,6 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2837-rpi-zero-2-w.dtb
 
 subdir-y	+= bcm4908
+subdir-y	+= bcmbca
 subdir-y	+= northstar2
 subdir-y	+= stingray
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
new file mode 100644
index 000000000000..d5f89245336c
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_BCMBCA) += bcm963158.dtb
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
new file mode 100644
index 000000000000..cfa235d99a32
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "brcm,bcm63158", "brcm,bcmbca";
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
+
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
+		periph_clk: periph-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+		uart_clk: uart-clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&periph_clk>;
+			clock-div = <4>;
+			clock-mult = <1>;
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
+		ranges = <0x0 0x0 0x0 0xff800000 0x0 0x800000>;
+
+		uart0: serial@12000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0x12000 0x0 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>, <&uart_clk>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
new file mode 100644
index 000000000000..eba07e0b1ca6
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+/dts-v1/;
+
+#include "bcm63158.dtsi"
+
+/ {
+	model = "Broadcom BCM963158 Reference Board";
+	compatible = "brcm,bcm963158", "brcm,bcm63158", "brcm,bcmbca";
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
2.17.1


--00000000000040662f05df0127e5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDDbx5fpN++xs1+5IgzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwODA1MjJaFw0yMjA5MDUwODEwMTZaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDVdpbGxpYW0gWmhhbmcxKTAnBgkqhkiG9w0B
CQEWGndpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA4fxIZbzNLvB+7yJE8mbojRaOoaK1uZy1/etc55NzisSJJfY36BAlb7LlMDsza2/BcjXh
lSACuzeOyI8sy2pKHGt5SZCMHeHaxP8q4ZNR6EGz7+5Lopw6ies8fkDoZ/XFIHpfU2eKcIYrxI25
bTaYAPDA50BHTPDFzPNkWEIIQaSBBkk55bndnMmB/pPR/IhKjLefDIhIsiWLrvQstTiSf7iUCwMf
TltlrAeBKRJ1M9O/DY5v7L1Yrs//7XIRg/d2ZPAOSGBQzFYjYTFWwNBiR1s1zP0m2y56DPbS5gwj
fqAN/I4PJHIvTh3zUgHXNKadYoYRiPHXfaTWO9UhzysOpQIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUohM5GmNlGWe5wpzDxzIy
+EgzbRswDQYJKoZIhvcNAQELBQADggEBACKu9JSQAYTlmC+JTniO/C/UcXGonATI/muBjWTxtkHc
abZtz0uwzzrRrpV+mbHLGVFFeRbXSLvcEzqHp8VomXifEZlfsE9LajSehzaqhd+np+tmUPz1RlI/
ibZ7vW+1VF18lfoL+wHs2H0fsG6JfoqZldEWYXASXnUrs0iTLgXxvwaQj69cSMuzfFm1X5kWqWCP
W0KkR8025J0L5L4yXfkSO6psD/k4VcTsMJHLN4RfMuaXIT6EM0cNO6h3GypyTuPf1N1X+F6WQPKb
1u+rvdML63P9fX7e7mwwGt5klRnf8aK2VU7mIdYCcrFHaKDTW3fkG6kIgrE1wWSgiZYL400xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw28eX6TfvsbNfu
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMthm9WQsOZ2+7QaF4qiEgFrXS2s
H3v8aqU/s+6edNSOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDUxNDIzMjg1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBq7vCmt7XHwqvNayKolQ4bsTpeE8HWBXMdzPNlvGZm1NR+
lenZR6sCRSMxw0a8yKkpiBSe4MLjOsbkQg+YkduhlcmxhSqRtTJEaa3LokFVEn7inLWHV0YWhogZ
oNyJkOCQRspBrzIdDKypCiHVR48n6GtaOnfsPNFpuWn5CPV6NytIKWlbti45jzvFyGFGnGtfHxqM
q2D+h8orVV0d7YjHxKGDuKWv0ws4HdAvqZaV2hPFmKRWTWaXiDg7YtvSHNYPbb8QRnims+a91sPR
El1BuGfx691B0LnTHkUAi6S1ip8hWkAHKHrRfnBFXJsDq+pl8kf8PrG2TbCjo6H3zPaW
--00000000000040662f05df0127e5--
