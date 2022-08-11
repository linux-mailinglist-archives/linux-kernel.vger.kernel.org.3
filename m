Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4845A58FEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiHKPCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiHKPCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:02:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3554026540;
        Thu, 11 Aug 2022 08:02:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r69so10814742pgr.2;
        Thu, 11 Aug 2022 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=PdxjyG4o129tv5D6bBFrRNKETbxKBwJPUxDMzvux7fQ=;
        b=Yjzv7ukSa1e49QP+0UORQLT4AfgMOH13n925fw7D1p0anHZp+kw6vrg0rJlkopgfpo
         Bwj813DpHXYKz/i9Eh3uid9RYJM1qQmc1gybbQfTcJOYXqNku/JgeEXwyKat10Nt1LxS
         UbxDp3kmcs39ZWa3fs2C6fbrWavJqeVyWiuqZsmYB3LOM8QAx0vPPXqOWKHm03ZJBRoP
         4+Pl9oW9YDCdVOzHjeBj07OhfOaWMjXdVGIYGADpiUldrRqpqH4xxOpC8CJgGu9dyGw+
         d8By8bRMY6wFdanKsMoHpBDldr6fx8Z7QTFGOqF7JnJVZ3yNVlCrqeLa02QNKiVp6DA3
         3GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=PdxjyG4o129tv5D6bBFrRNKETbxKBwJPUxDMzvux7fQ=;
        b=4nifBiZiyo1m3LDlqRTrGzZYIO8jBZqDOI/CALNE1AZWc5YMYHgVFK4NUN1Cu53e00
         z4s8syMfSMC8mnjdNTqr8ycSdD8ntHnQ7eu2ld82OrJLa6Tlfs+B5Gyr7FfEpMJbkwyx
         nMcoROEMg3HlqZlWOL0g69oZakC+XIPgbbz9Lka6omC0yE5iEeX8fWlkdRIIkUbniyAq
         vea94zKcG3PLA6nJNvhLpPIuOCOwnc6HR5066i8iVMEHAtnV3JR+ThCTxWBswPtF+oW3
         74RhEghLLh5Pk1A3Z0eTdPQlc2tIBo63UqXrMc4jV5ddCupJ0DE2HuILM+6xS3S6Zkba
         ArCw==
X-Gm-Message-State: ACgBeo1xVX1G4R+WPLl1wIxafUe7quUu1LvNYdJyRLmi+e2gQ+J7fRDg
        HFbAlFyiMfrquE/XX/RUrz8=
X-Google-Smtp-Source: AA6agR4ac+p0iDbzB4anSBk/axdljzlGUCKwJ8GLULUNQggGjBmnT0WenqTW9hJVvlMkh8exuQtyng==
X-Received: by 2002:a05:6a00:23d0:b0:52e:74be:d52 with SMTP id g16-20020a056a0023d000b0052e74be0d52mr32180482pfc.62.1660230149535;
        Thu, 11 Aug 2022 08:02:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b0016eede528b4sm15183659plg.61.2022.08.11.08.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:02:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5474a8db-4f15-5f83-7685-de43183b0fb1@roeck-us.net>
Date:   Thu, 11 Aug 2022 08:02:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
References: <YvO4cfx12Q9gcmPg@monster.localdomain>
 <ace70782-777f-ab7c-d190-735f5c65a5e4@roeck-us.net>
 <20220810185658.6e27d9bd@posteo.net>
 <bc1d22d1-45b4-7d49-bedd-f0eafdc035cd@roeck-us.net>
 <20220810194852.78536153@posteo.net>
 <8beb8ae2-04cd-fa37-5dbe-8d18e6a53f4d@roeck-us.net>
 <20220811100506.4d69b027@posteo.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
In-Reply-To: <20220811100506.4d69b027@posteo.net>
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

On 8/11/22 01:05, Wilken Gottwalt wrote:
> On Wed, 10 Aug 2022 11:21:36 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 8/10/22 10:48, Wilken Gottwalt wrote:
>>> On Wed, 10 Aug 2022 10:29:08 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>> On 8/10/22 09:56, Wilken Gottwalt wrote:
>>>>> On Wed, 10 Aug 2022 09:31:21 -0700
>>>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>>> On 8/10/22 06:53, Wilken Gottwalt wrote:
>>>>>>> Add reporting if the PSU is running in single or multi rail mode via
>>>>>>> ocpmode debugfs entry. Also update the documentation accordingly.
>>>>>>>
>>>>>>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>>>>>>> ---
>>>>>>> Changes in v2:
>>>>>>>       - fixed spelling issues in commit message
>>>>>>
>>>>>> You did not address or even provide feedback on my second comment.
>>>>>
>>>>> Oh darn ... sorry, I was quite busy and didn't really pay attention. I will
>>>>> answer the earlier mail and think about it.
>>>>>
>>>>> Though, maybe you can help me with that what keeps me so busy. Would it be okay
>>>>> to use a kthread in a hwmon driver to do sampling (500ms - 10s) in conjunction
>>>>> with HWMON_C_UPDATE_INTERVAL, or is this a strict no-no? I know it is actually
>>>>> used to set a sample/update rate in a sensor (-register), but this USB-HID
>>>>> approach is a pure polling thing. It seems to work quite and enables the driver
>>>>> to collect data quite early in the boot process.
>>>>>
>>>>
>>>> It really depends. Is it _necessary_ ? The pwm-fan driver uses a timer for
>>>> periodic polling, but that is because it has to. We should not do it purely
>>>> for convenience, and from the code I don't immediately see why it would
>>>> be necessary.
>>>
>>> Together with the polling I would add encountered lowest and highest values and
>>> the average of basically all available sensors (kind of session statistics). I
>>> know it is a bit odd, but currently these power supplies are sold again in a
>>> newer version and people really like to use them in their servers/workstations
>>> because of the "realtime" data and this driver. No joke, but I really got
>>> several requests to add this and I must admit I have quite some fun implementing
>>> it.
>>>
>>
>> That is out of scope for a kernel driver. If desired, a user space application
>> should do the polling and calculate statistics such as lowest/highest or averages.
> 
> That is exactly what I told the requesting people. Now it is in the public
> record and I hope that kind of requests go down a bit, at least for pushing
> this in the mainline kernel.
> 

 From Documentation/hwmon/sysfs-interface.rst:

"
All entries (except name) are optional, and should only be created in a
given driver if the chip has the feature.
"

Think about it - having the kernel collect statistics like this would only
make sense if it was added for all drivers, ie in the hwmon core. That would
end up burdening everyone, not just the few people who want it.

Guenter
