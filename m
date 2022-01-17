Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3FE490562
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiAQJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbiAQJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:48:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:48:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u21so63065345edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hvs7wdHNk9d6evPXMTRPHKlvNS1pd2jeBhpDZL4yqgM=;
        b=j2eUcRSqjv8rz+GGyoypRLAiAp5ByKbji3UGDPaismYVEFznjzB0AqxcwnFSnIa5XG
         b0cBStOP4jQD2Zw/3wYoPLGO+9ULjkL+mz7s1pp8yfHTSVx67v6T6OxrVIq6AbOZHk2L
         j7v7/kvJC9ch+PZ4wTRPp0dRN2QdlGFNNfhcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Hvs7wdHNk9d6evPXMTRPHKlvNS1pd2jeBhpDZL4yqgM=;
        b=RmyqNbDKy1vVJA5wNL2A7kBhuiB33RrPlJjb4u1TPW4IzV37NGKN7b8ZkEt47Cvi1J
         c+J8pNJh0DYJ45XjuBnbdTT57R3t1MPd6640XT43mlerovyLR+H4+7Yx36MjVReUIZUo
         veLGI2w/uwa3sBN04px7cKGIYkFWeA+MdjhvEkutOg4uSkp+qfTCIBQfKw0EjW8dzsmy
         XxVonGryttM0CTRsiRdE2D0QbH+Xitv0F6HtB4ZVm5B376F2qLjKcMIpz0UdxMruTYeH
         vTsJFkgS1DyTvpL1l8VWHoZQtnhFRNip/Wsf9AwehH8NqtVllZATCV2/8Bj4kkcdySnV
         Dwpw==
X-Gm-Message-State: AOAM531XRjxvOf2XdIcJxfOGWPqvcu9vn/3dzFle/qsP49qGOsjG3vr4
        dMhiDa0CG0EWQSGR9ZYpcBM8ZoZKuUBiXg==
X-Google-Smtp-Source: ABdhPJzgzyXyFgTeax+VBjmTswOv7LJ3YOfVs1bNjMWWzVqPATfGKipEN5KgjwU4FLcDhpQ8YuNBeA==
X-Received: by 2002:a17:907:3e07:: with SMTP id hp7mr7400211ejc.469.1642412883687;
        Mon, 17 Jan 2022 01:48:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p4sm2887048ejl.78.2022.01.17.01.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 01:48:03 -0800 (PST)
Date:   Mon, 17 Jan 2022 10:48:01 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
Message-ID: <CAKMK7uFnhK7pnfiMzz-UY1UYv3WG=sVOCe24bz0xROhQOxY+eA@mail.gmail.com>
Mail-Followup-To: Helge Deller <deller@gmx.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <YeG8ydoJNWWkGrTb@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeG8ydoJNWWkGrTb@ls3530>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge

On Fri, Jan 14, 2022 at 7:18 PM Helge Deller <deller@gmx.de> wrote:
>
> The fbdev layer is orphaned, but seems to need some care.
> So I'd like to step up as new maintainer.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d0cd537803a..ce47dbc467cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7583,11 +7583,12 @@ W:      http://floatingpoint.sourceforge.net/emulator/index.html
>  F:     arch/x86/math-emu/
>
>  FRAMEBUFFER LAYER
> -L:     dri-devel@lists.freedesktop.org
> +M:     Helge Deller <deller@gmx.de>
>  L:     linux-fbdev@vger.kernel.org
> -S:     Orphan
> +L:     dri-devel@lists.freedesktop.org
> +S:     Maintained
>  Q:     http://patchwork.kernel.org/project/linux-fbdev/list/
> -T:     git git://anongit.freedesktop.org/drm/drm-misc
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git

Maybe don't rush maintainer changes in over the w/e without even bothering
to get any input from the people who've been maintaining it before.

Because the status isn't entirely correct, fbdev core code and fbcon and
all that has been maintained, but in bugfixes only mode. And there's very
solid&important reasons to keep merging these patches through a drm tree,
because that's where all the driver development happens, and hence also
all the testing (e.g. the drm test suite has some fbdev tests - the only
automated ones that exist to my knowledge - and we run them in CI). So
moving that into an obscure new tree which isn't even in linux-next yet is
no good at all.

Now fbdev driver bugfixes is indeed practically orphaned and I very much
welcome anyone stepping up for that, but the simplest approach there would
be to just get drm-misc commit rights and push the oddball bugfix in there
directly. But also if you want to do your own pull requests to Linus for
that I don't care and there's really no interference, so whatever floats.

But any code that is relevant for drm drivers really needs to in through
drm trees, nothing else makes much sense.

I guess you're first action as newly minted maintainer is going to be to
clean up the confusion you just created.

Cheers, Daniel

>  F:     Documentation/fb/
>  F:     drivers/video/
>  F:     include/linux/fb.h



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
