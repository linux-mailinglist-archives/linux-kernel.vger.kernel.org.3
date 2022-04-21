Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AEC509FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385008AbiDUMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358695AbiDUMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:42:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE35623BC4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:39:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bx5so4859913pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nssjfya3+9VTlrQeOXbk1Fnunfs1cJh58vKzBuqD+5w=;
        b=pIeQUahUEw73/0XELeSGeveLsVNRSo3mUBldB2hgxa51jomlq8h+OiyitGRnWJ+4BK
         Bvwc7ENq6ZVhtbzcIxC52/o3UeA3ag5bciQsHqThadcTnSmQFJPT9i5NHauFMmNkMZND
         27haqYujf2wKniMfksGkGof29htMzGVVzPhNzDu5YhaeO3By25BLa3LZILWbm7Hg8X8z
         9W1g/5HjhR2uOiRGl2pLNsAOGzQON1T7vHNHiAmGOSOA1Th3j7uZpzCfm6u7zse/hG91
         D1xLqeRFu1Bfufg+PxXA044rlFO2dp6PsGX/J9yHFtOS7rX06qTnS1b2M9FTyUV2IotV
         uPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nssjfya3+9VTlrQeOXbk1Fnunfs1cJh58vKzBuqD+5w=;
        b=4QJmgon0k7F96C7I0XgqrTPQlScbdDLvErTYLQprQ0ivV3xzocjiNwZuwT+eD6T0c2
         /SgLYbIZqCawpb7ZfbFBERvC/ViM/9C2/lB5Z/EfWs3KsPjQCNWhHEM1fTSBbvV+6SfM
         VQOB4U/m8lCu9tgksfiEFkcEWcetv3eSFBYwxFURpuAvAJbiNct0qtYjUeTepxrJN8Lp
         oGLsVGPXd/YlZPZgG0bXPgEpIQVEp/n23ZXBbh7rmcaK5FT6OGH0M9n4SyyvDvpx+3ds
         7+sOXdwetUi5vq2i0KbZH5wbHcZiPggNNdiX5+fgQiO1ONoHPe6p1WQH7hdRln7P8ieQ
         BLfg==
X-Gm-Message-State: AOAM5309pPhmtg5zpvORQdUGr/stJ17jsildFYnona0alljdthC0HBHd
        h3t7mw/Rohe9MMjhygkkShqzdDJwK6oQTPnsgtE=
X-Google-Smtp-Source: ABdhPJydPCqhqGo0Ypkm47vjMGBgOdnq/oMsB6raDz0GdtqLPYfAOOwVPepZ7ZvInejprP2fCo8W0387QvKQTPdm/yc=
X-Received: by 2002:a17:90b:1a8a:b0:1d2:e93e:6604 with SMTP id
 ng10-20020a17090b1a8a00b001d2e93e6604mr10172088pjb.233.1650544760102; Thu, 21
 Apr 2022 05:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com> <b3f7e288-3341-8c6f-1b95-e553ac5ebc35@suse.de>
In-Reply-To: <b3f7e288-3341-8c6f-1b95-e553ac5ebc35@suse.de>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Thu, 21 Apr 2022 14:39:08 +0200
Message-ID: <CAMeQTsbh-Fy4CORBTX=AfZ+K-fZYUQ=hY=ctLFyu9KcJ5NgFUA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 1:49 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 09.04.22 um 06:23 schrieb James Hilliard:
> > Select the efi framebuffer if efi is enabled.
> >
> > This appears to be needed for video output to function correctly.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v2 -> v3:
> >    - select EFI_FB instead of depending on it
> > Changes v1 -> v2:
> >    - use depends instead of select
> > ---
> >   drivers/gpu/drm/gma500/Kconfig | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
> > index 0cff20265f97..a422fa84d53b 100644
> > --- a/drivers/gpu/drm/gma500/Kconfig
> > +++ b/drivers/gpu/drm/gma500/Kconfig
> > @@ -2,11 +2,13 @@
> >   config DRM_GMA500
> >       tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
> >       depends on DRM && PCI && X86 && MMU
> > +     depends on FB
>
> Why do we need FB here? Framebuffer support should be hidden by DRM's
> fbdev helpers.

It is not needed but gives him video output since it enables the drm
fbdev emulation.

I looked some more at the logs and it seems weston doesn't work on his
system without the fbdev backend. So the question is why weston isn't
working without fbdev? Perhaps this is just a Weston configuration
issue?
