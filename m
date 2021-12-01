Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82E46554F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352372AbhLAS01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352328AbhLASZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:25:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3EFC061574;
        Wed,  1 Dec 2021 10:21:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so1818989wms.3;
        Wed, 01 Dec 2021 10:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0znfekrUInn5HV1vA+VAV/rcSYZjyQOcwwYpPx9vb0c=;
        b=qQm5NiCFVGKxg2ccCKmwp5W8k1nsd/J2wfjXDa8iUyIz0D67VPHMn0pI11aUE/QPmK
         Dc44HdjJw7MQFOxEAD6mqoB8XVSN3cR9TJjneDBDecLsVYuV4IWSV4v9pmfOKsUHGk/0
         d9UK+D17jD10gEKT1ifKjKeQgBAhquZMnwctWq+sEyxn2+LkOp7VV41AFmVRsrFM8dfN
         6ASlyuAX6BoxZMSMjwiv0jW34bvFbnCqofmmgcVpvcLFQXGvwat5LnQ6eH8wlWOYnvLq
         33ReiiWIiXS1NAASeIH8wP47Ri610zHLGoJ05pKDkOvOZaIdNpQDc+sd1rqfDxNDhav6
         dnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0znfekrUInn5HV1vA+VAV/rcSYZjyQOcwwYpPx9vb0c=;
        b=un//GraZA0OyZmav4X39GbpYBixLVEH12e0Qp7ZydaPuu9TW1CPozK9o4ky+sbLyt3
         yfqDRBst4NX60K8W2HonFIMY6q1PgPn8thssHV3IbyK4LN/beBSMyis3xV872gNPDMOB
         fS+vEqI9wdE483Jnnhkv3f38Ugw0VD0K/vvjY7qOq+P/2Iy8IPsAiJmAGst5t28hxieI
         mdyJRcoILPO+c5OYnNBfQvOo0hgjme0gP2FwEpcPJmJqAa8cM1tEPn9Wz9Ls27gD+Iqm
         EdHoYldKHCTix+eDyYE567oAXfbvUXXcZYIUc2KasVbcsPN8G2Ax3lAmABass+2dLr22
         2wKg==
X-Gm-Message-State: AOAM531QOm4uwTTnsk6Bez7uo2okpIhZkAZhDG6ksAlBgtnY3XqxZMRc
        EQWoEF2Fk4M4Q7F2NpegW0Y=
X-Google-Smtp-Source: ABdhPJzrKzPCMz5gik93CwtDXbaqyj6tOPCbkZhxB4yRL/zcWPPLgGW8dLsEpVoOv7BFWWTNZI5qIA==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr9069048wme.182.1638382913573;
        Wed, 01 Dec 2021 10:21:53 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id f7sm604705wri.74.2021.12.01.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:21:53 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 5/5] arm64: dts: allwinner: h6: tanix-tx6: Enable bluetooth
Date:   Wed,  1 Dec 2021 19:21:18 +0100
Message-Id: <20211201182118.1213806-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
References: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 comes either with RTL8822BS or RTL8822CS wifi+bt combo module.
Wifi part is already enabled in tanix DTSI. Let's enable also bluetooth.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index a6e69f4b2666..9a38ff9b3fc7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -13,3 +13,17 @@ / {
 &r_ir {
 	linux,rc-map-name = "rc-tanix-tx5max";
 };
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8822cs-bt";
+		device-wake-gpios = <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
+		host-wake-gpios = <&r_pio 1 1 GPIO_ACTIVE_HIGH>; /* PM1 */
+		enable-gpios = <&r_pio 1 4 GPIO_ACTIVE_HIGH>; /* PM4 */
+	};
+};
-- 
2.34.1

