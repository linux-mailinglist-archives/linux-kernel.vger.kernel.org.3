Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E70530DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiEWJJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiEWJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379BE4507C;
        Mon, 23 May 2022 02:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9B2F60FC7;
        Mon, 23 May 2022 09:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E38C34119;
        Mon, 23 May 2022 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653296935;
        bh=8566TNAIYuMPUSqB2VKigugwmemkLIms0TpE+9DCQW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fm+XiAo8zTvPBLqbwfdmXIgNP8eJyeTPyGy4wvfZ7wrzE4YL16cwW1xi2cm+k/2H2
         fRcgwiRuHSKVEoi3rMvsNIEVAlazq7gu8t9TAxlm/vIld2SQuBHJQMgZNhkK9DeDV9
         sRozIlXrL7j7rcb+/Pky9QemCwAv8WIWJjct6Cdnhibi/caz24ojdCgJKmD22fbMjL
         h8ezV21F3ZVhpRXVWCic1OwgovX9sqycm5NF3abi0I4yXnBq/W5YXbtuyMJuDMOXNc
         BVl7Nnqj0sUZkA/AP+kJokjk3yjrtSZfIWDm1gF7CIuSfZCVF4VC4NPqzhdnMIVyQo
         EB6ycSEc80c/g==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        mka@chromium.org, devicetree@vger.kernel.org, tzungbi@kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/5] dt-bindings: add google,cros-kbd-led-backlight
Date:   Mon, 23 May 2022 17:08:20 +0800
Message-Id: <20220523090822.3035189-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220523090822.3035189-1-tzungbi@kernel.org>
References: <20220523090822.3035189-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No content changes from v3 but rebase to the latest
Documentation/devicetree/bindings/mfd/google,cros-ec.yaml.

No changes from v2.

Changes from v1:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220214053646.3088298-4-tzungbi@google.com/)
- Update email address accordingly.
- Add A-b tag.

 .../chrome/google,cros-kbd-led-backlight.yaml | 35 +++++++++++++++++++
 .../bindings/mfd/google,cros-ec.yaml          |  3 ++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-kbd-led-backlight.yaml

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-kbd-led-backlight.yaml b/Documentation/devicetree/bindings/chrome/google,cros-kbd-led-backlight.yaml
new file mode 100644
index 000000000000..5b875af6a95a
--- /dev/null
+++ b/Documentation/devicetree/bindings/chrome/google,cros-kbd-led-backlight.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/chrome/google,cros-kbd-led-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS keyboard backlight LED driver.
+
+maintainers:
+  - Tzung-Bi Shih <tzungbi@kernel.org>
+
+properties:
+  compatible:
+    const: google,cros-kbd-led-backlight
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    spi0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cros_ec: ec@0 {
+        compatible = "google,cros-ec-spi";
+        reg = <0>;
+
+        kbd-led-backlight {
+          compatible = "google,cros-kbd-led-backlight";
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index afec0bd2f1de..09e00adf445e 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -90,6 +90,9 @@ properties:
   pwm:
     $ref: "/schemas/pwm/google,cros-ec-pwm.yaml#"
 
+  kbd-led-backlight:
+    $ref: "/schemas/chrome/google,cros-kbd-led-backlight.yaml#"
+
   keyboard-controller:
     $ref: "/schemas/input/google,cros-ec-keyb.yaml#"
 
-- 
2.36.1.124.g0e6072fb45-goog

