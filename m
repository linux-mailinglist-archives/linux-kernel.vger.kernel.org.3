Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396265A1EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbiHZCmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiHZCmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:42:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15E033A12;
        Thu, 25 Aug 2022 19:42:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o4so357945pjp.4;
        Thu, 25 Aug 2022 19:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=PLLLntBRKNP/TR5HdmPuN09W5k0TVn71VC7Vx2rA/LU=;
        b=RTt5GrnTfa7hAfcc/J07/2fvusNJYRSxZfYZ03xUL76cBwmkm6jNEHsFfryhZiBO/q
         tlfUOk7ecPNjEGZOzx3FzriuX062rEa55QsGlNGohENjf1Dm7IC30j7hLAOX4kYrjX1/
         ZkIEgaYvQWnRu7U/QBNC7zqH6CO8PSIgp4fm9vWCQMoXIi13jaP59CwYCBjY3eSli0xo
         22OTfiK0uOKhDhYJFMayZGaPdb75L4kx8j7qgp5FR0n+sQar5YOA2beDqE5OKwrQ6Qb8
         NebSkTsK9MaFX6NwcwZ2bJlJiaugoiDOxbjAUreOT5jmxWzw5moDvd6o1E1NOWBHlqTm
         fPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=PLLLntBRKNP/TR5HdmPuN09W5k0TVn71VC7Vx2rA/LU=;
        b=jUTT58ZsEdG85mSZsEZUBt6gqrd3olxh6ZzqvBy4exLgHSqskvN2JzSGsRoJ4PgK8Z
         EAWOykdXstkcbSm0at7tLQuMWATE/2oadbAGX4WF1rNxLALaP1f/8EdEdnLVCdExTEHJ
         fjWUar8FK3am1XgYrp4JNNoz7qJOlatyL2g8fDhYo2+9pL9vPDQcVQofMw/eb2JxSgNf
         9yueV71j5AZnxuLoabkj08QnrBDspwJQalhJ4cX46o+x6G0Nh41QbjltomT+b6BEWd54
         GACo3i9FndcDVRH+VllKYkWznTZFqAHTtvaaf4tX/kDbfIYL2vQi7iSYoVWJs5Ntm1ij
         8pcQ==
X-Gm-Message-State: ACgBeo3nIfaI2xG/DQiIL91ILs1EA+74Oh1+xvt3uF8VF4YBKB9fSI+8
        I0JrfS0jb73ZImUkSfxfGjg=
X-Google-Smtp-Source: AA6agR4jBxOUZXbSQmInIFfHedB8ThuUhiJs5/hLw7Em9GE6AS9ynfIU+JcuiLYWoBObxWNIcEJgTQ==
X-Received: by 2002:a17:902:f712:b0:171:29d0:6f9f with SMTP id h18-20020a170902f71200b0017129d06f9fmr1776297plo.84.1661481720267;
        Thu, 25 Aug 2022 19:42:00 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s34-20020a17090a69a500b001f021cdd73dsm444473pjj.10.2022.08.25.19.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 19:41:59 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v5 1/5] arm: dts: Add node for NPCM Video Capture/Encode Engine
Date:   Fri, 26 Aug 2022 10:41:20 +0800
Message-Id: <20220826024124.22747-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220826024124.22747-1-milkfafa@gmail.com>
References: <20220826024124.22747-1-milkfafa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for Video Capture/Differentiation Engine (VCD) and Encoding
Compression Engine (ECE) present on Nuvoton NPCM SoCs. Tested with Nuvoton
NPCM750 evaluation board.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index 3696980a3da1..0d2df74974bf 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -178,6 +178,19 @@
 			status = "disabled";
 		};
 
+		video: video@f0810000 {
+			compatible = "nuvoton,npcm750-video";
+			reg = <0xf0810000 0x10000>, <0xf0820000 0x2000>;
+			reg-names = "vcd", "ece";
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>,
+				 <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+			reset-names = "vcd", "ece";
+			nuvoton,syscon-gcr = <&gcr>;
+			nuvoton,syscon-gfxi = <&gfxi>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -553,6 +566,12 @@
 				pinctrl-0 = <&smb15_pins>;
 				status = "disabled";
 			};
+
+			gfxi: gfxi@e000 {
+				compatible = "nuvoton,npcm750-gfxi", "syscon",
+					     "simple-mfd";
+				reg = <0xe000 0x100>;
+			};
 		};
 	};
 
-- 
2.17.1

