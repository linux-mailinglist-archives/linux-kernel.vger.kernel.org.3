Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF490515B48
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382344AbiD3IH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiD3IHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 04:07:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A42492332;
        Sat, 30 Apr 2022 01:04:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n32-20020a05600c3ba000b00393ea7192faso5899266wms.2;
        Sat, 30 Apr 2022 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xh9pubjMeb3o3FM+QnkmnVOKKHDYvAGdOjaoC0qkMS8=;
        b=epJsoiPoZVHhPAyNMEKDKBb0IFBygqOijGeTVAhD9r/PaAUGbCWdPm7AC0PUCuB1+3
         gozFBWVCJWLCBZ0KrTbmupBB8g6uux9n4gX7fYh/ucn05yQR9h+e0B7gIptx49MmSz4c
         WxdFYcwxD/5g7AZhXl7+ONMFQh3y9pBFoTS7XLVsmcFwo3u2kfLMlWdPclh7L4A8br5r
         gtSlejIm8G1LSfbl4qNnbr7vYRA4AoT4h4K55UPl4vb14T0Zt6DIev8cUZGKwgUWUY8k
         Fna1EBkzLqMYWy3YurGVo24M1JrHFebULCeN88q8Hv5k1OUH6MgnDm0Vl8pZeT5huTEO
         Rs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xh9pubjMeb3o3FM+QnkmnVOKKHDYvAGdOjaoC0qkMS8=;
        b=HJam9dTT5rmq+AdGgRkiRGv4ozmZdqPMiDxJUNzR/RvObYYOIG/MYIgRG8g7O8hjju
         cmLChb/dg2GXS7YbLSxMSc6vp28s/at6S+sZ2F2d02guwvDDQU2yQ7OYKYNUISAZwLvC
         ORjvTPWeOEFJ36Jf/w7cVPGKxkWoR3T2PgbWoEzZ7ruxKQTuIWIWHCffv/bGcJ5zHXEh
         uTjbt0zwEIf4hJmj9fve+E6sVMTHQ/Nj2Zbbr5oCn3SOgkYl+YjOItn6tz29ZbZZGnXb
         zE+Ig78z0nFGltXvjYSxgr3zppLaJ0RxQ4fUocKOhSg4MZ71qeDjcjeWtUaxTL/aNUQ5
         oRZw==
X-Gm-Message-State: AOAM530QRLzz5VuC6pw6G1XCJaDgpwimxLWRoEJSE+thq6szwcmWmEam
        pZsM5cYTfFDjEG1Z+RX7JkAbLWpYz9cwNBIlVGo=
X-Google-Smtp-Source: ABdhPJzdoM+Kd0V6q2zu3OJLhQfGJ9rUGzrVpoGneVa0zAJy95Vg1IowIGaV96u+YYqrAnGCx7l6Wg==
X-Received: by 2002:a05:600c:1f0f:b0:38e:c9c8:9983 with SMTP id bd15-20020a05600c1f0f00b0038ec9c89983mr2486393wmb.105.1651305871808;
        Sat, 30 Apr 2022 01:04:31 -0700 (PDT)
Received: from ?IPV6:2a06:a003:501a:a7ce:1c4f:5843:2dc4:fd34? ([2a06:a003:501a:a7ce:1c4f:5843:2dc4:fd34])
        by smtp.gmail.com with ESMTPSA id e12-20020adfa74c000000b0020c5253d8d6sm1345979wrd.34.2022.04.30.01.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 01:04:31 -0700 (PDT)
Message-ID: <0450d781-c506-c28e-a0e5-435bee16721f@gmail.com>
Date:   Sat, 30 Apr 2022 11:04:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
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
 <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
 <bd533827-b575-caad-c230-af060851b231@gmail.com>
 <db70e53b-7484-43bf-e9c8-b6a2dce1fbb5@linaro.org>
 <25da3f43-c46e-8108-2da9-0e4f2b7cc1a4@gmail.com>
 <b279040a-a782-a2ca-2acb-2d8f07709081@linaro.org>
 <1c19faf9-fc1c-9adf-d038-97b673a8f0be@gmail.com>
 <a84df850-149e-9656-43fa-1f040368a9f1@linaro.org>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <a84df850-149e-9656-43fa-1f040368a9f1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/2022 11:22 PM, Krzysztof Kozlowski wrote:

