Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4372A50878A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378351AbiDTMAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244583AbiDTMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:00:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79721CFC9;
        Wed, 20 Apr 2022 04:57:15 -0700 (PDT)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nh8xN-0007Pq-Am; Wed, 20 Apr 2022 13:57:13 +0200
Message-ID: <20ad7c63-c837-6f6e-6bbe-7b49d653e033@leemhuis.info>
Date:   Wed, 20 Apr 2022 13:57:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        workflows@vger.kernel.org
References: <6808cd17-b48c-657d-de60-ef9d8bfa151e@leemhuis.info>
 <acccdf28-3c5d-a81b-8e3a-f72e0f46149c@kernel.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: A lot of regression reports submitted to bugzilla.kernel.org are
 apparently ignored, even bisected ones
In-Reply-To: <acccdf28-3c5d-a81b-8e3a-f72e0f46149c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1650455836;2df81ad0;
X-HE-SMSGID: 1nh8xN-0007Pq-Am
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.22 12:31, Krzysztof Kozlowski wrote:
> On 06/04/2022 14:35, Thorsten Leemhuis wrote:
>> Hi! TLDR: I looked closer at every ticket filed in bugzilla.kernel.org
>> over a time span of two weeks to see how well reports are handled, in
>> particular those for kernel regressions. The results of this rough
>> analysis are kinda devastating from my point of view. I for example
>> found 8 tickets describing a regression where the reporter had even
>> bisected the problem, but nevertheless the ticket afaics didn’t get a
>> single reply or any other reaction from a regular kernel developer
>> within about a week; in fact out of a total of 20 reports that looked
>> like regressions to me (17 if you exclude tickets where the reporter
>> used an afaics lightly patched distro kernel), only one got a helpful
>> reply from a developer within a week. 
> To respond, developer would first had to be notified. Did it happen? Or
> just some default assignee got automated notification?

I didn't check, as I didn't care about the individual developers
performance for this analysis: I just wanted to check how good or bad
bugzilla is working for the Linux kernel development community as a
whole. My expectations were low already, but the numbers I came up with
were even worse than expected.

>> That makes us miss valuable
>> reports and puts our "no regressions" rule into a bad light. Hence,
>> something IMHO should be done here to improve the situation, but I'm not
>> sure myself what exactly -- that's why I'm writing this mail. A better
>> warning on bugzilla’s frontpage suggesting to report issues by mail
>> maybe? And/or disable all bugzilla products and components where it's
>> not clear that somebody will be looking at least once at submitted tickets?
> 
> I find such Bugzilla useless - the Components are not matching reality,
> Products look ok except missing really a lot. Does it have proper
> assigners based on maintainers? Nope. At least not everywhere.
> 
> All the bug or issue reports I get via email and I think I am not alone
> in this. All automated tools (kbuild, kernelCI) are using emails for bug
> reporting. Why having one more system which seems not up to date?

I'm the wrong one to ask, as I think it's a disservice right now that
needs to be dealt with -- for example by turning it off or by making it
work properly. But to my knowledge there is nobody really responsible
for it (apart from Konstantin and his team, but they are afaics only
responsible for running bugzilla the software -- not for maintaining
components, products, and such things). That's afaics why we as the
kernel developers community need to come up with a decision. But maybe
mailing lists are a bad tool for this and this needs to wait till kernel
and/or maintainers summit in September (it's already on the list of
topics I plan to propose).

> The only reliable and up to date information we have in maintainers
> file: who is responsible and whom to CC (e.g. lists).

That's why the current "reporting issues" document (which is even linked
prominently on the front-page of bugzilla.kernel.org and mostly written
by yours truely) tells everyone to look there and even discourages using
bugzilla.kernel, unless the MAINTAINERS file mentions it as official
point of contact (the last time I checked that was the case for
roundabout 20 entries, mainly ACPI, PM, and PCI). But most people simply
don't read the docs and just use the bug-tracker; seems that's just how
humans are. :-D

> I can give example from my domain:
> https://bugzilla.kernel.org/show_bug.cgi?id=210047
> 
> This is clearly issue for me but there is no way I was notified about
> this. I just found it by using the keyword from maintainers. Wrong
> mailing list as Assignee, no CC to me. Such bug reports will be missed
> because there is no way I can receive information about them. Why then
> providing interface for bug reports which by design will not reach the
> respective person?

I have no idea, but to play devils advocate for a moment: it didn't
happen by design, things like that just happened in loosely organized
projects -- and for many years now nobody simply cared enough to do
anything about it.

Ciao, Thorsten
