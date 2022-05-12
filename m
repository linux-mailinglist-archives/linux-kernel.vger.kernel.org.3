Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61395246E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350987AbiELH1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350964AbiELH1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:27:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3226C12FEC8;
        Thu, 12 May 2022 00:27:39 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x8so419006pgr.4;
        Thu, 12 May 2022 00:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbCROyekNSS6r922VIpU9j52qiNMPCsXY7vyKjWup7s=;
        b=ETrbDFnf6QoERKrNeXN/vJhckh+Jid/ylQ9oIwHuOniqdIh7zvCVmou2Vg34q5d78Z
         E2vlgCPPNmeNeeVCkQ8euCfkKx/un4TGIzmvp03oZXRtGJqv46hD6CMHUUK466GNnti1
         SRz5m/g4zl4xctVYY2GAexq5GI1EnoX4mCta9rehXYeNx/GD+jV2ppkQggEphnOcvC2y
         jnkLT1bRjwy9BLkWV3hNvnHjCfDXRzM8x8ovcUxNN/idcYhy/N5GnpVddJUatOet8cc9
         /2MAK5OsLIbflwf//T+zJOHirXYz3syCBIsJhf6GdoCdxKuhpLw+6zFHezlrMGON9okB
         rgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbCROyekNSS6r922VIpU9j52qiNMPCsXY7vyKjWup7s=;
        b=soFRee+PYk1kreGzs9O0xkQBcJYgr5p/Gkh7JZYjl7W2XMNK6N3ylCJp+cWxYrno1Q
         z07HJal2bT6yzaQwYHa/0CO5dBrtMITJXyQyFJQCc9+mL+2Tg6ewWVoAB/KI+B4yT5Vv
         ZUnUhjWEs1lyZ+DHKER0JbRQr5lEaL5rPBFekR1Y32z5w37QF3Lru17bJXTCzNK4ktQE
         GJHTRDIgC14jv2hN/DZn7wb5uYeZitTpW5UzGAfvVFRbDSVkJY5Nm5juxhpr8go4pMXf
         Jk3cKszTqUbwz0YeylesLyTRiO/fEq5bvGMLECzewWnoe+fwvqIm/Wzus+ufzqn2Ywfa
         HKOg==
X-Gm-Message-State: AOAM531PIjlsPQ5GvU5JsAo0Z7enXJpXacUkwrSQf8awqs178wfRbORx
        KLWGbVc3jHfiT8xQThOIybF5Whnnokhswg==
X-Google-Smtp-Source: ABdhPJwzcBtT4Mxya91XaNMZTt6nZp5IgwGbwP4h7R1jpflxvjexD1216f1TtHet2cJ//gaUJGoTbA==
X-Received: by 2002:a62:5ec6:0:b0:50d:a467:3cb7 with SMTP id s189-20020a625ec6000000b0050da4673cb7mr28079644pfb.85.1652340458700;
        Thu, 12 May 2022 00:27:38 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z9-20020aa79e49000000b0050dc762813csm3082779pfq.22.2022.05.12.00.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:27:38 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
X-Google-Original-From: Marvin Lin <kflin@nuvoton.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: [PATCH v1 1/5] arm: dts: Add node for NPCM Video Capture/Encode Engine
Date:   Thu, 12 May 2022 15:27:18 +0800
Message-Id: <20220512072722.25005-2-kflin@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220512072722.25005-1-kflin@nuvoton.com>
References: <20220512072722.25005-1-kflin@nuvoton.com>
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

