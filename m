Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5132949C2CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiAZEuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiAZEuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:50:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F334C061748;
        Tue, 25 Jan 2022 20:50:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r7so1722330wmq.5;
        Tue, 25 Jan 2022 20:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VcXMYRd9nvU6wwq0JZM21t9w6xo2utk/CM5bkqi1t0Q=;
        b=OORLWLxo5Qil2yoA01f7hsqlK7krLOGzUBUGb+SB6dzzWYrX0Yl8XzvlWYp3tvmpKR
         If1supF8lx5s65uDJYGNW7oPCSSMlWlVmm0lrv5dsKr2q3aSTG6K6Nje+2XhxeTOYCAw
         u+nNdYX6qhojp0CD1kQ0dMSrTbGpxyYtY3JGlzrY03vorRA32w5/10Itwfyq0GRNKG+E
         OEtYWASYvjA+W1GXCQv19HKxn6jG8HTpdtOzw419gt9mCkUVKBujLG247H+SNf1ShcHV
         IMZ7PgB8vYV3UB9K9rKNJTvy+ZDSJW/Z6IG9Sa+TsSF4unA1WpRWIRqCx6qzW6WNgzDV
         Kttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VcXMYRd9nvU6wwq0JZM21t9w6xo2utk/CM5bkqi1t0Q=;
        b=N9K49zLmTPk7B4yGQgS9roPx8Jxpa5VEvFM+Y6wVJ6uBSP0PXciUy/KtT+jf5ctQjo
         IPdS5vAJUDEs+U1YwLMHjaWTQYi90D9unBGRpN9pbhUPSSm89IjJ0gtBjQErZwB4kQ2X
         PgmwPoHlsTpeXVA8DWsBvoQh/vWVyxRrIMGv4/3nCeRuDJr9hGccMwdvWm2MIU4nrwDU
         NaITbYSIZQuAT7E1KpMasQ28wtRv3OBSi9kdUAXHEG4Wg3DFTatzv3wQCAeA8mLt7zhd
         TzxjD+0LO4UvuaO53rx4W+9Bv2+omhBkyEnIfkIGyjCgqfyxMIcnz/+13vETwgNTYwYE
         X1HA==
X-Gm-Message-State: AOAM5310IVE/JKQ3Eu8G/4c7uAO5l26zFE5BfNAAr2ZbDCO6jYDyoRAu
        8V4cdxdFijYpm3SaHXjiHrE=
X-Google-Smtp-Source: ABdhPJx5Lyiaze7X5x6rEgdEsNm08hTFIL56leW7p/EvLMH+WRTo9sI+PJMQJH60z/9Hbju/7W48Dg==
X-Received: by 2002:a7b:cb8b:: with SMTP id m11mr5697035wmi.5.1643172605083;
        Tue, 25 Jan 2022 20:50:05 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n15sm2171342wmr.26.2022.01.25.20.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:50:04 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/3] arm64: dts: meson-g12: drop BL32 region from SEI510/SEI610
Date:   Wed, 26 Jan 2022 04:49:54 +0000
Message-Id: <20220126044954.19069-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126044954.19069-1-christianshewitt@gmail.com>
References: <20220126044954.19069-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BL32/TEE reserved-memory region is now inherited from the common
family dtsi (meson-g12-common) so we can drop it from board files.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 8 --------
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts  | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index d8838dde0f0f..4fb31c2ba31c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -157,14 +157,6 @@
 		regulator-always-on;
 	};
 
-	reserved-memory {
-		/* TEE Reserved Memory */
-		bl32_reserved: bl32@5000000 {
-			reg = <0x0 0x05300000 0x0 0x2000000>;
-			no-map;
-		};
-	};
-
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 427475846fc7..a5d79f2f7c19 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -203,14 +203,6 @@
 		regulator-always-on;
 	};
 
-	reserved-memory {
-		/* TEE Reserved Memory */
-		bl32_reserved: bl32@5000000 {
-			reg = <0x0 0x05300000 0x0 0x2000000>;
-			no-map;
-		};
-	};
-
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
-- 
2.17.1

