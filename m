Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0C57F600
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiGXQad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiGXQab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:30:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E211117F;
        Sun, 24 Jul 2022 09:30:30 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h132so8328797pgc.10;
        Sun, 24 Jul 2022 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=PQJ0FjQXDR/Sgw7KF5CLi/PBTOkjGRDxr2OlSvwVCgs=;
        b=dJq6c9Chb97lR3PsMmJiDNB1A3Os+7nE2/mIIVFyohygMEhnqdBBP92irGn2lgMTjO
         qIgi0qdYDIz+YyejDe2TCqVzEaZ2rp6M7EwzXmfkwgpcCbCsB4MCaT7yzRVWbN4+b5gB
         3kEhwiNJBNjCalJfyiXkIkMNyuJ6S/YifKY6Noy4Bu7Pe736uxx7AVXWaS74696ZhdVa
         f8ynOrfHy3SmyhzR8nrumjNlGRkiInenemmX2b+F/vTthkctNjdAxDXwQ0A1H/SNM4vu
         j3gVI7lKOwZkKQwQaoStD8Ej9PCSB+2UGANHbetoFdADp69ZFrGTa/HLntOwosn1thur
         /r0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=PQJ0FjQXDR/Sgw7KF5CLi/PBTOkjGRDxr2OlSvwVCgs=;
        b=qKmnCKTsWKXpzupcQwqNSqOlQRx1blL/kToy31Wo1qg43JJjJ00x+S239S0z4uXXGr
         SMF88KvZnRa0TFHcJDLfMhlCHqaqss7WK+otKGkGAaQAGcyY+JJTuBk2Ct0qCYK4L0VI
         xOkIFpWS8Ziefi/bU3b+r8pjKmA8pRaW/KGwAtCDz6aOhblvIHpD0Nocg/SWAs1Zy+L4
         Egwoz56F4coG3vZ73v+nRkSybLn+C0wWO+nJ0YI04VQVnCyqRx3guXHDggJ911vxXl/c
         NgmcOLjDFZAYjeEGYRqv6qexmUEjfe4eaCqkKYnFnuAKkB6fafdLEN9NxZAX7Q8iPtjU
         GMLQ==
X-Gm-Message-State: AJIora9ooUcG33mfI/JH7baihMNyjz0DrOjEdwLCikbOFe2QKaaRKJ3F
        Na2deAV9Tfa88zp3X06+/Xs=
X-Google-Smtp-Source: AGRyM1v3Bep1LzW8UiA21lihgQvk/dJHCVnGKEOYzLt8xWNPrd/bkwPhBik3gMDfNSYWGnNhEB9W9g==
X-Received: by 2002:a65:524a:0:b0:41a:996c:a2c6 with SMTP id q10-20020a65524a000000b0041a996ca2c6mr7703761pgp.528.1658680229196;
        Sun, 24 Jul 2022 09:30:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79416000000b005289fad1bbesm7967695pfo.94.2022.07.24.09.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 09:30:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e948e1e7-88d4-954f-64c8-f0e5a83a3ee8@roeck-us.net>
Date:   Sun, 24 Jul 2022 09:30:26 -0700
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
 <4005c025-4722-53ab-116c-6bd1b37f4d41@roeck-us.net>
 <9d621e8c-6e62-b0e3-9a6a-c2e904b00971@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] hwmon: Add pwmX_fan_channel attribute
In-Reply-To: <9d621e8c-6e62-b0e3-9a6a-c2e904b00971@gmx.de>
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

On 7/24/22 09:06, Armin Wolf wrote:
[ ... ]
> It would be indeed better if userspace software like pwmconfig would
> use an internal list containing the names of all hwmon chips for which
> the pwm to fan mappings are known.
> I will add a note to the documentation of dell-smm-hwmon about the
> pwm to fan mapping so userspace software knows about this.

That is effectively the fancontrol configuration file. pwmconfig is
supposed to assist in determining how that configuration file should
look like. Having some file added to pwmcontrol to determine how the
fancontrol configuration file should look like seems a bit off-track.

What you are talking about is really the idea of providing a number of
sample configuration files with the fancontrol (or lm-sensors) package,
similar to the various sensors.conf files. That doesn't belong into
the hwmon kernel documentation. It should be part of the lm-sensors
package.

Guenter

