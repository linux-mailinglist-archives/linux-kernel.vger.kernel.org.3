Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF924F857E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbiDGRGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiDGRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:06:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E596E6E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:03:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 7so5966647pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o7DSjU/xqsy5AN43adD8t3WIGQh58clKwf1/MSjnezU=;
        b=NNzy7KBEDqTeDpfORIJWKVxVgYlxgXab9P2GUoqXJaO+iclNG3I0IQewNcIaXqn3sb
         X8JT7yXdiwed/rH+gUtGXXIGyVz3PWGY2FsiltlfKQMGQJ+achwjKMEdX7/jfKK+szwt
         n4Y63fpbVOOFn36A2QKJcS8NW1yFKENg2hDiz0fVfbP9FRWp7DoyTZZLu9YSQ/jpEUaK
         gQeOyisl1FZ9sj0ahUQ8KhpJi58JbsCVvbtgg+BL/V7Z5xlMmF85eDwRafnMaLifLGQc
         n7S88/96zfIYHXrTwD/BgskKB3VEeRw+NU30fpav1XUXDt+52+/C9pEpBwqunqfRu9ZN
         Hing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o7DSjU/xqsy5AN43adD8t3WIGQh58clKwf1/MSjnezU=;
        b=eQH2acjxr0GqrtJ4wbPZ3U5oPipUZ2ssgK+ideLnRq9L0Trss41SI9V2Xre8pM4PK+
         1FEGsAZNmj5Ov325bgWC4eetCNVDLlIVKhnIt/LxGMJAvER9W+yjjY5n2dvfpUroq9eB
         fCO/lC78ruEbKVlc47A75+e1teorBaZXCnJWFt37u2Nuo4Owrfk/Dt2YAyXiyjipObFC
         8GwL/bam1piiz6MxxYmZMHbUhHR5jg1NUfisscG10CKZrXVG5I0KCP8w6SgL0/wIxfkP
         Ks4PjU38ex4I6JOEFyZSnPDjS9t52+QTC7pD6HZvCQjybXYrOQQykMkLA0P7kMvd/4J3
         gJTA==
X-Gm-Message-State: AOAM533VkBvfDhLCR0159yIn+3ZcqjsTaQ/oZ8+x+Wqw2n0qupgZ7rH3
        r2Yhn2RdMIbSxMEY1qE10kZyOhtbxhI=
X-Google-Smtp-Source: ABdhPJwQI7ynXVTWqobtJxGlzNkdbGN3HOUSpbgNgINefYsCfjF4/7+CqvaD34sE2OMn1FWyboVJyw==
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr15182922pfl.38.1649351036931;
        Thu, 07 Apr 2022 10:03:56 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm9360090pjk.8.2022.04.07.10.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 10:03:56 -0700 (PDT)
Message-ID: <0fdba110-8743-3b2d-cb30-3a89b7cfa592@gmail.com>
Date:   Fri, 8 Apr 2022 02:03:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
Content-Language: en-US
To:     Guenter Roeck <groeck@google.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
 <Yk4DGZfpYbK8dofL@chromium.org>
 <CABXOdTcY3w56hc7kWsDLxKU-c6fCLYt_jigK13tKjjm9OHi2+w@mail.gmail.com>
 <033c1ec4-4bee-a689-140c-9694dfee435b@gmail.com>
 <CABXOdTet5ynSXf94qMimobJF4LLzHc89cVbwJ5NuAz8G6jmVdQ@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <CABXOdTet5ynSXf94qMimobJF4LLzHc89cVbwJ5NuAz8G6jmVdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/08 1:28, Guenter Roeck wrote:
> On Wed, Apr 6, 2022 at 6:16 PM Akihiko Odaki <akihiko.odaki@gmail.com> wrote:
> [ ... ]
>>>>>         ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
> 
> I completely missed the part that this is not on the parent.
> 
>>>>> +     if (!ec_dev)
>>>>> +             return -EPROBE_DEFER;
> [ ... ]
>>
>> 1. The parent exists and dev_get_drvdata(pdev->dev.parent) returns
>> non-NULL value. However, dev_get_drvdata(&typec->ec->ec->dev) returns
>> NULL. (Yes, that is confusing.) I'm wondering
> 
> I am actually surprised that typec->ec->ec is not NULL. Underlying
> problem (or, one underlying problem) is that it is set in
> cros_ec_register():
> 
>          /* Register a platform device for the main EC instance */
>          ec_dev->ec = platform_device_register_data(ec_dev->dev, "cros-ec-dev",
>                                          PLATFORM_DEVID_AUTO, &ec_p,
>                                          sizeof(struct cros_ec_platform));
> 
> "cros-ec-dev" is the mfd device which instantiates the character
> device. On devicetree (arm64) systems, the typec device is registered
> as child of google,cros-ec-spi and thus should be instantiated only
> after the spi device has been instantiated. The same should happen on
> ACPI systems, but I don't know if that is really correct.
> 
> I don't know what exactly is happening, but apparently typec
> registration happens in parallel with cros-ec-dev registration, which
> is delayed because the character device is not loaded. As mentioned, I
> don't understand why typec->ec->ec is not NULL. Can you check what it
> points to ?

If I read the code correctly, the registration itself happens 
synchronously and platform_device_register_data() always returns a 
non-NULL value unless it returns -ENOMEM. The driver, however, can be 
asynchronously bound and dev_get_drvdata(&typec->ec->ec->dev) can return 
NULL as the consequence. It would have a call trace like the following 
when scheduling asynchronous driver binding:
platform_device_register_data()
platform_device_register_resndata()
platform_device_register_full()
-  This always creates and returns platform_device.
platform_device_add()
- This adds the created platform_device.
device_add()
bus_probe_device()
device_initial_probe()
__device_attach()
- This schedules asynchronous probing.

typec->ec->ec should be pointing to the correct platform_device as the 
patched driver works without Oops on my computer. It is not NULL at least.

Regards,
Akihiko Odaki

> 
> Thanks,
> Guenter
> 
>> dev_get_drvdata(pdev->dev.parent) returned NULL in the following crash
>> log but it would be a problem distinct from what is handled with my patch:
>> https://lore.kernel.org/lkml/CABXOdTe9u_DW=NZM1-J120Gu1gibDy8SsgHP3bJwwLsE_iuLAQ@mail.gmail.com/
>>
>> 2. My patch returns -EPROBE_DEFER instead of -ENODEV and I confirmed it
>> will eventually be instantiated.
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Guenter
>>>
>>>> Thanks,
>>>>
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/chrome?id=ffebd90532728086007038986900426544e3df4e
>>

