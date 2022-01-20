Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0373A494D42
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiATLl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiATLl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:41:56 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A475C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:41:56 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id w206so3405751vkd.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AcK8qyswp9gjQwYqxYG0L3jUGTV1Nm9qXmgnSkoFndU=;
        b=uhjyyCqJ7UVJYr6kFSsnoWr8Yb9oWhPS/21aw0JO8FOnTLNEKxaa7qfmHMBntMzfoH
         mcwlXC55x56Kt76CCX2teuDzOGrIhYeOav8kJjU8lEVEsxSDMK4xkeTP1UC18+BB7nBB
         KctO6TxhvyZfCI8z4dcdOKKsNTnICEfVHJU6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AcK8qyswp9gjQwYqxYG0L3jUGTV1Nm9qXmgnSkoFndU=;
        b=evgRyQAzG8s0y2Ft9xU0oA40wCe5qo/bwHogzEONZalILp9D2IELFkVuWY0wgGjOBt
         dDrDzGRO/vjXjoSVBLPmE1+UOaFlCjeIFBIOY4m9zDRK7XdWIu5NcaxA5dlOobnMGv7L
         VgiIyOg+Pq02GlTx84UTUWb8Jr9KVwanI9l5b0L107CCRgS6wCPhJf/wsBqJ5obZfNEK
         ebrBtMJFVF8raxKCW+jatdKtp6rHJjfmqKmLgwpWdcfi/OWdVLqgBY/l35AOu64O+exh
         /+FXAGzPIWQ4/cTweH27RSbWetowYQvHe6iQDLJFoSVe03+MiVGjbw1UmWFKBfWtKxxn
         ujZA==
X-Gm-Message-State: AOAM533X75jf1AH1RiiDwurv0PxKCgrz1qwZEB95+Ll2KPm4LXH9TG5W
        6J6vXYtWtRtprM9iVEpl21xuuHF2tiI0gig0k8bxaWu4jQ7Hsg==
X-Google-Smtp-Source: ABdhPJzKuGisiIKX6JkS19MYQ5lMiIMLo7J6D0ujzzT5zQzQVnVViRq1oJFR8HGXDXxC+J1lbRio0kz39IufKUQWgfo=
X-Received: by 2002:a05:6122:a09:: with SMTP id 9mr1812478vkn.12.1642678915222;
 Thu, 20 Jan 2022 03:41:55 -0800 (PST)
MIME-Version: 1.0
References: <CAFr9PXnig9YfnwSzMg5UPm3UtAsEAQT_xVheBbLppiU45mc_QQ@mail.gmail.com>
 <Yeg8mi0S2ACy9q8O@phenom.ffwll.local> <CAFr9PXkUwfyZ9yJgNYHX5_jo_SFfDU9wKA3Ldf+hbVL23faqKQ@mail.gmail.com>
 <cdeace24-67ba-8e23-29ad-f41abac98d79@gmail.com>
In-Reply-To: <cdeace24-67ba-8e23-29ad-f41abac98d79@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 20 Jan 2022 20:44:55 +0900
Message-ID: <CAFr9PX=-zERaND_DMbtPahAoiNeDDGVa=KwwLAErHrBrYMZohQ@mail.gmail.com>
Subject: Re: [RFC] How to add hardware rotation, scaling etc to a DRM/KMS driver
To:     Hans de Goede <j.w.r.degoede@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, 20 Jan 2022 at 20:24, Hans de Goede <j.w.r.degoede@gmail.com> wrote=
:
> > I wanted to do the rotation in the kernel so I didn't have to hack up S=
DL1.
>
> Right, doing the rotation in the kernel to make this all transparent
> was my first idea / wish too. Unfortunately that just doesn't really
> work well. Most display-blocks have multiple layers, for things like
> hw-rendering a mouse cursor, video overlays etc. I guess this is mostly
> exposed through the DRM/kms interfaces, but I believe fbdev also
> export some of this.

That makes sense. This hardware has a bunch of different framebuffer
things with different properties. My plan was just to fix the main
display and forget the rest of it exists. ;)

> For Fedora we have moved all SDL1 apps over to using the SDL1
> compatibility wrapper around SDL2:
>
> https://github.com/laibsdl-org/sdl12-compat

Thanks for the pointer! I didn't know that existed.

> And SDL2 has a drm/kms backend. So I think the best way forward here
> might be to use SDL2 (either directly or through the compat layer)
> with its kms backend and teach that backend to honor the panel
> rotation drm-connector property (so have SDL2 do the 180=C2=B0 flipping
> you want).

I was just looking at this... It seems like currently the KMS/DRM
driver for SDL2 requires a GPU and doesn't work on dumb hardware
according to comments I saw. But it seems like the best route forward.

Thanks for the pointers.

Daniel
