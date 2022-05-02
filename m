Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410E517441
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiEBQ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiEBQ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:29:47 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CEB7642;
        Mon,  2 May 2022 09:26:18 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q8so15268881oif.13;
        Mon, 02 May 2022 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=64QIA6q/Jq1SXZtvXAHmkaqaem8y9EOcss9DFzQHU9s=;
        b=lSCTdreNcz/0Ozt6K1HBv4cRzX5rD5YkQNxljOsfS8tDiCYDoI+IPMQxP7X/EZIUm6
         nEUbOImYvwji0WLPLOr7WKakqkxdg7JpvGJPTfUXZcQQCuBLI6CBT8jIjTQ6snEColp+
         42NQ0U8dK6CrK0vLyvJNfr+ZWyi1wOVvde/g8GkgMS8kO99Le/sMzMeHcBDeFPgZnh0r
         LROiIiUnXvzBr+1b680itD4douFeeTEs3uEVAyKivH87Mp4cNraXu5PlswZdijptsHiy
         E/tGZIauqoE0htLx1qKBecZCr69Lv4Vi0nEVaQXlcbRczQ9R4I77j4rRVkbcch1Z44Nq
         l6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=64QIA6q/Jq1SXZtvXAHmkaqaem8y9EOcss9DFzQHU9s=;
        b=kNapBUcPZwXpLZ3g9kNgyu9Z5XM9RnsUEVkTsYSXqmuPJC4KNEHppWIsd2zkCGKnuo
         N9kGqkMKnEAGbB4eOeVqQ2BimR//z9O91gzQNzylBIDoSVIng/ejs+fHd3o2N2KrfV2X
         BdMooJZTCzIno50wqD8Ot6L2FfK27Ccmz9haJ835eCTF8iMEXrWNHESQVM0dgKu8ojo1
         GB19Is4FiQD5MvomPb29ddCxDcNNbchEX9fjyosfUjDIZvgCc9mhniFjF2YZjsjz6dNI
         OP5T+u/y2liR03ufp6TnVg+mJnS1wzeIG6UiGQjUpVGSO01LYxkM7Rk4ZCcKMTfHXkfR
         hzXQ==
X-Gm-Message-State: AOAM531rbeQB9qw40jfeG0QqNsgp7Cv7nCBQvWtWQBeGpvHmHFRHP3l3
        HqhMTF/5mJtrYEvCmax77UM=
X-Google-Smtp-Source: ABdhPJw9C3TtXs+N7Y0xL4doHaW0x+AFJyxcg+z0+P8jqToBpOw3SVN62D2BXqS+EDk7pkn5yUYINw==
X-Received: by 2002:a05:6808:140f:b0:322:cbe9:8d29 with SMTP id w15-20020a056808140f00b00322cbe98d29mr7789910oiv.220.1651508777476;
        Mon, 02 May 2022 09:26:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l39-20020a0568302b2700b0060603221256sm3008945otv.38.2022.05.02.09.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 09:26:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4dcdbfe2-9edf-320b-d123-3b62c8b5e28e@roeck-us.net>
Date:   Mon, 2 May 2022 09:26:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
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
 <20220422234150.GA3442771@roeck-us.net>
 <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net>
 <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
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
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAK8P3a3jiqf_zpBsZyvAb5ZtkwDa7KkqExqDAdpY_pYqkr_NgQ@mail.gmail.com>
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

On 4/30/22 07:23, Arnd Bergmann wrote:
> On Sat, Apr 30, 2022 at 3:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Sat, Apr 30, 2022 at 2:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>> On 4/30/22 01:04, Arnd Bergmann wrote:
>>>> and concluded that it must have done this for a long time. In my own qemu
>>>> instance, I see a crash from iWMMXt, but that works fine on your machine.
>>>> OTOH, your failed instances all look like they either time out or
>>>> failed to find a
>>>> rootfs. I tried passing an MMC device as root, and that works here.
>>>>
>>>
>>> Booting from mmc works for me as well. Booting from pcmcia worked before,
>>> so I assume that there must be some regression.
>>
>> Ok, got it, and managed to reproduce the hang now. My "ARM: pxa/sa1100: move
>> I/O space to PCI_IOBASE" patch managed to get it to the point of detecting
>> the pcmcia device instead of crashing, so I assumed it was enough when it
>> clearly was not. Before that patch, it still works, afterwards it hangs with
>> "pata_pcmcia: probe of 0.0 failed with error -12" as mentioned above. I'll
>> have another look.
> 
> Got it: as the PCMCIA bus on this machine is the only thing with an I/O space,
> I assigned it port number range 0-0x1000, with an io_offset of 0, but this
> was apparently unexpected and triggered this sanity check:
> 
> static int static_find_io(struct pcmcia_socket *s, unsigned int attr,
>                          unsigned int *base, unsigned int num,
>                          unsigned int align, struct resource **parent)
> {
>        if (!s->io_offset)
>                return -EINVAL;
>        ...
>        return 0;
> }
> 
> I moved the devices around now, giving zeus/viper I/O space an offset of
> zero, and moving PCMCIA to offset 0x10000 and 0x11000 for the two slots,
> which now works because the io_offset is nonzero. I've regenerated the
> branches again, and confirmed the for-next branch still boots from pcmcia.
> 


With v5.18-rc1-49-gcb813018b5c1, I still get:

[    0.797668] RAMDISK: Couldn't find valid RAM disk image starting at 0.
[    0.805262] /dev/root: Can't open blockdev
[    0.805487] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
[    0.805674] Please append a correct "root=" boot option; here are the available partitions:

when trying to boot z2 from initrd.

The other problems are gone.

Guenter
