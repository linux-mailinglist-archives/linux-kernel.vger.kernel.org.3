Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2864D5FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiCKKhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348033AbiCKKhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:37:48 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6A51BD9B3;
        Fri, 11 Mar 2022 02:36:45 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so7808960pju.2;
        Fri, 11 Mar 2022 02:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAMK60NpXBR6+l2gJDXA4dYn6ytQdSs95lYsdU91qdc=;
        b=hNUZha6su5Akxd4J6xRAOzOC5RSl2rpxo08ZxvniE3Ub9Wi6zBuPAoGwZdkazOtiua
         lsJX9FWG8bGLIy4nre+e5cPodMENaYbCkqGmPLO4+vVyAYAQrclyy8T0NshlNFxrV8mn
         ijsGkQBfw/jsY0Eivb0w1ERhtUms+4/IhchOwP2x9UGDinwL5o1F9tR9OwlAzTTmdR0J
         inAWX7s0KxsldYwmWBImh9N7vKb3M/oMeBEIsJtElm9ATFYG44tDVfrXsh80ZFyACl7R
         bcp3Axlz88tuoSDrbH0FBmTP7GnrJHJrBIhGb63oXfJnN2vi9BvOIMcanbasYJd4hgiH
         PbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAMK60NpXBR6+l2gJDXA4dYn6ytQdSs95lYsdU91qdc=;
        b=QIuZNr37wjbEIkdD4PMNc8BaZ6IQHobACQOUfbFKwKwovMMWwpgxFbl6QkQhuDVf/1
         XjKYAsqxCxagnDHqlmbbdWVZn4kyZc3QuYA6UFPRdpM7ECLPPMXu1baylw9DeN/leeyH
         DUq30v3LIq5a38q3vZ7ZyjJLiJ6OQzKSAebhbQQBUr5Rbr8NksadKMGT+HqKBIu3fm3C
         FYqdiymSSHNYUb276M9rmIZd72wOEgnVXvqjYyXlvp/galBmgiWP8OQoMCDJQRQr9msZ
         asxK28cdPOvWC0OnP/I0sFiNSRF47MMwm6eg7Fr1NNMOIlFNrJqznVfCwEG+wCiJn9D/
         7bVw==
X-Gm-Message-State: AOAM531+21rk/qloJoGasL6vt0/PJ+17XSCc29FwcduXptxqyfJ1qcbE
        6Pg5FpKk9LFnAwApV6vs1nq94FOPY61JbQ==
X-Google-Smtp-Source: ABdhPJzDReZVvXo0j5Pdcpa5ZqltnvRLEJIlccvtB1l3yK4H2Wg9VX4KZAYGjOycmYLrYpG4Qbod/A==
X-Received: by 2002:a17:90b:4a8d:b0:1bf:a379:938c with SMTP id lp13-20020a17090b4a8d00b001bfa379938cmr16116265pjb.129.1646995005289;
        Fri, 11 Mar 2022 02:36:45 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm4445892pgo.6.2022.03.11.02.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 02:36:45 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: realview: Update spi clock name
Date:   Fri, 11 Mar 2022 16:06:33 +0530
Message-Id: <20220311103635.39849-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
References: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
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

SPI clock for pl022 is "sspclk" and meanwhile ARM realview platforms
specify "SSPCLK" as clock name. Even though binding check don't
differentiate the two names, better to keep same convention throughout
i.e sspclk to align with other platforms.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v2:
- Separate out patches for various platforms
- Rebase to top

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

