Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A4F5148B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358811AbiD2MDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiD2MDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:03:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6981C8A8E;
        Fri, 29 Apr 2022 04:59:55 -0700 (PDT)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nkPHt-0002CR-PA; Fri, 29 Apr 2022 13:59:54 +0200
Message-ID: <9811c780-ea28-1461-6347-93a3cf218b6c@leemhuis.info>
Date:   Fri, 29 Apr 2022 13:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Bug 215872] New: ath11k: QCA6390 firmware crashes after some
 time
Content-Language: en-US
References: <bug-215872-62941@https.bugzilla.kernel.org/>
Cc:     linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Kai Mast <mail@kai-mast.de>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <bug-215872-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1651233595;7d280789;
X-HE-SMSGID: 1nkPHt-0002CR-PA
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed below regression report in bugzilla.kernel.org that afaics
nobody acted upon since it was reported about a week ago, that's why I
decided to step in here. Could somebody take a look into below issue? Or
was this discussed somewhere else already? Or even fixed?

On 21.04.22 22:07, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215872
> 
>             Bug ID: 215872
>            Summary: ath11k: QCA6390 firmware crashes after some time
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 5.17.3-arch1-1
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Bluetooth
>           Assignee: linux-bluetooth@vger.kernel.org
>           Reporter: mail@kai-mast.de
>         Regression: No
> 
> Created attachment 300786
>   --> https://bugzilla.kernel.org/attachment.cgi?id=300786&action=edit
> dmesg | grep Bluetooth
> 
> I'm on arch Linux. For a while now (multiple kernel versions since 5.15 at
> least) my qca firwmare seems to crash. Weirdly bluetooth stops working and WiFi
> still works fine.
> There is nothing in particular that seems to trigger this. I just have to wait
> for a while. Sometimes a few minutes after boot sometimes a few hours. 
> 
> Rebooting without a power connection or booting into Windows usually resolves
> this issue.
> 
> I'm on a 2020 Dell XPS 9500. Fimrware is up to date at 1.13.
> 
> Output of uname -a: Linux kai-xps 5.17.3-arch1-1 #1 SMP PREEMPT Thu, 14 Apr
> 2022 01:18:36 +0000 x86_64 GNU/Linux

Anyway, to get this tracked:

#regzbot introduced: v5.15..v5.17
#regzbot from: Kai Mast <mail@kai-mast.de>
#regzbot title: bluetooth: QCA6390 firmware crashes after some time
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215872

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.

