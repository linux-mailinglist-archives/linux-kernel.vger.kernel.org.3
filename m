Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0230E4EC8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348396AbiC3Puu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348355AbiC3Pus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:50:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B286A33EAC;
        Wed, 30 Mar 2022 08:49:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id g24so28242413lja.7;
        Wed, 30 Mar 2022 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dq8xdoLIR4aRi6FkMb+20PWNHqW1rgCenoTdxXhapeQ=;
        b=iEUFe0ObPg8qK8j1JvE8RRHyMghNpiQQxXbwvFtCunM0DqR7JYxOXqAOFS1X8FIvbv
         Q0jwBAhjoA+FCfJRj/ifJ6BIzHZ5UKMGa5lStV8/Zlix0V2PFNBYjg2ne7WOoN5gp7pR
         zW54GurfJQHFF3EeUxPZaHLDciSPnu7ij6ScQ2e7MSDo1eHy5ZYxLMnhZk3+NHmNirmq
         l4Aa3/++C8AC6ykYazwoLvj//FQqUoBJmaC/STCqoAeYw7rXRXOg0MO49PZAPbxM0bff
         kUnbDar1asklrk1T3evqldCGliH96rQ105mc2qE4KOaRpWY9I5BsWY6miPMwsqPfLgvt
         DIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dq8xdoLIR4aRi6FkMb+20PWNHqW1rgCenoTdxXhapeQ=;
        b=RmiRzmoCQ4jOrNSX1R/BWE9vsg078XaGlyp4FA5UJNBx34OflGbqrgv+VsNDlDXNZg
         KttzKwRTHU/3k8DdlfVGLfxsS4498wz2cWIyexMsVboOLh7GBRvyzia90wcEzs+vMdZ7
         FBVU4hSnkThLNsDGfT1lzVr7gv2Lkg8Yw023wzNZP10O2UUWbke+1nmnHDT51QmsxSfD
         Nb++GeWFFgOaRWG0pL9zzp4s1AXlf80MFHCOoewr705z3TKcXQ8NFiBl6HWeE4aLoAlf
         cXOJwxrEhoEgro9+Jy2q0ijlqfRPiOnYLD5HMuzoOPY9gMDojx7xEFJZeL0m2fA8DCVE
         yYGg==
X-Gm-Message-State: AOAM531Wr01gm87+GzcCPNw4C/Tjpi/LvBzkUNiTUzuLoXSnLthhHnN8
        I/GhzV5Dd/VSF9+4R0zVQyM=
X-Google-Smtp-Source: ABdhPJyUOGgz9ZqjEOkltDEfzpulzR5+n7lOLWprzDlNwq2ielugYc/3nwzAT2zYEJY6zDunh4PM6Q==
X-Received: by 2002:a05:651c:204:b0:249:832a:12b with SMTP id y4-20020a05651c020400b00249832a012bmr7201978ljn.473.1648655332642;
        Wed, 30 Mar 2022 08:48:52 -0700 (PDT)
Received: from [192.168.1.2] (235.132.246.94.ip4.artcom.pl. [94.246.132.235])
        by smtp.googlemail.com with ESMTPSA id w22-20020a2e9996000000b00249824260f8sm2413038lji.25.2022.03.30.08.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 08:48:52 -0700 (PDT)
Message-ID: <ae3864ac-b4f0-01a6-b3ed-75fa53ab3b95@gmail.com>
Date:   Wed, 30 Mar 2022 17:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215726 - si2157.c: mention name of the missing firmware file
Content-Language: pl-PL
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Robert Schlabbach <robert_s@gmx.net>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5f660108-8812-383c-83e4-29ee0558d623@leemhuis.info>
 <trinity-2ca61ae4-4f05-454d-94fd-d41e1afbec2f-1648581688394@3c-app-gmx-bs54>
 <1fc02de2-890e-e8e8-0ab6-aba62a333de5@leemhuis.info>
 <2ce6dc15-51a8-e59c-26ab-4380cdca6209@gmail.com>
 <703ad976-a504-eded-41b6-cd4f9f74e8df@leemhuis.info>
