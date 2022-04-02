Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1190A4F05B3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiDBTK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiDBTKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:10:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20B344C1;
        Sat,  2 Apr 2022 12:09:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so1405981pjb.0;
        Sat, 02 Apr 2022 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2u46UfW6kIuGqw2fEWOMbQ8vmrbpCAIrB+DNSu9kic0=;
        b=OyL5oa6mwmQ4Nhi+Vbzst8I61BXM/9lXgchFPVrLkEEGNTW3n6CmmBxGgRuuX7gyxX
         EBCjiO0yqy8X0rYIvpxmsMq7tBHfc+Jg+6f2LVHVPXNaWWq6mg/zqMK9wHk2ZpJXR+wm
         mS25FPcfk+mfyXxvy2m109uV8sGWMbPBiUQjemFA199Yav1bypOnwHt4YvH7bQ0lYg+Z
         hO3hanTooAaY3zJRYAgB82qrC1r/P5tCrSy2cqd3Ar+6ouwunnkGwH1nuZGvcu/LFLaP
         Ww4NmfwZMfUiKp3aIo3TU+6R5N9CFFFIgtur8o6pL5F94Hmyj6R+lXKPXSv+6j2cpxzu
         eHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2u46UfW6kIuGqw2fEWOMbQ8vmrbpCAIrB+DNSu9kic0=;
        b=S+PGtTGzEisPWnCYqDPXXrOlwaUtQWD2JeJD4FNUQ0bSigtEKr/0lxmIVKl4CLCr5H
         1jRgLGy5LznrqmK7dE5HW7L9ZIHI5DXdXIv3GlrRJu6IX+IxOqLJ5c9nhSyJjwzAkXzo
         JGCbXL045b9TeIFXZSyCJ8ulako2476qR5feGV06Epk8w05faYnJJWYDmgdt1PNSk+Dc
         PCoK63NytR6LZCupHheFTlI+rgQvN/FI/47of3buTj4/9GLgpg4fkGAXvpRsu52Zw/98
         C4TbUqypRQ0Yziytdceil8/LdcZum/2Ucrj42GDG8xRroFkxR2vs8UQfkiE57WjKyZd9
         AY9w==
X-Gm-Message-State: AOAM533F7PHCOaDMqG16N9ulepDD54luSHsIGAVqIGq+jzxvENt2IlRy
        pdz0x0qKU5yAIPiyqF9WlMzacNClHJU=
X-Google-Smtp-Source: ABdhPJwPvY2t1ET5chnedD9sLhAFQk+HC1hdO6ndJ6R85Uepwzb1AXQwmznUUlfj4CYJ7xg8Jx8Wyw==
X-Received: by 2002:a17:903:1205:b0:151:8ae9:93ea with SMTP id l5-20020a170903120500b001518ae993eamr16475211plh.37.1648926542122;
        Sat, 02 Apr 2022 12:09:02 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b001c779e82af6sm5682112pjf.48.2022.04.02.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:09:01 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: lx2160a: Update can node property
Date:   Sun,  3 Apr 2022 00:38:55 +0530
Message-Id: <20220402190855.35530-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl,clk-source property is of type uint8 and need to be defined as
"/bits/ 8 <0>". Simply setting value to 0 raise warning:
can@2180000: fsl,clk-source:0: [0, 0, 0, 0] is too long

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c5daa15b020d..82bd8c0f318b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -909,7 +909,7 @@ can0: can@2180000 {
 					    QORIQ_CLK_PLL_DIV(8)>,
 				 <&clockgen QORIQ_CLK_SYSCLK 0>;
 			clock-names = "ipg", "per";
-			fsl,clk-source = <0>;
+			fsl,clk-source = /bits/ 8 <0>;
 			status = "disabled";
 		};
 
@@ -921,7 +921,7 @@ can1: can@2190000 {
 					    QORIQ_CLK_PLL_DIV(8)>,
 				 <&clockgen QORIQ_CLK_SYSCLK 0>;
 			clock-names = "ipg", "per";
-			fsl,clk-source = <0>;
+			fsl,clk-source = /bits/ 8 <0>;
 			status = "disabled";
 		};
 
-- 
2.25.1

