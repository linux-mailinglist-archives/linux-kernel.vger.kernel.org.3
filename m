Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA63948A259
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbiAJWFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345138AbiAJWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:05:01 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE5C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:05:01 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id j124so20516619oih.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXhKTZ4OmGBgXBdJL0PZRRw2ubmb4jJBTwXOgNZ8A90=;
        b=X2L2lkhAJJf8PQOu8rul77EN8CMf9uins0JWD0AM9eGDgLeHUP+trxehOq5EoF+KaJ
         4ibiE7afHrDr75OrcpIaruIGoDgypdYwFaaEhMLdy9y3pjT36qRLhac/IavU/kRU/dHl
         Ekvar5nEGXu4vtLu6tau/TiWs8Cs6HNZH9PE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXhKTZ4OmGBgXBdJL0PZRRw2ubmb4jJBTwXOgNZ8A90=;
        b=SekXeC5gvgoygKPNYjsG5wvRGfv/I0RIdEtvni8GpLNI+IJG7V8x9pW8nMZ+9mXecR
         3b11rswen3iNxz8XBIccgrmLMVhR6kXHu7gzJnZJNbCQ4mlscB6di64RhTsE4WhJmSqP
         pofKTdoDZN/xOaM8xDS1gSrDxoYF8JVeyKbgyzzdDeajXVLVzDn2PDQRobkll/WOuNvo
         MC8cOVUHCCuMlMGT18A5F/0EUSnubPWkuVsk/F46WB5l9eNJjTlKo/OHjA5ZuF35g7IZ
         OOqQpyaIo+bneCJMCYhzI2seE8gtHxgFVmN/y9/FgBFCUgRar/mW34JMxjaz8u2b22g1
         Dp0Q==
X-Gm-Message-State: AOAM530cqQsirmpZ2zlIbJ6V8jkeq21ydQhDytgxQfPfTrACEiuquEOf
        JAyxxwnGf3UgJh0FlnpnwmLX3EPtFDTNaOY1QYrRXg==
X-Google-Smtp-Source: ABdhPJw1mAmmTWAyagLxfDd96trE4G+y2z1zCFYZwKPClOuJcQEAyqFg88OvuNfI5qTIiUq15pTeY5AbNDh4aioWP2M=
X-Received: by 2002:a54:410a:: with SMTP id l10mr1047264oic.128.1641852298114;
 Mon, 10 Jan 2022 14:04:58 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
In-Reply-To: <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 10 Jan 2022 23:04:46 +0100
Message-ID: <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        "Wentland, Harry" <harry.wentland@amd.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 10:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jan 6, 2022 at 10:12 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> >   git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-01-07
>
> Gaah. I merged things and it built cleanly, and I pushed it out.
>
> But then I actually *booted* it, and that's not pretty.
>
> It *works", but it's almost unusable because of random scanline
> flickering.  I'm not sure how to explain it, but it's as if there
> wasn't quite enough bandwidth on the scan-out, so you get these lines
> of noise and/or shifted output. They are temporary - so the
> framebuffer contents themselves is not damaged (although I don't know
> how the compositor works - maybe the problem happens before scanout).
>
> This is on the same Radeon device:
>
>    49:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] (rev e7)
>
> with dual 4k monitors.
>
> Any idea?

Since Christian is mostly the compute/memory side, adding some display
folks for this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
