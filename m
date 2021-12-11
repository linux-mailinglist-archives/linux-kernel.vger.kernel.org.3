Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83E347116B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 05:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbhLKE2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 23:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345848AbhLKE2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 23:28:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1BC061714;
        Fri, 10 Dec 2021 20:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=GTjR2SdfhyxyI61g7E3lqfPsQYtygE21VYD0ZVCGTeQ=; b=lLRErdEAiTvBuPD78xufRb1Uh+
        7ZjQnYF9nSqKUc19RYdtHoOBRjWGEHkT+/6LGfDgGD2OIMsFJtX58lCRcWJxFTj8PZOCG7D8+uVBy
        dg1sN+h0gUIIVkbGwhZ3YGrYNfmDT4Og0Jo5riXNvozSgFTzqMRGYyat6mEa04TWk4/eoyVJ6RNCO
        zaCBBd/v4rZHlKdb+QnjqL/qRlUXd98DlalvDKBpLGB9AFCYW4G4x+4PNdImM6tQv+4GthBV6Grt1
        AnetaGCPY/spm1PXPkEXN7NF65C3avWF4uud4FCuYfs8GXK6Bueb7wg0vldK2tK68Dk3TzbJXnTW8
        RA2HNfgg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvtwI-00Awxe-R9; Sat, 11 Dec 2021 04:24:52 +0000
Message-ID: <0c911d14-88b4-85e7-07b1-183fd8a8c338@infradead.org>
Date:   Fri, 10 Dec 2021 20:24:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 2/4] docs: allow to pass extra DOCS_CSS themes via make
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>, Alex Shi <alexs@kernel.org>,
        linux-kernel@vger.kernel.org
References: <cover.1638870323.git.mchehab+huawei@kernel.org>
 <03d09bf41ad39aa0abfe2ea3c879b09aa3a0948d.1638870323.git.mchehab+huawei@kernel.org>
Content-Language: en-US
In-Reply-To: <03d09bf41ad39aa0abfe2ea3c879b09aa3a0948d.1638870323.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 12/7/21 01:53, Mauro Carvalho Chehab wrote:
> Specially when the RTD theme is not used, it makes sense to
> allow specifying extra CSS files via a make variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH v4 0/4] at: https://lore.kernel.org/all/cover.1638870323.git.mchehab+huawei@kernel.org/
> 
>  Documentation/Makefile             | 8 +++++++-
>  Documentation/conf.py              | 7 +++++++
>  Documentation/doc-guide/sphinx.rst | 3 +++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 11f8b3b9a7ef..9f0f53db2f10 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -20,6 +20,7 @@ SPHINXBUILD   = sphinx-build
>  SPHINXOPTS    =
>  SPHINXDIRS    = .
>  DOCS_THEME    =
> +DOCS_CSS      =
>  _SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
>  SPHINX_CONF   = conf.py
>  PAPER         =
> @@ -85,7 +86,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  	-D version=$(KERNELVERSION) -D release=$(KERNELRELEASE) \
>  	$(ALLSPHINXOPTS) \
>  	$(abspath $(srctree)/$(src)/$5) \
> -	$(abspath $(BUILDDIR)/$3/$4)
> +	$(abspath $(BUILDDIR)/$3/$4) && \
> +	if [ "x$(DOCS_CSS)" != "x" ]; then \
> +		cp $(DOCS_CSS) $(BUILDDIR)/$3/_static/; \
> +	fi
>  
>  htmldocs:
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
> @@ -157,4 +161,6 @@ dochelp:
>  	@echo
>  	@echo '   make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'
>  	@echo
> +	@echo '   make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'

The 2 new '   make DOCS_THEME/DOCS_CSS' lines are indented one more space than the
preceding  '  make SPHINX*' lines.

> +	@echo
>  	@echo  '  Default location for the generated documents is Documentation/output'


-- 
~Randy
