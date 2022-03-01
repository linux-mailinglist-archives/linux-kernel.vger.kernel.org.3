Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E884C8C78
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiCANVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiCANVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:21:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9089BB81
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:20:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bk29so3188539wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 05:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EX7x1WLeV89mTenKTRjKxeZqDFfAAfBdLkab9/KTRFU=;
        b=TmkG97zcvctztj0cYcA9OROjVUsaem9cmT+XGazETkehN80XgxzmgoH4MbJrE+tUHp
         4VoyO1s9D1FJeM6R7rKRnw3RgRitb7Hs098qcWx7CAWrHbWh6p+dBRJC+sNzST1Xl4XL
         650FV+qHUHteM3HY/ct40vL1L/XJmIcmYvlfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EX7x1WLeV89mTenKTRjKxeZqDFfAAfBdLkab9/KTRFU=;
        b=JcgXD1Ce+barQRuBj6jXyLXJs9LUpsj0tnVSv3bPG5audj8LahpJgWIrwTlNsc/ZUa
         V9zubtPp9AYZ9x4Mq/O9QWnNIg3nPE37MeUxmUOQh9UHtoHdpK24/2qHv5ihlV4kDXVd
         QALMKsO/c4AZlszMMpdfD5saIxqOKus7eCme/clM/B40jhlrVtaw6ZKGZZZjgJ/w6p4v
         V3YwfWjG74u8511fdVArFjj5FeFCdaHboA31BoCg6UoEJwWxxnUKL8ELieST3jmxpbqr
         8v9Uqj3wYgrhsVE39cKseD606zTJjPHhzxLgCgS8Ibc17MiS0hI+erX7apsRabh4tg3D
         W5mg==
X-Gm-Message-State: AOAM531gRehWGyJzhvvhJJFPe9BNwTPI7rn8YpKzPs7w5oyuqt0R0f2w
        R6z8ITr7VcEdJp4m9G3DInmK+w==
X-Google-Smtp-Source: ABdhPJwRE/3HFFsGWfsejA9PpDzCYob2PkUibpYrTch3RhB8qmtJNFi8JLnGsmSI6SBkT62DuIpF5w==
X-Received: by 2002:a5d:4a8b:0:b0:1ef:9566:71c4 with SMTP id o11-20020a5d4a8b000000b001ef956671c4mr9769298wrq.400.1646140850254;
        Tue, 01 Mar 2022 05:20:50 -0800 (PST)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id i12-20020adfe48c000000b001ef6eab4c81sm13258492wrm.96.2022.03.01.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 05:20:49 -0800 (PST)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: usb: add TS5USBA224 USB/Audio switch mux
Date:   Tue,  1 Mar 2022 14:20:06 +0100
Message-Id: <20220301132010.115258-3-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301132010.115258-1-alvin@pqrs.dk>
References: <20220301132010.115258-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The TS5USBA224 is a USB High Speed/Audio switch mux IC controlled via
GPIO. It is typically composed with a Type-C port controller with Audio
Accessory mode detection.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 .../bindings/usb/ti,ts5usba224.yaml           | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,ts5usba224.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,ts5usba224.yaml b/Documentation/devicetree/bindings/usb/ti,ts5usba224.yaml
new file mode 100644
index 000000000000..0a488b961906
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,ts5usba224.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,ts5usba224.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TS5USBA224 USB 2.0 High Speed and Audio mux DT bindings
+
+description:
+  The Texas Instruments TS5USBA224 is a double-pole, double throw
+  (DPDT) multiplexer that includes a low-distortion audio switch and a
+  USB 2.0 High Speed switch in the same package.
+
+maintainers:
+  - Alvin Šipraga <alsi@bang-olufsen.dk>
+
+properties:
+  compatible:
+    enum:
+      - ti,ts5usba224
+
+  asel-gpio:
+    description: Output GPIO for A_SEL signal
+    maxItems: 1
+
+  accessory:
+    type: boolean
+    description:
+      Indicates that this is an Accessory Mode mux.
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      OF graph bindings modelling a Type-C port controller.
+
+required:
+  - compatible
+  - asel-gpio
+  - accessory
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    usbaudiomux@0 {
+      compatible = "ti,ts5usba224";
+      asel-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+      accessory;
+
+      port {
+        usb_audio_mux1: endpoint {
+          remote-endpoint = <&typec1_mux>;
+        };
+      };
+    };
-- 
2.35.1

