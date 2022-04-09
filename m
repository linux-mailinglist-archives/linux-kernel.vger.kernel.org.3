Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741B84FA7A5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241419AbiDIM2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiDIM2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:28:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415EB20F54;
        Sat,  9 Apr 2022 05:26:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id p15so22110745ejc.7;
        Sat, 09 Apr 2022 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7lfQcIbfBOc571bYYHEBdw9+NesBxMLEAHBRpYUsHpM=;
        b=l85U+/e7//bKcpyGvLxrG1yhyKHxmr8w0SZGTNL3wt/aXsU+h+Fhpm9g9IMKCaHddY
         wD6KZlCzZNLezOg0axwRxV+qooDNxnYLncy3DrXj6o/Xu/2ap33MEq206G9/KRr3VFIT
         CofDszGEYpnaQaFCqS6XHFR5ODJyrYoHaTmXqWK5SvRCJkWXhda0LQCAFvtLy7mnjHI7
         VyqzivHW8A6JGrVbdDHb1ahA39OpC/CcYqIM5nXqPSNE0SpKtRkgHm0SDquqopv/FgIL
         wnjmEjwZ40OJSEf3Xy5xNQzIfIxV4DjIKuQt7tXnnegW8rnzxliv2KIFqMcRZ1KHCGz4
         DQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7lfQcIbfBOc571bYYHEBdw9+NesBxMLEAHBRpYUsHpM=;
        b=Xn3rCm+vf0rhIKnn9IIdZ1pA1Vrwbe47gRAKeg4ujcI+WSW1foPL6kHT9ktxv1Fp6D
         I5845krXDYBY+Xa506rqsE1s/RsiSNhzE+i41TY1jC30MOxv2tBzz9+pLH2zEzNNfr0z
         TFaYdd0di+6lySnPe+1ZvJhMN85ZVQpyfDAuuOeNw3YLMH8dcbu8ZMyX/y9fUe0OoQ1I
         j4ZdLgTCsHz0rqud2icdFHZ1oWxDwaSSGSrKFo9jlkOcV9Y6r2wkZ0HpBJj1A2Au02QD
         EB2LjqLuYZfq2HxTVwoKJzlni5FbmQP+1wfHqnC3ptzO1V2qp4wqd8B0fHbIeMJzG5xP
         wJ7A==
X-Gm-Message-State: AOAM530ZMPQK4zAOXlQEvyEc18y04In5iVzpGlaN+gVonpgAmuxi/s/b
        njkBomCZ+hRBOi4Pn+4iE90=
X-Google-Smtp-Source: ABdhPJxSTnOEszZHgvZHGQfO9wFH+eqKR2uXs4Rx7bKoPu19YS1mecM/8PT8N6e3NVhq+hel+fkK2g==
X-Received: by 2002:a17:906:e28a:b0:6d6:e2e9:d39d with SMTP id gg10-20020a170906e28a00b006d6e2e9d39dmr22135072ejb.2.1649507186790;
        Sat, 09 Apr 2022 05:26:26 -0700 (PDT)
Received: from ?IPV6:2001:470:9898:9eac:f1cb:6e16:4fc0:c830? ([2a09:bac0:87::815:6e3d])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfd8074d27sm9526982ejc.79.2022.04.09.05.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 05:26:26 -0700 (PDT)
Message-ID: <57bebf2f-af4c-b2d9-10e5-19e5104946fb@gmail.com>
Date:   Sat, 9 Apr 2022 15:26:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for Sercomm
 parser
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
 <8d0d8b27-35ff-3693-cf80-897b80c26b4e@linaro.org>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <8d0d8b27-35ff-3693-cf80-897b80c26b4e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 4/7/2022 10:48 AM, Krzysztof Kozlowski wrote:

(...)

>> +properties:
>> +  compatible:
>> +    const: sercomm,sc-partitions
>> +
>> +  scpart-id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Partition id in Sercomm partition map
> Do you really need it? The reg should define the order, unless you
> expect some incomplete partition list?
>
> In any case this requires vendor prefix.

I'm not sure that "scpart-id" is necessary here. "sercomm,sc-partitions"
is necessary. I'm going to add vendor prefix in a separate patch. Is this
ok?

---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..65ff22364fb3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1082,6 +1082,8 @@ patternProperties:
     description: Sensirion AG
   "^sensortek,.*":
     description: Sensortek Technology Corporation
+  "^sercomm,.*":
+    description: Sercomm (Suzhou) Corporation
   "^sff,.*":
     description: Small Form Factor Committee
   "^sgd,.*":
--

>> +
>> +required:
>> +  - compatible
> Missing reg.

reg isn't required. Parser can read partition offsets and sizes from
SC PART MAP table. Or do you mean something else?  All is ok
without reg definition in "Example" (except the warns that reg property
is missing).

> Are you sure that you tested your bindings? You miss here address/size
> cells and children, so you should have big fat warning.
>
> Plus your DTS example has error and does not compile...

Whole dts, for the real device (not for example), was tested many times.
Thank you for your feedback! I checked the another examples and there
are no any warnings now. But I'm not yet sure that "properties" and
"required" are correct.
What do you think (or what else I have to read / check)?

---
 .../mtd/partitions/sercomm,sc-partitions.yaml | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml

diff --git
a/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
b/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
new file mode 100644
index 000000000000..cb171a0383aa
--- /dev/null
+++
b/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id:
http://devicetree.org/schemas/mtd/partitions/sercomm,sc-partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sercomm Partitions
+
+description: |
+  Sercomm is one of hardware manufacturers providing SoCs used in home
routers.
+  The Sercomm partition map table contains information about non-standard
+  partition offsets and sizes (depending on the bad blocks presence and
their
+  locations). Partition map is used by many Sercomm-based Ralink devices
+  (e.g. Beeline, Netgear).
+
+maintainers:
+  - Mikhail Zhilkin <csharper2005@gmail.com>
+
+properties:
+  compatible:
+    const: sercomm,sc-partitions
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: true
+
+examples:
+  - |
+    partitions {
+        compatible = "sercomm,sc-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            label = "u-boot";
+            reg = <0x0 0x100000>;
+            scpart-id = <0>;
+            read-only;
+        };
+
+        partition@100000 {
+            label = "dynamic partition map";
+            reg = <0x100000 0x100000>;
+            scpart-id = <1>;
+        };
+
+        factory: partition@200000 {
+            label = "Factory";
+            reg = <0x200000 0x100000>;
+            scpart-id = <2>;
+            read-only;
+
+            compatible = "nvmem-cells";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            macaddr_factory_21000: macaddr@21000 {
+                reg = <0x21000 0x6>;
+            };
+        };
+
+        /* ... */
+
+    };
-- 

> Best regards,
> Krzysztof

Best regards,
Mikhail

