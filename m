Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF46462492
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhK2WVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:21:23 -0500
Received: from ms.lwn.net ([45.79.88.28]:53558 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234017AbhK2WT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:19:59 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B5EC62CA;
        Mon, 29 Nov 2021 22:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B5EC62CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1638224200; bh=iTY2/h04UezM1V4M7XZgBk0FWcWxT9Syov9TVxzHjFE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RhFQy3d6hB3kKajco72EVJtAjF4CN0+4BU2CNPr3lsAX0gkg+pA0UicUHclGgHdZK
         YZ6EU0zHf46kFqdEPwysyZa1A+FEIyl37q6VD5GMk+xTyjM5/+CizHRLS6dS/rFbAl
         y/PTDx66u4qjRkCMJTQM58fkXZ+/Wk24YAusD+n9jFFXuN+H+9VtMgHwzR70o8fSow
         nTNtSF/83dOSIcR1N5fk/eeN2lbMRK8X7TtCBNEmNDcGKTclyf4O80Be86IQjxUFMR
         wok32rcbbMNXwWneh8Qu/5KD4nNcO1ee0K4lZyH6ckPhzvIczl5vYJFJZRbeSPVYMm
         xjsX1WH5P2vOQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
In-Reply-To: <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
Date:   Mon, 29 Nov 2021 15:16:40 -0700
Message-ID: <8735nesj3r.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Introduce the tags 'Reported:' and 'Reviewed:' in addition to 'Link:',
> as the latter is overloaded and hence doesn't indicate what the provided
> URL is about. Documenting these also provides clarity, as a few
> developers have used 'References:' to point to problem reports;
> nevertheless 'Reported:' was chosen for this purpose, as it perfectly
> matches up with the 'Reported-by:' tag commonly used already and needed
> in this situation already.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> To: workflows@vger.kernel.org

Thanks for flooding my inbox during a holiday week :)  Just looking at
this now.

> v1/RFC:
> - first, *rough version* to see how this idea is received in the
>   community
> ---
>  Documentation/maintainer/configure-git.rst   |  6 +--
>  Documentation/process/5.Posting.rst          | 54 ++++++++++++++------
>  Documentation/process/submitting-patches.rst | 22 ++++----
>  3 files changed, 53 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
> index 80ae5030a590..8429d45d661c 100644
> --- a/Documentation/maintainer/configure-git.rst
> +++ b/Documentation/maintainer/configure-git.rst
> @@ -40,12 +40,12 @@ Creating commit links to lore.kernel.org
>  The web site http://lore.kernel.org is meant as a grand archive of all mail
>  list traffic concerning or influencing the kernel development. Storing archives
>  of patches here is a recommended practice, and when a maintainer applies a
> -patch to a subsystem tree, it is a good idea to provide a Link: tag with a
> +patch to a subsystem tree, it is a good idea to provide a Reviewed: tag with a
>  reference back to the lore archive so that people that browse the commit
>  history can find related discussions and rationale behind a certain change.
>  The link tag will look like this:
>  
> -    Link: https://lore.kernel.org/r/<message-id>
> +    Reviewed: https://lore.kernel.org/r/<message-id>

The *link* tag will look like that?

[...]

> +The tags in common use are:
> +
> + - ``Reported:`` points to a report of a problem fixed by this patch. The
> +   provided URL thus might point to a entry in a bug tracker or a mail in a
> +   mailing list archive. Typically this tag is followed by a "Reported-by:"
> +   tag (see below).
> +
> + - ``Link:`` points to websites providing additional backgrounds or details,
> +   for example a document with a specification implemented by the patch.

So this is a serious change from how Link: is used now, and runs counter
to the scripts used by a lot of maintainers.  I suspect that this thread
is only as short as it is because a lot of people haven't seen this yet;
it could be a hard change to sell.

Also, I think that documents like specs should be called out separately
in the changelog, with text saying what they actually are.

> + - ``Reviewed:`` ignore this, as maintainers add it when applying a patch, to
> +   make the commit point to the latest public review of the patch.

Another question would be: what's the interplay between the (quite
similar) "Reviewed" and "Reviewed-by" tags (and the same for the report
tags).  If there's a "Reviewed" do we still need "Reviewed-by"?  That
should be spelled out, whichever way is wanted.

I do worry that the similarity is going to lead to a certain amount of
confusion and use of the wrong tag.  People have a hard time getting all
the tags we have now right; adding more that look almost like the
existing ones seems like a recipe for trouble.

For these reasons, I would be more inclined toward Konstantin's
suggestion of adding notes to the existing Link: tags.

> +A third kind of tags are used to document which developers were involved in
> +the development of the patch. Each of these uses this format::
>  
>  	tag: Full Name <email address>  optional-other-stuff
>  
>  The tags in common use are:
>  
> - - Signed-off-by: this is a developer's certification that he or she has
> + - ``Signed-off-by:`` is a developer's certification that he or she has

So this markup addition is a separate change that would belong in its
own patch.  Do we really need it, though?  It clutters the text and
irritates the anti-RST minority (which has been mercifully quiet
recently) without really adding any benefit.

Thanks,

jon
