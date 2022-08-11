Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5318258F7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiHKGjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiHKGis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:38:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2775A8B993
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:38:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z25so24339990lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=AGEywKGeoHQ0FbmdJ6X1DklF8N9Blk35YsMIqDrQ5Mw=;
        b=QDLGAXXBsgC04gfJKOEdrkRdt7sHC5ZTFaNm25Y4iwXxALrOoH45XuzuBmlG5JpolA
         TqXKykAgXPC01T8cFQQwtgcC2K410aXDsoXaMBJnbvVyfentYv2dbO7+q9UQUEtplti9
         jUBIYkji138JeXwjl4H42p8ncNvpyyTAGDHs5hoYnfLVEZD7Da5BThWeJhkifdnoT7p8
         ejaBsT9TFFNO6YWOu5W1puCR6a4WH2VUiROY2Woj+MAxjFDhdJvFVn581Zq+E1Qey/On
         qpZdMYJGCrW2sbcjULBpZO9pAfxPDcKbsIfpmhppTl+q0MMiR21tAUPdBgV1xefOQznE
         D9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=AGEywKGeoHQ0FbmdJ6X1DklF8N9Blk35YsMIqDrQ5Mw=;
        b=giLw8YuEAk//llDMM9hmGTvWczp6Io+WEZRqkbH0wmw13wS1jEcqrXpBB5EiWE8TRj
         sQbAzCY2kGkK+uWZ26BFrAwGf9o/pGFl85jKcufy7szqi9XaoVp/qtI/GvYVYqU3o1Vk
         q+1Pq1WrkOq1/9wzFuIFBKnEKJwuCqk5AjsBLGzmU0jXu2zaW2OcRxcIJcrZAGZq4xnZ
         kvL88ApjWGRQTgfbYTJ1rvI0jGic5FWvXba0yHe7z7AdnGbS/kSFFBGW3KlF+AMukV5h
         F+eOmEgDy85jllDP1yAyxdjfTMTd2zD3CnMKv/9jD3yTx7tuGIKFNmC/JOCqZj6HzLyz
         /Wog==
X-Gm-Message-State: ACgBeo0J8ILpYQeugqSXq1mvAaYRR2XZFe+MnDZP2B8W6nXJJnzEI5it
        9I4sM8Q22ZGOXXCi+mhm3Erd+g==
X-Google-Smtp-Source: AA6agR4ugZV+KRC/fxXYtcxvD9OkFiF6TJixcJtRQF4gWRmYwTQnRaC2c4lhLhI+rf8d4aFDAojiEQ==
X-Received: by 2002:a05:6512:3583:b0:48a:e811:3d89 with SMTP id m3-20020a056512358300b0048ae8113d89mr11627782lfr.371.1660199923566;
        Wed, 10 Aug 2022 23:38:43 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512324f00b0048ac33f34d8sm585537lfr.289.2022.08.10.23.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:38:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: phy: Drop Pratyush Yadav
Date:   Thu, 11 Aug 2022 09:38:40 +0300
Message-Id: <20220811063840.7670-1-krzysztof.kozlowski@linaro.org>
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

Emails to Pratyush Yadav bounce ("550 Invalid recipient").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml | 2 +-
 Documentation/devicetree/bindings/phy/cdns,dphy.yaml    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
index 07be031d82e6..834f65636819 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cadence DPHY Rx Device Tree Bindings
 
 maintainers:
-  - Pratyush Yadav <p.yadav@ti.com>
+  - Kishon Vijay Abraham I <kishon@ti.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
index f0e9ca8427bb..37bc20493fd0 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cadence DPHY Device Tree Bindings
 
 maintainers:
-  - Pratyush Yadav <p.yadav@ti.com>
+  - Kishon Vijay Abraham I <kishon@ti.com>
 
 properties:
   compatible:
-- 
2.34.1

