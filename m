Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F354EFEDA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 07:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353779AbiDBFOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 01:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353750AbiDBFO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:14:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04A51905A6;
        Fri,  1 Apr 2022 22:12:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b15so4383831pfm.5;
        Fri, 01 Apr 2022 22:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cmh3zBP9GsKXvL2pssHcTFPMISefgaLSJBLP3U0JXlQ=;
        b=AoGYQZWG6wsdCVOGtMdF4xUeIPkQaO857bhsv+DdFDv8TAsgBuHcDnvGew1xll6gK5
         klJwu4dxZcGZ7eQSROPJwcC+8p/a0sqnuL/fSoeZlIV8du8NOll29oVviZ5FmzNj9tAG
         8WQ/UvBMM1sCbftS2oaY69leQOfS16+Svvf5SnXI+UXw/gghgbTjmpkAYV0jUWJnL3cR
         cOzZC7kV2VXbDsMP7i7iv5CkTEPVIiRXxHFIkX9Gy1EA+q2eZo/Go6JdkMG6AkcjH7iv
         Ap54wA3Gg4lQLaA/6whUmOcBY0gyIpB33Mv6MdA2MFXdGUp4/TnrSEdnZWeBPHHa/SzD
         A3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cmh3zBP9GsKXvL2pssHcTFPMISefgaLSJBLP3U0JXlQ=;
        b=JgqX5ULQJobdNwWgNvi06wiEJKvE3psANHdb94SnEONiudUqyeUl9EBdHXC1iVRegl
         WC0y9S99DduH+yWFASVbi6ghqdCEkLpqX3eGzM40QLrId5DZEcBNRTvxIs5pJ0l87UzF
         KeydrTuISVIpStJgMRHPRElm/jgfQa4aByw99t9AeHyKu82fYJeDhB+JUepYYyctgOrJ
         USGJ3+ub0v20xHUhRJ3G268udT88zfCwlzzymSX+fJrWr0+qSYXAIxbiCQ7dGF2AAVXV
         cynJ7Wl7kUCYJrrND2yWVHfpWf4P+Rw10OXLEPa2yoQRRdJMMSWoTYJVl10Bw7yPJ1Yv
         BXaA==
X-Gm-Message-State: AOAM530sDHZObovdvO8gfJB0QogCmCca22UblahJv8vfnkJZddTW7MyS
        QGMulKoPkSrzuFsuSomGaVY=
X-Google-Smtp-Source: ABdhPJzMIkQ8AIMYzYpn8QBnw3j8ONlhGOQgm+9wuTzXUlfUzp8VRj+3yZ9t8Ii9kLYIji7gvaHrPA==
X-Received: by 2002:a63:1758:0:b0:381:effc:b48f with SMTP id 24-20020a631758000000b00381effcb48fmr17861363pgx.124.1648876351130;
        Fri, 01 Apr 2022 22:12:31 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm3834721pgo.6.2022.04.01.22.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:12:30 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 5/5] dt-bindings: qcom: geni-se: Remove common controller properties
Date:   Sat,  2 Apr 2022 10:42:06 +0530
Message-Id: <20220402051206.6115-6-singh.kuldeep87k@gmail.com>
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

Now that Geni serial engine controllers(spi, i2c and uart) have their
own individual bindings, it's time to remove all common properties of
the controllers from parent schema.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 .../bindings/soc/qcom/qcom,geni-se.yaml       | 33 -------------------
 1 file changed, 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index 9f72c676b22c..c8e1a4a87ba8 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -64,39 +64,6 @@ required:
   - ranges
 
 patternProperties:
-  "^.*@[0-9a-f]+$":
-    type: object
-    description: Common properties for GENI Serial Engine based I2C, SPI and
-                 UART controller.
-
-    properties:
-      reg:
-        description: GENI Serial Engine register address and length.
-        maxItems: 1
-
-      clock-names:
-        const: se
-
-      clocks:
-        description: Serial engine core clock needed by the device.
-        maxItems: 1
-
-      interconnects:
-        minItems: 2
-        maxItems: 3
-
-      interconnect-names:
-        minItems: 2
-        items:
-          - const: qup-core
-          - const: qup-config
-          - const: qup-memory
-
-    required:
-      - reg
-      - clock-names
-      - clocks
-
   "spi@[0-9a-f]+$":
     type: object
     description: GENI serial engine based SPI controller. SPI in master mode
-- 
2.25.1

