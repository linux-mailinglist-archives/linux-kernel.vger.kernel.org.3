Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D609D519A34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346570AbiEDIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbiEDIqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:46:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929024F08
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:43:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g6so1560943ejw.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kmKpPTh53HGaPGmc2OC1yOa2m+JoLUvELUPD1fQ0byo=;
        b=SEYSYfVIjrtuu0K54gTH0Wzhwuz014Qzjb5o6h0ki1u4Mzh53usYUNfaiwlwEK9cWZ
         YOR20fbwuNMy/H7weBRP8GZE/6GAl3Grk/ed8d57NNiZU2dfLoAxnT1/QWw845d0b5XD
         XV8yPMrUaR29PvVwwl4MFQGjBTe9l98ekMJ0ysO4C1Eeb0ffjbM+xfwHN5ltUOVpMz+P
         J7NW46ssnuj8QAE7hO7Rh+s9JFQn/K8KgywLrMRhg2JLcu2EichU0Q9RTfYC0BKv85sv
         RL8oBfPlrl6zlZTSgAe72f47RfKw74m7I3nCtmQV50eFNf7JeX0oqdSdyVGch0hWowoN
         5t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kmKpPTh53HGaPGmc2OC1yOa2m+JoLUvELUPD1fQ0byo=;
        b=pwytdBVCbr7TqWprkKngDuHkHy9pYk6jLevfDU9kDA6Ml80mdkBIy27d/cKdk+3l+Y
         VwVvdsNhwH5jbzO4UVs0s1AMzqq+1HH8rIBuU3fHpokFGVc8OBTlTRls+PYbstH0pESr
         +g/mu3bXGLX6c9leEQxC1vFqwbaN8uF7ZvpmDbLWI+T5cbuG7ORTo6deYsLSHzmuq4xO
         D+dt84V/G9jkqKCbvy4Y5gVO198CZjD+gwSc8k3LCqjyiVhJRusan4zvoUqxfuY976eC
         w1sM59PL//ksk2dMtOp93TTjN5TRDB4fLRzEYAwOLqe2wR/n4O7NSlJ54Gsj5BePGCQ4
         bIew==
X-Gm-Message-State: AOAM531LWiSC0NsVfmUNKKVcjNoQJGgjWI+Uevh4RDTjenorwX3tgGSC
        kOPcjSqFx0P2rttFHFpTneUNBw==
X-Google-Smtp-Source: ABdhPJxOON1fkLWxozmqD+lrywo7aHVA2H8luRvjKe6gL0v6Ji/UILgJJ5iHLa6eML1Rrbb6UCNohg==
X-Received: by 2002:a17:906:6a26:b0:6f4:6bf8:1efe with SMTP id qw38-20020a1709066a2600b006f46bf81efemr9561816ejc.208.1651653786607;
        Wed, 04 May 2022 01:43:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm5474399ejc.223.2022.05.04.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:43:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: mfd: wlf,arizona: Add spi-max-frequency
Date:   Wed,  4 May 2022 10:43:04 +0200
Message-Id: <20220504084304.46173-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The Wolfson Microelectronics Arizona audio can be connected via SPI bus
(e.g. WM5110 on Exynos5433 TM2 board), so allow SPI peripheral
properties.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Allow all SPI properties, not only max-frequency.
---
 Documentation/devicetree/bindings/mfd/wlf,arizona.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml b/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
index 9e762d474218..ea3337dafaf5 100644
--- a/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
+++ b/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
@@ -14,6 +14,7 @@ description: |
   range of analogue I/O.
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
   - $ref: /schemas/sound/wlf,arizona.yaml#
   - $ref: /schemas/regulator/wlf,arizona.yaml#
   - $ref: /schemas/extcon/wlf,arizona.yaml#
-- 
2.32.0

