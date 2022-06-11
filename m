Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EE5477EA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 01:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiFKXZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 19:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFKXZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 19:25:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4426C3E0E4;
        Sat, 11 Jun 2022 16:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C772EB80B4B;
        Sat, 11 Jun 2022 23:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDD7C34116;
        Sat, 11 Jun 2022 23:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654989919;
        bh=kt58fye0OvkKlNPCoqcE//wrcrWCQBuwW6FUcECoqYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n5pcTGtPOoY/+MPc9NA7wlmYfkABIUeLxO9fAUTmgHzNn/6qwtXZYptU7Whu0CJSk
         CZ496VssUPK+mU+VSQhuP8+00iLsHwTrL4rhZ7S4vJtD2Z65noLFuEk0EFAphqNq47
         MtdaUMIZVNleZe+Y/2jtxN4eyTw2Nl+5JiAHD6mTFYdd/8CaUFHJa2IqV9/8QDL6HT
         9NYlsKTTjeqyuymmbltcmxM4SVc6cX5EfjrCVScK0YrezpsNkXVCpx1BcCweIuA8dw
         ehCEJkfWbN8JpG588mXWZvyThKBlus5KklymJJhM+baA7ta73w4xq3KCwuKmdAocDx
         t1Q3y542zOI8Q==
Date:   Sun, 12 Jun 2022 00:25:12 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/5] docs/doc-guide: Update guidelines for title
 adornments
Message-ID: <20220612002512.1150fc83@sal.lan>
In-Reply-To: <c25c29c7-28a6-65d4-8eb2-ac857894c1ba@gmail.com>
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
        <732154bc-aa35-2326-2b64-87b6c4dd02e7@gmail.com>
        <871qvw2898.fsf@intel.com>
        <CANiq72n3MQnjenbQGBUKD+SqNzdGUyJW9zjTOVY4+6cKBRc9ig@mail.gmail.com>
        <c25c29c7-28a6-65d4-8eb2-ac857894c1ba@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 11 Jun 2022 12:15:54 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Fri, 10 Jun 2022 18:08:43 +0200,
> Miguel Ojeda wrote:
> > On Fri, Jun 10, 2022 at 11:11 AM Jani Nikula
> > <jani.nikula@linux.intel.com> wrote:  
> Thank Jani and Miguel for chiming in!
> As this is a RFC patch, I'm glad to have nice comments from both of you.
> 
> >>
> >> When I wrote the original guidelines, it was my subjective decision to
> >> steer towards using the same title adornment styles and ordering across
> >> the kernel documentation. I intentionally left out all the
> >> reStructuredText details about this, because the definitive
> >> documentation is the reStructuredText documentation we can refer to.
> >>
> >> While the "Nth level title" is a more precise description, I'm not sure
> >> it's actually helpful without describing how these levels should map to
> >> kernel documentation structure. (Not saying the original did that
> >> either, but then there wasn't much structure to speak of.)  
> I agree that we need to cover in doc-guide the way the kernel documentation
> is organized and managed.  Total lack of such documentation is kind of
> surprising to me.
> 
> > 
> > To give a bit of context: this patch followed from a question I asked
> > to Jonathan and Akira privately. Currently it is hard to tell the
> > "nesting level", and even worse, existing files are not consistent and
> > checking is not automated. Therefore, an easy way to handle this is to
> > request to follow the same pattern regardless of nesting across the
> > tree.

The thing is that there were *lots* of Kernel documents that were already
following ReST syntax, some requiring minor adjustments.

Yet, each one used its own way to indent the several levels. On most
of those, the indentation was:

	First
	=====

	Second
	------

Having to rewrite all tags at the entire document with no real gain,
while having a batch of thousands of documents left to be converted
from .txt to .rst was simply a waste of resources. At the documents
I converted myself, I just kept whatever level indentation it was
already there.

Going further, even now I would really prefer not needing to review
patches that are just changing the tags for each indentation level.
Again, this would be a waste of resources. I would very much like
to receive more patches adding kernel-doc documentation and ReST
changes to document the Kernel core APIs.

Now, for *new* documents, I agree that it makes sense to use a
standard way, at least up to level 3, like:

	=====
	First
	=====

	Second
	======

	Third
	-----

Which is quite intuitive to me. 

> >   
> >> Improving the documentation on documentation is great, but I think it's
> >> a bad sign when length of the notes and warnings on something far exceed
> >> the length of the thing being documented. The bulk of the text should be
> >> helpful enough for people to DTRT, while leaving out exhaustive
> >> descriptions of all the details that should just be references to
> >> reStructuredText documentation.  
> 
> So, I was not aware of such a hidden rule on what should _not_ be in
> doc-guide.  :-)
> In my opinion, RST documentation is not easy to follow especially for
> new contributors, and putting some useful tips somewhere in doc-guide
> would improve situation.
> 
> I agree with you that those notes and warning don't belong to guidelines.
> 
> Maybe add a section collecting RST tips and tricks mainly consisting
> of pointers to RST and docutils documentation.
> 
> > 
> > Perhaps we can move the rationale to the commit message, and keep only
> > the current rules in the document. What about something like:
> > 
> > """
> > Please stick to this relative order of adornments within each file
> > (i.e. regardless of nesting level across the kernel tree):
> > 
> >     1. ``=`` with overline.
> >     2. ``=``.
> >     3. ``-``.
> >     4. ``~``.

At least at the charset I use here, `~` is bigger than `-`. For me, it sounds
counter-intuitive to use it there... Personally, i prefer `^` for the
4th level.

Yet, the forth level (and the following ones) generally happen when someone
needs to add something to an already-existing document. I doubt anyone that
already works with ReST would ever look at the doc-guide if they need to 
add a 4th/5th/... level on an already existing documents.

So, IMO, it is pointless to define or expect that all docs would use the
same level markup after the third level.


> > For instance::
> > 
> >     =====
> >     First
> >     =====
> > 
> >     Second
> >     ======
> > 
> >     Third
> >     -----
> > 
> >     Fourth
> >     ~~~~~~
> > """  
> 
> I'm more inclined to keep "level"s in the example.

Agreed.

Regards,
Mauro
