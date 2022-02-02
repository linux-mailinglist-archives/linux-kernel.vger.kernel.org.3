Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136EC4A6E57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245711AbiBBKFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiBBKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:05:41 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C3C061714;
        Wed,  2 Feb 2022 02:05:41 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nFCWB-0006QL-5B; Wed, 02 Feb 2022 11:05:39 +0100
Message-ID: <35bf934c-d8ed-7988-69f3-e0cb53e0adf4@leemhuis.info>
Date:   Wed, 2 Feb 2022 11:05:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-BS
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1643710947.git.linux@leemhuis.info>
 <b32d06dca7d228d61692acaff386928bd673754f.1643710947.git.linux@leemhuis.info>
 <87k0ee5gf2.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v4 1/3] docs: add two documents about regression handling
In-Reply-To: <87k0ee5gf2.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1643796341;cd3236e6;
X-HE-SMSGID: 1nFCWB-0006QL-5B
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.22 00:13, Jonathan Corbet wrote:
> OK, I'll try not to take so long to have a look at it this time.
> 
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> Create two documents explaining various aspects around regression
>> handling and tracking; one is aimed at users, the other targets
>> developers.
>>
>> The texts among others describe the first rule of Linux kernel
>> development and what it means in practice. They also explain what a
>> regression actually is and how to report one properly.
>>
>> Both texts additionally provide a brief introduction to the bot the
>> kernel's regression tracker uses to facilitate the work, but mention the
>> use is optional.
>>
>> To sum things up, provide a few quotes from Linus in the document for
>> developers to show how serious he takes regressions.
>>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> ---
>>  Documentation/admin-guide/index.rst           |   1 +
>>  .../admin-guide/regressions-users.rst         | 436 ++++++++++++
>>  Documentation/process/index.rst               |   1 +
>>  Documentation/process/regressions-devs.rst    | 672 ++++++++++++++++++
> 
> I'll start with some *serious* bikesheddery...it's best if the names of
> the files tell readers what's inside.  This isn't something I feel
> really strongly about, but we could consider

I wasn't totally happy with the file names myself, so it's good that you
bring it up.

> 	admin-guide/reporting-regressions.txt (or just regressions.txt)
>         process/regression-policy.txt

I like "reporting-regressions.txt", but I wonder if using the word
"policy" is a good idea. I tried to avoid it (and similar words, like
guidelines), as they might do more harm then good. So how about:

 	admin-guide/reporting-regressions.rst
        process/regressions.rst

> [...] 
>> +Send a mail to the regressions mailing list (regressions@lists.linux.dev) while
>> +CCing the Linux kernel's regression tracker (regressions@leemhuis.info); if the
>> +issue might better be dealt with in private, feel free to omit the list.
> 
> Perhaps a separate concern, but might you want to set up an @kernel.org
> alias for the regression tracker?  Trust me, you're not gonna want to
> run it forever, and the ability to quickly redirect the mail may prove
> to be a nice thing to have.  An email address with your domain sitting
> in the docs will circulate for years after it gets changed.

Yeah, it's on my mental to do list for a few weeks already, but never
set down to actually get this rolling. You are right, I'll ask for an alias.

>> +Is the "no regressions" rule really adhered in practice?
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +It's taken really serious, as can be seen by many mailing list posts from Linux
> 
> serious*ly*

Fixed.

> Otherwise I can't find a lot to complain about at this point.  I'm not
> really convinced that we need all those Quotations From Chairman Linus,
> but I won't fight about it either :)

I'll take a look again and consider kicking a few.

> In general, though, unless objections show up, I don't see any real
> reason to not apply this one.

Great, many thx!

Ciao, Thorsten
