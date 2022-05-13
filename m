Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DFC525A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376811AbiEMDfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376804AbiEMDfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:35:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4229228C9FF;
        Thu, 12 May 2022 20:35:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i17so6735356pla.10;
        Thu, 12 May 2022 20:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbCROyekNSS6r922VIpU9j52qiNMPCsXY7vyKjWup7s=;
        b=n1gdkpQJYWsQX/eNyIr99178nRxAREb6VAKPEq8l2QMwpSJHqM7MivzutUl80J6+04
         FOMOtYXiKXIPsDwEa50HN6WEa2ztKz4Qtgw358e9I10CqXuOnYHp/GwbNBVHvDhq4qST
         uPTuT8SJR2hVTLws1k6ks+BWsSFWY2fK4Cj0BcC3ft41atrlo4MHgxrHKC6cclDxp/v/
         gmQ9ICDqRbUykCBJracaVnB/x5TiAMAODAQVJSeOpwxL3R0XUQ8LWRyQI1XHHqWbFWSv
         zVlZv6Pz2J93o/SkV7pqiGrsOAX/jPpbRpPjiSpm9kNOoN3RIAx52/1KmHnsEhZRHQZJ
         R5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbCROyekNSS6r922VIpU9j52qiNMPCsXY7vyKjWup7s=;
        b=J4NAo/5m1gru5W96YYr0DYPFxWRZe7ZIWF75JvA33rm6w0ppT3Hihrcq1pmagHpBvj
         viZHhFKAFLARtDIIxlLt7WRstz8Qx2xks4rw/3A2BagBYNvPwTXiF+jOkPw1T2BCTrM4
         a7rkWTMC14SD+sJRS8s/ZCiAtIcwomDC5e9UUwQjTVorbJQnuzDEiIYxd7kwMkcpRyuc
         lJNbAfmF+W7hWedV9dAkby2gJPQOnX2fRZ9CgAzr1RmnQ/4t3BF2AWJT2z9jZuB3uqJ2
         4RA1FsTIgcO3V4/3ekeIn2NrszGl9WJ7EgMKQWpf4m+iwl+n7lUPRs+UgJeVCF7v533X
         MGJQ==
X-Gm-Message-State: AOAM531DPN2aj8wm2l0MJkqljCkoriftRUgz6FiIyp0+OdbqUVwBSB5b
        YJaQJXdPPngS/5b6eTFs3CU=
X-Google-Smtp-Source: ABdhPJx6A2fGWgDLxcD7QRm9iBmw5wSkeClt8vmV+fJ5TamKnVvIkXvDrs1imi7Y2Y3z5VQ+fxDKtA==
X-Received: by 2002:a17:903:290:b0:15c:1c87:e66c with SMTP id j16-20020a170903029000b0015c1c87e66cmr2797661plr.61.1652412936727;
        Thu, 12 May 2022 20:35:36 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0015e8d4eb1c7sm685133plm.17.2022.05.12.20.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 20:35:30 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
X-Google-Original-From: Marvin Lin <kflin@nuvoton.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: [PATCH v2 1/5] arm: dts: Add node for NPCM Video Capture/Encode Engine
Date:   Fri, 13 May 2022 11:34:46 +0800
Message-Id: <20220513033450.7038-2-kflin@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513033450.7038-1-kflin@nuvoton.com>
References: <20220513033450.7038-1-kflin@nuvoton.com>
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
Compression Engine (ECE) present on Nuvoton NPCM SoCs.

Signed-off-by: Marvin Lin <kflin@nuvoton.com>
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

