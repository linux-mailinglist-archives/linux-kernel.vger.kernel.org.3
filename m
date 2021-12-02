Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D304465AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbhLBA3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhLBA3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:29:39 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3E0C061574;
        Wed,  1 Dec 2021 16:26:17 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 71so25295951pgb.4;
        Wed, 01 Dec 2021 16:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=sv23TKvRzZPWht8CGSZ7AaQzPSxfhV6p2hx6hoQB8RA=;
        b=B/7CH6WFlj8Q5RNgrAfZqS62Li1OnmWsNztgZSDN3/k6O6Y8OMbfSWSjWY1qrbbmpD
         Y882GtTKA436La/dCX0MXxQSY7pEhdijgj0gPvIJC8aKNvK6hMC7ovkk8p0okDoIMX3t
         ipLkOVP+tYMC2qXQKZO/44f64PsJIWBTC1ChXNPO+4m/1S7cIAyxro5f3Q/gFYruT6O8
         PY0MCDY8Xe/ZPEv8IjVYmvc+wYo/U3yIdydIVuXx0pAzCTQDwYRxaKnW54P+RTL/EAIf
         c8O23h+7AcQhZcPcyiHbpoQYFU/PZ2chqW7spKzyoQXSs1pun8Nka8hUDSnHxNhSvsDJ
         Q01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=sv23TKvRzZPWht8CGSZ7AaQzPSxfhV6p2hx6hoQB8RA=;
        b=cN1s0FPGgpdossznRbZ95+Mz0O/MSGNX3QAkE5kKfv5/Mo9MCylr26ujqe3vWlKwJ4
         toAHynxfM6Z1JisdLGY7Ontpa/RvsudgQ0be4XCGoEmiotQIihQncvLAhqXPFyfEFnxU
         6UhPiRuMKbdpRlxZ0X1N91QRoxtmnhqzsnRfRWKT4TApOJ4HwnHDqiwQ0hd4nbc32plu
         UAQlNjC9Vo24VGuLFaWRdeDEqdmiLEBOpCpPkdF3i+EBlaH+ndVbrf5AKLb8sx7+MGnM
         F3XvFIrqmCXQft0dlAKHtK27pliUMafnB9C1DjxSRDfAQzpU0xoiUnda5W0P3QJ+8bCl
         DfUA==
X-Gm-Message-State: AOAM533gvQWb/dmRD6mGw1U+FvJMn+TNI7mLtoz6TgVNwgNeho07oDgJ
        Mwv9Kj+lvnwdAVuILY6lpZh98jeU+D6avZtsIZ8=
X-Google-Smtp-Source: ABdhPJxey/5t7weQ8d0mFE0yXPl7NJpEfgcpgxxuty7D+wcx4F3paTHNjatvKNNty79uRcDsauN4SfjZr8Nt4drMCy0=
X-Received: by 2002:a05:6a00:1312:b0:4a4:e341:213a with SMTP id
 j18-20020a056a00131200b004a4e341213amr9397893pfu.57.1638404777476; Wed, 01
 Dec 2021 16:26:17 -0800 (PST)
MIME-Version: 1.0
References: <2036923.9o76ZdvQCi@positron.chronox.de> <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com> <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com> <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com> <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com> <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com> <CAHmME9q-WUGQ7NUO7oafUBkGBNtWePGXHGfEd2rTmZMUA49+DQ@mail.gmail.com>
In-Reply-To: <CAHmME9q-WUGQ7NUO7oafUBkGBNtWePGXHGfEd2rTmZMUA49+DQ@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 1 Dec 2021 19:24:43 -0500
Message-ID: <CAH8yC8k1WMwjoUXY_2nWjLMLVLPQsno3asyDEYVRJ4pg=OpLQA@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Simo Sorce <simo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 1:25 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Dec 1, 2021 at 12:19 PM Simo Sorce <simo@redhat.com> wrote:
> > that much it is, and it is a required one. However having worked a lot
> > on this I can tell you there is actually real cryptographic value in
> > the requirements FIPS introduced over the years
> > Well I think most of the requirements are sane practices, hopefully
> > controversial stuff will be minimal.
> > I happen to think quite a few of the requirements are actually good
> > ideas to implement to improve the guarantees of randomness
>
> If you think there are good ways to improve the RNG, of course send
> patches for this, justifying why, taking into account recent research
> into the topic you wish to patch, etc. Don't write, "because FIPS";
> instead argue rationale for each patch. And if you _do_ feel the need
> to appeal to authority, perhaps links to the various eprint papers you
> consulted would be worthwhile. Preferably you're able to do this in a
> small, incremental way, with small standalone patchsets, instead of
> gigantic series.

I may be parsing things incorrectly, but you seem to be rejecting the
NIST requirements, and then positioning your personal opinion as
superior. It sounds like one authority is being replaced by another.
Perhaps I am missing something.

I am also guessing you've never read the relevant NIST documents. The
documents state the security goals and provide the steps to achieve
them in an implementation.

Jeff
