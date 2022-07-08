Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529E856BC61
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiGHO7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiGHO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:59:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351051EED2;
        Fri,  8 Jul 2022 07:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6D00628AC;
        Fri,  8 Jul 2022 14:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AC4C341CD;
        Fri,  8 Jul 2022 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657292357;
        bh=aiPOdm248eh6i+dFXA/U9LFbDV6bPilDGjIPCHIxIiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YMiAWYkZYQ7+nUj9qeb2MWfQhFxSyCsvrctKQ+rKTDb+XqZZgYXcObmb1RuIRK+PM
         pjKulDNPrLFvKk2dvpPIiPwRtCIKsGuMXOxeKLJXPD8Sa3e+TzTOe9aySQ5AmXuoZB
         rOWzHc2PcMwS/joxv38tSXWKY0GBWChepvQTsSzk0J+tGYE41HjrWgC552QHUUsUyv
         uFES3lx+j7dGVbziDXA5X/cTcqQL2IQGohPqPi07MrQXcAz3Q0E7fPdWxVKRRI58Vn
         ulQbA2JuDYZSKNraQz1rBKQ1hxBz1LOb9KaGQDnHuawVvwp/S853nBn4OzA8IJ7YtM
         vSVR7ic7cioWA==
Date:   Fri, 8 Jul 2022 15:59:10 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org
Subject: Re: Expectation to --no-pdf option (was Re: [PATCH v2 0/5] Address
 some issues with sphinx detection)
Message-ID: <20220708155910.7c4ea35c@sal.lan>
In-Reply-To: <87bktzhfcj.fsf@meer.lwn.net>
References: <cover.1656756450.git.mchehab@kernel.org>
        <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
        <20220707211558.438a27d4@sal.lan>
        <3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com>
        <87bktzhfcj.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 08 Jul 2022 08:02:52 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Akira Yokosawa <akiyks@gmail.com> writes:
> 
> > In my tests, the mathjax extension works with all the versions of Sphinx
> > I tested (1.7.9, 2.4.4, 3.4.3 (debian bullseye), 4.2.0 (openSUSE LEAP 15.4),
> > and 5.0.2).
> > Note that math expressions should look much sharper (vector fonts)
> > than those from imgmath (pixel images).
> > The time for a browser to complete the rendering might be longer than
> > with imgmath, especially for pages with a lot of math expressions,
> > though.  (Yes, I see some of media documents have a lot of them.)
> >
> > When you are detached from network connections, browsers will give
> > up and show those expressions in mathjax source code. 

> -extensions.append("sphinx.ext.imgmath")
> +extensions.append("sphinx.ext.mathjax")

There are two problems with this:

1. mathjax doesn't work for PDF output - nor would work if we add support
   for man pages some day;
2. Some Kernel developers disable javascript.

As imgmath works everywere, we opted to use it instead. We were
actually hoping that the lack of proper math support on Sphinx were
something that later Sphinx versions after 1.3.1 would have fixed. 
> 
> Pulling in a bunch of JavaScript from the net while browsing the kernel
> docs is not an entirely pleasing solution either.  But perhaps it's
> preferable to loading the system with Latex. 

If we could change conf.py to either load either one depending if it is
building PDF or not would be the best. The technical problem is that the 
javascript solution is not compatible with PDF output.

> I kind of wish we could
> just do without the fancy math processing entirely, but I lost that
> battle some time ago...:)

The media uAPI book uses math, and also vm/memory-model.rst. The last
one could easily use just a C code.

yet, it sounds funny to not have it used inside DRM. GPU processing
does lots of math. i would expect to have math used there for things
similar to the usages on media.

Trying to describe the colorspace conversion expressions there without
math would be really painful:

	https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/colorspaces-details.html?highlight=detailed+colorspace

Anyway, if you have some other solution, I'd gladly use something else.

> 
> Mauro, have you looked at that option?

Yes, but it got discarded due to pdf output. Not sure if this would work
on epub either.

> 
> Thanks,
> 
> jon
