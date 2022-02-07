Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE04ACB10
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiBGVRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiBGVRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:17:54 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F15DC06173B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:17:53 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so15202156oor.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v+WQ2xVsw1oloryxWnpzmbXz/wxjOTMCRW462Qc7Xqs=;
        b=OcbJiNLwcq0sJ+Fp2kOwKKLiaUv/95AU39rRIU3j1+5ZXPbY/Vqzi2PtntwgWpj5Ml
         fTnmnmSS8KZlEzsgsMmmCweGE2X/N0ej1u78XhcaI6XtkNZ6g/+g/TuVUsxDQUml+Dpe
         uMs+G9iV6LbilyL7ZkyZhOgdkledFfpR7vVRJsjani5xa/2Q3cLGgDSZ4sfhknDGSm/R
         Noh9ntR2Crldtj5S7t83+1zhG6aMj2E2jD43qJLgrzj5bncxqBRnhM/V94F3OhMVk609
         wnZ+69LbP8FisjhLua+Ss1pvnCcF6ohwjkXEvyaURztnFTEYFNVKc0J/E+h8CLJH4qEY
         je7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v+WQ2xVsw1oloryxWnpzmbXz/wxjOTMCRW462Qc7Xqs=;
        b=xyn6ScXefTDTM2kZVyv0N1dtWAZPNDtYlYSdAQp4F9QA2ewIzs+QtncY0eMVrMGflc
         MHiFPaQk9IjLQlu2Ipddfo8pefUJmYPH/SbbU/9YPsTqDsNkn6ycjfJ022NNl5vWZB/F
         xH60Z2pMydsxJQEnEb2ggxnD9YkZSs/6+7QcuFy1NVIHhuXPHZBKIC+6m8wq7xi4kd/5
         NzO6+2qddvFxdyLHdk1UQ/b6erHjFbkw8S1AJoMZZXUioajyvFpadTa7/0ghM8P/GZmU
         /y+r7I3uRW+erUM2XMuS0kw6B8d7ZsCdNtmfmA7lsyvz1j0HHmK3lWb9bwOSveFHMjrS
         F5Ng==
X-Gm-Message-State: AOAM532cm9Ms16PuQN37oCJl5En8sjjTwAdv1qdHuk9tqwjelfY8k1X4
        uq5ysA2ME71x6g5pjyUtk29HiFRpPuPzu+ysXI0=
X-Google-Smtp-Source: ABdhPJwxahO9gU4b7vgJU1VxOUJqEJqsTZeca/z/V2pSmCt5TD2eqOzVnHKuDMsSBe3vZzP16U85FdCFWaUpUsoZsn8=
X-Received: by 2002:a05:6870:790c:: with SMTP id hg12mr285137oab.73.1644268672692;
 Mon, 07 Feb 2022 13:17:52 -0800 (PST)
MIME-Version: 1.0
References: <YfskWvNqt81rZZpQ@fedora> <DM6PR12MB26199543AD01C2DA18CCFB64E42C9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26199543AD01C2DA18CCFB64E42C9@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Feb 2022 16:17:41 -0500
Message-ID: <CADnq5_OgYywwhy1GJsX=z6pttMVbo2kJc5uOT8WMrEWR8O2Mhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: add missing prototypes to amdgpu_dpm_internal
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "Chen, Guchun" <Guchun.Chen@amd.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>,
        "jiapeng.chong@linux.alibaba.com" <jiapeng.chong@linux.alibaba.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Sun, Feb 6, 2022 at 10:30 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Thanks for the fix!
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: Ma=C3=ADra Canal <maira.canal@usp.br>
> > Sent: Thursday, February 3, 2022 8:40 AM
> > To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> > airlied@linux.ie; daniel@ffwll.ch; nathan@kernel.org;
> > ndesaulniers@google.com; Lazar, Lijo <Lijo.Lazar@amd.com>; Tuikov, Lube=
n
> > <Luben.Tuikov@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>;
> > Zhang, Hawking <Hawking.Zhang@amd.com>;
> > jiapeng.chong@linux.alibaba.com
> > Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; lin=
ux-
> > kernel@vger.kernel.org
> > Subject: [PATCH] drm/amd/pm: add missing prototypes to
> > amdgpu_dpm_internal
> >
> > Include the header with the prototype to silence the following clang
> > warnings:
> >
> > drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:6:
> > warning: no
> > previous prototype for function 'amdgpu_dpm_get_active_displays'
> > [-Wmissing-prototypes]
> > void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
> >      ^
> > drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:1: note:
> > declare
> > 'static' if the function is not intended to be used outside of this
> > translation unit
> > void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
> > ^
> > static
> > drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:76:5:
> > warning: no
> > previous prototype for function 'amdgpu_dpm_get_vrefresh'
> > [-Wmissing-prototypes]
> > u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
> >     ^
> > drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:76:1: note:
> > declare
> > 'static' if the function is not intended to be used outside of this
> > translation unit
> > u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
> > ^
> > static
> > 2 warnings generated.
> >
> > Besides that, remove the duplicated prototype of the function
> > amdgpu_dpm_get_vblank_time in order to keep the consistency of the
> > headers.
> >
> > fixes: 6ddbd37f ("drm/amd/pm: optimize the amdgpu_pm_compute_clocks()
> > implementations")
> >
> > Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c | 1 +
> >  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h      | 1 -
> >  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c   | 1 +
> >  3 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
> > index ba5f6413412d..42efe838fa85 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
> > @@ -25,6 +25,7 @@
> >  #include "amdgpu_display.h"
> >  #include "hwmgr.h"
> >  #include "amdgpu_smu.h"
> > +#include "amdgpu_dpm_internal.h"
> >
> >  void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
> >  {
> > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > index 5cc05110cdae..09790413cbc4 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > @@ -343,7 +343,6 @@ struct amdgpu_pm {
> >       struct amdgpu_ctx       *stable_pstate_ctx;
> >  };
> >
> > -u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
> >  int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum
> > amd_pp_sensors sensor,
> >                          void *data, uint32_t *size);
> >
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > index 7427c50409d4..caae54487f9c 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > @@ -28,6 +28,7 @@
> >  #include "amdgpu_pm.h"
> >  #include "amdgpu_dpm.h"
> >  #include "amdgpu_atombios.h"
> > +#include "amdgpu_dpm_internal.h"
> >  #include "amd_pcie.h"
> >  #include "sid.h"
> >  #include "r600_dpm.h"
> > --
> > 2.34.1
