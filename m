Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8B4A7605
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbiBBQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbiBBQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:35:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77FC06173B;
        Wed,  2 Feb 2022 08:35:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c24so43714746edy.4;
        Wed, 02 Feb 2022 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rolQc+QeV6/sWeHuoVWITOz2rFwUTuSxmkxEOlEseaw=;
        b=gejAnHy0niTm6ryHaBOrZMXupGOWpng/HKnLZPpUJD3zqobwsXOV17Xmtf8tHZmTMN
         xGAbwZyLrwMhQzrkKAURJiWApWMWHARvmXtDPhGo7qPHz8P2j9m7z2GWyzu5BPeCwyC9
         bxIt6uEK1Kk3Kv+FfwmS+Crusw/Yo9yuCaNGQvAsht54CChxrnR7+3e35bQxWudnEo30
         qGLh/kc0eLnyylMr8o8GPgkU+SvMuJHCAc/Dl95J2gvItadkKaTVK/rqcP8lT3NoCPuE
         ZMPgUV1H6zJhh06PUdyGuExmRkc/T/wZJ4meGgY5JjodFvb8rUisCn2Opj9gqQaF/NEN
         4vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rolQc+QeV6/sWeHuoVWITOz2rFwUTuSxmkxEOlEseaw=;
        b=Ecp23G3fEHC4stZVyJgv+tIoQlYCEIdNhjhgAZJXuUoE4o09v1CsLfbXYoXdrItf9Q
         cw0ZAdeBIKlpKvvPySLTj0WRfw5JATGbm9t8shrcRS1SCiCl5JGWFYlqe2gmcNKBJhk2
         fgTCgw67q5RC0UvivkaWcNBda2lZ0thFD/rCJwF3CVNFYMREy78M7Lxoqts8n+3a87Qy
         7Pk1lJZcZ1AXKHC5fw5lNLX2WewGd3AGfpktWUb5ozvyHxX8bAy3gTMHfwUaq+lFkH1X
         0RBLgWzevzMV4Doi7Kw9YGGFcpe4JCwqXI9My7VIu8wnR930e7PEy0PMWPR8ZZd2WS64
         Pmwg==
X-Gm-Message-State: AOAM5317OqonlE2cosIs7F31FkOwSa4ilTCyZVoSgR6u6248k3L+9uzN
        FuDafwvn7BbVeSzGnYadSPY=
X-Google-Smtp-Source: ABdhPJwFlGZfn+kMbwxHye6FyfkNQU+NCfAvvYTMvd0GGVS3QiH5QHxa4gtDRQtgqtohXSLx3IsWCw==
X-Received: by 2002:aa7:d913:: with SMTP id a19mr30936284edr.123.1643819752031;
        Wed, 02 Feb 2022 08:35:52 -0800 (PST)
Received: from adroid (027-177-184-091.ip-addr.vsenet.de. [91.184.177.27])
        by smtp.gmail.com with ESMTPSA id lc22sm15806551ejc.76.2022.02.02.08.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 08:35:51 -0800 (PST)
From:   =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
Subject: [PATCH 1/3] ARM: dts: exynos: add smb347 charger to p4note
Date:   Wed,  2 Feb 2022 17:34:12 +0100
Message-Id: <5d15937b6a7c4ae82a8f0d164fa28a4d4ad46325.1643757744.git.martin.juecker@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree entry to support the Summit SMB347 charger which is
built into the p4note devices.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
 arch/arm/boot/dts/exynos4412-p4note.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index b386a9b8e188..63459db653ea 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/samsung.h>
+#include <dt-bindings/power/summit,smb347-charger.h>
 
 / {
 	compatible = "samsung,p4note", "samsung,exynos4412", "samsung,exynos4";
@@ -182,6 +183,27 @@ stmpe_adc {
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
+		charger@6 {
+			compatible = "summit,smb347";
+			reg = <0x6>;
+			summit,enable-usb-charging;
+			summit,enable-charge-control = <SMB3XX_CHG_ENABLE_SW>;
+			summit,fast-voltage-threshold-microvolt = <2600000>;
+			summit,chip-temperature-threshold-celsius = <130>;
+			summit,usb-current-limit-microamp = <1800000>;
+		};
+	};
+
 };
 
 &adc {
-- 
2.25.1

