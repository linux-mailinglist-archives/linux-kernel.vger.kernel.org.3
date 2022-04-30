Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AFD515FEC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 20:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbiD3S6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 14:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbiD3S6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 14:58:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BEA6AA69;
        Sat, 30 Apr 2022 11:54:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e2so14726119wrh.7;
        Sat, 30 Apr 2022 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D0+x/yJ2k7VejWfPmsLmIQrShDrcM1gbM8xZRgFTcbg=;
        b=aXEUd1SGnNin82HWtus9mmAglNks5GWr7dtfe8+AcqM5IjIdAQYdrCeo+eH86n1tIf
         oI4uOg6PsfW7B+qjsLC30V8S+gY2ratp7r8YDrd4Wu+ap1Nir/4J6alUhqAQ1g7yLa/T
         HW5MA/WQou5+/iv/zoKVTMz1Vcu2RMGmC7xXeF6GV0eeTBUuCwldB6YFh9vlPHdKzYsR
         AiHBlzO946p/cgqIdGyeYJmp+g51qiY+keTuBzIfNBfL0DXQVLohCBkWdKY7wIpqqzXd
         1CPWY3fctXVmNmdgZ8KsqybkG/YbQf5a3Y6p7UWbyCWtdqlvTbZ+z4aQPJtvp3aKYLH3
         fYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D0+x/yJ2k7VejWfPmsLmIQrShDrcM1gbM8xZRgFTcbg=;
        b=GVBESohdpYZIo5y6AztDFZwbGABVmpMJUAbpmIvHQoyafZhRGJxDuWmWH0+WbTlcsv
         SRyF53UoVdcnPusgA2jBUueDMLKU/kACNIaK6QIaVpzAKUHQEikxOvj0IsOTzUrRhsDC
         CC1pkkQchm0Fz3pvyAgeh30tUNBjCPKcz0TPVljuC5BttTHlyIqV/JS5rOJH8aXzcDWM
         5vvrZiYfYJFNNKtZq6ssBnGgQDClO5DE+rPcDnQcUnsbRoIQ4mAXv5NWIStll4b3KoN9
         xJDDDbQlESywLiluzFMvLDDggeJGpsHm0pW7vuY6ExOVeBbt4p9ONBU4e2wuzoRMzr6Y
         5rBg==
X-Gm-Message-State: AOAM5339imKVkmbWzk2eTJmNRvJD6k0cnU+nUlP32ebTxndDWDEYO7rz
        CGRp5WXGsGtEd5HCcmM53P0=
X-Google-Smtp-Source: ABdhPJzmMTPzg9iref6Pzy9FQdMK5YeRUESQ094b8/PWZqrJqqRB9tOkzqUpdIGnyOkQoK8SaBh4WA==
X-Received: by 2002:a05:6000:86:b0:20a:d7be:e09b with SMTP id m6-20020a056000008600b0020ad7bee09bmr3834720wrx.398.1651344887567;
        Sat, 30 Apr 2022 11:54:47 -0700 (PDT)
Received: from ?IPV6:2a06:a003:501a:a7ce:5405:3d01:56ff:a60d? ([2a06:a004:d009:c8fa:102c:912a:a6e3:41ea])
        by smtp.gmail.com with ESMTPSA id n6-20020adf8b06000000b0020c5253d921sm2613117wra.109.2022.04.30.11.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 11:54:47 -0700 (PDT)
Message-ID: <ee5f293a-e59a-03d8-d9e4-ef35d33b5383@gmail.com>
Date:   Sat, 30 Apr 2022 21:54:43 +0300
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
 <0450d781-c506-c28e-a0e5-435bee16721f@gmail.com>
 <2e51842a-d2c9-8953-13aa-02ad3abb3f14@linaro.org>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <2e51842a-d2c9-8953-13aa-02ad3abb3f14@linaro.org>
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

On 4/30/2022 5:35 PM, Krzysztof Kozlowski wrote:

>> diff --git
>> a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>> b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>> index ea4cace6a955..fa457d55559b 100644
>> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>> @@ -17,9 +17,29 @@ description: |
>>  maintainers:
>>    - Rafał Miłecki <rafal@milecki.pl>
>>  
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - fixed-partitions
>> +
>> +  required:
>> +    - compatible
> With your approach you do not need this entire select. I pointed out to
> you if you wanted to take the syscon approach.
>
>> +
>>  properties:
>>    compatible:
>> -    const: fixed-partitions
>> +    anyOf:
> oneOf
>
>> +      - items:
>> +          - enum:
>> +              - sercomm,sc-partitions
>> +
>> +          - const: fixed-partitions
>> +
>> +      - contains:
>> +          const: fixed-partitions
>> +        minItems: 1
>> +        maxItems: 2
> This is also not needed if you do no take the syscon approach.

I tried to take into account all of your comments:

diff --git
a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index ea4cace6a955..45d6a3971514 100644
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
 
@@ -27,7 +31,20 @@ properties:
 
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
+              description: Partition id in Sercomm partition map. Parser
+                uses this id to get partition offset and size values from
+                dynamic partition map.
+              $ref: /schemas/types.yaml#/definitions/uint32
 
 required:
   - "#address-cells"
@@ -52,6 +69,7 @@ examples:
             reg = <0x0100000 0x200000>;
         };
     };
+
   - |
     partitions {
         compatible = "fixed-partitions";
@@ -64,6 +82,7 @@ examples:
             reg = <0x00000000 0x1 0x00000000>;
         };
     };
+
   - |
     partitions {
         compatible = "fixed-partitions";
@@ -82,6 +101,7 @@ examples:
             reg = <0x2 0x00000000 0x1 0x00000000>;
         };
     };
+
   - |
     partitions {
         compatible = "fixed-partitions";
@@ -119,3 +139,30 @@ examples:
             };
         };
     };
+
+  - |
+    partitions {
+        compatible = "sercomm,sc-partitions", "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            label = "u-boot";
+            reg = <0x0 0x100000>;
+            sercomm,scpart-id = <0>;
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


>    "#address-cells": true
>  
> @@ -27,7 +47,18 @@ properties:
>  
>  patternProperties:
>    "@[0-9a-f]+$":
> -    $ref: "partition.yaml#"
> +    allOf:
> +      - $ref: "partition.yaml#"
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: sercomm,sc-partitions
> +        then:
> +          properties:
> +            sercomm,scpart-id:
> +              description: Partition id in Sercomm partition map
> +              $ref: /schemas/types.yaml#/definitions/uint32
> I think we still did not clarify why do you need this ID which in all
> your examples increments by one. The description basically is a copy of
> property name, so it does not explain anything.

I added more detailed description.

>  
>  required:
>    - "#address-cells"
> @@ -119,3 +150,29 @@ examples:
>              };
>          };
>      };
> Blank line.

Fixed. And I added blank lines between already existing examples.

>> +  - |
>> +    partitions {
>> +        compatible = "sercomm,sc-partitions", "fixed-partitions";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        partition@0 {
>> +            label = "u-boot";
>> +            reg = <0x0 0x100000>;
>> +            sercomm,scpart-id=<0>;
> Missing spaces around =.

Thanks. Fixed.

> Best regards,
> Krzysztof

-- 
Best regards,
Mikhail

