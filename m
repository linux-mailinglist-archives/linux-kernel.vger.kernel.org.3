Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D231F510CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356132AbiDZXg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356107AbiDZXgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:36:22 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306253191D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:33:13 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w23-20020a056830111700b00603c6d1ce73so9356otq.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ccHpfjKvoYsLiN02b0zGlFTRc8MFHHJZhCSYDZSrEEQ=;
        b=lj/6ts4BRlKuC0/uEuX3u3t560IJg632JClZpIPFMZFQgaKDYrRiDDroMO/lzORUH0
         GJRHOOk6KNcUArQytWA9UbOTPQAdOW2k4VLEHSqO8IGMskDWx44S16zN4hMTY0ee4nVj
         u3JDcMVWqXtnEcztMZf6/fUzqKqBfIjRn318VAuLO4iRjNUtG/cfMW8cJHLn0Ub8hPY1
         hu6W3U4Aph8/Sasc+cbiflC8DkhphJDyZslPT85ehQfTDoudYCKP5R+N4sziCknDaKig
         H5GDPHOxAo48b6w3RUFId1LGq46ceWv6fnbj7bf8UIjKJQauEB7MEQVqHZ/tdkpUW7Jt
         sbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccHpfjKvoYsLiN02b0zGlFTRc8MFHHJZhCSYDZSrEEQ=;
        b=gGN7tTRv1+9PcWGSS8A15w6M0Igm08g1UNAm+tFAWrTmKQ6OuzgvQ+qKKTMAbEA/Fy
         dMSnvw+s6A85YWclDMrc2Ba+5s4kZv9/U/3J4G3+zr/wiS8GbRM2b73tQSok5w7ymaxh
         Rgks1jsY4I65yOsrhMEdEx1Cd6iSQnXnuMI4uxCPR9vnq6IY8EfzoBgQu7rd5NQsJMmN
         WPECVmqPAoQVX6ZswsoIB/RcJswebyqL8HIR2vopOYxaSm8ey+ntFvHVcZ2uElcgAIoJ
         7LSB2vYABgFQh+WHl+r13PyHFowW5yec2QScpv0KtG01Qt+JJtO9sITgJlhH3l2xByT8
         SCRw==
X-Gm-Message-State: AOAM5323KQGYUhLNxqQ3vei1Vp64kB32gYBPRizvV+b+j27keGlI4CW7
        HfrqeTD/N0ZN5mka4i37bLYLNw==
X-Google-Smtp-Source: ABdhPJz0++1dtaAhm5LlWPwSNAOOQfegDPdLRIQM9uH5pO+2yUAAJt0Oz1MEBMP7/W5HrF5vieDpfg==
X-Received: by 2002:a9d:9:0:b0:605:a536:c500 with SMTP id 9-20020a9d0009000000b00605a536c500mr5508638ota.384.1651015992545;
        Tue, 26 Apr 2022 16:33:12 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k2-20020a4adfa2000000b0033a3381a7f1sm6151658ook.44.2022.04.26.16.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 16:33:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: power: rpmpd: Add sc8280xp RPMh power-domains
Date:   Tue, 26 Apr 2022 16:35:06 -0700
Message-Id: <20220426233508.1762345-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
References: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
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

The sc8280xp has 13 power-domains controlled through the RPMh, document
the compatible and provide definitions for the power-domains - and their
active-only variants where applicable.

The SA8540p differs slightly in the power domains exposed, so add a
separate compatible for this, but reuse the constants to allow sharing
the DeviceTree source.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added sa8540p compatible

 .../devicetree/bindings/power/qcom,rpmpd.yaml  |  2 ++
 include/dt-bindings/power/qcom-rpmpd.h         | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index b90c4427beec..ad77a6380f38 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -27,10 +27,12 @@ properties:
       - qcom,msm8998-rpmpd
       - qcom,qcm2290-rpmpd
       - qcom,qcs404-rpmpd
+      - qcom,sa8540p-rpmhpd
       - qcom,sdm660-rpmpd
       - qcom,sc7180-rpmhpd
       - qcom,sc7280-rpmhpd
       - qcom,sc8180x-rpmhpd
+      - qcom,sc8280xp-rpmhpd
       - qcom,sdm845-rpmhpd
       - qcom,sdx55-rpmhpd
       - qcom,sdx65-rpmhpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 0a8978d0c78c..6cce5b7aa940 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -125,6 +125,24 @@
 #define SC8180X_MX	9
 #define SC8180X_MX_AO	10
 
+/* SC8280XP Power Domain Indexes */
+#define SC8280XP_CX		0
+#define SC8280XP_CX_AO		1
+#define SC8280XP_DDR		2
+#define SC8280XP_EBI		3
+#define SC8280XP_GFX		4
+#define SC8280XP_LCX		5
+#define SC8280XP_LMX		6
+#define SC8280XP_MMCX		7
+#define SC8280XP_MMCX_AO	8
+#define SC8280XP_MSS		9
+#define SC8280XP_MX		10
+#define SC8280XP_MXC		12
+#define SC8280XP_MX_AO		11
+#define SC8280XP_NSP		13
+#define SC8280XP_QPHY		14
+#define SC8280XP_XO		15
+
 /* SDM845 Power Domain performance levels */
 #define RPMH_REGULATOR_LEVEL_RETENTION	16
 #define RPMH_REGULATOR_LEVEL_MIN_SVS	48
-- 
2.35.1

