Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C887D4A6FA8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbiBBLLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiBBLLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:11:01 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3528CC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:11:01 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id k31so59880529ybj.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5o2JVyWPjvF0CuBYdtH6rf3OCwSu8v5z/m2E3EDxEVQ=;
        b=6JC4qWqQoyur6n49lXlwJ8argU2sfdQwrI+5UZ/cAgJfz/Wny6UxNwpfY4nKvjDOf4
         bC8yqlshTJqy2m9fSfRZx1mHvZHvU9NCnbTm2Hz8QKFGXNmTLuF2q/PQPQcJnF2rdPfI
         7EQ8tQsgBfjmBUJ7GKHlLlmXRyoppvNp37bOKrZ4l/v573+8dKE7AtQOjDIqDzNUrl5O
         M5dmxC6WklOEBh19YK8riY5u60LO+BbHsdTedAZO8mKbSRT+bkvd5WqWMzTGa0MP8bsy
         i2QRtLbgjqRDiIiagTRyBHl/amtF7ScuFdW7LxgXu1qUFnOZTEOkenxrGPpIREqp5/KT
         gUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5o2JVyWPjvF0CuBYdtH6rf3OCwSu8v5z/m2E3EDxEVQ=;
        b=U0tBCBQrbV3vE5wATnfJ6tmaANOGdhUuqHr9VdqJgQBRAXnuJfkMmpgKeUuO1ajuJj
         7i6FaqYkudzLB/Kslh7IYOZIOzmgyt2LLTaG4bEIzZ3Fs6Dg6YgsE7fy9D0VO0DzOmCQ
         QdIiJon0J4OCmmZHARw2kucoavSiEyMJfrztSuu7iha+P8zhZJuWldjh+YIGolvxk9KO
         KFLChP+W/HyVGoTrxwx1+qjhy6hkCD4baA2opnDa/GtWSH8d8jo4ljtJyCaGb6/Gbhnz
         NfqNXCvzOAUwxjD+5o5XDgG2GKZHuWJWAYI6ApwXbaEYLgiFo1cT8Xbimj8rvIjhbQV6
         Qubg==
X-Gm-Message-State: AOAM533w8KXJMm71FYD4dqtSil6TXCfAPkRSlx7Es3dAZPglyJbNvDdQ
        z5+CprOrny/r3+EnTSINPMpCtwuJzw2KbonoFvTBPw==
X-Google-Smtp-Source: ABdhPJxXYTqOt/oSe5PrM2Wrpx8vatAUxY/eNAT3jcriiGBCZwZLVaTevoVERbyDMHiO0clxqoChrMTzgZvvtsyVmcE=
X-Received: by 2002:a25:a206:: with SMTP id b6mr20061500ybi.707.1643800260369;
 Wed, 02 Feb 2022 03:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch> <20220131210552.482606-2-daniel.vetter@ffwll.ch>
In-Reply-To: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 2 Feb 2022 11:10:49 +0000
Message-ID: <CAPj87rMhkdtoUHTB4y4HLR8KM2tPkQCufFcHbvA0_xHycCHmhg@mail.gmail.com>
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>,
        Gerd Hoffmann <kraxel@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sven Schnelle <svens@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 21:06, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Ever since Tomi extracted the core code in 2014 it's been defacto me
> maintaining this, with help from others from dri-devel and sometimes
> Linus (but those are mostly merge conflicts):
>
> $ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
>     35  Daniel Vetter
>     23  Linus Torvalds
>     10  Hans de Goede
>      9  Dave Airlie
>      6  Peter Rosin
>
> I think ideally we'd also record that the various firmware fb drivers
> (efifb, vesafb, ...) are also maintained in drm-misc because for the
> past few years the patches have either been to fix handover issues
> with drm drivers, or caused handover issues with drm drivers. So any
> other tree just doesn't make sense. But also, there's plenty of
> outdated MAINTAINER entries for these with people and git trees that
> haven't been active in years, so maybe let's just leave them alone.
> And furthermore distros are now adopting simpledrm as the firmware fb
> driver, so hopefully the need to care about the fbdev firmware drivers
> will go down going forward.
>
> Note that drm-misc is group maintained, I expect that to continue like
> we've done before, so no new expectations that patches all go through
> my hands. That would be silly. This also means I'm happy to put any
> other volunteer's name in the M: line, but otherwise git log says I'm
> the one who's stuck with this.

Acked-by: Daniel Stone <daniels@collabora.com>
