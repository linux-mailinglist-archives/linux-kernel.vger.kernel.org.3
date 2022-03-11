Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187E74D6994
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiCKUkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiCKUkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:40:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9BA1D830E;
        Fri, 11 Mar 2022 12:39:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q11so8583738pln.11;
        Fri, 11 Mar 2022 12:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bO2rIxvDYfsPa9cxwHpXWKkPY45x6bqw/K1gApD60dc=;
        b=oFh81eq1xvA1WxDZUpu6563KMLc1LBvX8YJGxaJ+9gJd2A1asPeE5aX+voMfmC4fnk
         MA1teTVM8J9Rif6peJ9Ogl4tKOTPvj3lrz61XoPipjnTnfA/0+5tM+JLoWmrpo2nuYXe
         qJx8CSCQ81pzfv8fZ0IsELuMXXNn4PshanBHY5GQzMNywV8bMe2HwJcoyuDHaPnz9kmn
         IdOviz/YuXL1gwoirgdVQf4jB0IRdlgqt0qTpNrp+4rGp3HgedhP7U+i3qOV3pZSF76G
         mWL4WdxkFOXU8OYe0ZLupAx+t8cqjsAhG2rj5VvoB46XOqyG9IVvCDwWfIALihFY2v2z
         JJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bO2rIxvDYfsPa9cxwHpXWKkPY45x6bqw/K1gApD60dc=;
        b=bH/M2VUAkdw6DE4thXHutjTk4io/JD9rJ2wsuUBH3Ac2lngByL7LCDeWbw3+H/AGKB
         7dHhrPDKIR5vzgjFu7zA3UGdBjCLCKwjV9wDi2KFpWxGlxNGrEaVHL4a+gbRqqNX7HhL
         Ve52gaaF/rJdogi4X53bmUEKnxoPO02gSBPkNZK/eiSvhVuE7kzqNgYyuYY8WvM6A+C9
         SjPYlGPToUH+p4BBrpCjNoAOfzsirfnyvS6c3NZslnJIitYdFHIZdMTScn+FNnR8xbt4
         WGAkmZg9atzEWFMHOkjx79co20pPNjDTylnOuXhr3ZwVROOxBajl4Y3uxFQDxdpIUgD7
         8bJw==
X-Gm-Message-State: AOAM533BTDqf/CaPQM5KQA+ypu1LBUM+lgJhZlhZUP9bK0SwOfuHwccS
        jdAwej7114q3wwbKVxWWhI0=
X-Google-Smtp-Source: ABdhPJy0ATLW9SlY3h7D8I+JGTRadFoRZdR9jWZw9XSsybl0ti2G1NFHWkbScIaWygCLjDpZxKLZAw==
X-Received: by 2002:a17:902:bd88:b0:14f:8ddf:e373 with SMTP id q8-20020a170902bd8800b0014f8ddfe373mr11870266pls.89.1647031143354;
        Fri, 11 Mar 2022 12:39:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o66-20020a17090a0a4800b001bf388fc96esm10071246pjo.21.2022.03.11.12.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 12:39:02 -0800 (PST)
Subject: Re: [PATCH] tty: serial: bcm63xx: use more precise Kconfig symbol
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Arnd Bergmann <arnd@arndb.de>
References: <20220310072239.4489-1-zajec5@gmail.com>
 <CAMuHMdWQNDABuT9uwAugrzdQM31wFtXX_9F8MviC-BRc-YngKw@mail.gmail.com>
 <145c66e0-2ba5-712c-57de-82378328ec3f@gmail.com>
 <7d7ed784-f01f-44a0-4387-cd7a76a8abe4@gmail.com>
 <CAMuHMdU92K9ZLptwJPG_opA4Reg61ksOgQ-P+2niHX=bf306Kg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <10d33c58-3f77-2aa2-fbb5-3d6fbad08f5b@gmail.com>
Date:   Fri, 11 Mar 2022 12:38:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU92K9ZLptwJPG_opA4Reg61ksOgQ-P+2niHX=bf306Kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 1:13 AM, Geert Uytterhoeven wrote:
> Hi Florian,
> 
> On Thu, Mar 10, 2022 at 10:49 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 3/10/22 12:33 AM, Rafał Miłecki wrote:
>>> On 10.03.2022 09:19, Geert Uytterhoeven wrote:
>>>> On Thu, Mar 10, 2022 at 8:22 AM Rafał Miłecki <zajec5@gmail.com> wrote:
>>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>>
>>>>> Patches lowering SERIAL_BCM63XX dependencies led to a discussion and
>>>>> documentation change regarding "depends" usage. Adjust Kconfig entry to
>>>>> match current guidelines. Make this symbol available for relevant
>>>>> architectures only.
>>>>>
>>>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>>>> Ref: f35a07f92616 ("tty: serial: bcm63xx: lower driver dependencies")
>>>>> Ref: 18084e435ff6 ("Documentation/kbuild: Document platform
>>>>> dependency practises")
>>>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>>>
>>>> Thanks for your patch!
>>>>
>>>>> --- a/drivers/tty/serial/Kconfig
>>>>> +++ b/drivers/tty/serial/Kconfig
>>>>> @@ -1100,7 +1100,8 @@ config SERIAL_TIMBERDALE
>>>>>   config SERIAL_BCM63XX
>>>>>          tristate "Broadcom BCM63xx/BCM33xx UART support"
>>>>>          select SERIAL_CORE
>>>>> -       depends on COMMON_CLK
>>>>> +       depends on MIPS || ARM || ARM64 || COMPILE_TEST
>>>>> +       default ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC
>>>>
>>>> So ARCH_BCM4908 covers ARM64, and BCM63XX || BMIPS_GENERIC
>>>> cover MIPS.  Is there some symbol covering ARM so we can change the
>>>> depends to
>>>>
>>>>      depends on FOO || ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC ||
>>>> COMPILE_TEST
>>>>
>>>> ?
>>>
>>> Florian, Kevin: do you know what other platforms need that driver?
>>
>> Yes that would be ARCH_BCM_63XX.
> 
> Had to read this twice, before I realized this is different from BCM63XX.
> 
> As we already have
> 
>     drivers/char/hw_random/Kconfig:    ARCH_BCM_63XX || BCM63XX ||
> BMIPS_GENERIC || COMPILE_TEST
>     drivers/spi/Kconfig: depends on BCM63XX || BMIPS_GENERIC ||
> ARCH_BCM_63XX || COMPILE_TEST
> 
> and drivers/tty/serial/Kconfig would be a third case, would it make
> sense to unify BCM63XX and ARCH_BCM_63XX into a single symbol?
> We already share several ARCH_* symbols between arm and arm64,
> and I expect more will be shared with riscv in the future
> (e.g. ARCH_RENESAS).

In hindsight, I could have used BCM63XX, however back then a number of
drivers that depended on BCM63XX were either not applicable, or not able
to build with an ARM-based kernel. For consistency with the other
platforms defined in arch/arm/mach-bcm/Kconfig, I went with
ARCH_BCM6_63XX to denote the difference.

> 
> Or are MIPS BCM63xx and ARM BCM63xx too dissimilar?

The chips are an incremental update in a number of ways and did take a
number of the "legacy" cores present in previous chips in the UBUS bus
bridge, such as UART, GPIO, timer, watchdog, USB device controller, but
also added new ones in the AXI bus.

Changing the symbol names could be done, but it feels like it could be
some unnecessary churn now, no?
-- 
Florian
