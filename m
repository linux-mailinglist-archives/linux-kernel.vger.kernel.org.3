Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04593514F50
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378373AbiD2PaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiD2PaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:30:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6CB7FF73;
        Fri, 29 Apr 2022 08:26:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u3so11256785wrg.3;
        Fri, 29 Apr 2022 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S21LZMOMIuKscCAVGlXF+uK+ApslTmDzzwG+NZhSchA=;
        b=O7ujDJaUsTmCVSelWMVE0M/07tET5WJFMVFVOCdhUlXIHobJu9cx8jwXkJxEHwTgDX
         lDDELmIAvfWIdgoFN2ZntaiQPn8pJAfUvT2iJ8ZAe1lWxrtjaOlz5xmJc6q/gdhgGtxw
         PeBRLtq5K6nAI3SESy0mfF9f0wb1GTANQU/OxHXXhO+iXvkQOt+wOCmFqlegisWPeOIy
         23XaH+jxoe98JjPdaWC4cxL6Xpd/ol0ncOOieYSbF0VF9PR7OEScLw2WFjr4xRjOw+V4
         Uq5uiJwBokrcirkgocbQ+CopKc9e+1af5OD/j7WDDW37JftCCr/v9ko9JHVu5aLXuPPL
         4N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S21LZMOMIuKscCAVGlXF+uK+ApslTmDzzwG+NZhSchA=;
        b=M2pc6oG2oh3ZmvyOUWB3tt0Va8/NnuQOYnDMJJcPoZz4Xzn1FW3jmxiQWcMbwDzjCb
         sgFTYbLIM/fZK72mQrMWRP5fjWCGwbYM8fat4BcqYZbm7npW15pT1u9AKoAslWTKzvq2
         ulHoSIaFHGcqIU7L8K6XRi8OUq4VNGvUrmJLjHAvyJ2HFBYeCs0JbELOA+spJROlzXs4
         6AXA3vRUIy0AY8wBVyq01YMSC9goXaCCxPpB2lBXEaSaZjK2wVlEpnEajwoIwlT8IBCF
         Comz5bMgr5BeOhA3O0PKhTrhwX52CvN6Vpobo2dHLDZ7/z55Cj8mYpgxxI8E5dpY6rks
         Up4Q==
X-Gm-Message-State: AOAM530esDXaFWyO7sw+ZqQXgThAN2oPBYgkbK/56WIXwmo7HE4nJaPG
        0GDbZrDFd+uuDm0whEJzeNMBnGtSx0d8Up9bxPc=
X-Google-Smtp-Source: ABdhPJwlAbdiau1S8QDQQ1e543yvsafxIJSPKr5DNZyZcTNyn+IdhgE5fQGPkwu328s7IN6cwkoFrw==
X-Received: by 2002:adf:e7c1:0:b0:20a:b724:cedd with SMTP id e1-20020adfe7c1000000b0020ab724ceddmr31941202wrn.409.1651246003754;
        Fri, 29 Apr 2022 08:26:43 -0700 (PDT)
Received: from ?IPV6:2a06:a003:501a:a7ce:d836:2ab4:b41d:7819? ([2a06:a003:501a:a7ce:d836:2ab4:b41d:7819])
        by smtp.gmail.com with ESMTPSA id j8-20020a5d5648000000b0020af42ae172sm2667111wrw.87.2022.04.29.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:26:43 -0700 (PDT)
Message-ID: <1c19faf9-fc1c-9adf-d038-97b673a8f0be@gmail.com>
Date:   Fri, 29 Apr 2022 18:26:40 +0300
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
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <b279040a-a782-a2ca-2acb-2d8f07709081@linaro.org>
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

On 4/29/2022 9:46 AM, Krzysztof Kozlowski wrote:

>>> I am sorry, but you changed now a lot in the bindings and it looks
>>> entirely different. Things previously being correct now are wrong, so
>>> rather start from your old bindings...
>>
>> Looks like I'm a bit confused... I use dual "compatible" in my real dts
>> and I realized that:
>>
>> 1. Therefore I have to use  dual "compatible" in example too:
>>
>> compatible = "sercomm,sc-partitions", "fixed-partitions";
>>
>> 2. When I'm trying to reuse "fixed-partitions" compatible from
>> fixed-partitions.yaml in my new .yaml I get "too long" errors.
> Yes, the fixed-partitions.yaml would have to be changed to allow extension.

Well.

>> Real dts:
>>
>> Link:
>> https://github.com/openwrt/openwrt/blob/edcc1a9a734bb3fcdc9242025290d3f173e71b78/target/linux/ramips/dts/mt7621_beeline_smartbox-giga.dts#L79
>>
>> So, I currently found another solution - to extend fixed-partitions.yaml
>> with "sercomm,sc-partitions". Is It ok from your side? Can I use this
>> code in v3?
> Not really, I don't understand why do you need it 

The main idea is keeping original Sercomm firmware behavior:

1. If dynamic partition map found then use offsets and mtd sizes stored
in partition map. It's provided by "sercomm,sc-partitions" compatible.

2. If dynamic partition map doesn't exist or broken then default values
(from dts) are used. It's provided by "fixed-partitions" compatible.

> and it does not
> include our previous talks.

At the time, I didn't realize how important is it. Understanding began
to come after dozens of experiments and checking the similar Linux patches.

>> diff --git
>> a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>> b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>> index ea4cace6a955..9eebe39a57fb 100644
>> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>> @@ -19,7 +19,11 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    const: fixed-partitions
>> +    oneOf:
>> +      - const: fixed-partitions
>> +      - items:
>> +          - const: sercomm,sc-partitions
>> +          - const: fixed-partitions
>>  
>>    "#address-cells": true
>>  
>> @@ -27,7 +31,18 @@ properties:
>>  
>>  patternProperties:
>>    "@[0-9a-f]+$":
>> -    $ref: "partition.yaml#"
>> +    allOf:
>> +      - $ref: "partition.yaml#"
>> +      - if:
>> +          properties:
>> +            compatible:
>> +              contains:
>> +                const: sercomm,sc-partitions
>> +        then:
>> +          properties:
>> +            scpart-id:
> It still misses vendor prefix and we agreed you don't need it, didn't we?

Do you mean "sercomm" vendor prefix? If so then we agreed that I include
it in a separate patch:

Link:
https://lore.kernel.org/linux-mtd/1b391399-984b-7a63-3265-62ef09caec39@gmail.com/

I'm going to send it in v3:

---
dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix

Update Documentation/devicetree/bindings/vendor-prefixes.yaml to include
"sercomm" as a vendor prefix for "Sercomm (Suzhou) Corporation".
Company website:
Link: https://www.sercomm.com/

Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
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
2.25.1

> Best regards,
> Krzysztof

-- 
Best regards,
Mikhail

