Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754CC589E39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbiHDPJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiHDPJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:09:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC6B1C133
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:09:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so31267834lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Ls3wmwZc27FOQS4WF8l9pDgrn7cd87DuWOgr6YV+4E=;
        b=ry/Jo/Ok9+ZPG+82b0uF1vKq1QNAELdkGNfI7VaEYH0ZsY84RoECLsV8WP67WdFRyw
         7FJNlhQGiady5DovDtRe/sfuxxZjHPX975QQMmgsGbP5GChZ6/Gn11+R/RlNC/CeJxob
         ia3qIvsgLSgPGDjoR6s9sS1AH9cNjOSDO/lcwQEoV4qb0hRJ1T1mnIjOYH+DH8ZReSLf
         35MfUIXVLmklevioSRjGU3GuukTaX50dnOeYT0LhPhVQaIjtx4vU4jVM1Ed6tpVMgoZw
         ufTr6ccTJkc79a6LvE9SZ7WqUAqVyIq7d5qE62/EhMJGzVdjlhlsQWv1YzuKoo7eaOPQ
         sJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Ls3wmwZc27FOQS4WF8l9pDgrn7cd87DuWOgr6YV+4E=;
        b=Po+QVUqPpkqTzoFxScHh90FS25VeIMzw6dYDlyAqLGgtj/6GJDzdRvbsw3ZvStApJa
         Pg7Cy6irKQfU+mjVumQboZxwxeNFGgqQccuCsOTzhd2qtWLcrXi4F6XwApbhqIRRWx74
         5E5KfocDG34WrJy5xRx/jES9lDb+Dbi0MjL1AervnGn8S+ixilKRDtFAmLlmOEqh5p6x
         3Hn+u+TUCLGXADJ+5YMtz2QM6fjtS2P8FLemVA+SAk9BRCRiUbnJ6a7EEEFVPjarRbGc
         FVMserFVnTb1vs3tJ1GRxnR8w+H0Y3UWHuemPeU2CedF96fNwI6bAKUQCje97HO3B02R
         aUpg==
X-Gm-Message-State: ACgBeo1mqH1LRxzfdq7z1dFBWBpV0jyrq0meKpWrgx8opf1/Amn/GNl3
        1YWr+nheLL5g75Z56XpIF8rV/w==
X-Google-Smtp-Source: AA6agR5X0yl7CVbndZJi7Hs/+Xnnpb6lNmxgp0Wl/kB+ntjRtZ+aQgTxPPqdoYXv4nAKYO2X3G1YBQ==
X-Received: by 2002:a05:6512:ba4:b0:48a:f185:db17 with SMTP id b36-20020a0565120ba400b0048af185db17mr790025lfv.107.1659625789282;
        Thu, 04 Aug 2022 08:09:49 -0700 (PDT)
Received: from krzk-bin.. ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id be39-20020a056512252700b0048b37d29256sm152681lfb.63.2022.08.04.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 08:09:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc compatible after rename
Date:   Thu,  4 Aug 2022 17:09:35 +0200
Message-Id: <20220804150935.121890-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The Nuvia DC-SCM BMC board compatible was renamed iin commit
7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
so adjust the bindings as well.

Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Use proper qcom compatible.
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1895ce9de461..4f0b308e9f0f 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,7 +80,7 @@ properties:
               - ibm,tacoma-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
-              - nuvia,dc-scm-bmc
+              - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
           - const: aspeed,ast2600
 
-- 
2.34.1

