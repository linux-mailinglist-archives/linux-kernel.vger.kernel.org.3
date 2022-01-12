Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6548C074
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351799AbiALIzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351771AbiALIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:54:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434E4C06173F;
        Wed, 12 Jan 2022 00:54:57 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n7ZPD-0004z1-6n; Wed, 12 Jan 2022 09:54:55 +0100
Message-ID: <0a79a9be-eddc-fa2b-d7d9-8a2680ed370a@leemhuis.info>
Date:   Wed, 12 Jan 2022 09:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <51654a51-4264-c333-40d5-4f755e69d54b@leemhuis.info>
 <20220111145031.cfkyxffmps3swakv@meerkat.local>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Add a few more FAQs to the [kernel.org] releases page
In-Reply-To: <20220111145031.cfkyxffmps3swakv@meerkat.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641977697;ad489ecd;
X-HE-SMSGID: 1n7ZPD-0004z1-6n
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.22 15:50, Konstantin Ryabitsev wrote:
> On Tue, Jan 11, 2022 at 07:32:46AM +0100, Thorsten Leemhuis wrote:
>> * you added two sections that use the term "LTS", which is not explained
>> on that page and wasn't used on it earlier. I wonder if it might be
>> better to use "Longterm series" or something like that instead, as that
>> it the term used on the page (and the official one afaics).
> Thanks for the feedback, I switched to using "longterm" uniformly on that
> page.

Ahh, nice, thx.

>> This was also added:
>>
>>> Does the odd-even number still mean anything?
>>>
>>> Not since 2.5 days.
>>
>> I guess a lot of users won't known how long ago that was, so how about
>> using an answer like this instead:
>>
>> "Not since December 2003, when Linux 2.6 got released."
> 
> I've expanded a bit more on that topic, just to avoid confusion.

Great.

BTW, also a big "thank you" from my side for linking "reporting issues".

I looked a little more at the two pages you changed. Most of what
follows is nitpicking, feel free to ignore it. Quotes from here on are
from the linked pages, not from the mail I'm replying to:


# https://www.kernel.org/category/releases.html

> What is the next longterm release going to be?
>
> Longterm kernels are picked based on various factors -- major new
> features, popular commercial distribution needs, device manufacturer
> demand, maintainer workload and availability, etc. You can roughly
> estimate when the new longterm version will become available based on
> how much time has elapsed since the last longterm version was
> chosen.

This is not true anymore afaics (or is it vague on purpose?). Greg (now
CCed) since a few years always makes the last mainline release of a year
the next longterm kernel. He said that a few times, for example here:
https://twitter.com/kernellogger/status/1321081399730970626

So something like this maybe?
"""
What is the next longterm release going to be?

The last Linux mainline version released in a year becomes a longterm
kernel.
"""

# https://www.kernel.org/category/faq.html

> Why is an LTS kernel marked as "stable" on the front page?
>  
> Long-term support ("LTS") kernels announced on the Releases page […]

Maybe get rid of the LTS here, too?

"""
Why is a longterm kernel described as "stable" on the front page?

Longterm kernels announced on the Releases page […]
"""

FWIW, in reporting issues I did it like this: "Longterm kernels
(sometimes called 'LTS kernels') are […]"

> How do I report a problem with the kernel?

I'd sort the list of distribution bug trackers alphabetically to avoid
people thinking things like "why is x listed earlier than my favourite
distro, which is way better".

Ohh, and I guess you make some people happy if you do
s/OpenSUSE/openSUSE/ :-D

Ciao, Thorsten
