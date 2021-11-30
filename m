Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0244639EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243626AbhK3PZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245327AbhK3PUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:20:25 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA1C061D66;
        Tue, 30 Nov 2021 07:14:57 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x131so20909236pfc.12;
        Tue, 30 Nov 2021 07:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=y+hG1SvxK/UEoPVNvwI1oVw84wwOy37q25qC1tOztcY=;
        b=dMdTuSfrvjKx6EbK4er9VcmRknJYgMALE2LKARHHJtstqTaKMhcV98weg4pBUbV5C0
         zgn/thH1AWLyd2yCAwC42ql6/uIzfohACgTgBYE2Xqt32SWL7Hd8hhDsI90AuNWlStvY
         +RZCf6yR7mKDxt0UvfxmP0xsKONk/o+TtrAId74r97mXuMlQa3H7c14pG5DZaQxUEu2R
         TNz4jG0C6YYOjaP2PfevzHM1+9yV5EvC4RU6+CujKOe5B+mCYgvr5irrdGvvAdF9tCZm
         hd25q1iXY5y3Mz+fpehcXmZhjsjKGUXQ9AGAfRLJf5JR/8gpjkEKTRCa+2K6uYpLqabW
         L+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=y+hG1SvxK/UEoPVNvwI1oVw84wwOy37q25qC1tOztcY=;
        b=svjnPKA8eixFbyhN5ugRJEindZWnQEnQXD7DO3lqhCj8DA5B/r9JSbSR3XD+gfOUsQ
         VoruLDJWfVKZWeiLdC0DPr5MNQAZh37UCSVSrRWiY30pS+xKii/eQ3z0B5d6zMDcTwCZ
         NWSTetKwKP7CdmN8ueILQvLRsXJ2z8ZWgLc2CVQqgX29XzZbbZzUUeMccSq0nEgukkaa
         Rbz0d+fQbQM+sCVhmJdes415YLVTO25Kzq6t7bIOPRfXyqzX6WxsMHw8HV6q5328ZhiO
         TRbxBg1b0HbfSWePeb80OV+GmNxuU1I0w3z+LGXGwLBhIFLyezSqiXzbNLjWLsGImIak
         PNDA==
X-Gm-Message-State: AOAM533n+6pIBAR78QGKbKxNtlBWlDKMc2eGyoPcfKk3D0+50OhNYm6T
        cNTWYP5PJLik8jI1y7hjkfHuytcaae1Wbih3yzg=
X-Google-Smtp-Source: ABdhPJyzaItNRFUPBt7B4pzAVjqbphEgxPgK5GhWjKoW6Og3btecqQkfL2gktJDPESGB7sFK/hfDpd54OOxk1QHdkkk=
X-Received: by 2002:aa7:8883:0:b0:49f:f87a:95de with SMTP id
 z3-20020aa78883000000b0049ff87a95demr46899391pfe.53.1638285297086; Tue, 30
 Nov 2021 07:14:57 -0800 (PST)
MIME-Version: 1.0
References: <2036923.9o76ZdvQCi@positron.chronox.de> <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com> <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com> <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com>
In-Reply-To: <YaYvYdnSaAvS8MAk@kroah.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 30 Nov 2021 10:13:26 -0500
Message-ID: <CAH8yC8nWLk9vhV1iACE+vmtby2rRN8RDqeuS54qZahE-xH2X_w@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Simo Sorce <simo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Tso Ted <tytso@mit.edu>,
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
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 9:04 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 30, 2021 at 07:24:15AM -0500, Jeffrey Walton wrote:
> > On Mon, Nov 29, 2021 at 6:07 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > ...
> > > Sometimes, yes, it is valid to have different implementations for things
> > > that do different things in the same area (like filesystems), but for a
> > > core function of the kernel, so far the existing random maintainer has
> > > not wanted to have multiple implementations.  Same goes for other parts
> > > of the kernel, it's not specific only to this one very tiny driver.
> > >
> > > As a counterpoint, we do not allow duplicate drivers that control the
> > > same hardware types in the tree.  We have tried that in the past and it
> > > was a nightmare to support and maintain and just caused massive user
> > > confusion as well.  One can argue that the random driver is in this same
> > > category.
> >
> > I think an argument could be made that they are different drivers
> > since they have different requirements and security goals. I don't
> > think it matters where the requirements came from, whether it was ad
> > hoc from the developer, NIST, KISA, CRYPTREC, NESSIE, or another
> > organization.
> >
> > Maybe the problem is with the name of the driver? Perhaps the current
> > driver should be named random-linux, Stephan's driver should be named
> > random-nist, and the driver should be wired up based on a user's
> > selection. That should sidestep the problems associated with the
> > "duplicate drivers" policy.
>
> The "problem" here is that the drivers/char/random.c file has three users,
> the userspace /dev/random and syscall api, the in-kernel "here's some
> entropy for the random core to use" api, and the in-kernel "give me some
> random data" api.
>
> Odds are, you REALLY do not want the in-kernel calls to be pulling from
> the "random-government-crippled-specification" implementation, right?

It's not a question of whether some folks want it or not. They have to
accept it due to policy. They have no choice in the matter.

I hope I don't sound argumentative. It's not my intention. But I know
what it's like to have to comply with policies, even ones I don't
like.

Jeff
