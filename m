Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A252571D51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiGLOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiGLOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:51:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8965BA17F;
        Tue, 12 Jul 2022 07:51:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l124so7667138pfl.8;
        Tue, 12 Jul 2022 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1Tizn7ReuniA3QRV5u1tt09n7x6OjmxExAXJYs6xK4=;
        b=Uu5iH68CcLbl4s9NpaGtnd4syR1tMhJ5Vy2j0bdg3iXbYLBtyhLe8wcMTw0P/DbY8A
         F31jlpYxpHnpr8GmSm9mLL2pnwzTI1NgDGtRmOCSoujf3A6WigwrSL3QBldjG5nLX7ZS
         sWGBWWbVZapagdySfWVvZGODJQ8jWc1UhpVFQauxJbU3/GLeb9txKalaK4JUvAx2SuYG
         gBtrJELeekbs9SASNALkZqjijoVCvm/wGBDi9sZGw9uDJZ+X2WinobdzRHIYIiVFpsOU
         YvqadQm4iKT5nQN1zwT984K48+GcqZhwA6lw4IJZNbmMpbaVI+CEspEkT39W0zI3Tdm7
         Aavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1Tizn7ReuniA3QRV5u1tt09n7x6OjmxExAXJYs6xK4=;
        b=PSZCLUcQLktaPU+IsznR6h5A/cmmSAOj4LEUKFz36CkHU4jGEy9ck5XP7o1scld3BT
         nhnQ+2UNYX7rciDRkodfwF5CGnNBvbVRHTs4mZUZd/VjW2wfBfmxYpthtCOt6NJOmAhd
         SiCPfgxwxyjEYolaNy3/HUkrA1hA41bEq734nXNwEZ8DVxfIun8/1x40n8+UP8DUixFv
         DUtb4EyWvmyfkT42OXAv/qU+fDtnuVnGsHiCxubfwTQ+5yiI/lz7vkrYm9OvXTThnmw9
         AQ67nkzhvQLc0j6YsVxgtcwWBqV+PW2F80QMZ6V1kJaqI5wm4rZy//x0yOoF8K6g+8ly
         T3bw==
X-Gm-Message-State: AJIora/TU3t88TIC993shLhIjELTzzF7vLRZfcIOjKFiaFX6z+py4Bfu
        YlVTb0/ygf6W0kKLe823PGU=
X-Google-Smtp-Source: AGRyM1vtYFCfK2Xj9SteX78/tUjbDahenzMUS3LxO9ubungtJ4sauypDsL+4f75WIf8f74sr9Z2Lww==
X-Received: by 2002:a05:6a00:194a:b0:52a:d6ff:22e2 with SMTP id s10-20020a056a00194a00b0052ad6ff22e2mr8355015pfk.10.1657637511463;
        Tue, 12 Jul 2022 07:51:51 -0700 (PDT)
Received: from localhost.localdomain ([112.0.190.94])
        by smtp.gmail.com with ESMTPSA id o11-20020a170903210b00b0016bf1e8f1besm6876926ple.28.2022.07.12.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:51:50 -0700 (PDT)
From:   Molly Sophia <mollysophia379@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Mix2s bindings
Date:   Tue, 12 Jul 2022 22:51:38 +0800
Message-Id: <20220712145139.9473-1-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for "xiaomi,polaris" device.

Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 02087bb1f698..cb4efd43dd2f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -353,6 +353,7 @@ properties:
               - sony,apollo-row
               - thundercomm,db845c
               - xiaomi,beryllium
+              - xiaomi,polaris
           - const: qcom,sdm845
 
       - items:
-- 
2.37.0

