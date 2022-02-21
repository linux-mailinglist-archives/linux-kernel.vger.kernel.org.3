Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E88C4BE4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377110AbiBUNyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:54:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349266AbiBUNyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:54:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF63DE80;
        Mon, 21 Feb 2022 05:53:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q17so29670000edd.4;
        Mon, 21 Feb 2022 05:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=G3DC4qi9Rxgo/akJjc9uQtn29p0/BI+YilmzZePFgCA=;
        b=KjMOOzxqt8z6xWdgQOftpOQWDw70KVdrK8Tp3HqRaWT7rOkRBkgE3Z6rAymxth7ub1
         yXKhiKl9ns0NsOqnw/2mlkxQaXf3PjqHWYszGIClDUsrZHqSXZ9fXqvfXK9GS+ELIbIB
         3sYJFUtHfe9Z4yQn4tcAmXQ1w8FCmiPjsz9AI0oUsB4rIoTuFww4WoQg91E0X3LxnF6C
         ikOZtwdI3i1N1Y8Ctqo3WKHOSyC1+uO/L/a8hBwpe+iJtBEXRZjIZGAaYp9Otu6DPpx5
         AgNlKwSVPayOLcEP0L8ygtjAzQjEqLEXXPJtc/ufsOJVgWIj7a1FHXcetWKeauoY+3XE
         XWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=G3DC4qi9Rxgo/akJjc9uQtn29p0/BI+YilmzZePFgCA=;
        b=vIu1INlOSHVAiE2qQw1U7Ie7uPPq8pFro3nRyD9oWZpO9z6xuIqu9PJJiyb/T7jSj+
         FKXMtHHOXqhUny9drD9wINq9pQDok0p7S+QUAcX1GsuezElguu6FfIPNVHXg408iALHt
         ATTJahKV+IW02dVD2+0f8t4WVyc75blc69NlzXIaK+vE5DTraN8Pli0ZFqKuoVEn/gXv
         HmU4+f6BzXtpKyrh/FVHxpkynxld3fghaKrWAJSHrFnoSnE/PSuV5DmK3h13MGKpA9Ns
         isk8IokE4d9jkFkYguvHFx/PV2iVrra9iDzxYWraQ6RWIorcqbInZwiDKVQSxXpsdgNC
         CwzQ==
X-Gm-Message-State: AOAM5316JXYMuNoYIpR1myxR9jdwo5Ppg8n+eq/7hVYOrtRUCQfmsV1I
        U2JG+dzBWYou3KtYA2rkPfF6u5tHRiv4zA==
X-Google-Smtp-Source: ABdhPJyOS03GMYX7eH/DOmGTI9PyzEvRckZJEkOWty6yyMReikfzqySXVV9g6ZS36dAodPSQskn5Qg==
X-Received: by 2002:aa7:c047:0:b0:40b:488:547c with SMTP id k7-20020aa7c047000000b0040b0488547cmr21091419edo.76.1645451632612;
        Mon, 21 Feb 2022 05:53:52 -0800 (PST)
Received: from ubuntu ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id eg42sm6800528edb.79.2022.02.21.05.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:53:52 -0800 (PST)
Date:   Mon, 21 Feb 2022 14:53:51 +0100
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: remoteproc: Add AVM WASP
Message-ID: <20220221135351.GA7342@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AVM Fritzbox router boards may contain an additional ATH79
based SoC that has the wifi cards connected.
This patch adds bindings for this remote processor.

Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
---
 .../bindings/remoteproc/avm,wasp-rproc.yaml   | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
new file mode 100644
index 000000000000..21f3bbcc4202
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/avm,wasp-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AVM WASP processor controller bindings
+
+maintainers:
+  - Daniel Kestrel <kestrelseventyfour@gmail.com>
+
+description: |
+  This document defines the bindings for the remoteproc component that loads and
+  boots firmwares on the AVM Wireless Assistent Support Processor (WASP) SoC
+  that is attached to some AVM Fritzbox devices (3390, 3490, 5490, 5491, 7490).
+
+properties:
+  compatible:
+    const: avm,wasp
+
+  ath9k-firmware:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Should contain the name of the ath9k eeprom that is to be loaded from
+      the lantiq host flash. Wifi on the WASP SoC does not work without it.
+      The file should be located on the firmware search path.
+
+  ath10k-caldata:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Should contain the name of the ath10k caldata that is to be loaded from
+      the lantiq host flash. Wifi on the WASP SoC does not work without it.
+      The file should be located on the firmware search path.
+
+  wasp-netboot-firmware:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Should contain the name of the netboot firmware that is to be loaded
+      and started on the WASP SoC using mdio in order to be able to load
+      the initramfs image as a second stage.
+      The file should be located on the firmware search path.
+
+  wasp-netboot-mdio:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the Lantiq GSWIP switch mdio.
+
+  wasp-initramfs-port:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the network port, where the WASP SoC is connected to.
+
+  wasp-initramfs-image:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Should contain the name of the initramfs linux image that is to be loaded
+      and started on the WASP SoC.
+      The file should be located on the firmware search path.
+
+  reset-gpio:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: Reference and parameters for the reset gpio of the WASP SoC.
+
+  startup-gpio:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: Reference and parameters for the power switch gpio of the WASP SoC.
+
+required:
+  - compatible
+  - ath9k-firmware
+  - ath10k-caldata
+  - wasp-netboot-firmware
+  - wasp-netboot-mdio
+  - wasp-initramfs-port
+  - wasp-initramfs-image
+  - reset-gpio
+  - startup-gpio
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    avm-wasp {
+        compatible = "avm,wasp";
+        ath9k-firmware = "ath9k-eeprom-ahb-18100000.wmac.bin";
+        ath10k-caldata = "ath10k/cal-pci-0000:00:00.0.bin";
+        wasp-netboot-firmware = "netboot.fw";
+        wasp-netboot-mdio = <&gswip_mdio>;
+        wasp-initramfs-port = <&port5>;
+        wasp-initramfs-image = "avm_fritzx490-wasp-initramfs-kernel.bin";
+        reset-gpio = <&gpio 34 GPIO_ACTIVE_HIGH>;
+        startup-gpio = <&gpio 5 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.17.1

