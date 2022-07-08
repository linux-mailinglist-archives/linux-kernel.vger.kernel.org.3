Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6942356B06D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiGHCHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiGHCHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:07:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C127392C;
        Thu,  7 Jul 2022 19:07:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso523072pjh.1;
        Thu, 07 Jul 2022 19:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6qXHBRggPv7WVxROCph+0wgkDdSGgA4sRqXZcZDbr8=;
        b=nCtXSuYk79ctMRPPeoM5rCIR5xA2wD8paCEOUIEZH7hSlH5sUM9zJ8fV0ow38QTXCv
         Jh6WPOFOdwou3MLT7iKyOQe2oqYr8O7pYgRrMB2ww4XF3MoZLq4uk3ZBreeqm8LZ5HsJ
         UWvuZbKqDC1WqEcRYvbtqDSrmcknryDohpx3S3K6icD4Qvt1yYXvqImRsKStqholCgpr
         LdLnES5Q5sQ6A7/4yPwSGsyuILGHT/NqybYdh5kGCH1HToXcKSA5Hxnnwf/wNACoiIdR
         27QPppc9wepbS9e1t1zbVEyiK9NcwTh9ZH8pnyHEar1YZuGj8akkmRnnzlT8xgtmDSJb
         rSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6qXHBRggPv7WVxROCph+0wgkDdSGgA4sRqXZcZDbr8=;
        b=mppR9iy8hMzvGbcPugO9Fy3tezTROKxAyViswCnph1PW+yBjAgi8XfZ0SsFWLyCHSz
         GeTOHuaFv9tOhfat6NplA40NmCCbbzWCau6CpWzdBF6guVv11I1oaJa3rcfsyqrPGTb3
         6jHvKZRXrXS3P+N/WkxJ5dP1S9RARCd9A6Iieesffzsl7uW9jaR80N/UHydolTMO48OA
         TgK42yYkpBOoldKkqK2PCOu/XE3pF5Ke7GsUcsHFT4KjPdVGNjqLWqpcHyz0GEQqwRNa
         FZVCwjN/jI6UCyRU5HhZ6CJpvs5bB5SvbJkWaCyXQGdc0SZNRWpcf4hJBWzOR7CUoyc5
         ep0g==
X-Gm-Message-State: AJIora9XMSWTSRF5TA1sIMdO96X+4FJRRcvAh/zHcFGwFVxi/8MrXRWG
        y4Jv0tVNqq1tEu/sDk/4R7A=
X-Google-Smtp-Source: AGRyM1uvcs0cnBLbTZWc2zeBMSNMQwDzFg013OntYLs9xgmjNcRnitamfI6zaFgwbssya/n5DpjrfQ==
X-Received: by 2002:a17:90b:4ac7:b0:1ed:21e8:ddb2 with SMTP id mh7-20020a17090b4ac700b001ed21e8ddb2mr1086916pjb.93.1657246028566;
        Thu, 07 Jul 2022 19:07:08 -0700 (PDT)
Received: from localhost.localdomain ([112.0.189.16])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090a5e0100b001ec92575e83sm268584pjf.4.2022.07.07.19.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 19:07:07 -0700 (PDT)
From:   MollySophia <mollysophia379@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        MollySophia <mollysophia379@gmail.com>
Subject: [PATCH v3 2/2] dt-bindings: arm: qcom: Add Xiaomi Mi Mix2s bindings
Date:   Fri,  8 Jul 2022 10:06:48 +0800
Message-Id: <20220708020648.6675-2-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708020648.6675-1-mollysophia379@gmail.com>
References: <20220708020648.6675-1-mollysophia379@gmail.com>
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

