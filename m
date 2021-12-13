Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A632D4722A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhLMI1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhLMI1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:27:23 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EFEC061A32
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:27:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r11so48768671edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BYKQNnBxeHaOMAkWkceoLRaeZrdXyLl7SHClr7Sqxk=;
        b=Hq3C61iAmdQv+LNC1AUhY1ev2O8uu6aIwKNgRci27s0lc2qRBEalj9zuHDHvCQiR7a
         dJ9N96miaRNMK91droldq7/LP7Ges/sqAQDjqgpQava9KVYirq2o+ZmTCf1x9S1zMFIy
         hbqxMnVuS3LqPPR+Ivb4fjYHzstP7M0qW7UJAgKZyFSpgeR2XbqLIKtm9iTCpOaEj4nQ
         veDho0E/IJO6eB68srJxhg9SEYWdqiTVBdyYJ+LgaWkSx/AX6NBxTW6ydG4y1bGz3d6O
         PDs+QM+dXnytMw1NKqosz6VYIIFP2UE0Ml35PnfcGrDXEirvJqzERF5ZyXKgiOldyCob
         lzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BYKQNnBxeHaOMAkWkceoLRaeZrdXyLl7SHClr7Sqxk=;
        b=oTvdlNytCbaWgZ0o6ywlpeMxmJqmSiMP3j2tpLyPoDWHjO1olo6sQ1A/ymUJ3VJ4+p
         0UJDIqAei9xddF5HtO8swVu7nmuKtjmyiONqJRUVNsICgrtzPbihSykrt4VmY00Cl3Tp
         eMA+SXt+Q/NfkO7nPu2fJRnJAmvZtbPEwvhsiM8/TIgQZmdJr7NfJHdWQFV9x35njmHC
         eiktHzyox93Mu7OdPNtp2fy9XRWlgNt5nWI8zyUeIkK6wNa4jzYZtPhPOB2mDiO+3lGt
         iSTj+iSg3NOrTPI7DWxBKiELK5t9Oxh7pFQzkC6ZDSgM1jK+t8Luq4hSJqIGK8KSd1N/
         vg7w==
X-Gm-Message-State: AOAM533WUhmLA6d8dw9MuMWK+Q8/W38bwJUNFzly98RlADyMETvae5Me
        FUmpF1thw5Me4BmA0fWDdxxjTA==
X-Google-Smtp-Source: ABdhPJwLX/+1Jcch7hkL40o+jVQ/y6C/s5+Hbm7xBmKf82rj6DI695dxIsJcF9Hw676mSrMHOLg0+Q==
X-Received: by 2002:a17:906:478e:: with SMTP id cw14mr42790527ejc.46.1639384041936;
        Mon, 13 Dec 2021 00:27:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id b11sm6062432ede.62.2021.12.13.00.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 00:27:21 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] arm64: dts: qcom: sm6350: Fix validation errors
Date:   Mon, 13 Dec 2021 09:26:11 +0100
Message-Id: <20211213082614.22651-11-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213082614.22651-1-luca.weiss@fairphone.com>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort clocks and interrupts as specified in the docs and remove the stray
property #power-domain-cells from aoss_qmp to solve dtbs_check
validation errors.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index a7158fe9e192..8322a981cdfc 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -810,10 +810,10 @@ usb_1_qmpphy: phy@88e9000 {
 			ranges;
 
 			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&xo_board>,
 				 <&rpmhcc RPMH_QLINK_CLK>,
-				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
-				 <&xo_board>;
-			clock-names = "aux", "ref", "com_aux", "cfg_ahb";
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
 
 			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
 				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
@@ -871,11 +871,12 @@ usb_1: usb@a6f8800 {
 				      "sleep";
 
 			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
-					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
-					  "dm_hs_phy_irq", "ss_phy_irq";
+					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>;
+
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
 
@@ -935,7 +936,6 @@ aoss_qmp: power-controller@c300000 {
 			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
 
 			#clock-cells = <0>;
-			#power-domain-cells = <1>;
 		};
 
 		spmi_bus: spmi@c440000 {
-- 
2.34.1

