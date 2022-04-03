Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438484F0A63
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359081AbiDCOxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbiDCOxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:53:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE5739B88
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:51:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w7so6664651pfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3zoiG+f8JGVz1ginGh+WpIukd/W3+NQcd9twqB58ow=;
        b=CIoCQkSS489lEotJcZBHd+04zDuXDDXDYKYJZuzwgbGIlhXOEODtPh/a5YBZK/EGEU
         pT0RHCxnLecm1YAcuE1ghwkswn0645UV5E4LvwFgd7S5rwjzPU7GOo8eoa7RXtnJsHll
         D7nrFocqA8phI8J3WmN5O2mfK53wigAavkYIxvmd9Ts7oDlUQK7lsPMob0ar3KypaOEx
         QnOcNiE3YR2H5GwGYaXviBqLwxB1jjd+P6mqBFsrp8yeNL3DlM9txhwmbL9tdQBXPJ3N
         iHG3TIOh9qd1VKyI+7wIv7N03vMXqUFIhVErOKqlg3iCXvdFYKQjPMrhSmYbJEQYUFkv
         lNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3zoiG+f8JGVz1ginGh+WpIukd/W3+NQcd9twqB58ow=;
        b=mL2eZ2wLkH7DIQurAoqObiKiEHVNvDwY3CA90PiJc4vQby5AJtLKX3CekWxFo0Zyth
         TslZjaBcviph5iKawUnsNJWyUjJwynem3+VeXasLIfHWCMgp2eX8ppKCBMb1VAFA9Oxa
         tr/rghhneQU061AS6Xd87hOjKzMAcQHo/CuCiotIKQAq7bt24KersPTUKfW3yGi8+Z25
         W8KXH9oykoVY2UJLYR+m6/4ZIGHyu2/IYDhXWHDqnIILYTc3GNtvVq53IvlUZqhB2YWi
         Hq2hDqXGOodmXKVkr4Se0NMR/DnILA0F0pi//YgdONt9fxIV/5v+95KYJI7IDqKRSefi
         3gOA==
X-Gm-Message-State: AOAM532w+xlhZf90lpqJ7T1gPDGhEcFwtLzhd2FXIrzEBkyy98HetOs0
        YO634Uy9K75A3r5ab6tOZ+Ze4A==
X-Google-Smtp-Source: ABdhPJxVDBJsPqv4DSqoOQ3FQHpF7gQd+oUwex0arHcl2zipNPRUICKpeUltEhkTAWQELAInNzV1Zw==
X-Received: by 2002:a63:d257:0:b0:399:2df1:2fc with SMTP id t23-20020a63d257000000b003992df102fcmr252809pgi.268.1648997507541;
        Sun, 03 Apr 2022 07:51:47 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.251])
        by smtp.gmail.com with ESMTPSA id q6-20020a056a00150600b004fb2d266f97sm9317866pfu.115.2022.04.03.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:51:47 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/1] dt-bindings: mmc: sdhci-msm: Add compatible string for sm8150
Date:   Sun,  3 Apr 2022 20:21:33 +0530
Message-Id: <20220403145133.93583-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sm8150 SoC specific compatible strings for qcom-sdhci controller.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 6216ed777343..35a7d78da213 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -25,6 +25,7 @@ Required properties:
 		"qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
 		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
+		"qcom,sm8150-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
 	NOTE that some old device tree files may be floating around that only
 	have the string "qcom,sdhci-msm-v4" without the SoC compatible string
-- 
2.35.1

