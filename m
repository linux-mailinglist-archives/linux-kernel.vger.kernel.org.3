Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F9543D68
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiFHUMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiFHUMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:12:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86031F3FA5;
        Wed,  8 Jun 2022 13:11:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq6so30536811ejb.11;
        Wed, 08 Jun 2022 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uEzAC/fb8rfW8BmBwAuwdVL2b33gNwQNVs7GK9Y1keI=;
        b=ivaoghs9FNI2QJRK39FBzysHfKlDlhgCrY/JiEMDyIG1IE/K6TaNvjEt3HcQhMxp0O
         6qEC4fTwKAcQIBDIRABycrqum2jsUyQdYf40ClI8BKYoQ10uJAME9QFRRc8dA+Uk1U1P
         idg4FmhNpzCxrtn1WkmysRnSytzJO4QG1B3EgVCCnmElorqdQTszSbjWKrCmqhGyQ1RR
         BNf23DHa4SKUYqtciQZGbD+FjzmygdW/cYgC7SQzK1CfJMLu9K9Hub0zGovaveNsv9ZK
         US2LcjHRcC3vJyGvrrWquWiOCgSA4aDlF9J8hrA0IbauCDLdx5R5bbufJm5RFZo2RYYp
         z7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uEzAC/fb8rfW8BmBwAuwdVL2b33gNwQNVs7GK9Y1keI=;
        b=OY1H8aFoDa/Q9/9UkTiuJTyYby7WZguLTHcE1A6x6SoZhPLs7v8u9llbpsFrvX19yc
         9bqfI3J3Bgd7Dy0Ti4Zsgz8b3bCJ7PDTlbl9tds0j/SFEOlS5UrkZqDVBwuRqvbRGXWU
         STExb6y1jxJ/EeXVxMfB+0//1mp8Lq67pspCvxhKwXJr6R9zQURO8Gf3UtyTTu2jcmfz
         QuUUqRhZLYjVDM9i50p/t7f0wTeMAncgf1FO6ZR08nN+KX86WIzKhcOFiP1MifMcgnoS
         M9DkBgqCc8AWO5aOiZZ+n/6KMe2KTbW8CQveFZ9lF32H6MIvvCS33lbEfjamKBmpvWPI
         SqVA==
X-Gm-Message-State: AOAM5318A7RFHXTomdl0X803qwgYBD1LEsFvCjKxMmuYFrWHe8Bu1py4
        hqx05ZOeJd8emu7NcMqqqps=
X-Google-Smtp-Source: ABdhPJwD7f35LTHEtzCCd9yxzKg6HKpKHaxOALhPl5uAJ2XLGz3CN3u+cBiTUzaX+JUmbjcoIOB2NQ==
X-Received: by 2002:a17:906:4d50:b0:70d:afd4:1e63 with SMTP id b16-20020a1709064d5000b0070dafd41e63mr29043184ejv.618.1654719113970;
        Wed, 08 Jun 2022 13:11:53 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.112.100])
        by smtp.gmail.com with ESMTPSA id ec2-20020a0564020d4200b0042aaaf3f41csm12852161edb.4.2022.06.08.13.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 13:11:53 -0700 (PDT)
Message-ID: <37ac71be-78d6-a266-045b-18164d715e57@gmail.com>
Date:   Wed, 8 Jun 2022 23:11:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 2/2] iio: adc: ad4130: add AD4130 driver
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
References: <20220608091238.403897-1-cosmin.tanislav@analog.com>
 <20220608091238.403897-3-cosmin.tanislav@analog.com>
 <CAHp75Vdvng-fxt-p2bHJiF8i967eh1o_MUgDFN_odhW0sLu69A@mail.gmail.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CAHp75Vdvng-fxt-p2bHJiF8i967eh1o_MUgDFN_odhW0sLu69A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/22 18:59, Andy Shevchenko wrote:
> On Wed, Jun 8, 2022 at 12:19 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>>
>> AD4130-8 is an ultra-low power, high precision, measurement solution for
>> low bandwidth battery operated applications.
>>
>> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
>> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
>> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
>> selectable filter options, smart sequencer, sensor biasing and excitation
>> options, diagnostics, and a FIFO buffer.
> 
> I believe we may gain a few LoCs by slightly bending the rule of 80.
> Also see below.
> 

