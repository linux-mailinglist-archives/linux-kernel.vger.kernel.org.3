Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E5850C42B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiDVWK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiDVWIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:08:42 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63B21E091;
        Fri, 22 Apr 2022 13:56:00 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q129so10378477oif.4;
        Fri, 22 Apr 2022 13:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=dXiJm80u3vct5ZA4J6DW1RGzMyFIoPHOT6vuGbwNurc=;
        b=iWRJDLUmsJExj3ZSWRXFuO7zZl7oyn5zK0LHtmS8jytsmUlOLYrbZl3zMMDdT3uWm/
         xyML3s2qTKRkkCUZzTEAvOhXBkTSBfz3qgrecZ7igdGU3IMaWlrlzazDF/pHlwN7SWtJ
         vf75sZ7ob6NZmJI+M7eI/fY8u94ltVTe8ANXOYopOiJ+yIt0DtFVEfWZTMsW09SGZkvh
         0evVUyf6R+UmDiqo1pL9gn2BUdEp8Kq4quRaY6A3/56ZT9ff9ZIRVCAToYbvWo7ZyFcD
         1yzjHW2DhO7j75VO4r/7ZGtQscQjW0Aqh5SqgmfV6oCZtNU4NVdoO4lg6AeAaN2/W5l0
         OIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=dXiJm80u3vct5ZA4J6DW1RGzMyFIoPHOT6vuGbwNurc=;
        b=RMpSsQiLZTKxYk+JVFCAB9HmW2rtgUCZvZfJ4YGHRL5Z0Y7jHNpi3Cqkjroj4hbHe8
         Pzzxs7POQAikvVKYCxAq/+6wWKv/wzOfCW8+H/w1S+61msV7T4ednhL7tdWwONUdP1Ui
         aSaOA6nqRs3J07Z/JEhrWh7A82K0qL9c2ORgZW3dVH++XtfNsSvguMH0r85wM8e6X6mV
         2moddkUqfC+FKtIzIkEGoQcK4PsRRkrp+qOMTVahVBMWzRQ7c4SKOJ/0A/i6KCBvmYt2
         jtqlfJLMHyykpWN2cWQRSIryj2OxxtT+fF2EERdRkctLPdpIf5aewPgu6I9yt9vy4fru
         AXbA==
X-Gm-Message-State: AOAM532Er40uaNR8T6cQE1ChMkAzN7c1wjA2tk59uoaFLV1KbjDSObEh
        eyKzVVzTz+9Gczo+3HsswQc=
X-Google-Smtp-Source: ABdhPJwX4UvBJ53I/iBuJGqgq7gnqoevqiajv9t+AYucTVvzXxJv8bs7/qWcwXRyplXGqFxwCPEdcA==
X-Received: by 2002:aca:adc6:0:b0:322:4e10:49c6 with SMTP id w189-20020acaadc6000000b003224e1049c6mr3195846oie.256.1650660959564;
        Fri, 22 Apr 2022 13:55:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y26-20020a544d9a000000b00322656e2988sm1123312oix.39.2022.04.22.13.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 13:55:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net>
Date:   Fri, 22 Apr 2022 13:55:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
 <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
