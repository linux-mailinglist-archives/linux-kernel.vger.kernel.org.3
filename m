Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FB053239A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiEXHES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiEXHEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:04:16 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA027CDE7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:04:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e4so19245596ljb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gaJhjmwqczm2UYXAEhvO2v8f6V5xAgILsqBVg/JTTfw=;
        b=VoWqY7LHF9P/vlorHNABRn3Lwgpm0nOfqWW+i07nErI62PRwJMq7U7M22ov2GQ96Gj
         6FEbuxxVCcszDcaSdhwtC4fUTnnlVtZjFtZOZpp4jix08SZpqkV8L89/CSNCPeUNSrC+
         qEv8t1AKdjVlr3/Tjc45z/UcwKV3yey1SG8jvQ6Sotf8jxwsEnYWv7+P9E652YrJ7ZQU
         wmlE79vQqjouBb6uQiPsvC/XgiHHOgOX2OTWSMVItaPKkvuaywtDmpO7RHWP1y5ikd/F
         S4ZwneXPGuTgH6VzRqUpuW8TGiBQe7VAU62ITWXrdnh1X2ULGO9T+YzzZdjUh9bTbpzs
         8g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gaJhjmwqczm2UYXAEhvO2v8f6V5xAgILsqBVg/JTTfw=;
        b=RvgUHxfiB3AW4ab8Z3QL6oxOz6/Q1QCTzB0TcIisqjXtytBfCP0hEI/CA3iX78GG+B
         HIhYMejCBhh485cSpHdkV++XOCT3WCLOypHIc0rrmx2lqSIKZSP+fyKUXFSP/tWAU34r
         rhsUYbjyt/nMZOII/MzdxxJvFTS/rmyhMARAZpwVhITpmA/HeN5058PijnIouOqLvO+u
         HfTsK6pMAlWUIf7IgwH+iPeO/oPYaxFc1as14bjX5h81BLuLUdY42r7zpjp5CZcDxQe4
         PZhzkOa69PNfLfUlHBxcodYgnTcy3nARi5UZ9XF9tlJ5to3aF1i1PMcVonMV70huevLy
         2oKQ==
X-Gm-Message-State: AOAM532kFiUA0bAf04JkAD53cTWjFCus+TwwOupdeyaetApj5ncJXJQ6
        ZmdTKtwTbw0mZYSiR43l0683BQ==
X-Google-Smtp-Source: ABdhPJzSKnjnAYuNMX9kHQ2kVrZI1whSyhNNKeUSeT0d8Nn57g588/W24ySsouKqFXRKCn6HmsfGug==
X-Received: by 2002:a2e:8404:0:b0:250:cde7:e9e3 with SMTP id z4-20020a2e8404000000b00250cde7e9e3mr15286313ljg.289.1653375851311;
        Tue, 24 May 2022 00:04:11 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u28-20020ac251dc000000b0047791125880sm2373479lfm.267.2022.05.24.00.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:04:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: soc: qcom,smd: do not use pattern for simple rpm-requests string
Date:   Tue, 24 May 2022 09:04:08 +0200
Message-Id: <20220524070408.39505-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

patternProperties should not be used for properties with a simple string
as name:

  Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml: patternProperties:^(.*-edge|rpm)$:patternProperties:
    '^rpm-requests$' should not be valid under {'pattern': '^\\^[a-zA-Z0-9,\\-._#]+\\$$'}

Fixes: 375eed5f51a8 ("dt-bindings: soc: qcom,smd: convert to dtschema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
index e6f9ffa1c0ea..bca07bb13ebf 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
@@ -66,9 +66,7 @@ patternProperties:
           The identifier for the remote processor as known by the rest of the
           system.
 
-    # Binding for edge subnodes is not complete
-    patternProperties:
-      "^rpm-requests$":
+      rpm-requests:
         type: object
         description:
           In turn, subnodes of the "edges" represent devices tied to SMD
-- 
2.34.1

