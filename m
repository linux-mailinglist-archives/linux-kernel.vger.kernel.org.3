Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DCE4D5D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiCKIm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiCKImY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:42:24 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43431BA166;
        Fri, 11 Mar 2022 00:41:21 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id h2so3323029pfh.6;
        Fri, 11 Mar 2022 00:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLqx+cpswbXRaJQWL8k1lvJijI81uoOijIjOKiOB33s=;
        b=qVDMOLe/Tf6QBjkIYvzkyxTvQ0MHI11VqwIykRP5UiB1tqBtW38wwjpGgk/WmBlKkb
         kBKqziLXVZHZet6ALTshfADoYe1jSyBjbZIQXE4+hG0viWbKxxwYZ8N9Rm+lsozrhGG2
         kmD7mjTazJN9/0JUHMSBqBqey/KnqSoQqlODwvJ/Jgcc6SEGkPa8wcM8LmV6YJHjqMus
         NLdFFRDakywnC5uZc7ndM+W9MxvXkBcXUECoqdaMEdsJL2OVwSom/yeDxSn5NAvnGiyI
         NR9JE4icFVEZFWcis4bP10ScvXgbpiMh2gI7lxx1U1xp+LVyLfg5cFPdKGE4KOpt8Mmx
         3mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLqx+cpswbXRaJQWL8k1lvJijI81uoOijIjOKiOB33s=;
        b=m0tjTK7f+ZeOcHdbfeUgYacEgs/QgUULagEJDyZ+IOm+gPCMuphmNT6rDJnQC+eLC1
         H0jh2WEUcE4+rQxIpjOr8YGE7y3EOMIlenjlhJP3C02GLpEGC29WJxMbGbFXMrYAc4mS
         vCNe3imCNqNh0jgKai64KHGtsvpmtgaMjh3WLvPJWmycN/0ZQI8Tj/l3K1/J2dXCwSdS
         NECdFG1XxO8luqMZzsyeYun0h3rd0KXw+fsC5djotiZ+1E25QIrNHuEPxlmiUbbsUNXx
         kpx+ci/guyibpzfDY8VLrmwSzIKbGvX1l0p5S4dqtxyIEqJGEi3nbyWMbSmG8XVLjg05
         1GAw==
X-Gm-Message-State: AOAM533tbRJXyd7th/cT8eKq+87teim8sFN1Rq+0v/bCJIpucyOngFZr
        vSiMwJojfm41feeLwBmYgpSjUChhrmKkfA==
X-Google-Smtp-Source: ABdhPJzOutp4T4k5/Wpo3DYmvq4XO0WOg9QK4oHp+K4P3WHU2agjTWvllPfMbK3wm7cAJyj9Wv9wSA==
X-Received: by 2002:a63:82c1:0:b0:37c:9950:2fec with SMTP id w184-20020a6382c1000000b0037c99502fecmr7320950pgd.13.1646988081221;
        Fri, 11 Mar 2022 00:41:21 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id f7-20020a056a0022c700b004e11d3d0459sm10146467pfj.65.2022.03.11.00.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 00:41:20 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: bcm-cygnus: Update spi clock properties
Date:   Fri, 11 Mar 2022 14:11:14 +0530
Message-Id: <20220311084114.16408-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
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

PL022 binding require two clocks to be defined but broadcom cygnus
platform doesn't comply with bindings and define only one clock.

Update spi clocks and clocks-names property by adding appropriate clock
reference to make it compliant with bindings.

CC: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index ad65be871938..f9f79ed82518 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -397,8 +397,8 @@ spi0: spi@18028000 {
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-0 = <&spi_0>;
-			clocks = <&axi81_clk>;
-			clock-names = "apb_pclk";
+			clocks = <&axi81_clk>, <&axi81_clk>;
+			clock-names = "sspclk", "apb_pclk";
 			status = "disabled";
 		};
 
@@ -409,8 +409,8 @@ spi1: spi@18029000 {
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-0 = <&spi_1>;
-			clocks = <&axi81_clk>;
-			clock-names = "apb_pclk";
+			clocks = <&axi81_clk>, <&axi81_clk>;
+			clock-names = "sspclk", "apb_pclk";
 			status = "disabled";
 		};
 
@@ -421,8 +421,8 @@ spi2: spi@1802a000 {
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-0 = <&spi_2>;
-			clocks = <&axi81_clk>;
-			clock-names = "apb_pclk";
+			clocks = <&axi81_clk>, <&axi81_clk>;
+			clock-names = "sspclk", "apb_pclk";
 			status = "disabled";
 		};
 
-- 
2.25.1

