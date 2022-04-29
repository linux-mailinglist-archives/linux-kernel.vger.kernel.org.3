Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6423E51489D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358772AbiD2L4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbiD2L43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:56:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A3C6EF9;
        Fri, 29 Apr 2022 04:53:10 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 126so4653871qkm.4;
        Fri, 29 Apr 2022 04:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jW8w5Kaw7/H5XCbI2kCQ16R8uTSgfLbNJXXeM0gMkvo=;
        b=RNt7zo98GfO6oQ2OvLOZidtn73jtI6KGw7Tbw7PdL1cJ0/n5ihcStj0IdxKjnP3klH
         S516ToXWBx3vo5aF9t2aEmMX9HJAkeaHyJ4bVL/Ya9gZMZquLsGppaNZnVcMVGrt7Bqr
         gcnhvgBEF3/I0N/P/TjykqoeH7Ok7Hb0Azmx6p4JUWPYTrlt/hawzbvlvpEZ3aLGK9Om
         B3jyCQIQieHzFv/inOnb+vITn6qDa0VlZRPJ/ayRCag0qkvzSiNu0v/OpanuyBabjz4I
         IV4THTJREjqC+NTWxkXG2Bg7Z7FP0QdZ7udG1HQJGkghRwAcmfeVbp6HIW9fQw3NL0Gr
         F1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jW8w5Kaw7/H5XCbI2kCQ16R8uTSgfLbNJXXeM0gMkvo=;
        b=Y5E0i74sRtG24vYXQcuQgDZEfWoxN+j12VNr1/Ru0aCh1A9e2YufTUFOIdfChTJYHK
         CmKBjZfJSUn04GTvBE26u8YS216VkKduhCPsJywnM0b4aZkUOQvjkuKk92cnBw/lEFbo
         7RDibXbxF84Jr6+bYAdQGfoT3+98QwoDXQZ5mUImJx1wqmDrP6xFzupi3aR2gXiUL0J7
         JSPQpb3McfHgK8XUbqrCnPsYnulMg15F4t2yWGCCMKCJItr64M596ujU/aKm34lkAb8a
         LgYrwzDxu7JRIfe+o9qgDgy5KEVaxTPooiFcMLVV9RE6YlUrQank9y7EIVdjXrtukdwf
         i+vA==
X-Gm-Message-State: AOAM5315st/uAo3ww95gh4TwRwrq+GMReukwIyckSWaG2CnRGCJDZ+Sw
        UPQW5OwG9uDn+ysMmnH2B+M=
X-Google-Smtp-Source: ABdhPJwbuQgvcFaVFG72RI4ScVNdIUw9FCOeppgEtLex90TTIiMwKskD7aNa6c7UPCidcXCwFKvbvg==
X-Received: by 2002:a37:6902:0:b0:606:853:fe50 with SMTP id e2-20020a376902000000b006060853fe50mr22197916qkc.751.1651233189959;
        Fri, 29 Apr 2022 04:53:09 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 123-20020a370c81000000b0069fa408fdb7sm1382505qkm.24.2022.04.29.04.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:53:09 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/7] dt-bindings: arm: rockchip: Add Pine64 SoQuartz SoM
Date:   Fri, 29 Apr 2022 07:52:47 -0400
Message-Id: <20220429115252.2360496-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429115252.2360496-1-pgwipeout@gmail.com>
References: <20220429115252.2360496-1-pgwipeout@gmail.com>
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

The SoQuartz system on module is designed to be pin compatible with the
RPi CM4 SoM. It is based on the rk3566 SoC and outputs on uart2 for
debug and console. The first carrier board supported is the CM4IO board
from RPi.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index beb5b0ac1a2a..b85a8e6c5e75 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -509,6 +509,13 @@ properties:
               - pine64,quartz64-b
           - const: rockchip,rk3566
 
+      - description: Pine64 SoQuartz SoM
+        items:
+          - enum:
+              - pine64,soquartz-cm4io
+          - const: pine64,soquartz
+          - const: rockchip,rk3566
+
       - description: Radxa Rock
         items:
           - const: radxa,rock
-- 
2.25.1

