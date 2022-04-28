Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73A451383F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349109AbiD1P17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbiD1P16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:27:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D02EB7157;
        Thu, 28 Apr 2022 08:24:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id q185so7169067ljb.5;
        Thu, 28 Apr 2022 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SzJXhZg7qGrBl+J121B58kcKO0wVfv/TnHF/oCwmV6o=;
        b=hzmBfUP04rp5lGzXAo7D1RGUZ1S6j/COkdetxgNRb+SU7A+uun0bJ78x2DdmHJ5fHj
         TT3pTRQ0Rm5XlHh4ZjpHbZXAcVunIS5U9CRKGaVwRYQdAbE/kNkUbaxqJAznMOJCUqwU
         jqFTZ68BTSNvbHbajn31p8UYJLPGRUN3tsduXGryeD4ia9HnFkAHrwtYyX8WdlUcKyaP
         07jVeXi4kaBDcUsV3NuC+nWE2FES5WwKFOvoM2Ge3wq2ijeZwSmKlFpyfPfu/qFRc7fG
         iYqihaFt4y/OCtpE+lKrTKd8hJNdco+9QJB72olUze5Nq9UUsf5tpEjf7opUOc+RVIaA
         89KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SzJXhZg7qGrBl+J121B58kcKO0wVfv/TnHF/oCwmV6o=;
        b=Go/qvcigXmycv0B2xLFrd/yKuSNFQ70cADca58eP8o0EkpR9zoWYgomqyWpp4cBTWC
         YkjNEHA0abvyltezXWRpRXdxrzErvBrK14uafCYu/8Kte5BxpiOx60QdeV1H4+H34nSL
         scpYWCcIQA08YOYEGyCA7mXIpYFbqQ89JDBCvkxIEnHP+1597QTm7uGISDAbjbfMHui/
         ZwyCNBPUqebrZoWI22KCamqzu3AHJwmNpQoRGeW8LOnqEuxbdsfpEairAVPmdjoHEPDW
         X4iCiaKKsUtIEgtgHDMWAyqb979rvAwJKfIlX47LzEFFeiEbE6OkQuFOPgyMkXUCvzvo
         k3HQ==
X-Gm-Message-State: AOAM531XG6AXv5eYAmf/9KRA4fKb7bjNB4WznPE2emNEUVo3lDRh6Eyr
        yRrELoWUrm7w7sOc63IOgXY=
X-Google-Smtp-Source: ABdhPJxAsRNvdhIkNNUOuQo9jhs45Y/TigHYoQssJn3JBnGYv0FOckyPXgZr4kxnhvowMEuwzIz0AA==
X-Received: by 2002:a2e:1f11:0:b0:24b:6b35:42e3 with SMTP id f17-20020a2e1f11000000b0024b6b3542e3mr21503724ljf.195.1651159481353;
        Thu, 28 Apr 2022 08:24:41 -0700 (PDT)
Received: from ?IPV6:2a06:a003:501a:a7ce:d836:2ab4:b41d:7819? ([2a06:a004:d009:c8fa:102c:912a:a6e3:41ea])
        by smtp.gmail.com with ESMTPSA id s11-20020a2e9c0b000000b0024ace83744asm19844lji.116.2022.04.28.08.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 08:24:40 -0700 (PDT)
Message-ID: <25da3f43-c46e-8108-2da9-0e4f2b7cc1a4@gmail.com>
Date:   Thu, 28 Apr 2022 18:24:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for
 Sercomm parser
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
 <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
 <bd533827-b575-caad-c230-af060851b231@gmail.com>
 <db70e53b-7484-43bf-e9c8-b6a2dce1fbb5@linaro.org>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <db70e53b-7484-43bf-e9c8-b6a2dce1fbb5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Krzysztof,

On 4/10/2022 11:18 AM, Krzysztof Kozlowski wrote:
> I am sorry, but you changed now a lot in the bindings and it looks
> entirely different. Things previously being correct now are wrong, so
> rather start from your old bindings...


Looks like I'm a bit confused... I use dual "compatible" in my real dts
and I realized that:

1. Therefore I have to use  dual "compatible" in example too:

compatible = "sercomm,sc-partitions", "fixed-partitions";

2. When I'm trying to reuse "fixed-partitions" compatible from
fixed-partitions.yaml in my new .yaml I get "too long" errors.

Real dts:

Link:
https://github.com/openwrt/openwrt/blob/edcc1a9a734bb3fcdc9242025290d3f173e71b78/target/linux/ramips/dts/mt7621_beeline_smartbox-giga.dts#L79

So, I currently found another solution - to extend fixed-partitions.yaml
with "sercomm,sc-partitions". Is It ok from your side? Can I use this
code in v3?

diff --git
a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index ea4cace6a955..9eebe39a57fb 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -19,7 +19,11 @@ maintainers:
 
 properties:
   compatible:
-    const: fixed-partitions
+    oneOf:
+      - const: fixed-partitions
+      - items:
+          - const: sercomm,sc-partitions
+          - const: fixed-partitions
 
   "#address-cells": true
 
@@ -27,7 +31,18 @@ properties:
 
 patternProperties:
   "@[0-9a-f]+$":
-    $ref: "partition.yaml#"
+    allOf:
+      - $ref: "partition.yaml#"
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: sercomm,sc-partitions
+        then:
+          properties:
+            scpart-id:
+              description: Partition id in Sercomm partition map
+              $ref: /schemas/types.yaml#/definitions/uint32
 
 required:
   - "#address-cells"
@@ -119,3 +134,29 @@ examples:
             };
         };
     };
+  - |
+    partitions {
+        compatible = "sercomm,sc-partitions", "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            label = "u-boot";
+            reg = <0x0 0x100000>;
+            scpart-id=<0>;
+            read-only;
+        };
+
+        partition@100000 {
+            label = "dynamic partition map";
+            reg = <0x100000 0x100000>;
+            scpart-id = <1>;
+        };
+
+        partition@200000 {
+            label = "Factory";
+            reg = <0x200000 0x100000>;
+            scpart-id = <2>;
+            read-only;
+        };
+    };
-- 
2.25.1


>> +
>> +additionalProperties: true
> This is wrong, why it became true?

You're right. Got it


> Best regards,
> Krzysztof

-- 
Best regards,
Mikhail

