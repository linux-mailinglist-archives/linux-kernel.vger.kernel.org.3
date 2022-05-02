Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53495516A62
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 07:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383362AbiEBFp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 01:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349296AbiEBFpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 01:45:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953AB35847;
        Sun,  1 May 2022 22:42:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e2so18211216wrh.7;
        Sun, 01 May 2022 22:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SFf90Cp87yxtikwr5SrnqckhY2eRdXiPSkqLmdjSB0Y=;
        b=mdV8gUBfaGKV1xac9Fiq0BXYwgb3hP57li604oiegba4cvbj1pMaXz/DN3sYIqhhQJ
         1jU8oDoMqE5mXAFxOieJKCSi39cshQTbMNHkSSwmWq65LOgTNnEpRESqalbv+tSPWJIR
         uy7UI+FzEjUZlyXN8+xikq6VznA4QpzvpT1tEYOj/SPlE3jjx/A6cspg9FQnqpHqn6KQ
         yIp1dvoSjMDYUZdy+hOqsKd7YrFT5ZfrrRcpv+eWPO7xcAzoXcZqhbJQAuWFix4VkW3v
         hR7L3/p0AqS6TXhTf5hBlYXiKYEMIow7cX939169/z2xX0giDSazAI1pPNmStA6KJpDs
         0LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SFf90Cp87yxtikwr5SrnqckhY2eRdXiPSkqLmdjSB0Y=;
        b=qnF5tAFmWx4JVGq0j/4N+Ii9Q6pUOUHjzCjkaOaZK3jyrcDL7N3tFZV5uUWJ7/qk0J
         PlfpCiMmKl7enmh67dyJS5+0THszmVY2KHpfdQU0g/TntfG4ToYEbGs5WHAbn1z6oIBw
         8UWN0hB8x466mtzQlw4JKz2/0GTxtj1llZP+npLKDG/zJGl3SUOYCP58oJYSLEso6SDq
         1YpSBS//cbF8jgMZfKr83qi+QxYIWhISbTM2IdaNgs0y0XJwGjPYZu+BCXfXJ5fsaYF0
         dso+/DgjCPAUJc/IDrE+oPPKgu1LaVmzUgAerPI89LXSvQ91R61Q9s/hiPys6Cyir7sH
         j3Lw==
X-Gm-Message-State: AOAM530RaxQJJS+DbxsLMSN7P0Fn96HxYfSBvYx9IHg/IqVD63JjQEPG
        V5BqduDg6Owhm8ALEEirnww=
X-Google-Smtp-Source: ABdhPJyZAcTn+ctBQ3cxL4EATaIUzzLMQqvYgKQQ4Qhmg9bQpcj1kAPOtDlrfaCGmcSPEu7FoGQmKw==
X-Received: by 2002:a05:6000:1681:b0:20c:5aa2:ae14 with SMTP id y1-20020a056000168100b0020c5aa2ae14mr4740062wrd.443.1651470146011;
        Sun, 01 May 2022 22:42:26 -0700 (PDT)
Received: from ?IPV6:2a06:a003:501a:a7ce:5405:3d01:56ff:a60d? ([2a06:a003:501a:a7ce:5405:3d01:56ff:a60d])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c230600b003942a244ecfsm5397359wmo.20.2022.05.01.22.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 22:42:25 -0700 (PDT)
Message-ID: <abf8fb56-2ad0-8128-ccd4-105055af9226@gmail.com>
Date:   Mon, 2 May 2022 08:42:24 +0300
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
 <ee5f293a-e59a-03d8-d9e4-ef35d33b5383@gmail.com>
 <6c3ba4a7-80b0-5fd1-eb08-1f9e256b02c4@linaro.org>
 <909094fd-ded0-38f9-b374-dd5f7b63e298@gmail.com>
 <11fbbafd-e7ce-f921-2073-146e96f01f6b@linaro.org>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <11fbbafd-e7ce-f921-2073-146e96f01f6b@linaro.org>
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

On 5/1/2022 7:17 PM, Krzysztof Kozlowski wrote:

> On 01/05/2022 16:51, Mikhail Zhilkin wrote:
>> On 5/1/2022 11:17 AM, Krzysztof Kozlowski wrote:
>>
>>> On 30/04/2022 20:54, Mikhail Zhilkin wrote:
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
>>>> +            sercomm,scpart-id:
>>>> +              description: Partition id in Sercomm partition map. Parser
>>>> +                uses this id to get partition offset and size values from
>>>> +                dynamic partition map.
>>> Partition offset and size values are not derived from scpart-id. I am
>>> sorry but after all these questions - it's the third time now - you
>>> never answer why do you need this property and what is it used for. From
>>> all the examples it could be simply removed and the partition map will
>>> be exactly the same.
>> scpart-id is necessary to get (using mtd parser) partition offset and
>> size from dynamic partition map (NOT from the reg property):
>>
>> ❯ xxd -e -c 12 -s $((0x800)) -l $((0x78)) mtd1
>> 00000800: 00000000 00000000 00100000  ............
>> 0000080c: 00000001 00100000 00100000  ............
>> 00000818: 00000002 00200000 00100000  ...... .....
>> 00000824: 00000003 00300000 00100000  ......0.....
>> 00000830: 00000004 00400000 00600000  ......@...`.
>> 0000083c: 00000005 00a00000 00600000  ..........`.
>> 00000848: 00000006 01000000 02000000  ............
>> 00000854: 00000007 03000000 02000000  ............
>> 00000860: 00000008 05000000 01400000  ..........@.
>> 0000086c: 00000009 06400000 01b80000  ......@.....
>>           scpart-id  offset      size
>>
>> With sercomm,sc-partitions the reg property will be ignored (offset =
>> 0x200000, size = 0x100000) and the values will be taken from partition map.
>>
>> For example we have this is dts:
>>
>> partition@200000 {
>>             label = "Factory";
>>             reg = <0x200000 0x100000>;
>>             sercomm,scpart-id = <2>;
>>             read-only;
>>         };
>>
>> Dynamic partition map:
>>
>> scpart-id = 2; offset = 0x00200000; size = 0x00100000
>>
>> 00000002 00200000 00100000  ...... .....
>>
>> In this example the offset and size are the same in reg and dynamic
>> partition map. If device have bad blocks on NAND the values will be a
>> little different. And we have to take partition offsets from partition
>> map to avoid boot loops, wrong eeprom location and other bad things.
>>
>> Is there anything that needs to be explained in more detail?
> Thanks a lot, this clarifies the topic. Looks good. Maybe you could put
> parts of this into the scpart-id field description?

Thank you for you support! I updated the scpart-id description and hope
this should be clear enough. If so, I'll prepare PATCH v3.

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
+              description: Partition id in Sercomm partition map. Mtd
+                parser uses this id to find a record in the partiton map
+                containing offset and size of the current partition. The
+                values from partition map overrides partition offset and
+                size defined in reg property of the dts. Frequently these
+                values are the same, but may differ if device has bad
+                eraseblocks on a flash.
+              $ref: /schemas/types.yaml#/definitions/uint32

> Best regards,
> Krzysztof

-- 
Best regards,
Mikhail

