Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC20B592029
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbiHNO1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiHNO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:27:41 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF911C27
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:27:39 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 11so822025ybu.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=BDAVIhnSkgENDUQ7IfYC3/2QkAEAsNSSEneZku1M24s=;
        b=p0gfoBw4ZgOT1ksw69dVgdZR0JT7daeCJ16dH8wcxMLnRGqjA3uhDchB1lA7TQfaYX
         BrQw9XUmookElN0tbP/iD4tNxHbscwSregEaqi3xk9KU+HnauYP7IDU38X3ZZJGiM3hc
         2cUIIAVEHjFscy2B3j5HOgzkZTsMCx9rw/txu7rZ55uaJm4jlwQc7RspbXg/YAloW0C/
         0svWUNrFbrZiZ7KzaV5kWEWoFtC/V4k27Ur2X/IFi253YZhnsFFyEBoQ+jjOu06CSB77
         L5qDaCYzVqdwx8ZM/qx64yS4r691EzmylMr4OT3lTcBSK98a1Kt2wCd0iOF2OHsyy1IV
         Yv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=BDAVIhnSkgENDUQ7IfYC3/2QkAEAsNSSEneZku1M24s=;
        b=h8irLGKgl7i64g4joOVZhXaoQYLYl32+tSfAC+TcfRz+dgTiOxUPW2cXf42nYrPWMH
         +OiNfuvMjQ5YCGFOwmDhgg12b4efiYiSmml1/nus4b6+rHd+FwgitN4xp8xgJriL3Ndg
         UorelNW8bjR/dr3oMNMfF8643FaVjA/XYotyu9Xr+aKl1SpsroFXS497n0VeaEsk8YTR
         F2c7Km+BFB1msTdmJ9Nydemuh6ode3RX8jkYxVjxCxaEaOzqeHwii8DTpg4qHmu3+peN
         VbgubKqciSFUdxuWHhvsuy5Nma0ONBw8Sr8AXMisqfvCCWC2v55Mek6Kpu6LqTMs8edB
         dIhw==
X-Gm-Message-State: ACgBeo0X+ewGpCL8moUt/3R6BSC49IoRX98iLjk/oHiYyu2WjHJnUMIg
        XiPymCugeFR64tAdJhDF3cYJLVShD1U7vvxulp7Pvw==
X-Google-Smtp-Source: AA6agR5oRn4CSLlwRnezXr30VfLoZdKWLSMB++KAjfSH1Z47K3NbFei2uLb/C/FS4mNgtaqJbSfnADfGVfrcqLFcy4o=
X-Received: by 2002:a25:cb05:0:b0:67c:29a8:cb9c with SMTP id
 b5-20020a25cb05000000b0067c29a8cb9cmr9640988ybg.135.1660487259148; Sun, 14
 Aug 2022 07:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <5b6d3e7f-c638-fdc7-5080-44d34abed610@ideasonboard.com> <a3ed3a2c-86ce-1c85-e8aa-c08b54ad1a43@gmail.com>
 <CAMSo37XdZSZUHLWJj373DdtOBA9=uD8SJ7ywWCYF2pU1i4cB_g@mail.gmail.com> <ed4fe238-4fcd-1253-658f-18fe1e1f13b0@gmail.com>
In-Reply-To: <ed4fe238-4fcd-1253-658f-18fe1e1f13b0@gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Sun, 14 Aug 2022 22:27:27 +0800
Message-ID: <CAMSo37V3U5nYng77jzSnKH73CTLhGYQJu11Q5wRt289se5nFJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs through DMM/TILER
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, tomba@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        merlijn@wizzup.org, tony@atomide.com,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, IvayIo

Thanks very much for the reply!

