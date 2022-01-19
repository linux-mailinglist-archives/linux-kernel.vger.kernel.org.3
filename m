Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAEC4939DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354201AbiASLsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:48:08 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:42929 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiASLsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:48:04 -0500
Received: by mail-ua1-f46.google.com with SMTP id p1so3923119uap.9;
        Wed, 19 Jan 2022 03:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCbX2OMJvl/EE6vcwTdZbTk0S6N5nx5++Qk7hJWCnWw=;
        b=6ynxB6zjuNh7C8y/KfaG2P69DmrTo2wKsYLHt92OpNUH/BFq9jbiF9j+J/pYtv6Txw
         TE11ImT4QTVH84vkcclXRWugm3LAhfGthsQm18atYI7YIdQLQ3ayUB243zVYDxoDdIuq
         5PoQGep5MHgalvtPD27G85pEVaCGm/t7CO+H1M5TDayjOmXzXntQQTxKrMbdjIWqeaqi
         mE7qBQovTIrYoVsTNk1aldqap6eH7B/5Zp0RGO5wm58TuU1qnaeitQX5q+chN7y95dr4
         clFOC0A/JIS3kyFfAoO7FWNUL7BTOtBDZCd+3i7ANJa9wjslu4ZjI/gUz+PE2iPARNXg
         JXvg==
X-Gm-Message-State: AOAM531QajfPvZ+agOBlv3uoumIS9F2cBUB7mt+FYi+wGnMb5s5BMtjR
        2jb8EbaP6m1MzAdCTENYSRfBI4C/jmWJlQ==
X-Google-Smtp-Source: ABdhPJxTkH8KHcNKagOL1iqb4sxFVVyIV2kicNzKsbcUqtJjKDX4xWk2WC0LpPLFEXQsoMwUCXRFPA==
X-Received: by 2002:a05:6102:b02:: with SMTP id b2mr10568744vst.52.1642592883776;
        Wed, 19 Jan 2022 03:48:03 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id b8sm4426601vsl.19.2022.01.19.03.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 03:48:02 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id l1so2101791uap.8;
        Wed, 19 Jan 2022 03:48:02 -0800 (PST)
X-Received: by 2002:a05:6102:3581:: with SMTP id h1mr11427171vsu.5.1642592881909;
 Wed, 19 Jan 2022 03:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20220119110839.33187-1-deller@gmx.de> <20220119110839.33187-3-deller@gmx.de>
 <Yef0j8+DBbwC7Kjv@kroah.com> <Yef15k2GtC40aJEu@kroah.com>
In-Reply-To: <Yef15k2GtC40aJEu@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Jan 2022 12:47:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVWFJEDwjf-htZ_D1484efmuPnz_L-qhcTeUE-GVpvZXA@mail.gmail.com>
Message-ID: <CAMuHMdVWFJEDwjf-htZ_D1484efmuPnz_L-qhcTeUE-GVpvZXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Jan 19, 2022 at 12:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 19, 2022 at 12:22:55PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Jan 19, 2022 at 12:08:39PM +0100, Helge Deller wrote:
> > > This reverts commit 39aead8373b3c20bb5965c024dfb51a94e526151.
> > >
> > > Revert this patch.  This patch started to introduce the regression that
> > > all hardware acceleration of more than 35 existing fbdev drivers were
> > > bypassed and thus fbcon console output for those was dramatically slowed
> > > down by factor of 10 and more.
> > >
> > > Reverting this commit has no impact on DRM, since none of the DRM drivers are
> > > tagged with the acceleration flags FBINFO_HWACCEL_COPYAREA,
> > > FBINFO_HWACCEL_FILLRECT or others.
> > >
> > > Signed-off-by: Helge Deller <deller@gmx.de>

> > As for "why", I think there was a number of private bugs that were
> > reported in this code, which is why it was removed.  I do not think it
> > can be safely added back in without addressing them first.  Let me go
> > dig through my email to see if I can find them...
>
> Ah, no, that was just the soft scrollback code I was thinking of, which

So the bugs argument is moot.

> was a different revert and is still gone, thankfully :)

FTR, not everyone else was thankful about that one...

> This one was just removed because Daniel noticed that only 3 drivers
> used this (nouveau, omapdrm, and gma600), so this shouldn't have caused
> any regressions in any other drivers like you are reporting here.
>
> So perhaps this regression is caused by something else?

1. Daniel's patch was not CCed to linux-fbdev,
2. When I discovered the patch, I pointed out that the premise of 3
   drivers was not true, and that it affects 32 more fbdev drivers[1] .
   The patch was applied regardless.
3. When the patch was suggested for backporting, I pointed out the
   same[2].
   The patch was backported regardless.

[1] https://lore.kernel.org/r/alpine.DEB.2.22.394.2010311116530.379363@ramsan.of.borg/
[2] https://lore.kernel.org/r/CAMuHMdXRgam2zahPEGcw8+76Xm-0AO-Ci9-YmVa5JpTKVHphRw@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
