Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC44F8723
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbiDGSiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiDGSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:38:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69040559D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:36:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dr20so12608185ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=efsOEK74uxQH0g4CA1QrPFjgXzWZd0T4aU7euJISdQs=;
        b=qHBU2iY1gdx/BaLr7O+TicPwlIUJq0P588uTeJuPqy+p4jbqR3GT1rpakWQ1FwYg6H
         9vCwzfhEX0k156qWY/2XNSeYGmSd+MeAcVfgmpSZkWEEDrVAlSYDO1bJf4GsKoiTaRjf
         Fa6uMjaxFuznkMDuOwUBW9mfx0E4B415zukgiJ+u43lIQ1HG073zu3bRGzQNn8jh3/xu
         BacDAA/ttzHu3krCFUSLk7uV7HDep2eeb1v4hh9429ZgHcZioQUz/CXJMUrpgF/V/bPz
         GF9VD56SR/TnQU6QN1TXCBYbCC+grCuIO7qj6fgtCqnT+705f9ajUuS6Zy6AG4OIQpWZ
         UBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=efsOEK74uxQH0g4CA1QrPFjgXzWZd0T4aU7euJISdQs=;
        b=4bJY4i3VSH6AXZIPS1aNnEmF+ZHjRztwsRQrXYoTd0zBeAvV++1gm6WC1+IghMJNVO
         FiztAqWv6l4d4ydguE8un6URomIPkfH0zbajYLF6A1mbnhHEKe7+EBXw1jiQTAvQbrLe
         8Pd8EdAqOGx32orFYw5+waazioIUdGXdXYk/bLMlUOuB523MI3B6x7U6MFapfUPjEfmg
         cbqrm+M+yWrD3XPzDNx/u+nvtVhkD61ABMdKBCXEIZN9gHEiZitAJLAjCnbMFLuAD3/H
         ZTIQSsBoh50zqfOTfo3Ut8lpiT8k4RFeXt0z7WpOa4wwO/WtRy0S3jrrMR2mnYu/lzdr
         cR0g==
X-Gm-Message-State: AOAM533i+Z6EQdyP/uy7l0KC9oW6nRGQ9K2UC5BGwkKLoa+Yi+PI+VtH
        RxRrFkJ0v+s/avgiXT74NzsOkaD225SEL2YB/ms=
X-Google-Smtp-Source: ABdhPJxy1jWI5CERHD0x1aaFsei6BQ4Qn3oXT1cfmvk0+B0UJyjaV5LYpzZPw2p9s5subhfYioZotT1XZiWr7wT7vpI=
X-Received: by 2002:a17:906:7947:b0:6da:892f:2503 with SMTP id
 l7-20020a170906794700b006da892f2503mr14421854ejo.710.1649356566868; Thu, 07
 Apr 2022 11:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220406165057.97492-1-h0tc0d3@gmail.com> <26951c45-f742-2f0e-f4a6-281a031c3471@gmail.com>
 <CADnq5_NXzEzo=6adPQzEBrAGtWfegyvi=yGHVVOsb+3r9OiNaQ@mail.gmail.com>
In-Reply-To: <CADnq5_NXzEzo=6adPQzEBrAGtWfegyvi=yGHVVOsb+3r9OiNaQ@mail.gmail.com>
From:   =?UTF-8?B?0JPRgNC40LPQvtGA0LjQuQ==?= <h0tc0d3@gmail.com>
Date:   Thu, 7 Apr 2022 21:36:05 +0300
Message-ID: <CAD5ugGDe1SnjEKfoJp0yS8BM-PPc=dOJ+7u-eEkMH0pSOTyFZg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix code with incorrect enum type
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>, Daniel Vetter <daniel@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Joseph Greathouse <Joseph.Greathouse@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Deucher I will do it. Initially, I came across an error that
different enum types are used.
Now I looked at the files, and indeed AMDGPU_GFX_PIPE_PRIO_* is used
instead of AMDGPU_RING_PRIO_*.
The question remains whether it is worth increasing the priority to
AMDGPU_RING_PRIO_MAX=3D3 ?

Regards, Grigory.

=D1=87=D1=82, 7 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 20:46, Alex Deucher=
 <alexdeucher@gmail.com>:
>
> On Thu, Apr 7, 2022 at 2:21 AM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 06.04.22 um 18:50 schrieb Grigory Vasilyev:
> > > Instead of the 'amdgpu_ring_priority_level' type,
> > > the 'amdgpu_gfx_pipe_priority' type was used,
> > > which is an error when setting ring priority.
> > > This is a minor error, but may cause problems in the future.
> > >
> > > Instead of AMDGPU_RING_PRIO_2 =3D 2, we can use AMDGPU_RING_PRIO_MAX =
=3D 3,
> > > but AMDGPU_RING_PRIO_2 =3D 2 is used for compatibility with
> > > AMDGPU_GFX_PIPE_PRIO_HIGH =3D 2, and not change the behavior of the
> > > code.
> > >
> > > Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
> >
> > Good catch, Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v8_0.c
> > > index 5554084ec1f1..9bc26395f833 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > @@ -1929,7 +1929,7 @@ static int gfx_v8_0_compute_ring_init(struct am=
dgpu_device *adev, int ring_id,
> > >               + ring->pipe;
> > >
> > >       hw_prio =3D amdgpu_gfx_is_high_priority_compute_queue(adev, rin=
g) ?
> > > -                     AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_RING_PRIO_DE=
FAULT;
> > > +                     AMDGPU_RING_PRIO_2 : AMDGPU_RING_PRIO_DEFAULT;
>
> gfx_v8_0.c, gfx_v9_0.c, gfx_v10_0.c all do this.  Care to fix them all up=
?
>
> Alex
>
> > >       /* type-2 packets are deprecated on MEC, use type-3 instead */
> > >       r =3D amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, ir=
q_type,
> > >                            hw_prio, NULL);
> >
