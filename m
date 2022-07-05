Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4618C566F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiGENeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiGENdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:33:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B428E17
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:55:14 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a11so14391965ljb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W1cGgApTbKJWLFEV91Nplq6woKey3TRAhy9Am/ClrW4=;
        b=jPvGH+kdVD6Q/3Ol/HMko/03+o/UKAOFK9C23heMweX++XoZmFROm6jci5QHMpRE36
         3gQCaz4SlBirqZ6zRyTqI2Ku8znOuUSx1PnPCp2G5bWDmfkCqsxlGygbzN3Xq7K5J1Vg
         w9eJXusFlTjMLMY2dm583K8lvPRCi7gYRBEUeO6Xr/yTzIO34rcHN1aiUZPdLRFoNG+E
         y0/0GOPVZYpKbfasLgHjgH0SHnSU+rb3063siGQpK9t6INtYCZMf9mkg6cY3XiqfYd9P
         DWUqqg788SqI7Kom7m2XG+hnzonknCsaE/xNYG68tnVCTksRsx+VvdDAHp1lC6V1vocD
         6Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W1cGgApTbKJWLFEV91Nplq6woKey3TRAhy9Am/ClrW4=;
        b=OOc4QdXvW6MqEarTlDq7IHgkKKMDqMwLaZ4EDmX9l8yckh+UGOGzqOLszn0dd82HVz
         i0DIRQrItEp4gtPkwebr27B13DF2cobwQJ7w5fSEFzeWVN6WpoeS0wmI2/xNLToi3nwt
         BShwLwYd83ZkhVlRbXKs91nzMPQefsxRszCp2GkKj/SCc/Ay7nD2PO0/pDe/xabiof2+
         rmx1wHCIfai148E4rSvl/h65ndKQMCmN04OT4eOXCtTFAMNpUMPEbGcttpXORo39PCDi
         EoM6tdJo4kFPIhqFNMAZjuXer/Jvx/JYaQmugyZ+JE+X+rkdaa+/sPan3+fOe3iSaJ7n
         BKmw==
X-Gm-Message-State: AJIora8fns0sbyTDvWgsfwwZ2KWatJY8IJ+AP0AZaKHhEqYyGfRBFCwN
        vtaF9eULQi11VdoeHh9ss93wdEVnoIzsFg==
X-Google-Smtp-Source: AGRyM1s3xnM62iOhzwwEsUJLvlYd4iPyPQs8nvpycCl9q1NqfYqmBypbvl1w9wTag2K2lwq1B+TZNA==
X-Received: by 2002:a2e:a484:0:b0:25a:8c94:3763 with SMTP id h4-20020a2ea484000000b0025a8c943763mr19292175lji.64.1657025712278;
        Tue, 05 Jul 2022 05:55:12 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id l8-20020ac25548000000b0047255d21107sm5674891lfk.54.2022.07.05.05.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 05:55:11 -0700 (PDT)
Message-ID: <3358f88c-5c58-ae0d-2c26-7ba9a954b491@linaro.org>
Date:   Tue, 5 Jul 2022 14:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add cznic,turris1x-leds.yaml
 binding
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705000448.14337-1-pali@kernel.org>
 <42d837dd-fbd1-6294-2fa0-8a07ae0f8d44@linaro.org>
 <20220705114238.xwgexavgozqskwbw@pali>
 <90fd55cb-13f4-eac2-2b1a-85ae628ecc89@linaro.org>
 <20220705121541.t7jjcjp4hkqprsdo@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705121541.t7jjcjp4hkqprsdo@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 14:15, Pali Rohár wrote:
>>>> You need to describe the items, if it is really two items. However your
>>>> example has only one item, so this was not tested and won't work.
>>>
>>> Ehm? Example has two items in the reg.
>>
>> No, you have exactly one item.
>> <0x13 0x1d>
>>
>> Two items are for example:
>> <0x13 0x1d>, <0x23 0x1d>
> 
> Ok. So I should change maxItems to 1 in this case?

Yes

> 
> And how you want to describe those items?

