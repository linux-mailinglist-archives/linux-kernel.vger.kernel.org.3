Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7EB50F279
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbiDZHfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbiDZHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:35:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7BBF69A7;
        Tue, 26 Apr 2022 00:32:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w19so30346435lfu.11;
        Tue, 26 Apr 2022 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECSt8WJ9R352FecYhqnYcCZ/BQb6Kwbuk7sd9ia4Ebk=;
        b=kk7Kf1Je8VkUrvZdZzqrsYPbpXJVFXCvyi4SiINGP0qIo9wGN9hytMEpx/p/oVpuCR
         P9cLb1g/OYhlr0DaDQlP1fT5sZ2FeYxmbE5IW4q/dM8S2lm45gJhTJbJG83Is8C9bKZC
         UjONIEt+Ij2x2bd5U/K9DTx5f/CgWseTvKGxVuSONDShsZN1kBQWYBUuWK4NttnSD/Mt
         ZAxIG5FppY/7gb/wrzxzdbBxL59iKyn0ZrkT3VsfoBvymEmyRfKoUu/K4b1kbkMCBxYh
         Q955w44hE4ZT3Rt+Am4Xynmn79gpPBVKX0r7uEpcY3t+fKnxpCZpAlqnwh9aw6mpbc9c
         vNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECSt8WJ9R352FecYhqnYcCZ/BQb6Kwbuk7sd9ia4Ebk=;
        b=o60B2EbRnghHVphgQkxaRqgq104l9LP7MASMCGvUjv74ZUFB3T6Z63KjFP+1mK69hC
         J8Et4XDWtAb+IMjjGKQN11R/NRjXsfCMYzylHbERRfQgLgfs+4YIrcjDGbPsHrkwlHUx
         4h90sfOnr2xI41VtZRO+xLkwdNEVffufyfN8TSWSPA6w6dErEj2oJS8sevtHZW7KDwqA
         8tX8qq5goZdjW4Xzu50YHx/eM2JiBkySChD5uwVnwm27kn0ntDll1Zlq10xayl10DhWX
         6uMM0Uvtpy1VXzzCvY+rnhH+T+kU9DxIFZ5Q9QVAN7DWNunPGU/MmuhTv1b37slmhyIs
         2oFA==
X-Gm-Message-State: AOAM532RKlbA1PlHw5DWIXhjw3tvQ2cMmsd8mz3kMACFSu6FRHBSkVKa
        TFbDXVdy8oY++MSPHtTCppLmsP6LJwo=
X-Google-Smtp-Source: ABdhPJxTfADyf2Jwdwc7mfBgLYaQor0quobDcB2O3Jr5F4Z9aUOe05l235b6tI0VuBugDHUG3b4tCw==
X-Received: by 2002:a05:6512:ac4:b0:472:10a8:a1db with SMTP id n4-20020a0565120ac400b0047210a8a1dbmr3464852lfu.610.1650958332742;
        Tue, 26 Apr 2022 00:32:12 -0700 (PDT)
Received: from localhost.localdomain (adla4.neoplus.adsl.tpnet.pl. [79.185.4.4])
        by smtp.gmail.com with ESMTPSA id d2-20020a056512320200b004721999f1cesm103509lfe.66.2022.04.26.00.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:32:12 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: clk: qcom: gcc-msm8976: Add modem reset
Date:   Tue, 26 Apr 2022 09:30:47 +0200
Message-Id: <20220426073048.11509-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426073048.11509-1-a39.skl@gmail.com>
References: <20220426073048.11509-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add modem reset for MSM8976.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-msm8976.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-msm8976.h b/include/dt-bindings/clock/qcom,gcc-msm8976.h
index 51955fd49426..5351f48b2068 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8976.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8976.h
@@ -224,6 +224,7 @@
 #define RST_CAMSS_CSI_VFE1_BCR			7
 #define RST_CAMSS_VFE1_BCR			8
 #define RST_CAMSS_CPP_BCR			9
+#define RST_MSS_BCR				10
 
 /* GDSCs */
 #define VENUS_GDSC				0
-- 
2.25.1

