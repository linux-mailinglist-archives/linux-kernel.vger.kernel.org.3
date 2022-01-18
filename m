Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79964913B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiARBjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbiARBi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB73C061746;
        Mon, 17 Jan 2022 17:38:25 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f21so15809421eds.11;
        Mon, 17 Jan 2022 17:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q0OwDpW3SXPApRGgUCRLy02IG26qd83+5ZiAXOatBVA=;
        b=Sx4tP2lIsrC3FSrqq+aRf3l4O/x66Ky3Lp8uOzU+vgd8vz71ZOUMgvr5UBxlaySELC
         tlIlSfh1iLwYDtcW9hG0EZ2ODvfGvvw5Hy22Xp6PXpUCFWkDwtyhjTnyi2i4EztdZXRg
         6LoHFkO6osuP7KXPxfnm/D+noS1VgzFNcoFRLDRmugFpLWcI1OGm5g+HBPO8moI/9ouy
         9GD8Q6f2x8BYin0T+XY9U8fnBsuBWY5mfPmYXgl6WKNhHW7Tj8eU7Yu5ODwfU/jsdSfT
         vwkAoYp0tStQqDGCPyD+iobTBzwXnEGGFRxvnl2gx89KbrXZSqS0mNlpuDjJyCFnaNkh
         tVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0OwDpW3SXPApRGgUCRLy02IG26qd83+5ZiAXOatBVA=;
        b=5ppx2pzYIBS43s8Eb5aehWnypPxVbH5vOgYX9+FZ/8hLBY4NY/6gEoeGHmR6zUp06F
         GKR70GSJWIXBe+A4SMGPWfaNses3SfvVLRkcxlmCO/YseX4dgfH50eG+gzrj9b5MXTD3
         I5pYJXGouYso2A29k22jemG4XbYoEnslcmv4sZPqVK+WO/T3loa7LyNDldOSvfX+rVHz
         zA8DDNOAtUcgZO2rv0LLkhR90ATaQMDpqx55PF1/VBfgTPsLZPr1XddziHfZ828lV5Pl
         hYuwdD6vNFrv3PkK1PDmKA6Dhtg4UcI8c3IKp3A2F0O88nthF9kM6DxEqdRxsjMLXjbM
         f5+A==
X-Gm-Message-State: AOAM530rvkiy7tWOsCJQ73yZb59Ahv+7K0Sykt2+IZGTXXfmSPMHPILG
        OR482W7XVP/YSIAdhITqYwj9zKz3YM4=
X-Google-Smtp-Source: ABdhPJxHDqK2bfbP5/1Et0TUTldtTYEaliiLmjOKBIsOsVrKJ0MEr1RCPuNomdCq6cOHDqWKHSC3OQ==
X-Received: by 2002:a05:6402:502:: with SMTP id m2mr21920012edv.273.1642469904094;
        Mon, 17 Jan 2022 17:38:24 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:23 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 14/16] ARM: dts: qcom: remove redundant binding from ipq8064 rb3011 dts
Date:   Tue, 18 Jan 2022 02:20:46 +0100
Message-Id: <20220118012051.21691-17-ansuelsmth@gmail.com>
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