In-Reply-To: <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 12:16, Arnd Bergmann wrote:
> On Fri, Apr 22, 2022 at 7:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Tue, Apr 19, 2022 at 06:37:22PM +0200, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> This revisits a series I sent a few years ago:
>>>
>>> https://lore.kernel.org/lkml/20191018154052.1276506-1-arnd@arndb.de/
>>>
>>> All the other ARMv5 conversions are under way now, with
>>> OMAP1 being the only one still not in linux-next yet,
>>> and PXA completing the set.
>>>
>>> Most of the patches are unchanged from before, furtunately
>>> the PXA code is fairly stable. I addressed Robert's comments,
>>> pulled in two patches from Dmitry, and added the last a the
>>> final four patches to finish off the multiplatform conversion.
>>>
>>> I hope someone is left to test these on PXA: if this works,
>>> I'd like to merge it for 5.19. A git tree with these is avaialable
>>> for testing at
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=pxa-multiplatform-5.18
>>>
>>
>> Unfortunately that crashes for me when trying to boot from ide.
>> Bisect points to the last patch of the series.
> 
> Thanks a lot for testing and the perfect bug report!
> 
>> [    1.403715] 8<--- cut here ---
>> [    1.403848] Unable to handle kernel paging request at virtual address feeb000e
>> [    1.404097] [feeb000e] *pgd=00000000
> 
> Ok, this is the PCI I/O space area, which starts at 0xfee00000,
> clearly the way I/O space
> gets mapped changed here. I don't yet see what happened, but it should
> be straightforward
> to find from here.
> 
>> [    1.416643]  pcmcia_init_one from pcmcia_device_probe+0xe4/0x2a0
>> [    1.416882]  pcmcia_device_probe from really_probe+0xc8/0x3b4
>> [    1.417070]  really_probe from __driver_probe_device+0x9c/0x214
>> [    1.417255]  __driver_probe_device from driver_probe_device+0x38/0xe0
>> [    1.417454]  driver_probe_device from __device_attach_driver+0xa4/0x11c
>> [    1.417657]  __device_attach_driver from bus_for_each_drv+0x88/0xd8
>> [    1.417864]  bus_for_each_drv from __device_attach+0xf4/0x194
>> [    1.418047]  __device_attach from bus_probe_device+0x8c/0x94
>> [    1.418224]  bus_probe_device from device_add+0x3d0/0x894
>> [    1.418395]  device_add from pcmcia_device_add+0x2ec/0x3e0
>> [    1.418568]  pcmcia_device_add from pcmcia_card_add+0xd4/0x1a0
>> [    1.418756]  pcmcia_card_add from pcmcia_bus_add+0x44/0x4c
>> [    1.418930]  pcmcia_bus_add from socket_insert+0x12c/0x150
>> [    1.419103]  socket_insert from pccardd+0x398/0x44c
>> [    1.419257]  pccardd from kthread+0xdc/0x114
>> [    1.419400]  kthread from ret_from_fork+0x14/0x2c
>> [    1.419569] Exception stack(0xc48a5fb0 to 0xc48a5ff8)
>> [    1.419735] 5fa0:                                     00000000 00000000 00000000 00000000
>> [    1.419979] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    1.420222] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [    1.420501] Code: 13570000 e1a06000 0a000043 e3a03002 (e5c03000)
>> [    1.420874] ---[ end trace 0000000000000000 ]---
>>
>> ---
>> # bad: [7643a9ca9f8e08f71e15f89dd74863635e981e03] ARM: pxa: convert to multiplatform
>> # good: [3123109284176b1532874591f7c81f3837bbdc17] Linux 5.18-rc1
>> git bisect start 'HEAD' 'v5.18-rc1'
>> # good: [9b03d7f95bd4d97101ecb8ea1e822103b81fdb2d] ARM: pxa: mainstone-wm97xx: use gpio lookup table
>> git bisect good 9b03d7f95bd4d97101ecb8ea1e822103b81fdb2d
>> # good: [764063eee7620ea9abb940068a7ad0e7f9efa1b6] cpufreq: pxa3: move clk register access to clk driver
>> git bisect good 764063eee7620ea9abb940068a7ad0e7f9efa1b6
>> # good: [5153474f0a4388b7ddb59add4be73bfb42b2007f] ARM: mmp: remove tavorevb board support
>> git bisect good 5153474f0a4388b7ddb59add4be73bfb42b2007f
>> # good: [2746f7c78b428c8b01b691a29a972c08101ae343] ARM: PXA: fix multi-cpu build of xsc3
>> git bisect good 2746f7c78b428c8b01b691a29a972c08101ae343
>> # good: [73d5106e9489464eac84362705e93bcf3b376123] ARM: pxa: remove support for MTD_XIP
>> git bisect good 73d5106e9489464eac84362705e93bcf3b376123
>> # first bad commit: [7643a9ca9f8e08f71e15f89dd74863635e981e03] ARM: pxa: convert to multiplatform
> 
> I'll back out this patch for now while investigating further.
> 
> Which machine did you hit this on? Is this on hardware or in qemu?
> 
qemu, as always. borzoi, spitz, terrier, tosa, z2, and sx1 fail.
Also, I just noticed that the failure is not always the same.
z2 fails to boot from initrd, and sx1 fails to boot completely.
I'll do another round of bisects.

Guenter

>         Arnd

