Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA58D5354D8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349028AbiEZUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349095AbiEZUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:43:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE680E64F4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gi33so5174149ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61SDdlI/WkCqCxMIXxDin340q/9pKul5ClTEVboRWS4=;
        b=ENxKB7k1c/ZGV4wSMizWGUYlXla7EY+KcuTEWIdR4K3LqZXQNQYCdPdonJkglV3hni
         9Y9kgwkJSPSwkTAwvdtAYawWKgGEZnPBOW3Lu5j4/bG2vLZYFrhxFVJJARdMJMA8kcs8
         cKt/5reimCGAyjs8yUHgL5EWYvrGMfoDXtxR7KlpfvL1yUB6/byAGfAPRex8yGb+W4RY
         6m0Yv5E+5x/z7E8Cwyn98M57knnt24VrXeFDtN9UguY32VPeWSSgBCqDlHx1nBTqnpZG
         UBZOo//HLzdznGWHwe0MRS9o3yOTZHX8A66UM8RsafOue75TDum//Ia5dWPOmyLs8Gdf
         Q1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61SDdlI/WkCqCxMIXxDin340q/9pKul5ClTEVboRWS4=;
        b=pvYjHxSYE00c2MTkOiWvaLj9c+HSGUbNi2ByP6Dnv6O5t6xDNTJ1Q414U8UCCeK8Di
         ja6cT0aTqEjyiKrQwRL2jPZSKn34kTiFZYf52HvKmMIUHTezLbwGKYsr7pvqkW+KOKwi
         hwBAf9UTP8/WlzQvgUchraFH6tU5ElXfQ9Ef/XvoUhmVgkuZOoQlqIRtSPqRNF2IldpA
         yd37s0gyogPTjAl3YvGK3q5hw8BQDKMP5htgGBt8+crLMoxTzu2ZU0sKy2NmaopzAF1g
         OzSNARajIPyGp4VVc0qiQDXsvibpPzk9oM6R+bb7VdHfcYmNGczPiduPKgS7H0ud/lvE
         bIgQ==
X-Gm-Message-State: AOAM533qmUK0oE06fGKdhIde3BJENlnFUKm3LfWVdp6Zx0EZhhZjCuEv
        6DpIKWeU3KZKO6riUlfrOi5SrA==
X-Google-Smtp-Source: ABdhPJxBYTEfl97pyUDWNEiYeiRo028m5NzT74n56sjtRyphUKYAKiajTWdqTYhQWx0qOFaqYwwvEQ==
X-Received: by 2002:a17:906:cb97:b0:6fe:ec71:a49 with SMTP id mf23-20020a170906cb9700b006feec710a49mr19773575ejb.540.1653597807380;
        Thu, 26 May 2022 13:43:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y11-20020a170906070b00b006fec28bd09fsm816846ejb.22.2022.05.26.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:43:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: exynos: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:43:22 +0200
Message-Id: <20220526204323.832243-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index 0ce46ec5cdc3..5827e1228fa9 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -364,7 +364,7 @@ ufs_0_phy: ufs0-phy@17e04000 {
 		};
 
 		ufs_0: ufs0@17e00000 {
-			compatible ="samsung,exynosautov9-ufs";
+			compatible = "samsung,exynosautov9-ufs";
 
 			reg = <0x17e00000 0x100>,  /* 0: HCI standard */
 				<0x17e01100 0x410>,  /* 1: Vendor-specific */
-- 
2.34.1

