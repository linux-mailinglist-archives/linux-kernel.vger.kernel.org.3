Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D491519D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348256AbiEDKvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbiEDKvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:51:17 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3138E1DA56
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:47:42 -0700 (PDT)
Received: from [2a02:8108:963f:de38:1b3c:6996:5378:f253]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nmCXk-00033E-42; Wed, 04 May 2022 12:47:40 +0200
Message-ID: <f42e91ae-a22d-b664-003a-e1698dc021aa@leemhuis.info>
Date:   Wed, 4 May 2022 12:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Regression in BinderFS: Kernel bug at binder.c:2352
Content-Language: en-US
To:     Todd Kjos <tkjos@google.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "quackdoctech@gmail.com" <quackdoctech@gmail.com>
References: <d62431af-5ce4-3d8f-542f-df8e7a7faaf1@leemhuis.info>
 <CAHRSSEw5CBnCpXcowKKG5KzOoazecC6jDn+4_fd0Gp3+e9Yixw@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAHRSSEw5CBnCpXcowKKG5KzOoazecC6jDn+4_fd0Gp3+e9Yixw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1651661262;95db0511;
X-HE-SMSGID: 1nmCXk-00033E-42
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.04.22 17:28, Todd Kjos wrote:
> On Fri, Apr 8, 2022 at 3:27 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> Hi, this is your Linux kernel regression tracker.
>>
>> Todd, seems there is a regression that is caused by one of your Linux
>> kernel changes:
> 
> Yes, it was reported a few days ago by the ChromeOS team. Already
> looking into it.

What happen to this? It looks like it has fallen through the cracks. Or
was progress made and it just didn't link to the ticket or mention the
reporter?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot poke

>> I noticed a regression report in bugzilla.kernel.org that afaics nobody
>> acted upon since it was reported about a week ago, that's why I decided
>> to forward it to the lists and all people that seemed to be relevant
>> here. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215795 :
>>
>>>  quackdoctech@gmail.com 2022-04-02 19:56:29 UTC
>>>
>>> Created attachment 300686 [details]
>>> Dmesg output cut to error
>>>
>>> Apologies if this should have been reported under Drivers where the source is, selftests has it listed under filesystems so I chose here. Using Waydroid which is android run via LXC, on android 10 the bug comes when trying to use video playback. I know of issues on android 11 but have not yet had the chance to get the logs from it. the issue does not occur in Linux kernel 5.16 series. but does occur on linux 5.17. the issue is confirmed on both Arch's linux-zen 5.17.1.zen1-1 kernel as well as some users reporting a fedora kernel with the issue.
>>>
>>> [reply] [−] Comment 1 quackdoctech@gmail.com 2022-04-03 19:38:37 UTC
>>>
>>> I've narrowed down the issue to this patch series.
>>>
>>> https://lore.kernel.org/all/20211130185152.437403-1-tkjos@google.com/
>>>
>>
>> Could somebody take a look into this? Or was this discussed somewhere
>> else already? Or even fixed?
>>
>> Anyway, to get this tracked:
>>
>> #regzbot introduced: v5.16..v5.17
>> #regzbot from: quackdoctech@gmail.com <quackdoctech@gmail.com>
>> #regzbot title: BinderFS: Kernel bug at binder.c:2352
>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215795
>>
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
>> --
>> Additional information about regzbot:
>>
>> If you want to know more about regzbot, check out its web-interface, the
>> getting start guide, and the references documentation:
>>
>> https://linux-regtracking.leemhuis.info/regzbot/
>> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
>> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
>>
>> The last two documents will explain how you can interact with regzbot
>> yourself if your want to.
>>
>> Hint for reporters: when reporting a regression it's in your interest to
>> CC the regression list and tell regzbot about the issue, as that ensures
>> the regression makes it onto the radar of the Linux kernel's regression
>> tracker -- that's in your interest, as it ensures your report won't fall
>> through the cracks unnoticed.
>>
>> Hint for developers: you normally don't need to care about regzbot once
>> it's involved. Fix the issue as you normally would, just remember to
>> include 'Link:' tag in the patch descriptions pointing to all reports
>> about the issue. This has been expected from developers even before
>> regzbot showed up for reasons explained in
>> 'Documentation/process/submitting-patches.rst' and
>> 'Documentation/process/5.Posting.rst'.
> 
> 
