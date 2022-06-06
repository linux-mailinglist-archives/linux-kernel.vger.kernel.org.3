Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E8553EE1F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiFFSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiFFSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:49:54 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28171B605F;
        Mon,  6 Jun 2022 11:49:53 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id u2so11648256iln.2;
        Mon, 06 Jun 2022 11:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knkYhw1mfnMkCC1ujwe7ELaa78ZmS0Jjfq7mJJNl874=;
        b=VNTj/sa8HLY5OI+FxyhUINhMkvBc5Wn7jJaHrLpmNxOqueLrFQ6GalBbfT0spVsNpu
         YGRkBG7Fl1TdsxgiB1vaTeuY1poHXpdgh7caqYeVkmHajSqb9ZczaxwSzM2KWSqjOxBT
         Z5NhDp1ElAERPbrE/lFAuPlclW0/GLlqXrsYkvp4iUMd32ijQair6v3jEN2/lkc/1qgo
         QPsd0Qo6efJ6wqiTZcbsZqGhgmj8YCpj6IckuYRwgMoVpz/E7RDpPd14cZn4gn9mQ9gM
         fe+EFcq63gEjwx5JAeJiVmVQJsvRnYbFiUdbo/iXz/ze9gPvIORvMolEIg88CfjXvZx/
         taTg==
X-Gm-Message-State: AOAM5339tM5yx3R3k5LqBpd5LcpGOg6PyLHpETEMN4Q2q+SBAAVBrzad
        oKkmMRchFiFf7FW3bsFEBaDRlriiOQ==
X-Google-Smtp-Source: ABdhPJyWIlqEvE4x3EOI1o9Q6mWaXvkcn4Qazm//NnuXqkHyTrH6NnRRWcfXFf45g7M4f3DdLX4N/A==
X-Received: by 2002:a92:d450:0:b0:2d4:4cdb:d46e with SMTP id r16-20020a92d450000000b002d44cdbd46emr9213150ilm.197.1654541393041;
        Mon, 06 Jun 2022 11:49:53 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id m7-20020a026a47000000b0032ea33f23a0sm5861784jaf.95.2022.06.06.11.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 11:49:52 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: dt-bindings: Convert gpio-ir-receiver to DT schema
Date:   Mon,  6 Jun 2022 13:49:44 -0500
Message-Id: <20220606184944.1067068-2-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220606184944.1067068-1-robh@kernel.org>
References: <20220606184944.1067068-1-robh@kernel.org>
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

Convert the gpio-ir-receiver binding to DT schema format.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/gpio-ir-receiver.txt       | 20 ----------
 .../bindings/media/gpio-ir-receiver.yaml      | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/gpio-ir-receiver.txt
 create mode 100644 Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml

diff --git a/Documentation/devicetree/bindings/media/gpio-ir-receiver.txt b/Documentation/devicetree/bindings/media/gpio-ir-receiver.txt
deleted file mode 100644
index 108bf435b933..000000000000
--- a/Documentation/devicetree/bindings/media/gpio-ir-receiver.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Device-Tree bindings for GPIO IR receiver
-
-Required properties:
-	- compatible: should be "gpio-ir-receiver".
-	- gpios: specifies GPIO used for IR signal reception.
-
-Optional properties:
-	- linux,rc-map-name: see rc.txt file in the same
-	  directory.
-	- linux,autosuspend-period: autosuspend delay time,
-	  the unit is milisecond.
-
-Example node:
-
-	ir: ir-receiver {
-		compatible = "gpio-ir-receiver";
-		gpios = <&gpio0 19 1>;
-		linux,rc-map-name = "rc-rc6-mce";
-		linux,autosuspend-period = <125>;
-	};
diff --git a/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml b/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml
new file mode 100644
index 000000000000..61072745b983
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/gpio-ir-receiver.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO Based IR receiver
+
+maintainers:
+  - Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+
+allOf:
+  - $ref: rc.yaml#
+
+properties:
+  compatible:
+    const: gpio-ir-receiver
+
+  gpios:
+    maxItems: 1
+
+  linux,autosuspend-period:
+    description: autosuspend delay time in milliseconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ir-receiver {
+        compatible = "gpio-ir-receiver";
+        gpios = <&gpio0 19 1>;
+        linux,rc-map-name = "rc-rc6-mce";
+        linux,autosuspend-period = <125>;
+    };
+...
-- 
2.34.1

