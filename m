Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C34F9F76
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 00:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiDHWF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 18:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiDHWF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 18:05:26 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8252A8EE1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 15:03:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id e189so10192713oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eewg3H1xy6qXGWRPZTaCTNl8Vpw97TxspgFq5EUBMRA=;
        b=fOpVelIK08yCmnuMNNzlwgP+fy2zs5w4WJxU2/loihlzUnWt7lcEDyNs59vDCVvWHs
         Q0CbB5QfOFnw5CDbkZN/teoiV8cBLYV2HpdMXtwlYBfT6ViiCKpBHC6ef8Bb43WvB5PF
         lucDNe4WcvGCNSeIdHo/ST6Kucf2ZELgLqL8e49XYLH75b4d55Vkkb00AKeQynFLNDPf
         AqbjgDqEt1h6K9eoDNVpXL6wz77cjcx1G4YVshpe3CjPd2s3Efg2JtzkafwxUsXFskNR
         69RNaSfBVj7EtunmGzzf/DXIjjWAEIIp9rd4fE2l2UlFPsWNhlscTf5J9RVHNECVXnBK
         Cqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eewg3H1xy6qXGWRPZTaCTNl8Vpw97TxspgFq5EUBMRA=;
        b=HwLnSA9sCzL/7o/P6DzrceoQuJwfaurpYRNZRaC1OgACEuOmBhZvp3k6zHQekvEzyJ
         M2aPuZemsx1jcIfh/5/XlHaPxgCXO0UkGJLARuByvJi0lsE5ym8e0pMSDQlSsPdGFQ38
         kbZ1X2POpp+fEWqzuLlbHluPXCfAnY4Gi7PYuznDf7d4Ng9l6Zb7t6gMIzYrJL/xqcvu
         uO9xHFe3sbf5m4kyhpPPfrEkoSSDMPeB0qN9muRJOtdfirXmfJqHzH6H+PTt84K0YeL5
         8k7AYBHoAgx70qoUMRUrR97N+DPZmzAxiLEAhTlsMMy0XWIuCxo6mQBhGYxWoRZty+uw
         Y6Xg==
X-Gm-Message-State: AOAM53337oOc8IzHz78VA8F/RZjVhYxUwn4vpQ39R26uCYZJBA9g//uX
        nDSg+48LpbbnN8lnKZLT3vWJGw==
X-Google-Smtp-Source: ABdhPJw7B8pf6MakGL0WWtA4jRzGyZlx3cel8YeUFC2Wxm1VAnkL64p5UbLlW46Ysmdnw7RGS8hnzw==
X-Received: by 2002:a05:6808:114d:b0:2f7:59fd:2f18 with SMTP id u13-20020a056808114d00b002f759fd2f18mr848289oiu.113.1649455399908;
        Fri, 08 Apr 2022 15:03:19 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id d1-20020a056830138100b005cf2f29d89csm9212635otq.77.2022.04.08.15.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 15:03:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: remoteproc: qcom: pas: Add sc8280xp adsp and nsp pair
Date:   Fri,  8 Apr 2022 15:05:38 -0700
Message-Id: <20220408220539.625301-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Add the Qualcomm sc8280xp ADSP and NSP pairs to the binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/remoteproc/qcom,adsp.yaml        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index a4409c398193..df8286296c37 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -29,6 +29,9 @@ properties:
       - qcom,sc8180x-adsp-pas
       - qcom,sc8180x-cdsp-pas
       - qcom,sc8180x-mpss-pas
+      - qcom,sc8280xp-adsp-pas
+      - qcom,sc8280xp-nsp0-pas
+      - qcom,sc8280xp-nsp1-pas
       - qcom,sdm660-adsp-pas
       - qcom,sdm845-adsp-pas
       - qcom,sdm845-cdsp-pas
@@ -169,6 +172,9 @@ allOf:
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
               - qcom,sc8180x-mpss-pas
+              - qcom,sc8280xp-adsp-pas
+              - qcom,sc8280xp-nsp0-pas
+              - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
               - qcom,sm6350-adsp-pas
@@ -284,6 +290,9 @@ allOf:
               - qcom,qcs404-wcss-pas
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
+              - qcom,sc8280xp-adsp-pas
+              - qcom,sc8280xp-nsp0-pas
+              - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
               - qcom,sm6350-adsp-pas
@@ -471,6 +480,7 @@ allOf:
             enum:
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
+              - qcom,sc8280xp-adsp-pas
               - qcom,sm6350-adsp-pas
               - qcom,sm8150-slpi-pas
               - qcom,sm8250-adsp-pas
@@ -508,6 +518,22 @@ allOf:
             - const: cx
             - const: mxc
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-nsp0-pas
+              - qcom,sc8280xp-nsp1-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: NSP power domain
+        power-domain-names:
+          items:
+            - const: nsp
+
   - if:
       properties:
         compatible:
-- 
2.35.1

