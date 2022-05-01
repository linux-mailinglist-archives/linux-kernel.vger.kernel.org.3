Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA927516527
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348993AbiEAQU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348942AbiEAQUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:20:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC431A837
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 09:17:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k23so23933214ejd.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x5ohyCygEHddhh2Mt5evi/snR/P1ql5wrtaula7bajY=;
        b=mLJgk+VCGKhaJ/vJniRuSmtaGWsZLod8QFNDKz4LeIbaZePqtsu/Q+0Wv5qc0wvd+V
         3TpORtiJdVx/D5P6u2kgc0nzUNCiGNb8k7XHyjNSjMcBggQKVza0v/iFCrsuSxXuPhEx
         xpDRii2tg6xfNAUPKCAv86KQtDHSxnKNvZRik6q4XH2F/GqmkIBIjacBfPljmoGU/v6R
         LQsR8Ql3WnVNpL5tcfvCe1PYOeeX3HFYQuX4fhdhY51SyX9nWQcXuEyUKFd2THxgO2hy
         icOc5MC+OMYf9ryPQV0V20mIICXv9e1DoJtl0ym79E9kOw3Ysl6JU85N47XUx94qHRSo
         DvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x5ohyCygEHddhh2Mt5evi/snR/P1ql5wrtaula7bajY=;
        b=1RUuNl/ac6HLzwnxoyH+9cV3Cb3J9qtMolYN2GnPxC15NoGrgazb44qGu3DFLR6prW
         7mSOnCEWAJ6vbLEfnHPF4daRpErX+1/LkpgKUsBLJq0kwzPYvUmZKVovKxWmGe7iP8Kg
         rg9TYOGbJ30ueCZ+qirHt0XXxbO1QpYvXlJp6imtTk2RdY6mxRhH1McAinp1MXxyJZOK
         3sYyq5wxl2MCxJKZ/ppWprxNxPwTmq/lddn1zWlodvqHX9FjUOMZlRHbrhsWGVytzKDf
         XFbfXfbWsgBeLh/a633OtwVWkEo9I8hRsbxVvUcHLiv4d+1AMA6KyMN1NlpxZpxxs7gc
         iIdA==
X-Gm-Message-State: AOAM533gj/kICaMtX9FNxcgB7CnPDFYqlM5yLqhrR6Z1HHqZ3EkPhopQ
        iJIZqE507KdQPMh7cPq7Je5t+Q==
X-Google-Smtp-Source: ABdhPJyPNsLWguq1ZcYy8FBqygSRQv0qbEI3lwLesqKVjA3jDL6zXrdUI3kmcc08tDjI5hGx0A0D1A==
X-Received: by 2002:a17:906:6a15:b0:6f4:4de5:de39 with SMTP id qw21-20020a1709066a1500b006f44de5de39mr1440718ejc.317.1651421846684;
        Sun, 01 May 2022 09:17:26 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jz26-20020a17090775fa00b006f3ef214e49sm2716602ejc.175.2022.05.01.09.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 09:17:26 -0700 (PDT)
Message-ID: <11fbbafd-e7ce-f921-2073-146e96f01f6b@linaro.org>
Date:   Sun, 1 May 2022 18:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for
 Sercomm parser
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <909094fd-ded0-38f9-b374-dd5f7b63e298@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 16:51, Mikhail Zhilkin wrote:
> On 5/1/2022 11:17 AM, Krzysztof Kozlowski wrote:
> 
>> On 30/04/2022 20:54, Mikhail Zhilkin wrote:
>>>  patternProperties:
>>>    "@[0-9a-f]+$":
>>> -    $ref: "partition.yaml#"
>>> +    allOf:
>>> +      - $ref: "partition.yaml#"
>>> +      - if:
>>> +          properties:
>>> +            compatible:
>>> +              contains:
>>> +                const: sercomm,sc-partitions
>>> +        then:
>>> +          properties:
>>> +            sercomm,scpart-id:
>>> +              description: Partition id in Sercomm partition map. Parser
>>> +                uses this id to get partition offset and size values from
>>> +                dynamic partition map.
>> Partition offset and size values are not derived from scpart-id. I am
>> sorry but after all these questions - it's the third time now - you
>> never answer why do you need this property and what is it used for. From
>> all the examples it could be simply removed and the partition map will
>> be exactly the same.
> scpart-id is necessary to get (using mtd parser) partition offset and
> size from dynamic partition map (NOT from the reg property):
> 
> ❯ xxd -e -c 12 -s $((0x800)) -l $((0x78)) mtd1
> 00000800: 00000000 00000000 00100000  ............
> 0000080c: 00000001 00100000 00100000  ............
> 00000818: 00000002 00200000 00100000  ...... .....
> 00000824: 00000003 00300000 00100000  ......0.....
> 00000830: 00000004 00400000 00600000  ......@...`.
> 0000083c: 00000005 00a00000 00600000  ..........`.
> 00000848: 00000006 01000000 02000000  ............
> 00000854: 00000007 03000000 02000000  ............
> 00000860: 00000008 05000000 01400000  ..........@.
> 0000086c: 00000009 06400000 01b80000  ......@.....
>           scpart-id  offset      size
> 
> With sercomm,sc-partitions the reg property will be ignored (offset =
> 0x200000, size = 0x100000) and the values will be taken from partition map.
> 
> For example we have this is dts:
> 
> partition@200000 {
>             label = "Factory";
>             reg = <0x200000 0x100000>;
>             sercomm,scpart-id = <2>;
>             read-only;
>         };
> 
> Dynamic partition map:
> 
> scpart-id = 2; offset = 0x00200000; size = 0x00100000
> 
> 00000002 00200000 00100000  ...... .....
> 
> In this example the offset and size are the same in reg and dynamic
> partition map. If device have bad blocks on NAND the values will be a
> little different. And we have to take partition offsets from partition
> map to avoid boot loops, wrong eeprom location and other bad things.
> 
> Is there anything that needs to be explained in more detail?

Thanks a lot, this clarifies the topic. Looks good. Maybe you could put
parts of this into the scpart-id field description?

Best regards,
Krzysztof
