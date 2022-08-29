Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A55A53C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiH2SIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiH2SIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:08:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D83F8A6D3;
        Mon, 29 Aug 2022 11:08:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 76so8975565pfy.3;
        Mon, 29 Aug 2022 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=oeLZkJo7r0Pmf6SXLt1P90pmtp2k2ZydEitpNUpbvO0=;
        b=jPjzwZsCGZGhTkiGm1iWMxZR5WZtevO4uTVZEzwzGZD6QXFD4q7epA7kULhXYSZGPm
         KrfxX6AOJrk+DllaePDOW482IEuvBWAInCvfjbvtd762IahigGBOtiRP/1ygOVm5drM0
         LJWHF4I4HwGaM4xTVD6FndSr9yrNedUBUyWygHS9Q+spB4+jcqaBah4GWv0Dz2pY//73
         gMW60FEocbZjLukQfCJ0FWGc/CypGfyECLubw3L1NM2JpFJ0Zy3z1lm4Xi6PluDLP5Hn
         A1LugeO6ZD79Yt18aaN1EigThReXrKiImm69D7jN5MDIbj+Ofn9g9AuJGvcfNIXqoMcN
         4V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=oeLZkJo7r0Pmf6SXLt1P90pmtp2k2ZydEitpNUpbvO0=;
        b=N0F5E2+034vZDlUU/jHA9DsHKatxreVBoQPjzBcEW1T2b9hW3P9NbWXf2jVEoj0BLb
         /dge5GmrevSkIeVg9p7l2utME7gRxIRFrThAN9oCdhLHVjxwHhuSv+D7CHQAv5hAwDaf
         TrofobF35l7Wsm2QqM9vGHbcZXVJfktUg68bT6yp6rvAesT/FI8P5t+ElRDFFBrBS2AI
         r1Ztk5AcklHj2W+dtCI6AsQ+O/YpBY2MtG0afvyuSbjEyjv2dMeEfzBZDnGs5Hqg7Yyu
         KeRd/8nCzj2xAth3pmz1BUC6IhBuZDSrjX6oDwfwYaOeXYWxqqcCqpzWmFLzz2+BprEC
         AfDA==
X-Gm-Message-State: ACgBeo11ZeaolrJR1kaV3Enf39kZ3LxXdLW37Hr+9lDkD8m1gUhOh5WZ
        TxdW52aBw6vYBKcqdqoLL98=
X-Google-Smtp-Source: AA6agR6BnIpTZZNNYzRynPOKecsOXwSiHdjwSBKJbLgBEkgmTSTMdP3feo2XzQfvSt9aJsE0/TtJQg==
X-Received: by 2002:a63:191c:0:b0:427:567b:8442 with SMTP id z28-20020a63191c000000b00427567b8442mr14940799pgl.433.1661796526832;
        Mon, 29 Aug 2022 11:08:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r2-20020aa79882000000b0053826ec2a68sm3249956pfl.191.2022.08.29.11.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 11:08:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <19161199-3ab8-7ba6-0658-271f6f1e4ba4@roeck-us.net>
Date:   Mon, 29 Aug 2022 11:08:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hwmon: (max31790) add fanN_enable
Content-Language: en-US
To:     Justin Ledford <justinledford@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220829024351.2415147-1-justinledford@google.com>
 <20220829132017.GA3039965@roeck-us.net>
 <CAHCvCEcGvrS=3p2Whj0Cmx9sx+aSzX2097LahQ=f3eRCCAN_bA@mail.gmail.com>
 <20220829161135.GB1320973@roeck-us.net>
 <CAHCvCEc27ozgr6pthRZ84FzJnhM+X705RJpW4z4SB-P9dV_aSg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHCvCEc27ozgr6pthRZ84FzJnhM+X705RJpW4z4SB-P9dV_aSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/29/22 10:15, Justin Ledford wrote:
