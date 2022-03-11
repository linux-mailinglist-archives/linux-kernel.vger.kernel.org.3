Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB04D5B86
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbiCKGSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbiCKGSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:18:43 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCD552B3B;
        Thu, 10 Mar 2022 22:17:39 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o8so6666983pgf.9;
        Thu, 10 Mar 2022 22:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kQqw7tTt+yfVeLVpBIoJCXqGZMxXviWoufN/qt8xwd0=;
        b=ZoIVAwvxj2sYqN0VDOivFza7qxhW4lpJGmh5u/++SwtQhhYiTuPswWU2Ca7YBC2bHT
         28P5dsZIXurAcjFMWbxXNqmPHkaPGUWjSMB5glQho/JoXGrfwfrEJ+h6W+DKH8jcGSXv
         1PFKtkWSYanjLP39p52gYkPwGFt7MGerBMUWaHV1gW3fpwmtN1JNDFb3pnrAmX1nYexb
         Zw9LGvFjh9bdOxuQMg4U3JCWTB6R/z7mgCBPPC1y31Fn5pjbdpcspNVx4vkuARdwUaQ8
         gIX4OvGb12b/vUQVLi/hqbs4K9IwsRt2Iga9m5ex+buHT+uIw4hVu8tJHi4ung7zS/Nu
         VVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kQqw7tTt+yfVeLVpBIoJCXqGZMxXviWoufN/qt8xwd0=;
        b=OJmOkwruzJLIehG/stPPAPcJa/eRin0N3SWcf1btFXbvixUD+XLP0QrWBoQzakfnnE
         Rwbvs+c7eAOYcaKMhHO4Xk2qR+bMFQBWwgsDarW1kB7We/1HhTDAcQ044sE32dKbNBK4
         VSDvk8Ds/TyUYyMOSc/byNFPS6DsGpW5+qxixHUKBWaOAfxZztSRrHTkH1s1cVdMYB2I
         QcWYnRcNwVEyx/XGmvrqQzLM7Ar6lW20cqrevrJC1pYLVhTdIe3DYlXiSvIi4g2wDy3J
         QPhMUxAXgw5EGuhmSKWo/AfqvrkihF5mTtB8DWq3R+rrmvxXkXAL8R1bZvgRRXGGpsvd
         XDCQ==
X-Gm-Message-State: AOAM5339j2eB+GG5M3vUoQML04X9fM3O299SRK3+4r5IsWSRT19poU6R
        ODS4DgXwDHjEH5/V7LztR/s=
X-Google-Smtp-Source: ABdhPJxnk1FATJe0oNRePPbbVf+GZMCM0mYjz3niQ17X5pIinsD+fFnbRH7sE0Gunr4Euqpe6F91Rw==
X-Received: by 2002:a65:57c9:0:b0:375:7489:1bac with SMTP id q9-20020a6557c9000000b0037574891bacmr7118940pgr.349.1646979459493;
        Thu, 10 Mar 2022 22:17:39 -0800 (PST)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a0010d400b004f7093700c4sm9101764pfu.76.2022.03.10.22.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 22:17:39 -0800 (PST)
From:   jimliu2 <jim.t90615@gmail.com>
X-Google-Original-From: jimliu2 <JJLIU0@nuvoton.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, jim.t90615@gmail.com,
        CTCCHIEN@nuvoton.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v1 1/3] dts: add Nuvoton sgpio feature
Date:   Fri, 11 Mar 2022 14:09:34 +0800
Message-Id: <20220311060936.10663-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220311060936.10663-1-JJLIU0@nuvoton.com>
References: <20220311060936.10663-1-JJLIU0@nuvoton.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add Nuvoton sgpio feature

Signed-off-by: jimliu2 <JJLIU0@nuvoton.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index 3696980a3da1..58f4b463c745 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -329,6 +329,36 @@
 				status = "disabled";
 			};
 
+			sgpio1: sgpio@101000 {
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				compatible = "nuvoton,npcm750-sgpio";
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox1_pins>;
+				bus-frequency = <16000000>;
+				nin_gpios = <64>;
+				nout_gpios = <64>;
+				reg = <0x101000 0x200>;
+				status = "disabled";
+			};
+
+			sgpio2: sgpio@102000 {
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				compatible = "nuvoton,npcm750-sgpio";
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox2_pins>;
+				bus-frequency = <16000000>;
+				nin_gpios = <64>;
+				nout_gpios = <64>;
+				reg = <0x102000 0x200>;
+				status = "disabled";
+			};
+
 			pwm_fan: pwm-fan-controller@103000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.17.1

