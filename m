Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08448427D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiADN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiADN3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:29:47 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8FAC061761;
        Tue,  4 Jan 2022 05:29:47 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n4jsm-0002Tb-Kj; Tue, 04 Jan 2022 14:29:44 +0100
Message-ID: <ed8ffc6c-19cd-6558-7f7e-d7bdde4ecdb9@leemhuis.info>
Date:   Tue, 4 Jan 2022 14:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1641203216.git.linux@leemhuis.info>
 <9a68f2fcb5fe599b76e278a61928e23eb950cd83.1641203216.git.linux@leemhuis.info>
 <CAKXUXMx_J-enVGQtX6ZqKKRZ7SwZe203tLnQoJ=VLPz3tUhK+Q@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 2/2] docs: regressions.rst: rules of thumb for
 handling regressions
In-Reply-To: <CAKXUXMx_J-enVGQtX6ZqKKRZ7SwZe203tLnQoJ=VLPz3tUhK+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641302987;5af550f9;
X-HE-SMSGID: 1n4jsm-0002Tb-Kj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.22 13:16, Lukas Bulwahn wrote:
> On Mon, Jan 3, 2022 at 3:23 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:

>> diff --git a/Documentation/admin-guide/regressions.rst b/Documentation/admin-guide/regressions.rst
>> index 1ff6a0802fc9..5f02a001e53c 100644
>> --- a/Documentation/admin-guide/regressions.rst
>> +++ b/Documentation/admin-guide/regressions.rst
>> @@ -63,6 +63,10 @@ list; add the aforementioned paragraph, just omit the caret (the ^) before the
>>  ``introduced``, which make regzbot treat your mail (and not the one you reply
>>  to) as the report.
>>
>> +Try to fix regressions quickly once the culprit got identified. Fixes for most
> 
> s/got/gets/ --- at least, that is what the gmail grammar spelling suggests :)

Hmm, LanguageTool didn't complain. Not totally sure, maybe both
approaches are okay. But the variant suggested by the gmail checker
might be the better one.

You comment made me put my text in google docs, which found about
fifteen other places where something was wrong. Should have done this
sooner, sorry. :-/

> [a lot of helpful comments]

Many thx, fixed all of them locally.

> Thorsten, thanks for this process documentation. It was a nice and
> comprehensible read for me. Let us hope it helps contributors and
> maintainers to adopt those recommendations.

Time will tell. Guess it will take a while.

> If you need any support of any kind (more contributors,

If you known people looking for a kernel docs text to work on, I have
two related ideas that might be of interest for them:

* the kernel docs IMHO could need a text explaining how to use "make
localmodconfig" to ordinary users -- for example, when preparing for a
bisection or a quick test of the latest mainline tree. Something like
this maybe, but modernized (and maybe with a explanation how to clone
the tree without getting the history from ten years ago):
http://www.h-online.com/open/features/Good-and-quick-kernel-configuration-creation-1403046.html
(that's a translation of a German text I wrote a decade ago...)

* the kernel docs contain a text explaining bisection, but it iirc is
brief and quite hard to understand for users that are new to this.
That's why I think it would be wise to improve or even rewrite the text,
to make it more accessible.

> financial support) for such further
> documentation on the development process, please reach out to me and I
> will see what I can do.

Sounds great. I might do that sooner or later for the two ideas I
outlined above, but that is unlikely to happen in the next few months.

> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Great, thx!

Ciao, Thorsten
