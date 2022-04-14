Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D95500E63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 15:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbiDNNN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242365AbiDNNNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:13:54 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D91AF13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:11:26 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z8so5323789oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FJTqqynozRlFhZj6zQE6SI9JAXhhpX1MJOvb4vtV6bk=;
        b=b0VXhbb5s9tmmkoY9HD0UOaq4Nn461oG+PsAXbQQhdIuaxr9c2qvZveP19JJwNO6gd
         MFvH13UWVGq6UqdEvMht9odRsCXK++sZ0pz1duuz2/2QqHh+iCDCL6WnX8UZh0teINV3
         qBhJKCiwiH4Ekk5J8aKj54TsAxeHiTaVt0y3HDmIViIqlTBSJ1YHBVlYSxr8q78GiphC
         w2mtnHLDX6jFxDn+9Aztz+DNx1rH1XEUeyG4+X4FLa9fV/yDjrafl3B2fAhEZNMHmy7+
         4nK0m0Ex/+TUnsUT9Te6rYgcj2UAO86sefVgXCkbyrL9Y6FlQglzoOpwvbh1EMMQvtda
         W8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FJTqqynozRlFhZj6zQE6SI9JAXhhpX1MJOvb4vtV6bk=;
        b=iRu2MiK+BRm6f/KwmpDoZxKOixpLjDtDvnk7Vgkr6vAaEiNB8YABjxuEm/GdscIlbU
         8DHobINkAQPCsvAaAyRIAxXV4Jizzd129YwD1TT9ov+dWTjSoKVnWvxY4WC9VQeW01Jr
         wnTPNMgmH1Cu/IZIfXQIaJitAdhfSyTkuqjWvIPALkF4KDR1Nq4nZ57atLwNh4ZSCQae
         H2+DP7rYvipn3woPXn+psEpKwSWp0w7HEiUBw+WTosc5uh26T+QtbFVBCilJU9ztKIy3
         xqLi993k3NHzaNDQ80kDLWY+VNHysY7GvtWNFtO9fyMgachAxRCmI6UUNfywgzYMphZK
         58Uw==
X-Gm-Message-State: AOAM5324lYP29zJjHYGQgtXt+tU88WrEkXyhh9oVJXvpdEcQZXvSUk+i
        sjEnH3DzKrFM/fAAn0l5u1Q3aNjn4WSdt/sxqfA=
X-Google-Smtp-Source: ABdhPJylCbYVBm3BfzEiRvj1FrCDnwDBCv10i0cu00almCCBVRtEVezMTYQm0DJI1RRgTvCyd2GsFEdwvVO1QzqvPZE=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr1319996oiw.253.1649941886069; Thu, 14
 Apr 2022 06:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220412215000.897344-1-richard.gong@amd.com> <d4ba3998-34aa-86d2-bde9-bc6ae9d8d08d@molgen.mpg.de>
 <CADnq5_MgvcGPWf2gYn_3qCr+Gq1P39tvv-W-o8NhivvMpMwUBA@mail.gmail.com> <91e916e3-d793-b814-6cbf-abee0667f5f8@molgen.mpg.de>
