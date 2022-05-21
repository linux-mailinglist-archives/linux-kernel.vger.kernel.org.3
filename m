Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B432852FE5C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiEUQrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355429AbiEUQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:46:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7067F1182B
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id l13so12342905lfp.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gfwB5OaJD6dYd8Av6mbHzfIF+O7cvkxi6oQNkSu3FA=;
        b=t4RVV0qWK1L99UOAB1CvSXZhv6VGD8tO1u8gjKzvogg4rmhgN9IlCii/NxIG9iQcJo
         JqhBytdpOqT/YklOPfoXP8bjC5/Ow0UgDUqXdHfhEUIoFvhE9tvuCfBeECYyWbzMb0Vh
         CkpGYeyiMnn1T1HGEN1dQjMAoGRmdaExw9A4dmZFreRjIseks4l8xfpbnLMv77vUSev/
         aEwSjcgglqs+GhwFEAIqt+EhskKt6EbQ3nr+0WV8kqyluJANrMRM0MIzU+idXEmrfh5Q
         brHLAkUbeLbfCO0g8vlpeAPNpyrwO+StiLIex3pNePXZEEEuxnMsr07TqBYKIo92DQiy
         Aedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gfwB5OaJD6dYd8Av6mbHzfIF+O7cvkxi6oQNkSu3FA=;
        b=6N8sVCjMGP2kG0LXKNka1uTfyuCvHuiEcifL7u1schYjvXTGM7YJN5WttZFcQo4qR5
         pC1htEKGsNAQa0OIftlNdMN/VlQmqXLawzbwIXuGMi83YbyxQ0ukzDlnp7ouYsseB8Be
         PONaO+6MECzwurnwg0/ZGwBT+qS9MlNEh4Hk0RnomnpAmy2iRbpbGumc0DFlIdU/hVgK
         jlASH5AXjj4ZfSfy0dDtcbf9V/cAzz9lPEZMCUBeYw3cFozVo3rZ9wIFe0fkCeXH53CS
         EH8cojkGRNQZ/X1UM0o6RrWFQLACLXBcYaqvm2Y9SsjIZ0XHdLb/tWtJCFwM96vg/4tP
         NiGQ==
X-Gm-Message-State: AOAM532tmuM74l1GpmTZmufwrYcxWKztjmb9Hh3Q32i9R5pDY8Bm2TPS
        LlNYM6H2gjOWwWYwq880VnAXEQ==
X-Google-Smtp-Source: ABdhPJymLA7hvfxysiSPhj5B806dvKV4xjLhcIIRvKVIz7Y024/cVce2Kc8IELBlD4Mlt/FX3xhnaQ==
X-Received: by 2002:a05:6512:2386:b0:478:5590:c977 with SMTP id c6-20020a056512238600b004785590c977mr5619318lfv.127.1653151560587;
        Sat, 21 May 2022 09:46:00 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f26-20020a19ae1a000000b0047255d211cesm1114282lfc.253.2022.05.21.09.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:46:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/12] dt-bindings: arm: qcom: add missing SDM845 board compatibles
Date:   Sat, 21 May 2022 18:45:45 +0200
Message-Id: <20220521164550.91115-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
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

Document board compatibles already present in Linux kernel.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index c4fc6dd09ec3..84fdb4f337b6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -338,6 +338,21 @@ properties:
               - qcom,sa8295p-adp
           - const: qcom,sa8540p
 
+      - items:
+          - enum:
+              - lenovo,yoga-c630
+              - oneplus,enchilada
+              - oneplus,fajita
+              - qcom,sdm845-mtp
+              - shift,axolotl
+              - samsung,w737
+              - sony,akari-row
+              - sony,akatsuki-row
+              - sony,apollo-row
+              - thundercomm,db845c
+              - xiaomi,beryllium
+          - const: qcom,sdm845
+
       - items:
           - enum:
               - fairphone,fp4
-- 
2.32.0

