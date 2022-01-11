Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D3448A4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346154AbiAKBLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbiAKBLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:11:47 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB40C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:11:47 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id h20-20020a9d6f94000000b0059100e01744so105938otq.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24u0HfOYmEXMexHKNr6/VqyMwcTiPMZEtxMMSABMM2U=;
        b=eeLLtu9FBUsrR18bBEVcvoYAS8rN3dtSLLefmLIXSGl89dFeLKCTiL0o3MCjfvtMEn
         OaIFlO/WKvwQvZokAqzOPPoU2HNG7VOlQRz526FK5KnAF26pUXt5gYdoK+IwO+i+gwpU
         nMVMoiWKuoY9lcF6uOv65tRTpDMKD47+NCNoFuB9o2WVmXEBXiNfsGyLWrFsYBHbuMA3
         AEflSnx2LF6PSJeQQ6k0cP7wJ96OMP52wNGLhqMtV4BrtH8Nf0lCc2YsBWiUj7OITIQG
         ftWuvKy+C8N9HhNe8yfoppWGipWpDBIsKix9hDEwcJyEJTQ7UgAi1hBXzHNZgQDCn20o
         GQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24u0HfOYmEXMexHKNr6/VqyMwcTiPMZEtxMMSABMM2U=;
        b=m3Jl/Onj1AEVTYjuLzHZPgYMS1OgjGdYooDcmmW61YOmZGPNsI/Zdh9NU6ZtYtQMs9
         3cEaeucipA/QKUPMKgtxQVmrq9gaUih4t3o9C03BTkrirP54sb9oYXjgHwT5HANyUQE+
         6q3aLVzuflJ4e1/TO8KxcBE1ND1EGfpt4o/3eU7dc7sldSA9ljh7G+Bp/nGqdzZrpW0c
         FwCstLDKcedPkNu9d4tfuYsjOk+CZH452SHhmSTfGPI6w5H7m6/0Ymc/LsUiZndiq+Xi
         pZiGJXrAKjtRsl9XM2X/SUPhgeiGCOOCW3eTTWpFIcV+pweJvR3NUt6dpg/jRZwiZy+G
         r6ZQ==
X-Gm-Message-State: AOAM531zx95epm5Onf08ixc3V9fuA2V3ESN47Cznr8b7cPUWGx4kezxA
        EVZfiQgQQPpKKYfau6OlW0Y620wFHoAF/B93gdQ=
X-Google-Smtp-Source: ABdhPJwKhnwL+hbPwQXmM+GBeSLhrHPTondS/I97ppFbTy9pmgYJQaAdL+UYlUBpmLMERfQQoJi7/7DiUkdfbdsyRI8=
X-Received: by 2002:a9d:6390:: with SMTP id w16mr1830898otk.200.1641863506848;
 Mon, 10 Jan 2022 17:11:46 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com> <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
In-Reply-To: <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Jan 2022 20:11:35 -0500
Message-ID: <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        Dave Airlie <airlied@gmail.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 8:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jan 10, 2022 at 2:13 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > Sounds like something related to watermarks.  That said, we haven't
> > really touched the display code for DCE11 cards in quite a while.  Can
> > you provide your dmesg output?
>
> I'm not seeing anything that would look interesting, but here's the
> parts that look relevant for drm..

We are putting together a system to try and repro the issue.  Does it
happen with a single monitor or only with two?

Thanks,

Alex
