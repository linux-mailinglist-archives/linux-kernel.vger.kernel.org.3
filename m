Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77623515801
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381330AbiD2WM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381312AbiD2WMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:12:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57263DCA85
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:09:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so8816011pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MoViicfii9p6utWoae7ElSIZUS07VgE/0ju82SmR24M=;
        b=k7HcWctvtlxZkalvnAZe0Z5u5NOvNI94X3lEw6NY1VMBjEzPyVc1CrHbTxTLGTkZrE
         SrzihBdRRB441L87xO29eXdylrY5XRz9RfsoK7jc97uXxY3sZ++1ES/lN5qsMvbYBnWT
         AZAjM5U+7f70eK/wKjZhIagWjQkF53uolMKAKWuTe80FQ/1c+z2fuDR2/bWu7hecXeKU
         48A96M2TMQcjDl5drYDR5a14TtAN0oP8Pwmri/Ue5JxDhXNIezxWgdhILbMt5c9SIG6q
         jTnyMCuYWg6yB4XKGsAyxnaeCTepcpz0EDLZrc0TwQOWbk2qWhSaiZIcli85i4P5S1MV
         9iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MoViicfii9p6utWoae7ElSIZUS07VgE/0ju82SmR24M=;
        b=4i/Mt2JzYi0a7w2Ju1vS64gJI0t1nnsPKJzNAjnA/b8j1X+soc7ZuQi9QjO0kmiXRq
         8OxjjkSNdclQzWuuuABl8oxWv3Y0/I0hCdCaCis0+l6z1d5Io2sJ8X3JV1rj3OFRrLQ/
         5mzDi+EDfdnOea4zahBjAS/5/wvWHt4E3SpJGpVeJJbYpD3ULXS5wvmN+sy4ZBNuk8Z0
         rvT183A6+0SLYeazSbjJ+o/BBnGvPdjpGNyC0BPus4RRfP27Jda8aII1cUA5ibRwzBxh
         h9XppqBpHCOIB2pIrPUz6NgDsyN4z1iU/Ye3ubQw3lOo55UPb9ypiJl6ZSEYo70/9xBG
         yy4w==
X-Gm-Message-State: AOAM5313jD6fttSSesxsLqSA6SS55MTNjATPZl5lzf/jHjqOJsp1XYOE
        AyYztS6mx6BplYo1Wbw21tBj7g==
X-Google-Smtp-Source: ABdhPJxZ+EEi2RSJizGrNsZtppHOgq1GzCFOC9SGroJ2295J2M1o09ttfhXrciO0rwIXevRIfOUwBA==
X-Received: by 2002:a17:902:e743:b0:15e:8ddd:c7bd with SMTP id p3-20020a170902e74300b0015e8dddc7bdmr126045plf.128.1651270139817;
        Fri, 29 Apr 2022 15:08:59 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b0050dc76281c2sm170020pfa.156.2022.04.29.15.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:08:59 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, robh@kernel.org
Subject: [PATCH 3/4] dt-bindings: mmc: sdhci-msm: Add compatible string for sm8150
Date:   Sat, 30 Apr 2022 03:38:32 +0530
Message-Id: <20220429220833.873672-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sm8150 SoC specific compatible strings for qcom-sdhci
controller.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index c33f173e3b6c..4eb213b3e551 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -35,6 +35,7 @@ properties:
               - qcom,sdx55-sdhci
               - qcom,sm6125-sdhci
               - qcom,sm6350-sdhci
+              - qcom,sm8150-sdhci
               - qcom,sm8250-sdhci
           - enum:
               - qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
-- 
2.35.1