On Sat, 13 Aug 2022 at 14:58, Ivaylo Dimitrov
<ivo.g.dimitrov.75@gmail.com> wrote:
>
> Hi Liu,
>
> On 12.08.22 =D0=B3. 7:35 =D1=87., Yongqin Liu wrote:
> > Hi, Ivaylo, Tomi
> >
> > We have one X15 Android AOSP master build, it could not have the home
> > screen displayed
> > on the hdmi monitor connected with this change, with the following
> > message printed on the serial console
> >      [  607.404205] omapdrm omapdrm.0: Failed to setup plane plane-0
> >      [  607.410522] omapdrm omapdrm.0: Failed to setup plane plane-1
> >      [  607.416381] omapdrm omapdrm.0: Failed to setup plane plane-2
> >      [  607.422088] omapdrm omapdrm.0: Failed to setup plane plane-3
> >
> >     # for details, please check the link here: http://ix.io/47m1
> >
> > It will work with home screen displayed on the hdmi monitor if this
> > change is reverted.
> >
> > Is this the broken problem you talked about here?
> >
> > And could you please give some suggestions on how to have the x15
> > Android build work with this change?
> >
>
> Make sure scanout (i.e. those to be displayed) buffers are actually
> allocated as such - OMAP_BO_SCANOUT flag must be set when calling
> omap_bo_new().

I am not familiar with this area, I am sorry if I asked quite silly questio=
ns:(
I googled omap_bo_new, and found it's a function of libdrm here[1], is
it what you meant here?

If it's the omap_bo_new that we should pass OMAP_BO_SCANOUT when it is call=
ed,
then is it the correct way to update omap_bo_new to add the OMAP_BO_SCANOUT=
 flag
before it calls omap_bo_new_impl?

And another question is that, since the userspace(libdrm) will be used
to work with different kernel versions,
like the old 4.14, 4.19, etc, do you think there will be problem to
pass  OMAP_BO_SCANOUT
from the userspace side with the old kernels(which does not have this chang=
e)?
does this change need to be backported to the old kernel versions?

And the last question is that, omap_bo_new might be called by some
property binaries what not everyone
could get the source to update, for such case what's your suggestions?

[1]: https://gitlab.freedesktop.org/mesa/drm/-/blob/main/omap/omap_drm.c#L2=
27

Thanks,
Yongqin Liu
> > On Thu, 17 Feb 2022 at 23:29, Ivaylo Dimitrov
> > <ivo.g.dimitrov.75@gmail.com> wrote:
> >>
> >>
> >>
> >> On 17.02.22 =D0=B3. 14:46 =D1=87., Tomi Valkeinen wrote:
> >>> Hi,
> >>>
> >>> On 19/01/2022 12:23, Ivaylo Dimitrov wrote:
> >>>> On devices with DMM, all allocations are done through either DMM or
> >>>> TILER.
> >>>> DMM/TILER being a limited resource means that such allocations will =
start
> >>>> to fail before actual free memory is exhausted. What is even worse i=
s
> >>>> that
> >>>> with time DMM/TILER space gets fragmented to the point that even if =
we
> >>>> have
> >>>> enough free DMM/TILER space and free memory, allocation fails becaus=
e
> >>>> there
> >>>> is no big enough free block in DMM/TILER space.
> >>>>
> >>>> Such failures can be easily observed with OMAP xorg DDX, for example=
 -
> >>>> starting few GUI applications (so buffers for their windows are
> >>>> allocated)
> >>>> and then rotating landscape<->portrait while closing and opening new
> >>>> windows soon results in allocation failures.
> >>>>
> >>>> Fix that by mapping buffers through DMM/TILER only when really neede=
d,
> >>>> like, for scanout buffers.
> >>>
> >>> Doesn't this break users that get a buffer from omapdrm and expect it=
 to
> >>> be contiguous?
> >>>
> >>
> >> If you mean dumb buffer, then no, this does not break users as dumb
> >> buffers are allocated as scanout:
> >>
> >> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/omapdrm=
/omap_gem.c#L603
> >>
> >> If you mean omap_bo allocated buffers, then if users want
> >> linear(scanout) buffer, then they request it explicitly by passing
> >> OMAP_BO_SCANOUT.
> >>
> >> Ivo
> >
> >
> >



--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
