Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB164FAA14
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbiDISGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242953AbiDISGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:06:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E233192B8;
        Sat,  9 Apr 2022 11:04:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r206-20020a1c44d7000000b0038ccb70e239so2039050wma.3;
        Sat, 09 Apr 2022 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x+ZHRh6e82n5qKqvhVpyoJ5hZgFMYZM/zhsoK6Nbo1Q=;
        b=YKOP6jVnRkzeNqGA3VvHJwzmjyDK08GWK/YjBh5+xYw1W4RUHgOuaZJpf6wWfZbmwX
         UnS1BuFb+tfQ/sRE1kJdPw23yE9cepOTX12r+AXiVyTszFDEozTaL7SrgMHi+EyS0izg
         zq3+87+Kl8eGRCbCwdSeW1JXQ5R/VEg1MEeRrdoy5pyNAgP2Tr82+UVwvFHDA2WU1SJT
         R9SFIeBollfKOJiRQiY74UvCDqlOHd57iqXVJ2LfY2YhWhkOyc+1wL3OzXwEw+0QOE4w
         G3CLiYfPmFEVtwmzmv4OQBY12+MYpEOQoWC3OIfpyBnNKji7gDbyoVRVkMW3SdTtB/PS
         ABVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x+ZHRh6e82n5qKqvhVpyoJ5hZgFMYZM/zhsoK6Nbo1Q=;
        b=vjezQHPn8IWt5fK8Inpufx9nedPvEpnSYySuBYbtiwTOQ5GqVOVsKPRNeKzaqyeC87
         29Jc5RE2b2L9EgRv+zR4qIsIZfO50xjkGomtdAw0/5TIX0S2YXY2nLHkht6YpLocZFGC
         16/hjDp+k/Itp6EbwLohS//g2RtibILNagFYs405D9T0SwAcBF+c7TzkVeWkSmPtLkQr
         zM0qX6VGBMSuf6WQos1NLM+kKY7bME/ujH4vN+Cuc62qmKyTVZsUjj3NwNH0Yyi/fqFr
         Ape0K4bq5Wc8G0jwNcgnkBY/k1I4Xrk4gIhD/OaYvF1e0UbkdyuMQoGb1UvuU0xhvksz
         1MGw==
X-Gm-Message-State: AOAM533EUIY8F6DoOCrlwWDhAHJ4rMmLIpO2oJyrbAvfBFqZKYeGL/gS
        x/SZfHaLSleGstU0hfR6C8g=
X-Google-Smtp-Source: ABdhPJwLn4H230P5wbpYMvAJbu0DCavPV2PqvXJ+80n8Ppagqwl4TVLKYE2L9RCL3YmS05IwqaKrDA==
X-Received: by 2002:a05:600c:213:b0:38e:6379:af70 with SMTP id 19-20020a05600c021300b0038e6379af70mr21401923wmi.157.1649527448742;
        Sat, 09 Apr 2022 11:04:08 -0700 (PDT)
Received: from ?IPV6:2001:470:9898:9eac:f1cb:6e16:4fc0:c830? ([2a09:bac0:79::82a:3425])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm13715098wmz.43.2022.04.09.11.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 11:04:08 -0700 (PDT)
Message-ID: <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
Date:   Sat, 9 Apr 2022 21:04:05 +0300
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
 <57bebf2f-af4c-b2d9-10e5-19e5104946fb@gmail.com>
 <29cfa017-bbaf-3aba-fe1d-06771957dbaa@linaro.org>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <29cfa017-bbaf-3aba-fe1d-06771957dbaa@linaro.org>
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

On 4/9/2022 3:43 PM, Krzysztof Kozlowski wrote:

>> I'm not sure that "scpart-id" is necessary here. "sercomm,sc-partitions"
>> is necessary. I'm going to add vendor prefix in a separate patch. Is this
>> ok?
> Yes.

Thanks!

>>>> +required:
>>>> +  - compatible
>>> Missing reg.
>> reg isn't required. Parser can read partition offsets and sizes from
>> SC PART MAP table. Or do you mean something else?  All is ok
>> without reg definition in "Example" (except the warns that reg property
>> is missing).
> reg might not be required for current implementation but it is required
> by devicetree for every node with unit address. Do you expect here nodes
> without unit addresses?
Only "partitions" node has no unit address. All subnodes  have unit
addresses and therefore have to have reg property. I've just realized
that "fixed-partitions.yaml" is almost my case. It looks like I can
copy'n'paste  "required" and "*properties".
Do you mind if I don't reinvent the wheel and reuse this good
practice?

Here's what I got (no any warnings appears):

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

(...)

> Best regards,
> Krzysztof

-- 
Best regards,
Mikhail

