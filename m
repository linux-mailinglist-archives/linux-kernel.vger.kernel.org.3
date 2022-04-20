Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E819C5091F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347445AbiDTVS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241760AbiDTVSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:18:23 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B14348C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:15:35 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b188so3465798oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9wWA9mmXKy1uv6TuZmk40EGjV7AmBef4BwNDPN5tYaM=;
        b=b9D/nSuq3UZlK5Z7ujNhCKTViN+sEIh5ekjraPbWwoj9frWetYjWSQ4+sDnEnxFxYA
         iLpAkxQakoHbuNroX8sVQe7fOC95qIDxJ5yQEc2wnM5rpkqveTJKnfyoPHNk/FOlB0b0
         3FU57xaXjHOuUfpOyoyJ2Rg1bIBaIPj6NaHZ6jUm2oeoqhAvdEPicyHxieck2bPYu+QE
         rpqwLvXsQ4eqUoZyEdZ6Lxla2C/Ckxpm9ePcqKvknb1kuSWpuHyPRCAxJASMZfye+Jzg
         HJP5dqJqVhMXF60L+xe863u+PE2E2jwpDarf/tgYVWFe8WV9dkReqMERQcnAOVyEEhJw
         w0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9wWA9mmXKy1uv6TuZmk40EGjV7AmBef4BwNDPN5tYaM=;
        b=sCpEA+jJuixPKwgoWral/ecQYHlR4Vf1gKD1RdOHrfb7MtDk0EZHtjFRritq1tKume
         /pT/Kwp4jMtCx2KkJkMDvQqLyqPMbK/OHqTi37zewcUOliWr7oW4OdrG1fYwX42IvvaB
         IwI1G70Yo7jUopQ+/VsYWVmWh8zW7A6W6wgUODVhX87OB6xzik26/1BFxF8N9Gwzr1No
         /5YpENxzcxL10Zhpis8obxLVuAjSxZs3DxILrHksA0SxPxkpK/R11SF1xTx8nj2sVVru
         U4YKbq0v/uUwkEr6J4MCEdbfy1vtc05J/ekSsnRpRG0sgNH4rQNWCxedsEzugC2wrNyx
         JaxA==
X-Gm-Message-State: AOAM5322LheoO6AuXDQ0XpOB6iJD+u0PhVOxOOQKQ0ClvNwRmiWEyQDJ
        zMezX7DPbsYQkid9FiapH4/bRtXSJ7tSHlhQn/hgp2rb
X-Google-Smtp-Source: ABdhPJxOyDBmKEk+4O8Ciw2pFh1bKhxz9+jNtvXv5wSY8alt4wvr0bJpewK90vrpI+HqQRxAtPR87lzAxV1BuKKfMU4=
X-Received: by 2002:aca:3d88:0:b0:321:141:ce0b with SMTP id
 k130-20020aca3d88000000b003210141ce0bmr2564592oia.200.1650489334447; Wed, 20
 Apr 2022 14:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220412215000.897344-1-richard.gong@amd.com> <d4ba3998-34aa-86d2-bde9-bc6ae9d8d08d@molgen.mpg.de>
 <CADnq5_MgvcGPWf2gYn_3qCr+Gq1P39tvv-W-o8NhivvMpMwUBA@mail.gmail.com>
 <91e916e3-d793-b814-6cbf-abee0667f5f8@molgen.mpg.de> <94fd858d-1792-9c05-b5c6-1b028427687d@amd.com>
 <efc1dfd1-2b54-aee5-1497-4b800a468141@molgen.mpg.de> <CADnq5_NGTbTjn87tAsTJAMOKZ9niS7Mb=JDmjUH4KJXfDH_p_g@mail.gmail.com>
 <295e7882-21a2-f50f-6bfa-b0bae1d0fa12@molgen.mpg.de> <67e98c3e-cfa3-ee51-4932-bbad8de5ffd8@amd.com>
 <462dce7d-73fc-ea8c-0a8a-5e8722ee1967@molgen.mpg.de> <fefcb57e-cc28-d9c1-2fad-997ed3856a88@amd.com>
In-Reply-To: <fefcb57e-cc28-d9c1-2fad-997ed3856a88@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Apr 2022 17:15:23 -0400
Message-ID: <CADnq5_PV2D-iSVfjvK0P-F2ETPnYnq=6752tgShFKcuoZ0erSg@mail.gmail.com>
Subject: Re: [PATCHv4] drm/amdgpu: disable ASPM on Intel Alder Lake based systems
To:     "Gong, Richard" <richard.gong@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
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

