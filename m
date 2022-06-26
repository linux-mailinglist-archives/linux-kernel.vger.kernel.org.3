Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E955B2E2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 18:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiFZQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiFZQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 12:43:52 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F5BCB1;
        Sun, 26 Jun 2022 09:43:52 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id o43so11795303qvo.4;
        Sun, 26 Jun 2022 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3GBCSIEET7lQQDMpyMhapaXuicqozmAAusW3d9z5eU=;
        b=MQdeNhJOgbHObGV7N2uUjTckfvl872czwyyiN+TGFMq7PCFf8He1aYPI5+rAn6Zbzu
         B4jaEA/0NHdeKYnI2y5f+Tu/Ka3gv7zWH+ol7lJyfsbIzckVpeLsP8jBUsgpTXp48boQ
         Hhujh96c3Gl9xSBF79IpJdgOUxeJO3LV+Fb2vw8kSaDWcQCWYgxkO44Ibfs9ia2LVhvO
         xqi+b4IDQ+kXVaBWTP+JRV/U0o5PqyFDAGN5AbR42SrkxzlKQpmwJ6TN8SlCGAlEUJqc
         lXdSioTOWjLmDX8wUBBbrgCoGs/eNSAiJ+0NJsXniVUbX0Et/wg9E+lT+dzK1IWdkUNQ
         U5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3GBCSIEET7lQQDMpyMhapaXuicqozmAAusW3d9z5eU=;
        b=xo7H+YgNlmL33Pwqc1FClzfOrqsG44YgwA0Mbv+M+BO4C/xzW8bJMgyek9Bh56CQUd
         t6I9OE6OeLHiEGSYu94Vh10kctwETWz4XiyUBUAwusaLpt5pejCLhTE0QrisHamqChSY
         SoWrizJkPWd9TfoRlzZkm4C8aCwwOhfDQ5XeOIQ4bf3tvsHHI2BYCyCWpxGA0E2RReAZ
         S8mDS+3wCiXOh0wVbNdeWC0GdFPW4r15oOLf5tjh6jo+OZzZkFNUDT6JJ8aSOvicL5No
         Z1bamT+j3nv/rBHSEIMP4M5svarIDeUAU1qMY2s3XC4dnulB9DPxMujkGDYrzl+Caret
         +kfw==
X-Gm-Message-State: AJIora/mPyGLnd9NhYvwcd1YQkkzkA9Oc0RX4hPxmf6in/zbmb7x9Z4Q
        g1+aWEhAJyty6jiTLC+/gQK6x75Zq6ocsg==
X-Google-Smtp-Source: AGRyM1sIZk1rFbRf6GYKFymjzajzrnIyFKzv4aYRqReldoB1rEQzteUfKMfuPMwXdSCiyqwiYJKBeQ==
X-Received: by 2002:a05:6214:212c:b0:470:5ffa:ff3f with SMTP id r12-20020a056214212c00b004705ffaff3fmr6376247qvc.126.1656261831388;
        Sun, 26 Jun 2022 09:43:51 -0700 (PDT)
Received: from numbers.. ([198.179.6.194])
        by smtp.gmail.com with ESMTPSA id ey14-20020a05622a4c0e00b002fcb0d95f65sm5306182qtb.90.2022.06.26.09.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 09:43:50 -0700 (PDT)
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
Date:   Sun, 26 Jun 2022 12:43:33 -0400
Message-Id: <20220626164333.14999-1-newbie13xd@gmail.com>
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