From:   Piotr Chmura <chmooreck@gmail.com>
In-Reply-To: <703ad976-a504-eded-41b6-cd4f9f74e8df@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 30.03.2022 o 12:44, Thorsten Leemhuis pisze:
> On 30.03.22 12:35, Piotr Chmura wrote:
>> W dniu 30.03.2022 o 11:55, Thorsten Leemhuis pisze:
>>> On 29.03.22 21:21, Robert Schlabbach wrote:
>>>> the patch linked in the bugzilla ticket:
>>>> https://lore.kernel.org/linux-media/6f84b7f4-3ede-ae55-e99b-a9d4108c80e2@gmail.com/
>>>>
>>>> should indeed fix the issue.
>>> Ahh, the comment mentioning it was added shortly after I sent my mail.
>>> #regzbot monitor:
>>> https://lore.kernel.org/linux-media/6f84b7f4-3ede-ae55-e99b-a9d4108c80e2@gmail.com/
>>>
>>>
>>> Adding Piotr, the patches' author to the CC, who also replied.
>>>
>>> BTW: that patch is afaics missing a Fixes tag specifying the culprit and
>>> a `Cc: stable@vger.kernel.org # 5.17.x` tag to make sure it's quickly
>>> backported to the stable tree, as among others explained here:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/handling-regressions.rst
>>>
>> Sorry for my inconvenience.
> Don't worry, everything fine. In a case like...
>
>> I just fixed my device and wanted to share
>> solution with the "world". I'm not familiar with all kernel development
>> convention (yet).
> ...this someone else should point such details out to the submitter
> and/or add these tags when applying the patch.
>
> @Robert: Do you know which commit causes this regression and could tell
> us for a proper Fixes: tag?
Fixes: 1c35ba3bf97213538b82067acc0f23f18e652226

Cheers,
Piotr Chmura
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
>
>
>>>> The error was that the rom_id and required
>>>> fields were swapped in the table, so the non-zero rom_id was taken as a
>>>> "true" required boolean value, thus incorrectly evaluating that the
>>>> chip requires a firmware file to operate when in fact it does not.
>>>> I have tested the patch and found it worked for me. But I do not know
>>>> how to push this further along:
>>>> https://patchwork.linuxtv.org/project/linux-media/patch/6f84b7f4-3ede-ae55-e99b-a9d4108c80e2@gmail.com/
>>>>
>>> Mauro, what's up here? The patch fixes a regression and thus afaics
>>> should quickly find its way towards mainline to get it into the stable
>>> tree, as explained in the (bran new) document linked above.
>>>
>>> Ciao, Thorsten
>>>
>>>> Gesendet: Dienstag, 29. März 2022 um 10:33 Uhr
>>>> Von: "Thorsten Leemhuis" <regressions@leemhuis.info>
>>>> An: "Antti Palosaari" <crope@iki.fi>, "Mauro Carvalho Chehab"
>>>> <mchehab+huawei@kernel.org>, "Robert Schlabbach" <robert_s@gmx.net>
>>>> Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
>>>> az0123456@gmx.de, "Linux Media Mailing List"
>>>> <linux-media@vger.kernel.org>, "Linux Kernel Mailing List"
>>>> <linux-kernel@vger.kernel.org>
>>>> Betreff: Bug 215726 - si2157.c: mention name of the missing firmware
>>>> file
>>>> Hi, this is your Linux kernel regression tracker.
>>>>
>>>> I noticed a regression report in bugzilla.kernel.org that afaics nobody
>>>> acted upon since it was reported about a week ago, that's why I decided
>>>> to forward it to the lists and all people that seemed to be relevant
>>>> here. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215726 :
>>>>
>>>>> I get the following error messages when trying to use si2157.ko in
>>>>> linux 5.17:
>>>>> si2157 13-0060: found a 'Silicon Labs Si2157-A30 ROM 0x50'
>>>>> si2157 13-0060: Can't continue without a firmware
>>>>> I did work in linux 5.16.16 without a firmware file. Unfortunately
>>>>> the driver does not tell me the name of the missing firmware file.
>>>> Could somebody take a look into this? Or was this discussed somewhere
>>>> else already? Or even fixed?
>>>>
>>>>
>>