> On Mon, Aug 29, 2022 at 9:11 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Mon, Aug 29, 2022 at 08:09:21AM -0700, Justin Ledford wrote:
>>> The tach input isn't enabled in the device by default. So the only way
>>> to start using the fan input sensors is to set the regulator mode
>>> through the driver to RPM mode and then back to whatever mode you
>>> actually want to use. The I2C interface to the device doesn't couple
>>> the tach input to the regulator mode so I don't think it makes sense
>>> for the driver to do this either.
>>>
>> Please don't top-post.
>>
>> The above does not answer my question why fan_config[] wound need to
>> be updated repeatedly.
>>
>> Guenter
>>
>>> On Mon, Aug 29, 2022 at 6:20 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On Mon, Aug 29, 2022 at 02:43:51AM +0000, Justin Ledford wrote:
>>>>> The MAX31790 has a tach input enable bit in each fan's configuration
>>>>> register. This is only enabled by the driver if RPM mode is selected,
>>>>> but the driver doesn't provide a way to independently enable tachometer
>>>>> input regardless of the regulator mode.
>>>>>
>>>>> By adding the fanN_enable sysfs files, we can decouple the tach input
>>>>> from the regulator mode. Also update the documentation.
>>>>>
>>>>> Signed-off-by: Justin Ledford <justinledford@google.com>
>>>>> ---
>>>>>   Documentation/hwmon/max31790.rst |  1 +
>>>>>   drivers/hwmon/max31790.c         | 44 +++++++++++++++++++++++++++-----
>>>>>   2 files changed, 38 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
>>>>> index 7b097c3b9b90..33c5c7330efc 100644
>>>>> --- a/Documentation/hwmon/max31790.rst
>>>>> +++ b/Documentation/hwmon/max31790.rst
>>>>> @@ -38,6 +38,7 @@ Sysfs entries
>>>>>   fan[1-12]_input    RO  fan tachometer speed in RPM
>>>>>   fan[1-12]_fault    RO  fan experienced fault
>>>>>   fan[1-6]_target    RW  desired fan speed in RPM
>>>>> +fan[1-6]_enable    RW  enable or disable the tachometer input
>>>>>   pwm[1-6]_enable    RW  regulator mode, 0=disabled (duty cycle=0%), 1=manual mode, 2=rpm mode
>>>>>   pwm[1-6]           RW  read: current pwm duty cycle,
>>>>>                          write: target pwm duty cycle (0-255)
>>>>> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
>>>>> index 7e9362f6dc29..3ae02be4b41e 100644
>>>>> --- a/drivers/hwmon/max31790.c
>>>>> +++ b/drivers/hwmon/max31790.c
>>>>> @@ -118,6 +118,12 @@ static struct max31790_data *max31790_update_device(struct device *dev)
>>>>>                                        goto abort;
>>>>>                                data->target_count[i] = rv;
>>>>>                        }
>>>>> +
>>>>> +                     rv = i2c_smbus_read_byte_data(client,
>>>>> +                                     MAX31790_REG_FAN_CONFIG(i));
>>>>> +                     if (rv < 0)
>>>>> +                             goto abort;
>>>>> +                     data->fan_config[i] = rv;
>>>>
>>>> Why is this needed ?
>>>>
>>>> Guenter
>>>>
> 
> This is needed in case the fan_config is changed outside the driver
> with something like i2ctransfer, so that the driver reports the actual
> state of the device, rather than the state at the time of the last
> write originating from the driver.
> 

That is not a concern or valid argument. With such an argument,
not a single I2C (or, for that matter, any other) register would
be cacheable, and much of the caching code in the kernel would
not work. Anyone hacking around any driver in the system would
be on their own. One could even argue that such hacking should
be undone if possible because it may have severe and unexpected
impact on any driver operation.

Guenter

>>>>>                }
>>>>>
>>>>>                data->last_updated = jiffies;
>>>>> @@ -202,6 +208,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
>>>>>                }
>>>>>                mutex_unlock(&data->update_lock);
>>>>>                return 0;
>>>>> +     case hwmon_fan_enable:
>>>>> +             *val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
>>>>> +             return 0;
>>>>>        default:
>>>>>                return -EOPNOTSUPP;
>>>>>        }
>>>>> @@ -214,7 +223,7 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
>>>>>        struct i2c_client *client = data->client;
>>>>>        int target_count;
>>>>>        int err = 0;
>>>>> -     u8 bits;
>>>>> +     u8 bits, fan_config;
>>>>>        int sr;
>>>>>
>>>>>        mutex_lock(&data->update_lock);
>>>>> @@ -243,6 +252,23 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
>>>>>                                        MAX31790_REG_TARGET_COUNT(channel),
>>>>>                                        data->target_count[channel]);
>>>>>                break;
>>>>> +     case hwmon_fan_enable:
>>>>> +             fan_config = data->fan_config[channel];
>>>>> +             if (val == 0) {
>>>>> +                     fan_config &= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
>>>>> +             } else if (val == 1) {
>>>>> +                     fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN;
>>>>> +             } else {
>>>>> +                     err = -EINVAL;
>>>>> +                     break;
>>>>> +             }
>>>>> +             if (fan_config != data->fan_config[channel]) {
>>>>> +                     err = i2c_smbus_write_byte_data(client, MAX31790_REG_FAN_CONFIG(channel),
>>>>> +                                                     fan_config);
>>>>> +                     if (!err)
>>>>> +                             data->fan_config[channel] = fan_config;
>>>>> +             }
>>>>> +             break;
>>>>>        default:
>>>>>                err = -EOPNOTSUPP;
>>>>>                break;
>>>>> @@ -270,6 +296,10 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
>>>>>                    !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
>>>>>                        return 0644;
>>>>>                return 0;
>>>>> +     case hwmon_fan_enable:
>>>>> +             if (channel < NR_CHANNEL)
>>>>> +                     return 0644;
>>>>> +             return 0;
>>>>>        default:
>>>>>                return 0;
>>>>>        }
>>>>> @@ -423,12 +453,12 @@ static umode_t max31790_is_visible(const void *data,
>>>>>
>>>>>   static const struct hwmon_channel_info *max31790_info[] = {
>>>>>        HWMON_CHANNEL_INFO(fan,
>>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
>>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
>>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
>>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
>>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
>>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
>>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
>>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
>>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
>>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
>>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
>>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
>>>>>                           HWMON_F_INPUT | HWMON_F_FAULT,
>>>>>                           HWMON_F_INPUT | HWMON_F_FAULT,
>>>>>                           HWMON_F_INPUT | HWMON_F_FAULT,
>>>>> --
>>>>> 2.37.2.672.g94769d06f0-goog
>>>>>

