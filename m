Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6025C4A760B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345935AbiBBQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbiBBQgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:36:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42C4C061714;
        Wed,  2 Feb 2022 08:36:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r10so43592773edt.1;
        Wed, 02 Feb 2022 08:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9ViQKjdafpkt5ic07P4h3uUAndSyjNg2nRx9QigItQ=;
        b=Be99NaueJJ3OFKHNUAkGtQHsLLLV1C9MYXtI+GcXNjbfpd2dnLisNdYi/5F4VAyRcT
         UyYGHmePZQm7BUKOI2OJDPusJ5kKN2piZ3LS7WKquPRWgqMfts8Mh+yytf0grWf5ISzc
         qrBzI8kcHSZ22j1GDogU2xseaUwb+h/c6MxEzvtftxmP20NgkhdIzSVuPYB5r0Zfwlg/
         oenvuIVuFkUl+j/+qjk7b93qECEWHGfSQhH/xssrenUasvHIDhbsZxYa0Vi56Ap4KX30
         SV5MSKDftOjZtea8S/L6yGWp44yCWJp4eotPu/1egpzE171jShYZSy0KjmVBfFYmRnlQ
         Txfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9ViQKjdafpkt5ic07P4h3uUAndSyjNg2nRx9QigItQ=;
        b=HT3mXDed7TPhCaXlyHJlSPAn3RAxAt7JuiaGTp5u011ydpkT08mMF4PglPo++Ggmjs
         SPFyPfgmcK0ENudMOt4dX8fvSrB1+Cd9LpQ8RdXHmNbFW2ptr9iMBgXoLo+xfj71G7RO
         F975Z6o4YL7VtLrcvYwHmo07eGg74TPxeKkZ1Wom3SazeSerxH8/tQL/lKW9apIZndqL
         tzLY3VmR5Li1iT/0Ed+brXZTEbyTcUzqqHE+DG9ZZxYQBft9gubizDq673hHExsCNS8r
         AGgs2obIvxyu+Wot62Jjk5D5XBOmokxqHkhjTEdXgWKZqvpMqHcu9vgOtOyahVNy4t63
         lA7Q==
X-Gm-Message-State: AOAM531MLl5FpBy3Wd9qMzirnEauN2D/Nu5Wthrl3s7gME4in7XfMBpW
        HPI1e/0ZCX7MZ0Oro4IIMGc=
X-Google-Smtp-Source: ABdhPJztGAeJV1pm9NWNjCRXMHxJfQvPEe+ZkAbMQvG6Gfb9slpHWl8MomEUWSu0fppuORMglpJ3ew==
X-Received: by 2002:aa7:c5cf:: with SMTP id h15mr30714614eds.352.1643819793925;
        Wed, 02 Feb 2022 08:36:33 -0800 (PST)
Received: from adroid (027-177-184-091.ip-addr.vsenet.de. [91.184.177.27])
        by smtp.gmail.com with ESMTPSA id a7sm21334313edr.34.2022.02.02.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 08:36:33 -0800 (PST)
From:   =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
Subject: [PATCH 2/3] ARM: dts: exynos: add simple battery to p4note
Date:   Wed,  2 Feb 2022 17:34:14 +0100
Message-Id: <9436c417fc542eaa74011046369e089a68eea39e.1643757744.git.martin.juecker@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5d15937b6a7c4ae82a8f0d164fa28a4d4ad46325.1643757744.git.martin.juecker@gmail.com>
References: <5d15937b6a7c4ae82a8f0d164fa28a4d4ad46325.1643757744.git.martin.juecker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple battery node to the p4note device tree to set the missing
values for the charger to work properly.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
 arch/arm/boot/dts/exynos4412-p4note.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 63459db653ea..fcd75cceb877 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -115,6 +115,17 @@ wlan_pwrseq: sdhci3-pwrseq {
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
@@ -193,7 +204,7 @@ i2c-gpio-4 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		charger@6 {
+		power_supply: charger@6 {
 			compatible = "summit,smb347";
 			reg = <0x6>;
 			summit,enable-usb-charging;
@@ -201,6 +212,8 @@ charger@6 {
 			summit,fast-voltage-threshold-microvolt = <2600000>;
 			summit,chip-temperature-threshold-celsius = <130>;
 			summit,usb-current-limit-microamp = <1800000>;
+
+			monitored-battery = <&battery_cell>;
 		};
 	};
 
-- 
2.25.1

