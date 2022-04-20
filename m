Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB64C50917D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351599AbiDTUnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiDTUnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:43:11 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8952F3B6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:40:23 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id v133so2674954vsv.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JE/UnVkKZW6i6tEpSWSVHx7mPfUAzhZNSkANczglUAc=;
        b=lXqlA9bhb9b6yUDVePy9iHxzZOUEM2YMYJX0V8YUWrmqcm7IOnClGXVFjrb8MFhuix
         viFMgGhVZUNuTJArEIPlaaMai9Dltd2KZpRqX1ZDvvaZaPA5T5IAFd4dM6gDfcrywZDN
         36LetK/emGgzxMMAkfJBsErDRrtzdAAuTxvznrz2Niql+KrvqMfLudaHXQxYogcCPN38
         RADukYVYbPrE21mg7MbPR8hZ+5KQDyAtCC/urOOo0zBn1Go5mAsBrhoWiKlhiUbN1ZQW
         4Bda5Lk4iYUgIriJsIpENPL6dq9ZlgCE4+SHeZ7ENQHnoUXyK5bWggAjlesYDnfQD7BJ
         KWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JE/UnVkKZW6i6tEpSWSVHx7mPfUAzhZNSkANczglUAc=;
        b=Okj90hAlibFCJOD+TI7fWI9NHyWe1i6/CrXhGppB4j4EBcSB3pUDeRwynUcYUNqeQU
         5hPqoBZZPS0eONV8s3248/sHCb0UrkG3qXQB49DyTJ7lWqrJVpAPVWr2Mgdv/0jXLaKM
         ze2u8K4ahBwNftinvRn1/vK0cqgkkl3+d7orl+0oU+iRa5E8UBiUxzaP6xrVAYpTodzm
         HgkBvCUBLRIQQUrOb/2h3Eex+IxbHut/JjoALOvTC7jMV6PcOR7wdw2iQsbBdcBsmVhk
         Wbke8hmL/QFMG3i83tLyuZElz5XzD2c0j0YaZSoL+JWfyQ5EQUlbn3dSbVmugs2N66LW
         jrUA==
X-Gm-Message-State: AOAM531rtbl+LCq2Azd9x8+QWXWTcj5cmiHsFwT3jZaVKYcETXtAQO5j
        hoV6XNxvQxEb/LB7zhFaC52MgHcs644Puw+9trq0a2iq
X-Google-Smtp-Source: ABdhPJxPD+bJ3PBTfZAYCp1Nf3BkuDU/CMq2JAhhNrPW4hKE/DkDM5cmmQjH99zNynMQG4e8EZDpuo/p40+FqbEikVA=
X-Received: by 2002:a05:6102:2372:b0:32a:4ac4:5032 with SMTP id
 o18-20020a056102237200b0032a4ac45032mr6359189vsa.69.1650487222713; Wed, 20
 Apr 2022 13:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220412215000.897344-1-richard.gong@amd.com> <d4ba3998-34aa-86d2-bde9-bc6ae9d8d08d@molgen.mpg.de>
 <CADnq5_MgvcGPWf2gYn_3qCr+Gq1P39tvv-W-o8NhivvMpMwUBA@mail.gmail.com>
 <91e916e3-d793-b814-6cbf-abee0667f5f8@molgen.mpg.de> <94fd858d-1792-9c05-b5c6-1b028427687d@amd.com>
 <efc1dfd1-2b54-aee5-1497-4b800a468141@molgen.mpg.de>