>>>> Real dts:
>>>>
>>>> Link:
>>>> https://github.com/openwrt/openwrt/blob/edcc1a9a734bb3fcdc9242025290d3f173e71b78/target/linux/ramips/dts/mt7621_beeline_smartbox-giga.dts#L79
>>>>
>>>> So, I currently found another solution - to extend fixed-partitions.yaml
>>>> with "sercomm,sc-partitions". Is It ok from your side? Can I use this
>>>> code in v3?
>>> Not really, I don't understand why do you need it 
>> The main idea is keeping original Sercomm firmware behavior:
>>
>> 1. If dynamic partition map found then use offsets and mtd sizes stored
>> in partition map. It's provided by "sercomm,sc-partitions" compatible.
>>
>> 2. If dynamic partition map doesn't exist or broken then default values
>> (from dts) are used. It's provided by "fixed-partitions" compatible.
> Then you need to adjust fixed-partitions for such case. See syscon case
> (all over the tree and Documentation/devicetree/bindings/mfd/syscon.yaml).

Thanks! Here's what I got (neither errors nor warnings). I also updated
the parser itself by adding the vendor prefix and tested on a real device. 

 .../mtd/partitions/fixed-partitions.yaml      | 61 ++++++++++++++++++-
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git
a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index ea4cace6a955..fa457d55559b 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -17,9 +17,29 @@ description: |
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fixed-partitions
+
+  required:
+    - compatible
+
 properties:
   compatible:
-    const: fixed-partitions
+    anyOf:
+      - items:
+          - enum:
+              - sercomm,sc-partitions
+
+          - const: fixed-partitions
+
+      - contains:
+          const: fixed-partitions
+        minItems: 1
+        maxItems: 2
 
   "#address-cells": true
 
@@ -27,7 +47,18 @@ properties:
 
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
+            sercomm,scpart-id:
+              description: Partition id in Sercomm partition map
+              $ref: /schemas/types.yaml#/definitions/uint32
 
 required:
   - "#address-cells"
@@ -119,3 +150,29 @@ examples:
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
+            sercomm,scpart-id=<0>;
+            read-only;
+        };
+
+        partition@100000 {
+            label = "dynamic partition map";
+            reg = <0x100000 0x100000>;
+            sercomm,scpart-id = <1>;
+        };
+
+        partition@200000 {
+            label = "Factory";
+            reg = <0x200000 0x100000>;
+            sercomm,scpart-id = <2>;
+            read-only;
+        };
+    };
-- 
2.25.1


>>> and it does not
>>> include our previous talks.
>> At the time, I didn't realize how important is it. Understanding began
>> to come after dozens of experiments and checking the similar Linux patches.
>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>>>> b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>>>> index ea4cace6a955..9eebe39a57fb 100644
>>>> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>>>> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>>>> @@ -19,7 +19,11 @@ maintainers:
>>>>  
>>>>  properties:
>>>>    compatible:
>>>> -    const: fixed-partitions
>>>> +    oneOf:
>>>> +      - const: fixed-partitions
>>>> +      - items:
>>>> +          - const: sercomm,sc-partitions
>>>> +          - const: fixed-partitions
>>>>  
>>>>    "#address-cells": true
>>>>  
>>>> @@ -27,7 +31,18 @@ properties:
>>>>  
>>>>  patternProperties:
>>>>    "@[0-9a-f]+$":
>>>> -    $ref: "partition.yaml#"
>>>> +    allOf:
>>>> +      - $ref: "partition.yaml#"
>>>> +      - if:
>>>> +          properties:
>>>> +            compatible:
>>>> +              contains:
>>>> +                const: sercomm,sc-partitions
>>>> +        then:
>>>> +          properties:
>>>> +            scpart-id:
>>> It still misses vendor prefix and we agreed you don't need it, didn't we?
>> Do you mean "sercomm" vendor prefix? If so then we agreed that I include
>> it in a separate patch:
> There was some misunderstanding then. We talk here about scpart-id name.
> Adding vendor prefix cannot be a separate patch because it does not make
> much sense. You add new property with wrong name and immediately
> change/fix it in next patch.
>
> No, it should have proper name since beginning. The property is not used
> in the kernel.

Eureka! Thank you for your patience. I've never seen vendor prefixes for
properties  and didn't know that it's possible too.

>> Link:
>> https://lore.kernel.org/linux-mtd/1b391399-984b-7a63-3265-62ef09caec39@gmail.com/
>>
>> I'm going to send it in v3:
>>
>> ---
>> dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix
>>
>> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to include
>> "sercomm" as a vendor prefix for "Sercomm (Suzhou) Corporation".
>> Company website:
>> Link: https://www.sercomm.com/
>>
>> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index 01430973ecec..65ff22364fb3 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -1082,6 +1082,8 @@ patternProperties:
>>      description: Sensirion AG
>>    "^sensortek,.*":
>>      description: Sensortek Technology Corporation
>> +  "^sercomm,.*":
>> +    description: Sercomm (Suzhou) Corporation
> This can be separate patch, but it's separate issue...
>
>
> Best regards,
> Krzysztof

-- 
Best regards,
Mikhail

