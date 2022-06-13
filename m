Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434C54843D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbiFMJyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbiFMJyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:54:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617D71928F;
        Mon, 13 Jun 2022 02:54:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso5421531pjh.4;
        Mon, 13 Jun 2022 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=erc0cF0H69wNUT+Fr3YuZFhUNW2gCbs/AEVN/v4U6VE=;
        b=qEH2xUwt6QE+bDHotqWVLLYfc+6yrZjyHxzXPLyeUfRXD5Zzzaxh9lLTofaAc4EP0U
         lbj+KyYoi+7cnBpus7ALuZ67EHXdxxlKghYCoZyfL0RLL3AWsjxDfaXNX+U9nD6uaxfr
         J3VGgciJXyMaYrurVsPoufT94gGlVA3JNfgNQmsB9Gn/cVFdgZA7BGjAS8AmUKRD8LJh
         4sAHKg1hApMuoylXtEFyiNndh3XhAvNbeXr89nHQ+5/D62hmZMCYHveJCfyvqEcMO0eq
         WliT9Mv69nv8DdXG6gg3/JuyZEnsVq+lN8gitIcSKv1+R2Doafq08kjeQPvcx8LBwO6U
         n1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=erc0cF0H69wNUT+Fr3YuZFhUNW2gCbs/AEVN/v4U6VE=;
        b=cCt3mz4sDeblJoY/EW76wP2bdhhMwA1icSXOb9rEv01GpaGAhAHfXhB0dGO8P0voIW
         TyO4tJAq2WVmzo2cbQIAmwOUHUXyopX0OEfwt6s9Vp30VBrB+t4dgVn/wTkKs7cxMu0e
         oKMl4BzvhF1kTd/5sJkeHwYszRN5PZq+lYGAN01gAkBP1nxu4jWIhCU9JqT1tr1Yf9aT
         khv0/tBh26rhHvmK79B1qWNVOsU6gUelwAcNjStDnq8BCqF/gzeoREpMzQ+5nQX5Nefk
         QR1e5ciEC2mwkPNX85aRw4sN8tcFNh35eGQHBSYfjNAuSmM028HQVxqmzLkyBdyMh123
         qvRQ==
X-Gm-Message-State: AOAM532POINwh75kstloItCeZnGSnrIu25yIe9lNuMdxIrm+rCtSjZK8
        B2S3yS7rEpy6HHH6sGcHfnU=
X-Google-Smtp-Source: ABdhPJwgoF4t8LjwUPn6oaVyQHoakaWUU1XeGOYjr2dzzXgmP4s+IQ6ppGbNq4FSt7nL1UhQ/pW6Yg==
X-Received: by 2002:a17:902:f64c:b0:156:4349:7e9b with SMTP id m12-20020a170902f64c00b0015643497e9bmr58999092plg.139.1655114046570;
        Mon, 13 Jun 2022 02:54:06 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b001639f038250sm4639754plk.220.2022.06.13.02.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:54:06 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 4/4] ARM: dts: aspeed: bletchley: update fusb302 nodes
Date:   Mon, 13 Jun 2022 17:51:50 +0800
Message-Id: <20220613095150.21917-5-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613095150.21917-1-potin.lai.pt@gmail.com>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add interrupt pin of fusb302 on each sled.
2. Add vbus-supply property in each fusb302 node.
3. Fix BMC power-role at source and data-role at host.
4. Disable PD to avoid "HARD Reset" due to incompatible PD ver.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 150 ++++++++++++------
 1 file changed, 102 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 7b6de9b51547..9fdb3d17596b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -225,6 +225,60 @@
 			linux,code = <ASPEED_GPIO(H, 7)>;
 		};
 	};
+
+	vbus_sled1: vbus_sled1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled1_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus_sled2: vbus_sled2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled2";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled2_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus_sled3: vbus_sled3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled3";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled3_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus_sled4: vbus_sled4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled4";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled4_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus_sled5: vbus_sled5 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled5";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled5_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus_sled6: vbus_sled6 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled6";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled6_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &mac2 {
@@ -336,17 +390,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(B, 0) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled1>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
@@ -422,17 +476,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(B, 1) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled2>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
@@ -508,17 +562,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(B, 7) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled3>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
@@ -594,17 +648,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(S, 7) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled4>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
@@ -680,17 +734,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(Y, 3) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled5>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
@@ -766,17 +820,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 7) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled6>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
-- 
2.17.1

