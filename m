Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991EF4A8D95
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354388AbiBCUbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354368AbiBCUbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:31:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6CDC061749;
        Thu,  3 Feb 2022 12:30:53 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id s13so12392504ejy.3;
        Thu, 03 Feb 2022 12:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTBrkv50iPcsCl3Axc+/Cs3Z68I2VsXqY0C0lgkJvTM=;
        b=atofIeh4yIXZ0J9+2qb+Egv0Sj+9EN0yrcwr3AbxcuxVq4VZtPOzTUTa/fJnOOK7cP
         xy79ZNP7g8hFten6aD1Zw07nLBR2WYOfj0i+Z67x5goL1dDtvH6i6EQFDWcS+48r2o5c
         99nm4W1tPG69PYc9kxNd1zOUpGR7yyjKb03stUM0nuHC4tnQtKsUopp+8XRTgsC+txTq
         AUPJT4JX+oCYGCLaHgI2Mi9e3mSuq7XJzuEamE3LqpM/J/0wVMWWqXCA4LQwSU702fv+
         /38Y+DVaR5ank4+U4DfTvtrsBXtpADhaQfAPAY0NgOkyKggibE7Di+W0gcZZdAGwUkLv
         OK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTBrkv50iPcsCl3Axc+/Cs3Z68I2VsXqY0C0lgkJvTM=;
        b=L7dh3JFlnk41Y/CyA3r3GGkxTOR/pmD7CnEGm1+fp++S2S1Tz6R57akQySiaaEVjlv
         2EMctZvF3iX6JXPrP2EUzHFWSLBiGw2vRQC+bQaevy4Bb1RWaeXIvy+iLZ3HXRPJwa7w
         9BN5zOv9ec/YuSDpT5gVK8cUKFkbVv+5mHpsO0KcZw/Nmv+bLjKiVSVJA9HxoJHuxUo9
         IWLCctwXtSeoOhtIVukE8iq95Fa5IEPDqeXcfGjgGUSkAsgQmMCeIZpArEkOpz11fb4C
         1iaaKlHH5tpmWgws6qo4+t1rsCNb5Boj10RWNdcNM+PX3KJJmHFqqXfdUuIcNkW8p0WQ
         KYJg==
X-Gm-Message-State: AOAM531iIJW8NsEpOuakx7WVz7SX6hB1OzT8Pw8B38BHKxXvs9hWVZKX
        16JbICz05Ud6xfGwjxqxYBA=
X-Google-Smtp-Source: ABdhPJyM5yR9dRAuxYavP8LBxjs7IkwqTDrm+TvEKoUHcoUHW5eMd/V4plTO6YUFaH5jH6c8o7fUKw==
X-Received: by 2002:a17:907:2d11:: with SMTP id gs17mr31591742ejc.189.1643920252145;
        Thu, 03 Feb 2022 12:30:52 -0800 (PST)
Received: from adroid (027-177-184-091.ip-addr.vsenet.de. [91.184.177.27])
        by smtp.gmail.com with ESMTPSA id ry6sm8843513ejc.45.2022.02.03.12.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:30:51 -0800 (PST)
From:   =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
Subject: [PATCH v2 1/2] ARM: dts: exynos: add charger and battery to p4note
Date:   Thu,  3 Feb 2022 21:29:47 +0100
Message-Id: <d7f7b0f87a18b5cc44ba97390461c15469439829.1643919230.git.martin.juecker@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree entry to support the Summit SMB347 charger which is
built into the p4note devices, as well as a simple battery node.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
Changes in v2:
  - squash charger and battery commits
---
 arch/arm/boot/dts/exynos4412-p4note.dtsi | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index b386a9b8e188..fcd75cceb877 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/samsung.h>
+#include <dt-bindings/power/summit,smb347-charger.h>
 
 / {
 	compatible = "samsung,p4note", "samsung,exynos4412", "samsung,exynos4";
@@ -114,6 +115,17 @@ wlan_pwrseq: sdhci3-pwrseq {
 		clock-names = "ext_clock";
 	};
 
+	battery_cell: battery-cell {
+		compatible = "simple-battery";
+		device-chemistry = "lithium-ion";
+		constant-charge-current-max-microamp = <2200000>;
+		precharge-current-microamp = <250000>;
+		charge-term-current-microamp = <250000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+
+		power-supplies = <&power_supply>;
+	};
+
 	i2c-gpio-1 {
 		compatible = "i2c-gpio";
 		sda-gpios = <&gpy2 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
@@ -182,6 +194,29 @@ stmpe_adc {
 			};
 		};
 	};
+
+	i2c-gpio-4 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpm2 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpm2 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		power_supply: charger@6 {
+			compatible = "summit,smb347";
+			reg = <0x6>;
+			summit,enable-usb-charging;
+			summit,enable-charge-control = <SMB3XX_CHG_ENABLE_SW>;
+			summit,fast-voltage-threshold-microvolt = <2600000>;
+			summit,chip-temperature-threshold-celsius = <130>;
+			summit,usb-current-limit-microamp = <1800000>;
+
+			monitored-battery = <&battery_cell>;
+		};
+	};
+
 };
 
 &adc {
-- 
2.25.1

