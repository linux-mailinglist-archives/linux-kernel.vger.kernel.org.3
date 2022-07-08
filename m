Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB256B05E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiGHCAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiGHCAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:00:47 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4B73912;
        Thu,  7 Jul 2022 19:00:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q82so13996030pgq.6;
        Thu, 07 Jul 2022 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6qXHBRggPv7WVxROCph+0wgkDdSGgA4sRqXZcZDbr8=;
        b=eo6wAKpmk0VbJNQ9KBbcXvw2eWMhMZfBGWk8x5yL1CI0aYUUrI2EtbG/mNVlZ3MaMW
         XoRS8/+TXHzJ8z4WmPaYH7V0VexGuGcxbwUsfIDwoeG+NL1STmp+T5HJmziKYB2SiXnG
         cPyDl/HIxeAxRA9P8otG4rgQpPYkrauoe2D0Jt0eH3tHC6lVXzZWsA0VBy5zTzxJpD8O
         OSCFhqkwVVMyazk4M/v94AUZhK7eyS0n9aaHgjrFH7ioloJxhoo63CXDPK8GBF5IeNcR
         8D56U5zuVNAJOe5BspZQbQkWLW4hEkzrMvtVT/6vcj3vOsA6TnFdlsM7WIX5Ux1p9Ei+
         CVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6qXHBRggPv7WVxROCph+0wgkDdSGgA4sRqXZcZDbr8=;
        b=0C5TDoZGF8D8ISiBUTIdOHp/SEgOiBk7veGrLG/ZSX36WyhOIrhIuoyPMMjyC1x9tv
         mRhOK5rSS86eAcCo3cNj8RRZcKgHAghvwERSdz0ueKKSOCFLlDG2SEOO6LzvcMoPfX8C
         fdmdA6lBuztsHo6cdGdfqc12+4I9ypPU7ziWwTCsjiE614d9YU9+5XhHXQJyt9aIeDo0
         cpdKyIg/tNumWGHTjcLCDTO8piNegkceD9gQ3d3AypcpBnCUOSDRXYgPwyI3avnxj3P2
         +Jf1/owhLRR1g7YkKc0xhMlZX1KAItkvXCIvPY2jxZADNDj/CG38EWH09dbriV0KqChi
         fSwg==
X-Gm-Message-State: AJIora9oOJXWEMvJro4UYXqOSXIglAnuEt3H43LsoNdfV0glxVI/BhIo
        Atd6mjDDNT98NYrW1KtoLFw=
X-Google-Smtp-Source: AGRyM1umBevx+Eoa1xNM6VXRq8kr/7BFL5hNmrJWB3osWoAh0gtZvTnlPDeGQME58LxFuLtdP6OIew==
X-Received: by 2002:a05:6a00:15cd:b0:528:4252:7079 with SMTP id o13-20020a056a0015cd00b0052842527079mr1363856pfu.68.1657245646523;
        Thu, 07 Jul 2022 19:00:46 -0700 (PDT)
Received: from localhost.localdomain ([112.0.189.16])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902bd8e00b001677fa34a07sm28680514pls.43.2022.07.07.19.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 19:00:46 -0700 (PDT)
From:   MollySophia <mollysophia379@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        MollySophia <mollysophia379@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: arm: qcom: Add Xiaomi Mi Mix2s bindings
Date:   Fri,  8 Jul 2022 10:00:30 +0800
Message-Id: <20220708020030.4955-2-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708020030.4955-1-mollysophia379@gmail.com>
References: <20220708020030.4955-1-mollysophia379@gmail.com>
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

Signed-off-by: MollySophia <mollysophia379@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 129cdd246223..80dff09bdc83 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -235,6 +235,11 @@ properties:
               - xiaomi,lavender
           - const: qcom,sdm660
 
+      - items:
+          - enum:
+              - xiaomi,polaris
+          - const: qcom,sdm845
+
       - items:
           - enum:
               - qcom,sdx55-mtp
-- 
2.37.0

