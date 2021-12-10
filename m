Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B98470CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344658AbhLJWP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:15:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344642AbhLJWPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639174308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RG+vJicMqSML39k3bi7zqu+k/AVkghfoYq9xbLHJFcw=;
        b=hO3y1ZQXw26Iwv39HAMYmYERoJJEhzwhUfwlpENtfVk66DBZCs003CSa9oxHdB1RivUAfP
        S2mGnSiJBhsjoGjy488bVEGuDiYdZNQ9RhneqbZZytTKkip8qt2iGJ76vh8DpPNIEBp1hG
        Y68vGD4tdVCLkXaEFD+VCptlwIcQ/O0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-qQA2S4h9PEiQPydKxuH8vg-1; Fri, 10 Dec 2021 17:11:45 -0500
X-MC-Unique: qQA2S4h9PEiQPydKxuH8vg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B99358042E0;
        Fri, 10 Dec 2021 22:11:43 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE64677F29;
        Fri, 10 Dec 2021 22:11:41 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH V5 4/6] dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
Date:   Fri, 10 Dec 2021 17:10:31 -0500
Message-Id: <20211210221033.912430-5-cmirabil@redhat.com>
In-Reply-To: <20211210221033.912430-1-cmirabil@redhat.com>
References: <20211210221033.912430-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree binding
for the Sense HAT in yaml form.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 .../bindings/mfd/raspberrypi,sensehat.yaml    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml

diff --git a/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
new file mode 100644
index 000000000000..a57d1face50e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+$id: http://devicetree.org/schemas/mfd/raspberrypi,sensehat.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi Sensehat
+
+maintainers:
+  - Charles Mirabile <cmirabil@redhat.com>
+  - Mwesigwa Guma <mguma@redhat.com>
+  - Joel Savitz <jsavitz@redhat.com>
+
+description:
+  The Raspberry Pi Sensehat is an addon board originally developed
+  for the Raspberry Pi that has a joystick and an 8x8 RGB LED display
+  as well as several environmental sensors. It connects via i2c and
+  a gpio for irq.
+
+properties:
+  compatible:
+    const: raspberrypi,sensehat
+
+  reg:
+    items:
+      - description: i2c bus address
+
+  interrupts:
+    items:
+      - description: pin number for joystick interrupt
+
+  interrupt-parent:
+    items:
+      - description: gpio pin bank for interrupt pin
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-parent
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      sensehat@46 {
+        compatible = "raspberrypi,sensehat";
+        reg = <0x46>;
+        interrupts = <23 GPIO_ACTIVE_HIGH>;
+        interrupt-parent = <&gpio>;
+      };
+    };
-- 
2.31.1

