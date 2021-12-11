Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0954714E1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhLKRNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 12:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhLKRNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:13:05 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937FEC061714;
        Sat, 11 Dec 2021 09:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=FtEEvNYzIIV30TW9aa2QNWVH5p4vZD+jTMyATj033bs=; b=VCNCFWUeWm4Ai+ylUU6uaKXfD1
        97yeNlRQnLrkoF7Y8X2+b9iQt6pcjBdPn7X8dQgeg/+XqxF81Jeh7uDGUt7P+K3UavTEo5rkVr5TJ
        cWAKnAAbvwlNgzT//uQCAYQNlU6mMzmwJPTfNjNCVx/A3rSnjSjCPbG0NfiEsbrvxWQ1b2r8kFXXq
        D67alaSIzo/4hQrqJO7j1+rnTAzvmjHuEb2CGkoMzAfaejUHjtrNMUerKGZNky7OnOXbewzCn7B6Q
        Mi95k0Rqbgri+cyU3V87V7T9oExXZn6p9W+3X59rFEMjsJiRUMg222YLJmnxjL+sY9DaexUeZkUAA
        wUwJRC9Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mw5vd-000mAc-Qw; Sat, 11 Dec 2021 17:12:59 +0000
Message-ID: <58cb0905-3725-1aa7-4a32-317fa96e89f8@infradead.org>
Date:   Sat, 11 Dec 2021 09:12:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] docs: address some text issues with css/theme support
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>, Akira Yokosawa <akiyks@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1639212812.git.mchehab+huawei@kernel.org>
 <b0b166025019f7cc4f122bd789c79ba28cc2d29d.1639212812.git.mchehab+huawei@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <b0b166025019f7cc4f122bd789c79ba28cc2d29d.1639212812.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/21 00:57, Mauro Carvalho Chehab wrote:
> Fix:
> - overriden ->overridden
> - some whitespace issues introduced at the css/theme
>   Makefile help.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1639212812.git.mchehab+huawei@kernel.org/
> 
>  Documentation/Makefile             | 4 ++--
>  Documentation/doc-guide/sphinx.rst | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index c9543b63dc6a..9f4bd42cef18 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -159,8 +159,8 @@ dochelp:
>  	@echo  '  make SPHINX_CONF={conf-file} [target] use *additional* sphinx-build'
>  	@echo  '  configuration. This is e.g. useful to build with nit-picking config.'
>  	@echo
> -	@echo '   make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'
> +	@echo  '  make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'
>  	@echo
> -	@echo '   make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
> +	@echo  '  make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
>  	@echo
>  	@echo  '  Default location for the generated documents is Documentation/output'
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index 7fb6e6168bbb..673cbb769c08 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -147,7 +147,7 @@ By default, the build will try to use the Read the Docs sphinx theme:
>  
>  If the theme is not available, it will fall-back to the classic one.
>  
> -The Sphinx theme can be overriden by using the ``DOCS_THEME`` make variable.
> +The Sphinx theme can be overridden by using the ``DOCS_THEME`` make variable.
>  
>  To remove the generated documentation, run ``make cleandocs``.
>  
> 

-- 
~Randy
