Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6B583CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiG1LRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiG1LRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:17:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E98066B91;
        Thu, 28 Jul 2022 04:17:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b11so2561992eju.10;
        Thu, 28 Jul 2022 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N83H3oNoMy8JHMUEzp53BdqT7RoVkSAfEBNG/wDBUjY=;
        b=KJ31dxfLCoduc3d+IUQ4kYZGBFU9qgO6NpH1r1tQdmXzhJK5hAS1eNJIZ8fxOn8yh6
         Z/o3zOS+FFE35ypH1nQBMun8Bz8pUMKfZBfIcJVmLmVPjVopXYGfiI3/2IVwepuSP7vl
         7KfT2PI0AEAvHb2y9Ds8HoJjVHe51KtmO7msgGIDKqN23xv9lL+b06FeVvdbfnNeDJmZ
         P7k26HyxRYKI5KhzIXYnnrIEB3WeGvZ4ffAzyxb72/BfkzZnCcaUy85az6/U9ZMqFyT+
         7S17hT55n9lmMXkSUeLE+gesvHL0WRIneeZesrWL5SlyEDsukYmopSnKtidq+ZbQlxwF
         KMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N83H3oNoMy8JHMUEzp53BdqT7RoVkSAfEBNG/wDBUjY=;
        b=DH4tAg0hL8csT9p3MqPOP+rwYLJ6vqIj1u+5FjKnb5BVIsPsVsBBd+QyX1bzmy1tlO
         kUCpM0TzlDlVn2JKRRpyuoOMgLa5yW9dXqLqWHx5qbM1i15YIV9WKsC4+UIJ9gmejV83
         cbb11zFzY110DU4mF/6k7mTm9iyZbyoFZSZEiPziRNaL20sibtGpXS1wkruGyc3CmqOp
         g85uxYRH5PtnSytlNkZxMdcI+3KJz5pofH+M+y9T4aXa4Y69zn9uAeYdyC8a7jtxoCuj
         f5sf8hcmzXrXpNYRGhsg2PMIqD+vj7yb1W+LEi921ASA7j8/yxuspe/EAnuykVHyXjSW
         wtxQ==
X-Gm-Message-State: AJIora+QlPjLQd1t+FMF6QfxE28fXhYpKo8o6B1IYzN8lN4qCpiXI2PU
        DuFttu0QT/7zoQL9xiMuDkk=
X-Google-Smtp-Source: AGRyM1vXSWZ9gd1nNMzlzAm590GmiXr4VsPK8b3CHS3FghSTTsgchUiKEiUDMcNJ+mU0tZwLN7VSQQ==
X-Received: by 2002:a17:907:2724:b0:72b:496c:568a with SMTP id d4-20020a170907272400b0072b496c568amr21163184ejl.305.1659007066439;
        Thu, 28 Jul 2022 04:17:46 -0700 (PDT)
Received: from brandenburg.sect.tu-berlin.de ([130.149.39.100])
        by smtp.gmail.com with ESMTPSA id w10-20020a50fa8a000000b0043bdc47803csm517957edr.30.2022.07.28.04.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:17:45 -0700 (PDT)
From:   Shinjo Park <peremen@gmail.com>
Cc:     peremen@gmail.com, David Heidelberg <david@ixit.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: phy: add definition for MSM8960
Date:   Thu, 28 Jul 2022 13:17:40 +0200
Message-Id: <20220728111740.30595-1-peremen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the changes introduced by MSM8960 inclusion.

Signed-off-by: Shinjo Park <peremen@gmail.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
index 0655e485b..b3075c5ab 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -40,6 +40,7 @@ properties:
           - qcom,usb-hs-phy-apq8064
           - qcom,usb-hs-phy-msm8226
           - qcom,usb-hs-phy-msm8916
+          - qcom,usb-hs-phy-msm8960
           - qcom,usb-hs-phy-msm8974
       - const: qcom,usb-hs-phy
 
-- 
2.34.1

