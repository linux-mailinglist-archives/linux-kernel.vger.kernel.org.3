Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553EF492C73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347380AbiARRd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiARRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:33:52 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0CBC061574;
        Tue, 18 Jan 2022 09:33:51 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n9sMe-0000Fx-8a; Tue, 18 Jan 2022 18:33:48 +0100
Message-ID: <2f55b629-2e5b-bd45-e0ea-4e476f603dc8@leemhuis.info>
Date:   Tue, 18 Jan 2022 18:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: ChipIdea USB regression
Content-Language: en-BS
To:     Rob Herring <robh@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
 <5bd2dba7-c56f-4d8c-2f28-f2428afdcead@leemhuis.info>
 <CAL_JsqKH90fgSPjKqALweEmZDfxy88jAiRZ4uRKE3+-OZv1ZXQ@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAL_JsqKH90fgSPjKqALweEmZDfxy88jAiRZ4uRKE3+-OZv1ZXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1642527231;16d97773;
X-HE-SMSGID: 1n9sMe-0000Fx-8a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.22 17:53, Rob Herring wrote:
> On Sun, Jan 16, 2022 at 4:21 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> [TLDR: I'm adding this regression to regzbot, the Linux kernel
>> regression tracking bot; most text you find below is compiled from a few
>> templates paragraphs some of you might have seen already.]
>>
>> Hi, this is your Linux kernel regression tracker speaking.
>>
>> Adding the regression mailing list to the list of recipients, as it
>> should be in the loop for all regressions, as explained here:
>> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>>
>> On 14.01.22 11:56, Charles Keepax wrote:
>>> Hi guys,
>>>
>>> My Zynq based board stopped booting today, a bisect points to this
>>> patch:
>>>
>>> commit 0f153a1b8193 ("usb: chipidea: Set the DT node on the child device")
>>
>> Thanks for the report.
>>
>> To be sure this issue doesn't fall through the cracks unnoticed, I'm
>> adding it to regzbot, my Linux kernel regression tracking bot:
>>
>> #regzbot ^introduced 0f153a1b8193
>> #regzbot title usb: chipidea: Zynq based board stopped booting today
>> #regzbot ignore-activity
>>
>> Reminder: when fixing the issue, please add a 'Link:' tag with the URL
>> to the report (the parent of this mail) using the kernel.org redirector,
> 
> 'kernel.org redirector' is lore.kernel.org? It would be clearer to
> just say that.

Yes/No it's lore.kernel.org/r/ (and not lore.kernel.org/list-foo/).
You're right I'll rephrase next time.

>> as explained in 'Documentation/process/submitting-patches.rst'. Regzbot
>> then will automatically mark the regression as resolved once the fix
>> lands in the appropriate tree. For more details about regzbot see footer.
> 
> Would it be possible for you to provide the exact link tag in your
> reports? That would be easier and less error prone than describing
> what to do in prose.

Hmm. The webui already provides this (and other things you likely want
to add) when you show the details for a tracked regression or visit its
individual page:

https://linux-regtracking.leemhuis.info/regzbot/mainline/
https://linux-regtracking.leemhuis.info/regzbot/regression/20220114105620.GK18506@ediswmail.ad.cirrus.com/

I see that it would be convenient for developers and less error prone if
I could mention the proper Link: tag in mails like the one you quoted,
that's why I considered that already. But it would make the regression
tracker's job (aka my "job", which I'm kinda doing in my spare time) yet
again somewhat harder, as I see no easy solution to automate that when
writing these mails (which I do with thunderbird, currently). That's why
I decided to not do that for now, as that job is already hard enough and
I don't want to get burned out by this a second time; and those link
tags are something that were expected from developers even before I came
with regzbot.

But well, maybe over time I can up with some idea to make this easy for
me, then I'll gladly provide that service. One easy way to make this
happen would be: regzbot could send a confirmation mail when it adds a
regression to the list of tracked issues and mention the Link: tag
there. But that would be yet another mail in all out inboxes. But maybe
such a mail would be good for other reasons, too.

Ciao, Thorsten
