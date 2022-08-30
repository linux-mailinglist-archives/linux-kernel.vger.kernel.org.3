Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF55A6B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiH3Ryw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiH3Ry2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:54:28 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7350A6E8B6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:52:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id k22so12170656ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=VTjkGMpau5/qRAdXn0AI5h8erS6BqzJeV7Kg59cVfQA=;
        b=Oi+RM+tzjrXAvwWJ/1F2E+IM9ParyeuSLNnrQVs15TSAVeSuAE0Infw2CS1/QiRQS/
         LlAQT6OHgfQwX2CiMKnx8lxZWKGZdYZtf3T1/+Wd6XEyxWKdC9/VoZx1W2IH3dnCyRxD
         vQonf5rzfi99B9n08RlW2+poiVwtJHH2/2gifP7L9jg1a8ZF7bS7mXRQYgDt1NnvYfEd
         SPAh1G+E2H6fiF2PX9PkBJYaQbdvyveYL7JizYQL0yGeSgbJh4AaTSK3KKOXPLrFkADV
         0HleTJnmPIEmZYXw6u5uWrWSGv2vJSrgFw+A28jF4U5nFY67+KbOj/DAdGNIlgIKDg2F
         lmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=VTjkGMpau5/qRAdXn0AI5h8erS6BqzJeV7Kg59cVfQA=;
        b=W4e7qzzEfCLGuJIXiVSTriQkWivnyTWhzGrkDr+k7p60GA/SLDTuCc2+M/IzJ296Z0
         BQvif7soc4OXwKwStsaB2uxpLZFck1Ngz6GwBvaQZbgoFMr9pzFRZpGCky3QkJ3U09D9
         QOJmTeLbuj3cXKWDUTtoNQv50AU9AR/BOR2UdR8Gt+e08tjD1xLB84FigNqKt9iEZuSO
         9gd2kq/dgsb5Q366qVKBwNuccsuSLA7rUuk22UajDvoiaAKxUIVFUTCT7c3wMMN4V16J
         MOn342tpcfVMNG/LCVbhtHvpj3U/4EtkSdiLwq2+INoIS5psNzal59aC5HTjLV88MNTm
         oaNA==
X-Gm-Message-State: ACgBeo2Et9N0bHZ+2MDfYZfNb3nLH+TxFkjkbwBGNn6FeZEBxAplvj3P
        THDlY9vloU4GhnoFAXXyzAbFvw==
X-Google-Smtp-Source: AA6agR6YVxd1GqkYJZb2vCNU9Na2hZJBEwqWFfETlz+jgEblX/6iRSkfaYv+JTOwOExVYOZfxz5+ZA==
X-Received: by 2002:a2e:b8ce:0:b0:261:ada1:d803 with SMTP id s14-20020a2eb8ce000000b00261ada1d803mr6901699ljp.143.1661881933438;
        Tue, 30 Aug 2022 10:52:13 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id z16-20020a05651c11d000b00266461bf934sm653420ljo.107.2022.08.30.10.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 10:52:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/3] slimbus: qcom-ngd: use correct error in message of pdr_add_lookup() failure
Date:   Tue, 30 Aug 2022 20:52:05 +0300
Message-Id: <20220830175207.13315-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Use correct error code, instead of previous 'ret' value, when printing
error from pdr_add_lookup() failure.

Cc: <stable@vger.kernel.org>
Fixes: e1ae85e1830e ("slimbus: qcom-ngd-ctrl: add Protection Domain Restart Support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct typo
2. Return 'ret' instead of again PTR_ERR
---
 drivers/slimbus/qcom-ngd-ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 0aa8408464ad..f4f330b9fa72 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1581,8 +1581,9 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
+		ret = PTR_ERR(pds);
 		dev_err(dev, "pdr add lookup failed: %d\n", ret);
-		return PTR_ERR(pds);
+		return ret;
 	}
 
 	platform_driver_register(&qcom_slim_ngd_driver);
-- 
2.34.1

