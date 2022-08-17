Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F73596BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiHQJJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHQJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:09:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F70E33A24
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:08:59 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oOF2h-0002Up-4y; Wed, 17 Aug 2022 11:08:51 +0200
Message-ID: <35814f70-26ad-8007-9381-e8edf4a6d77f@leemhuis.info>
Date:   Wed, 17 Aug 2022 11:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [Intel-wired-lan] ice: Error setting promisc mode on VSI 6
 (rc=-17) @ 5.18.x
Content-Language: en-US
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
        "Siwik, Grzegorz" <grzegorz.siwik@intel.com>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
References: <CAK8fFZ7m-KR57M_rYX6xZN39K89O=LGooYkKsu6HKt0Bs+x6xQ@mail.gmail.com>
 <2596b2c6-71e4-543f-799f-b4b174c21f31@leemhuis.info>
 <CAK8fFZ6hS69JMtnvFnLVt9aiWEivZ9-izNgMHtB+KeAWAfaXaQ@mail.gmail.com>
 <6f52ccd2-8411-0c53-2deb-885bb1234ce5@leemhuis.info>
 <c89c993e-7a7a-15df-85ef-8d9b7be16b71@intel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <c89c993e-7a7a-15df-85ef-8d9b7be16b71@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1660727339;9fb92636;
X-HE-SMSGID: 1oOF2h-0002Up-4y
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.22 15:51, Wilczynski, Michal wrote:
> 
> Adding Grzegorz Siwik,  since he is working on similar issue and already
> has a patch that is being tested/reviewed internally at the moment.
>
> He can you a send patch tomorrow so you can test if it also fixes your
> problem.

Tony, Jesse, I have to wonder: why is it taken so long to get this
regression fixed? The regression was reported 69 days ago and the first
patches to fix this went out 40 days ago. That's far from ideal.

Reminder: this regression ideally should have been fixed within two
weeks after the report, as explained here:
https://docs.kernel.org/process/handling-regressions.html

FWIW, in case anyone wonders: the latest patch-series to fix this can be
found here:
https://lore.kernel.org/intel-wired-lan/1660310750-290943-1-git-send-email-grzegorz.siwik@intel.com/

Thx for working on it Grzegorz! Side note: might be good to add a
"Reported-by", but it's not really important I guess.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

BTW, let me update the regzbot status:

#regzbot introduce: 5eda8afd6bcc
#regzbot poke

