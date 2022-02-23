Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA114C0D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbiBWHg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiBWHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:36:21 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ECE70CFF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:35:55 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D8A5A3FCAC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645601753;
        bh=KcttjNAmbIhSjRs0HRxX1kGL0G5aH52vHUuc1heZPO0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=t+NFzcSm2pspI9nCvSvHxCqmW5zvyfKUKrTFLzyUYwEWigEJkop6hFTXaQ/OrOW4i
         MDCHLMiUbYDRZ+WXY8PEu0FCaRvgKsiv1LB9BBjo5HDoI8WuW6I2WBz4JFArwJcklY
         GyyB4lhg36rYVcs3KTZL/x2dVJk6p97Zz5aAg3efzaCbMSC6dukqlZQWCinwANugvW
         nwfd/jX2kvM8AJuD7+vR/9dnWQNk2DXukeQk4BdZK8P0DJph0sqv6pJJGIjQfa5ovI
         5tYV2TyYSWVUER0wQLuFho5AyNg9zEz+pL14kbuCoA9LIeLKhuMTEn5+Cd5TQeGqrz
         Tt4v3WK28Vb3g==
Received: by mail-ej1-f72.google.com with SMTP id qf24-20020a1709077f1800b006ce8c140d3dso6733155ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KcttjNAmbIhSjRs0HRxX1kGL0G5aH52vHUuc1heZPO0=;
        b=ue+MYCZbQe70Q/TZMLsgpS2tSd8wfmsr/+JihS0qTcm/3qoGMtXZF0+cCyDj62tHhl
         lFD3PrzqJjtHP9NFcdcDF0rS15hqFHu1+QHzJycOFI8Q3yrocIciebtyRfMhagActQff
         3nlCIu3imvzbev3LB/buLSglWHQUXPIsZbDeEm6n9MvqP+GMT5x2bIyDLaN4CizNPRFz
         eL3//D+n2bTFkBrZdYzRpqKcEfxX8jwi44O4oS9fCpC/bxr/3wTB9QckrXDEMNF5EP+k
         sfdHcoOezVJR0xQSc887U0+lrKrhJX5np6pPVBLHYPDT8iymuO48zKUoSyfjsZEIpH2g
         nFKg==
X-Gm-Message-State: AOAM532U850ls5FerzJsmQy2ASH+tkdtg9+aKZ6xcDiQ2Ux2b6bcyiTI
        wPgvegqf64Ss1+Rk6VnyIO785Em/Ni2qcs+Yo7iT5qqe89MmZDO0OJQ8Eu8T5lfU3YulYSb3tMT
        1tr8owFpgJ6BtJxcx9x7Sx7wqbA+LY9VpYmDQeX+vtg==
X-Received: by 2002:a17:906:f2cc:b0:6ce:7164:ac9a with SMTP id gz12-20020a170906f2cc00b006ce7164ac9amr21593531ejb.629.1645601753546;
        Tue, 22 Feb 2022 23:35:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOwY2Eh1aNU5JQEK3K13jDU3E29JLr5VjvAqtJ/sUL4KqaFQ0/gvrXV7486by/PMgh4dIqSw==
X-Received: by 2002:a17:906:f2cc:b0:6ce:7164:ac9a with SMTP id gz12-20020a170906f2cc00b006ce7164ac9amr21593519ejb.629.1645601753310;
        Tue, 22 Feb 2022 23:35:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id u4sm7129842ejn.216.2022.02.22.23.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:35:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: example: Extend with typical case (int-array and disallowed prop)
Date:   Wed, 23 Feb 2022 08:35:47 +0100
Message-Id: <20220223073547.8746-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223073547.8746-1-krzysztof.kozlowski@canonical.com>
References: <20220223073547.8746-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the example with:
 - an array where each element has constraints (min/max value),
 - property not allowed in case of different compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/example-schema.yaml        | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
index c078796ae1b5..80a28781845d 100644
--- a/Documentation/devicetree/bindings/example-schema.yaml
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -162,6 +162,16 @@ properties:
       don't need a type.
     enum: [ 100, 200, 300 ]
 
+  vendor,int-array-variable-length-and-constrained-values:
+    description: Array might define what type of elements might be used (e.g.
+      their range).
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 3
+    items:
+      minimum: 0
+      maximum: 8
+
   child-node:
     description: Child nodes are just another property from a json-schema
       perspective.
@@ -207,6 +217,10 @@ allOf:
     then:
       required:
         - foo-supply
+    else:
+      # If otherwise the property is not allowed:
+      properties:
+        foo-supply: false
   # Altering schema depending on presence of properties is usually done by
   # dependencies (see above), however some adjustments might require if:
   - if:
-- 
2.32.0

