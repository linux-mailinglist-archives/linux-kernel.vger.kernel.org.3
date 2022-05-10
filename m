Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982175215D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbiEJMxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241719AbiEJMxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:53:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450BB1A6AED
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so32700176ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwSEDQjFnwotXAtx/HSGdXHZhDY72VMSwl9scvd/d5E=;
        b=o3h880dzH6Y90hW139+ZkGG8SE0ySGB7a41cCmjBk5+OBsUt5ygCr4s3a07LHeQWnH
         k7tyTKvDY8KiFl3HLNiBOWEytjM0/Q7NDBnVXJUN4JNAz/4YP1aiiuh3JBQOhqu/SNoc
         UZUsDAjyy0mDfBkvTUN/c9EzxF5UbUniixJnstsWuob9fekY9RKqtJTKD5Nmcs9I3zx5
         VfFtnJyL0EmHFvyjpdTR1YlCeQc3ZmZ0cO4pdJofo6k1pFrTQ5mK++NXG1jh5MEfvDht
         1iMBCQrkf+c3+XeCmTo+bIT0UEfGoBcN8hW20ZDlO+rebPCX+ZmJQ6YBPcGZC9NvywwZ
         oIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwSEDQjFnwotXAtx/HSGdXHZhDY72VMSwl9scvd/d5E=;
        b=n/3rstNx0KHzGsm9LhqYMkBw0oSbkON+TlMFD0x2bFu26ISLCr7lPOPYmiw8S9Z8PF
         om+uLtmhHa+GKhBR+PBCRgNiEgjlg27waCocwomA98P51TPd1Si7sk43EpDQLvnW3fz5
         gmH1YlzU98bYOEfwz5sgPQgjQn+c1B7/AaxQCDwNGIGiRGNBrcQxjBtmTLIcmwcebhpe
         CGQkug0/4jsh/MXa8PJNowP8mM014mwpVgpcwa2Sqp9m7DYOMTFMY0wzaBRo45/tz9lB
         qo4nK8zWfLH2qUhfvKGrX4ThBYmBqXlL75XPnCP9+qhTs5sEBwDcMHx3VUDioPJEAkKR
         ZnHA==
X-Gm-Message-State: AOAM531T+sonL0J2sNuXkN6i0mUoemPK4785ajMYiYE2m50aW7WLMXoF
        E7We55qUPAzrfE8T9TquRlocoQ==
X-Google-Smtp-Source: ABdhPJzkQHZolGvccUtfG+aH8pjTTF52qEYDIOqyGPbYfIkk82mgKajVFLtjhDSy/pTFLxFlzgdXRw==
X-Received: by 2002:a17:907:6d87:b0:6f8:95d2:6814 with SMTP id sb7-20020a1709076d8700b006f895d26814mr13531809ejc.232.1652186976753;
        Tue, 10 May 2022 05:49:36 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-75-cbl.xnet.hr. [94.253.144.75])
        by smtp.googlemail.com with ESMTPSA id gz14-20020a170907a04e00b006f3ef214e62sm6094290ejc.200.2022.05.10.05.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:49:36 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 02/11] dt-bindings: marvell: convert Armada 37xx compatibles to YAML
Date:   Tue, 10 May 2022 14:49:20 +0200
Message-Id: <20220510124929.91000-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510124929.91000-1-robert.marko@sartura.hr>
References: <20220510124929.91000-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Armada 37xx SoC compatibles to YAML.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../bindings/arm/marvell/armada-37xx.txt      | 26 ----------
 .../bindings/arm/marvell/armada-37xx.yaml     | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
index f6d6642d81c0..29fa93dad52b 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
@@ -1,21 +1,3 @@
-Marvell Armada 37xx Platforms Device Tree Bindings
---------------------------------------------------
-
-Boards using a SoC of the Marvell Armada 37xx family must carry the
-following root node property:
-
- - compatible: must contain "marvell,armada3710"
-
-In addition, boards using the Marvell Armada 3720 SoC shall have the
-following property before the previous one:
-
- - compatible: must contain "marvell,armada3720"
-
-Example:
-
-compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
-
-
 Power management
 ----------------
 
@@ -48,11 +30,3 @@ avs: avs@11500 {
 	compatible = "marvell,armada-3700-avs", "syscon";
 	reg = <0x11500 0x40>;
 }
-
-
-CZ.NIC's Turris Mox SOHO router Device Tree Bindings
-----------------------------------------------------
-
-Required root node property:
-
- - compatible: must contain "cznic,turris-mox"
diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
new file mode 100644
index 000000000000..3f41ef2c6f3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/armada-37xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 37xx Platforms Device Tree Bindings
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Armada 3710 SoC
+        items:
+          - const: marvell,armada3710
+
+      - description: Armada 3720 SoC
+        items:
+          - enum:
+              - marvell,armada-3720-db
+              - globalscale,espressobin
+              - cznic,turris-mox
+              - methode,udpu
+          - const: marvell,armada3720
+          - const: marvell,armada3710
+
+      - description: Globalscale Espressobin boards
+        items:
+          - enum:
+              - globalscale,espressobin-emmc
+              - globalscale,espressobin-ultra
+              - globalscale,espressobin-v7
+          - const: globalscale,espressobin
+          - const: marvell,armada3720
+          - const: marvell,armada3710
+
+      - description: Globalscale Espressobin V7 boards
+        items:
+          - enum:
+              - globalscale,espressobin-v7-emmc
+          - const: globalscale,espressobin-v7
+          - const: globalscale,espressobin
+          - const: marvell,armada3720
+          - const: marvell,armada3710
+
+additionalProperties: true
-- 
2.36.1

