Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB564A4939
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiAaOW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiAaOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:22:26 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECD1C061714;
        Mon, 31 Jan 2022 06:22:25 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nEXZX-00074h-C5; Mon, 31 Jan 2022 15:22:23 +0100
Message-ID: <00f73105-da64-f62b-866c-00828d8701ba@leemhuis.info>
Date:   Mon, 31 Jan 2022 15:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-BS
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1643110442.git.linux@leemhuis.info>
 <f97738d6250050bc982bf2947587f1c73f37446f.1643110442.git.linux@leemhuis.info>
 <87sftbwemg.fsf@meer.lwn.net>
 <c8d7228a-2df5-df92-6d53-c3e940274dad@leemhuis.info>
Subject: Re: [PATCH v3 1/2] docs: add a document about regression handling
In-Reply-To: <c8d7228a-2df5-df92-6d53-c3e940274dad@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1643638946;ed0d6898;
X-HE-SMSGID: 1nEXZX-00074h-C5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.22 15:10, Thorsten Leemhuis wrote:
> 
> On 26.01.22 00:59, Jonathan Corbet wrote:
>> Thorsten Leemhuis <linux@leemhuis.info> writes:

>>> +   Note: Only the content of this RST file as found in the Linux kernel sources
>>> +   is available under CC-BY-4.0, as versions of this text that were processed
>>> +   (for example by the kernel's build system) might contain content taken from
>>> +   files which use a more restrictive license.
>>
>> I wonder if we could put this boilerplate at the bottom, with a single
>> "see the bottom for redistribution information" line here?  Most readers
>> won't care about this stuff and shouldn't have to slog through it to get
>> to what they want to read.
> 
> Totally fine with me. When I touch reporting-issues.rst the next time
> I'll move it downwards as well.

V4 will do that, as I added a patch to point from reporting-issues.rst
to one of the two new documents.

>>> +The important bits for people affected by regressions
>>> +=====================================================
>>> +
>>> +It's a regression if something running fine with one Linux kernel works worse or
>>> +not at all with a newer version. Note, the newer kernel has to be compiled using
>>> +a similar configuration -- for this and other fine print, check out below
>>> +section "What is a 'regression' and what is the 'no regressions rule'?".
>> Can we be consistent with either single or double quotes?  I'd suggest
>> "double quotes" but won't make a fuss about that.
> 
> Changed to "double quotes" everywhere in the text. But just to make sure
> I get things right: in this particular case this will result in
> 
> ...section "What is a "regression" and what is the "no regressions rule"?".
> 
> This looks a bit strange to me. Something in me really would like to
> quote the section's header in single quotes, but I guess grammar rules
> do not allow that, so whatever. :-D

I changed something and now simply don't mentioned the section names to
avoid this problem. After the split that's not strictly needed afaics.

>>> +Report your regression as outlined in
>>> +`Documentation/admin-guide/reporting-issues.rst`, it already covers all aspects
>> No need to quote the file name.
> Okay, I thought I had seen some commit or instructions that it's better
> to use them in this case, but my brain must have imagined it.

I noticed I quoted internal references in reporting-issues.rst quite
often. IMHO it improves readability sometimes (it depends a lot on the
title of the target document), as can be seen in this example:

```
If your kernel is tainted, study
'Documentation/admin-guide/tainted-kernels.rst' to find out why.
[...]
To find the change there is a process called 'bisection' which the document
'Documentation/admin-guide/bug-bisect.rst' describes in detail.
```

after processing to HTML looks like this:

```
If your kernel is tainted, study 'Tainted kernels' to find out why.
[...]
To find the change there is a process called ‘bisection’ which the
document ‘Bisecting a bug’ describes in detail.
```

Sure, "Tainted kernels" and "Bisecting a bug" are links and hence
displayed differently by the browser, but I think the quotes help. But YMMV.

I sooner or later hope to improve and fix a few things in
reporting-issues.rst anyway. Let me know if I should take the
opportunity to remove the single quotes then.

>>> +Who needs to find the commit causing a regression?
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +It's the reporter's duty to find the culprit, but developers of the affected
>>> +subsystem should offer advice and reasonably help where they can.
>>
>> Is it really our policy that *reporters* need to find the offending
>> commit?  That's certainly not my view of things, anyway?

BTW, I noticed reporting-issues.rst covers it like this:

Normally it's up to the reporter to track down the culprit, as
maintainers often won't have the time or setup at hand to reproduce it
themselves.

> Well, do we have something on that written down somewhere or a few
> quotes from Linus that might help to clarify things?
> 
> Anyway: I was not totally happy with it either, as I found the first
> part of the sentence to strong, and the second to soft. But I had
> trouble finding something better, maybe a native speaker could help out
> here. Maybe something along these lines?

I plan to go with this now:
```
Who needs to find the root cause of a regression?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Developers of the affected code area should try to locate the culprit on
their own. But for them that's often impossible to do with reasonable
effort, as quite a lot of issues only occur in a particular environment
outside the developer's reach -- for example, a specific hardware
platform, firmware, Linux distro, system's configuration, or
application. That's why in the end it's often up to the reporter to
locate the culprit commit; sometimes users might even need to run
additional tests afterwards to pinpoint the exact root cause. Developers
should offer advice and reasonably help where they can, to make this
process relatively easy and achievable for typical users.
```

Ciao, Thorsten
