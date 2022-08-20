Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54359AFCF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 21:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiHTTAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiHTTAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:00:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ED6C69;
        Sat, 20 Aug 2022 12:00:35 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id e2so2390681ljj.1;
        Sat, 20 Aug 2022 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=uqGDkOSDG1Pr07DLwE5f87ASglb6oZGJd5cxuniMgsE=;
        b=cMSeXodxEyfye7aJHDaiRk1QQ+69zH1V1CqjaEU5gnNk8qXJ2R9RRmYXU/FRmW7cNy
         8QQxBNW32rKuc4G6Xj9bIJbhr3Y6uw4+irqYotoS6pT/hf9r8DLHsr3Xq6+kFi0bFBHO
         FBY2Gr3Ln1dFxTLSVZI8X9pAprSoHp+IyGi/6wYudoF+e81NB2YUjDqcPQyNh0qTC03w
         X7L9fwFqNNJzRDLnHVEWiKmMZNE9KaoDjwHfQ0olTt+UZe67cpQTJ7uv4BBHuwQ6WGLd
         zJyLeZhTbntEAAD/pm46koRi7OyAWi0siMdR+IGRKv6KZjmVQOhfIG4UC7KQ6Z4lnVqJ
         uZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uqGDkOSDG1Pr07DLwE5f87ASglb6oZGJd5cxuniMgsE=;
        b=3F237KcXHFx7onqPcvtT5Pa9/Eb0z8JVGe0q7AmzhpcH9QKGZC340bhgt28xr13WPB
         xkJIvAm1RfWDU8LMRjbmtiXTvYxdZPhm4fnh77x0z05I56HoUSqAKVGdW+VO86ETkxyz
         SNSv7FxfFPh9U0UfqFFUQTvJhkUo1U3aqnvdjDlXtmk1Cz+t5Bsl1+AawKFyzfCHDvs0
         yU0cK7/o4rBzz1W+4eCLBUA4BXtBKOmiNa4zwLYtY9fDHIweM3GsS0oiv2fVnevOESAu
         p/n/R5kaemBozEnvrZh4eMD8EDqcibhj1zq4GXjumMw+C2utUkaAN+4lkgJ9/7KPBpv1
         tFvA==
X-Gm-Message-State: ACgBeo2JB7ZhjINXFshe8mklBm11qdfbeDXIm1uj3iyDJYfGWz+AAvz2
        SofhWY8tgFvGqRSEnTutifM=
X-Google-Smtp-Source: AA6agR5ZXkfcG0e+cOE6XkP+iasPN2aVE6R2aH0d3WnhsjTCS8F6LKKgVXytySHfkkESrj3/DKBAiw==
X-Received: by 2002:a2e:a784:0:b0:25f:dcd4:53fb with SMTP id c4-20020a2ea784000000b0025fdcd453fbmr4008605ljf.159.1661022033456;
        Sat, 20 Aug 2022 12:00:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id a14-20020a05651c030e00b0025e728764ebsm789836ljp.105.2022.08.20.12.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 12:00:32 -0700 (PDT)
Message-ID: <103abfae-6c0d-9a2e-2d59-0da4c8be3eb4@gmail.com>
Date:   Sat, 20 Aug 2022 22:00:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
 <20220820122120.57dddcab@jic23-huawei>
 <412c5d22-d59b-9191-80dd-e3ca11360bc4@gmail.com>
 <CAHp75VdoKtc2QqFcDuJ00KBz6mjg0fnM_WhyVqhCmDVo_3K6kg@mail.gmail.com>
 <01fec744-f3d4-b633-d3ce-bcd86a153132@gmail.com>
 <CAHp75Vd3vyAZbWpZT9SmyD=ecGTAdVNWK=fs_n4OSAqGtGj_gg@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
In-Reply-To: <CAHp75Vd3vyAZbWpZT9SmyD=ecGTAdVNWK=fs_n4OSAqGtGj_gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/22 20:41, Andy Shevchenko wrote:
> On Sat, Aug 20, 2022 at 8:30 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> On 8/20/22 19:09, Andy Shevchenko wrote:
>>> On Sat, Aug 20, 2022 at 4:45 PM Matti Vaittinen
>>> <mazziesaccount@gmail.com> wrote:
>>>> On 8/20/22 14:21, Jonathan Cameron wrote:
>>>>> On Fri, 19 Aug 2022 22:19:17 +0300
>>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> ...
> 
>>>>> For the whole static / vs non static. My personal preference is not
>>>>> to have the static marking but I don't care that much.
>>>>
>>>> I'd like to stick with the static here. I know this one particular array
>>>> does not have much of a footprint - but I'd like to encourage the habit
>>>> of considering the memory usage. This discussion serves as an example of
>>>> how unknown the impact of making const data static is. I didn't know
>>>> this myself until Sebastian educated me :)  Hence my strong preference
>>>> on keeping this 'static' as an example for others who are as ignorant as
>>>> I were ;) After all, having const data arrays static is quite an easy
>>>> way of improving things - and it really does matter when there is many
>>>> of arrays - or when they contain large data.
>>>
>>> But still the same comment about global scope of the variable is applied.
>>
>> I don't understand why you keep claiming the variable is global when it
>> is not?
> 
> It is. The static keyword makes it global, but putting the entire
> definition into the function is asking for troubles.
> 

Please, describe the trouble we can get with a local static const 
variable? A real concrete threat there is. I have explained the benefit. 
I have also explained the concrete possibility of name collision when we 
really do a global out of local.

> I guess some C standard chapter describes that in non-understandable language.
> 
>>> As I explained before, hiding global variables inside a function is a
>>> bad code practice.
>>
>> I don't really get what you mean here. And I definitely don't see any
>> improvement if we would really use a global variable instead of a local one.
> 
> The improvement is avoid hiding the global variable to the local namespace.

I guess you mean that you may miss the fact that a variable stays there 
even after execution exits the function, right? Ok, let's assume someone 
misses this point when reading the code. Now, please describe me the 
potential issues this can cause knowing our static is const and doesn't 
change the value.

Best Regards
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
