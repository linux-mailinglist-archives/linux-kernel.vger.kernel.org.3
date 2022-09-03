Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA72B5AC0DB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiICSkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiICSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:40:35 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1420727FDA;
        Sat,  3 Sep 2022 11:40:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 757965C00D6;
        Sat,  3 Sep 2022 14:40:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 03 Sep 2022 14:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxfierke.com;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1662230432; x=
        1662316832; bh=XzLw5vYcr1J4oSmZ5M3XQeQrDLvf7gMoOQ4jx6zOY60=; b=s
        C+FPLJ0eOjaLCkYP4fG37p5rRR1nj8q8wk3+jCgAHPgUtOFqEEj03XOZX8LrnZLX
        3LSvZfcHl+BPtg5qewjPT/RH/S9V1VK3QcFaiOADHAS010w3RmB2yjPilgf9I96n
        mcNS5U3hC1CeJLUrPIktPZF3+K4v1GZZU+/5agL/ZGtbcxkuGcmuiOD47IXmzjyC
        OVez5R4Q5qcAGFduV/Mg6q+vqtspJEcpyeY9bUvsYmdx6HcUhVZ9dvSNiZDSZAwx
        0r9jQrBIZfQclEjRfs+Qgb/EP+D3t5ZQxkqZztpuBhGZ3FTyZeikQmr4hoT/LaMU
        e8ylCgZiIxbh5indk4d4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1662230432; x=1662316832; bh=XzLw5vYcr1J4o
        SmZ5M3XQeQrDLvf7gMoOQ4jx6zOY60=; b=loCfU8GZJYU/y2e67TGJwyitiL+Wd
        pvqr2ndpkTcmyGGUB/AePBqXTK9a/oJ6ru2XvLG96WblIG5gCv7rpVF9voWdh07u
        KkokTLLnhvZqq8Q2ldgibeF8625KA8SkUWlsCyxp9HMLNWux8qMb9rU/0emGWkqy
        hDyksJna0U6hMPIXYROjVA5Z2zt+exEK24GHt5vWjeE/4Vn+XG/x2V10dB+nBxAP
        NrAKBfu6UnOIsSXkySdzp4gAWkoo04+mRxILJm6R2e8ncao8uU/amgrPfpNAMqS6
        c6n3BGZ2GXOH7FQzKn7k1/2WRF+IAk6UbFBA8l8PRU/ojL+NyiR8Sd2VQ==
X-ME-Sender: <xms:oJ8TY5mBbU4__fh3GFyPPsLGibhDnmP3uz5wrJFKxPOmwH2vpQ6HSw>
    <xme:oJ8TY03AETa5jWVj-q3zBeZogPuLjttc93IU2VINK3LlJyXY72kCF9mwokTN4b12G
    8AU_LxFrMWP7XaQlQQ>
X-ME-Received: <xmr:oJ8TY_pmsPwm-cxdTwxQtAQDPwqFykZ_FgddhLaZevxO9arp-hURi838TkxPWAjNbVdttX0REHDqc78efIk4B9kEbXjgYeEWbe60r9k47lp34er6NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelvddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgig
    ucfhihgvrhhkvgcuoehmrgigsehmrgigfhhivghrkhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejuefghffgjeekfefhueeglefggeetieejheehfffhkedtueffheehledvvdek
    feenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgiesmhgrgihfihgvrhhkvgdr
    tghomh
X-ME-Proxy: <xmx:oJ8TY5ng-xKteNiq0Ptu613O9ykBljn5DyUz3GQGvBe_ZGaSnR69yQ>
    <xmx:oJ8TY33bV1hyNt89Z7k0XHxR5psqv17k0MZvy9x_gVhhq3kbuXrLJg>
    <xmx:oJ8TY4tevcr6pVigGvGxxMa4-TnKOGyb0GK7oh-5f8pW-aumvrRfjg>
    <xmx:oJ8TY-2M6tqp-mdajFBhpQhWP1K8Oj7QvQoqF9rYbt3GnyGZ2Y7Ipw>
Feedback-ID: idee9475d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Sep 2022 14:40:31 -0400 (EDT)
From:   Max Fierke <max@maxfierke.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Fierke <max@maxfierke.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/4] dt-bindings: display: Add ClockworkPi CWD686 panel
Date:   Sat,  3 Sep 2022 13:37:51 -0500
Message-Id: <20220903183753.25736-3-max@maxfierke.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903183753.25736-1-max@maxfierke.com>
References: <20220903183753.25736-1-max@maxfierke.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CWD686 is a 6.86" IPS LCD panel used as the primary
display in the ClockworkPi DevTerm portable (all cores)

Signed-off-by: Max Fierke <max@maxfierke.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2 (Krzysztof Kozlowski and Rob Herring's Suggestions)
 - remove redundant backlight example
 - add missing regulators

 .../display/panel/clockworkpi,cwd686.yaml     | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml b/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
new file mode 100644
index 000000000000..eaf55d629266
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/clockworkpi,cwd686.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ClockworkPi CWD686 6.86" IPS LCD panel
+
+maintainers:
+  - Max Fierke <max@maxfierke.com>
+
+description: |
+  The ClockworkPi CWD686 is a 6.86" ICNL9707-based IPS LCD panel used within the
+  ClockworkPi DevTerm series of portable devices. The panel has a 480x1280
+  resolution and uses 24 bit RGB per pixel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: clockworkpi,cwd686
+
+  reg:
+    description: DSI virtual channel used by that screen
+    maxItems: 1
+  iovcc-supply:
+    description: regulator that supplies the iovcc voltage
+  vci-supply:
+    description: regulator that supplies the vci voltage
+
+  reset-gpios: true
+  rotation: true
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - backlight
+  - reset-gpios
+  - iovcc-supply
+  - vci-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "clockworkpi,cwd686";
+            reg = <0>;
+            backlight = <&backlight>;
+            reset-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
+            rotation = <90>;
+            iovcc-supply = <&vcc_1v8>;
+            vci-supply = <&vcc3v3_sys>;
+        };
+    };
-- 
2.37.1
