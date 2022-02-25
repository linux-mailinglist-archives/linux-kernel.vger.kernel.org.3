Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7064C3F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiBYHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiBYHby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:31:54 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9043725D6F3;
        Thu, 24 Feb 2022 23:31:22 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id r13so9117124ejd.5;
        Thu, 24 Feb 2022 23:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=8s/sEEcezqOxjPo1IRls593HXMXJluYQRZTRz8WXcj8=;
        b=Jd+WEwcsLf9IpHmWlG9ySEMdGpPs+3onyuscGmGbKmdhMheleGyTL9Cm9ALua0Q9YH
         /ju3VD/q63kgKX4Mbo8t5adzCIT3trHUFM/TvGsnx9qEHGk/Iys989IMOTvzechAw1Em
         ufYmqqNZNo0wUl7PC+rSgzqe+A3VUNFSlRW9+AfPIZ77BhnI5uYKFmK1bRGly64DhRDP
         svTsahuO7E7fp8yH3Ar4o6+OLdDifCR2hSPuuhzRcn0XurBaw4O/EFalRhSZL9MDwRH0
         Zd3ayxDHA26g6dyZA7GZgaynwbN6gXfi7vCvWwV5wQMkNSTRLoXxmMqCM6f8SigXM4aG
         ZIJQ==
X-Gm-Message-State: AOAM530jabgEoy8eHIflTTVBT24WRsPqN2r8BXtAvUVGTVyDBb1xQSpK
        zcDpABpzK7VKUeTx4pgKGYc=
X-Google-Smtp-Source: ABdhPJxD3DA6d3nPM0aMoQKdrjnBr7p9a+RYfT0msZEO4qIv24OP6aPqyshDjRat48CbBH1nxv5LkQ==
X-Received: by 2002:a17:906:7e52:b0:6b6:bc81:eae9 with SMTP id z18-20020a1709067e5200b006b6bc81eae9mr5119912ejr.273.1645774280890;
        Thu, 24 Feb 2022 23:31:20 -0800 (PST)
Received: from [192.168.0.128] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id bx1-20020a0564020b4100b00410f01a91f0sm934477edb.73.2022.02.24.23.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 23:31:19 -0800 (PST)
Message-ID: <b527a418-b807-7afa-9ed0-2ac4271ff79e@kernel.org>
Date:   Fri, 25 Feb 2022 08:31:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: Add sample averaging property
 for ADM1275
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Potin Lai <potin.lai@quantatw.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220224154329.9755-1-potin.lai@quantatw.com>
 <20220224154329.9755-3-potin.lai@quantatw.com>
 <c6607953-927e-4d85-21cb-72e01a121453@kernel.org>
In-Reply-To: <c6607953-927e-4d85-21cb-72e01a121453@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 08:06, Krzysztof Kozlowski wrote:
> On 24/02/2022 16:43, Potin Lai wrote:
>> Add new properties for binding sample averaging in PMON_CONFIG register
>>
>> - adi,volt-curr-sample-average
>> - adi,power-sample-average
>>
>> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>> ---
>>  .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> index 223393d7cafd..325f6827648f 100644
>> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> @@ -37,6 +37,48 @@ properties:
>>      description:
>>        Shunt resistor value in micro-Ohm.
>>  
>> +  adi,volt-curr-sample-average:
>> +    description: |
>> +      A value to configure VI_AVG in PMON_CONFIG register to indicate a
>> +      number of samples to be used to report voltage and currentvalues.
> 
> missing space after current.
> 
>> +      If set to 7, the 128 samples averaging would be used.
>> +
>> +    $ref: /schemas/types.yaml#/definitions/uint8
> 
> Make it a uint32.
> 
> The previous usage of this field was more appropriate. Instead of
> keeping register values in DT, it's better to keep logical value. What
> if in next cheap the register values have calculation method?
> 
> This should be like in v1 - enum for number of samples to take in averaging.
> 

One more thought: this field could also stay in current approach if you
change the meaning from "value to configure VI_AVG" to something like
"the exponent used to determine the number of samples, where the base is 2".

This approach would allow you to skip the "ilog" in the code. It sill
won't be that easily scalable if another chip comes with different
formula, but I think that's unlikely.

Best regards,
Krzysztof
