Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB69A50FBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349390AbiDZLLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345570AbiDZLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:11:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A461D2AC60
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:08:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dk23so11991927ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ned8K4/DJ2jNNS3XJQ8BysZeLMLkezd228hF2G2kCNA=;
        b=bTzMeiMzvnJ3igj9/EPAnoT0quEcrRMVvqCDZt7cjChZ8FiuQ/qBSYrjp5PYDLkLWo
         2SJmgwBnp3mw5dAZs3zQSAePI4r7nI080cK0vfhJ3h28Zfn+UsLBULlJWOrEuVhD26ci
         49c9pisJKDnip5uKtRqycy+80CjOB5TToP62ADTblfIuz9SA/WTd8MxWS3Z34gmYNVAe
         iRiC4jlHpBdMH+/xinuSSb9HR7euPV9h50b9bRRjIsYEsg22s4dS0MyLr5CfNNV20zln
         UngdE00lUseRPe1/B7XlCPMjANoQWsZaxUo9eLKc4jjKssCl6xY5k6OQDaJgxbjZxsU3
         jseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ned8K4/DJ2jNNS3XJQ8BysZeLMLkezd228hF2G2kCNA=;
        b=dAXYcE9KOfuLzSi+P+gJ/XCFJ6JALYkkMvWD2cNs47rqdqsgL7+evFv1CU7EFDWELy
         etZY+qMbaBkjHOyVpYTDsiUnJSiVLk+PceCBtnF+DzE0s5yETCth9SFDeFCuMwMmFc9S
         okvQf3Ahqe0DZZNQX7IpTDW46CQ4GbodfTBau/R9b2zaiT2s5EO7JkyImFb3akDQ3IvN
         dV7u7B0FTAnOR/bscipRtgzyHlMqSlTFHAg1uAEG/xFue044cr6xO9kMiqoKXTwcQ33q
         cAEgaE9pdc86nVn7UZi3V/2ERUIFJ4vzWy0kPn16XGWFmzxCOFcXPj8/48SypX0MDBlC
         anfg==
X-Gm-Message-State: AOAM531Bu0b5t1WwL9txhPC8XPxkxVyqTT5tzUlNd8okeJ69gGB0PJVd
        nOHZmdqJWKNcz6o9yqQZDV1i9w==
X-Google-Smtp-Source: ABdhPJza9w19lgcQbzmc9lPFuOGcElTa3Uz0iMCiD7XPluXEE1inm+3i4eVNdXCAWTodwZoCvhYasQ==
X-Received: by 2002:a17:907:c07:b0:6f3:a3b2:9582 with SMTP id ga7-20020a1709070c0700b006f3a3b29582mr6148248ejc.91.1650971281249;
        Tue, 26 Apr 2022 04:08:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640204d000b0042062f9f0e1sm5926033edw.15.2022.04.26.04.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 04:08:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: soc: qcom,rpmh-rsc: simplify qcom,tcs-config
Date:   Tue, 26 Apr 2022 13:07:57 +0200
Message-Id: <20220426110757.80603-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The schema for "qcom,tcs-config" property can be a little bit simpler,
without the need of defining each item.  Also move the description of
each part of "qcom,tcs-config" tupple to the tupple items description.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml      | 33 +++++++------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
index f5ecf4a8c377..4a50f1d27724 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
@@ -65,33 +65,22 @@ properties:
 
   qcom,tcs-config:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 4
+    maxItems: 4
     items:
-      - items:
-          - description: TCS type
-            enum: [ 0, 1, 2, 3 ]
-          - description: Number of TCS
-      - items:
-          - description: TCS type
-            enum: [ 0, 1, 2, 3 ]
-          - description: Number of TCS
-      - items:
-          - description: TCS type
-            enum: [ 0, 1, 2, 3]
-          - description: Numbe r of TCS
-      - items:
-          - description: TCS type
-            enum: [ 0, 1, 2, 3 ]
-          - description: Number of TCS
+      items:
+        - description: |
+            TCS type::
+             - ACTIVE_TCS
+             - SLEEP_TCS
+             - WAKE_TCS
+             - CONTROL_TCS
+          enum: [ 0, 1, 2, 3 ]
+        - description: Number of TCS
     description: |
       The tuple defining the configuration of TCS. Must have two cells which
       describe each TCS type.  The order of the TCS must match the hardware
       configuration.
-      Cell 1 (TCS Type):: TCS types to be specified::
-       - ACTIVE_TCS
-       - SLEEP_TCS
-       - WAKE_TCS
-       - CONTROL_TCS
-      Cell 2 (Number of TCS):: <u32>
 
   qcom,tcs-offset:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.32.0

