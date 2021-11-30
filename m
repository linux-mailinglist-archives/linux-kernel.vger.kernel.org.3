Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6E46337F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhK3L54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhK3L5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:57:46 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93CC061756
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:54:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y196so17203233wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s/MCC1O3IE0ZQH2CohqUhzPHI1Euqff0ThFYq8pwzS4=;
        b=BjqK1ZKqktax3hF6VltM9cidNs9XqcShJKucxE2q6M7Zl7KwTvM22Fspla59TycN+p
         B8M4bTlCs2dEytRrSJqxbKoF4cAobCa2PB0klheKQpkf0hdUbJuzKMLfn+q8Jkfo7erR
         oC3ZzlzV2Apm0jZuknuyhBqH/4VMPtcUdQewru+Y+VYqKK1nGqA076Vo9nXljLJWXYLX
         pLPFhHZD0VO2JSKEZyI1m3zSCTjmuFvPrLLLpwnArpwdORzaF+2Fog9vsS2g2R0uEnRd
         vTAu11oTyK+SVY4HbFImPbSiwi3XSQz87dKf0i49tTBA7PKs5aZwEi1EyEny286WfAcU
         ooPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/MCC1O3IE0ZQH2CohqUhzPHI1Euqff0ThFYq8pwzS4=;
        b=zja3o13ApLSFfSTTL7PBhoTYB5OQF0A8mYlyaFAEMfqR28joqg5XiuUxOjuXkEA677
         JjUYVosyJNdppPvFQBqw/C5WQErfKuwZSPMErkYVHzQemW8w9oYe0CilC/9Y+MewVCsM
         NBP+m3J7YEVQw6E1C+DlAJt2Niu2RhkecMEEVEE9wKd4tpdvWea/JkaXnCW2z2Km8Vyd
         o5wnwzABUslGn6p1zRVIttJxSlg2pYNbFnYb2PWr6Td8WvFfXIzZWZ5IMNpzgD8IDFlz
         txadxikRhxNDh1g3xbga06hdT+mNcvrRHlZfYs4n37qKMsAmypSe9yTwVtpK6iW4SCZZ
         FS4Q==
X-Gm-Message-State: AOAM530OLq3KcrlCMDE6uEVfpsjTB640jPyq9/zmAnaVGLXrC51m9SvG
        FEA9fUbYzxX9+NLptAoUAC8kHA==
X-Google-Smtp-Source: ABdhPJwF8317Xox73+G2snJoD+SBuc5iH5MnErcxK+DWaH5CAMClLp3wFLMY5PFDp0AqivJXsiPBcA==
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr4438317wml.0.1638273265220;
        Tue, 30 Nov 2021 03:54:25 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id q4sm15851381wrs.56.2021.11.30.03.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 03:54:24 -0800 (PST)
Subject: Re: [RFC PATCH] dt-bindings: nvmem: add transformation support
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
References: <20211123134425.3875656-1-michael@walle.cc>
 <7807ac74-5b5c-f0a0-804a-497b67d2c985@linaro.org>
 <31ee8f287bb410fabae11f31c42d5c86@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c36aaeb5-117a-b0df-2b2d-c86bc29fe881@linaro.org>
Date:   Tue, 30 Nov 2021 11:54:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <31ee8f287bb410fabae11f31c42d5c86@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/11/2021 17:43, Michael Walle wrote:
> Hi Srinivas,
> 
> Am 2021-11-29 13:54, schrieb Srinivas Kandagatla:
>> On 23/11/2021 13:44, Michael Walle wrote:
>>> This is my second attempt to solve the use case where there is only the
>>> base MAC address stored in an EEPROM or similar storage provider. This
>>> is the case for the Kontron sl28 board and multiple openwrt supported
>>> boards.
>>>
>>> The first proposal [1] didn't find much appreciation and there wasn't
>>> any reply to my question or new proposal [2]. So here we are with my new
>>> proposal, that is more flexible and doesn't fix the ethernet mac only.
>>> This is just an RFC for the device tree representation for now to see if
>>> this is the correct way to tackle this.
>>>
>>> I'm also aware of the latest post process hook support [3]. This doesn't
>>> fix the base mac address issue, but I think it also doesn't solve the
>>> case with swapped ethernet addresses in the general case. That hook will
>>> involve the driver to do the swapping, but how would the driver know
>>> if that swapping is actually required. Usually the interpretation of the
>>> content is opaque to the driver, after all it is the user/board
>>
>> But this is the path for any post processing hook, which ever
>> direction we endup with(using core helpers or provider specific
>> post-processing).
> 
> Mh? I don't understand. My point was that the driver is unlikely
> to know what it should process. Take the mtd (or the mtd otp)

