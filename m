Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE055B291
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiFZPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiFZPMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 11:12:21 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50B2DEF5;
        Sun, 26 Jun 2022 08:12:18 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id t16so11639322qvh.1;
        Sun, 26 Jun 2022 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIHQ1XpTztOaVeUfTC02wJu16rSVdYLWoc8bvY9/wXI=;
        b=MYZ3tPwl+Bhl9t8FrL5VGynKKGhVinL0sxa1inw/eEv1w/Wi0o6YYImnTRptlOAcFE
         MOmD9p5Rm4n3VNvhjTIgi+hCwguNUXL4JCVZWbpsWEZFgY2qVnAIBqaFz5UGyPph5W++
         QapjX2aw8okw+IgYCvT0O0QyKWnpe3UTGVMg348KRaWfFwl3f/wCAjiFBCSVkDAJPvJj
         EGOPrEhNIR/tRawleE851pBPTU/K/iCRE3DqAybEsN9B9jj0dO4FeIqwDyBdIekFdMyT
         gMOrnBydBSAItnv/vUuRHpR/AuV+eA1uCpL0E2tBuz4N4Lsl6FaKlX1dwZI7u+5lhYhY
         tm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIHQ1XpTztOaVeUfTC02wJu16rSVdYLWoc8bvY9/wXI=;
        b=3lTuAYn1DYpMhnjsb9WlL1q6mP3DxaAF3vU+fyfaBcB55mKZsnLNf8vcmhl7V/OT0G
         WO788IySRxkJLAqhhWM1dYsk7QXZ38yEHKpiurZm4YdUAcQ5lvMtFpD+XmHZTpjV7Sz8
         xMd2SJIUV0EkoeGB7FifrR4t9X9+5e/R78PabG35a86YT2qclcKczk+JfL6AiX4P1fwO
         FqS+rucV25+Il+a37xK4LaG3SREgh0erWLDCgdNc37jOIEExPqZtAdyAE9mqXwTI4UbY
         +cdth481jXROCM6bgLBeMJX5iVYVCfFeDQat0LIhQLDhof3Gq99H4rSeY2LTuZHUusvM
         C8AQ==
X-Gm-Message-State: AJIora+Hja1KW8MyHaU7IvGziBzb4scVMEysuyErldkp6XlfizpcFcKd
        omyJwPmv1JP7XWNCbajcLKL4cBHUJ4H7gQ==
X-Google-Smtp-Source: AGRyM1uvNBK+/+XA38zP+7jnhH6UC3DwXJNIEZefo8rpfz2Ir1E0S3geebawTosGE3Z26CGtNqbX3g==
X-Received: by 2002:ac8:7d85:0:b0:316:80e9:d792 with SMTP id c5-20020ac87d85000000b0031680e9d792mr6469396qtd.590.1656256337790;
        Sun, 26 Jun 2022 08:12:17 -0700 (PDT)
Received: from numbers.. ([198.179.6.194])
        by smtp.gmail.com with ESMTPSA id x4-20020ac87a84000000b00307cac53129sm5193462qtr.42.2022.06.26.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 08:12:17 -0700 (PDT)
From:   Stefan Hansson <newbie13xd@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Stefan Hansson <newbie13xd@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Document lg,judyln and lg,judyp devices
Date:   Sun, 26 Jun 2022 11:12:12 -0400
Message-Id: <20220626151213.10159-1-newbie13xd@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the LG G7 and LG V35 smartphones
which are based on Snapdragon 845 (sdm845).

Changes since v2:

 - Rebased on top of
https://lore.kernel.org/all/20220521164550.91115-7-krzysztof.kozlowski@linaro.org/

Signed-off-by: Stefan Hansson <newbie13xd@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index cf025c64d494..bc16f58082be 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -282,6 +282,8 @@ properties:
       - items:
           - enum:
               - lenovo,yoga-c630
+              - lg,judyln
+              - lg,judyp
               - oneplus,enchilada
               - oneplus,fajita
               - qcom,sdm845-mtp
-- 
2.36.1

