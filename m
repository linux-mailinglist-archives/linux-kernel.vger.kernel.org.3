Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923C64EFBA5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352600AbiDAUaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352815AbiDAUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:30:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF6127383E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:28:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b15so4300281edn.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/uYZwJv4qOMJdSh4QC+fOSVjVZQvMo857xnnr6uG3Y=;
        b=HdYKLktMOpNGpDkytMi3ugQSj2eYeTDTin0govK5Z2QnKeDD0goHA1sp8HepIe0YN5
         6XNt4KzL0KUPa287Qi211ygoUEpzUZ/HIs3bjm3BrGR5UZ87UR5XNWvmPawvwFqfyO3D
         julaLPVZ85fVl7Dar013jGPtxkw9RY7dImSuxsjSD9ZViVUT8e+V/prO8dWQvdIqgcpg
         941nhXmpFu3DOjJ3Jdg8LlmJBXj7XcJ0nlRdWIITA0LTG66BNwphJpYGEkI/zTW1FEkf
         H9VhfH3S3H1wla+mTe3xFkRzX1HEhHnh3lmm5kF678NULkQntMtHoTrPt/lit25bLYCE
         mU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/uYZwJv4qOMJdSh4QC+fOSVjVZQvMo857xnnr6uG3Y=;
        b=nda4z626ALfJPlWW7fepiBXQY+Tir2mrFD1/GOfEvlsljvmqdgG5/ak3W6ty3LR3jS
         kQrmzE6XvjnS6CagY1IqP2kRU/jjTf7mKPfV/y1PA5ifpVsTpagJA38pLYr6DLR3txWQ
         Ve1o2d8TYJV5YkY9LDBN25aOuyWsROqbN3F6bwr2SNf5Aphsc+L3dpUrDjjvXc3ltHTX
         eEGrPxGFAKuBgzk1JmtFvd79zitylnPqyfcCZNoh9+ic71UcV2vcLr4azFGHMMzKbQqK
         N2qiy/8G40in6o1LIMZxrLDuiZ8TqO76LGXGB4Z0dmm3YzlleDFNIgnHV1XWDf/Rf7W8
         jKfw==
X-Gm-Message-State: AOAM532DZJFEvcibQJ7g8am4/zEYNr29fZ5asILVbKmfzTWfFCERSIg+
        KHMIzdvh01ftW5c9HBORsbJ3jg==
X-Google-Smtp-Source: ABdhPJw8Wux1sPx1JVJOa5MrP8GuPRljGHUkUxfIrbDJcSI+GVjbIs33571XBu0v3Bg0KInVFN5u7g==
X-Received: by 2002:a05:6402:26c7:b0:41b:7aef:bdf6 with SMTP id x7-20020a05640226c700b0041b7aefbdf6mr9692665edd.210.1648844882314;
        Fri, 01 Apr 2022 13:28:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ga42-20020a1709070c2a00b006df76956b53sm1340155ejc.212.2022.04.01.13.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:28:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: qcom,smd-rpm: update maintainers (drop Kathiravan)
Date:   Fri,  1 Apr 2022 22:27:59 +0200
Message-Id: <20220401202759.191560-1-krzysztof.kozlowski@linaro.org>
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

Kathiravan's email bounces (585: Recipient address rejected:
undeliverable address: No such user here) so switch maintainers to Andy
and Bjorn (as Qualcomm platform maintainers).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml  | 3 ++-
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index 0daad8e3e260..6a9a7eed466f 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -69,7 +69,8 @@ description:
   l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
 
 maintainers:
-  - Kathiravan T <kathirav@codeaurora.org>
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 49e9755b3a90..000d61afbea3 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -25,7 +25,8 @@ description: |
   rpm_requests.
 
 maintainers:
-  - Kathiravan T <kathirav@codeaurora.org>
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
 
 properties:
   compatible:
-- 
2.32.0

