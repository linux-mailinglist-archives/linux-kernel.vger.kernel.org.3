Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC674A71EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiBBNsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBBNs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:48:29 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE34C061714;
        Wed,  2 Feb 2022 05:48:29 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so19496950otp.4;
        Wed, 02 Feb 2022 05:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uu884ediVQVvJM3ZzCLfpTG+ntZuBEo87SA1KIuOuM0=;
        b=UuvxzlJp9adTcB4epAAVweTNAsxOGsy+9dgSgBz2IxuUFw2v2WVeVkJQA8SvIqoawM
         BIVikL3qoGFEVX3pciAfMW+Zpbyk6BaaVLApudc0M0u6g6ogN/UqM858NWiK7EJdBW9W
         Wewg6qYRjA8ZYl5c8a1l72R2nU5agi0BR0B3DIgb8YY4jX9wIm9zzm2Du8AOwBkJueQW
         m0j3d3cnwKTw+KmmZPkE2S9t0E6Dzqy6UqV7yCGvIDQBziQWJmsy5pj5gPDiEyEpv8D8
         jiWDXszqcjGVNI2A2hL9T69hJ2Q+m2fnCBvcvPCO0jq5SvsuHJRnbi4vv7QVp2gURKnV
         JMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uu884ediVQVvJM3ZzCLfpTG+ntZuBEo87SA1KIuOuM0=;
        b=v7nQppoWXAPdTLOvCs7K7RNkq4qW82dHf8WWui+xTy9NbrcIfPfxSXuYpqi7875by+
         hiyhoMLZL1Z/u8/ftZyv7RSz6b+9dKDdOCnCvnF0Iuge7IyUZSj/9yp/H2VFNu7Ot6bq
         zZNTVxHNnEAtaHOxNnPfT5VsHMEp6Aq9lnwT4g8//eQkQVk2QiCpszs08fm71gHKOP1x
         hZrrMBzcv5e118zua29dEjzZkflGSfLz1sgiFvAKNXTnXAH/Q9iKoHLgl64gBJaLaHsj
         Nk8PClbccHUUCL0alFHeiFppWla8cUrnvizRd/RMLQO4YF/8pijy7Gm/muUyfxDn5kkg
         8mPA==
X-Gm-Message-State: AOAM5326g6FOVMNOg+SWWEPzalWb6CoRK3RWmE0txGHcHO1yB0Ro4AJ7
        MtuU8Zr82Fyxz/JhGvuUpR7MRIcmEth1FsfTPM8=
X-Google-Smtp-Source: ABdhPJwigQJstWLtxI0ElSovHNJx6WRVGD0F5N1ydlyffTBNNCafbHWtsFqtK4UihV0E85NiyjbLer9ZQe5qShM0GNk=
X-Received: by 2002:a9d:e94:: with SMTP id 20mr16685522otj.200.1643809708794;
 Wed, 02 Feb 2022 05:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-2-daniel.vetter@ffwll.ch> <20220202113126.3rgzqkhnorrbfj6b@houat>
In-Reply-To: <20220202113126.3rgzqkhnorrbfj6b@houat>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Feb 2022 08:48:17 -0500
Message-ID: <CADnq5_M6Q0L7UmXtGryOEL51Etz_MTwM4T1D0rb3KxY1bunUvw@mail.gmail.com>
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sven Schnelle <svens@stackframe.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Feb 2, 2022 at 6:31 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Jan 31, 2022 at 10:05:32PM +0100, Daniel Vetter wrote:
> > Ever since Tomi extracted the core code in 2014 it's been defacto me
> > maintaining this, with help from others from dri-devel and sometimes
> > Linus (but those are mostly merge conflicts):
> >
> > $ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
> >     35  Daniel Vetter
> >     23  Linus Torvalds
> >     10  Hans de Goede
> >      9  Dave Airlie
> >      6  Peter Rosin
> >
> > I think ideally we'd also record that the various firmware fb drivers
> > (efifb, vesafb, ...) are also maintained in drm-misc because for the
> > past few years the patches have either been to fix handover issues
> > with drm drivers, or caused handover issues with drm drivers. So any
> > other tree just doesn't make sense. But also, there's plenty of
> > outdated MAINTAINER entries for these with people and git trees that
> > haven't been active in years, so maybe let's just leave them alone.
> > And furthermore distros are now adopting simpledrm as the firmware fb
> > driver, so hopefully the need to care about the fbdev firmware drivers
> > will go down going forward.
> >
> > Note that drm-misc is group maintained, I expect that to continue like
> > we've done before, so no new expectations that patches all go through
> > my hands. That would be silly. This also means I'm happy to put any
> > other volunteer's name in the M: line, but otherwise git log says I'm
> > the one who's stuck with this.
> >
> > Cc: Dave Airlie <airlied@gmail.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Javier Martinez Canillas <javierm@redhat.com>
> > Cc: DRI Development <dri-devel@lists.freedesktop.org>
> > Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Cc: Claudio Suarez <cssk@net-c.es>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Sven Schnelle <svens@stackframe.org>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>
> Acked-by: Maxime Ripard <maxime@cerno.tech>
>
> Maxime
