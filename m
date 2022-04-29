Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93AA5152F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379803AbiD2RwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379808AbiD2Rv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:51:58 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E046AD3D90;
        Fri, 29 Apr 2022 10:48:38 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id m11so9239827oib.11;
        Fri, 29 Apr 2022 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m5t7cdt/CWgC/r7ZaFwRZ/Pe0JhVgK8SGggmxnAqq8E=;
        b=OnQlHi3ErSMC6qSiLPAQK9tsaNNmGUsK/yx8P84vl8ZH25FjCToTTPCP6xYzUtp823
         nQu8zFOChn7TRclx0bhUluxvWGG31ISy3vYfQGsDQqCS3EjmUrqIVRNyq2psGtG3IDpi
         1W6Ytq3a5RYAKQBAidu7fUxQYTQpt+5vW3SEkCPANbWWQlmsLBqc9x1cEkbQPaLnW01H
         /gSIWuD7kQ5j7LODOU/HAxL6B5EQxZzhqJDbdqVUp7cmUle2rokPIwVHwnAzyzTxiKGl
         riWnsbp5SbzhiGJgU3qP8CBvVkoxV+4fTE0nup4rFZ2hllcAmSpZXHHWttMly/Jd1ESk
         NA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m5t7cdt/CWgC/r7ZaFwRZ/Pe0JhVgK8SGggmxnAqq8E=;
        b=udmPLQBOZ0l0YxVOjotvF9nbHe5bj0fFvHlEfo190PuI0Y0u0HSbhBqy8Y3WAFVMmc
         zU5QqximbdIUopnrej6PQSFEKvupe3fZIgRz1pEjegLnyrqguPoTaoLy0aHChaBFTAcG
         fWmDV93KiodLGEeM8Ysk7+FcvAI1YRUMlNR6wGFUYT9Kq+4tkLd1TR2eA6gaxXW/XBNN
         MV3d0//EYER7AzemZWUeWestg/pOil66ViLoX5lrp8b4pyUHswsIGssCQ//TJtPre7mV
         GR/ELhsXBJAKuWXCY5QELuHRDRmdrbvg4yZCS0uFjZt7XkIq1AuE6pmqkT0SxcDdiu87
         aVEg==
X-Gm-Message-State: AOAM533rAFbWNzed8JHj2loMEujnerVvJuj9A2OvVCDkgNcIXgwhoCAZ
        pzqfnobXL0AntLf1UXJXTXk=
X-Google-Smtp-Source: ABdhPJxkF8A90UBe5FIUXgDpVBp8codcF4hzbNyKrz59fIRSWDCgfC0jKHUvcyNxHQ5kW9qHkRB58A==
X-Received: by 2002:a05:6808:11ca:b0:2d4:6861:2a9e with SMTP id p10-20020a05680811ca00b002d468612a9emr282421oiv.114.1651254518245;
        Fri, 29 Apr 2022 10:48:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b7-20020a9d5d07000000b00605e7b6b19dsm1261051oti.39.2022.04.29.10.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 10:48:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net>
Date:   Fri, 29 Apr 2022 10:48:33 -0700
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
 <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net>
 <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
 <20220422234150.GA3442771@roeck-us.net>
 <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net>
 <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net>
 <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
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

On 4/28/22 06:44, Arnd Bergmann wrote:
> On Sun, Apr 24, 2022 at 8:48 PM Arnd Bergmann <arnd@kernel.org> wrote:
>> On Sun, Apr 24, 2022 at 5:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>> On 4/24/22 01:52, Arnd Bergmann wrote:
>>>> On Sun, Apr 24, 2022 at 4:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> into the defconfig file, otherwise the multiplatform target defaults to
>>>> an ARMv7 instead of ARMv5 build. For an OMAP15xx as in the SX1,
>>>> you also need to enable CONFIG_ARCH_MULTI_V4T.
>>>>
>>>> This is slightly unfortunate, but I don't see any way to avoid it, and the
>>>> modified defconfig will still work fine with older kernel trees.
>>>>
>>>
>>> Yes, that works. I changed it in my configuration.
>>
>> Ok, great!. I managed to boot the z2 machine with PCMCIA support
>> and it gets around the issue with my patch, correctly detecting the
>> CF card.
> 
> Hi Guenter,
> 
> I have now sent out a fix that I'm happy with, and applied it to the
> pxa-multiplatform-5.18 branch of the soc tree as well as the
> combined arm/multiplatform tree.
> 
> I have not merged this new version into the for-next branch
> since I would like to see if there are any other regressions first.
> 
> Can you run your boot tests on the arm/multiplatform branch
> and let me know if that fixes everything you found? If that
> takes a lot of manual steps on your side, I'd just wait for the
> build bots and merge it after all there are no new compile-time
> issues.
> 

I tried the pxa-multiplatform-5.18 branch. Its failures match
those in v5.18-rc1.

Should I try soc/arm/multiplatform as well ?

Guenter
