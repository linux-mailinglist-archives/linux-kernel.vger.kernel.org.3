Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9175C4EFED8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 07:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353762AbiDBFOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 01:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242466AbiDBFOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:14:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A21189A2C;
        Fri,  1 Apr 2022 22:12:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w21so3880983pgm.7;
        Fri, 01 Apr 2022 22:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDSgYN32AfJHFFW2LrlYc4myT1RM3QFcvjBNtontNQc=;
        b=nDYr8PrtODpKNUYnnfIslPNPRpnlNV5yEWDzDRrEghy6uBz5VmjpZJKFmSb7mW+beL
         Or6XX3/OQZt0VJ377PuFXGOXznQJXWJ46NMw5OpVvwLLK1Ub55ymWZB1uTJa9Mjkf7NO
         YxZ5P6pEII2wbUv4rrZ666ZEnQB722BuZSdtpZgH9tsZLgrTWtqY5Yzy2/RTsa1p3kSy
         FFDdmFPT5f1HHS/wJq1OjlzBkf35bYWtDANpnZq1d6P2c+H+mMxqg7uNrdC36VIMPy9C
         4Uwng0VVm8Lt/ch8Odw5eWxS15HwgzXubd8djhdHKXTYXv0LKX8WpNqT161ZMAl7hzP8
         qWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDSgYN32AfJHFFW2LrlYc4myT1RM3QFcvjBNtontNQc=;
        b=YDkYgKMd789d4khrkkqTYPENgCBBzppFLe8oHah4B6+CvYfKK0H2B04ytZtLOAB8pD
         3TcsQuE/UfH4oMZTwam3fftVZImIkX9CLOlcNoR2fgPfayZu/ItKK+pJU4gd88NAOXAA
         jBpA2fDf/IbjkBXPjmu2g2GdByq6InPVf8IgYtY7fvbuHgo18vt/m3XSM3ksK91nwH69
         MwBwZaLoVHCawyExjtwT5nW+mgELiYkRA+vPXKvaKExF3nk7K1eVn7hlfzoP1F6jhZXq
         fRDX6O3Km6b2fN+uEa7dFl+TjSX1lr8wew40hoa6lhCDQahkiDNEpenfW2BX5+onkKNj
         xeyw==
X-Gm-Message-State: AOAM531RdwfXOsCZeUqhJpJ+ad0J1A9luP16JAR2nxOLPjcmprZXkLk9
        BmZ7XcPwxLPYsXie31BoD/M=
X-Google-Smtp-Source: ABdhPJwODkvvt6gpU649zQUdVjC9Hm7ry105K6u6fX37gs2HhjAz5EjXSKOW+h/QzeHau6lFGhwmeQ==
X-Received: by 2002:a63:ae03:0:b0:386:2b5d:dd7d with SMTP id q3-20020a63ae03000000b003862b5ddd7dmr17260234pgf.332.1648876339977;
        Fri, 01 Apr 2022 22:12:19 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm3834721pgo.6.2022.04.01.22.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:12:19 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: qcom: geni-se: Update i2c schema reference
Date:   Sat,  2 Apr 2022 10:42:03 +0530
Message-Id: <20220402051206.6115-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
References: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have geni based QUP i2c controller binding in place as
dt-bindigs/i2c/qcom,i2c-geni-qcom.yaml similar to other controllers,
update reference in parent schema and while at it, also remove
properties defined for the controller from commown wrapper.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 .../bindings/soc/qcom/qcom,geni-se.yaml       | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index 95fcb43675d6..e6073923e03a 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -128,31 +128,7 @@ patternProperties:
   "i2c@[0-9a-f]+$":
     type: object
     description: GENI serial engine based I2C controller.
-    $ref: /schemas/i2c/i2c-controller.yaml#
-
-    properties:
-      compatible:
-        enum:
-          - qcom,geni-i2c
-
-      interrupts:
-        maxItems: 1
-
-      "#address-cells":
-        const: 1
-
-      "#size-cells":
-        const: 0
-
-      clock-frequency:
-        description: Desired I2C bus clock frequency in Hz.
-        default: 100000
-
-    required:
-      - compatible
-      - interrupts
-      - "#address-cells"
-      - "#size-cells"
+    $ref: /schemas/i2c/qcom,i2c-geni-qcom.yaml#
 
   "serial@[0-9a-f]+$":
     type: object
-- 
2.25.1

