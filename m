Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6099559684D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiHQEwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiHQEwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:52:46 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9CF78BCB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:52:44 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-324ec5a9e97so203044667b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=P+P7U2dHcH7HvKdIM34nR5zTB1057uLXCO9nJeUpApE=;
        b=mInliz2MDp3Y2l0zLTVTwFKtILUmFyBlHw3FlaOd6SS7mQ5Eb2y2m04Jw/NqPlQreV
         g5xXktTWhDRD4/VNBp1yizy48nHp/Vok2EuGpI/ddA62h3Sb122HX6Qtf+OP5y1gq3/O
         vo+k/SGsKTuT43xLS5sIT3ECxsBSl1tuT57awW6MoNe2A/poRkUozM+mw4UMv/9UZ3Gh
         JZNp77vAcNzp/IknxliP1A0kf1ShqGpCBiVQUrZLstDWp+N/6KuDVKEEtCSzFChEDE76
         3ayfxifKTcpccrmxNEZvLX52svkIq5YJ9p7sSTjS8H1T4HpoCbd9+jiNVMC7/10ObMPI
         AzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=P+P7U2dHcH7HvKdIM34nR5zTB1057uLXCO9nJeUpApE=;
        b=PvuO3vpMcwCyfM1pCrYu3IGPC3IlJ7lM379CsrgaN4pZ9jc+RMzzhiQ7oPVqMCYtFA
         OXz4k4XxmuktBnoP5ciOOOwdqQ+OzBRh4d3hthb3l9h2k0ZHtTrvK2yd4ZpCTzhlrn6Q
         7hjYPkMLp3E2bc5/wO1yVXfi4gVge7hX2fyXewHLyvYgA6L2HFVzK7rGzyVJkSsRZfcG
         J00GaX0XarTnGDgkprEhl3Zi/816glhoPNPk6uHq0a6i7ufhFKo2dpoWVuJCa6duxxhQ
         +T18yZlES5/+DaJRwLwnC4Duw+i4OoQkO4PPCIOMJgVvjwtfQ1V3vK3aiot4DxQ+s6f6
         h0PQ==
X-Gm-Message-State: ACgBeo1+IzU4u+FFML0oyQMH/1QoBTdA6JVVpKod9K9JnkIPM/PO2TRU
        yCVYWNtc3i2ycgduXGJEv4w+3FmrLv+Q//7O7htRUQ==
X-Google-Smtp-Source: AA6agR4n9oAPiASwsUuBj7VCDanSfJyRQbFukds9m7aRqQZqh5v6CSqLW42Mr30/VlqZmXCPVbQX4WEOqI6qpJpB2kE=
X-Received: by 2002:a25:2b01:0:b0:68a:6dff:4a87 with SMTP id
 r1-20020a252b01000000b0068a6dff4a87mr7229961ybr.364.1660711963618; Tue, 16
 Aug 2022 21:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <5b6d3e7f-c638-fdc7-5080-44d34abed610@ideasonboard.com> <a3ed3a2c-86ce-1c85-e8aa-c08b54ad1a43@gmail.com>
 <CAMSo37XdZSZUHLWJj373DdtOBA9=uD8SJ7ywWCYF2pU1i4cB_g@mail.gmail.com>
 <ed4fe238-4fcd-1253-658f-18fe1e1f13b0@gmail.com> <CAMSo37V3U5nYng77jzSnKH73CTLhGYQJu11Q5wRt289se5nFJw@mail.gmail.com>
 <4128aed0-211a-d12a-6a86-deb4457d39f7@gmail.com>
In-Reply-To: <4128aed0-211a-d12a-6a86-deb4457d39f7@gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Wed, 17 Aug 2022 12:52:32 +0800
Message-ID: <CAMSo37W-DePLDP=zk-nY6FGcZuk0QzHj4=usrieyV0TNcNfbXw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ivaylo

