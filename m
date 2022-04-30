Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B95515CF4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiD3MkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiD3MkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:40:16 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CA669280;
        Sat, 30 Apr 2022 05:36:54 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l9-20020a056830268900b006054381dd35so6875754otu.4;
        Sat, 30 Apr 2022 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Avtg8U1a0UTlE95PYdqBdaXhxpdHsz32dmj04jLlbjQ=;
        b=AlUSVqFsN8wJhZhPlfLFQDnmaTRsEiUtXXZPNGFzE3GdONjgSZxx3NdJq9gnYWx72u
         U+T7aXsXy5VreP74kwnG2Jxms2tXfp/vi42zbuAe+6B/a90LOYL31TBPR1Kt6N1mysyK
         BSyZF/oFW41m2cHrnApv2v53h9cBfsWZDLadlRfGJqsSbrhGUb/hR3Ql1aBN9abnAL09
         e84rv+/Hsv7rlX/hl691su0M04mForgLuEkBptr/eQllOugc7Qn/SBJMX8W20EYOEaFc
         +mWuAzw7kDuMATWNBGj79Grqbu9BphyLT8LdPalhSfM89MG2NS1y9UtKiz2KQn5uokdU
         T1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Avtg8U1a0UTlE95PYdqBdaXhxpdHsz32dmj04jLlbjQ=;
        b=SQAW9LVYHG9Nxg5QG1JzpHGCvmW9SFdPFzLZE8regtPei9XCk1VYeds1JJuP3wrq1N
         y1PbgM/JaA7y6nTC6+Fsu3IJf6BYTDCbr+v4ndyyg9dxeKHoLif1nYQMarzVJhJzR2xE
         /42DUaDugbFA8OX2Y/jPmr/WrfgvYLYiv0uNsgJ1ZRhijxSKXcIiQQZIhWGejFH4sl/Q
         ywdu1nRvcgCUwsblNIbnFkysElhxyUmrP8RY/0V1G/ROtIrIW8yYizQz2cO0dMyXoSgo
         PPLlwHbKGAqiHZGxpNzbiB8L4ak4XoJrv3F4WJqQ9SlZJKPhN3FPaogtXyx6mUb6X1le
         Rd/A==
X-Gm-Message-State: AOAM532QpJvHnSmrY8PXKPohelijuVKmvnESqOBv/xBPC/Q7E9HvHqo5
        O66xAKle4FlugE/t+ckrj0I=
X-Google-Smtp-Source: ABdhPJzLx1AaAI/DnEjp4kZBcH8VSeFMx3WRuLY+U2pDcCG1mpM4fisK94MdUBp7dQALAnRSx8s1Eg==
X-Received: by 2002:a9d:1b5:0:b0:605:d7e5:7fc7 with SMTP id e50-20020a9d01b5000000b00605d7e57fc7mr1333133ote.14.1651322214128;
        Sat, 30 Apr 2022 05:36:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v23-20020a4ae057000000b0035e9f149b90sm1829877oos.3.2022.04.30.05.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 05:36:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4217c96d-2fe2-fdef-3b15-b5368499f1bf@roeck-us.net>
Date:   Sat, 30 Apr 2022 05:36:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sebastian Ene <sebastianene@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com
References: <20220429083030.3241640-1-sebastianene@google.com>
 <20220429083030.3241640-3-sebastianene@google.com>
 <YmumSgiTrQUWoXsb@kroah.com>
 <e94fdd89-7b8e-eec3-4b2f-dcea55c7f0bc@roeck-us.net>
 <YmzUpr0e+eq0NUYc@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YmzUpr0e+eq0NUYc@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 23:18, Greg Kroah-Hartman wrote:
> On Fri, Apr 29, 2022 at 09:51:51AM -0700, Guenter Roeck wrote:
>> On 4/29/22 01:48, Greg Kroah-Hartman wrote:
>>> On Fri, Apr 29, 2022 at 08:30:33AM +0000, Sebastian Ene wrote:
>>>> This driver creates per-cpu hrtimers which are required to do the
>>>> periodic 'pet' operation. On a conventional watchdog-core driver, the
>>>> userspace is responsible for delivering the 'pet' events by writing to
>>>> the particular /dev/watchdogN node. In this case we require a strong
>>>> thread affinity to be able to account for lost time on a per vCPU.
>>>>
>>>> This part of the driver is the 'frontend' which is reponsible for
>>>> delivering the periodic 'pet' events, configuring the virtual peripheral
>>>> and listening for cpu hotplug events. The other part of the driver
>>>> handles the peripheral emulation and this part accounts for lost time by
>>>> looking at the /proc/{}/task/{}/stat entries and is located here:
>>>> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
>>>>
>>>> Signed-off-by: Sebastian Ene <sebastianene@google.com>
>>>> ---
>>>>    drivers/misc/Kconfig       |  12 +++
>>>>    drivers/misc/Makefile      |   1 +
>>>>    drivers/misc/vm-watchdog.c | 206 +++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 219 insertions(+)
>>>>    create mode 100644 drivers/misc/vm-watchdog.c
>>>>
>>>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>>>> index 2b9572a6d114..26c3a99e269c 100644
>>>> --- a/drivers/misc/Kconfig
>>>> +++ b/drivers/misc/Kconfig
>>>> @@ -493,6 +493,18 @@ config OPEN_DICE
>>>>    	  If unsure, say N.
>>>> +config VM_WATCHDOG
>>>> +	tristate "Virtual Machine Watchdog"
>>>> +	select LOCKUP_DETECTOR
>>>> +	help
>>>> +	  Detect CPU locks on the virtual machine. This driver relies on the
>>>> +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
>>>> +	  has to do a 'pet', it exits the guest through MMIO write and the
>>>> +	  backend driver takes into account the lost ticks for this particular
>>>> +	  CPU.
>>>> +	  To compile this driver as a module, choose M here: the
>>>> +	  module will be called vm-wdt.
>>>
>>> You forgot to name the module properly here based on the Makefile change
>>> you made.
>>>
>>> And again, as this is called a "watchdog", it seems crazy that it is not
>>> in drivers/watchdog/
>>>
>>
>> I disagree. It is not a watchdog driver in the traditional sense (it does
>> not use, want to use, or need to use the watchdog driver API or ABI).
>> Its functionality is similar to the functionality of kernel/watchdog.c,
>> which doesn't belong into drivers/watchdog either.
> 
> Ah, ok, that makes more sense, the user/kernel api is not the same.
> Someone should put that in the changelog next time :)
> 

Renaming it to "VCPU stall detector" or similar should fix the confusion.

Guenter
