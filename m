Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB7449257D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiARMLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:11:24 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:55534 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiARMLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:11:22 -0500
Date:   Tue, 18 Jan 2022 12:11:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1642507878;
        bh=6jJPhYWwoA+//43JWYgSIF2TDwtpv80+W+Aoj4JDSLQ=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=vro2rCcTNzJ1eiAzCCiIAtkK535vVvmHHVv+w/dx41CqwnVtLe/qojBuxkWfn8cJo
         oqWo82DKtp1s2KeVteUDfc6Hd/3bPCATrl75PGwviwene45RJmiKL7TmmdFWrmJ69s
         NHrGuz7mN03cgeGRtXwPglG9kRi5sA3tbWliZPR5h6UUGKdAH1tuPpKtoennM753T/
         8rhlsoH5ghDNrAoZDo7wQFidZuyrxIDMZtwOYsHi1liZkj6FiX8UhPR+wKEomJlIJo
         4+A+3Qjz8bc3LCE/kD4O9IPLJadcX1Kfdg1htuahb+CWmVurizdZRlEALBcyEAvd3t
         HZDhc9X9mZiEQ==
To:     Daniel Vetter <daniel@ffwll.ch>
From:   Simon Ser <contact@emersion.fr>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
Message-ID: <Eq7vej5ZXGABhmCc7fCbSiaC0FruYkhMp8Bc3WsRENghKb_BOZ2LpVLsz8TkBGlrXD18jqkjAbBPwQt2n1yA7hQcK9u5Ep37fOC4UasJV_U=@emersion.fr>
In-Reply-To: <CAKMK7uHtdjyeasnJw2ZVwJJjuCn1KGT05kJu-x5jdmEmnBB-dA@mail.gmail.com>
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com> <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de> <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de> <87ee5659dt.fsf@intel.com> <4f1d6018-d74e-8e62-ea4d-0ca79c6bbbc5@gmx.de> <87a6ft5thv.fsf@intel.com> <CAMuHMdVE6OY29qB+F-QPgQt2q5xAYfyuPhKqSDrh_HhD9PPw9g@mail.gmail.com> <CAKMK7uHtdjyeasnJw2ZVwJJjuCn1KGT05kJu-x5jdmEmnBB-dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 18th, 2022 at 12:41, Daniel Vetter <daniel@ffwll.ch> wr=
ote:

> On Tue, Jan 18, 2022 at 9:41 AM Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> >
> > Hi Jani,
> >
> > On Tue, Jan 18, 2022 at 9:38 AM Jani Nikula <jani.nikula@linux.intel.co=
m> wrote:
> > > On Mon, 17 Jan 2022, Helge Deller <deller@gmx.de> wrote:
> > > > On 1/17/22 22:40, Jani Nikula wrote:
> > > >> On Mon, 17 Jan 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:
> > > >>> Seems like few people read linux-fbdev these days.
> > > >>
> > > >> How much traffic is there to linux-fbdev that is *not* Cc'd to dri=
-devel
> > > >> also?
> > > >
> > > > Doesn't seem like much traffic - which IMHO is OK for such a tree w=
ith
> > > > mostly just maintenance patches.
> > > >
> > > >> Do we still need a separate linux-fbdev mailing list at all?
> > > >
> > > > Yes. I want to have it seperate of dri-devel.
> > > > Actually I'd prefer to drop dri-devel from the list where patches
> > > > for fbdev are sent...
> > >
> > > Disagreed. If anything, this thread shows we can't have fbdev and drm=
 in
> > > silos of their own.
> >
> > Unless DRM drops fbdev support. Isn't that the long-term plan anyway?
>
> No. There's way too much old stuff still using the fbdev interface to
> do that. We've even done things like standardize the vblank wait
> ioctl, because people need that.

Kind of related: I wonder, could we document somewhere that fbdev is a
deprecated uAPI? ie. new user-space shouldn't use it and should prefer DRM.
I don't see that mentioned anywhere, although it seems like it's the
consensus among all kernel developers I've talked to.
