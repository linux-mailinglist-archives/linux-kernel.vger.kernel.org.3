Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EAD58C33E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiHHGYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiHHGYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:24:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C844E38A0
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:24:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t1so11222379lft.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OAoNmHHUa0PKL5V24wDfmfVNG28E4Bq7r3iUtf/CBrE=;
        b=VUrKVyV6003OFc0VJimc1BldUZ2d4k1+MWNVvrkr3BAa24PPuyQW1vNr/T2BhKciNq
         ayfqaqYmF8wGRn38/2txCmCTtUVVy8/tj07Y2MP1EkhF6SIsF2dKTPzX+iKvZowvxk14
         t5V5waxUfUcqedy/HueYc4w/iWqaLReTJEXd9RGGyEzLO+WYzu0U2eVdvzH8eb9a6PWI
         5EtKCp52osl1xFznd4ceIlPCa3pOhuaQ/7VwOnGNUTLG7d9Bt5jphH7RVj+jhtffNC6T
         732/Oq/msT/6KJIx1CYPxckyIPCN6fQxJPEhzQobNOmUKNF2HMpDE8u4nwPffgjF5bgI
         Rh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OAoNmHHUa0PKL5V24wDfmfVNG28E4Bq7r3iUtf/CBrE=;
        b=8IF//KEZXOpcJ9YCTF0k7vX1N0SkoHkqyFr/K3Lf74UEDcz2luJQl5bZgNTaXN7/WZ
         ZguqZ7LHc7UkZrbINkoRHOv2bB8xmUa3RKx5xJ3ejucrVN8gc4jVvWyVZP8tixTkGq26
         SgQUx7HoDMSjnAifuulo59gbD0duPT730hAFnS9NEyfpqpzc2E3UcH7ZEdONslFeA1pi
         M8ELw/L6OQjlpYvaQ/O7yUmw+UUqk4iSdteBQv2k84opcsRXhtbIDIvnxAvxbg6tnQZI
         V2BI+PQe8e61ID4tRlIGtOKvcJdIDnep7v6WW5fzz3GpSY/l+IZSI/Tka6xurUrh2eui
         4Gyw==
X-Gm-Message-State: ACgBeo2hK4KTEfPrDwfCvGMAaRf/3NnIOH7U/oyQmw6FfBJIJ7ixklbk
        4us8SqrbasV0kmxriAkIFOYH+Q==
X-Google-Smtp-Source: AA6agR6prZiP/qNX9oqYZNmqTNXmZeF6UVrUNvdf4EHwTJX2GFqoBKKBsc4oes1ezKPjna+niysCZg==
X-Received: by 2002:a05:6512:32c5:b0:48b:969a:9c24 with SMTP id f5-20020a05651232c500b0048b969a9c24mr3322429lfg.300.1659939860138;
        Sun, 07 Aug 2022 23:24:20 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id k21-20020ac24f15000000b0048ae66976ffsm1311807lfr.47.2022.08.07.23.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:24:19 -0700 (PDT)
Message-ID: <7d7ee605-9e5d-aa98-23a9-82e0f41ef326@linaro.org>
Date:   Mon, 8 Aug 2022 09:24:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, minyard@acm.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220804181800.235368-1-tmaimon77@gmail.com>
 <20220805115827.GG3834@minyard.net>
 <CAP6Zq1gfvEpUF-TKhA8EdJqBtwaVvJR3qxtn=8Li4swHB6sDYQ@mail.gmail.com>
 <20220807121138.GL3834@minyard.net>
 <CAP6Zq1iL7okjGU8_-CnrBnRUzjLKPD8FNw_oYso-jbthbeR1iQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1iL7okjGU8_-CnrBnRUzjLKPD8FNw_oYso-jbthbeR1iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2022 16:54, Tomer Maimon wrote:
> On Sun, 7 Aug 2022 at 15:11, Corey Minyard <minyard@acm.org> wrote:
>>
>> On Sun, Aug 07, 2022 at 11:03:56AM +0300, Tomer Maimon wrote:
>>> Hi Corey,
>>>
>>> Thanks for your comment.
>>>
>>> On Fri, 5 Aug 2022 at 14:58, Corey Minyard <minyard@acm.org> wrote:
>>>>
>>>> On Thu, Aug 04, 2022 at 09:18:00PM +0300, Tomer Maimon wrote:
>>>>> Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
>>>>> string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
>>>>>
>>>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
>>>>> index cbc10a68ddef..4fda76e63396 100644
>>>>> --- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
>>>>> +++ b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
>>>>> @@ -7,7 +7,7 @@ used to perform in-band IPMI communication with their host.
>>>>>  Required properties:
>>>>>  - compatible : should be one of
>>>>>      "nuvoton,npcm750-kcs-bmc"
>>>>> -    "nuvoton,npcm845-kcs-bmc"
>>>>> +    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"
>>>>
>>>> This is just wrong.  The compatible is supposed to identify the device,
>>>> not the board the device is on.  I think compatible here should be
>>>> "npcm7xx-kcs-bmc", and just use that everywhere.  It's fine if that is
>>>> used on a board named npcm845.
>>> The NPCM8XX is not a board, The Nuvoton NPCM8XX is a fourth-generation
>>> BMC SoC device family.
>>
>> Ok, but same principle applies.
>>
>> If the device is exactly the same, then you would only use one of the
>> "npcm7xx-kcs-bmc" and put that in both device trees.  You can use
>> "nuvoton,npcm750-kcs-bmc", it's really not that important.  Or even
>> "nuvoton,npcm-kcs-bmc"
> If we use "nuvoton, npcm-kcs-bmc" we should take care of backward dts
> compatibility, and I am not sure we like to change NPCM KCS driver.
>>
>> If the device has a minor difference that can be expressed in a
>> parameter, then create a parameter for it.
>>
>> If the device has enough differences that a parameter or two doesn't
>> cover it, then you put either nuvoton,npcm750-kcs-bmc or
>> nuvoton,npcm750-kcs-bmc in the device tree.  Not both.  Then you need
>> two entries in the of_device_id array and you use the data field or
>> something to express the difference.
>>
>> Since there appears to be no difference, just put
>> "nuvoton,npcm750-kcs-bmc" in the npcm845 and I will drop the patch
>> adding all this.  Then a patch can be added saying it applies to both
>> the 7xx and 8xx series of BMC SOCs.  If you want to change the name,
>> then a patch will be needed for that, but then you will need multiple
>> entries in your device tree, but you would not document it as such, as
>> there would only be one that applies for this kernel.
> 
> It little bit confusing to use nuvoton,npcm750-kcs-bmc that are
> related to NPCM7XX for NPCM8XX KCS.
> We can use the generic name "nuvoton, npcm-kcs-bmc" as you suggested

No, please don't. It will be NAKed. :)

> above but we should take care of backward dts compatibility, and I am
> not sure we like to change NPCM KCS driver.
> 
> We had a disscation with Arnd, Arnd asked us to use a fallback as we
> did here if NPCM8XX device module is similar to NPCM7XX module:
> https://lore.kernel.org/lkml/20220522155046.260146-5-tmaimon77@gmail.com/
> 
> I think we should use a fallback to describe the NPCM8XX KCS in the
> dt-binding document.


Best regards,
Krzysztof
