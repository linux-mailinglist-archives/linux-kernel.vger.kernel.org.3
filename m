Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652BC539007
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbiEaLqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbiEaLpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:45:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FF9985AA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:45:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so18305559wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYSEyUlsKgFpMImQK8ePQlB37MdL0HrdJFsY0FXbKmA=;
        b=JT5l3xMYkAt+4TZYJ5fHveeJWZa96eRE0vHFuBF3Zjv+2XhDxCbnddvfhAawHbou3O
         nmLtys+/mYZKVxGVA4M2oacHrWqtFQr/aJmYYDT9i3GWqO+GeGTur7j+wBhSy1y2zSUS
         W+AF+ZWnuP+wrHaWmWonlM5MuziB7iv4m/+0F8BGxiEuHtEO7FjOE/W9p5WHzLpRTSKv
         NGX52+vK3k+I+EpnQmtsfhqb6lm8e7Vojo0JmMVQBzr4aFHGMSofBq1qEpvwXYMiiGmO
         sJoSABKT6sCy55cZIlY/Ei3P06cwCOzA4P+XW0yKXRPtWNRSxNwYXiuXLD6qZnZRkmo1
         Q3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYSEyUlsKgFpMImQK8ePQlB37MdL0HrdJFsY0FXbKmA=;
        b=Lqwi5sBDuAoaTcgr4owKyePnXqmz3UdcBp/0tbMrtXeDn8rLcQ5x7qncKJByRIYVGX
         P9YbHkfbrN8COHdMTjIDPAYseSjVOg/9LRRE6tCH9xC7i4V8A27R9VFUjSI+528K7xU6
         xUSCG0zCtiV9yX/gsYXpgltljeSIg2vaY3QhyrKUia+z0ZxMYsY7t+86GU4Ieapwzg6L
         lN1a4nros+1M6IRRVshv9Yf7x1w8TLXSYaOVtAMEULKVoMKYk3pbpiQii09c9yzuH8cf
         YuNdbgJpUqEcNo9pZYwKXQrsXc96LSf4TOxp1K6vB3Gx/QdJW5dknwKyPYkDslt2i6Ll
         x4gQ==
X-Gm-Message-State: AOAM5333EpgL4dsLDEAWDRL9CLaBMyi92530UDyJcOY/G2Mw4HRRjcPp
        cv27xzdv/3b4WG+Dp2zJ/MsUDA==
X-Google-Smtp-Source: ABdhPJyePNMa/IHOGRQ08K1lGsWNcl+BGJTvraImexb5JIbQoAQ4i/xDhuHPCpbkE5fkVdYO3IGe+A==
X-Received: by 2002:a5d:4450:0:b0:210:e8b:7896 with SMTP id x16-20020a5d4450000000b002100e8b7896mr20712199wrr.490.1653997552679;
        Tue, 31 May 2022 04:45:52 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm2064154wmq.29.2022.05.31.04.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 04:45:52 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8195: add pwm node
Date:   Tue, 31 May 2022 13:45:44 +0200
Message-Id: <20220531114544.144785-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531114544.144785-1-fparent@baylibre.com>
References: <20220531114544.144785-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195's PWM IP has 4 PWM blocks.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index d076a376bdcc..366543f27a99 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -367,6 +367,21 @@ pwrap: pwrap@10024000 {
 			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
 		};
 
+		pwm0: pwm@10048000 {
+			compatible = "mediatek,mt8195-pwm",
+				     "mediatek,mt8183-pwm";
+			reg = <0 0x10048000 0 0x1000>;
+			#pwm-cells = <2>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_PWM_H>,
+				 <&infracfg_ao CLK_INFRA_AO_PWM>,
+				 <&infracfg_ao CLK_INFRA_AO_PWM1>,
+				 <&infracfg_ao CLK_INFRA_AO_PWM2>,
+				 <&infracfg_ao CLK_INFRA_AO_PWM3>,
+				 <&infracfg_ao CLK_INFRA_AO_PWM4>;
+			clock-names = "top", "main", "pwm1", "pwm2", "pwm3",
+				      "pwm4";
+		};
+
 		scp_adsp: clock-controller@10720000 {
 			compatible = "mediatek,mt8195-scp_adsp";
 			reg = <0 0x10720000 0 0x1000>;
-- 
2.36.1

