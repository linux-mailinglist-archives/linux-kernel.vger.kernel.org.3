Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E143B57F584
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 16:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiGXOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiGXOo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 10:44:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE49CF8;
        Sun, 24 Jul 2022 07:44:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z3so8311002plb.1;
        Sun, 24 Jul 2022 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=nA72AeNwOv75MfmR/vgb+MgulgcuJ3AQihTrt7Qpx6o=;
        b=QBOZ22BeRVN8QsaOyPxfPsnz6bYxKxj+NtNKQ0CoPAZwE4zibzL68Yowk67loZ4vVt
         sPiTr5eWUexB9Z1bE+U/Rbgs6HZVdaegwXpkg163lhRsEz75//LshX68DKUWEfECcU59
         RQHb1AcX+u70gEn2qmFzo+YxA28yQpZG0JTrPYAL6yajZxrZ3Owpx5h5fziZYliRK5xc
         rd+d+HdCPJVjLM+2+oNh/ADgLdrtZSMnwl2TahbuMyZfW17xuF+Z0ia+3w2UpWA0Hl6i
         BzfQa2GE10WiJ48qLNX0N0nEQbgO6Ye4ib9iLSaAbfKkIj32EeE2dYyaU+doC5KcSZB4
         HqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=nA72AeNwOv75MfmR/vgb+MgulgcuJ3AQihTrt7Qpx6o=;
        b=D+FhXk2eL5SRhFvKy+oSKbE1/XdTk8AXPG54LNjDrBCKoCsddfmSF81EgQ9LJr6O9L
         kKUCkfj6DNIC66320tyAAhlFt7bPr4zURrXzcge7u82vJbCjNUjhwImKwm6PVF9X3h2u
         oqHKcF853/v8E+HrVTP3nHi6y5vc4DAGAJ95MWwonmM+tqueXN0ISDhg1u24QwjFQwX1
         UsNLlCPlhqgOvIpmY/ZIhgXGNDu949sQNKug3WfzwjmVyfAQGxgZi04J8XTdc5FI1z29
         9N6wrqcFtPBPUn3VrxdTE2zIknuxhCBqe11/9RAxDO99cZS42eiHN6mZbTriruKDgQa8
         Xk0A==
X-Gm-Message-State: AJIora/C2zvZTOGHVBx+p/H5SMJ8mfkpDkIqb9NfTf6f2erKviafnJBA
        +dnnwI/NuojzQysM8SYPci9SOaoEVh9+GQ==
X-Google-Smtp-Source: AGRyM1tPkMWAavy5KS5BXLyz8/I9Ju21okzn2eCWm/YujV7RuhyHNqCk3zJncM4a++8HQHSCwjrvRQ==
X-Received: by 2002:a17:902:a710:b0:16c:5305:2244 with SMTP id w16-20020a170902a71000b0016c53052244mr8637552plq.125.1658673895848;
        Sun, 24 Jul 2022 07:44:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709026b8300b0016c4e4538c9sm7269986plk.7.2022.07.24.07.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 07:44:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4005c025-4722-53ab-116c-6bd1b37f4d41@roeck-us.net>
Date:   Sun, 24 Jul 2022 07:44:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220723033820.22612-1-W_Armin@gmx.de>
 <20220723033820.22612-2-W_Armin@gmx.de>
 <20220723141734.GC2979894@roeck-us.net>
 <7f5c4c26-aa4d-eb97-2188-690c9e11f9a4@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] hwmon: Add pwmX_fan_channel attribute
In-Reply-To: <7f5c4c26-aa4d-eb97-2188-690c9e11f9a4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/22 18:20, Armin Wolf wrote:
> Am 23.07.22 um 16:17 schrieb Guenter Roeck:
> 
>> On Sat, Jul 23, 2022 at 05:38:19AM +0200, Armin Wolf wrote:
>>> Until now, userspace software needs to guess which
>>> PWM channel is associated with which fan channel by
>>> probing each PWM output and watch for fan speed changes.
>>> This proccess is error-prone and unreliable.
>>>
>>> Some hwmon chips, especially firmware-based ones, already
>>> know which PWM output is associated with which fan channel.
>>>
>>> Allow such chips to export this knowledge to userspace.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> All of the chips I am aware of have a fixed association from pwm channel
>> output to fan input. None I am aware of make this association configurable.
>> I do not see the value of this attribute.
>>
>> Guenter
> 
> That is true, the association from pwm channel output to fan input is usually fixed.
> However not all chips are able to discover which pwm channel output is associated with
> which fan channel. For example most superio-based chips cannot know how the motherboard
> manufacturer wired the fans, and thus userspace relies on pwmconfig for manually probing
> each pwm channel.