In-Reply-To: <91e916e3-d793-b814-6cbf-abee0667f5f8@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Apr 2022 09:11:14 -0400
Message-ID: <CADnq5_MJuH1KEHHWfuF4gY=LOAZ=2adBZ61jqL5k2WnupdFx4Q@mail.gmail.com>
Subject: Re: [PATCHv4] drm/amdgpu: disable ASPM on Intel Alder Lake based systems
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Richard Gong <richard.gong@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        xinhui pan <xinhui.pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alexander Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Apr 14, 2022 at 3:52 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> [Cc: -kernel test robot <lkp@intel.com>]
>
> Dear Alex, dear Richard,
>
>
> Am 13.04.22 um 15:00 schrieb Alex Deucher:
> > On Wed, Apr 13, 2022 at 3:43 AM Paul Menzel wrote:
>
> >> Thank you for sending out v4.
> >>
> >> Am 12.04.22 um 23:50 schrieb Richard Gong:
> >>> Active State Power Management (ASPM) feature is enabled since kernel =
5.14.
> >>> There are some AMD GFX cards (such as WX3200 and RX640) that won't wo=
rk
> >>> with ASPM-enabled Intel Alder Lake based systems. Using these GFX car=
ds as
> >>> video/display output, Intel Alder Lake based systems will hang during
> >>> suspend/resume.
> >>
> >> I am still not clear, what =E2=80=9Chang during suspend/resume=E2=80=
=9D means. I guess
> >> suspending works fine? During resume (S3 or S0ix?), where does it hang=
?
> >> The system is functional, but there are only display problems?
> >>
> >>> The issue was initially reported on one system (Dell Precision 3660 w=
ith
> >>> BIOS version 0.14.81), but was later confirmed to affect at least 4 A=
lder
> >>> Lake based systems.
> >>>
> >>> Add extra check to disable ASPM on Intel Alder Lake based systems.
> >>>
> >>> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> >>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> This tag is a little confusing. Maybe clarify that it was for an issue
> >> in a previous patch iteration?
> >>
> >>> Signed-off-by: Richard Gong <richard.gong@amd.com>
> >>> ---
> >>> v4: s/CONFIG_X86_64/CONFIG_X86
> >>>       enhanced check logic
> >>> v3: s/intel_core_asom_chk/aspm_support_quirk_check
> >>>       correct build error with W=3D1 option
> >>> v2: correct commit description
> >>>       move the check from chip family to problematic platform
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
> >>>    1 file changed, 16 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/am=
dgpu/vi.c
> >>> index 039b90cdc3bc..b33e0a9bee65 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> >>> @@ -81,6 +81,10 @@
> >>>    #include "mxgpu_vi.h"
> >>>    #include "amdgpu_dm.h"
> >>>
> >>> +#if IS_ENABLED(CONFIG_X86)
> >>> +#include <asm/intel-family.h>
> >>> +#endif
> >>> +
> >>>    #define ixPCIE_LC_L1_PM_SUBSTATE    0x100100C6
> >>>    #define PCIE_LC_L1_PM_SUBSTATE__LC_L1_SUBSTATES_OVERRIDE_EN_MASK  =
  0x00000001L
> >>>    #define PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_2_OVERRIDE_MASK      =
  0x00000002L
> >>> @@ -1134,13 +1138,24 @@ static void vi_enable_aspm(struct amdgpu_devi=
ce *adev)
> >>>                WREG32_PCIE(ixPCIE_LC_CNTL, data);
> >>>    }
> >>>
> >>> +static bool aspm_support_quirk_check(void)
> >>> +{
> >>> +     if (IS_ENABLED(CONFIG_X86)) {
> >>> +             struct cpuinfo_x86 *c =3D &cpu_data(0);
> >>> +
> >>> +             return !(c->x86 =3D=3D 6 && c->x86_model =3D=3D INTEL_F=
AM6_ALDERLAKE);
> >>> +     }
> >>> +
> >>> +     return true;
> >>> +}
> >>> +
> >>>    static void vi_program_aspm(struct amdgpu_device *adev)
> >>>    {
> >>>        u32 data, data1, orig;
> >>>        bool bL1SS =3D false;
> >>>        bool bClkReqSupport =3D true;
> >>>
> >>> -     if (!amdgpu_device_should_use_aspm(adev))
> >>> +     if (!amdgpu_device_should_use_aspm(adev) || !aspm_support_quirk=
_check())
> >>>                return;
> >>
> >> Can users still forcefully enable ASPM with the parameter `amdgpu.aspm=
`?
> >>
> >>>
> >>>        if (adev->flags & AMD_IS_APU ||
> >>
> >> If I remember correctly, there were also newer cards, where ASPM worke=
d
> >> with Intel Alder Lake, right? Can only the problematic generations for
> >> WX3200 and RX640 be excluded from ASPM?
> >
> > This patch only disables it for the generation that was problematic.
>
> Could that please be made clear in the commit message summary, and messag=
e?

Sure.  Richard, please add that this only disables ASPM on VI parts
when in an alderlake system.

>
> Loosely related, is there a public (or internal issue) to analyze how to
> get ASPM working for VI generation devices with Intel Alder Lake?

We'd need support from Intel.  I'm not sure where things currently stand.

Alex
