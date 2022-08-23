Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90CC59E984
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiHWRY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243788AbiHWRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:46 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1EF237F8;
        Tue, 23 Aug 2022 07:57:43 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso9970477otv.1;
        Tue, 23 Aug 2022 07:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=xXlClLOBLqfBa2Nm9PNs15DRgZ9VUL5nc8REUjtlTJo=;
        b=Jn9jtJ4XHWrqlIV2NiVCiSxumXOxHTge6pBUZtMw3raFlDsSTcACOzKZo7FaI+cIiK
         p6MXMXNrVzP5rqVj0pAaCLvvHINVGtTu111G1jxZwYhznfELYytvE9tkflCZi/eiiNJW
         OaA7Y0xs/WIClLuSx7d6462FaJ5uLT+mDW6YvnQCcbo7tdjnNnvv4O54oPjzR7UNWHOY
         LUbX2sdW+dDMeW8UJ3BDLxEEY9XMtdnEUASigY+t66CNSTQyz7WVgA0Fc0Dq77uyh8Rx
         K1JVHlo2e7HJxp4sYnVWkzYaVf7T7T+HWcFL54pYmwBtouq0hWaNu3YXHhmv3oipCuy8
         F+0A==
X-Gm-Message-State: ACgBeo0qwf7RsF+xJAl3yB5h1f2dECHo+8WTrPzwC/E5zS3mMVBEer/B
        iM/24zaYFqMZe7S71c1x+Q==
X-Google-Smtp-Source: AA6agR5M8KPfP6Ja+OU+O5Ju+w3SnKym3mCHnwpgwKy9HL8bYAteZbk4AfULp1ObktfogdNOKzTmgw==
X-Received: by 2002:a05:6830:1bfa:b0:637:1491:2ac7 with SMTP id k26-20020a0568301bfa00b0063714912ac7mr9416645otb.9.1661266662630;
        Tue, 23 Aug 2022 07:57:42 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:42 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:47 -0500
Message-Id: <20220823145649.3118479-16-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml        | 1 +
 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
index cd2176cad53a..f6efa48c4256 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
@@ -62,6 +62,7 @@ properties:
 patternProperties:
   '^frame@[0-9a-z]*$':
     type: object
+    additionalProperties: false
     description: A timer node has up to 8 frame sub-nodes, each with the following properties.
     properties:
       frame-number:
diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
index 0a01e4f5eddb..a84fef0fe628 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
@@ -114,6 +114,8 @@ patternProperties:
   "^watchdog@[a-f0-9]+$":
     type: object
     $ref: /schemas/watchdog/watchdog.yaml#
+    unevaluatedProperties: false
+
     properties:
       compatible:
         oneOf:
@@ -146,6 +148,8 @@ patternProperties:
   "^pwm@[a-f0-9]+$":
     type: object
     $ref: /schemas/pwm/pwm.yaml#
+    unevaluatedProperties: false
+
     properties:
       compatible:
         oneOf:
-- 
2.34.1

