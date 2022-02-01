Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6A4A6653
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbiBAUrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiBAUr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:47:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AC0C061714;
        Tue,  1 Feb 2022 12:47:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m11so37015687edi.13;
        Tue, 01 Feb 2022 12:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBnJnA9U9S3KagUnngEcBE9vHXc5AUv/doMbVPNRS3M=;
        b=DVRlUjS7VD4VU5BIZI8dkhEQHskJDVcEhTqXgdBLXMvM85SH3FVbL1zwAze6A0bx8X
         OAW0RmKejtBz7i1iD0FUGGayBM737FcPbGGupR5eUbQXtdhysj2U/fSebBcJAcmFxrC2
         /Tk9m3SCEpQsrDlVridmbiOa5DoIj3XduwMBgfuz2MJHNOk1hrZQFUfZDeboO4ayqnCf
         xAuHpuxqj4JGFYbwMaC6W/9Mn94WUZIxjhX6dauEPZ6tTYVvRALbVQ75OI6aqmbfBVOx
         tl//7qnWxG1dkofxM2g/2PlGzhuRgMIwnjoGiiQ8fUKNLW3DP0Wenw6I5dcj18YIz64U
         qi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBnJnA9U9S3KagUnngEcBE9vHXc5AUv/doMbVPNRS3M=;
        b=XEWCplfFHjbn1kSfVqLCzms9MISAZs8pW8nk3i2xtKjXjbhrQ7X6gBjsyu7K5yRANe
         EWgZbBNAcobtnthIZiazMlUhf6nqsPSpbaOEyOv82zaB0jfw9FYmL19Ml9O5C24DtoMC
         QlxfaPgLBIMysj8V/GBQ00haBfT3gzpfk0Tf+l074UfvCpRTQx1dYuMilwQWz0ASq/Pv
         V8exQJxFWwS3S3EykEnezXSbtcMIZ+e69hPo+4R7ljOvL+qeaQ0rQDAtdJznKMXOTUKL
         EPnjDyGAHSA5fnfrA91vYOaqXKHErqqTvNyJJ4jqQNjNN8YHdDyXe/nQ33QW4tL2FMvG
         NJiA==
X-Gm-Message-State: AOAM532csSjaO8oS9w5ZSg9iHtH4LytAgtr904UGy/tvawpkRZogHxnS
        b7cpptW/E7IGZGYEwvy5pEtgIlVOyqDnfc83IVk=
X-Google-Smtp-Source: ABdhPJyBBdtce7X6YzSzBIRP8A8MLaDIvOP+WrtnwMdA5W9VQWaObJqInyQslAQfXCXv4oNyf4z0GJMdf8TOMxscNbo=
X-Received: by 2002:a05:6402:5186:: with SMTP id q6mr27091981edd.96.1643748447233;
 Tue, 01 Feb 2022 12:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch> <20220131210552.482606-2-daniel.vetter@ffwll.ch>
In-Reply-To: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 2 Feb 2022 06:47:15 +1000
Message-ID: <CAPM=9txcHr11R9_bmwBrhz6pDs_Vk0Xb840_piRH9QdYM29KZg@mail.gmail.com>
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sven Schnelle <svens@stackframe.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 at 07:06, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
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

Acked-by: Dave Airlie <airlied@redhat.com>
