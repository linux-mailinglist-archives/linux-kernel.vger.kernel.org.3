Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92465158DC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381717AbiD2XMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381689AbiD2XMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:12:46 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C384EC8;
        Fri, 29 Apr 2022 16:09:26 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s131so10060528oie.1;
        Fri, 29 Apr 2022 16:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=43bhXKjvki5l9d/uYFdijwNa1GUErzr1H3q463hR+XU=;
        b=OUSt6wkRUbg0ovBrwSGrseeTfVqA3atJE26IGGL8DNDKMbVWyzV7fWqixesYb9S/mA
         rgBp/vgWVmZ/2SlxqdaVKFisC/DX2eo4pEgNEmTUveV61siwDvexnXReKJ4KInzJ+JVf
         qFRYIk57Zf7KE5IqQd6E9kuwLyNvXqeY18u9sXPldsZHCbpZQ9kw31XwNt/jpYsmggt1
         3DzogSdIaSMtewj0hqjuAW3EwbG0+z+yCYsMAftASTL8pYSQ3/TIzpEEpEvE1aCdKITD
         c0o8+XWDHiHzhST5JtA4/c6tGuJLD552k5cdjIV4SeeCvbAOGItN9qS8zGZ2A17U8O+I
         msTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=43bhXKjvki5l9d/uYFdijwNa1GUErzr1H3q463hR+XU=;
        b=mT2oX+us+jAjxxNCRAJwVItXzD9LCXnKAwnPlt3aIz/DOTvh4zEJ7csNhtctH1hi3N
         QaU2rmb3tV1C4TnbhRCsu+FuOB5Y+syVxgRa13zFZZbydkiidaJ1jeAOlqP8rugq+A4o
         3E7/GcQLpEYkxWRUPddwjYgLvuJaXIWys6nABTZK7592NBLfDysn94vUCV1dHO/q9eIh
         GyJeTxQNl0BgkbD8rAHINhr+dESERaMYN07cyxzU547ZJGRIfoFZO2ClfRWOEghmPRAe
         MhPpsaM9OxMzIE6PNVPrg1XTXD6hpDSg6hocSqTPLPMWkDpUTsQTmFMe7VrmiklJS4f6
         I3Aw==
X-Gm-Message-State: AOAM532b+VCyaP8EQwBbr+0jiSGuVCIm00hhDNz+IOPB97TXHu8yz44/
        tT1gdgA7aGoG24sCARBJ99s=
X-Google-Smtp-Source: ABdhPJwXwAJF7RkFvU52UI/VP0gJxz700pwOLyrX7CYTkoQTpT4bc4rvMjOD84iMZwh8LrG+2Nl3bg==
X-Received: by 2002:a05:6808:17a7:b0:325:c561:31fb with SMTP id bg39-20020a05680817a700b00325c56131fbmr1544693oib.75.1651273765807;
        Fri, 29 Apr 2022 16:09:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w1-20020a9d77c1000000b0060603221242sm230484otl.18.2022.04.29.16.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 16:09:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net>
Date:   Fri, 29 Apr 2022 16:09:19 -0700
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
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net>
 <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
 <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
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

On 4/29/22 14:46, Arnd Bergmann wrote:
> On Fri, Apr 29, 2022 at 10:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 4/29/22 10:48, Guenter Roeck wrote:
>>>
>>> I tried the pxa-multiplatform-5.18 branch. Its failures match
>>> those in v5.18-rc1.
>>>
>>
>> Uuh, wait, the build wasn't complete. There are still some
>> failures. I'll report later.
> 
> Sorry about the breakage, I got a few more reports about minor build errors
> and warnings, the newly uploaded branches should address all of the ones
> I got reports for.
> 

Unless I am missing something the failures are the same as before. See
https://kerneltests.org/builders/qemu-arm-testing/builds/74/steps/qemubuildcommand/logs/stdio

This is with v5.18-rc1-49-ge8ab9a9a2745 which is the tip of
soc/pxa-multiplatform-5.18.

Should I check a different branch ?

Thanks,
Guenter