> On 7/5/205eda8afd6bcc22 11:43 AM, Thorsten Leemhuis wrote:
>> [adding Michal to the recipients]
>>
>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>> to make this easily accessible to everyone.
>>
>> Intel network maintainers, help me out here please. Has anything been
>> done to address this regression? It looks like Jaroslav didn't even get
>> a single reply. What's up there?
>>
>> BTW, took a quick look into the issue and noticed a the patch "ice: Fix
>> promiscuous mode not turning off" from Michal:
>> https://lore.kernel.org/all/20220704131227.2966160-3-michal.wilczynski@intel.com/
>>
>> Is this maybe fixing this? Then it would be good to add Link and
>> Reported-by tags to that patch.
>>
>> Or is this something else and Jaroslav needs to bisect?
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>
>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
>> reports and sometimes miss something important when writing mails like
>> this. If that's the case here, don't hesitate to tell me in a public
>> reply, it's in everyone's interest to set the public record straight.
>>
>> #regzbot poke
>>
>> On 19.06.22 19:00, Jaroslav Pulchart wrote:
>>> Hello,
>>>
>>> yes, I revert that commit. Still the promiscs cannot be set and the
>>> dmesg
>>> error message changed to:
>>> ---------------
>>> $ ip link set em1 promisc on
>>> $ dmesg
>>> ...
>>> ice 0000:63:00.0 em1: Error setting Multicast promiscuous mode on VSI 6
>>> ...
>>> ---------------
>>>
>>> Jaroslav P.
>>>
>>> ne 19. 6. 2022 v 13:51 odesílatel Thorsten Leemhuis
>>> <regressions@leemhuis.info> napsal:
>>>
>>>> [TLDR: I'm adding this regression report to the list of tracked
>>>> regressions; all text from me you find below is based on a few
>>>> templates
>>>> paragraphs you might have encountered already already in similar form.]
>>>>
>>>> Hi, this is your Linux kernel regression tracker.
>>>>
>>>> On 09.06.22 08:58, Jaroslav Pulchart wrote:
>>>>> I'm struggling with broken network connectivity at VMs using linux
>>>>> bridge at host after update of kernel from 5.17.x to 5.18.x @ Dell
>>>>> R750 server with E810-XXV NICs.
>>>>>
>>>>> I noticed the kernel reports "Error setting promisc mode" in dmesg.
>>>>>
>>>>> # dmesg  | grep 'Error setting promisc'
>>>>> [   24.863557] ice 0000:31:00.0: Error setting promisc mode on VSI
>>>>> 6 (rc=-17)
>>>>> [   24.878369] ice 0000:31:00.0: Error setting promisc mode on VSI
>>>>> 6 (rc=-17)
>>>>> [   25.045834] ice 0000:31:00.0: Error setting promisc mode on VSI
>>>>> 6 (rc=-17)
>>>>> [   25.129840] ice 0000:b1:00.0: Error setting promisc mode on VSI
>>>>> 6 (rc=-17)
>>>>> [   25.144440] ice 0000:b1:00.0: Error setting promisc mode on VSI
>>>>> 6 (rc=-17)
>>>>>
>>>>> # lspci -s 0000:31:00.0
>>>>> 31:00.0 Ethernet controller: Intel Corporation Ethernet Controller
>>>>> E810-XXV for SFP (rev 02)
>>>>> # lspci -s 0000:b1:00.0
>>>>> b1:00.0 Ethernet controller: Intel Corporation Ethernet Controller
>>>>> E810-XXV for SFP (rev 02)
>>>>>
>>>>> It is easy to reproduce by:
>>>>>    # ip link set em1 promisc on
>>>>>    # dmesg -T | tail -n 1
>>>>>    [Thu Jun  9 08:48:19 2022] ice 0000:31:00.0: Error setting promisc
>>>>> mode on VSI 6 (rc=-17)
>>>>>
>>>>> Could it be an 'ice' driver bug introduced in the 5.18 kernel?
>>>> CCing the regression mailing list, as it should be in the loop for all
>>>> regressions, as explained here:
>>>> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>>>>
>>>> Jaroslav, did you try to revert the change that was suggested to you in
>>>> https://lore.kernel.org/all/d993bbb6-e583-5d91-76c0-841cc5da86af@roeck-us.net/
>>>> Did it help?
>>>>
>>>> Anyway: To be sure below issue doesn't fall through the cracks
>>>> unnoticed, I'm adding it to regzbot, my Linux kernel regression
>>>> tracking
>>>> bot:
>>>>
>>>> #regzbot ^introduced v5.17 to v5.18
>>>> #regzbot title net: ice: Error setting promisc mode on VSI 6 (rc=-17) @
>>>> 5.18.x
>>>> #regzbot monitor
>>>> https://lore.kernel.org/all/CAK8fFZ68+xZ2Z0vDWnihF8PeJKEmEwCyyF-8W9PCZJTd8zfp-A@mail.gmail.com/
>>>> #regzbot monitor
>>>> https://lore.kernel.org/all/CAK8fFZ61mQ3AYpdWjWtyUXzrs-RVMW61mBLrjRDXBxB-F9GzbA@mail.gmail.com/
>>>> #regzbot ignore-activity
>>>>
>>>> This isn't a regression? This issue or a fix for it are already
>>>> discussed somewhere else? It was fixed already? You want to clarify
>>>> when
>>>> the regression started to happen? Or point out I got the title or
>>>> something else totally wrong? Then just reply -- ideally with also
>>>> telling regzbot about it, as explained here:
>>>> https://linux-regtracking.leemhuis.info/tracked-regression/
>>>>
>>>> Reminder for developers: When fixing the issue, add 'Link:' tags
>>>> pointing to the report (the mail this one replied to), as the kernel's
>>>> documentation call for; above page explains why this is important for
>>>> tracked regressions.
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
>>>> hat)
>>>>
>>>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
>>>> reports and sometimes miss something important when writing mails like
>>>> this. If that's the case here, don't hesitate to tell me in a public
>>>> reply, it's in everyone's interest to set the public record straight.
>>>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
