Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F714C0AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiBWDoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiBWDok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:44:40 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE34606E4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:44:13 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id u17-20020a056830231100b005ad13358af9so11042420ote.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cHDW5RUUyNmE9gCTFJFCIDcotOQWpizv8XZqucavco=;
        b=PQuuKWbRymj1GpDSMBPB97c3vG3n94NvkjICYWR8/tEFtEs5VpHWMMswkSvLReHbvw
         PgASX/SAndR0laYmeziouM8hHgvSahCUL3IF0psMWLWGi8vd+DUvgmgv4kM+w6Q7lqrE
         Mj4fEnDoj+F6S5LdkUtsAPpfv2GVo+cD5lLq+3ZQ9UdxFIKRFLrexg2QXyI/JnEAsyW2
         NdDHj+94zFj26Fr2BWZdr7OdVpKuSLQUhhxHeOzUhDPkWLmXIzgWt1fQzLyu+meYG84g
         ayfUYwmfvQ0tp7JoxkFWq9SZzgrZAraPEOX4COL8CIwuDC8inIZ8J+YqySCGw1k98GpO
         CTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cHDW5RUUyNmE9gCTFJFCIDcotOQWpizv8XZqucavco=;
        b=WSd0L3hcPKHY2WD7pEiAXcTRKJGMy9IqzS424guWAFWrPZkSXYOYYy44/0D1JVp4vv
         NWUxz0fHJE2HuYvDlfF54lxq07Lbs45JtKXtT/0Z1HNVzxyDPxL808zLM1Ytn0fpS9B/
         v2m7ulMNs9s3j64G3wxXRT1wTEELfOmBGK1d0+wHGbvT3FkJZCnI/InQ255F00pJZlfn
         /rjFY9u6cCG2AQLnEafmvgSRnlc4lx5BqIpFhdtv2PBunRQA6ZvgWBqydPsRQsvnsHCu
         Kbi/J6vAv6Bhgb6Hsb6r7XTVBaYwjELBpR0IEfkXfj/5RngpZrUfHo9PGjITP+BwIhaI
         vlqw==
X-Gm-Message-State: AOAM533xC9Ho2GhW6ESMw4Ar9Xsk9++mDHJdbqVQF5XoVdiC9rCzU03b
        LHYgfXBWg8HvsvW6aur4R4an/Q==
X-Google-Smtp-Source: ABdhPJzDnK/fNmE1i9MA/5k+F+RWareX1DjVjHvQ5QpI2TwBvJhwkKQygA+4v9c1RsYzzy1aw+MzlQ==
X-Received: by 2002:a9d:67d3:0:b0:5ad:147a:7ff9 with SMTP id c19-20020a9d67d3000000b005ad147a7ff9mr9333208otn.37.1645587852796;
        Tue, 22 Feb 2022 19:44:12 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id f38sm6124552otf.22.2022.02.22.19.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 19:44:12 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: qcom: Document sa8540p, sc8180x and sc8280xp
Date:   Tue, 22 Feb 2022 19:46:13 -0800
Message-Id: <20220223034613.3725242-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for the sa8540p automotive, as well as sc8180x and
sc8280xp compute platforms. Also add compatibles for the ADP devboard,
the Lenovo Flex 5G, Microsoft Surface Pro X and the sc8280xp QRD.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/arm/qcom.yaml         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index e8b1606bc849..1042f71300af 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -39,8 +39,11 @@ description: |
         msm8994
         msm8996
         sa8155p
+        sa8540p
         sc7180
         sc7280
+        sc8180x
+        sc8280xp
         sdm630
         sdm660
         sdm845
@@ -224,6 +227,18 @@ properties:
               - google,senor
           - const: qcom,sc7280
 
+      - items:
+          - enum:
+              - qcom,sc8180x-primus
+              - lenovo,flex-5g
+              - microsoft,surface-prox
+          - const: qcom,sc8180x
+
+      - items:
+          - enum:
+              - qcom,sc8280xp-qrd
+          - const: qcom,sc8280xp
+
       - items:
           - enum:
               - xiaomi,lavender
@@ -252,6 +267,11 @@ properties:
               - qcom,sa8155p-adp
           - const: qcom,sa8155p
 
+      - items:
+          - enum:
+              - qcom,sa8540p-adp
+          - const: qcom,sa8540p
+
       - items:
           - enum:
               - fairphone,fp4
-- 
2.33.1

