Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CFB55B301
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 18:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiFZQpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 12:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFZQpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 12:45:47 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDB7D11A;
        Sun, 26 Jun 2022 09:45:47 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id u14so9131990qvv.2;
        Sun, 26 Jun 2022 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3GBCSIEET7lQQDMpyMhapaXuicqozmAAusW3d9z5eU=;
        b=Vpgi4rI3AE45dO4Y6ClzWiH09uCwy5uYeUbEkMZmCcL8iRT7TusEkfyKoLFgVimipZ
         1aTNOu0GyhEDM1HPfut9RMP7hKaXrfMzU8ok9teAcaumlbLXtr5aVprmIa8xhHqUvNS9
         pd0zxaoR11kzqdUmL2Ah5qIfvNIqBeEDTdPbrDFb3pIpNAN/nhXU0LctK9eHlSdrNaTf
         SY3/ZeGOGO+4Gt3/RJeBswhIwN64k+zgiUsjNCODeQ2uhO8SundqfFn1gEZ1vEA/7rFt
         6aWr2WXrHG8nKe181zP7QDZG+y7utsyUPu3BJaFb7T+EFR/FDe34ZxQOJUyw9JRT+YX2
         G0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3GBCSIEET7lQQDMpyMhapaXuicqozmAAusW3d9z5eU=;
        b=j0nZetkyDHqtVzXP2kUU98jkM5z2xj29xE/VkNRDS2sZt14GFlc5atlYD37sEQWLZt
         +kLnDVt70pF97TGSQHYe4q0L5TPKOSj87e+W+8u+pNguwJCD7piHzou2JSMefH35Q1vQ
         fCnMxWY6eNqh+X1HZ1js7cviAnG6ZTOMlz/Ed0BMwudH3pi1OMb5D3HWf5HbEE2sct/i
         JIMiT5ua99LFpcQx0BI44j126MWbjPPEkXtu4+4QNRIMD+ivqa/8pnaM1wgNJwUAJEDt
         gGKX3PB3olXo/qD/M9rvO1D2kGj9Js8c38ZQTO/Qa9ogAP5QW2KjW/vgVgdG2z7jFyyC
         GJgA==
X-Gm-Message-State: AJIora8sgzfoRQmFq0aostOZR61eaWsvU6/uT8qq3+1mfw3JSVChingd
        KvkKfi/zbtggTxEZqD9fnYg=
X-Google-Smtp-Source: AGRyM1vWgb2JehqoQOHVCrBbl51e0c+1wuwpJ6IKQtpKK1uCU80NgP518yHSDqU89JBAhZQY3i8/pg==
X-Received: by 2002:a05:622a:11ca:b0:317:ccf3:b272 with SMTP id n10-20020a05622a11ca00b00317ccf3b272mr6745471qtk.306.1656261946391;
        Sun, 26 Jun 2022 09:45:46 -0700 (PDT)
Received: from numbers.. ([198.179.6.194])
        by smtp.gmail.com with ESMTPSA id v26-20020ac873da000000b00304dec6452csm5388181qtp.78.2022.06.26.09.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 09:45:45 -0700 (PDT)
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
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: Document lg,judyln and lg,judyp devices
Date:   Sun, 26 Jun 2022 12:45:36 -0400
Message-Id: <20220626164536.16011-1-newbie13xd@gmail.com>
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

Signed-off-by: Stefan Hansson <newbie13xd@gmail.com>
---
Changes since v3:

 - Fixed changelog location

Changes since v2:

 - Rebased on top of
https://lore.kernel.org/all/20220521164550.91115-7-krzysztof.kozlowski@linaro.org/

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