> Sorry for bothering you.
> 
> Armin Wolf
> 
>>> In contrast, many firmware-based chips do know which pwm channel
>>> output controls which
>>> fan channel. One example might be the dell-smm-hwmon driver and the
>>> gpio-fan driver.
>>>
>>> In this case, making the attribute RO would indeed make sense.
>>>
>>
>> Unless the attribute is used to configure the chip, it does not make
>> sense
>> in the first place. Also note that gpio-fan is usually configured using
>> devicetree properties, _and_ it only has a single set of fan/pwm
>> properties,
>> so a sysfs attribute would always return 1 and make make even less
>> sense there.
>>
>> Guenter
>>
>>> Armin Wolf
>>>
>>>>> ---
>>>>>   Documentation/ABI/testing/sysfs-class-hwmon | 8 ++++++++
>>>>>   Documentation/hwmon/sysfs-interface.rst     | 3 +++
>>>>>   drivers/hwmon/hwmon.c                       | 1 +
>>>>>   include/linux/hwmon.h                       | 2 ++
>>>>>   4 files changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon
>>>>> b/Documentation/ABI/testing/sysfs-class-hwmon
>>>>> index 7271781a23b2..f3d653bcf736 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-class-hwmon
>>>>> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
>>>>> @@ -315,6 +315,14 @@ Description:
>>>>>
>>>>>           RW
>>>>>
>>>>> +What:        /sys/class/hwmon/hwmonX/pwmY_fan_channel
>>>>> +Description:
>>>>> +        Select which fan channel is controlled by this PWM output.
>>>>> +
>>>>> +        Valid fan channel/PWM output combinations are chip-dependent.
>>>>> +
>>>>> +        RW
>>>>> +
>>>>>   What: /sys/class/hwmon/hwmonX/pwmY_auto_channels_temp
>>>>>   Description:
>>>>>           Select which temperature channels affect this PWM output in
>>>>> diff --git a/Documentation/hwmon/sysfs-interface.rst
>>>>> b/Documentation/hwmon/sysfs-interface.rst
>>>>> index 209626fb2405..17fcec03d3c5 100644
>>>>> --- a/Documentation/hwmon/sysfs-interface.rst
>>>>> +++ b/Documentation/hwmon/sysfs-interface.rst
>>>>> @@ -209,6 +209,9 @@ PWM
>>>>>   `pwm[1-*]_freq`
>>>>>           Base PWM frequency in Hz.
>>>>>
>>>>> +`pwm[1-*]_fan_channel`
>>>>> +                Select which fan channel is controlled by this PWM
>>>>> output.
>>>>> +
>>>>>   `pwm[1-*]_auto_channels_temp`
>>>>>           Select which temperature channels affect this PWM output in
>>>>>           auto mode.
>>>>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>>>>> index 2e2cd79d89eb..8c2d7574c461 100644
>>>>> --- a/drivers/hwmon/hwmon.c
>>>>> +++ b/drivers/hwmon/hwmon.c
>>>>> @@ -604,6 +604,7 @@ static const char * const
>>>>> hwmon_pwm_attr_templates[] = {
>>>>>       [hwmon_pwm_enable] = "pwm%d_enable",
>>>>>       [hwmon_pwm_mode] = "pwm%d_mode",
>>>>>       [hwmon_pwm_freq] = "pwm%d_freq",
>>>>> +    [hwmon_pwm_fan_channel] = "pwm%d_fan_channel",
>>>>>       [hwmon_pwm_auto_channels_temp] = "pwm%d_auto_channels_temp",
>>>>>   };
>>>>>
>>>>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>>>>> index 14325f93c6b2..9d40cc1e520f 100644
>>>>> --- a/include/linux/hwmon.h
>>>>> +++ b/include/linux/hwmon.h
>>>>> @@ -332,6 +332,7 @@ enum hwmon_pwm_attributes {
>>>>>       hwmon_pwm_enable,
>>>>>       hwmon_pwm_mode,
>>>>>       hwmon_pwm_freq,
>>>>> +    hwmon_pwm_fan_channel,
>>>>>       hwmon_pwm_auto_channels_temp,
>>>>>   };
>>>>>
>>>>> @@ -339,6 +340,7 @@ enum hwmon_pwm_attributes {
>>>>>   #define HWMON_PWM_ENABLE        BIT(hwmon_pwm_enable)
>>>>>   #define HWMON_PWM_MODE            BIT(hwmon_pwm_mode)
>>>>>   #define HWMON_PWM_FREQ            BIT(hwmon_pwm_freq)
>>>>> +#define HWMON_PWM_FAN_CHANNEL BIT(hwmon_pwm_fan_channel)
>>>>>   #define HWMON_PWM_AUTO_CHANNELS_TEMP
>>>>> BIT(hwmon_pwm_auto_channels_temp)
>>>>>
>>>>>   enum hwmon_intrusion_attributes {
>>>>> -- 
>>>>> 2.30.2
>>>>>
>>

