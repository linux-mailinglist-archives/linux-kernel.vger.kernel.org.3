Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE54F7B9D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243773AbiDGJ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbiDGJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:29:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EADCD66A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:27:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qh7so9492863ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XD1rP9un2hmsqq0b2Cm9MfuJFrWq4hgmVGB9CsvK7E=;
        b=iABlEFG8GrPja1/jzRRcIfR9Dvt7wl8LU7VmVR1w/91XfwsCvReILJid/u6X1Yk6MO
         F4azg/k9gk/gF0Q6NJInkJ7WFIv/uCmUbM4ZdWvwThQxwmWsM3eIdFEs+qf4z9ABKTKM
         tNcn+FIhp5c0szBe+pZ7vE6HhdLbTg28wJPl8ZTlQwta0EiAVYKkna6LITVh/BGkcURP
         Q8HGMNo3oAjb89leKAaNK2MSHh1x0HGFBmlx7yXkxInfl5Y3rBRxP7mhrvltIZRt+94p
         J8JEjPjOKzLWXJ9TXJXA8rszr+6LbYyisWRJcxZ58cR0dyfYSkVcyLaNExXe7hPIm3hQ
         2+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XD1rP9un2hmsqq0b2Cm9MfuJFrWq4hgmVGB9CsvK7E=;
        b=npHI4T3aqSZKgQXTsV7RY5yY/aR5A2QFfccclgNjp32/50ji0fj66Eibtg8sod+qNU
         Wh/Tp2Xj9jS0XZnhc9TNNZlQitXMopTbwgle9HO/DOagMAFUZoHo0AZAbHCkvWX/1o2W
         x1bVs80UZ1IVTQF0ZmiBLJCAa2X0dQCykxQkw4tjFBK4+JuGolyCGUBZuziZtNRBQJcu
         TDJdYVRjGl1MTpXSGe1gxFh9CzmN/zvSMCNIDILAcf/SXv14rOMpt1WbPxOMOckAqG0G
         l86C26yoNFbBHMIyKugmtt3EF+0plQ81mHd7jKxkjSnFumcK2XykmEng6o0XJKRl3gLI
         Wkgw==
X-Gm-Message-State: AOAM530njEDMH4o4smOt7488zTyKiXQvVaKpM3/15IJ4+7jENjkrT0tM
        Gy6e/2ZVVAQ4BP2B5iSBx0QYcYsSWn/dFckg
X-Google-Smtp-Source: ABdhPJwup3iMLbpJBGlTFYCEdADs+iBSFW7bU8p/YDdJmXjEEl1BV7FIj7iEMfgXcywtB85A2JTw9Q==
X-Received: by 2002:a17:907:6e10:b0:6e7:f672:f39b with SMTP id sd16-20020a1709076e1000b006e7f672f39bmr12533217ejc.451.1649323669689;
        Thu, 07 Apr 2022 02:27:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b20-20020a1709063f9400b006e12836e07fsm7454790ejj.154.2022.04.07.02.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:27:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v3] arm64: dts: hisilicon: align 'freq-table-hz' with dtschema in UFS
Date:   Thu,  7 Apr 2022 11:27:46 +0200
Message-Id: <20220407092746.232547-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT schema expects 'freq-table-hz' property to be an uint32-matrix,
which is also easier to read.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 8bd6d7e8a474..6b3057a09251 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1045,8 +1045,8 @@ ufs: ufs@ff3b0000 {
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
 				<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
 			clock-names = "ref_clk", "phy_clk";
-			freq-table-hz = <0 0
-					 0 0>;
+			freq-table-hz = <0 0>,
+					<0 0>;
 			/* offset: 0x84; bit: 12 */
 			resets = <&crg_rst 0x84 12>;
 			reset-names = "rst";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 636c8817df7e..3125c3869c69 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -671,8 +671,8 @@ ufs: ufs@ff3c0000 {
 			clocks = <&crg_ctrl HI3670_CLK_GATE_UFSIO_REF>,
 				 <&crg_ctrl HI3670_CLK_GATE_UFS_SUBSYS>;
 			clock-names = "ref_clk", "phy_clk";
-			freq-table-hz = <0 0
-					 0 0>;
+			freq-table-hz = <0 0>,
+					<0 0>;
 			/* offset: 0x84; bit: 12 */
 			resets = <&crg_rst 0x84 12>;
 			reset-names = "rst";
-- 
2.32.0

