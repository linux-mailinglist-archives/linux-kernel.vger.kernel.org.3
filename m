Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4845370BA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiE2LPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiE2LPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:15:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE551986C1
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:15:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id f21so16010860ejh.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4T5vhUM1NViXGJsshqdrzfvWLGGvkPzScftKsb22jA8=;
        b=o4eSsznPrj3zLmr0uxcuKLBvgR5kIYT8PSVa4RjgjLmTJ8z+q0PRN7R8gBuDU0L40l
         z0fCqy4ouKnOxJvagNegLwIJOotTliDu4qiD6rIV1j7Raz4Rzr5Gqo8ULr/gPNcPbe5L
         YAFXTdTrnLg+lpf4b04sqp5rCofE6s4m8KlxKUEfNtyfdDFPbDkCmfqAX+qX2f+ckyWL
         dzk04xZZg52arW9ePdUPnLO5Fhdu7mPv+6/W9/NBhWzz8NK/+Ge+fmjwclPbyahDlmxR
         8oG+N4mml02CMDs4/029fPzHRmAOlLued3TV1QBmx6yCjhFVzGTbN8mHLnevhcp8Mcco
         xlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4T5vhUM1NViXGJsshqdrzfvWLGGvkPzScftKsb22jA8=;
        b=zWE4RLkaaEXSsCt5b4wywIYN3K2iG01uPC6VmvrihtS0iVW3TvvfSBzKcX4a7O7+Vl
         z7S8CQDyGHwt4YmBEhP1niQ0407UD/4mhFVKvYWIwG5rjQ049Mx+BMZ0d9SHWNO4s8Fx
         APkJH9TjpDSePkQk6Hjr8J9ehxrd9g6YGKoN4IkN/tAXXBryHunw+aLlt1t2xQZmHpfZ
         xfavTRz5UuHehb2r/vpXaVAGYMN4oCWnRrP9YjFnVrO3MXVQvVcj8GemVd0I4FUo2G6D
         fdnBWsx6e18KhGtlOR03boFR7Y8HzbMDLMhy1wQrzOWmwsBUU/JQlNaxwXfXrnECE/SV
         BXbQ==
X-Gm-Message-State: AOAM533HFNm42ypcVBqKvw5poDji93dFpFbE6FXWOVu4f2XY2gAyVfBa
        6VC8cwU2YIGv032LHMzzpmne8Q==
X-Google-Smtp-Source: ABdhPJzPwStx3ud/wM0wjW8ONC5Eg96YZVdJXNzlrLLfz7rL8uFBwK2nwKShMM5gVTY6pPPGRyAJ2Q==
X-Received: by 2002:a17:907:3d01:b0:6e0:c63b:1992 with SMTP id gm1-20020a1709073d0100b006e0c63b1992mr46296729ejc.422.1653822922321;
        Sun, 29 May 2022 04:15:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b006fec6e1d856sm3084848ejn.82.2022.05.29.04.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 04:15:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: vendor-prefixes: document deprecated Atheros
Date:   Sun, 29 May 2022 13:15:15 +0200
Message-Id: <20220529111515.182810-1-krzysztof.kozlowski@linaro.org>
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

Two old boards use "atheros" prefix instead of already documented "qca".
Document it as deprecated to fix warnings like:

  at91-gatwick.dtb: atheros@0: 'atheros,board-id' does not match any of the regexes

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 169f11ce4cc5..61a2cdc83058 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -145,6 +145,9 @@ patternProperties:
     description: ASRock Inc.
   "^asus,.*":
     description: AsusTek Computer Inc.
+  "^atheros,.*":
+    description: Qualcomm Atheros, Inc. (deprecated, use qca)
+    deprecated: true
   "^atlas,.*":
     description: Atlas Scientific LLC
   "^atmel,.*":
-- 
2.34.1

