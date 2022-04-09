Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558784FAA1F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbiDISTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiDISTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:19:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD55577F;
        Sat,  9 Apr 2022 11:17:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e16so20006337lfc.13;
        Sat, 09 Apr 2022 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=dkZS+u1u1YMngtfyHQMffzDhiw+IRddRGo68l2Ra+Cw=;
        b=erY9p/SC8sRYECfqtwi8P4kDVvNzSfEgfZtOq+pRsbxMJq07ScwSMtPUWRQHnh+vza
         IqHeExlv5yo/1N9Sc5E0doa7hVgqo4N9POWAGnGiZSFqvV7BADRVCdFGL/Xn5p4E7xb+
         wyeg1k745NLeIXDofjdUbcohVEZgHCgZuVjGFWUSfEAppANZoFqip+gZAGxlko4RQBAa
         2KvX6UCudD9c14VOX49GfdTAXm60zQn2ycPVEl9/4eDWGTXxgTC311wxZ2g33GToPZfG
         jmYtxDjFzuvQDM8CMwkILGPY40cmuFL/wsiaIs04AvyfFSQp17FyBmu9wq2E+7M+QcT1
         DFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=dkZS+u1u1YMngtfyHQMffzDhiw+IRddRGo68l2Ra+Cw=;
        b=6jjc3OM38Hx49/liFuI5MuTJWS1/VU/uHT7ehjyL1CIJTAtDlrUaNtCmyhtG1eSJBf
         vBkv+Pgr/keqVezqDgVnZAucm9PKFvkjiDWl/bcPmqXRGMQ7OyTLWSCbZ3rV6zbhkB1t
         9CVwmumUc2RbeRD675YvkIngnJMmhK9hsUOGZEJdJ+2UV7DLykjfr5ugJElMwornFIkD
         r7ry/cgFu8gUgyC6Ny+T7IwTB3dyw0CFUl5BQOu8KxQ+AUXm6C0vMUHrNtrG3ncsyLeD
         5wWPak/+0Tb5TtglucnkHqai89Lw4ePVGmkkLOb9E9HKUBTfac1aNdZg8RftDXPL4mS6
         6qcg==
X-Gm-Message-State: AOAM531wbqdxh63q113ks8oqNABjO93sSrP1Bj35UhVgwjN1BOpBkhx7
        0R1S9eKrEk8kpnLKfr84KCg=
X-Google-Smtp-Source: ABdhPJzNKxmzhOEn8UegFgZGFUfZwPUfAuqLLZWOhmFvJDh2/sWtPffSkZCE4rJw545FObXYwPcVRA==
X-Received: by 2002:ac2:508b:0:b0:46b:9141:a66f with SMTP id f11-20020ac2508b000000b0046b9141a66fmr2768168lfm.198.1649528224929;
        Sat, 09 Apr 2022 11:17:04 -0700 (PDT)
Received: from ?IPV6:2001:470:9898:9eac:f1cb:6e16:4fc0:c830? ([2a09:bac0:87::815:6e3d])
        by smtp.gmail.com with ESMTPSA id q23-20020a2e8757000000b0024b5e0ec306sm38082ljj.97.2022.04.09.11.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 11:17:04 -0700 (PDT)
Message-ID: <bd533827-b575-caad-c230-af060851b231@gmail.com>
Date:   Sat, 9 Apr 2022 21:17:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for Sercomm
 parser
Content-Language: en-US
From:   Mikhail Zhilkin <csharper2005@gmail.com>
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
 <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
In-Reply-To: <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
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


On 4/9/2022 9:04 PM, Mikhail Zhilkin wrote:
>>>>> +required:
>>>>> +  - compatible
>>>> Missing reg.
>>> reg isn't required. Parser can read partition offsets and sizes from
>>> SC PART MAP table. Or do you mean something else?  All is ok
>>> without reg definition in "Example" (except the warns that reg property
>>> is missing).
>> reg might not be required for current implementation but it is required
>> by devicetree for every node with unit address. Do you expect here nodes
>> without unit addresses?
> Only "partitions" node has no unit address. All subnodes  have unit
> addresses and therefore have to have reg property. I've just realized
> that "fixed-partitions.yaml" is almost my case. It looks like I can
> copy'n'paste  "required" and "*properties".
> Do you mind if I don't reinvent the wheel and reuse this good
> practice?
>
> Here's what I got (no any warnings appears):


I'm sorry, Krzysztof & All. Here is the final one.

---
 .../mtd/partitions/sercomm,sc-partitions.yaml | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml

diff --git
a/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
b/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
new file mode 100644
index 000000000000..33172f0be92a
--- /dev/null
+++
b/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
@@ -0,0 +1,78 @@
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
+  locations). Partition map is used by many Sercomm-based Ralink
devices (e.g.
+  Beeline, Netgear).
+
+  The partition table should be a node named "partitions". Partitions
are then
+  defined as subnodes.
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
+patternProperties:
+  "@[0-9a-f]+$":
+    $ref: "partition.yaml#"
+
+required:
+  - compatible
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
> Mikhail
