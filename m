Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08149574C13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiGNL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiGNL2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB57459266;
        Thu, 14 Jul 2022 04:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2196C61CC2;
        Thu, 14 Jul 2022 11:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4A4C341C6;
        Thu, 14 Jul 2022 11:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798078;
        bh=tOGmD5u/m9ilA/glyEAQrd2KlEkkAMsHW3drN8WKV/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5WiL4mTT1a43S+B3rLO5E5wkRqZ3KWIFX4R+bXiXL2Dewy3zBY4HJfc42nlDyF57
         Y0UnraujQsDkAAXNarcSHVn8LnM2BnOJqIDPWwwrr1lwfjB6VkqPRcdfG6umF9GqtS
         KtOjOylKy/v0UOHIQ6ohhK/u7hrFUychRoxN34Ns0ivWRC/W18x3z9Rkw+YVIACThW
         W6InZslRmF/LCFxydbfpYAqiG3Bvy/TiP6kd6Adxn01TAAAyuehyU/yjaj5OjZAAXE
         pGXZ396EXSEnUgKimKA7VZ/aowwQDpuM2hFZ0wRPiATw+Jgs+kitZ4+yzeGhfRlVZ+
         G4OBG8DTzCyvA==
From:   Lee Jones <lee@kernel.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 6/8] dt-bindings: backlight: Update Lee Jones' email address
Date:   Thu, 14 Jul 2022 12:25:31 +0100
Message-Id: <20220714112533.539910-7-lee@kernel.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220714112533.539910-1-lee@kernel.org>
References: <20220714112533.539910-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going forward, I'll be using my kernel.org for upstream work.

Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-leds@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 Documentation/devicetree/bindings/leds/backlight/common.yaml    | 2 +-
 .../devicetree/bindings/leds/backlight/gpio-backlight.yaml      | 2 +-
 .../devicetree/bindings/leds/backlight/led-backlight.yaml       | 2 +-
 .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml   | 2 +-
 .../devicetree/bindings/leds/backlight/pwm-backlight.yaml       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/common.yaml b/Documentation/devicetree/bindings/leds/backlight/common.yaml
index 702ba350d8698..3b60afbab68ba 100644
--- a/Documentation/devicetree/bindings/leds/backlight/common.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/common.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Common backlight properties
 
 maintainers:
-  - Lee Jones <lee.jones@linaro.org>
+  - Lee Jones <lee@kernel.org>
   - Daniel Thompson <daniel.thompson@linaro.org>
   - Jingoo Han <jingoohan1@gmail.com>
 
diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
index 75cc569b9c558..3300451fcfd5e 100644
--- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: gpio-backlight bindings
 
 maintainers:
-  - Lee Jones <lee.jones@linaro.org>
+  - Lee Jones <lee@kernel.org>
   - Daniel Thompson <daniel.thompson@linaro.org>
   - Jingoo Han <jingoohan1@gmail.com>
 
diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
index f5822f4ea6679..0793d0adc4ec9 100644
--- a/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: led-backlight bindings
 
 maintainers:
-  - Lee Jones <lee.jones@linaro.org>
+  - Lee Jones <lee@kernel.org>
   - Daniel Thompson <daniel.thompson@linaro.org>
   - Jingoo Han <jingoohan1@gmail.com>
 
diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index 08fe5cf8614a8..3c9b4054ed9a5 100644
--- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: TI LM3630A High-Efficiency Dual-String White LED
 
 maintainers:
-  - Lee Jones <lee.jones@linaro.org>
+  - Lee Jones <lee@kernel.org>
   - Daniel Thompson <daniel.thompson@linaro.org>
   - Jingoo Han <jingoohan1@gmail.com>
 
diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
index fcb8429f3088c..78fbe20a17580 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: pwm-backlight bindings
 
 maintainers:
-  - Lee Jones <lee.jones@linaro.org>
+  - Lee Jones <lee@kernel.org>
   - Daniel Thompson <daniel.thompson@linaro.org>
   - Jingoo Han <jingoohan1@gmail.com>
 
-- 
2.37.0.144.g8ac04bfd2-goog