I'll only go over the 80 columns limit if Jonathan agrees to it.

>> +       *size = ad4130_reg_size[reg];
>> +       if (!*size)
>> +               return -EINVAL;
> 
> Is this check necessary?
> 

Yes. I haven't described all registers in the table, and the registers
can be accessed by the user via the debugfs_reg_access() method.

>> +static void ad4130_gpio_set(struct gpio_chip *gc, unsigned int offset,
>> +                           int value)
>> +{
>> +       struct ad4130_state *st = gpiochip_get_data(gc);
>> +       unsigned int real_offset = st->gpio_offsets[offset];
> 
> Can't you use valid_mask instead of this additional array? In such a
> case the real offset can be got by the number of the set bit, no?
> 

I'm not sure what you mean by this? If valid_mask will prevent all
GPIOs equivalent to the bits not set in the mask from being exposed,
then yes, it could be useful. I wish I knew about it earlier since
it's already the second driver in which I use this approach.

>> +       for (i = 0; i < AD4130_MAX_SETUPS; i++) {
>> +               struct ad4130_slot_info *slot_info = &st->slots_info[i];
>> +
>> +               /* Immediately accept a matching setup info. */
> 
>> +               if (!memcmp(target_setup_info, &slot_info->setup,
>> +                           sizeof(*target_setup_info))) {
> 
> Instead, you may use crc32 and save it, the matching will be much faster.
> 
> The example, where it's done for the same purposes (to compare later)
> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/scan.c#L659
> 

I think it's fine as it is. Most people won't use than many channels
anyway.

>> +                       *slot = i;
>> +                       return 0;
>> +               }
>> +
>> +               /* Ignore all setups which are used by enabled channels. */
>> +               if (slot_info->enabled_channels)
>> +                       continue;
>> +
>> +               /* Find the least used slot. */
> 
> Have you considered to use
> https://elixir.bootlin.com/linux/latest/source/include/linux/list_lru.h
> ?
> 

No. And I don't think I intend to.
>> +       const struct ad4130_filter_config *filter_config =
>> +               &ad4130_filter_configs[filter_mode];
> 
> One line? Or even a helper, since you are using this more than once.
> 

I don't think creating a helper would be helpful here. I can save like,
one character. Or you meant a helper that also declares the
filter_config variable? That would make the code even harder to read.

>> +       switch (ref_sel) {
>> +       case AD4130_REF_REFIN1:
>> +               ret = regulator_get_voltage(st->regulators[2].consumer);
>> +               break;
>> +       case AD4130_REF_REFIN2:
>> +               ret = regulator_get_voltage(st->regulators[3].consumer);
>> +               break;
>> +       case AD4130_REF_AVDD_AVSS:
>> +               ret = regulator_get_voltage(st->regulators[0].consumer);
>> +               break;
>> +       case AD4130_REF_REFOUT_AVSS:
>> +               ret = st->int_ref_uv;
>> +               break;
>> +       default:
>> +               ret = -EINVAL;
>> +               break;
>> +       }
> 
>> +       if (ret < 0)
>> +               return dev_err_probe(dev, ret, "Cannot use reference %u\n",
>> +                                    ref_sel);
> 
> Can it be moved to the caller where it would cleaner to use, I think?
> As a good side effect the all above will be shortened to just return directly.
> 

I'm pretty sure I remember Jonathan suggested moving it inside the
function.

>> +       ret = ad4130_get_ref_voltage(st, setup_info->ref_sel);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return 0;
> 
> In all cases what does the positive return value mean?
> If there is no meaning, drop all these ' < 0' parts and esp. here use simply
> 
> return ad4130_get_ref_voltage(...);
> 

ad4130_get_ref_voltage() returns the voltage of the specified reference
via its return value.

The voltage would be positive, while an error code would be negative.
Same for ad4130_find_table_index() where < 0 is also used.

>> +               for (j = 0; j < AD4130_MAX_PGA; j++) {
>> +                       unsigned int pow = resolution + j - st->bipolar;
> 
>> +                       unsigned int nv = div_u64((((u64)ret * NANO) >>
>> +                                                  pow), MILLI);
> 
> It will be much better if you make it on one line. Moreover, it seems
> it's ivariamt to the loop, why it's inside the loop?
> 

pow depends on j, nv depends on pow.

