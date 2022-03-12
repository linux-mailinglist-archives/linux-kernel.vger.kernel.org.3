Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1254D6E82
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiCLLkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiCLLkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:40:11 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2166D1F1D14;
        Sat, 12 Mar 2022 03:39:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso10397922pjo.5;
        Sat, 12 Mar 2022 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xig33dsAiLqK584XC74c3T1yCKsF3fWL7xuH/+RsxoM=;
        b=Y1vGRJny0Ixt948a/hrZ0jez5869rPoMygM6ZMmOuU853nH23SIMrtHX5LD5/qt1Ax
         P0TZmVKiNb2SiTfSi99ZcDKMQXi7ypTdCGaYILYRybww+sNCQtvWW91NudmmcgcmbtSC
         NKgu3pc3QrIzWIj5UXv8UD+EYAKJXtqnheja+kGVM7x/UpXNwndGYgQIsfTXXeSOqShk
         5J8skqZfUPbjT7yEIIVVUjVga4laXUHUCPkOzL5y8beSu7VtfpBhWPssCtGXV5Tr/DYj
         w9uaL3KoPZH3Xjx4DUQ9/HIN4YqdnpkpK37GwCNp9mjkKOwoj7N5SJqoVKtzTC1hkORv
         QZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xig33dsAiLqK584XC74c3T1yCKsF3fWL7xuH/+RsxoM=;
        b=twG/VU3bMxmzTjKpAz88E1S0GgLqG25GiMuzxEUfj4/uPbjA1lb0mdKkUSZhqhxudE
         rYKq+Jx0oMEKOxCK1JX9SrjTd2prwUEhEI7Bd9wPVqrGadI0U0jsBzpyVbue+1Eim1mR
         uUJM0gT/wZjvAa3VqXovVElMXCPE8Aq/tGgygLu7/OYTgtLeed1YpHX3gvN17pS+bXzZ
         O8RdeJGOgqrpT/hj7VtmMMU2Y/v+s79EFY9HdzBIt1+oLf9g9ainm+dRBVhDqS675qZy
         Vn/TPGztEV3nhklyhkbvzB5raHsKPT+euHzUXg2kca8PNLjjlMKa7HWj3QsL0ZCVFMYO
         c73g==
X-Gm-Message-State: AOAM530nWvrfEXyrWxhdWLD5hEyJgLbtCoj/fxL/8xc+qOUyJ1/AzXZL
        so4VR85p+FaR5faXe7xWUcs=
X-Google-Smtp-Source: ABdhPJxL/0wBldiR8gDFU4UBUB6AE4e+t8vmgOuzyt9zqGDy3DC0d0bve5kMKpTBgzdPrqe1aEnFjg==
X-Received: by 2002:a17:90a:d3d3:b0:1bf:2e8d:3175 with SMTP id d19-20020a17090ad3d300b001bf2e8d3175mr15756754pjw.2.1647085145544;
        Sat, 12 Mar 2022 03:39:05 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00363a2533b17sm11065191pgc.8.2022.03.12.03.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 03:39:05 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] ARM: dts: realview: Update spi clock-names property
Date:   Sat, 12 Mar 2022 17:08:51 +0530
Message-Id: <20220312113853.63446-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
References: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that spi pl022 binding only accept "sspclk" as clock name, realview
platforms with "SSPCLK" clock name start raising dtbs_check warnings.
Make necessary changes to update this property in order to make it
compliant with binding.

clock-names:0: 'sspclk' was expected

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v3:
- Reword commit message

v2:
- Split patches as per platform

 arch/arm/boot/dts/arm-realview-eb.dtsi    | 2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts | 2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 2 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-eb.dtsi b/arch/arm/boot/dts/arm-realview-eb.dtsi
index 2dfb32bf9d48..fbb2258b451f 100644
--- a/arch/arm/boot/dts/arm-realview-eb.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb.dtsi
@@ -399,7 +399,7 @@ ssp: spi@1000d000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x1000d000 0x1000>;
 			clocks = <&sspclk>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		wdog: watchdog@10010000 {
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 06b8723b09eb..efed325af88d 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -410,7 +410,7 @@ pb1176_ssp: spi@1010b000 {
 			interrupt-parent = <&intc_dc1176>;
 			interrupts = <0 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&sspclk>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		pb1176_serial0: serial@1010c000 {
diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index 295aef448123..89103d54ecc1 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -555,7 +555,7 @@ spi@1000d000 {
 			interrupt-parent = <&intc_pb11mp>;
 			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&sspclk>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		watchdog@1000f000 {
diff --git a/arch/arm/boot/dts/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm-realview-pbx.dtsi
index 6f61f968d689..ec1507c5147c 100644
--- a/arch/arm/boot/dts/arm-realview-pbx.dtsi
+++ b/arch/arm/boot/dts/arm-realview-pbx.dtsi
@@ -390,7 +390,7 @@ ssp: spi@1000d000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x1000d000 0x1000>;
 			clocks = <&sspclk>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		wdog0: watchdog@1000f000 {
-- 
2.25.1

