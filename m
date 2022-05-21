Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448B652FE6A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355475AbiEUQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354256AbiEUQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:46:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D0EDF5B
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:45:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q1so2984173ljb.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gddd0fAw+DDHS5UQpyWxRARue36ZoZZ9O5PUo4nnIcU=;
        b=rRqCRfxqlvdHIxEcE+nigMTIT2JUiHyQtIr3jv9PdDUR4xMzvj/bCgXsm5OKnpZT4+
         +zC+4exp2z8CFKngJCNXPdY3ygS7Z2BfavarrvRbBE+EllfkdomzXn65OBx80skthS35
         FVXDMYEWKKdp3dsfL5Q4uKlVWCdus4R5FzOpjvA2se1XcIMYEa6vwooJOxRM/tsTlUHv
         UC8Dyh9O0dT0+K1RB1iV+RCKL954DcZIu3JqjDVr9cg/aAC3P3KjGfcDAjbChQ5IKKuw
         XwkUolUthegmReuh+IIG5tsxHYUGenpp7baWz/54gNYBMoRZROb9B4CsDgMfz9MyaGa8
         dYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gddd0fAw+DDHS5UQpyWxRARue36ZoZZ9O5PUo4nnIcU=;
        b=alGv83NTrDRlxMf3e3BGi++zjI8GbG2+AygwEYTZ5J36AnMMGRoQJIxNrURmPROxya
         NJpmc2cgECgCxLEBfDoiS5MoAk5/DrkaMAkQXnJqU4zW4U9JG4egeMi32iIqJS8G/qL1
         4c4Hkq5LAUOj6h6L1YDfDvg3kd0Kpf+VJSwtO535WYE9g//SbYuU71jEEbxUJsKXaTIP
         hO0wzGBuyQpRsF6bhIjh/FuRvFG/KEkrFX4+VF05MNipRTsXmsDekEWt0jEHv4/JcZA4
         xEYEv8WKK+fnBeyzgd+3TJQYYjKx7eLWHzQDUlkmyYLjMvyeWbB1lHkWRL2y4mA2PlUQ
         LiGQ==
X-Gm-Message-State: AOAM5330TOnnt57deKBN7Wi/x+5DppXTpBeNlnoQy1yzkXADwroc9LRH
        9jAvhe5OTDT2i8+72768G/954A==
X-Google-Smtp-Source: ABdhPJwJ4v+PxMbSwUzIRXnS3FZidnv/KU4MzdWcShWBU/bE1bew+wzucXOs6iv/xPda8u0RIIDTQQ==
X-Received: by 2002:a2e:6e02:0:b0:253:d7da:ef27 with SMTP id j2-20020a2e6e02000000b00253d7daef27mr7183920ljc.105.1653151553619;
        Sat, 21 May 2022 09:45:53 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f26-20020a19ae1a000000b0047255d211cesm1114282lfc.253.2022.05.21.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:45:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/12] dt-bindings: vendor-prefixes: add Shift GmbH
Date:   Sat, 21 May 2022 18:45:39 +0200
Message-Id: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
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

Add prefix for SHIFT GmbH, phone manufacturer
(https://www.shiftphones.com/en/).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 495a01ced97e..85d52300e588 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1098,6 +1098,8 @@ patternProperties:
     description: SGX Sensortech
   "^sharp,.*":
     description: Sharp Corporation
+  "^shift,.*":
+    description: SHIFT GmbH
   "^shimafuji,.*":
     description: Shimafuji Electric, Inc.
   "^shiratech,.*":
-- 
2.32.0

