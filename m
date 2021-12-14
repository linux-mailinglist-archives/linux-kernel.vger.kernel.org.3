Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E59A474C51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbhLNTzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhLNTzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:55:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA2C061574;
        Tue, 14 Dec 2021 11:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=iv01Pf6xrNRqNbiIiHIBFnovLsVBu7ZpwLTFS0Q02fI=; b=Zrj5wbU0SzoFaiXAjqyfK4imuu
        WGxMd6r5exANbz/MatXyC7/8JsmQyHFzvrh110c5ERevUEY6sFgoM5D7WleVK64TQrnuYN6lXa6n4
        nvRF0exoUYNCOzmhPnp0mAfuODaD8aJZNG4r/o/Tv4B802LZOneEU5OAM5BxkJVYE39tKvw1nYxIs
        LSIifhxvTKf15bDprYom2PXJHlC0YYbKmVMqmh6nCGAW53cOA0xlGui00qLgeGllCFu1n+MecSmdM
        lcGYpidpzHagFuMAcSoKKnT2fXeJwV3UhOVHby3Q2gpF1BCjFvdG4kIqcbTCd+O7gqSmfK95PIrKi
        GdzsonIQ==;
Received: from [2601:1c0:6280:3f0:7629:afff:fe72:e49d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxDtF-00Ffi4-9i; Tue, 14 Dec 2021 19:55:09 +0000
Subject: Re: [RFC PATCH] Remove mentions of the Trivial Patch Monkey
To:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211214191415.GA19070@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0f74ba31-aba2-0608-b383-9ab46766485b@infradead.org>
Date:   Tue, 14 Dec 2021 11:55:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211214191415.GA19070@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/21 11:14 AM, Miguel Ojeda wrote:
> Apparently, it was decided that trivial@kernel.org
> is no longer used.
> 
> Link: https://lore.kernel.org/lkml/fe86efbd-4e03-76c8-55cf-dabd33e85823@infradead.org/
> Co-developed-by: Joe Perches <joe@perches.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Cc: akpm

Thanks.

> ---
> Sending this before we forget about it...
> 
> We may want to keep the definition of "trivial patch" somewhere else.
> 
>  Documentation/process/submitting-patches.rst | 19 -------------------
>  MAINTAINERS                                  |  6 ------
>  2 files changed, 25 deletions(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 6b3aaed66fba..31ea120ce531 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -271,25 +271,6 @@ least a notification of the change, so that some information makes its way
>  into the manual pages.  User-space API changes should also be copied to
>  linux-api@vger.kernel.org.
>  
> -For small patches you may want to CC the Trivial Patch Monkey
> -trivial@kernel.org which collects "trivial" patches. Have a look
> -into the MAINTAINERS file for its current manager.
> -
> -Trivial patches must qualify for one of the following rules:
> -
> -- Spelling fixes in documentation
> -- Spelling fixes for errors which could break :manpage:`grep(1)`
> -- Warning fixes (cluttering with useless warnings is bad)
> -- Compilation fixes (only if they are actually correct)
> -- Runtime fixes (only if they actually fix things)
> -- Removing use of deprecated functions/macros
> -- Contact detail and documentation fixes
> -- Non-portable code replaced by portable code (even in arch-specific,
> -  since people copy, as long as it's trivial)
> -- Any fix by the author/maintainer of the file (ie. patch monkey
> -  in re-transmission mode)
> -
> -
>  
>  No MIME, no links, no compression, no attachments.  Just plain text
>  -------------------------------------------------------------------
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13f9a84a617e..c88bac733e9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19334,12 +19334,6 @@ W:	https://github.com/srcres258/linux-doc
>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>  F:	Documentation/translations/zh_TW/
>  
> -TRIVIAL PATCHES
> -M:	Jiri Kosina <trivial@kernel.org>
> -S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
> -K:	^Subject:.*(?i)trivial
> -
>  TTY LAYER
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Jiri Slaby <jirislaby@kernel.org>
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
https://people.kernel.org/tglx/notes-about-netiquette
