Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E08E517C1E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiECC7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiECC7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:59:10 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AA2BCB;
        Mon,  2 May 2022 19:55:39 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id e189so17022318oia.8;
        Mon, 02 May 2022 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=ML+ALf4muC9UINFB1D+jUSUaT6Yc1q590//LqncXPBg=;
        b=i7O9COFXjCPh9mubsfg4ugisxlHT5wiyH0MXCmkS/E9xJKUh9gtudd7mJOdt/lRU5s
         XviWqp4uUxdnstDiOc3faSUjpvZagNsoavB45X1ONbSZGvYwKqCS3Q4EtrJCw38BFSTy
         GfNBd7eRD5cCXw35f/BALZfCm/WuBWvrvy8CHiiL2yrOPGPoRYnxiuE92NR59Xn+HZB5
         KmWN9JXFhIw1dIK45cEVSlCPHBcxANoVGaomRAUVkCZ8j7FysnRmKK/nqDi0QqiAU5qN
         jRYD07RpfwKLRhTaIOHoyPVauNdPj2DaFQwX8xWbJUP/uVrx5krbwy8PAtKyqKnZh5Fk
         0gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=ML+ALf4muC9UINFB1D+jUSUaT6Yc1q590//LqncXPBg=;
        b=AScAAAfQBs5jsGUnRtMO/HXUdbYQCM4L4yz1STlLCOHqWzq8GhLjJj0QEtr+mHwZzC
         UR1hGujcZmtfqB50KWZgDd3N8rcbx+rhLdM1Nsax+a7HdWyOaVsSYEmxKSW4ZyIGJlBE
         1XoW7E5Q+/Ft6MK2sdqL96H0vQTLq9QuhiX4g7Pgh3cx1FPTowE47zfEf8Hh7ycIxROO
         D9eL5Cs63VjeA/iZfkGd0nMYrMkshj2LXcuI5XeGbWjxVREGgkFBNyafTbeSze4rVa0d
         qy8Wzda0Yby76G5FfylPPaP2eq00jPzZIMzKC6/DQcZdk5a+Zd0BFk+cEUKojzPgqBLy
         2Nww==
X-Gm-Message-State: AOAM5317zaNYQN8hD2cFd2BVU8Nmj/xVpO+LojrlUdYdHny8dK/KzJh9
        g/g1lqIKcw5nP91qVU3wmT8=
X-Google-Smtp-Source: ABdhPJznbXpW7jRNt5UM7xwEtyewbcsNlzza6ofH1kXi3NQqMh/99I9VMArk+DRpxcBP+PFc4iZ78A==
X-Received: by 2002:a05:6808:1115:b0:2ec:e78e:3fc0 with SMTP id e21-20020a056808111500b002ece78e3fc0mr978131oih.207.1651546539238;
        Mon, 02 May 2022 19:55:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m17-20020a9d7e91000000b006060322126csm1564658otp.60.2022.05.02.19.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 19:55:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <04840b4f-5b9d-b29a-62f7-e5148d415313@roeck-us.net>
Date:   Mon, 2 May 2022 19:55:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
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
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net>
 <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net>
 <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
 <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
 <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net>
 <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
 <b13783aa-9225-d52a-3800-c97ad772688b@roeck-us.net>
 <CAK8P3a3S5OjkKq_u5FpnwzYv+0+typya6Z4MzTez5ZH+do00xQ@mail.gmail.com>
 <CAK8P3a3jiqf_zpBsZyvAb5ZtkwDa7KkqExqDAdpY_pYqkr_NgQ@mail.gmail.com>
 <4dcdbfe2-9edf-320b-d123-3b62c8b5e28e@roeck-us.net>
 <CAK8P3a0ogn1wgPBDHkT=Fb8ufA+y8Ax1Qov2-vRXfC08QqnrQA@mail.gmail.com>
 <c001d58e-9a78-6338-a533-d0f215b3dfd1@roeck-us.net>
 <CAK8P3a1X3YH0RqqmqgqFAaY94yreD-PfY-pvyMf+xU3nGeqvsg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
In-Reply-To: <CAK8P3a1X3YH0RqqmqgqFAaY94yreD-PfY-pvyMf+xU3nGeqvsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 14:03, Arnd Bergmann wrote:
> On Mon, May 2, 2022 at 10:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 5/2/22 12:21, Arnd Bergmann wrote:
>>>
>>
>> To boot from initrd:
>>
>> qemu-system-arm -M z2 -kernel \
>>        arch/arm/boot/zImage -no-reboot -initrd \
>>        rootfs-armv5.cpio --append \
>>        "panic=-1 slub_debug=FZPUA rdinit=/sbin/init console=ttyS0" -nographic \
>>        -monitor null -serial stdio
>>
>> where rootfs-armv5.cpio is from my repository at github.com.
>>
>> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/rootfs-armv5.cpio.gz
>>
> 
> Ok, that works here with any configuration, I don't see a regression.
> Could this be a problem with the size increase? The machine only has
> 32MB of RAM, so it's possible that the multiplatform-enabled kernel
> with DT support etc pushes it over the edge, especially with an initramfs.
> 

qemu puts initrd in the middle of available memory. With the image size
being ~1MB larger than with v5.18-rc, this is too much, and the kernel
overwrites part of initrd. This causes it to be corrupted.

It looks like that would have happened eventually, your patch series just
made it happen now. The kernel is just getting too large to run on such small
systems. I worked around the problem in my version of qemu by loading initrd
at the end of the (small) RAM. With that, I no longer see the boot failure.

Guenter