In-Reply-To: <efc1dfd1-2b54-aee5-1497-4b800a468141@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Apr 2022 16:40:11 -0400
Message-ID: <CADnq5_NGTbTjn87tAsTJAMOKZ9niS7Mb=JDmjUH4KJXfDH_p_g@mail.gmail.com>
Subject: Re: [PATCHv4] drm/amdgpu: disable ASPM on Intel Alder Lake based systems
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Richard Gong <richard.gong@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Xinhui Pan <xinhui.pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 4:29 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Richard,
>
>
> Am 19.04.22 um 23:46 schrieb Gong, Richard:
>
> > On 4/14/2022 2:52 AM, Paul Menzel wrote:
> >> [Cc: -kernel test robot <lkp@intel.com>]
>
> [=E2=80=A6]
>
> >> Am 13.04.22 um 15:00 schrieb Alex Deucher:
> >>> On Wed, Apr 13, 2022 at 3:43 AM Paul Menzel wrote:
> >>
> >>>> Thank you for sending out v4.
> >>>>
> >>>> Am 12.04.22 um 23:50 schrieb Richard Gong:
> >>>>> Active State Power Management (ASPM) feature is enabled since
> >>>>> kernel 5.14.
> >>>>> There are some AMD GFX cards (such as WX3200 and RX640) that won't
> >>>>> work
> >>>>> with ASPM-enabled Intel Alder Lake based systems. Using these GFX
> >>>>> cards as
> >>>>> video/display output, Intel Alder Lake based systems will hang duri=
ng
> >>>>> suspend/resume.
>
> [Your email program wraps lines in cited text for some reason, making
> the citation harder to read.]
>
> >>>>
> >>>> I am still not clear, what =E2=80=9Chang during suspend/resume=E2=80=
=9D means. I guess
> >>>> suspending works fine? During resume (S3 or S0ix?), where does it ha=
ng?
> >>>> The system is functional, but there are only display problems?
> > System freeze after suspend/resume.
>
> But you see certain messages still? At what point does it freeze
> exactly? In the bug report you posted Linux messages.
>
> >>>>> The issue was initially reported on one system (Dell Precision 3660
> >>>>> with
> >>>>> BIOS version 0.14.81), but was later confirmed to affect at least 4
> >>>>> Alder
> >>>>> Lake based systems.
> >>>>>
> >>>>> Add extra check to disable ASPM on Intel Alder Lake based systems.
> >>>>>
> >>>>> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> >>>>> Link:
> >>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1885&amp;data=3D04%7C01%=
7Crichard.gong%40amd.com%7Ce7febed5d6a441c3a58008da1debb99c%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637855195670542145%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp=
;sdata=3D7cEnE%2BSM9e5IGFxSLloCLtCOxovBpaPz0Ns0Ta2vVlc%3D&amp;reserved=3D0
>
> Thank you Microsoft Outlook for keeping us safe. :(
>
> >>>>>
> >>>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>>
> >>>> This tag is a little confusing. Maybe clarify that it was for an iss=
ue
> >>>> in a previous patch iteration?
> >
> > I did describe in change-list version 3 below, which corrected the buil=
d
> > error with W=3D1 option.
> >
> > It is not good idea to add the description for that to the commit
> > message, this is why I add descriptions on change-list version 3.
>
> Do as you wish, but the current style is confusing, and readers of the
> commit are going to think, the kernel test robot reported the problem
> with AMD VI ASICs and Intel Alder Lake systems.
>
> >>>>
> >>>>> Signed-off-by: Richard Gong <richard.gong@amd.com>
> >>>>> ---
> >>>>> v4: s/CONFIG_X86_64/CONFIG_X86
> >>>>>       enhanced check logic
> >>>>> v3: s/intel_core_asom_chk/aspm_support_quirk_check
> >>>>>       correct build error with W=3D1 option
> >>>>> v2: correct commit description
> >>>>>       move the check from chip family to problematic platform
> >>>>> ---
> >>>>>    drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
> >>>>>    1 file changed, 16 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>>> index 039b90cdc3bc..b33e0a9bee65 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>>> @@ -81,6 +81,10 @@
> >>>>>    #include "mxgpu_vi.h"
> >>>>>    #include "amdgpu_dm.h"
> >>>>>
> >>>>> +#if IS_ENABLED(CONFIG_X86)
> >>>>> +#include <asm/intel-family.h>
> >>>>> +#endif
> >>>>> +
> >>>>>    #define ixPCIE_LC_L1_PM_SUBSTATE    0x100100C6
> >>>>>    #define PCIE_LC_L1_PM_SUBSTATE__LC_L1_SUBSTATES_OVERRIDE_EN_MASK
> >>>>> 0x00000001L
> >>>>>    #define PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_2_OVERRIDE_MASK
> >>>>> 0x00000002L
> >>>>> @@ -1134,13 +1138,24 @@ static void vi_enable_aspm(struct
> >>>>> amdgpu_device *adev)
> >>>>>                WREG32_PCIE(ixPCIE_LC_CNTL, data);
> >>>>>    }
> >>>>>
> >>>>> +static bool aspm_support_quirk_check(void)
> >>>>> +{
> >>>>> +     if (IS_ENABLED(CONFIG_X86)) {
> >>>>> +             struct cpuinfo_x86 *c =3D &cpu_data(0);
> >>>>> +
> >>>>> +             return !(c->x86 =3D=3D 6 && c->x86_model =3D=3D
> >>>>> INTEL_FAM6_ALDERLAKE);
> >>>>> +     }
> >>>>> +
> >>>>> +     return true;
> >>>>> +}
> >>>>> +
> >>>>>    static void vi_program_aspm(struct amdgpu_device *adev)
> >>>>>    {
> >>>>>        u32 data, data1, orig;
> >>>>>        bool bL1SS =3D false;
> >>>>>        bool bClkReqSupport =3D true;
> >>>>>
> >>>>> -     if (!amdgpu_device_should_use_aspm(adev))
> >>>>> +     if (!amdgpu_device_should_use_aspm(adev) ||
> >>>>> !aspm_support_quirk_check())
> >>>>>                return;
> >>>>
> >>>> Can users still forcefully enable ASPM with the parameter
> >>>> `amdgpu.aspm`?
> >>>>
> > As Mario mentioned in a separate reply, we can't forcefully enable ASPM
> > with the parameter 'amdgpu.aspm'.
>
> That would be a regression on systems where ASPM used to work. Hmm. I
> guess, you could say, there are no such systems.
>
> >>>>>
> >>>>>        if (adev->flags & AMD_IS_APU ||
> >>>>
> >>>> If I remember correctly, there were also newer cards, where ASPM wor=
ked
> >>>> with Intel Alder Lake, right? Can only the problematic generations f=
or
> >>>> WX3200 and RX640 be excluded from ASPM?
> >>>
> >>> This patch only disables it for the generatioaon that was problematic=
.
> >>
> >> Could that please be made clear in the commit message summary, and
> >> message?
> >
> > Are you ok with the commit messages below?
>
> Please change the commit message summary. Maybe:
>
> drm/amdgpu: VI: Disable ASPM on Intel Alder Lake based systems
>
> > Active State Power Management (ASPM) feature is enabled since kernel 5.=
14.
> >
> > There are some AMD GFX cards (such as WX3200 and RX640) that won't work
> > with ASPM-enabled Intel Alder Lake based systems. Using these GFX cards=
 as
> > video/display output, Intel Alder Lake based systems will freeze after
> > suspend/resume.
>
> Something like:
>
> On Intel Alder Lake based systems using ASPM with AMD GFX Volcanic
> Islands (VI) cards, like WX3200 and RX640, graphics don=E2=80=99t initial=
ize
> when resuming from S0ix(?).
>
>
> > The issue was initially reported on one system (Dell Precision 3660 wit=
h
> > BIOS version 0.14.81), but was later confirmed to affect at least 4 Ald=
er
> > Lake based systems.
>
> Which ones?
>
> > Add extra check to disable ASPM on Intel Alder Lake based systems with
> > problematic generation GFX cards.
>
> =E2=80=A6 with the problematic Volcanic Islands GFX cards.
>
> >>
> >> Loosely related, is there a public (or internal issue) to analyze how
> >> to get ASPM working for VI generation devices with Intel Alder Lake?
> >
> > As Alex mentioned, we need support from Intel. We don't have any update
> > on that.
>
> It=E2=80=99d be great to get that fixed properly.
>
> Last thing, please don=E2=80=99t hate me, does Linux log, that ASPM is di=
sabled?

I'm not sure what gets logged at the platform level with respect to
ASPM, but whether or not the driver enables ASPM is tied to whether
ASPM is allowed at the platform level or not so if the platform
indicates that ASPM is not supported, the driver won't enable it.  The
driver does not log whether ASPM is enabled or not if that is what you
are asking.  As to whether or not it should, it comes down to how much
stuff is worth indiciating in the log.  The driver is already pretty
chatty by driver standards.

Alex
