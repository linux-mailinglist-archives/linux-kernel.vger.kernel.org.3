Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD3E535498
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348895AbiEZUiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348360AbiEZUiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:38:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C7E2752
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:38:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id f21so5023897ejh.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7jum0HEDbTJCXnQC3vXB66FP6M8+k2CNreGmlsnCIo=;
        b=OJKUgCasUKoPz3Ig5L1FvvuXLp5g/5ZM45PVd8CxXzKQcgsvi4B/+QF/4XHsL+0EKJ
         okS1UAaPbptrjDnClLtWI0EFE9pgc5nt+uwM/vG7NTx25b88Ps3kenx06hFRGrxvsfgH
         IpJCT6as8zhZZpQBs1YhX3Xrp95yeKjHXi9D54ano4LqUd4p0t2A+WHLuOTkilXbLfj8
         9/uoLjSegliCMOJ+oOVJNaA79frccm6cmRZ5R9Dg3LOzos6eudpN+zZz9ril3lgz/ioz
         UAM9f+wczX1YksJZszFsF3ImvhWCaynbWPFGELN7NJdrEqTBbQjsEU/o7WoUB4JMl3S/
         8Cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7jum0HEDbTJCXnQC3vXB66FP6M8+k2CNreGmlsnCIo=;
        b=LzmH40XEsW3wtVKIhX/7U+tgua8c3WUvXby1RSzdP0G0Lm6yzUImM90Qjbdp/om2LX
         xOZ60pU70sSvWkN0nOkEP+C8lOgQ4laV+occCe26kGLc6qEngE6+FE28Qm2jA39/uWQT
         vmoQ2J3FWOgM8qhIUeh1pRWuKIRgagWSl2hPUoKobl9ae6q+ugx7kDA4MgoDxBK8lJUz
         J0V8PeJwYa+k/QVJwqcAKby+QbVrwvCJSNOtgroGT4s8pDOjTKOEQ7K0jR/+LppHAO7e
         opJjwwobDs0asvOEvc28xouVAlGhwUwgtqoXOF+f0ZRdczxi5cx4kHkqd1TC9vVNy5z9
         l4tg==
X-Gm-Message-State: AOAM531llLRgP0/R49rRDTkJ3SwrWT4phtnOXLC+50cfpnRa6tgIH9kS
        /V+YblB2cPqgpy5KjSvAYmAhww==
X-Google-Smtp-Source: ABdhPJxs7VC174mZ5yXMgJXJG1xnMc7/gVpYs31URTj9TCQbWTfceMkO4vAckyhmCTKUXRRt0cioCg==
X-Received: by 2002:a17:907:d28:b0:6f4:6375:5245 with SMTP id gn40-20020a1709070d2800b006f463755245mr34722095ejc.12.1653597492888;
        Thu, 26 May 2022 13:38:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906255800b006fee2570067sm799612ejb.23.2022.05.26.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:38:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: alpine: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:38:10 +0200
Message-Id: <20220526203810.831352-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/alpine.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index 3b0675a1c460..4be9887033f9 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -154,7 +154,7 @@ pcie@fbc00000 {
 			reg = <0x0 0xfbc00000 0x0 0x100000>;
 			interrupt-map-mask = <0xf800 0 0 7>;
 			/* Add legacy interrupts for SATA devices only */
-			interrupt-map =	<0x4000 0 0 1 &gic 0 43 4>,
+			interrupt-map = <0x4000 0 0 1 &gic 0 43 4>,
 					<0x4800 0 0 1 &gic 0 44 4>;
 
 			/* 32 bit non prefetchable memory space */
-- 
2.34.1

