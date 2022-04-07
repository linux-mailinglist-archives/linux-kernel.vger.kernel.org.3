Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4AB4F817B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiDGOYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiDGOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:24:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79E6F9FA4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:21:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d7so6566391edn.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3az0dsHhRbjAtvjLKgQFw2T2bUmh6TKysA+m1P0pGGU=;
        b=e+pjZBZ9Ab1nOqK9IYrgBwN04kNJAEfZChRyW+f/KTw428JVlN4vE3rBXrzyr6rvMu
         bf8trEZ0L+m94fGQBRWz+lx7RobDaVaGsJQMzdDsVS4NHM/+APAgsfNPWnLE3lpMQUaI
         6bd4C2NQfhABAM2tYlCdomWNIAmKSuxiMNBOAw48qKQh1DgO4BaZQqVZHpLEhpkIolJU
         imu0OrGekQiJIpOV5rHBT+3b4yOxPkoVN61TpGMAQQYpGZd+4QyvZiBDzmRKRTwwPmcq
         q02v+sb4n6rXuVCWfZiidtXzRb6OLCdPGXgRJcbzoIfrJTSNQ1hbE2+KQEMEWfeMJknW
         +XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3az0dsHhRbjAtvjLKgQFw2T2bUmh6TKysA+m1P0pGGU=;
        b=ixpgcOkE9bcyWbXRKmWeIp1ejV6722Ot7fQxd7Dd4PVR/JrnEIspGOtFxQotlYVk85
         +y+bPH8M0Ln9CIHuqvB6L63AJli872BPa4A+drcZ9DZSjf6cvdWhsBM4v2/amlDC7dJ7
         u1+iGLIHidNW5EkfA0wlneRAvdnJe+AmHEBG/uDGrGiHLbhogQ/Li8SKFASovvXASgfI
         BO7nxc3zfYLXdi3+lT0+PnBWGnvh2k7cLFaXvNywkmLfEIs1y9mbQRxh2aKlX88FIcFJ
         HCvogy0B+DMHzXdlxlO6cLkAXfhHO7pbYWU4uBl7o6PdK8wyQGTA6s8nPN89OxoJgaGK
         lAVQ==
X-Gm-Message-State: AOAM532+V3tl3O/sFo//84bs9wJnnpga+b1YWBVdl7rj0idfcvTH0fLI
        SVhw4Ljp3FapzC00d0UVLUNeOw==
X-Google-Smtp-Source: ABdhPJxJ+Ro2BmvGVRNloYDOX+r7PLvVDALhZHY4o7bDgmr9/dXcIP9WmdJvA86P3pUy91cdIl4leg==
X-Received: by 2002:a50:e79b:0:b0:41c:dd2c:3e19 with SMTP id b27-20020a50e79b000000b0041cdd2c3e19mr14497675edn.291.1649341306706;
        Thu, 07 Apr 2022 07:21:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm7667869eji.67.2022.04.07.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:21:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: mt8183-kukui: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:21:43 +0200
Message-Id: <20220407142143.293740-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 0f9480f91261..8d5bf73a9099 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -849,7 +849,7 @@ &spi1 {
 	mediatek,pad-select = <0>;
 	status = "okay";
 
-	w25q64dw: spi-flash@0 {
+	w25q64dw: flash@0 {
 		compatible = "winbond,w25q64dw", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <25000000>;
-- 
2.32.0

