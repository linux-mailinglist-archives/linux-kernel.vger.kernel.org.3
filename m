Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B795ABF1E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiICNZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiICNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:25:27 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A852AE0F;
        Sat,  3 Sep 2022 06:25:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::e2d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A713B4B0;
        Sat,  3 Sep 2022 13:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A713B4B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1662211525; bh=bJCWEkDDvhyPhDxPqXVdbXV2a+4oXAK3ZRM+enz8kG0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Uc0DEG3L+d4/xd4bF1ZOFWktJeDZvGSKsZjAB2ip9FdVyR817I+8HHBzLQ1y37g/T
         VmuzpARfEzJ1MoHGTupLoQEA8lV8wk6SRriU7b4fzoTkqJMUSxjcRDr4gksTC1YT+I
         Oe/VxUhhe1hvLed9dW3/KoOIj/08zcDYkHHJ7L8mcCfvEQQ8WLuhAOIsuZoVNqbJij
         4I571ZCbzaa7FUsoVU6d9MzWabe7scaDGDgehtzp+1zkcervBkkmt2Fh6hgKapyjV/
         XRtW9uCgJT4Nl5kHkXyd9sUlChdDyNhnBMUlXEkjocHdZYKMybdUkTLGbVp9JpLU/i
         1XST+oQXsGkMA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Rewrite the top-level index.rst
In-Reply-To: <938a9905-217c-f02a-b5c2-35c1e5d7822b@leemhuis.info>
References: <20220901231632.518583-1-corbet@lwn.net>
 <938a9905-217c-f02a-b5c2-35c1e5d7822b@leemhuis.info>
Date:   Sat, 03 Sep 2022 07:25:25 -0600
Message-ID: <87tu5ooaii.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Great initiative. But looking at the rendered result made me wonder:
> what overall structure for the docs are you aiming for in the end? I'm
> sure you have a picture in your head, but I failed to grasp it, as for
> me a few things looked a little odd:

Thanks for taking a look!

> * we do all of this for the users, so shouldn't the section aimed at
> users be at the top? And list more things they will look for?

My thinking is that the main consumers of the kernel docs is kernel
developers (I can't prove this, I just know it :), and that I see a lot
of referrals to the process documentation.  So I started with that.  I'm
not wedded to that organization if something else seems better.

> * What is so important about "Architecture-agnostic documentation" and
> "Architecture-specific documentation" (both with just one entry) that
> they have to be listed here? Same for "Firmware-related documentation".

I kind of ran out of energy after moving a lot of stuff from the front
page and wasn't sure what to do with them.  There's definitely room for
improvement. 

> And is the User-oriented section really the right place for the kbuild
> stuff, as from a quite look it seems most of those aim at developers and
> not at users?

I guess I saw building and installation as a *use* of the kernel.  This
one does sort of cross the lines and could certainly go somewhere else.
I was mostly trying to avoid a bunch of subsections with a single entry. 

> * Quite a few things I'd had expected on that front page aren't listed
> there. Sure, everybody has different expectations on what's important,
> but I for example hat expected "command-line parameters" or "Reporting
> issues" (here I'm obviously biased) to be somewhere on that page.

I'm happy to change the mix; "reporting issues" probably does belong
there, at least.  As long as we don't get back to the current state
where *everything* is on the front page.

> This made me think: should that main index page maybe just have these
> three sections (apart from Translations) ?
>
> * User-oriented documentation
> * Application-developer documentation
> * Other documentation on the Linux kernel and its development

That relegates an awful lot of our important stuff to "other"; as said
above, I think that the main consumers of the documentation are kernel
developers, and the documentation organization should reflect that.

> I'd say that makes it quite clear where readers need to go from there,
> even if the name of the third section is a bit vague (but in contrast it
> becomes clear I'd say).
>
> Each section could list its five to ten most important documents before
> linking to a separate index file with more. And that index file for will
> need subcategories, too, otherwise it will become large, too.
>
> And sure, quite a few documents will be hard to categorize currently.
> Making things fit properly might take a decade or two (unless somebody
> hires a few people to bring order into this). But it would set a clear
> direction. It also would tell doc writers what tone and detail level to
> use when writing their texts, as that depends on the audience which
> becomes clearer this way.

The creation of a bit more structure is certainly one of the goals here.
After several years I'm not having to argue quite so much about grouping
documentation for the intended readers, so it seems like time to stir
things up again :)

> Ciao, Thorsten
>
> P.S.: /me wonders if Jonathan posted this patch-set as a bait and will
> force everyone replying to come to his LPC/kernel summit session "What
> kernel documentation could be"
> /me despite this replied, as he had planned to go anyway

An awful lot of kernel work gets done on conference-presentation
deadline schedules...  The session would be a good time to talk about
what we think our overall structure should be.

I will try to do another pass on this before then, but there's no
guarantees.  If nothing else, it'll clean up the bottom-of-page
messiness where I got lazy the first time.

Thanks,

jon
