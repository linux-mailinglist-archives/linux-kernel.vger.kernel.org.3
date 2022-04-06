Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F704F6528
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbiDFQLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiDFQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:11:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836154E0035
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:39:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a6so4454371ejk.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iyJLK8l5hs8KCNBFxlx1llqa+FYfySe8JZbdJuv2BSY=;
        b=AZPHzmAkPb4vBz8KQIFg70PyU76BInADKyX8st0Ig2+U518SEl0fYZpUw9xiNqn87K
         aFxAL3Rzj+bm6m248CxtYI2apq5TfG0PFHHUmZ81yjVBfZyky+nQJ/y68jjzZEoz3IVP
         2ZeHrhjWp7zRdPFnB94aJ4/AKOIGQDHMVIHBYN9336v/0QdlpMxxmRvr9byy1Bbv4vDL
         t/8yFF66Fj9bRZzxcLG0bXKl15HjhRZclLJAUz756gQUgnTvBYY20cHN7doi1i5nWcX4
         ErVcNb4eFZDmVj0lZzaKcxqtV9IkWmD3avg4JPdWRFGAV0+pyTjszJMDk1upXk7xhzUN
         JwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iyJLK8l5hs8KCNBFxlx1llqa+FYfySe8JZbdJuv2BSY=;
        b=U+DoP9+SCQIW9mWelHpeg3+c5hosev8xFySgzH8gaszeGvBL+JPRvPhNJlgCOMHDel
         UGaxAfzi2uhCOE+vcn30D6CiHwO9R5MUMsiteMvyjz3HmkMra3+1eKxZs+XhguqEJl9N
         zkEkbCcL/Om6RC6maIvfkJkiehx1cUxKFGXwK9VJKHQBckFqc/KnzmTKCcKfEtJ3ymbY
         oewVhfiH+JhQVxURhRv3yjkZUbC64nRSC75Gz02HqjN46Ya0FH3uDvVOq3KczTtWQHpb
         QwWev1K28vU2Uq+WI83GAiEsgF53H7ss0L17a+uSlnbHw0W00UpZQgPZ0XDXiUNXoUgG
         pMtw==
X-Gm-Message-State: AOAM533tQAu4yrhNVi+L2fks5uhcOghRzv0nF8p7oeK2FRX6H31w+dCo
        NUU4xOoZPEH0POd5dUgWmW6mqUynXjARD8pdJjc=
X-Google-Smtp-Source: ABdhPJxMIvTQA11CZ2AiXt7TtQTnJBNSoAaXV+VAZQ4YGkON/JIi45sEq/1i4BR871lm6N50qVjEtGN9q8EZB893/WU=
X-Received: by 2002:a17:906:7947:b0:6da:892f:2503 with SMTP id
 l7-20020a170906794700b006da892f2503mr8161523ejo.710.1649252387873; Wed, 06
 Apr 2022 06:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220405213800.90205-1-h0tc0d3@gmail.com> <CADnq5_PXDyOXX2p4FswWWyY6sw8nXmajhUzx-=ke+6jiZn3ZPA@mail.gmail.com>
In-Reply-To: <CADnq5_PXDyOXX2p4FswWWyY6sw8nXmajhUzx-=ke+6jiZn3ZPA@mail.gmail.com>
From:   =?UTF-8?B?0JPRgNC40LPQvtGA0LjQuQ==?= <h0tc0d3@gmail.com>
Date:   Wed, 6 Apr 2022 16:39:46 +0300
Message-ID: <CAD5ugGDAKGtKLavhqSDObbGRu1WSyE04eQRhUv4Dk7dC+PrK6w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Unnecessary code in gfx_v7_0.c
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joseph Greathouse <Joseph.Greathouse@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
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

Alex Deucher, Thanks, that's what I thought too. But this code is
uninformative, and without it is clear what this code is doing. If you
need to provide additional information on how the code works, then for
me it's better to leave a comment.
This is actually more like a bug than an explanation of what the code is do=
ing.

=D1=81=D1=80, 6 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 16:20, Alex Deucher=
 <alexdeucher@gmail.com>:
>
> On Wed, Apr 6, 2022 at 4:00 AM Grigory Vasilyev <h0tc0d3@gmail.com> wrote=
:
> >
> > The code is useless and doesn't change the value.
> >
> > (0 << GB_ADDR_CONFIG__ROW_SIZE__SHIFT) =3D 0
> > gb_addr_config | 0 =3D gb_addr_config
> >
> > Perhaps there could be 1 instead of 0, but this does not correspond wit=
h
> > the logic of the switch.
>
> It doesn't do anything, but it helps the developer to understand how
> the driver state maps to hardware state.
>
> Alex
>
> >
> > Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v7_0.c
> > index 1cb5db17d2b9..5ed84a6467ee 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > @@ -4409,16 +4409,14 @@ static void gfx_v7_0_gpu_early_init(struct amdg=
pu_device *adev)
> >         /* fix up row size */
> >         gb_addr_config &=3D ~GB_ADDR_CONFIG__ROW_SIZE_MASK;
> >         switch (adev->gfx.config.mem_row_size_in_kb) {
> > -       case 1:
> > -       default:
> > -               gb_addr_config |=3D (0 << GB_ADDR_CONFIG__ROW_SIZE__SHI=
FT);
> > -               break;
> >         case 2:
> >                 gb_addr_config |=3D (1 << GB_ADDR_CONFIG__ROW_SIZE__SHI=
FT);
> >                 break;
> >         case 4:
> >                 gb_addr_config |=3D (2 << GB_ADDR_CONFIG__ROW_SIZE__SHI=
FT);
> >                 break;
> > +       default:
> > +               break;
> >         }
> >         adev->gfx.config.gb_addr_config =3D gb_addr_config;
> >  }
> > --
> > 2.35.1
> >
