Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49B351483D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358480AbiD2Lhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358479AbiD2Lh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:37:28 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A22B6449;
        Fri, 29 Apr 2022 04:34:10 -0700 (PDT)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nkOsy-0003f1-Uz; Fri, 29 Apr 2022 13:34:09 +0200
Message-ID: <34691c94-ca34-89a2-a846-5416d44da9f3@leemhuis.info>
Date:   Fri, 29 Apr 2022 13:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Bug 215744 - input from the accelerometer disappeared, regression
 on amd_sfh on kernel 5.17 #forregzbot
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info>
In-Reply-To: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1651232050;89eee364;
X-HE-SMSGID: 1nkOsy-0003f1-Uz
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

#regzbot invalid: bios bug and reporter seems to be satisfied by
resolving this with a bios update

On 01.04.22 10:06, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all people that seemed to be relevant
> here. It looks to me like this is something for Basavaraj, as it seems
> to be caused by	b300667b33b2 ("HID: amd_sfh: Disable the interrupt for
> all command"). But I'm not totally sure, I only looked briefly into the
> details. Or was this discussed somewhere else already? Or even fixed?
> 
> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215744 :
> 
>>  Marco 2022-03-25 15:22:19 UTC
>>
>> After updating to 5.17, the input from the accelerometer disappeared, completely. No devices available from IIO tree. First bad commit causing it is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c?id=b300667b33b2b5a2c8e5f8f22826befb3d7f4f2b. Reverting this and the the other two on top fixed this. Tried to not revert only the above mentioned commit, but it's still not working.
>>
>> Marco.
> 
> Anyway, to get this tracked:
> 
> #regzbot introduced: b300667b33b2b5a2c8e5f8f22826befb3d7f4
> #regzbot from: Marco <rodomar705@protonmail.com>
> #regzbot title: input: hid: input from the accelerometer disappeared due
> to changes to amd_sfh
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215744
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
