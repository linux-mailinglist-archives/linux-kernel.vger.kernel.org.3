Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CBF569437
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiGFVUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiGFVUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:20:47 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74208248D1;
        Wed,  6 Jul 2022 14:20:45 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id g1so12024286qkl.9;
        Wed, 06 Jul 2022 14:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DAWa7494DFRqqpHDm8ORlleZxGRDphGIG+m5f4M5GfU=;
        b=hySu4tqN4k52pg10G1/vPWfnUvoni1gyL+VlRm8vyiVlj8YcBkYGjNHJoX91H61rhZ
         SMenAWa2lwzH8VTWGeVtSr/wpks1+ADybQrICV8L2z5DLOwar37dmJKmo695598Ll25U
         JSw6Cb+P27oRw7i6nBWaMO/jYcIIjZI3LNLT/fkpS99ywdas3em3MEBjM4sToP8Xhjt4
         9dt+s0hh0gLRkPq9CIKeTgMnrex21Ic5iT8ZxyXU6uY0DvjkNDdOeZ67hj9zjO1EayOm
         2SLUyRafhtcAERnZfW9uFKq2dh0iebmHGwHbHaoFWUvfXwOmDYjVuMF0s4ulTmbAJgit
         q8RA==
X-Gm-Message-State: AJIora/QeRIHnNC8YDmXp8M8zY/TQggQGBuzpRue05TWZsLo4MMQthB5
        b+RRUfL/hKwRbXixIrw1lg==
X-Google-Smtp-Source: AGRyM1u8X5QNza6abXXnIiQoT+WJTgBwh8lL2wWQ/gqzAgec8bKSnJ8YtzaXyopnDSRIph2luRJ0TA==
X-Received: by 2002:a05:620a:1031:b0:6ae:eaf2:928e with SMTP id a17-20020a05620a103100b006aeeaf2928emr28997399qkk.575.1657142444540;
        Wed, 06 Jul 2022 14:20:44 -0700 (PDT)
Received: from xps15.. ([172.58.107.140])
        by smtp.googlemail.com with ESMTPSA id w20-20020a05620a445400b006af37b005bdsm24747827qkp.128.2022.07.06.14.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:20:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: nvidia,tegra20-pmc: Move fixed string property names under 'properties'
Date:   Wed,  6 Jul 2022 15:20:34 -0600
Message-Id: <20220706212034.568861-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed string property names should be under 'properties' rather than
'patternProperties'. Additionally, without beginning and end of line
anchors, any prefix or suffix is allowed on the specified property names.

As all the nvidia,tegra20-pmc powergates child node properties are fixed
strings, change 'patternProperties' to 'properties'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
index 564ae6aaccf7..7fd8d47b1be4 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
@@ -208,7 +208,7 @@ properties:
       "^[a-z0-9]+$":
         type: object
 
-        patternProperties:
+        properties:
           clocks:
             minItems: 1
             maxItems: 8
-- 
2.34.1

