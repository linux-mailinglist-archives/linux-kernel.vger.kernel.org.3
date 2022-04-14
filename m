Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9150179B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358944AbiDNPm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbiDNPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:12:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4395BB2458;
        Thu, 14 Apr 2022 07:53:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r13so10549201ejd.5;
        Thu, 14 Apr 2022 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/vd0ABk9Uv8CXGT1XhdmltOBRajCrHaBdNTPR8s2GVs=;
        b=M/nwcxed74Z1zu5KFnuL9OThA4kgtL9BN+Nd2OJ6JOv9UEmmNp97n2cI2JPnSThPWz
         pjLc3vWl8+7VHuhc5zC09DNeEZBsGm5SeVUJLN/KeFbC05WJrJA9HVE5chu4rU+P9NPK
         fz4Q6mO60wLys08v4twAIpoZqgKAEH4fUrsMVoOnBx3kwZgh0SAsnirvP0zV52pEdGVX
         bId/2PlR1d0ZNAtV5hrrHw7c/geSq760P7B1CpN5ffZkCX+8J2Vhs/x06E5/2M9wK1dF
         StjGH4qg2ZiKCIAEwwktQqcqu9sJi0kqFFEkq3oQOWZ3K6KF0nUhKb3UpAOQST/XZFdk
         KiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/vd0ABk9Uv8CXGT1XhdmltOBRajCrHaBdNTPR8s2GVs=;
        b=FQgSKkJfi9UuPwGZrOP0dymU6wt/Bnh64zgj1Gd6N0NrSxpdO6fb4ZV6ytQWyvTlTm
         BN28fzrwfJXvumXRtlj5DEVpurDd/zEbXUj4Vr5DDMvr6fiD4Zz7T837ZofOUvBtiDGP
         LHW1pZwe5C1Whj8Oz+6AlIgX7RD2jppsCmjiiMt2dkt5BxvsG5N7L0rZms7nAZ8OjClV
         2bg3CVaP6VSZAjfEKCWMSxpgUnsBC+n4iCRVoGZtCdaDJHsfWG73WmAel1sQDRUF9hHb
         S9kQusWEbsbWHi78Vm9HHV+7FfHkzmwvATKFmafpWkc16WDtRSZFZm7qUX+EGJdPTGOQ
         bzRQ==
X-Gm-Message-State: AOAM531NIVuckt7jQeVcVqA77LYx08n3eG00F4nnrR3Jnd7pobzDjUlA
        3NasFnW1J260FKLh603zguvHssejrJo=
X-Google-Smtp-Source: ABdhPJzgdkmpc3tsESRQhUW79TqGI55xbBqkctA/XrPrQuFxglGd93qrbFGXtzkvlk0ncMjIpSVSIw==
X-Received: by 2002:a17:907:94c1:b0:6e6:f038:9993 with SMTP id dn1-20020a17090794c100b006e6f0389993mr2685986ejc.238.1649947990464;
        Thu, 14 Apr 2022 07:53:10 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id ee17-20020a056402291100b0041fe1e4e342sm1077630edb.27.2022.04.14.07.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 07:53:10 -0700 (PDT)
Message-ID: <0823cf19-60b5-3050-0e26-04b87a7ce5c0@gmail.com>
Date:   Thu, 14 Apr 2022 17:53:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 3/3] iio: adc: ad4130: add AD4130 driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
 <20220413094011.185269-3-cosmin.tanislav@analog.com>
 <CAHp75VfzX8u45J3634yN5p-QTeT7w0Bos27OxeWOsb3MQ2VRVw@mail.gmail.com>
 <80196942-4c33-7625-3945-86ce5b7b347f@gmail.com>
 <CAHp75VfAjvJz2KHYfDM+-8D+hSBtdKJm521EBY3VgCfUsAgt8Q@mail.gmail.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CAHp75VfAjvJz2KHYfDM+-8D+hSBtdKJm521EBY3VgCfUsAgt8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/22 16:45, Andy Shevchenko wrote:
> On Thu, Apr 14, 2022 at 2:06 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>> On 4/13/22 18:41, Andy Shevchenko wrote:
>>> On Wed, Apr 13, 2022 at 1:41 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>>>> +#define AD4130_RESET_CLK_COUNT         64
>>>> +#define AD4130_RESET_BUF_SIZE          (AD4130_RESET_CLK_COUNT / 8)
>>>
>>> To be more precise shouldn't the above need to have DIV_ROUND_UP() ?
>>
>> Does it look like 64 / 8 needs any rounding?
> 
> Currently no, but if someone puts 63 there or 65, what would be the outcome?
> OTOH, you may add a static assert to guarantee that CLK_COUNT is multiple of 8.
> 

No one will. 64 is defined in the datasheet and will never change. I'm
not gonna do anything about it. Actually, I can do something about it.
Remove AD4130_RESET_CLK_COUNT and only define AD4130_RESET_BUF_SIZE as
8.

