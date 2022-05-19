Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32F452E02F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbiESXBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbiESXA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:00:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72B6E026
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:00:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so9970208pjp.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+cnG0T1VfIcJDi4Tnrthnwsto5lgJAgXz/DN8hILeM=;
        b=E9ICPWOHq0JDDEynKw8oMU09qUbnljwf2UPOKuvme7k2m0oT7juy2tMyXCboV6z0Lh
         9sycljyk3NTft1DtA3PpNilaiobcApb+u6c2Qk4y2hu8ia/1wHl4muP/PDNNaJjK9m/4
         IK0ZSFu8FZ5vG+vqOMAswOwCk+TcIYUkKesBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+cnG0T1VfIcJDi4Tnrthnwsto5lgJAgXz/DN8hILeM=;
        b=1hiGw/VU/vyzKmrygDUbFv/VxTom6R7XFxlSlDFq1D9NOiJmbL/pMztiqYXdozNzBB
         mjNjO327JW6EO/V8CHJpgQRiWNVYhS8w9X1c9CysnM4Yz9AJ3T6bMvRWc5EDLBCWY70f
         Dmh6YmLtHS8iFQRSK18lN7S0NV3wb7dfR+QJZZXYXbXGerSfMdtBykB9sPKy/pGJlYFa
         Ejsp8EibyXStqZVsvBmUpQbj4GGhnRbe2Y+AbCxNqIqDwmzi4NC/qP+lUDUpzZcpM8/y
         hc6Rjt95mDRHR0sZ3Kq5Tt0zxKabvOYWX2QocKVn6grhYRPbTTaoPLCoqIFB1OkiXkWU
         NsVA==
X-Gm-Message-State: AOAM532wjdF2Hz2e9N7N2M6rMeKFl2IOB+UcsLerDOo1BJUypBaTI1Dt
        vr7qEUxHWcZ3JGznEiSNN/p8GAO00ymIIFvuEvQ=
X-Google-Smtp-Source: ABdhPJw+ZRz4Jko72uPDZg2ZBv9BBdBcNFqM9VVfrbGvBZTPeeJB4aIvFwTEqu0JM4pnp3rKOYazRA==
X-Received: by 2002:a17:90a:9311:b0:1dc:8d06:eb1b with SMTP id p17-20020a17090a931100b001dc8d06eb1bmr7490101pjo.41.1653001255156;
        Thu, 19 May 2022 16:00:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:e45f:1f3c:299b:4d86])
        by smtp.gmail.com with ESMTPSA id m10-20020a056a00080a00b0050dc762819csm202411pfk.118.2022.05.19.16.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 16:00:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     swboyd@chromium.org, linux-input@vger.kernel.org, mka@chromium.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: HID: i2c-hid: elan: Introduce bindings for Elan eKTH6915
Date:   Thu, 19 May 2022 16:00:02 -0700
Message-Id: <20220519155925.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like many i2c-hid touchscreen controllers, the Elan eKTH6915
controller has a reset gpio. For the Goodix GT7375P touchscreen the
decision was to add a new binding rather than trying to add a new GPIO
to the existing i2c-hid binding. We'll follow the lead and do it here,
too.

SIDE NOTE: the Elan eKTH6915 is a touchscreen _controller_ that's
included as a part on some touchscreens. The reset line isn't truly
necessary for the functioning of the touchscreen, so it's possible
that some designs won't have it hooked up and will just guarantee the
power sequencing requirements with RLC circuits. Thus, we'll mark the
reset gpio as optional.

Note that if the reset GPIO isn't used there's actually no true need
to use the "elan,ekth6915" compatible instead of the "hid-over-i2c" on
Linux. However:
- Officially using just "hid-over-i2c" for this device violates the
  existing "hid-over-i2c" bindings. The bindings say that you're not
  supposed to use "post-power-on-delay-ms" without specifying a more
  specific compatible. Currently the Linux driver doesn't enforce
  this, but it violates the bindings to just use
  "hid-over-i2c". ...and if you're going to add a more specific
  compatible anyway, might as well do it right.
- Using this compatible means we don't need to specify
  "hid-descr-addr" since it's inferred from the compatible.
- Using this compatible means that the regulator names match the names
  on the Elan datasheet (vcc33 / vccio) vs the generic hid-over-i2c
  (vdd / vddl).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../bindings/input/elan,ekth6915.yaml         | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/elan,ekth6915.yaml

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
new file mode 100644
index 000000000000..05e6f2df604c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/elan,ekth6915.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Elan eKTH6915 touchscreen controller
+
+maintainers:
+  - Douglas Anderson <dianders@chromium.org>
+
+description:
+  Supports the Elan eKTH6915 touchscreen controller.
+  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
+
+properties:
+  compatible:
+    items:
+      - const: elan,ekth6915
+
+  reg:
+    const: 0x10
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    description: Reset GPIO; not all touchscreens using eKTH6915 hook this up.
+
+  vcc33-supply:
+    description: The 3.3V supply to the touchscreen.
+
+  vccio-supply:
+    description:
+      The IO supply to the touchscreen. Need not be specified if this is the
+      same as the 3.3V supply.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vcc33-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ap_ts: touchscreen@10 {
+        compatible = "elan,ekth6915";
+        reg = <0x10>;
+
+        interrupt-parent = <&tlmm>;
+        interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+        reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+        vcc33-supply = <&pp3300_ts>;
+      };
+    };
-- 
2.36.1.124.g0e6072fb45-goog

