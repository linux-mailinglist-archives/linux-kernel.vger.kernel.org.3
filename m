Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893D54A6BF9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 07:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245290AbiBBGxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 01:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244751AbiBBGwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:38 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32CC061755;
        Tue,  1 Feb 2022 22:08:26 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nF8oW-0002ui-WD; Wed, 02 Feb 2022 07:08:21 +0100
Message-ID: <7a1e66cc-a1c5-54c7-ca7d-04a389beb8b2@leemhuis.info>
Date:   Wed, 2 Feb 2022 07:08:20 +0100
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
 <978ad91647e93b20b7fe12c3f237f6de8f9eaca1.1643710947.git.linux@leemhuis.info>
 <87bkzq5fxu.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v4 3/3] docs: reporting-issues.rst: link new document
 about regressions
In-Reply-To: <87bkzq5fxu.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1643782106;67ce4a9f;
X-HE-SMSGID: 1nF8oW-0002ui-WD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.22 00:23, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> Make Documentation/admin-guide/reporting-issues.rst point to the newly
>> created document about regressions
>> (Documentation/admin-guide/regressions-users.rst). This allows to
>> shorten a few explanations the new document describes better and in more
>> detail.
>>
>> While at it move the copyright hint to the end of the file, as suggested
>> during review of the new documents about regressions.
>>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> ---
>>  .../admin-guide/reporting-issues.rst          | 60 +++++++++----------
>>  1 file changed, 29 insertions(+), 31 deletions(-)
> 
> [...]
> 
>> +You deal with a regression if some application or practical use case running
>> +fine with one Linux kernel works worse or not at all with a newer version
>> +compiled using a similar configuration. The document
>> +'Documentation/admin-guide/regressions-users.rst' explains this in more detail.
> 
> Some of those quotes around file names are still sneaking in.

I did that on purpose here, as the file right now uses single quotes for
doc references almost everywhere and I thought I better stick to its
style -- especially as one such a quoted references is pretty close by
in this case, so it would look odd to quote one but not the other:

```
[...] compiled using a similar configuration. The document
 'Documentation/admin-guide/regressions-users.rst' explains this in more
detail.
 It also provides a good deal of other information about regressions you
might
 want to be aware of; it for example explains how to add your issue to
the list
 of tracked regressions, to ensure it won't fall through the cracks.



What qualifies as security issue is left to your judgment. Consider reading
 'Documentation/admin-guide/security-bugs.rst' before proceeding, as it
 [...]
```

Stupid me just forgot to use single quotes for the second link to
Documentation/admin-guide/regressions-users.rst. Will fix this up :-/

That being said: in a mail on Monday I already raised the issue like
this (slightly reworded):

----
I noticed I quoted internal references in reporting-issues.rst quite
often. IMHO it improves readability sometimes (it depends a lot on the
title of the target document), as can be seen in this example.

The source text looks like this:

```
If your kernel is tainted, study
'Documentation/admin-guide/tainted-kernels.rst' to find out why.
[...]
To find the change there is a process called 'bisection' which the
document 'Documentation/admin-guide/bug-bisect.rst' describes in detail.
```

After processing to HTML the text looks like this:

```
If your kernel is tainted, study ‘Tainted kernels‘ to find out why.
[...]
To find the change there is a process called ‘bisection’ which the
document ‘Bisecting a bug’ describes in detail.
```

Sure, "Tainted kernels" and "Bisecting a bug" are links and hence
displayed differently by the browser, but I think the quotes help. But YMMV.

I sooner or later hope to improve and fix a few things in
reporting-issues.rst anyway. Let me know if I should take the
opportunity to remove the single quotes then.
----

So I'd say: I add two more quoted doc links to the file now and fix this
up later, if you still think removing the quotes is a good idea. Or do
you want me to remove the single quotes now in that patch (or a separate
one?)? It's not a big deal, there are only about 10 docs references.

Ciao, Thorsten
