Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBFA464B70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348540AbhLAKUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:20:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47334 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348501AbhLAKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:20:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7717CCE1D91;
        Wed,  1 Dec 2021 10:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92ECDC53FCC;
        Wed,  1 Dec 2021 10:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638353809;
        bh=XzomCRP9HPlFxXOWu7bb++tXZ9myJAhOlLcfqQbpG+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CZA5FA1HX2UPH43QHdlVh+5ONMbpWWHw+lcnTkpQKHudSQbwEM2U6Bo8e2cM9jWaF
         pPmBmfQuQfvI2Rr7fOAxSIP1OqJTPFwE7DDkoiaJtak1+yAWn1HN7u23s1f5F8RraF
         prK7Q3qh3nP8E+4/iX58bJWqUAsXhtg0z101WJsAkffzwT2T1rTNQUrMm4rcpApmTE
         17OMKHjP4SrnrxocQE0QFvIuzfd0TI7PkKzwuIYHBJSKxzv6DY5DuHPkCVg1zPGzKS
         EI5XEnzFCnsEBAGqDvvzPQ9KMteNdZ/9Z7Go6cib94jir4yb52sTaGl38NjO/YytB7
         Ihf15/SOmo6sg==
Date:   Wed, 1 Dec 2021 11:16:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] docs: conf.py: fix support for Readthedocs v 1.0.0
Message-ID: <20211201111644.218b510a@coco.lan>
In-Reply-To: <4c6fe1f6-1a81-1181-f23a-df3f1b538cdf@infradead.org>
References: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
        <13c40ed9-a51f-7496-7224-03b563bb6695@gmail.com>
        <59f64802-c3dc-74cd-8f35-878e3fac64e2@infradead.org>
        <87sfvik21z.fsf@intel.com>
        <20211127102518.6e715036@coco.lan>
        <4c6fe1f6-1a81-1181-f23a-df3f1b538cdf@infradead.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 27 Nov 2021 07:59:13 -0800
Randy Dunlap <rdunlap@infradead.org> escreveu:

> > Perhaps one alternative to help with themes maintenance would be to
> > select one of the builtin themes from:
> > 
> > 	https://sphinx-themes.org/  
> 
> Looks to me like those are external to sphinx-doc.org. It says that
> they are maintained by @pradyunsg and @shirou. (don't know who they are)
> There are over 40 themes shown there.
> 
> OTOH, there is https://www.sphinx-doc.org/en/master/usage/theming.html#builtin-themes,
> which shows about 12 builtin themes to choose from. Pretty much like the
> list the you show just below here...
> 
> > 
> > if they're good enough and are present at the minimal Sphinx version
> > supported by Kernel documentation. The ones available on 1.7.9 are:
> > 
> > 	$ ls sphinx_1.7.9/lib/python3.10/site-packages/sphinx/themes
> > 	agogo  bizstyle  default  haiku   nonav    scrolls    traditional
> > 	basic  classic   epub     nature  pyramid  sphinxdoc
> > 
> > They all are also the same themes available at the latest version.
> > 
> > If we're willing to do so, I did a quick test here. Those seems to
> > produce a reasonable output:
> > 
> > 	- bizstyle
> > 	- nature
> > 	- classic  
> 
> Thanks for checking.
> 
> > If something would still be needed to change, the css override file could
> > still be used, but keeping it minimal helps to avoid the need of too
> > drastic changes.  
> 
> I'll take a look...

Just sent a patch to help testing/using a different theme:

	https://lore.kernel.org/lkml/8a33f4516c937556b9a38157e236b2f55ef67540.1638353179.git.mchehab+huawei@kernel.org/T/#u

After such patch, you could easily select a different theme during
documentation build, like:

	$ make cleandocs
        $ make SPHINXDIRS=input THEME=classic htmldocs
	$ make SPHINXDIRS=i2c THEME=nature htmldocs

The patch disables the CSS overrides when a theme different than RTD
is used, as the CSS changes there may not be the best with other
themes. It probably make sense to split the contents of the
CSS override to a generic theme, which contains only things that
would apply to all themes (like font selection) from other things
that are theme-dependent, like colors.

Thanks,
Mauro
