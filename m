Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1620C4BED0C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiBUWLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:11:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiBUWLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:11:47 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9216C22BF0;
        Mon, 21 Feb 2022 14:11:21 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id f10so14456589qkg.9;
        Mon, 21 Feb 2022 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CuC7f4KIwhRURQqrkG1raV3vJWZvnVGFpmPUwwQMuuE=;
        b=EPQjAeljfZI07y1KWMA5ii6YRXBezMDpX4SEnWzSYInuqPIBI6PSuD3mEq88PACcIF
         BXnbcHmvKplH7koEBdQbpua/DvYHU3K+ylBLgw8Hdhyni9QEC1jQKkUf8S17NEd0tSpV
         EKaaOFLNJucljmw1c7lE+1ho7tBIsOy1M9+o/g0OJPNHPIRCAbLgLrwhbbahY31PdSlO
         /Kwh8R0pgEamuORLmC+fgNYuip5EAGQ7ZuQbZdu9B1u3h9KkjGSvyXq3JAE5W07GrK5A
         nqaltX6dD1VUnahlWp+CM7/hysZK5A9VP0DrHT08Um20TanzRODtDvbAnnkaIDu+Oyi4
         jbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CuC7f4KIwhRURQqrkG1raV3vJWZvnVGFpmPUwwQMuuE=;
        b=WBBhdAVHRhdJ1iIrm7coY1miuk0ctcAIrbCk1Yrcb+1elX2btCxmcKh5KrpaX2Zbud
         SiUbdvX72xdAlg9i4kY4zO+BoY7tCYVH6RRQ7sgoZKdMmnQp2B3M1xvKThVj4L0f9Wni
         tpwF9Kmwm13sE5cQyTnjeFT5O+/QKZGVNdiMcUW0wpx1FkaS6hrkuYIubXkOuD28/yVX
         piYO/ielQJ4xl2BTUyGf9F7LoR3XYkvS76bfaqe/RKqmKoBcRIm6zDH/qyhlZgd5tqt0
         6SPITQxTG56JIKwLfDNSho9OgUL/USEDDkvIT35H4NH4LvEDCwJthm88xlniP2ZxBj+Z
         a6MA==
X-Gm-Message-State: AOAM53065/enzU9VRbjxS8g2p/cCwNlGM7ElDi9lLZQVqJ2waADRwr72
        6gq6OF45gTy1NF6K+yfNQwk0fD4ziYpnaw==
X-Google-Smtp-Source: ABdhPJxpJ+l2HZnyCZFV4l5AhFdQti/g+NjkiIxQWV5JfL7+b5zo1Dwj1KsaXDmwMtkX0JIsX7QE4A==
X-Received: by 2002:ae9:dfc7:0:b0:648:e065:84be with SMTP id t190-20020ae9dfc7000000b00648e06584bemr4538507qkf.129.1645481480727;
        Mon, 21 Feb 2022 14:11:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1sm28345769qkn.71.2022.02.21.14.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 14:11:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <238e6fb0-cd77-4772-3e92-23941dc74403@roeck-us.net>
Date:   Mon, 21 Feb 2022 14:11:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: add tmp464.yaml
Content-Language: en-US
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>
Cc:     linux-hwmon@vger.kernel.org, Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220218150908.1947772-1-linux@roeck-us.net>
 <YhNWVLHYVtCvdGhi@localhost.localdomain>
 <66e6b131-274f-454b-44f6-17df879d71a9@roeck-us.net>
 <YhQDGHD3S0qwP2OB@localhost.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YhQDGHD3S0qwP2OB@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 13:24, Krzysztof Adamski wrote:
> Dnia Mon, Feb 21, 2022 at 08:16:15AM -0800, Guenter Roeck napisał(a):
>>> I still thing we should have the same format here and in tmp421, for
>>> consistency. If use the same property name, "ti,n-factor" but on tmp421
>>> you have use 32bit value while here you have to use 8bit (which is weird
>>> in DT, BTW), it might be confusing.
>>> Back when we did this for TMP421, there was some discussion and we
>>> settled on this approach, why do it differently now?
>>>
>>
>> I seem to recall from that discussion that there was supposedly no way to
>> express negative numbers in devicetree. Obviously that is incorrect.
> 
> Well, I would still argue it *is* correct. DT only support unsigned
> numbers and, really, only 32 or 64 bit. See the chapter 2.2.4 Properties
> in:
> https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4-rc1/devicetree-specification-v0.4-rc1.pdf
> 
> Devicetree also supports array of bytes, and this is how we get the
> /bits/ magic but this is just a syntactic suggar. The same is true about
> negative values. Just decompile your compiled DTB and you will see.
> To put it in other words - DTS does support negative values, DTB don't.j
> 
>> In addition to that, I strongly suspect that the tmp421 code as written
>> does not work. Its value range is specified as 0..255, but it is read with
>>     err = of_property_read_s32(child, "ti,n-factor", &val);
>> and range checked with
>>     if (val > 127 || val < -128) {
>>                dev_err(dev, "n-factor for channel %d invalid (%d)\n",
>>                       i, val);
>>                return -EINVAL;
>>        }
>>
>> That just looks wrong. Either the value range is 0..255 and checked
>> as 0 .. 255, or it is -128 .. 127 and must be both checked and specified
>> accordingly. This made me look into the code and I found how negative
>> numbers are supposed to be handled.
> 
> It worked for me when I tested that. I could redo the test, if you are
> unsure. The code also looks good to me. I wasn't convinced for this
> format in yaml but after the whole discussion we had, we settled on
> that, with Robs blessing :)
> 

It is hard for me to believe that you can enter, say, 255 into the dts file
and of_property_read_s32() reads it as -1. If so, of_property_read_s32()
could never support values of 128 and above, which seems unlikely.

Now, I can imagine that one can enter 0xffffffff and of_property_read_s32()
returns -1, but that isn't what is documented for tmp421.

Guenter

> Here's the actual discussion where all this was considered:
> https://patchwork.kernel.org/project/linux-hwmon/patch/3ff7b4cc57dab2073fa091072366c1e524631729.1632984254.git.krzysztof.adamski@nokia.com/
> 
> I'm not saying the way we do this for tmp421 is better or even right,
> all I say is that it would make sense to be consistent and not redo this
> discussion every time we have this problem.
> 
> Krzysztof

