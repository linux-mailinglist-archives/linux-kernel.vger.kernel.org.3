Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520784913B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbiARBjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbiARBi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC70C061746;
        Mon, 17 Jan 2022 17:38:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g22so26383520edu.1;
        Mon, 17 Jan 2022 17:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q0OwDpW3SXPApRGgUCRLy02IG26qd83+5ZiAXOatBVA=;
        b=MKOdLShuRGVbD5BKRp071h0YKY1MHoAfeZVSxJSnSd6YAjlh/7PTD2uI6CBN8jLMr6
         aGrw+ujmK6R2C6nz+zXVmfkLiEaWCyitk345fXlfLalS+fRJ/5kplegb5OoBU8Rv9Gct
         afGlIelR8+8kYpfhvmvmdvtE3DyAjADOG3tRc5YrP3MyPVJo2WnDcAip9cPqBiBzmBPm
         w+hcC0PfsIYb8Xc6oQComPR1kuuGHtV75fGVFdqPIkmaRtVkpIhdBggzcjGsqAEJ5lam
         y+nseGFQI9/47NWJ68nh4e7a+/7GmZsX1ERqVAYxw/typ83K/tVG0RSwqCMVvio0xlDI
         ojqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0OwDpW3SXPApRGgUCRLy02IG26qd83+5ZiAXOatBVA=;
        b=EnPZIN/q9m+Ps1yYmYfnLyy52qYqBx36CTeKn/MBgYqsghtIuXN69AaHNjWamVZMbU
         xFz40tIneBZC3+zSdeWsU7GP/Ww1oJd2XnBx7aqaYNtzCkpgfSf63YMjrMp7E78CXOdD
         Iu3jmD+xkQJf3O2jXNTAlJSsWHCOf5WYblJz7f2+jf3pmeqdDwFA+f8oisveQJCDuey0
         i8VZZJ8NWfphz2b+a0oZy1HT6+APCyjtqH4nWOTangbXWAI5V7yLtmeR8BieEFw62tP+
         9OmR1FBlMwn7/fZ9D6vKkFLMPGA2Hj6n87iASOsLOB8s2WDAkV1v40IxsHwQTrFpXUrB
         n5Qw==
X-Gm-Message-State: AOAM5324jw31CseQfeaO9wlzf1WT4hDhfFRdKNCqGmT6lYP0BO+2gr08
        33/f/cHO2OBbmTorkD2bWPi/Ix1hXY0=
X-Google-Smtp-Source: ABdhPJy3m0RSeaycTthCG4othqvD4xbKhH9Xc/ml83TUSPjn1q+tn4HE+5oyYo1XRLvUFRmLWBpr2Q==
X-Received: by 2002:a05:6402:40c1:: with SMTP id z1mr11250724edb.13.1642469905771;
        Mon, 17 Jan 2022 17:38:25 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:25 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 15/17] ARM: dts: qcom: remove redundant binding from ipq8064 rb3011 dts
Date:   Tue, 18 Jan 2022 02:20:48 +0100
Message-Id: <20220118012051.21691-19-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mdio0_pins are now declared in ipq8064 dtsi. Usb phy are enabled by
default.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 596d129d4a95..d495b81b587b 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -255,10 +255,6 @@ &gsbi7_serial {
 	status = "okay";
 };
 
-&hs_phy_1 {
-	status = "okay";
-};
-
 &nand {
 	status = "okay";
 
@@ -305,15 +301,6 @@ mux {
 		};
 	};
 
-	mdio0_pins: mdio0_pins {
-		mux {
-			pins = "gpio0", "gpio1";
-			function = "gpio";
-			drive-strength = <8>;
-			bias-disable;
-		};
-	};
-
 	mdio1_pins: mdio1_pins {
 		mux {
 			pins = "gpio10", "gpio11";
@@ -354,10 +341,6 @@ mux {
 	};
 };
 
-&ss_phy_1 {
-	status = "okay";
-};
-
 &usb3_1 {
 	pinctrl-0 = <&usb1_pwr_en_pins>;
 	pinctrl-names = "default";
-- 
2.33.1

