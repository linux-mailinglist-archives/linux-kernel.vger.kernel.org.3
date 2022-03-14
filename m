Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7794D7E41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiCNJKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbiCNJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16F44199E;
        Mon, 14 Mar 2022 02:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CD6B612CD;
        Mon, 14 Mar 2022 09:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1FEC340F5;
        Mon, 14 Mar 2022 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647248955;
        bh=WNjHbkmfspMZLOgwbDaDKbPADP2Oyh57TgKhOEX0TKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rz7SpwptPboSi/FCf3lj9guCxgnQYbaaLDibf4ujTTguoR3AfdJ/LnP/6zC1FGhFe
         dNOny2VQ1r16ZZT8aRX8S4yyfdxwuk5q7jSI+R+TU3ZMEEmHF3Qv41HLh9VXU98TDh
         8dFspSKeuT5y2Rz273QIPKmwv6eD4ZzUl5C+AUi+U44gjSsQUObGhKk3Mt/Rdf7U5U
         TL9doHGpYm6fIshSr7aw5ySwPYu/hhciVc+t2Fne9JNi1pFHqHOJ/kooR1KI899Ngr
         uSu/ecV7oHLblzGW8+uXM3styThM0iaMYjIJE1m4wMrIOj2p+u+vvL7GPXcFGfMFbH
         0/eBHgQDp98Vw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, tzungbi@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/5] dt-bindings: add google,cros-kbd-led-backlight
Date:   Mon, 14 Mar 2022 17:08:33 +0800
Message-Id: <20220314090835.3822093-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220314090835.3822093-1-tzungbi@kernel.org>
References: <20220314090835.3822093-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
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
index d1f53bd449f7..1815ca0e8ebc 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -90,6 +90,9 @@ properties:
   ec-pwm:
     $ref: "/schemas/pwm/google,cros-ec-pwm.yaml#"
 
+  kbd-led-backlight:
+    $ref: "/schemas/chrome/google,cros-kbd-led-backlight.yaml#"
+
   keyboard-controller:
     $ref: "/schemas/input/google,cros-ec-keyb.yaml#"
 
-- 
2.35.1.723.g4982287a31-goog

