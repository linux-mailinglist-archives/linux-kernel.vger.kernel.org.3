Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E6520A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiEJBTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiEJBTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:19:39 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC369FF1;
        Mon,  9 May 2022 18:15:42 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-edeb6c3642so16691283fac.3;
        Mon, 09 May 2022 18:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=22X08gP2t/xBpwhITJ9mR4vQg1Gu37dtwLleQ2erYOo=;
        b=StW4qPkcK9RbvFnzZLoWdVk3jigBeXgmsH12XrwYRbOjDYdRC71zb7O9NYfkCaM4mE
         WYWDNUYrIZ2+eE/fUat9FfFz3K4H9H94Xo3cxHprfDf1VbwjCMb6K/Ca5Ot8YKobnGHQ
         D6NlWYfCyScO3r3OQCSJbJFDJxiKsXGkl8hw7bAfsKqXazn/0wUViFDfc4bSDRyEqSnT
         9F/ETu4p3mjRsBR5fD2J36IjYzJXjb1XiGJgWqQjBsmYLWmMoBg9boataIWLQTPfKuk7
         ZobRb3V3LKRT2KWz3sCe6JQnnx38GTcvya1w5LnUivqv/dNBJ96B6f68Pvi/dhpj36pR
         5msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=22X08gP2t/xBpwhITJ9mR4vQg1Gu37dtwLleQ2erYOo=;
        b=sqqp/GlY4um1d3+EZ/ycPetZViVk5g9onZEIASKoJZUQyrd2iDDZ9NaQmo5Ta6K9jf
         AW8MF9SyGKrBbTTaL3ionUqaNDF9pOzVQbdMiRH5g8djrat/PMuJY7MaS2jOR1788+lt
         L8txW1254DuE/GR0YM8ibd+mNkci1k+RvtAxVnMFO7OehWE5BArL+jy1dvNcbGs/ioyQ
         0tJiDcqSihcvE9Dmyhmj+vClm7s8iKAQa09sWkHghTsKQMIWi7+GUJdjBn+423vShdoJ
         1AMNA+pZTrrTYH2i70gNNRnJAwP/2o7VOMfO7mJF7/eV7DOsZbjNvU/ZEXnTHtHA/eUD
         IdFw==
X-Gm-Message-State: AOAM5332IEq3vvpxMG82T/04fgo17uJNZJaQq7clYdbjbcaQwHplTib7
        IvKewubxb50lXLzECWROdwg=
X-Google-Smtp-Source: ABdhPJycVqB8+h80gi3HgKQjt7NAWhCSBlm+8crCvvvi9tnnLb0Ge/aQTD0/Mu8bEq4aENmTcvSI0Q==
X-Received: by 2002:a05:6870:a1a0:b0:e2:9331:cc30 with SMTP id a32-20020a056870a1a000b000e29331cc30mr8525902oaf.155.1652145342056;
        Mon, 09 May 2022 18:15:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x35-20020a4a97e6000000b0035eb4e5a6d2sm5516651ooi.40.2022.05.09.18.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 18:15:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e3c78109-8b5e-efe6-b817-2f62c8bc8b1f@roeck-us.net>
Date:   Mon, 9 May 2022 18:15:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Watchdog: sp5100_tco: Lower verbosity of disabled
 watchdog hardware
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Jerry.Hoemann@hpe.com
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, ionut_n2001@yahoo.com
References: <20220509163304.86-1-mario.limonciello@amd.com>
 <b394bfcf-9f0d-b27c-5bc0-3d628de98755@roeck-us.net>
 <20220510003339.GA2788@perchik.americas.hpqcorp.net>
 <b3e1e442-50ef-abd2-5dc8-1c9943ff34ca@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <b3e1e442-50ef-abd2-5dc8-1c9943ff34ca@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 17:37, Mario Limonciello wrote:
> On 5/9/22 19:33, Jerry Hoemann wrote:
>> On Mon, May 09, 2022 at 03:55:54PM -0700, Guenter Roeck wrote:
>>> On 5/9/22 09:33, Mario Limonciello wrote:
>>>> If watchdog hardware has been disabled, currently the kernel driver
>>>> will show at err level during probe:
>>>>
>>>> "Watchdog hardware is disabled"
>>>>
>>>> This is unnecessarily verbose as there is already a -ENODEV returned.
>>>> Lower the level to debug.
>>>
>>> Is it ? Without this message, a user may try to load the driver,
>>> get an error message, and have no idea why the driver was not
>>> enabled even though the hardware exists. If anything , -ENODEV
>>> is less than perfect. Unfortunately there does not seem to be
>>> a better error code, or at least I don't see one.
>>>
>>> Guenter
>>
>> Coincidentally, I was looking at this code on Friday.
>>
>> Some HPE Proliant servers are disabling the AMD WDT in BIOS.  However,
>> sp5100_tco was still getting configured.  It was the lack of
>> "Watchdog hardware is disabled" message that helped clue us into
>> what was going on (Linux is enabling the WDT anyway.)
>>
>> So, I liked that this message exists.
>>
>> I'll send an RFC patch for this other issue as it orthogonal.
>> But just wanted to point out the message is useful.
> 
> I personally don't have a problem blacklisting on a system I encounter this. I take anything at "err" level as there is a firmware problem or a hardware problem that should be looked at.
> 
> As the message is genuinely useful as Jerry points out how about meeting in the middle at info or notice?
> 

I really don't want to change it. It does point out a serious issue,
intentional or not. Anyone concerned or disturbed about the message
can easily block the module from loading, and others may rely on it.
 From driver perspective it _is_ an error, and it should be treated
as such.

Guenter
