Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D134D463525
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbhK3NNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbhK3NNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:13:50 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA1C061574;
        Tue, 30 Nov 2021 05:10:30 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ms2tv-0007Va-VE; Tue, 30 Nov 2021 14:10:28 +0100
Message-ID: <72e4756f-c410-6c78-696f-b5e4bfebc135@leemhuis.info>
Date:   Tue, 30 Nov 2021 14:10:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
To:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <8735nesj3r.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
In-Reply-To: <8735nesj3r.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1638277831;9618bac3;
X-HE-SMSGID: 1ms2tv-0007Va-VE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.21 23:16, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> Introduce the tags 'Reported:' and 'Reviewed:' in addition to 'Link:',
>> as the latter is overloaded and hence doesn't indicate what the provided
>> URL is about. Documenting these also provides clarity, as a few
>> developers have used 'References:' to point to problem reports;
>> nevertheless 'Reported:' was chosen for this purpose, as it perfectly
>> matches up with the 'Reported-by:' tag commonly used already and needed
>> in this situation already.
>>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> To: workflows@vger.kernel.org
> 
> Thanks for flooding my inbox during a holiday week :)

We didn't have one here. :-D But hey, it wasn't out of envy, I'm a
little ignorant to local holiday/festival seasons, too.

>  Just looking at this now.
> 
>> v1/RFC:
>> - first, *rough version* to see how this idea is received in the
>>   community
>> ---
>>  Documentation/maintainer/configure-git.rst   |  6 +--
>>  Documentation/process/5.Posting.rst          | 54 ++++++++++++++------
>>  Documentation/process/submitting-patches.rst | 22 ++++----
>>  3 files changed, 53 insertions(+), 29 deletions(-)
>>
>> diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
>> index 80ae5030a590..8429d45d661c 100644
>> --- a/Documentation/maintainer/configure-git.rst
>> +++ b/Documentation/maintainer/configure-git.rst
>> @@ -40,12 +40,12 @@ Creating commit links to lore.kernel.org
>>  The web site http://lore.kernel.org is meant as a grand archive of all mail
>>  list traffic concerning or influencing the kernel development. Storing archives
>>  of patches here is a recommended practice, and when a maintainer applies a
>> -patch to a subsystem tree, it is a good idea to provide a Link: tag with a
>> +patch to a subsystem tree, it is a good idea to provide a Reviewed: tag with a
>>  reference back to the lore archive so that people that browse the commit
>>  history can find related discussions and rationale behind a certain change.
>>  The link tag will look like this:
>>  
>> -    Link: https://lore.kernel.org/r/<message-id>
>> +    Reviewed: https://lore.kernel.org/r/<message-id>
> 
> The *link* tag will look like that?

Ha, good point, will fix that.

> [...]
>> +The tags in common use are:
>> +
>> + - ``Reported:`` points to a report of a problem fixed by this patch. The
>> +   provided URL thus might point to a entry in a bug tracker or a mail in a
>> +   mailing list archive. Typically this tag is followed by a "Reported-by:"
>> +   tag (see below).
>> +
>> + - ``Link:`` points to websites providing additional backgrounds or details,
>> +   for example a document with a specification implemented by the patch.
> 
> So this is a serious change from how Link: is used now, and runs counter
> to the scripts used by a lot of maintainers.  I suspect that this thread
> is only as short as it is because a lot of people haven't seen this yet;
> it could be a hard change to sell.

Yeah, I'm aware of that. And to be honest: I don't have a strong
interest in this, just think it might be the right thing to do. And I
just got the impression that regzbot's dependence on the Link: tag for
linking to regression reports is making the ambiguity of the tag worse.
That lead to the thought: well, simply bring it up now and see what
people think; if they don't like it, I can tell myself "well, I tried to
improve it, but it was not welcomed" and sleep well at night. At least
as long as my cat allows me to. :-)

> Also, I think that documents like specs should be called out separately
> in the changelog, with text saying what they actually are.

I wonder a little if that is worth the trouble, but hey, why not, fine
with me.

>> + - ``Reviewed:`` ignore this, as maintainers add it when applying a patch, to
>> +   make the commit point to the latest public review of the patch.
> 
> Another question would be: what's the interplay between the (quite
> similar) "Reviewed" and "Reviewed-by" tags (and the same for the report
> tags).

Hmmm, I liked the interplay for Reported/Reported-by, but yeah, for
Reviewed/Reviewed-by I see the problem now.

>  If there's a "Reviewed" do we still need "Reviewed-by"?  That
> should be spelled out, whichever way is wanted.

I didn't want to undermine or obsolete "Reviewed-by" at all. I sometimes
wonder if this and "Tested-by" should be stored somewhere else (in "git
notes" or something), so they can be extended after a change got
committed -- but that's a whole different topic and something I'm even
less interested in driving forward. :-D

Maybe "Reviewed" was simply the wrong term. Maybe "Review:", "Posted:",
or "MergeRequest:" would be better in general and avoid this problem.

> I do worry that the similarity is going to lead to a certain amount of
> confusion and use of the wrong tag.  People have a hard time getting all
> the tags we have now right; adding more that look almost like the
> existing ones seems like a recipe for trouble.
> 
> For these reasons, I would be more inclined toward Konstantin's
> suggestion of adding notes to the existing Link: tags.

Yeah, maybe, but that results in long lines and forces people to type more.

>> +A third kind of tags are used to document which developers were involved in
>> +the development of the patch. Each of these uses this format::
>>  
>>  	tag: Full Name <email address>  optional-other-stuff
>>  
>>  The tags in common use are:
>>  
>> - - Signed-off-by: this is a developer's certification that he or she has
>> + - ``Signed-off-by:`` is a developer's certification that he or she has
> 
> So this markup addition is a separate change that would belong in its
> own patch.

Okay.

>  Do we really need it, though?  It clutters the text and
> irritates the anti-RST minority (which has been mercifully quiet
> recently) without really adding any benefit.

I'm not strongly attached to it. I added it after I noticed that it's at
least for me slightly unclear if the colon is part of the tag or used to
precede the explanation for the tag (in the 'Signed-off-by' case it's
both at the same time). And after adding the proposed tags the html view
imho looked a lot better.

Thx for the feedback!

Ciao, Thorsten