What if the drivers know what it should do for post processing?

TBH, all the post processing is provider centric, Its hard to really 
standardize this for every possible encoding that vendor programs into 
there nvmem. There is no standardization here that can go in to nvmem core.

My approach for this would be to use the same callback hook. Either set 
this at provider driver level or at core level.

> nvmem provider for example. If I understand it correctly, it just
> gets the nvmem name, for example, "mac-address". How should
> the post process hook know, what it should do? IMHO that just
> works for very specific drivers, which tied to the content
> they provide.
Currently the callback hook is just dealing with names but it can be 
extended to support other arguments.


> 
>>> manufacturer who does program the storage device. We might be lucky in
>>> the imx-ocotp case because the IMX reference manual actually states
>>> where and in which format the mac address is programmed.
>>>
>>> Introduce a transformation property. This is intended to be just an
>>> enumeration of operations. If there will be a new operation, support for
>>> it has to be added to the nvmem core.
>>>
>>> A transformation might have multiple output values, like in the base mac
>>> address case. It reads the mac address from the nvmem storage and
>>> generates multiple individual addresses, i.e. on our board we reserve 8
>>> consecutive addresses. These addresses then can be assigned to different
>>> network interfaces. To make it possible to reference different values we
>>> need to introduce an argument to the phandle. This additional argument
>>> is then an index into a list of values.
>>>
>>> Example:
>>>    mac_addresses: base-mac-address@10 {
>>>      #nvmem-cell-cells = <1>;
>>>      reg = <10 6>;
>>>      transformation = <NVMEM_T_ETH_OFFSET 0 1 7>;
>>
>> IMO, this is totally redundant. we could probably encode this info
>> directly in the cell specifiers, something like:
>>
>>>    }
>>>
>>>    &eth0 {
>>>      nvmem-cells = <&mac_addresses 0>;
>>
>> nvmem-cells = <&base_mac_addresses NVMEM_T_ETH_OFFSET 0>;
> 
> I had he same idea, but keep in mind, that there could be more
> than just one nvmem cells:
> 
> nvmem-cells = <&phandle1 arg1 &pandle2 arg2 arg3>;
> nvmem-cell-names = "name1", "name2";
> 
AFAIU, This should just work.

> So you'd need the #nvmem-cell-cells either way.
> 
>> And value of #nvmem-cell-cells is dependent on the first cell specifier.
That does not sound correct. You can see lots of example in dt that have 
phandles with different number of arguments.

AFAIU, both phandle1 and phandle2 will have different #nvmem-cell-cells 
values specified in there dt nodes.

--srini

> 
> What do you mean with first cell specifier? the phandle (base_mac_address
> in the example) or the NVMEM_T_ETH_OFFSET? I guess the latter, because the
> arguments depend on the transformation. But this is not how the
> of_parse_phandle_with_args() works, it will look the '#nvmem-cell-cells'
> property up, to see how many arguments it should expect, which is ann
> property to the referenced node. Thus I've come up with the additional
> indirection. The number of arguments for the reference cell is either
> 0 or 1 and the transformation is part of the nvmem cell.
> 
>> I understand that these 3 bits of info is required for this type of
>> post processing and this can only come from DT and its not possible to
>> determine this at runtime.
> 
> ok :)
> 
>> Would this address other usecases?
> 
> I think so, but see above for why it can't work. Or I am missing
> something.
> 
>> Are you in a position to test few of them?
> 
> Sure (at least after my vacation). And TBH I think the imxotp mac
> swap should use the same or it will be likely that there are future
> SoCs which will always swap the ethnet
> 
>> Lets wait for Rob's opinion on adding #nvmem-cell-cells property with
>> cell specifiers describing the encoding information?
> 
> +1
> 
> Thanks for looking into this,
> -michael
