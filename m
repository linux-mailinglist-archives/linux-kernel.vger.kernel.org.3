Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B4482EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiACHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiACHgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:36:33 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B095C061761;
        Sun,  2 Jan 2022 23:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Bx7NtCk13O3MYnOesPcQB/UnVRax9ZEBIq5svXtVmbM=; b=jAnUvCaO8PLbHhvB8G7hoc8pJn
        aKYylEnGeyhVDrH6QhTNanVYzpdkjE10nnn4UJUSbScGudrZuxk67km/SOqLdzEFHTtXFxLQuLGGw
        y+41rII6BRxKrc5URUl9UB8Sf8EoWipTUOJ5/EJhxACZqRVvuiV68y2ZNlgeRuA24Uuc0JpvYSJyc
        HQ10QO5Up4W+j0buZtw5XpfIwW0ls9fra+ztPdlSM1VDOwiK2TgQLgpxCg/QORXOJ5yZ7X0Fnuyn8
        Kloz3c3IhP/42FXKO0eS5cWnTyK5TuOJ9Zdk9Pq019whwiL4vxKzwIZgfd5SIbbCCbEdH/rMp8np2
        gATh4hmw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4HtM-0054kh-Hu; Mon, 03 Jan 2022 07:36:28 +0000
Message-ID: <7a9999a4-257c-3428-779e-0fdbf02d4782@infradead.org>
Date:   Sun, 2 Jan 2022 23:36:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v1] docs: 5.Posting.rst: describe Fixes: and Link: tags
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <2b9c093339322e2686140a486b978c0b03476f42.1641194004.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2b9c093339322e2686140a486b978c0b03476f42.1641194004.git.linux@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/2/22 23:15, Thorsten Leemhuis wrote:
> Explain Fixes: and Link: tags in Documentation/process/5.Posting.rst,
> which are missing in this file for unknown reasons and only described in
> Documentation/process/submitting-patches.rst.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
> Lo! If there is still a chance I'l like to get this patch into v5.17, as

                                 I'd

> during my work as regression tracker I noticed quite a few developers
> seem to be unaware how the Link: tag should be used. Maybe in parts
> that's because Documentation/process/5.Posting.rst doesn't describe it
> yet, which described things from a another different angle than
> Documentation/process/submitting-patches.rst.
> 
> Ciao, Thorsten
> 
> v1:
> - First version as stand alone patch. It used to be the first patch of
>   this series that got abandoned after RFC/v2:
>   https://lore.kernel.org/all/cover.1639042966.git.linux@leemhuis.info/
>   Patch itself is unchanged, patch description slighly changed. Might

                                                 slightly

>   later submit other changes from that series seperately, too, still

                                                separately,

>   unsure.
> ---
>  Documentation/process/5.Posting.rst | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index 855a70b80269..e7b919070210 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -197,14 +197,29 @@ the build process, for example, or editor backup files) in the patch.  The
>  file "dontdiff" in the Documentation directory can help in this regard;
>  pass it to diff with the "-X" option.
>  
> -The tags mentioned above are used to describe how various developers have
> -been associated with the development of this patch.  They are described in
> -detail in
> -the :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
> -document; what follows here is a brief summary.  Each of these lines has
> -the format:
> +The tags already briefly mentioned above are used to provide insights how
> +the patch came into being. They are described in detail in the
> +:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
> +document; what follows here is a brief summary.
>  
> -::
> +One tag is used to refer to earlier commits which had problems fixed by
> +the patch::
> +
> +	Fixes: 1f2e3d4c5b6a ("The first line of the commit specified by the first 12 characters of its SHA-1 ID")
> +
> +Another tag is used for linking web pages with additional backgrounds or
> +details, for example a report about a bug fixed by the patch or a document
> +with a specification implemented by the patch::
> +
> +	Link: https://example.com/somewhere.html  optional-other-stuff
> +
> +Many maintainers when applying a patch also add this tag to link to the
> +latest public review posting of the patch; often this is automatically done
> +by tools like b4 or a git hook like the one described in
> +'Documentation/maintainer/configure-git.rst'.
> +
> +A third kind of tags are used to document who was involved in the development of

                of tag is used

> +the patch. Each of these uses this format::
>  
>  	tag: Full Name <email address>  optional-other-stuff
>  
> 
> base-commit: b36064425a18e29a3bad9c007b4dd1223f8aadc5

-- 
~Randy
