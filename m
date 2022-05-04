Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02758519D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbiEDKnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348403AbiEDKnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:43:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A73E2A71C;
        Wed,  4 May 2022 03:39:23 -0700 (PDT)
Received: from [2a02:8108:963f:de38:1b3c:6996:5378:f253]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nmCPg-0002qJ-9r; Wed, 04 May 2022 12:39:20 +0200
Message-ID: <3bb21e7a-8937-d813-7273-f760b4e95cdb@leemhuis.info>
Date:   Wed, 4 May 2022 12:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Regression: Extremely unstable connection on ax200
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kyle McGrath <kyle.mcgrath@protonmail.com>,
        s.viper.z@gmail.com, info@cgnetlink.com,
        Udo Steinberg <udo@hypervisor.org>, golan.ben.ami@intel.com
References: <031b72a5-907e-219f-7433-8de3641d7c01@leemhuis.info>
In-Reply-To: <031b72a5-907e-219f-7433-8de3641d7c01@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1651660763;7cc7c3fc;
X-HE-SMSGID: 1nmCPg-0002qJ-9r
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Iwlwifi maintainers, what happened regarding below regression report?
Looks like it was ignored, is there a reason why? There are two other
tickets reg. similar problems in bugzilla.kernel.org that look like they
were mostly ignored as well:

https://bugzilla.kernel.org/show_bug.cgi?id=215635
https://bugzilla.kernel.org/show_bug.cgi?id=215697

Can anyone clarify what's up here? Are they all the same issue or are it
different ones?

And could the reporters of those tickets (CCed) please clarify in the
ticket if their problem still happens with the latest kernel (either
5.17.y or mainline; 5.16.y is irrelevant now, as it's EOL)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

On 08.04.22 12:11, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all people that seemed to be relevant
> here. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215789 :
> 
>>  Kyle McGrath 2022-04-01 14:05:34 UTC
>>
>> Created attachment 300678 [details]
>> Log of iwlwifi on 5.17
>>
>> Recently I updated to the Fedora 36 beta, with the 5.17 kernel. Ever since, I've experienced excessive issues with my Intel AX200 wireless card. Every other aspect of my usage has remained the same (laptop and router both in the same location, same number of devices on the network, etc.)
>>
>> Before updating to 5.17, I was able to perform latency-sensitive tasks such as playing online games and use VoIP applications without issue, with acceptable latency. After updating to 5.17 it is at the point where I cannot have an enjoyable match due to constant ping spikes, often to the point where the game will "stutter" or "lock up" every 10 seconds or say, with excessively high ping to go along with this. My VoIP applications have similar issues with calls often being interrupted or distorted.
>>
>> I reverted to 5.16.16 and this has alleviated the issue for the time being. I've included journal output from both 5.17 and 5.16 and you can see there are several issues/errors which are not present on 5.16.
>>
>> Below is all I get from the journal for iwlwifi under 5.16. I've included 5.17 output as an attachment.
>>
>>
>> Apr 01 01:18:06 tarsonis kernel: iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
>> Apr 01 01:18:06 tarsonis kernel: iwlwifi 0000:03:00.0: api flags index 2 larger than supported by driver
>> Apr 01 01:18:06 tarsonis kernel: iwlwifi 0000:03:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
>> Apr 01 01:18:06 tarsonis kernel: iwlwifi 0000:03:00.0: loaded firmware version 67.8f59b80b.0 cc-a0-67.ucode op_mode iwlmvm
>> Apr 01 01:18:07 tarsonis kernel: iwlwifi 0000:03:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
>> Apr 01 01:18:07 tarsonis kernel: iwlwifi 0000:03:00.0: Detected RF HR B3, rfid=0x10a100
>> Apr 01 01:18:07 tarsonis kernel: iwlwifi 0000:03:00.0: base HW address: e0:d4:e8:a5:98:21
>> Apr 01 01:18:07 tarsonis kernel: iwlwifi 0000:03:00.0 wlp3s0: renamed from wlan0
> 
> 
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?
> 
> Anyway, to get this tracked:
> 
> #regzbot introduced: v5.16..v5.17
> #regzbot from: Kyle McGrath <kyle.mcgrath@protonmail.com>
> #regzbot title: iwlwifi: Extremely unstable connection on ax200
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215789
> 
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