>>>> +       int                             samp_freq_avail_len;
>>>> +       int                             samp_freq_avail[3][2];
> 
>>>> +       int                             db3_freq_avail_len;
>>>> +       int                             db3_freq_avail[3][2];
>>>
>>> These 3:s can be defined?
>>>
>> I could define IIO_AVAIL_RANGE_LEN and IIO_AVAIL_SINGLE_LEN and then
>> define another IIO_AVAIL_LEN that is the max between the two.
>> But that's just over-complicating it, really.
> 
> I was talking only about 3:s (out array). IIRC I saw 3 hard coded in
> the driver, but not sure if its meaning is the same. Might be still
> good to define
Actually I just checked, and it's not even needed. The framework
always expects 3 elements for IIO_AVAIL_RANGE. I'll keep those two
3s as they are.

>>>> +       if (reg >= ARRAY_SIZE(ad4130_reg_size))
>>>> +               return -EINVAL;
>>>
>>> When this condition is true?
>>
>> When the user tries reading a register from direct_reg_access
>> that hasn't had its size defined.
> 
> But how is it possible? Is the reg parameter taken directly from the user?
> 

Users can write whatever they want to direct_reg_access. Unless I add
max_register to the regmap_config, the register that the user selects
will just be passed to our reg_read and reg_write callbacks.

Then it will be checked against the register size table.

>>>> +       regmap_update_bits(st->regmap, AD4130_REG_IO_CONTROL, mask,
>>>> +                          value ? mask : 0);
>>>
>>> One line?
>>>
>>> No error check?
>>
>> I actually can't think of a scenario where this would fail. It doesn't
>> if the chip is not even connected.
> 
> Why to check errors in many other cases then? Be consistent one way or
> the other.
> 

Yeah, right. I didn't add any error checking because the callback can't
handle errors, so all I can do is print a message to dmesg.

>>>> + out:
>>>
>>> out_unlock: ?
>>> Ditto for similar cases.
>>
>> There's a single label in the function, and there's a mutex being
>> taken, and, logically, the mutex must be released on the exit path.
>> It's clear what the label is for to me.
> 
> Wasn't clear to me until I went to the end of each of them (who
> guarantees that's the case for all of them?).
> 

Let's hope other people looking at that code will be able to figure out
what that label does then.

>>>> +               *val = st->bipolar ? -(1 << (chan->scan_type.realbits - 1)) : 0;
>>>
>>> Hmm... It seems like specific way to have a sign_extended, or actually
>>> reduced) mask.
>>> Can you rewrite it with the (potential)UB-free approach?
>>>
>>> (Note, that if realbits == 32, this will have a lot of fun in
>>> accordance with C standard.)
>>
>> Can you elaborate on this? The purpose of this statement is to shift the
>> results so that, when bipolar configuration is enabled, the raw value is
>> offset with 1 << (realbits - 1) towards negative.
>>
>> For the 24bit chips, 0x800000 becomes 0x000000.
>>
>> Maybe you misread it as left shift on a negative number? The number
>> is turned negative only after the shift...
> 
> 1 << 31 is UB in accordance with the C standard.
> 
> And the magic above seems to me the opposite to what sign_extend()
> does. Maybe even providing a general function for sign_comact() or so
> (you name it) would be also nice to have.
> 

I'm not trying to comact (I guess you meant compact) the sign of any
value. Please try to understand what is written in there. It's not
magic. If the chip is 24bit, and it's set up as bipolar, the raw value
must be offset by -0x800000, to account for 0x800000 being the
zero-scale value. For 16 bits, it's 0x8000.

>>>> +       ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
>>>> +                                AD4130_WATERMARK_MASK,
>>>> +                                FIELD_PREP(AD4130_WATERMARK_MASK,
>>>> +                                           ad4130_watermark_reg_val(eff)));
>>>
>>> Temporary variable for mask?
>>
>> You mean for value?
> 
>        mask = AD4130_WATERMARK_MASK;
> 
>        ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
>                                 mask, FIELD_PREP(mask,
> ad4130_watermark_reg_val(eff)));
> 

Please bother reading the macro definition next-time. The mask argument
to FIELD_PREP must be a compile-time constant.

>>>> +       if (ret <= 0)
>>>
>>> = 0 ?! Can you elaborate, please, this case taking into account below?
>>>
>>
>> I guess I just did it because voltage = 0 doesn't make sense and would
>> make scale be 0.0.
> 
> Again, what's the meaning of having it in the conjunction with
> dev_err_probe() call?
> 
>>>> +               return dev_err_probe(dev, ret, "Cannot use reference %u\n",
>>>> +                                    ref_sel);
> 
> It's confusing. I believe you need two different messages if you want
> to handle the 0 case.
> 

Why would I? The chip can't possibly use regulators with a voltage of 0,
right? Or dummy regulators, since these return negative. I think it's
fine as it is.
