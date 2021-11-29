Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991D3462219
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhK2UXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhK2UVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:21:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F13C06FD75;
        Mon, 29 Nov 2021 08:55:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so12877228wme.4;
        Mon, 29 Nov 2021 08:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GG5IcfDm+AMeXL7H50gjjx1nk2+97tgWyxWTprQdbjQ=;
        b=n9S4SOH+hITJyCaI4qEBAvyEb/j05Fzj23D9YCXkYDRU9QQLk1XdgZ9Jd8vYzCgJPS
         YuyUw4mSn5/+ZDviDKB35OE8f4xZm6M77uBqi8dh7E30k1C7RUzy/Fw+RC+C8JqDrYNN
         HgAul6nFSunzTg3frkYV7Dx2XPY8ed7GDvkayyKKCNbIYTpa0V7Ju1wB9m5W27SAYyZI
         rAKMjQVqzeWrwxq5wbi4gYebOdCqOyO5qzwvn5+fEY9WD/azV7DNrKomChqB2tuT5+ZU
         L7mqWFkUxQ0haXZve/kuQvqeyjmtHIcqglJF67dF20YMV3qKIvxr8mHzuqo1K+6D7sYz
         0uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GG5IcfDm+AMeXL7H50gjjx1nk2+97tgWyxWTprQdbjQ=;
        b=d42g1i+reAPrkd5Vtgr2L8T7mQ5qbaOryfjT3uXE6PVcEEJrbr9SjLEJgMIHPPVRBj
         Lr8eR/2/aKgXeV2HZ4LQZli/nt66+2B2ZvouwZNmbSYvGx8yU6/m4qDTTiP7uzZm788e
         rN0OxAuH4iIvda+7BqQX9nrOuMkGO/qV7JJkk4OpZ39yA0Kuhyn0mp4/ZANTfNhjiETr
         dRipK6hwek8Ab+W6UBduFIzLOWo/75npxJ/LT5/DDt0CpyscVdN1mkTrBfBw1sePExtn
         9tMfllAHzUKaavRYWXZ+stQoq4sAblwhbF/3pBlUlATSmoeavejrdcOtSpVi9sMQG+de
         BUnQ==
X-Gm-Message-State: AOAM53240xRTIVNXJcpfJXsMt0OWaOUraeLZ3XVxYF6VKBiQ5tF4XvRt
        tzWtrw+VIQ8SI4eHyVVIkzs=
X-Google-Smtp-Source: ABdhPJyTqLw6ql4fgR+ktp+Ip5KVhQ8XbBi1weeHAETxyYUzzQX/s1IC0fdkyYGaq0tMwspRYBZrfg==
X-Received: by 2002:a05:600c:4f87:: with SMTP id n7mr37180639wmq.168.1638204913765;
        Mon, 29 Nov 2021 08:55:13 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id q26sm14528695wrc.39.2021.11.29.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 08:55:13 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Klein <michael@fossekall.de>
Subject: [PATCH v2] ARM: dts: sun8i: Adjust power key nodes
Date:   Mon, 29 Nov 2021 17:55:10 +0100
Message-Id: <20211129165510.370717-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several H3 and one H2+ board have power key nodes, which are slightly
off. Some are missing wakeup-source property and some have BTN_0 code
assigned instead of KEY_POWER.

Adjust them, so they can function as intended by designer.

Co-developed-by: Michael Klein <michael@fossekall.de>
Signed-off-by: Michael Klein <michael@fossekall.de>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes from v1:
- added Co-developed-by tag

 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 3 ++-
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi               | 1 +
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts            | 3 ++-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts           | 3 ++-
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi        | 3 ++-
 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi     | 1 +
 6 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index 8e8634ff2f9d..d5c7b7984d85 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -52,8 +52,9 @@ gpio_keys {
 
 		sw4 {
 			label = "power";
-			linux,code = <BTN_0>;
+			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
index c7c3e7d8b3c8..fc45d5aaa67f 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
@@ -81,6 +81,7 @@ k1 {
 			label = "k1";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 597c425d08ec..9daffd90c12f 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -99,8 +99,9 @@ sw2 {
 
 		sw4 {
 			label = "sw4";
-			linux,code = <BTN_0>;
+			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 5aff8ecc66cb..90f75fa85e68 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -91,8 +91,9 @@ r_gpio_keys {
 
 		sw4 {
 			label = "sw4";
-			linux,code = <BTN_0>;
+			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
index 7a6af54dd342..d03f5853ef7b 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
@@ -82,8 +82,9 @@ gpio_keys {
 
 		sw4 {
 			label = "power";
-			linux,code = <BTN_0>;
+			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
index c44fd726945a..9e14fe5fdcde 100644
--- a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
+++ b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
@@ -49,6 +49,7 @@ power {
 			label = "power";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+			wakeup-source;
 		};
 	};
 
-- 
2.34.1