On Mon, 15 Aug 2022 at 14:23, Ivaylo Dimitrov
<ivo.g.dimitrov.75@gmail.com> wrote:
>
> Hi Liu,
>
> On 14.08.22 =D0=B3. 17:27 =D1=87., Yongqin Liu wrote:
> > Hi, IvayIo
> >
> > Thanks very much for the reply!
> >
> > On Sat, 13 Aug 2022 at 14:58, Ivaylo Dimitrov
> > <ivo.g.dimitrov.75@gmail.com> wrote:
> >>
> >> Hi Liu,
> >>
> >> On 12.08.22 =D0=B3. 7:35 =D1=87., Yongqin Liu wrote:
> >>> Hi, Ivaylo, Tomi
> >>>
> >>> We have one X15 Android AOSP master build, it could not have the home
> >>> screen displayed
> >>> on the hdmi monitor connected with this change, with the following
> >>> message printed on the serial console
> >>>       [  607.404205] omapdrm omapdrm.0: Failed to setup plane plane-0
> >>>       [  607.410522] omapdrm omapdrm.0: Failed to setup plane plane-1
> >>>       [  607.416381] omapdrm omapdrm.0: Failed to setup plane plane-2
> >>>       [  607.422088] omapdrm omapdrm.0: Failed to setup plane plane-3
> >>>
> >>>      # for details, please check the link here: http://ix.io/47m1
> >>>
> >>> It will work with home screen displayed on the hdmi monitor if this
> >>> change is reverted.
> >>>
> >>> Is this the broken problem you talked about here?
> >>>
> >>> And could you please give some suggestions on how to have the x15
> >>> Android build work with this change?
> >>>
> >>
> >> Make sure scanout (i.e. those to be displayed) buffers are actually
> >> allocated as such - OMAP_BO_SCANOUT flag must be set when calling
> >> omap_bo_new().
> >
> > I am not familiar with this area, I am sorry if I asked quite silly que=
stions:(
> > I googled omap_bo_new, and found it's a function of libdrm here[1], is
> > it what you meant here?
> >
>
> Yes, calling this function from userspace ends in kernel code the
> $subject patch is part of.
>
> > If it's the omap_bo_new that we should pass OMAP_BO_SCANOUT when it is =
called,
> > then is it the correct way to update omap_bo_new to add the OMAP_BO_SCA=
NOUT flag
> > before it calls omap_bo_new_impl?
> >
>
> omap_bo_new() is fine and does not need any updates/fixes, it is the
> code that uses it (whoever it is, I am not familiar with the userspace
> you are using) that shall pass correct flags (third parameter) when
> calling it.

Sorry, I do not get the point here.
Like you said, the code that calls omap_bo_new needs to pass OMAP_BO_SCANOU=
T,
then IMO omap_bo_new should be the best place to add the OMAP_BO_SCANOUT fl=
ag,
(like via flags =3D flags | OMAP_BO_SCANOUT), that could help avoid
missing the flag by some code,
and also avoids hacks/changes on the possible blob binaries.

Do I misunderstand somewhere?
Or is there some case that OMAP_BO_SCANOUT shouldn't be passed when
omap_bo_new is called?

> BTW you shall really find who and how uses OMAP BO API, in theory it
> might use ioctls directly and not call omap_bo_xxx functions.

Do you mean the DRM_OMAP_GEM_NEW ioctl api?
There is no place in the AOSP tree to call that except the
omap_bo_new_impl function,
which is called by the omap_bo_new and omap_bo_new_tiled functions.
The omap_bo_new should not be called with the OMAP_BO_TILED flag,
while the omap_bo_new_tiled should be called with the OMAP_BO_TILED flag

Regarding to the omap_bo_new function, there are 2 places call it in
the AOSP tree:
#1 ./external/libkmsxx/kms++/src/omap/omapframebuffer.cpp
#2 ./device/ti/beagle_x15/gpu/gralloc.am57x.so

#1 seems not used in AOSP yet, and #2 is one blob binary we do not
have the source for.

> strace
> would be your friend there. or gdb, or whatever tools are used on
> android. Or put some printfs() in omap_bo_new() that output the PID of
> the calling process, etc.

Thanks a lot for these great suggestions! Will use them when possible.

> > And another question is that, since the userspace(libdrm) will be used
> > to work with different kernel versions,
> > like the old 4.14, 4.19, etc, do you think there will be problem to
> > pass  OMAP_BO_SCANOUT
> > from the userspace side with the old kernels(which does not have this c=
hange)?
> > does this change need to be backported to the old kernel versions?
>
> There should not be any issue. The changes could be backported if one
> hits the issues this $series is fixing, but there is no need.

Thanks for the confirmation!
I just boot-tested with adding OMAP_BO_SCANOUT in the omap_bo_new function,
and it worked with the current 4.14, 4.19, and the mainline kernels.
# via adding line "flags =3D flags | OMAP_BO_SCANOUT" in the omap_bo_new fu=
nction.

> >
> > And the last question is that, omap_bo_new might be called by some
> > property binaries what not everyone
> > could get the source to update, for such case what's your suggestions?
> >
>
> Hard to say without knowing what that library would be.
>
> When I hit issues with closed blobs, sometimes I reverse-engineer them
> to fix the issue, example:
>
> https://github.com/maemo-leste/sgx-ddk-um/tree/master/dbm
>
> This is REed libdbm from sgx-ddk-um 1.17.4948957, that is responsible
> for allocating BOs (what omap_bo_new() does) but it uses DUMB buffers
> API, instead of OMAP BO API.
>
> I guess you are using some older version of sgx-ddk-um, so you may fix
> in similar way. Or binary patch.

The blob binary that calls omap_bo_new is the gralloc.am57x.so here[2]:
any suggestions with it?
# sorry, I am not able to find out how you did the reverse-engineer
work# with the dbm repository shared here,
# not sure if you could give some tutorial steps for the similar
reverse-engineer# work with gralloc.am57x.so

[2]: https://android.googlesource.com/device/ti/beagle-x15/+/refs/heads/mas=
ter/gpu/gralloc.am57x.so

Thanks,
Yongqin Liu

> >>> On Thu, 17 Feb 2022 at 23:29, Ivaylo Dimitrov
> >>> <ivo.g.dimitrov.75@gmail.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 17.02.22 =D0=B3. 14:46 =D1=87., Tomi Valkeinen wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 19/01/2022 12:23, Ivaylo Dimitrov wrote:
> >>>>>> On devices with DMM, all allocations are done through either DMM o=
r
> >>>>>> TILER.
> >>>>>> DMM/TILER being a limited resource means that such allocations wil=
l start
> >>>>>> to fail before actual free memory is exhausted. What is even worse=
 is
> >>>>>> that
> >>>>>> with time DMM/TILER space gets fragmented to the point that even i=
f we
> >>>>>> have
> >>>>>> enough free DMM/TILER space and free memory, allocation fails beca=
use
> >>>>>> there
> >>>>>> is no big enough free block in DMM/TILER space.
> >>>>>>
> >>>>>> Such failures can be easily observed with OMAP xorg DDX, for examp=
le -
> >>>>>> starting few GUI applications (so buffers for their windows are
> >>>>>> allocated)
> >>>>>> and then rotating landscape<->portrait while closing and opening n=
ew
> >>>>>> windows soon results in allocation failures.
> >>>>>>
> >>>>>> Fix that by mapping buffers through DMM/TILER only when really nee=
ded,
> >>>>>> like, for scanout buffers.
> >>>>>
> >>>>> Doesn't this break users that get a buffer from omapdrm and expect =
it to
> >>>>> be contiguous?
> >>>>>
> >>>>
> >>>> If you mean dumb buffer, then no, this does not break users as dumb
> >>>> buffers are allocated as scanout:
> >>>>
> >>>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/omapd=
rm/omap_gem.c#L603
> >>>>
> >>>> If you mean omap_bo allocated buffers, then if users want
> >>>> linear(scanout) buffer, then they request it explicitly by passing
> >>>> OMAP_BO_SCANOUT.
> >>>>
> >>>> Ivo
> >>>
> >>>
> >>>
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