Alternatively, the user can figure it out based on board documentation
and configure it directly. That is how it is. That doesn't mean that it makes
sense to 'store' that information in a sysfs attribute. That is not what hwmon
sysfs attributes are supposed to be used for.

> In contrast, many firmware-based chips do know which pwm channel output controls which
> fan channel. One example might be the dell-smm-hwmon driver and the gpio-fan driver.
> 
> In this case, making the attribute RO would indeed make sense.
> 

Unless the attribute is used to configure the chip, it does not make sense
in the first place. Also note that gpio-fan is usually configured using
devicetree properties, _and_ it only has a single set of fan/pwm properties,
so a sysfs attribute would always return 1 and make make even less sense there.

Guenter

> Armin Wolf
> 
>>> ---
>>>   Documentation/ABI/testing/sysfs-class-hwmon | 8 ++++++++
>>>   Documentation/hwmon/sysfs-interface.rst     | 3 +++
>>>   drivers/hwmon/hwmon.c                       | 1 +
>>>   include/linux/hwmon.h                       | 2 ++
>>>   4 files changed, 14 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
>>> index 7271781a23b2..f3d653bcf736 100644
>>> --- a/Documentation/ABI/testing/sysfs-class-hwmon
>>> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
>>> @@ -315,6 +315,14 @@ Description:
>>>
>>>           RW
>>>
>>> +What:        /sys/class/hwmon/hwmonX/pwmY_fan_channel
>>> +Description:
>>> +        Select which fan channel is controlled by this PWM output.
>>> +
>>> +        Valid fan channel/PWM output combinations are chip-dependent.
>>> +
>>> +        RW
>>> +
>>>   What:        /sys/class/hwmon/hwmonX/pwmY_auto_channels_temp
>>>   Description:
>>>           Select which temperature channels affect this PWM output in
>>> diff --git a/Documentation/hwmon/sysfs-interface.rst b/Documentation/hwmon/sysfs-interface.rst
>>> index 209626fb2405..17fcec03d3c5 100644
>>> --- a/Documentation/hwmon/sysfs-interface.rst
>>> +++ b/Documentation/hwmon/sysfs-interface.rst
>>> @@ -209,6 +209,9 @@ PWM
>>>   `pwm[1-*]_freq`
>>>           Base PWM frequency in Hz.
>>>
>>> +`pwm[1-*]_fan_channel`
>>> +                Select which fan channel is controlled by this PWM output.
>>> +
>>>   `pwm[1-*]_auto_channels_temp`
>>>           Select which temperature channels affect this PWM output in
>>>           auto mode.
>>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>>> index 2e2cd79d89eb..8c2d7574c461 100644
>>> --- a/drivers/hwmon/hwmon.c
>>> +++ b/drivers/hwmon/hwmon.c
>>> @@ -604,6 +604,7 @@ static const char * const hwmon_pwm_attr_templates[] = {
>>>       [hwmon_pwm_enable] = "pwm%d_enable",
>>>       [hwmon_pwm_mode] = "pwm%d_mode",
>>>       [hwmon_pwm_freq] = "pwm%d_freq",
>>> +    [hwmon_pwm_fan_channel] = "pwm%d_fan_channel",
>>>       [hwmon_pwm_auto_channels_temp] = "pwm%d_auto_channels_temp",
>>>   };
>>>
>>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>>> index 14325f93c6b2..9d40cc1e520f 100644
>>> --- a/include/linux/hwmon.h
>>> +++ b/include/linux/hwmon.h
>>> @@ -332,6 +332,7 @@ enum hwmon_pwm_attributes {
>>>       hwmon_pwm_enable,
>>>       hwmon_pwm_mode,
>>>       hwmon_pwm_freq,
>>> +    hwmon_pwm_fan_channel,
>>>       hwmon_pwm_auto_channels_temp,
>>>   };
>>>
>>> @@ -339,6 +340,7 @@ enum hwmon_pwm_attributes {
>>>   #define HWMON_PWM_ENABLE        BIT(hwmon_pwm_enable)
>>>   #define HWMON_PWM_MODE            BIT(hwmon_pwm_mode)
>>>   #define HWMON_PWM_FREQ            BIT(hwmon_pwm_freq)
>>> +#define HWMON_PWM_FAN_CHANNEL        BIT(hwmon_pwm_fan_channel)
>>>   #define HWMON_PWM_AUTO_CHANNELS_TEMP    BIT(hwmon_pwm_auto_channels_temp)
>>>
>>>   enum hwmon_intrusion_attributes {
>>> -- 
>>> 2.30.2
>>>

