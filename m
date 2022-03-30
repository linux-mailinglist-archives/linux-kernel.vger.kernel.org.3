Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4632C4EBED4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbiC3KgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbiC3KgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:36:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1098140CB;
        Wed, 30 Mar 2022 03:34:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so29132738lfa.12;
        Wed, 30 Mar 2022 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ritvBZs9U6ISn6YJS3TdS3OdiygpXsWSun+eyo5dlJs=;
        b=VOHFwiL3vwpxWUv+4jITr78r6hdvnNt85sn+GaZllBmAMnk91pGWUQW6PjQ1yh2Qlw
         +DKQ4c4hCS1HJjBH89pG9L989eikW+9pP/nxqdlyI1KuFPo5gEBBRyZAno2GBKPXqdIZ
         9RIbjxKGVIkLG+yikO+KaqvNtXYn0qYplXWBcmDi92itazIev7XGFXSBDRTNV3di3gOo
         eY2VlXXux4IFEalO9lc6pUDR8KnpoyxnyIfOgA5twMO9HFCHC6bY/ZkPTeLjCR+5QF1T
         KOFqv5oxoz62Xbc0I587pQSLXLuPgw58zoisNqjHlqKn4i3B+9XYRHVdm9lLVHgCCVNU
         sVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ritvBZs9U6ISn6YJS3TdS3OdiygpXsWSun+eyo5dlJs=;
        b=8HUzAf1NpTQeOJuvcjRxn1s4wlj1pJNzLeoQf1eMlT9oL3NEy11z/BbP2lGoKN+C4B
         NmWcQ+xzzj/6DqJQl2YerGRaeDT1UVdhYw1Sw8SuHDUb3ECixz2hlTJPuRIj39aw6k/e
         93h+gvtsbq66E4/QossuvIU6q9A7CVNxpGza8WfiL2aplFJmDuGvjudC1a7ForOostVL
         gE0WWAPawMiE8gyD21SYs6DkYYUT80b5k6ELunGyibSBJ45d+WckmJHVhIVd/W08kvw0
         vr/OQbmpZLAz5LL/1z+z8WVjjcCYqeNcB44xJTjMXYmbAvrP8SfrQoKcTW2H44BPVnzG
         2/Og==
X-Gm-Message-State: AOAM533MH2Fe+kET02LpWmRjAGFrjHC5OXtvnqsX/BEO5BC0KxKtuCxG
        gh+S3MmvxYwJyRZZvsWBQpo=
X-Google-Smtp-Source: ABdhPJxL1bgQYWPDIg4rQk9Rs2U6xYYJ/5T68Dc6bqqyi7t+V8gHEI0u/fqO3kMgwwG5FGtFnPLPkw==
X-Received: by 2002:a05:6512:3f04:b0:44a:8de0:15a5 with SMTP id y4-20020a0565123f0400b0044a8de015a5mr6382946lfa.278.1648636452963;
        Wed, 30 Mar 2022 03:34:12 -0700 (PDT)
Received: from [192.168.1.105] (235.132.246.94.ip4.artcom.pl. [94.246.132.235])
        by smtp.gmail.com with ESMTPSA id a4-20020a19ca04000000b0044a97178a1esm982995lfg.201.2022.03.30.03.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 03:34:12 -0700 (PDT)
Message-ID: <2ce6dc15-51a8-e59c-26ab-4380cdca6209@gmail.com>
Date:   Wed, 30 Mar 2022 12:35:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215726 - si2157.c: mention name of the missing firmware file
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Robert Schlabbach <robert_s@gmx.net>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5f660108-8812-383c-83e4-29ee0558d623@leemhuis.info>
 <trinity-2ca61ae4-4f05-454d-94fd-d41e1afbec2f-1648581688394@3c-app-gmx-bs54>
 <1fc02de2-890e-e8e8-0ab6-aba62a333de5@leemhuis.info>
From:   Piotr Chmura <chmooreck@gmail.com>
In-Reply-To: <1fc02de2-890e-e8e8-0ab6-aba62a333de5@leemhuis.info>
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


W dniu 30.03.2022 o 11:55, Thorsten Leemhuis pisze:
> On 29.03.22 21:21, Robert Schlabbach wrote:
>> the patch linked in the bugzilla ticket:
>> https://lore.kernel.org/linux-media/6f84b7f4-3ede-ae55-e99b-a9d4108c80e2@gmail.com/
>> should indeed fix the issue.
> Ahh, the comment mentioning it was added shortly after I sent my mail.
> #regzbot monitor:
> https://lore.kernel.org/linux-media/6f84b7f4-3ede-ae55-e99b-a9d4108c80e2@gmail.com/
>
> Adding Piotr, the patches' author to the CC, who also replied.
>
> BTW: that patch is afaics missing a Fixes tag specifying the culprit and
> a `Cc: stable@vger.kernel.org # 5.17.x` tag to make sure it's quickly
> backported to the stable tree, as among others explained here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/handling-regressions.rst
Sorry for my inconvenience. I just fixed my device and wanted to share 
solution with the "world". I'm not familiar with all kernel development 
convention (yet).

>
>> The error was that the rom_id and required
>> fields were swapped in the table, so the non-zero rom_id was taken as a
>> "true" required boolean value, thus incorrectly evaluating that the
>> chip requires a firmware file to operate when in fact it does not.
>> I have tested the patch and found it worked for me. But I do not know
>> how to push this further along:
>> https://patchwork.linuxtv.org/project/linux-media/patch/6f84b7f4-3ede-ae55-e99b-a9d4108c80e2@gmail.com/
> Mauro, what's up here? The patch fixes a regression and thus afaics
> should quickly find its way towards mainline to get it into the stable
> tree, as explained in the (bran new) document linked above.
>
> Ciao, Thorsten
>
>> Gesendet: Dienstag, 29. März 2022 um 10:33 Uhr
>> Von: "Thorsten Leemhuis" <regressions@leemhuis.info>
>> An: "Antti Palosaari" <crope@iki.fi>, "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>, "Robert Schlabbach" <robert_s@gmx.net>
>> Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, az0123456@gmx.de, "Linux Media Mailing List" <linux-media@vger.kernel.org>, "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
>> Betreff: Bug 215726 - si2157.c: mention name of the missing firmware file
>> Hi, this is your Linux kernel regression tracker.
>>
>> I noticed a regression report in bugzilla.kernel.org that afaics nobody
>> acted upon since it was reported about a week ago, that's why I decided
>> to forward it to the lists and all people that seemed to be relevant
>> here. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215726 :
>>
>>> I get the following error messages when trying to use si2157.ko in linux 5.17:
>>> si2157 13-0060: found a 'Silicon Labs Si2157-A30 ROM 0x50'
>>> si2157 13-0060: Can't continue without a firmware
>>> I did work in linux 5.16.16 without a firmware file. Unfortunately the driver does not tell me the name of the missing firmware file.
>> Could somebody take a look into this? Or was this discussed somewhere
>> else already? Or even fixed?
>>
>>

