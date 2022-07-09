Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5F56C7CB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 10:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGIH75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 03:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 03:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C6654C91;
        Sat,  9 Jul 2022 00:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC5B60C97;
        Sat,  9 Jul 2022 07:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14F3C3411C;
        Sat,  9 Jul 2022 07:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657353592;
        bh=7jAiWLYz3PeSlOtmhefxB/mS+5thanzSxGjma8acUM4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DMdshz3DCA93e3kF8/hTyueCZsiEmTECnhGqIOFc169DQ4gvNUOap0HqxTXuZQuCK
         H7L4wuSC9dxw/bwBMVJ1a8T4mwDj1hPLLtW8xsAPieK2FSYe2CN6FIutTtgitCzMkj
         AS0nnLX0fOMiRzjjrk8w+sK5KZzWkCiSguYt3p07mzhehnv7mEhQJZAmJxEEv4qvUq
         Kf7QR6uRoXQ45+PEDse+BLdRW8pE/0n253Mr1MOxyV32ILiU18GJnwvJa2M1kFfzWL
         GGhtu3rDYEpwRi4Dx06Ce0k0YNWNP9RIviK2aGvH6bxjB906qoLcl2ejdq2N9HeD+0
         SXqfdswVLVPPQ==
Date:   Sat, 9 Jul 2022 08:59:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+huawei@kernel.org
Subject: Re: Expectation to --no-pdf option (was Re: [PATCH v2 0/5] Address
 some issues with sphinx detection)
Message-ID: <20220709085946.083025aa@sal.lan>
In-Reply-To: <02a76970-78fb-5d09-6890-cc1dc11ca4db@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
        <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
        <20220707211558.438a27d4@sal.lan>
        <3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com>
        <87bktzhfcj.fsf@meer.lwn.net>
        <20220708155910.7c4ea35c@sal.lan>
        <d54415bb-9bad-6fd8-5636-218c04d5615a@gmail.com>
        <02a76970-78fb-5d09-6890-cc1dc11ca4db@gmail.com>
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

Em Sat, 9 Jul 2022 08:01:02 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> [-CC: ksummit-discuss]
> On Sat, 9 Jul 2022 00:27:25 +0900, Akira Yokosawa wrote:
> > On Fri, 8 Jul 2022 15:59:10 +0100,
> > Mauro Carvalho Chehab wrote:  
> >> Em Fri, 08 Jul 2022 08:02:52 -0600
> >> Jonathan Corbet <corbet@lwn.net> escreveu:
> >>  
> >>> Akira Yokosawa <akiyks@gmail.com> writes:
> >>>  
> >>>> In my tests, the mathjax extension works with all the versions of Sphinx
> >>>> I tested (1.7.9, 2.4.4, 3.4.3 (debian bullseye), 4.2.0 (openSUSE LEAP 15.4),
> >>>> and 5.0.2).
> >>>> Note that math expressions should look much sharper (vector fonts)
> >>>> than those from imgmath (pixel images).
> >>>> The time for a browser to complete the rendering might be longer than
> >>>> with imgmath, especially for pages with a lot of math expressions,
> >>>> though.  (Yes, I see some of media documents have a lot of them.)
> >>>>
> >>>> When you are detached from network connections, browsers will give
> >>>> up and show those expressions in mathjax source code.   
> >>  
> >>> -extensions.append("sphinx.ext.imgmath")
> >>> +extensions.append("sphinx.ext.mathjax")  
> >>
> >> There are two problems with this:
> >>
> >> 1. mathjax doesn't work for PDF output - nor would work if we add support
> >>    for man pages some day;  
> > 
> > Hmm, if I understand what is written in the following page:
> >     https://www.sphinx-doc.org/en/master/usage/extensions/math.html
> > 
> > , both imgmath and mathjax extensions are relevant only for HTML output.
> > 
> > It says:
> > 
> >     Changed in version 1.8: Math support for non-HTML builders is integrated
> >     to sphinx-core. So mathbase extension is no longer needed.
> > 
> > When did you see the issue of "mathjax doesn't work for PDF output" ?  
> 
> For the record,
> 
> I tested mathjax and PDF output with Sphinx 1.7.9, whose latex mode
> can't handle nested tables.
> I had no problem in building userspace-api.pdf and math expressions
> in it look perfect.
> 
> So I believe mathjax does not affect PDF output.

Did you also test epubdocs?

It was an issue when we decided to use imgmath. If this got fixed for
both supported non-html outputs, we can start using mathjax and get
rid of installing latex and dvipng.

> Mauro wrote:
> > As imgmath works everywere, we opted to use it instead. We were
> > actually hoping that the lack of proper math support on Sphinx were
> > something that later Sphinx versions after 1.3.1 would have fixed.   
> 
> I'm not going to test earlier versions of Sphinx and I have no idea
> of what issue Mauro saw at the time, but it sounds to me the issue
> has been fixed since.

Good.
 
> >   
> >> 2. Some Kernel developers disable javascript.  
> > OK, mathjax has no chance, then...  
> 
> On the second thought, I think mathjax (latex-free "make htmldocs")
> is good enough for test build purposes.  When javascript is disabled,
> math expressions are rendered in mathjax source.

Hmm... are there a way to use it with javascript disabled? If so, maybe
we can force it to always render math expressions during the build, instead
or relying on javascript at exec time.

> As conf.py is programmable, it is possible to choose sphinx.ext.imgmath
> when dvipng is found on the build system.

Not sure I like the idea. This would actually mean in practice that
all developers that are currently doing doc builds will keep using
imgmath, because they all have it already installed.

> As for sphinx-pre-install, what about adding an option
> 
>     --no-js   For those who disable javascript in their browser.
> 
> which provide the list of required packages for dvipng?

It is not that simple.

Sphinx has a configurable theme engine. On our builds, we're using
since the beginning the RTD (readthedocs) theme as default, but
recent versions default to classic if sphinx_rtd_theme package is
not installed.

All themes I know that provide a search button use JS to implement
such feature.

So, a "--no-js" won't provide a javascript-free build environment.

-

On a side discussion, should we keep recommending the install of 
sphinx_rtd_theme? It is not mandatory anymore to have it installed,
and the theme is more a matter of personal preferences. 

Also, when testing or modifying the docs, the theme doesn't really
matter.

So, IMHO, we could stop recommending it.

Regards,
Mauro   
