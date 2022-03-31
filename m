Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC74ED417
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiCaGsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiCaGr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:47:59 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D718512BFA1;
        Wed, 30 Mar 2022 23:46:11 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nZoZN-0001DN-DM; Thu, 31 Mar 2022 08:46:09 +0200
Message-ID: <1e2d2e77-1b86-31ca-965b-c7678788877b@leemhuis.info>
Date:   Thu, 31 Mar 2022 08:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215726 - si2157.c: mention name of the missing firmware file
Content-Language: en-US
To:     Piotr Chmura <chmooreck@gmail.com>,
        Robert Schlabbach <robert_s@gmx.net>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <5f660108-8812-383c-83e4-29ee0558d623@leemhuis.info>
 <trinity-2ca61ae4-4f05-454d-94fd-d41e1afbec2f-1648581688394@3c-app-gmx-bs54>
 <1fc02de2-890e-e8e8-0ab6-aba62a333de5@leemhuis.info>
 <2ce6dc15-51a8-e59c-26ab-4380cdca6209@gmail.com>
 <703ad976-a504-eded-41b6-cd4f9f74e8df@leemhuis.info>
 <ae3864ac-b4f0-01a6-b3ed-75fa53ab3b95@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ae3864ac-b4f0-01a6-b3ed-75fa53ab3b95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1648709171;72a1937c;
X-HE-SMSGID: 1nZoZN-0001DN-DM
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.22 17:47, Piotr Chmura wrote:
> W dniu 30.03.2022 o 12:44, Thorsten Leemhuis pisze:
>> On 30.03.22 12:35, Piotr Chmura wrote:
>>> W dniu 30.03.2022 o 11:55, Thorsten Leemhuis pisze:
>>>> On 29.03.22 21:21, Robert Schlabbach wrote:
>>>>> the patch linked in the bugzilla ticket:
>>>>> https://lore.kernel.org/linux-media/6f84b7f4-3ede-ae55-e99b-a9d4108c80e2@gmail.com/
>>>>>
>>>>>
>>>>> should indeed fix the issue.
>>>> Ahh, the comment mentioning it was added shortly after I sent my mail.
>>>> #regzbot monitor:
>>>> https://lore.kernel.org/linux-media/6f84b7f4-3ede-ae55-e99b-a9d4108c80e2@gmail.com/
>>>>
>>>>
>>>>
>>>> Adding Piotr, the patches' author to the CC, who also replied.
>>>>
>>>> BTW: that patch is afaics missing a Fixes tag specifying the culprit
>>>> and
>>>> a `Cc: stable@vger.kernel.org # 5.17.x` tag to make sure it's quickly
>>>> backported to the stable tree, as among others explained here:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/handling-regressions.rst
>>>>
>>>>
>>> Sorry for my inconvenience.
>> Don't worry, everything fine. In a case like...
>>
>>> I just fixed my device and wanted to share
>>> solution with the "world". I'm not familiar with all kernel development
>>> convention (yet).
>> ...this someone else should point such details out to the submitter
>> and/or add these tags when applying the patch.
>>
>> @Robert: Do you know which commit causes this regression and could tell
>> us for a proper Fixes: tag?
> Fixes: 1c35ba3bf97213538b82067acc0f23f18e652226

Just FYI, proper fixes tag usage is described here:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Hence in this case it should look like this:

Fixes: 1c35ba3bf972 ("media: si2157: use a different namespace for
firmware")

At this point it likely would be good to submit a v2 of the patch with
that Fixes tag, the Tested-by tag from Robert, the CC for stable
backports, and Link: tags linking to all known reports about this
problem (also described in above document), e.g. like this:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215726
Link:
https://lore.kernel.org/lkml/5f660108-8812-383c-83e4-29ee0558d623@leemhuis.info/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot introduced: 1c35ba3bf972

> Cheers,
> Piotr Chmura
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>
>> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
>> reports on my table. I can only look briefly into most of them and lack
>> knowledge about most of the areas they concern. I thus unfortunately
>> will sometimes get things wrong or miss something important. I hope
>> that's not the case here; if you think it is, don't hesitate to tell me
>> in a public reply, it's in everyone's interest to set the public record
>> straight.
>>
>>
>>>>> The error was that the rom_id and required
>>>>> fields were swapped in the table, so the non-zero rom_id was taken
>>>>> as a
>>>>> "true" required boolean value, thus incorrectly evaluating that the
>>>>> chip requires a firmware file to operate when in fact it does not.
>>>>> I have tested the patch and found it worked for me. But I do not know
>>>>> how to push this further along:
>>>>> https://patchwork.linuxtv.org/project/linux-media/patch/6f84b7f4-3ede-ae55-e99b-a9d4108c80e2@gmail.com/
>>>>>
>>>>>
>>>> Mauro, what's up here? The patch fixes a regression and thus afaics
>>>> should quickly find its way towards mainline to get it into the stable
>>>> tree, as explained in the (bran new) document linked above.
>>>>
>>>> Ciao, Thorsten
>>>>
>>>>> Gesendet: Dienstag, 29. März 2022 um 10:33 Uhr
>>>>> Von: "Thorsten Leemhuis" <regressions@leemhuis.info>
>>>>> An: "Antti Palosaari" <crope@iki.fi>, "Mauro Carvalho Chehab"
>>>>> <mchehab+huawei@kernel.org>, "Robert Schlabbach" <robert_s@gmx.net>
>>>>> Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
>>>>> az0123456@gmx.de, "Linux Media Mailing List"
>>>>> <linux-media@vger.kernel.org>, "Linux Kernel Mailing List"
>>>>> <linux-kernel@vger.kernel.org>
>>>>> Betreff: Bug 215726 - si2157.c: mention name of the missing firmware
>>>>> file
>>>>> Hi, this is your Linux kernel regression tracker.
>>>>>
>>>>> I noticed a regression report in bugzilla.kernel.org that afaics
>>>>> nobody
>>>>> acted upon since it was reported about a week ago, that's why I
>>>>> decided
>>>>> to forward it to the lists and all people that seemed to be relevant
>>>>> here. To quote from
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=215726 :
>>>>>
>>>>>> I get the following error messages when trying to use si2157.ko in
>>>>>> linux 5.17:
>>>>>> si2157 13-0060: found a 'Silicon Labs Si2157-A30 ROM 0x50'
>>>>>> si2157 13-0060: Can't continue without a firmware
>>>>>> I did work in linux 5.16.16 without a firmware file. Unfortunately
>>>>>> the driver does not tell me the name of the missing firmware file.
>>>>> Could somebody take a look into this? Or was this discussed somewhere
>>>>> else already? Or even fixed?
>>>>>
>>>>>
>>>
> 
> 