In that case, no need to describe.

> 
>>>
>>>> You'll get warning from Rob's robot soon... but you should test the
>>>> bindings instead.
>>>
>>> I have tested bindings on the real hardware and it is working fine
>>> together with the driver from patch 2/2.
>>
>> Bindings cannot be tested on real hardware. Bindings are tested with
>> dt_binding_check, as explained in writing-schema.rst
> 
> Ou... this is something which I was not able to run, it just does not
> work, throws lot of python dependency hell errors and it spend more than
> hour with it. So sorry, I really cannot run it. Maybe it would be a wise
> to provide web service for these checks for those who cannot run them
> locally?

It's one pip command to install and one make command to run... I would
say easy to start using, unless of course you use some unusual distro
without Python 3 (cannot believe nowadays...) or without pip.

Rob's bot will test it for you.

Anyway, in such case please mark your bindings always as RFT, so we will
not waste time on reviewing obvious stuff which is found by automated
tools. I think we both agree that reviewers time should not be used for
trivial stuff already pointed out by compiler/linter/automation.

> 
>>>
>>>>> +
>>>>> +  "#address-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  "#size-cells":
>>>>> +    const: 0
>>>>> +
>>>>> +patternProperties:
>>>>> +  "^multi-led@[0-7]$":
>>>>> +    type: object
>>>>> +    $ref: leds-class-multicolor.yaml#
>>>>
>>>> This looks incorrect, unless you rebased on my patchset?
>>>
>>> So what is the correct? (I used inspiration from
>>> cznic,turris-omnia-leds.yaml file)
>>
>> Which according to current multicolor bindings is not correct. Correct
>> is pwm-multicolor. However if you rebase on [1], it looks fine, except
>> missing unevaluatedProperties.
> 
> Ok. So does it mean that I should just add
> "unevaluatedProperties: false"?

Yes, on that level of indentation, so:
    $ref: leds-class-multicolor.yaml#
    unevaluatedProperties: false


> 
>> [1]
>> https://lore.kernel.org/all/20220624112106.111351-1-krzysztof.kozlowski@linaro.org/
>>
>>>
>>>>> +
>>>>> +    properties:
>>>>> +      reg:
>>>>> +        minimum: 0
>>>>> +        maximum: 7
>>>>> +
>>>>> +    required:
>>>>> +      - reg
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +
>>>>
>>>> No blank line.
>>>
>>> Ok.
>>>
>>>>> +    #include <dt-bindings/leds/common.h>
>>>>> +
>>>>> +    cpld@3,0 {
>>>>
>>>> Generic node name.
>>>
>>> Is not cpld name generic enough?
>>
>> No, it means nothing to me. Just like "a", "ashjd" or "wrls".
> 
> If you never heard about it, I would suggest to read something about
> Programmable logic devices. It is interesting category of hardware with
> which you can play. CPLD and FPGA are very often used in lot of products
> and FPGA is very easy for playing and programming custom logic.

The are many different acronyms in the language so without context might
be tricky to connect the dots.

> 
> For example on wikipedia is list of different technologies of
> programmable logic devices:
> https://en.wikipedia.org/wiki/Programmable_logic_device
> 
> So if you want more generic name, just name it "pld"? 

That one would be fine.

> But as it is CPLD
> device I would suggest to name it really as "cpld". It does not matter
> from which manufactor you have CPLD, just like it does not matter from
> which manufactor you have NAND.

Then cpld is fine as well.

> 
> From bus point of view, cpld is like nand or nor nodes in DTS. All of
> them refers to specific memory map of chip selects on the local bus.
> 
>> "The name of a node should be somewhat generic, reflecting the function
>> of the device and not its precise programming
>>  model. If appropriate, the name should be one of the following choices:"
> 
> Hm... You forgot to send what are those "choices:"?

I didn't, I just assumed you will Google it (or use other web-search
engine of your choice) to get the spec. As this is a quote, Google
results should be very accurate. No need to duplicate entire pages of
publicly available specification.

Best regards,
Krzysztof