On Wed, Apr 20, 2022 at 5:13 PM Gong, Richard <richard.gong@amd.com> wrote:
>
>
> On 4/20/2022 4:02 PM, Paul Menzel wrote:
> > Dear Richard,
> >
> >
> > Am 20.04.22 um 22:56 schrieb Gong, Richard:
> >
> >> On 4/20/2022 3:48 PM, Paul Menzel wrote:
> >
> >>> Am 20.04.22 um 22:40 schrieb Alex Deucher:
> >>>> On Wed, Apr 20, 2022 at 4:29 PM Paul Menzel <pmenzel@molgen.mpg.de>
> >>>> wrote:
> >>>
> >>>>> Am 19.04.22 um 23:46 schrieb Gong, Richard:
> >>>>>
> >>>>>> On 4/14/2022 2:52 AM, Paul Menzel wrote:
> >>>>>>> [Cc: -kernel test robot <lkp@intel.com>]
> >>>>>
> >>>>> [=E2=80=A6]
> >>>>>
> >>>>>>> Am 13.04.22 um 15:00 schrieb Alex Deucher:
> >>>>>>>> On Wed, Apr 13, 2022 at 3:43 AM Paul Menzel wrote:
> >>>>>>>
> >>>>>>>>> Thank you for sending out v4.
> >>>>>>>>>
> >>>>>>>>> Am 12.04.22 um 23:50 schrieb Richard Gong:
> >>>>>>>>>> Active State Power Management (ASPM) feature is enabled since
> >>>>>>>>>> kernel 5.14.
> >>>>>>>>>> There are some AMD GFX cards (such as WX3200 and RX640) that
> >>>>>>>>>> won't
> >>>>>>>>>> work
> >>>>>>>>>> with ASPM-enabled Intel Alder Lake based systems. Using these
> >>>>>>>>>> GFX
> >>>>>>>>>> cards as
> >>>>>>>>>> video/display output, Intel Alder Lake based systems will
> >>>>>>>>>> hang during
> >>>>>>>>>> suspend/resume.
> >>>>>
> >>>>> [Your email program wraps lines in cited text for some reason, maki=
ng
> >>>>> the citation harder to read.]
> >>>>>
> >>>>>>>>>
> >>>>>>>>> I am still not clear, what =E2=80=9Chang during suspend/resume=
=E2=80=9D means.
> >>>>>>>>> I guess
> >>>>>>>>> suspending works fine? During resume (S3 or S0ix?), where does
> >>>>>>>>> it hang?
> >>>>>>>>> The system is functional, but there are only display problems?
> >>>>>> System freeze after suspend/resume.
> >>>>>
> >>>>> But you see certain messages still? At what point does it freeze
> >>>>> exactly? In the bug report you posted Linux messages.
> >>>>>
> >>>>>>>>>> The issue was initially reported on one system (Dell
> >>>>>>>>>> Precision 3660
> >>>>>>>>>> with
> >>>>>>>>>> BIOS version 0.14.81), but was later confirmed to affect at
> >>>>>>>>>> least 4
> >>>>>>>>>> Alder
> >>>>>>>>>> Lake based systems.
> >>>>>>>>>>
> >>>>>>>>>> Add extra check to disable ASPM on Intel Alder Lake based
> >>>>>>>>>> systems.
> >>>>>>>>>>
> >>>>>>>>>> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> >>>>>>>>>> Link:
> >>>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1885&amp;data=3D05%=
7C01%7Crichard.gong%40amd.com%7C509e0378edcf477605a708da231114f0%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637860853537880384%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300=
0%7C%7C%7C&amp;sdata=3DSoXDKGHUiiQN4rcL7FpCotouWFt0kkAbcHyO3esfNlE%3D&amp;r=
eserved=3D0
> >>>>>>>>>>
> >>>>>
> >>>>> Thank you Microsoft Outlook for keeping us safe. :(
> >>>>>
> >>>>>>>>>>
> >>>>>>>>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>>>>>>>
> >>>>>>>>> This tag is a little confusing. Maybe clarify that it was for
> >>>>>>>>> an issue
> >>>>>>>>> in a previous patch iteration?
> >>>>>>
> >>>>>> I did describe in change-list version 3 below, which corrected
> >>>>>> the build
> >>>>>> error with W=3D1 option.
> >>>>>>
> >>>>>> It is not good idea to add the description for that to the commit
> >>>>>> message, this is why I add descriptions on change-list version 3.
> >>>>>
> >>>>> Do as you wish, but the current style is confusing, and readers of
> >>>>> the
> >>>>> commit are going to think, the kernel test robot reported the probl=
em
> >>>>> with AMD VI ASICs and Intel Alder Lake systems.
> >>>>>
> >>>>>>>>>
> >>>>>>>>>> Signed-off-by: Richard Gong <richard.gong@amd.com>
> >>>>>>>>>> ---
> >>>>>>>>>> v4: s/CONFIG_X86_64/CONFIG_X86
> >>>>>>>>>>        enhanced check logic
> >>>>>>>>>> v3: s/intel_core_asom_chk/aspm_support_quirk_check
> >>>>>>>>>>        correct build error with W=3D1 option
> >>>>>>>>>> v2: correct commit description
> >>>>>>>>>>        move the check from chip family to problematic platform
> >>>>>>>>>> ---
> >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
> >>>>>>>>>>     1 file changed, 16 insertions(+), 1 deletion(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>>>>>>>> index 039b90cdc3bc..b33e0a9bee65 100644
> >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>>>>>>>> @@ -81,6 +81,10 @@
> >>>>>>>>>>     #include "mxgpu_vi.h"
> >>>>>>>>>>     #include "amdgpu_dm.h"
> >>>>>>>>>>
> >>>>>>>>>> +#if IS_ENABLED(CONFIG_X86)
> >>>>>>>>>> +#include <asm/intel-family.h>
> >>>>>>>>>> +#endif
> >>>>>>>>>> +
> >>>>>>>>>>     #define ixPCIE_LC_L1_PM_SUBSTATE 0x100100C6
> >>>>>>>>>>     #define
> >>>>>>>>>> PCIE_LC_L1_PM_SUBSTATE__LC_L1_SUBSTATES_OVERRIDE_EN_MASK
> >>>>>>>>>> 0x00000001L
> >>>>>>>>>>     #define PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_2_OVERRIDE_MA=
SK
> >>>>>>>>>> 0x00000002L
> >>>>>>>>>> @@ -1134,13 +1138,24 @@ static void vi_enable_aspm(struct
> >>>>>>>>>> amdgpu_device *adev)
> >>>>>>>>>>                 WREG32_PCIE(ixPCIE_LC_CNTL, data);
> >>>>>>>>>>     }
> >>>>>>>>>>
> >>>>>>>>>> +static bool aspm_support_quirk_check(void)
> >>>>>>>>>> +{
> >>>>>>>>>> +     if (IS_ENABLED(CONFIG_X86)) {
> >>>>>>>>>> +             struct cpuinfo_x86 *c =3D &cpu_data(0);
> >>>>>>>>>> +
> >>>>>>>>>> +             return !(c->x86 =3D=3D 6 && c->x86_model =3D=3D
> >>>>>>>>>> INTEL_FAM6_ALDERLAKE);
> >>>>>>>>>> +     }
> >>>>>>>>>> +
> >>>>>>>>>> +     return true;
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>>     static void vi_program_aspm(struct amdgpu_device *adev)
> >>>>>>>>>>     {
> >>>>>>>>>>         u32 data, data1, orig;
> >>>>>>>>>>         bool bL1SS =3D false;
> >>>>>>>>>>         bool bClkReqSupport =3D true;
> >>>>>>>>>>
> >>>>>>>>>> -     if (!amdgpu_device_should_use_aspm(adev))
> >>>>>>>>>> +     if (!amdgpu_device_should_use_aspm(adev) ||
> >>>>>>>>>> !aspm_support_quirk_check())
> >>>>>>>>>>                 return;
> >>>>>>>>>
> >>>>>>>>> Can users still forcefully enable ASPM with the parameter
> >>>>>>>>> `amdgpu.aspm`?
> >>>>>>>>>
> >>>>>> As Mario mentioned in a separate reply, we can't forcefully
> >>>>>> enable ASPM
> >>>>>> with the parameter 'amdgpu.aspm'.
> >>>>>
> >>>>> That would be a regression on systems where ASPM used to work. Hmm.=
 I
> >>>>> guess, you could say, there are no such systems.
> >>>>>
> >>>>>>>>>>
> >>>>>>>>>>         if (adev->flags & AMD_IS_APU ||
> >>>>>>>>>
> >>>>>>>>> If I remember correctly, there were also newer cards, where
> >>>>>>>>> ASPM worked
> >>>>>>>>> with Intel Alder Lake, right? Can only the problematic
> >>>>>>>>> generations for
> >>>>>>>>> WX3200 and RX640 be excluded from ASPM?
> >>>>>>>>
> >>>>>>>> This patch only disables it for the generatioaon that was
> >>>>>>>> problematic.
> >>>>>>>
> >>>>>>> Could that please be made clear in the commit message summary, an=
d
> >>>>>>> message?
> >>>>>>
> >>>>>> Are you ok with the commit messages below?
> >>>>>
> >>>>> Please change the commit message summary. Maybe:
> >>>>>
> >>>>> drm/amdgpu: VI: Disable ASPM on Intel Alder Lake based systems
> >>>>>
> >>>>>> Active State Power Management (ASPM) feature is enabled since
> >>>>>> kernel 5.14.
> >>>>>>
> >>>>>> There are some AMD GFX cards (such as WX3200 and RX640) that
> >>>>>> won't work
> >>>>>> with ASPM-enabled Intel Alder Lake based systems. Using these GFX
> >>>>>> cards as
> >>>>>> video/display output, Intel Alder Lake based systems will freeze
> >>>>>> after
> >>>>>> suspend/resume.
> >>>>>
> >>>>> Something like:
> >>>>>
> >>>>> On Intel Alder Lake based systems using ASPM with AMD GFX Volcanic
> >>>>> Islands (VI) cards, like WX3200 and RX640, graphics don=E2=80=99t i=
nitialize
> >>>>> when resuming from S0ix(?).
> >>>>>
> >>>>>
> >>>>>> The issue was initially reported on one system (Dell Precision
> >>>>>> 3660 with
> >>>>>> BIOS version 0.14.81), but was later confirmed to affect at least
> >>>>>> 4 Alder
> >>>>>> Lake based systems.
> >>>>>
> >>>>> Which ones?
> >>>>>
> >>>>>> Add extra check to disable ASPM on Intel Alder Lake based systems
> >>>>>> with
> >>>>>> problematic generation GFX cards.
> >>>>>
> >>>>> =E2=80=A6 with the problematic Volcanic Islands GFX cards.
> >>>>>
> >>>>>>>
> >>>>>>> Loosely related, is there a public (or internal issue) to
> >>>>>>> analyze how
> >>>>>>> to get ASPM working for VI generation devices with Intel Alder
> >>>>>>> Lake?
> >>>>>>
> >>>>>> As Alex mentioned, we need support from Intel. We don't have any
> >>>>>> update
> >>>>>> on that.
> >>>>>
> >>>>> It=E2=80=99d be great to get that fixed properly.
> >>>>>
> >>>>> Last thing, please don=E2=80=99t hate me, does Linux log, that ASPM=
 is
> >>>>> disabled?
> >>>>
> >>>> I'm not sure what gets logged at the platform level with respect to
> >>>> ASPM, but whether or not the driver enables ASPM is tied to whether
> >>>> ASPM is allowed at the platform level or not so if the platform
> >>>> indicates that ASPM is not supported, the driver won't enable it.  T=
he
> >>>> driver does not log whether ASPM is enabled or not if that is what y=
ou
> >>>> are asking.  As to whether or not it should, it comes down to how mu=
ch
> >>>> stuff is worth indiciating in the log.  The driver is already pretty
> >>>> chatty by driver standards.
> >>>
> >>> I specifically mean, Linux should log the quirks it applies. (As a
> >>> normal user, I=E2=80=99d also expect ASPM to work nowadays, so a mess=
age,
> >>> that it=E2=80=99s disabled would help a lot.)
> >>
> >> In general rule we shouldn't generate additional log unless something
> >> went wrong with the system.
> >
> > Please run `dmesg` and see that your statement is false. That=E2=80=99s=
 what
> > log levels are for, and in your case, it would be at least error
> > level. Also, I claim, something indeed went wrong, because a quirk had
> > to be applied. So please add a notice log level, that ASPM gets disable=
d:
>
>  From my previous experience with upstream, the maintainers simply don't
> like adding logs unless absolutely need.
>
> I can add a pr_warn or dev_warn, but I can't guarantee that maintainers
> will take that in my case.

Certainly don't make it a warning.

Alex

>
> >
> > Disable ASPM on Alder Lake with Volcanic Islands card due to resume
> > problems. System energy consumption might be higher than expected.
> >
> >
> > Kind regards,
> >
> > Paul
